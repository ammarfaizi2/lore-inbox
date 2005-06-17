Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVFQT4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVFQT4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVFQT4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:56:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29634 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262089AbVFQT4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:56:39 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17075.10995.498758.773092@segfault.boston.redhat.com>
Date: Fri, 17 Jun 2005 15:56:35 -0400
To: mpm@selenic.com
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: netpoll and the bonding driver
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to implement a netpoll hook for the bonding driver.  In doing
so, I ran into the following problem:

netpoll_send_skb calls the device's hard_start_xmit routine.  In this case,
it will be one of the bonding driver's xmit routines.  Each of these ends
up calling bond_dev_queue_xmit, which in turn calls dev_queue_xmit.

Now, for netconsole, the code disables interrupts before calling
netpoll_send_udp:

        local_irq_save(flags);

        for(left = len; left; ) {
                frag = min(left, MAX_PRINT_CHUNK);
                netpoll_send_udp(&np, msg, frag);
                msg += frag;
                left -= frag;
        }

        local_irq_restore(flags);

Note that if you did an alt-sysrq-t, then you would enter this code path in
interrupt context as well, and herein lies the problem.  It seems that
dev_queue_xmit is not supposed to be called with interrupts disabled.  The
immediate affect of this is that the WARN_ON in local_bh_enable triggers
(called at the end of dev_queue_xmit), causing us to loop infinitely
printing out stack traces.

So, my question is this: how in the world do we fit the bonding driver into
the generic netpoll infrastructure?  In the case of every other driver,
netpoll simply calls the hard_start_xmit routine[1], and this approach
simply doesn't work for the bonding driver, for the reasons I described
above.  So, one way to make the bonding driver fit into this model is to
modify it to not call dev_queue_xmit when called from netpoll.  This can be
done, I suppose, by adding another start_xmit routine that is specific to
netpoll.  This doesn't feel good to me, but I'm not sure how else you would
solve the problem (and netpoll already gets its own poll interface, so is
one more all that bad?).  The other approach to take is to put bonding
specific logic into netpoll.  I think we can all agree that is a bad idea.

-Jeff

[1] Note that netpoll does not perform any of the checks that dev_queue_xmit
    does.  This either means that a) in the netpoll case, this is an okay
    thing to do (since it's been working for this long), or b) netpoll has a 
    bug.
