Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVAPF6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVAPF6H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVAPF5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:57:52 -0500
Received: from [220.248.27.114] ([220.248.27.114]:24990 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262435AbVAPF5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:57:04 -0500
Date: Sun, 16 Jan 2005 13:54:20 +0800
From: hugang@soulinfo.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Message-ID: <20050116055420.GA11880@hugang.soulinfo.com>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <20050115012120.GA4743@hugang.soulinfo.com> <200501151147.32919.rjw@sisk.pl> <200501152220.42129.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501152220.42129.rjw@sisk.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 10:20:42PM +0100, Rafael J. Wysocki wrote:
> > > > > 
> > > > > 2.6.11-rc1-mm1 
> > > > >  -> 2005-1-14.core.diff 	core patch		TEST PASSED
> > > > >   -> 2005-1-14.x86_64.diff	x86_64 patch	NOT TESTED
> > > > 
> > > > Unfortunately, on x86_64 it goes south on suspend, probably somwhere in write_pagedir(),
> > > > but I'm not quite sure as I can't make it print any useful stuff to the serial console
> > > > (everything is dumped to a virtual tty only).  Seemingly, it prints some
> > > > "write_pagedir: ..." debug messages and then starts to print garbage in
> > > > an infinite loop.
> 
> I have some good news for you. :-)
> 
> The patch actually works fine on my box.  What I thought was a result of an infinite loop,
> turned out to be "only" a debug output from it, which is _really_ excessive.  After I had
> commented out the most of pr_debug()s in your code, it works nicely and I like it very
> much.  Thanks a lot for porting it to x86_64!
> 
Cool, Current I making software suspend also works in Qemu X86_64
emulation, Here is a update patch to making copyback more safed and 
possible to improve copyback speed.

I change the swsusp_arch_resume to nosave section, the in memory copy
back it not touch this code. before not change that to nosave section,
I'm also geting a infinite loop in copy_one_page, From the qemu in_asm,
I sure that loop in copy_one_page, when I change it to nosave section,
that problem go away, I dont' sure tha't good idea to fixed it, but
current it works in my qemu, Can someone owner x86_64 test it.

I disable Flush TLB after copy page, It speedup the in qemu, But I can't
sure the right thing in real machine, can someone give me point.

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc

2005-1-16.x86_64.diff

--- 2.6.11-rc1-mm1/arch/x86_64/kernel/suspend_asm.S	2004-12-30 14:56:35.000000000 +0800
+++ 2.6.11-rc1-mm1-swsusp-x86_64/arch/x86_64/kernel/suspend_asm.S	2005-01-16 13:38:25.000000000 +0800
@@ -35,6 +35,7 @@ ENTRY(swsusp_arch_suspend)
 	call swsusp_save
 	ret
 
+	.section    .data.nosave
 ENTRY(swsusp_arch_resume)
 	/* set up cr3 */	
 	leaq	init_level4_pgt(%rip),%rax
@@ -49,43 +50,47 @@ ENTRY(swsusp_arch_resume)
 	movq	%rcx, %cr3;
 	movq	%rax, %cr4;  # turn PGE back on
 
-	movl	nr_copy_pages(%rip), %eax
-	xorl	%ecx, %ecx
-	movq	$0, %r10
-	testl	%eax, %eax
-	jz	done
-.L105:
-	xorl	%esi, %esi
-	movq	$0, %r11
-	jmp	.L104
-	.p2align 4,,7
+	movq	pagedir_nosave(%rip), %rdi
+	testq	%rdi, %rdi
+	je		done
+
+copyback_page:
+	movq	24(%rdi), %r9
+	xorl	%r8d, %r8d
+
+copy_one_pgdir:
+	movq    8(%rdi), %rsi
+	testq   %rsi, %rsi
+	je  	done
+	movq    (%rdi), %rcx
+	xorl    %edx, %edx
+
 copy_one_page:
-	movq	%r10, %rcx
-.L104:
-	movq	pagedir_nosave(%rip), %rdx
-	movq	%rcx, %rax
-	salq	$5, %rax
-	movq	8(%rdx,%rax), %rcx
-	movq	(%rdx,%rax), %rax
-	movzbl	(%rsi,%rax), %eax
-	movb	%al, (%rsi,%rcx)
-
-	movq	%cr3, %rax;  # flush TLB
-	movq	%rax, %cr3;
-
-	movq	%r11, %rax
-	incq	%rax
-	cmpq	$4095, %rax
-	movq	%rax, %rsi
-	movq	%rax, %r11
-	jbe	copy_one_page
-	movq	%r10, %rax
-	incq	%rax
-	movq	%rax, %rcx
-	movq	%rax, %r10
-	mov	nr_copy_pages(%rip), %eax
-	cmpq	%rax, %rcx
-	jb	.L105
+	movq    (%rcx,%rdx,8), %rax
+	movq    %rax, (%rsi,%rdx,8)
+	movq    8(%rcx,%rdx,8), %rax
+	movq    %rax, 8(%rsi,%rdx,8)
+	movq    16(%rcx,%rdx,8), %rax
+	movq    %rax, 16(%rsi,%rdx,8)
+	movq    24(%rcx,%rdx,8), %rax
+	movq    %rax, 24(%rsi,%rdx,8)
+#if 0 /* XXX speep up in qemu */
+	movq    %cr3, %rax;  # flush TLB
+	movq    %rax, %cr3;
+#endif
+	addq    $4, %rdx
+	cmpq    $511, %rdx
+	jbe 	copy_one_page; # copy one page
+
+	incq    %r8
+	addq    $32, %rdi
+	cmpq    $127, %r8
+	jbe 	copy_one_pgdir; # copy one pgdir
+
+	testq   %r9, %r9
+	movq    %r9, %rdi
+	jne 	copyback_page
+
 done:
 	movl	$24, %eax
 	movl	%eax, %ds

Here is the patch for current qemu, with this it has no problem in
software suspend/resume, everything. :)

--- target-i386/helper.c~cvs	2005-01-16 14:06:22.000000000 -0500
+++ target-i386/helper.c	2005-01-16 14:07:21.000000000 -0500
@@ -1454,7 +1454,7 @@ void load_seg(int seg_reg, int selector)
     selector &= 0xffff;
     if ((selector & 0xfffc) == 0) {
         /* null selector case */
-        if (seg_reg == R_SS)
+        if (seg_reg == R_CS)
             raise_exception_err(EXCP0D_GPF, 0);
         cpu_x86_load_seg_cache(env, seg_reg, selector, 0, 0, 0);
     } else {
