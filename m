Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUGKKas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUGKKas (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUGKKar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:30:47 -0400
Received: from witte.sonytel.be ([80.88.33.193]:23179 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266555AbUGKK34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:29:56 -0400
Date: Sun, 11 Jul 2004 12:29:51 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0407111226350.3963@waterleaf.sonytel.be>
References: <20040707122525.X1924@build.pdx.osdl.net>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com>
 <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
 <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
 <Pine.LNX.4.58.0407091313570.20635@scrub.home>
 <Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2004, Geert Uytterhoeven wrote:
> On Fri, 9 Jul 2004, Roman Zippel wrote:
> > On Thu, 8 Jul 2004, Linus Torvalds wrote:
> > > I have one. It's in my head. It's called the Linux Kernel C standard. Some
> > > of it is documented in CodinggStyle, others is just codified in existing
> > > practice.
> >
> > So far we have been quite liberal in style questions, what annoys me here
> > is that people send warning patches directly to you without even notifying
> > the maintainers. If you want people to conform people to a certain
> > CodingStyle please document officially in the kernel, sparse isn't
> > distributed with the kernel and the sparse police is silently changing the
> > kernel all over the place with sometimes questionable benefit. Only the
>
> I agree, when you're talking about the `if ((x = f())' cases. We already added
> the extra parentheses to shut up gcc...
>
> > __user warnings had really found the bugs, but the rest I've seen changes
> > perfectly legal code.

But why does sparse complain about

    p->thread.fs = get_fs().seg;

with

    linux-m68k-2.6.7/arch/m68k/kernel/process.c:265:23: warning: expected lvalue for member dereference

? Looks valid to me?

(patch to kill the warning below, _for reference only_)

--- linux-m68k-2.6.7/arch/m68k/kernel/process.c.orig	2004-06-21 20:20:00.000000000 +0200
+++ linux-m68k-2.6.7/arch/m68k/kernel/process.c	2004-06-27 14:47:23.000000000 +0200
@@ -242,6 +242,7 @@
 	struct pt_regs * childregs;
 	struct switch_stack * childstack, *stack;
 	unsigned long stack_offset, *retp;
+	mm_segment_t fs;

 	stack_offset = THREAD_SIZE - sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) ((unsigned long) (p->stack) + stack_offset);
@@ -262,7 +263,8 @@
 	 * Must save the current SFC/DFC value, NOT the value when
 	 * the parent was last descheduled - RGH  10-08-96
 	 */
-	p->thread.fs = get_fs().seg;
+	fs = get_fs();
+	p->thread.fs = fs.seg;

 	if (!FPU_IS_EMU) {
 		/* Copy the current fpu state */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
