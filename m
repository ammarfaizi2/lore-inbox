Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTIIWOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbTIIWOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:14:14 -0400
Received: from ee.oulu.fi ([130.231.61.23]:33459 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264867AbTIIWNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:13:53 -0400
Date: Wed, 10 Sep 2003 01:13:49 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4, b44 transmit timeout
Message-ID: <20030909221349.GA22387@ee.oulu.fi>
References: <200309081134.17013.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200309081134.17013.lkml@kcore.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 11:34:17AM +0200, Jan De Luyck wrote:
> On Tue, Sep 02, 2003 at 09:33:53AM +0200, Norbert Preining wrote:  
> 
> > A-ha! Thanks, I think this should be enough to figure out what the problem  
> > is... Looks like the driver doesn't even get the packets pump tries to send,  
> > pump is a bit special in the way it bounces the interface up and down when  
> > doing its work, that probably triggers a race in b44..
> 
> I can also easily recreate this by calling dhcpcd e.g. when the cable isn't in 
> the socket yet. If i attach the cable then I see the interface coming up, 
> going down, and then the NETDEV watchdog message.
> 
> Unfortunatly this usually means that dhcpcd goes hanging. ifconfig hangs too 
> if I try to use it, and rebooting must be forced with sysrq and an oops a 
> alt-sysrq-o for poweroff...
Hi

(I was quite far away from civilization for a few days, which is why
I've been quiet on this topic for a while :-) )

Culd you try the patch Jeff Garzik posted as a fix for tg3 
ifconfig down/up problems, I believe it fixes the same problem since
it's a generic thing with NAP

What I believe should happen after applying this patch is that the
b44 driver shouldn't hang as a result of doing tricks like the ones
mentioned. pump might not work even with it (If I understood correctly,
(pump & tg3 don't mix well either due to pump having some wrong assumptions
on when it can send packets). dhcpcd definately should work though.



--- SNIP --
Note that people seeing "ifconfig down ... ifconfig up" problems need to
apply this patch.  (to 2.4.23-pre, too)
                                                                                
        Jeff
                                                                                
                                                                                
                                                                                
[-- Attachment #2: patch --]
[-- Type: text/plain, Encoding: 7bit, Size: 0.5K --]
                                                                                
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c    Mon Sep  8 18:14:36 2003
+++ b/net/core/dev.c    Mon Sep  8 18:14:36 2003
@@ -851,7 +851,11 @@
         * engine, but this requires more changes in devices. */
                                                                                
        smp_mb__after_clear_bit(); /* Commit netif_running(). */
-       netif_poll_disable(dev);
+       while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
+               /* No hurry. */
+               current->state = TASK_INTERRUPTIBLE;
+               schedule_timeout(1);
+       }

-- SNIP --


