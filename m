Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTJIAXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJIAXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 20:23:32 -0400
Received: from gprs147-181.eurotel.cz ([160.218.147.181]:2688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261837AbTJIAXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 20:23:30 -0400
Date: Thu, 9 Oct 2003 02:23:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>, Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [pm] Re: JFFS2 swsusp / signal cleanup.
Message-ID: <20031009002318.GB219@elf.ucw.cz>
References: <1065266733.16088.91.camel@imladris.demon.co.uk> <20031005161155.GA753@elf.ucw.cz> <20031005171916.B21478@flint.arm.linux.org.uk> <20031005191344.GA963@elf.ucw.cz> <1065384453.3157.149.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065384453.3157.149.camel@imladris.demon.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Should I do recalc_sigpending() instead of flush_signals(current)?
> 
> Yes. You can do that unconditionally, too -- no need to do it depending
> on an argument from the caller.

Yes, and it actually works that way. Good.

[Patrick, this patch is probably good idea, flush_signals has
potential to loose some signal].

[flag argument can be killed, but I guess its bad idea to do it now].

								Pavel

--- tmp/linux/kernel/power/process.c	2003-08-27 12:00:53.000000000 +0200
+++ linux/kernel/power/process.c	2003-10-05 21:15:21.000000000 +0200
@@ -49,10 +49,7 @@
 	pr_debug("%s entered refrigerator\n", current->comm);
 	printk("=");
 	current->flags &= ~PF_FREEZE;
-	if (flag)
-		flush_signals(current); /* We have signaled a kernel thread, which isn't normal behaviour
-					   and that may lead to 100%CPU sucking because those threads
-					   just don't manage signals. */
+	recalc_sigpending(); /* We sent fake signal, clean it up */
 	current->flags |= PF_FROZEN;
 	while (current->flags & PF_FROZEN)
 		schedule();

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
