Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUIGRBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUIGRBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIGQ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:58:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37295 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268177AbUIGQzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:55:20 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16701.59261.688607.284454@segfault.boston.redhat.com>
Date: Tue, 7 Sep 2004 12:53:17 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll trapped question
In-Reply-To: <20040907165014.GX31237@waste.org>
References: <16692.45331.968648.262910@segfault.boston.redhat.com>
	<20040906213502.GU31237@waste.org>
	<16701.58093.63886.734877@segfault.boston.redhat.com>
	<20040907165014.GX31237@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netpoll trapped question; Matt Mackall <mpm@selenic.com> adds:

mpm> On Tue, Sep 07, 2004 at 12:33:49PM -0400, Jeff Moyer wrote:
>> ==> Regarding Re: netpoll trapped question; Matt Mackall
>> <mpm@selenic.com> adds:
>> 
mpm> On Tue, Aug 31, 2004 at 01:10:43PM -0400, Jeff Moyer wrote:
>> >> Hi, Matt,
>> >> 
>> >> This part of the netpoll trapped logic seems suspect to me, from >>
>> include/linux/netdevice.h:
>> >> 
>> >> static inline void netif_wake_queue(struct net_device *dev) { #ifdef
>> >> CONFIG_NETPOLL_TRAP if (netpoll_trap()) return; #endif if >>
>> (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state)) >>
>> __netif_schedule(dev); }
>> >> 
>> >> static inline void netif_stop_queue(struct net_device *dev) { #ifdef
>> >> CONFIG_NETPOLL_TRAP if (netpoll_trap()) return; #endif >>
>> set_bit(__LINK_STATE_XOFF, &dev->state); }
>> >> 
>> >> This looks buggy.  Network drivers are now not able to stop the queue
>> >> when they run out of Tx descriptors.  I think the __netif_schedule is
>> >> okay to do in the context of netpoll, and certainly a set_bit is
>> okay.  >> Why are these hooks in place?  I've tested alt-sysrq-t over
>> netconsole >> and also netdump with these #ifdef's removed, and things
>> work correctly.  >> Compare this with alt-sysrq-t hanging the system
>> with these tests in >> place.  If I run netdump with this logic still in
>> place, I get the >> following messages from the tg3
driver>
>> >>
eth0> BUG! Tx Ring full when queue awake!
>> >> Shall I send a patch, or have I missed something?
>> 
mpm> I don't remember the origin or motivation of this bit, so I'm not sure
mpm> at the moment. Shoot me a patch and I'll poke at it.
>> What tree would you like me to base the patch on?  In absence of
>> response, it will be the latest -mm.

mpm> -mm is fine.
 
mpm> Btw, did I send you my thoughts on your recursion patch?
>> Yes, from your mail:
>> 
mpm> But I still don't like this. dev->poll() is liable to attempt to
mpm> recursively take its own driver lock again internally and we still
mpm> deadlock. Have we already seen recursion here? If we do, I think we
mpm> need to fix that in drivers. Meanwhile we should just bail here and
mpm> maybe set a "something bad happened" flag.
>> I'm not sure I follow.  Which lock are you concerned about deadlocking
>> on?

mpm> A random lock private to a given driver, for instance one taken on
mpm> entry to the IRQ handler. If said driver tries to do a printk inside
mpm> that lock and we recursively call the handler in netconsole, we're in
mpm> trouble.  These are the issues that will have to be cleaned up in
mpm> individual drivers. So far, I haven't seen any reports, but I'm pretty
mpm> sure such cases exist. I suppose it's also possible for us to disable
mpm> recursion in netconsole instead of at the netpoll level.

Recursion in netconsole is protected by the console semaphore.

-Jeff
