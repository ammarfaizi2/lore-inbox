Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264895AbUGBSjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbUGBSjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUGBSjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:39:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26118 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264895AbUGBSjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:39:18 -0400
Date: Fri, 2 Jul 2004 19:39:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040702193914.B24028@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk> <20040630191428.GC31064@mail.shareable.org> <20040630202313.A1496@flint.arm.linux.org.uk> <20040630201546.GD31064@mail.shareable.org> <20040630235921.C1496@flint.arm.linux.org.uk> <20040630233014.GC32560@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040630233014.GC32560@mail.shareable.org>; from jamie@shareable.org on Thu, Jul 01, 2004 at 12:30:14AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 12:30:14AM +0100, Jamie Lokier wrote:
> > Ok, this could work, but there's one gotcha - TASK_SIZE-4 doesn't fit
> > in an 8-bit rotated constants, so we need 2 extra instructions:
> > 
> > __get_user_4:
> > 	mov	r1, #TASK_SIZE
> > 	sub	r1, r1, #4
> > 	cmp	r0, r1
> > 4:	ldrlet	r1, [r0]
> > 	movle	r0, #0
> > 	movle	pc, lr
> > 	...
> 
> One more possibility:
> 
> 	cmp	r0, #(TASK_SIZE - (1<<24))
> 
> I.e. just compare against the largest constant that can be
> represented.  For accesses to the last part of userspace, it's a
> penalty of 4 instructions -- but it might work out to be a net gain.
> 
> Actually, since the shortest path is only three instructions in the
> fast case, not counting control flow, it might be good to inline those
> 3 in uaccess.h, and change the "bl" to a conditonal "blhi" there.

I've been wondering whether we need any of this checking for 32-bit
ARMs in any case.  I wouldn't like to say definitely, but I've just
tried this:

__get_user_4:
4:	ldrt	r1, [r0]
	mov	r0, #0
	mov	pc, lr

and it appears to behave as we want.  My only concern is Xscale with
some of their errata.

If this works out fine, then we could kill the differences between
__get_user and get_user, and __put_user and put_user on ARM.  Before
doing that, however, I would want to evaluate the performance and
size difference between having this out of line and inline.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' orig/arch/arm/lib/getuser.S linux/arch/arm/lib/getuser.S
--- orig/arch/arm/lib/getuser.S	Tue Apr 13 19:40:00 2004
+++ linux/arch/arm/lib/getuser.S	Fri Jul  2 14:26:32 2004
@@ -32,59 +32,34 @@
 
 	.global	__get_user_1
 __get_user_1:
