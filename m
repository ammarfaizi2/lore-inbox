Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUJPVPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUJPVPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268889AbUJPVPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:15:43 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:31408 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S268886AbUJPVPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:15:38 -0400
Date: Sat, 16 Oct 2004 23:15:33 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
In-Reply-To: <20041016210231.GA14939@elte.hu>
Message-Id: <Pine.OSF.4.05.10410162305590.11899-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I have compile error when I use the make O= option: usr/initramfs_list
doesn't exist. This doesn't occur in pure 2.6.8.1 or 2.6.9-rc4 but does  
occur in 2.6.9-rc4-mm1.

Esben

Here is a fix (the build seems not to be broken with or without O=)

--- linux-2.6.9-rc4-mm1-RT-U4/usr/Makefile.orig 2004-10-16
19:39:46.000000000 +0200
+++ linux-2.6.9-rc4-mm1-RT-U4/usr/Makefile      2004-10-16
23:04:13.661382082 +0200
@@ -35,7 +35,10 @@
          echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > $@'; \
        else \
          echo 'echo Using shipped $@'; \
-       fi)
+          if [ $(KBUILD_SRC)!="" ]; then \
+            cp -f $(KBUILD_SRC)/usr/initramfs_list ./usr/initramfs_list; \
+          fi; \
+        fi)
 
 
 $(INITRAMFS_LIST): FORCE


On Sat, 16 Oct 2004, Ingo Molnar wrote:

> 
> * john cooper <john.cooper@timesys.com> wrote:
> 
> > Ingo,
> >    In reading your -U3 patch the test below (#156)
> > wasn't clear to me.   It would seem in the case of
> > softirq_preemption, __do_softirq() should be called
> > to kick ksoftirqd, otherwise ___do_softirq() would
> > be called to exec softirqs in the immediate context.
> 
> the dependencies here are a bit complex due to the
> various compile-time and runtime flags, and various
> architecture call-ins to softirq.c.
> 
> > kernel/softirq.c:
> > 
> >  153   asmlinkage void _do_softirq(void)
> >  154   {
> >  155           local_irq_disable();
> >  156           if (!softirq_preemption)
> >  157                   __do_softirq();
> >  158           else
> >  159                   ___do_softirq();
> >  160           local_irq_enable();
> >  161   }
> 
> ___do_softirq() is the 'lowest level' softirq function, it
> directly executes the handlers.
> 
> __do_softirq() disables bhs and calls ___do_softirq() - this
> is the 'direct' softirq execution model, this function is
> called by hardirq contexts and by softirqd. [btw., irqd calls
> this function too which is a bit pointless.] In the indirect
> execution model (SOFTIRQ_PREEMPT) this function does no softirq
> execution, it only wakes up softirqd.
> 
> _do_softirq() is what is called by softirqd - dependent on the
> execution model this function will either execute ___do_softirq()
> [no additional locking or bh disabling] in the threaded case,
> while in the direct case it will execute __do_softirq().
> 
> so the logic seems to be correct to me. (except for the minor
> detail of irqd calling __do_softirq() which doesnt make much 
> sense but which is harmless otherwise.)
> 
> with DEBUG_PREEMPT it is relatively safe to call ___do_softirq()
> from softirqd (without doing the extra bh disabling), because
> the two main rules of softirqs are still preserved:
> 
>  1) softirq execution doesnt reenter itself
> 
>  2) per-CPU assumptions safely detected
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


