Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265587AbUA2Kah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265647AbUA2Kah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:30:37 -0500
Received: from gprs103-63.eurotel.cz ([160.218.103.63]:5505 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265587AbUA2KaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:30:21 -0500
Date: Thu, 29 Jan 2004 11:29:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Hugang <hugang@soulinfo.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-ID: <20040129102948.GA480@elf.ucw.cz>
References: <20040123183030.02fd16d6@localhost> <1074912854.834.61.camel@gaston> <20040126181004.GB315@elf.ucw.cz> <1075154452.6191.91.camel@gaston> <1075156310.2072.1.camel@laptop-linux> <20040128202217.0a1f8222@localhost> <1075336478.30623.317.camel@gaston> <20040129100554.6453e6c8@localhost> <1075350214.1231.18.camel@gaston> <20040129165119.553403f1@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129165119.553403f1@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > As long as you make sure you save the LR in case you need it, you
> > can call asm functions. macros are _evil_ :)
> > 
> > Also, you can remove the code playing with BATs for now, they don't
> > really need to be saved. If the boot kernel sets them up any
> > differently than the saved kernel, we are in trouble anyway. And the
> > G5 has no BATs.
> 
> Thanks, I hate macros too, I'll change code to function as soon as
> possible.
> 
> First I would tell you current swusp(2) signal ppc part has a problem.
> I has add follow code into do_signal to let process to FREEZE before 
> suspend.
> ppc/
>     int signr, ret;
> 
> +    if (current->flags & PF_FREEZE) {
> +        refrigerator(PF_FREEZE);
> +        return 0;
> +    }
> 
>     if (!oldset)
>         oldset = &current->blocked;
> 
> i386/
>     if (current->flags & PF_FREEZE) {
>         refrigerator(PF_FREEZE);
>         if (!signal_pending(current))
>             goto no_signal;
>     }


You may want to try this one.. Maybe it helps?
								Pavel
Index: linux/kernel/power/process.c
===================================================================
--- linux.orig/kernel/power/process.c	2004-01-13 22:52:40.000000000 +0100
+++ linux/kernel/power/process.c	2004-01-09 20:33:05.000000000 +0100
@@ -49,10 +49,11 @@
 	pr_debug("%s entered refrigerator\n", current->comm);
 	printk("=");
 	current->flags &= ~PF_FREEZE;
-	if (flag)
-		flush_signals(current); /* We have signaled a kernel thread, which isn't normal behaviour
-					   and that may lead to 100%CPU sucking because those threads
-					   just don't manage signals. */
+
+	spin_lock_irq(&current->sighand->siglock);
+	recalc_sigpending(); /* We sent fake signal, clean it up */
+	spin_unlock_irq(&current->sighand->siglock);
+
 	current->flags |= PF_FROZEN;
 	while (current->flags & PF_FROZEN)
 		schedule();


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
