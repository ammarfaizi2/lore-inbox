Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270493AbTGVKcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270625AbTGVKcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:32:31 -0400
Received: from [213.39.233.138] ([213.39.233.138]:27611 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S270493AbTGVKc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:32:29 -0400
Date: Tue, 22 Jul 2003 12:47:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: John Bradford <john@grabjohn.com>
Cc: junkio@cox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Port SquashFS to 2.6
Message-ID: <20030722104723.GE29430@wohnheim.fh-wedel.de>
References: <200307221036.h6MAa7ER001757@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200307221036.h6MAa7ER001757@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 July 2003 11:36:07 +0100, John Bradford wrote:
> 
> > If you look closely at the kernel, there is currently no way of
> > telling whether it contains stack overflows waiting to happen, or not.
> 
> It would be an interesting experiment to deliberately make the kernel
> stack smaller, and see what happens.  If no problems seem apparent
> with a reduced kernel stack, it gives more weight to the argument that
> the default one is OK.

Been there, done that. :)

Use the patch below, enable the stack checking in your .config and
watch the system log get filled.  5k is quite agressive, I agree, but
with 4k stacks in mind, it is just 1k of slack left, plus the
measurement is a bit fuzzy, so you really want some slack.

Maybe there is also a patch flying around that initializes the stack
with some magic number on a fork and logs the number of used bytes on
exit.  That way you get rid of the fuzzyness, but you loose the exact
call trace that led to this number.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike

--- linux-2.5.67/arch/i386/kernel/irq.c~stack_overflow	2003-04-07 19:30:39.000000000 +0200
+++ linux-2.5.67/arch/i386/kernel/irq.c	2003-04-14 20:22:01.000000000 +0200
@@ -342,7 +342,15 @@
 
 		__asm__ __volatile__("andl %%esp,%0" :
 					"=r" (esp) : "0" (8191));
+#if 0
 		if (unlikely(esp < (sizeof(struct thread_info) + 1024))) {
+#else
+		/* We check for 5k for now. The kernel stack still is 8k,
+		 * but should shrink to 4k, so this test makes sense.
+		 * Once the stack is 4k, we go back to the old test.
+		 */
+		if (unlikely(esp < (sizeof(struct thread_info) + 5120))) {
+#endif
 			printk("do_IRQ: stack overflow: %ld\n",
 				esp - sizeof(struct thread_info));
 			dump_stack();
