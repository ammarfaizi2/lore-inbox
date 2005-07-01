Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVGAXGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVGAXGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVGAXGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:06:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261345AbVGAXF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:05:57 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17093.52306.136742.190912@segfault.boston.redhat.com>
Date: Fri, 1 Jul 2005 19:05:54 -0400
To: mpm@selenic.com
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rfc | patch 0/6] netpoll: add support for the bonding driver
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch series provides netpoll support for the bonding driver.
The best way to describe the approach taken is to walk through how it
works.  We'll use netconsole as our example.

Netconsole registers a console, and so release_console_sem will trigger the
write_msg implementation in netconsole.ko.  This, in turn, calls
netpoll_send_udp.  netpoll_send_udp will then call netpoll_send_skb, which
then calls into the network drivers hard_start_xmit routine.  It is
important to note that netpoll_send_skb takes care to not call the
hard_start_xmit routine if netif_queue_stopped(dev) returns true.  In this
case, it instead calls netpoll_poll, to hopefully free up some tx
descriptors.  After this is done, and the queue is woken up, the
hard_start_xmit routine can and will be called.

For all network drivers up to this point, this was the end of the line.
Netpoll would no longer have to be concerned with the skb.  It will be
sent off to the network by the driver.  However, this is not the case with
the bonding driver.

In the case of the bonding driver, we have now called its hard_start_xmit
routine, which can be one of many, depending on the configured bonging_mode
(specified at module load time).  For all of my testing, I have used
dynamic link aggregation (802.3ad).  So, in this case, we will call
bond_3ad_xmit_xor.  In all cases, the hard_start_xmit routine selects the
proper slave device over which to send the packet, and fills in the
skb->dev pointer to point at that device.  Then, they all send the skb off
to bond_dev_queue_xmit.

bond_dev_queue_xmit will then send the skb off to the networking layer via
dev_queue_xmit.  dev_queue_xmit is then responsible for calling the
underlying network device's hard_start_xmit routine.  Note that
dev_queue_xmit cannot be called with interrupts disabled.

And so, we bring our discussion back to netpoll.  In the case of netpoll,
we cannot have the bonding driver call into dev_queue_xmit.  For
netconsole, we have disabled irqs before calling netpoll_send_skb (and we
may even be called from interrupt context, in the case of sysrq-X).  This
is not the only problem with allowing the bonding driver to call
dev_queue_xmit.  We also have to deal with the fact that the underlying
network device may not be ready to send.  As in the case described above,
we may be short on tx descriptors.  In such a case, we need to be able to
call the driver's poll_controller routine to clear them out.  And so, we
have to modify bond_dev_queue_xmit to call *back* into the netpoll code.

The call chain will look something like this:

printk
  release_console_sem
    call_console_drivers
      write_msg
        netpoll_send_udp <----- skb->dev points to bond0
          netpoll_send_skb
            bond_3ad_xmit_xor
              bond_dev_queue_xmit
                netpoll_send_skb <------ skb->dev now points to real_dev

                  (may have to call dev->poll_controller, and perform a
                   napi poll here)

                  dev->hard_start_xmit

I wrote a test module to exercise the receive code path, as well.  The
module registers a struct netpoll with an rx_hook.  It then responds to
each packet it receives with a "PONG".  For this case, our call path now
looks as follows:

net_rx
  dev->poll
    netif_receive_skb
      netpoll_rx
        __netpoll_rx
          module_rx_routine
            netpoll_send_udp
              netpoll_send_skb <-- skb->dev points at bond0
                bond_3ad_xmit_xor
                  bond_dev_queue_xmit
                    netpoll_send_skb <-- skb->dev points at real_dev
                    
And here it gets tricky.  If we are sending out over the same interface
on which the packet arrived, then we will have to either queue the packet,
or drop it.  This functionality is already implemented in netpoll, so if we
filled in our queue routine to point at netpoll_queue, then at this point
we will call that via the ->drop pointer in our netpoll structure.  So,
continuing along, we have:

                      netpoll_queue
                        schedule_work

and we are done.  If the packet was schedule to head out a different
device, then we would continue with the send path:

                      dev->hard_start_xmit


New netpoll function implemented by the network drivers:

net_device->netpoll_setup
  This is required, since the bonding device has to walk through each slave
  and point its slave_dev->npinfo at the npinfo for the master device.  The
  reason for this is so that when we're doing the napi polling, we can set
  the rx_flags appropriately.

net_device->netpoll_start_xmit
  This routine is required since, otherwise, there is no way to intercept
  packets bound for interfaces that are not ready for them.  Of course, it
  requires further logic in the bonding driver to then call into the
  netpoll_send_skb routine (which is a new export).

Note that neither of these pointers has to be filled in by the driver.
These functions should only be implemented where needed, and to date, that
is only in the bonding driver.

Newly exported are:

netpoll_send_skb
  This is exported so that the bonding driver can queue a packet to be sent
  via the real ethernet device it has chosen.

netpoll_poll_dev
  This is a new routine that was created and exported so that the
  poll_controller implementation in the bonding driver could poll each of
  the underlying real devices without duplicating all of the logic that
  exists internally to netpoll already.


To test this, as I mentioned above, I wrote a simple module which, upon
receipt of any packet, sends out a packet with the message "PONG".  I fired
up netcat to send test packets, and receive the responses.  I also loaded
the netconsole module for the very same interface, bond0, and issue a
series of sysrq-X's, both via sysrq-trigger and via the keyboard.  I did
this while simultaneously testing the PING server on an SMP machine.  As
things stand, it is very stable in my environment.

And so, the patch set follows.  Any and all comments are appreciated.

Thanks,

Jeff