-	bic	r1, sp, #0x1f00
-	bic	r1, r1, #0x00ff
-	ldr	r1, [r1, #TI_ADDR_LIMIT]
-	sub	r1, r1, #1
-	cmp	r0, r1
-1:	ldrlsbt	r1, [r0]
-	movls	r0, #0
-	movls	pc, lr
-	b	__get_user_bad
+1:	ldrbt	r1, [r0]
+	mov	r0, #0
+	mov	pc, lr
 
 	.global	__get_user_2
 __get_user_2:
-	bic	r2, sp, #0x1f00
-	bic	r2, r2, #0x00ff
-	ldr	r2, [r2, #TI_ADDR_LIMIT]
-	sub	r2, r2, #2
-	cmp	r0, r2
-2:	ldrlsbt	r1, [r0], #1
-3:	ldrlsbt	r2, [r0]
+2:	ldrbt	r1, [r0], #1
+3:	ldrbt	r2, [r0]
 #ifndef __ARMEB__
-	orrls	r1, r1, r2, lsl #8
+	orr	r1, r1, r2, lsl #8
 #else
-	orrls	r1, r2, r1, lsl #8
+	orr	r1, r2, r1, lsl #8
 #endif
-	movls	r0, #0
-	movls	pc, lr
-	b	__get_user_bad
+	mov	r0, #0
+	mov	pc, lr
 
 	.global	__get_user_4
 __get_user_4:
-	bic	r1, sp, #0x1f00
-	bic	r1, r1, #0x00ff
-	ldr	r1, [r1, #TI_ADDR_LIMIT]
-	sub	r1, r1, #4
-	cmp	r0, r1
-4:	ldrlst	r1, [r0]
-	movls	r0, #0
-	movls	pc, lr
-	b	__get_user_bad
+4:	ldrt	r1, [r0]
+	mov	r0, #0
+	mov	pc, lr
 
 	.global	__get_user_8
 __get_user_8:
-	bic	r2, sp, #0x1f00
-	bic	r2, r2, #0x00ff
-	ldr	r2, [r2, #TI_ADDR_LIMIT]
-	sub	r2, r2, #8
-	cmp	r0, r2
-5:	ldrlst	r1, [r0], #4
-6:	ldrlst	r2, [r0]
-	movls	r0, #0
-	movls	pc, lr
-
-	/* fall through */
+5:	ldrt	r1, [r0], #4
+6:	ldrt	r2, [r0]
+	mov	r0, #0
+	mov	pc, lr
 
 __get_user_bad_8:
 	mov	r2, #0
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' orig/arch/arm/lib/putuser.S linux/arch/arm/lib/putuser.S
--- orig/arch/arm/lib/putuser.S	Tue Apr 13 19:40:00 2004
+++ linux/arch/arm/lib/putuser.S	Fri Jul  2 14:27:14 2004
@@ -32,60 +32,35 @@
 
 	.global	__put_user_1
 __put_user_1:
-	bic	ip, sp, #0x1f00
-	bic	ip, ip, #0x00ff
-	ldr	ip, [ip, #TI_ADDR_LIMIT]
-	sub	ip, ip, #1
-	cmp	r0, ip
-1:	strlsbt	r1, [r0]
-	movls	r0, #0
-	movls	pc, lr
-	b	__put_user_bad
+1:	strbt	r1, [r0]
+	mov	r0, #0
+	mov	pc, lr
 
 	.global	__put_user_2
 __put_user_2:
-	bic	ip, sp, #0x1f00
-	bic	ip, ip, #0x00ff
-	ldr	ip, [ip, #TI_ADDR_LIMIT]
-	sub	ip, ip, #2
-	cmp	r0, ip
 	movls	ip, r1, lsr #8
 #ifndef __ARMEB__
-2:	strlsbt	r1, [r0], #1
-3:	strlsbt	ip, [r0]
+2:	strbt	r1, [r0], #1
+3:	strbt	ip, [r0]
 #else
-2:	strlsbt	ip, [r0], #1
-3:	strlsbt	r1, [r0]
+2:	strbt	ip, [r0], #1
+3:	strbt	r1, [r0]
 #endif
-	movls	r0, #0
-	movls	pc, lr
-	b	__put_user_bad
+	mov	r0, #0
+	mov	pc, lr
 
 	.global	__put_user_4
 __put_user_4:
-	bic	ip, sp, #0x1f00
-	bic	ip, ip, #0x00ff
-	ldr	ip, [ip, #TI_ADDR_LIMIT]
-	sub	ip, ip, #4
-	cmp	r0, ip
-4:	strlst	r1, [r0]
-	movls	r0, #0
-	movls	pc, lr
-	b	__put_user_bad
+4:	strt	r1, [r0]
+	mov	r0, #0
+	mov	pc, lr
 
 	.global	__put_user_8
 __put_user_8:
-	bic	ip, sp, #0x1f00
-	bic	ip, ip, #0x00ff
-	ldr	ip, [ip, #TI_ADDR_LIMIT]
-	sub	ip, ip, #8
-	cmp	r0, ip
-5:	strlst	r1, [r0], #4
-6:	strlst	r2, [r0]
-	movls	r0, #0
-	movls	pc, lr
-
-	/* fall through */
+5:	strt	r1, [r0], #4
+6:	strt	r2, [r0]
+	mov	r0, #0
+	mov	pc, lr
 
 __put_user_bad:
 	mov	r0, #-EFAULT

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
