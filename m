Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423854AbWKIOyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423854AbWKIOyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423867AbWKIOyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:54:33 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:18925 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1423866AbWKIOyc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:54:32 -0500
Message-Id: <1163084072.31014.275411753@webmail.messagingengine.com>
X-Sasl-Enc: hjHcQGgYuyINo6ZlVBg5fK5oBbgbNKhZi2IwtLU6eXIw 1163084072
From: "Alexander van Heukelum" <heukelum@fastmail.fm>
To: "Steven Rostedt" <rostedt@goodmis.org>,
       "LKML" <linux-kernel@vger.kernel.org>
Cc: sct@redhat.com, ak@suse.de, herbert@gondor.apana.org.au,
       xen-devel@lists.xensource.com, heukelum@mailshack.com
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com>
Subject: Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
In-Reply-To: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com>
Date: Thu, 09 Nov 2006 15:54:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi,
> 
> Stephen Tweedie, Herbert Xu, and myself have been struggling with a very
> nasty bug in Xen.  But it also pointed out a small bug in the x86_64
> kernel boot setup.
> 
> The GDT limit being setup by the initial bzImage code when entering into
> protected mode is way too big.  The comment by the code states that the
> size of the GDT is 2048, but the actual size being set up is much bigger
> (32768). This happens simply because of one extra '0'.
> 
> Instead of setting up a 0x800 size, 0x8000 is set up.  On bare metal this
> is fine because the CPU wont load any segments unless  they are
> explicitly used.  But unfortunately, this breaks Xen on vmx FV, since it
> (for now) blindly loads all the segments into the VMCS if they are less
> than the gdt limit. Since the real mode segments are around 0x3000, we
> are
> getting junk into the VMCS and that later causes an exception.
> 
> Stephen Tweedie has written up a patch to fix the Xen side and will be
> submitting that to those folks. But that doesn't excuse the GDT limit
> being a magnitude too big.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.19-rc2/arch/x86_64/boot/setup.S
> ===================================================================
> --- linux-2.6.19-rc2.orig/arch/x86_64/boot/setup.S      2006-11-08
> 21:37:58.000000000 -0500
> +++ linux-2.6.19-rc2/arch/x86_64/boot/setup.S   2006-11-08
> 21:38:16.000000000 -0500
> @@ -840,7 +840,7 @@ idt_48:
>  	.word	0				# idt limit = 0
>  	.word	0, 0				# idt base = 0L
>  gdt_48:
> -       .word   0x8000                          # gdt limit=2048,
> +       .word   0x800                           # gdt limit=2048,
>  						#  256 GDT entries
> 
>  	.word	0, 0				# gdt base (filled in later)

The limit should be the offset of the last byte of the gdt table. So
I think what was meant was really 0x7ff. Comparing this code with the 
i386-version, why does x86_64 need 256 entries here, while i386 is happy
with just the code-segment and data-segment descriptors?

Greetings,
    Alexander
-- 
  Alexander van Heukelum
  heukelum@fastmail.fm

-- 
http://www.fastmail.fm - And now for something completely different…

