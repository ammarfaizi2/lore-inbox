Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVALNDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVALNDR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 08:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVALNDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 08:03:17 -0500
Received: from [220.248.27.114] ([220.248.27.114]:48270 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261179AbVALNDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 08:03:05 -0500
Date: Wed, 12 Jan 2005 21:01:10 +0800
From: hugang@soulinfo.com
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH swsusp: page rellocation speed up
Message-ID: <20050112130110.GA28919@hugang.soulinfo.com>
References: <20050111010122.GA3013@mail.muni.cz> <20050112124948.GA15687@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112124948.GA15687@hugang.soulinfo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 08:49:49PM +0800, hugang@soulinfo.com wrote:
> On Tue, Jan 11, 2005 at 02:01:23AM +0100, Lukas Hejtmanek wrote:
> > Hello,
> > 
> > attached patch should speed up page rellocation at time of resume. Please test.
> > The diff is against 2.6.10-bk8
> > 
> ....
> 
> really cool, Passed in my x86 and ppc.
> 
> Here is a patch to make pagedir using non-continuity page, 
>  2.6.10 -> mm1 -> this patch -> my patch
> 

support for PowerPc.
  2.6.10 -> mm1 -> Lukas Hejtmanek's patch -> agx's patch -> pbe core ->
   this patch

  agx swsusp patch from http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/

--- 2.6.10-mm1-axg-swap_mem/arch/ppc/kernel/swsusp.S~old	2005-01-12 20:55:31.000000000 +0800
+++ 2.6.10-mm1-axg-swap_mem/arch/ppc/kernel/swsusp.S	2005-01-12 20:57:59.000000000 +0800
@@ -159,43 +159,57 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	sync
 	isync
 
-	/* Load ptr the list of pages to copy in r3 */
-	lis	r11,(pagedir_nosave - KERNELBASE)@h
-	ori	r11,r11,pagedir_nosave@l
-	lwz	r10,0(r11)
-	tophys(r3,r10)
-
-	/* Load the count of pages to copy in r4 */
-	lis	r11,(nr_copy_pages - KERNELBASE)@h
-	ori	r11,r11,nr_copy_pages@l
-	lwz	r4,0(r11)
+	/* Load ptr the list of pages to copy in r11 */
+	lis     r9,pagedir_nosave@ha
+	addi    r9,r9,pagedir_nosave@l
 
+	tophys(r9,r9)
+	lwz     r9, 0(r9)
+#if 0
+	twi     31,r0,0 /* triger trap */
+#endif
+	cmpwi   r9, 0
+	beq copy_loop_end
 
-	/* Copy the pages. This is a very basic implementation, to
-	 * be replaced by something more cache efficient */
-1:
-	li	r0,256
-	mtctr	r0
-	lwz	r11,0(r3)	/* source */
-	tophys(r5,r11)
-	lwz	r10,4(r3)	/* destination */
-	tophys(r6,r10)
-2:
-	lwz	r8,0(r5)
-	lwz	r9,4(r5)
-	lwz	r10,8(r5)
-	lwz	r11,12(r5)
-	addi	r5,r5,16
-	stw	r8,0(r6)
-	stw	r9,4(r6)
-	stw	r10,8(r6)
-	stw	r11,12(r6)
-	addi	r6,r6,16
-	bdnz	2b
-	addi	r3,r3,16
-	subi	r4,r4,1
-	cmpwi	0,r4,0
-	bne	1b
+copy_loop:
+	tophys(r9,r9)
+	lwz    r6, 12(r9)
+	li     r10, 0
+
+copy_one_pgdir:
+	lwz    r11, 4(r9)
+	addi   r8,r10,1
+	cmpwi  r11, 0
+	addi   r7,r9,16
+	beq copy_loop_end
+	li     r0, 256
+	mtctr  r0
+	lwz    r9,0(r9)
+#if 0
+	twi    31,r0,0 /* triger trap */
+#endif
+	tophys(r10,r11)
+	tophys(r11,r9)
+
+copy_one_page:
+	lwz    r0, 0(r11)
+	stw    r0, 0(r10)
+	lwz    r9, 4(r11)
+	stw    r9, 4(r10)
+	lwz    r0, 8(r11)
+	stw    r0, 8(r10)
+	lwz    r9, 12(r11)
+	addi   r11,r11,16
+	stw    r9, 12(r10)
+	addi   r10,r10,16
+	bdnz copy_one_page
+	mr     r10, r8
+	cmplwi r10, 255
+	mr     r9, r7
+	ble copy_one_pgdir
+	mr     r9, r6
+	bne copy_loop
+copy_loop_end:
 
 	/* Do a very simple cache flush/inval of the L1 to ensure
 	 * coherency of the icache

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
