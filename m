Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266417AbUA3DoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 22:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266445AbUA3DoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 22:44:15 -0500
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:13903 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S266417AbUA3DoF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 22:44:05 -0500
Subject: Re: Help in writing a synchrnous ppp driver
From: Paul Fulghum <paulkf@microgate.com>
To: "vanitha@agilis.st.com.sg" <vanitha@agilis.st.com.sg>
Cc: "'redhat-ppp-list@redhat.com'" <redhat-ppp-list@redhat.com>,
       "'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <01C3E716.AA1B04A0.vanitha@agilis.st.com.sg>
References: <01C3E716.AA1B04A0.vanitha@agilis.st.com.sg>
Content-Type: text/plain
Message-Id: <1075434214.3902.62.camel@athlon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Jan 2004 21:43:34 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-29 at 19:51, Vanitha Ramaswami wrote:
> In linux kernel, what is the difference between the ppp_synctty.c
> (PPP synchronous TTY device driver) and syncppp.c (synchronous ppp)
> functions..?

syncppp.c was the original way of doing synchronous PPP
(and Cisco-HDLC) which creates a network device in the kernel.

This module seems to be deprecated at this point and
is not really maintained or enhanced. I occasionally
submit patches to keep it limping along when other
kernel changes break it.

When I wrote Linux drivers for Microgate's serial adapters,
there was only syncppp, but I needed
to do normal asynchronous communications, asynchronous PPP,
raw HDLC, and synchronous PPP. For PPP I wanted to work with
the user mode pppd (more features/better maintained than syncppp)

To meet these needs I extended the tty concept to
allow frame oriented communications (n_hdlc.c line discipline
for raw HDLC and a synchronous PPP line discipline).

Since then, the kernel support for pppd has been reworked
resulting in the generic PPP setup with ppp_synctty.c supplying
access to synchronous tty devices.

syncppp is simpler to setup and use,
but the tty device approach gives you more features.
Doing a driver for syncppp.c is also simpler.

The Microgate drivers (synclink.c, synclinkmp.c, synclink_cs.c)
implement both (syncppp and tty) interfaces so the user can choose.
This makes the code harder to follow and a little bloated.

There is a new, third approach using the 'generic HDLC'
interface. I have not investigated this yet. It looks like
a good way to get other types of support (Frame Relay, X.25, etc).


> I have a High speed serial driver that is capable of doing HDLC framing
> using a Network Processor. I want to run PPP on that serial driver. 
> The device driver has just provided functions to read/write on the device.
> 
> I intend to add a proprietary header to the packets coming out of PPP.
> Do i need to use the PPP synchronous TTY device driver or the one similar
> to syncppp.c. I am not clear of when to use the syncppp functions sppp_input etc.?

I'm not sure what you mean by adding a proprietary header to the
packets.

For syncppp:

Register with syncppp which creates a net_device for use
with your base driver.

When your base driver receives an HDLC frame, you allocate
an sk_buff, copy the frame to the sk_buff with and call
netif_rx(skb); (look at mgsl_sppp_rx_done() in synclink.c)

When syncppp needs to send a packet, it calls a transmit routine
in your base driver (which you registered with syncppp), passing
it an sk_buff containing data for you to send (look at
mgsl_sppp_tx() in synclink.c)

If your transmit routine can't accept more send data, call
netif_stop_queue(). When your base driver can accept more
send data (transmit complete IRQ etc) call netif_wake_queue().

Pretty simple.

> To use the functions in ppp_synctty.c,  then does the driver
> also needs to be a TTY driver.?

Yes

> Whether all the linux driver written for serial devices need to be TTY drivers..?

No. Some HDLC serial devices support only the syncppp.c interface.
Others support the generic HDLC. A few use the tty approach.
It depends on what services you need to provide.

You may want to learn the details of the different
interfaces by doing plain synchronous PPP before
deciding on the best method to do the proprietary packet
manipulation.

I suspect the syncppp may be the simplest way to approach it.


--
Paul Fulghum
paulkf@microgate.com


