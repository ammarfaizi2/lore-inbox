Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbUK1Qjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUK1Qjq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUK1Qjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:39:45 -0500
Received: from [220.248.27.114] ([220.248.27.114]:736 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261519AbUK1Q0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:26:43 -0500
Date: Mon, 29 Nov 2004 00:24:48 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend patch [3/6]
Message-ID: <20041128162448.GC28881@hugang.soulinfo.com>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128162320.GA28881@hugang.soulinfo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 12:23:20AM +0800, hugang@soulinfo.com wrote:
> Hi Pavel Machek, Nigel Cunningham:
> 
>  device-tree.diff 
>    base from suspend2 with a little changed.
> 
>  core.diff
>   1: redefine struct pbe for using _no_ continuous as pagedir.
>   2: make shrink memory as little as possible.
>   3: using a bitmap speed up collide check in page relocating.
>   4: pagecache saving ready.
> 
>  i386.diff
>  ppc.diff
>   i386 and powerpc suspend update.
> 
>  pagecachs_addon.diff
>   if enable page caches saving, must using it, it making saving
>   pagecaches safe. idea from suspend2.
> 
>   ppcfix.diff
>   fix compile error. 
>   $ gcc -v
>    .... 
>    gcc version 2.95.4 20011002 (Debian prerelease)
> 
> I'm using 2.6.9-ck3 With above patch, swsusp1 works prefect in my 
> PowerPC and x86 PC with Highmem and prepempt option enabled.
> 
> I hope the core.diff@1,@2,@3 i386.diff ppc.diff will merge into 
> mainline kernel ASAP, :). from I view point device-tree.diff is 
> very usefuly when using pagecache saving and pagecachs_addon.diff
> that's really hack for making pagecache saving safe.
> 

--- 2.6.9-lzf//arch/i386/kernel/signal.c	2004-11-28 23:17:23.000000000 +0800
+++ 2.6.9/arch/i386/kernel/signal.c	2004-11-28 23:16:59.000000000 +0800
@@ -587,6 +587,7 @@ int fastcall do_signal(struct pt_regs *r
 
 	if (current->flags & PF_FREEZE) {
 		refrigerator(0);
+		recalc_sigpending();
 		if (!signal_pending(current))
 			goto no_signal;
 	}
--- 2.6.9-lzf//arch/i386/power/swsusp.S	2004-11-26 12:32:45.000000000 +0800
+++ 2.6.9/arch/i386/power/swsusp.S	2004-11-28 23:16:59.000000000 +0800
@@ -31,24 +31,33 @@ ENTRY(swsusp_arch_resume)
 	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
-	movl	pagedir_nosave, %ebx
-	xorl	%eax, %eax
-	xorl	%edx, %edx
-	.p2align 4,,7
-
-copy_loop:
-	movl	4(%ebx,%edx),%edi
-	movl	(%ebx,%edx),%esi
-
-	movl	$1024, %ecx
-	rep
-	movsl
-
-	incl	%eax
-	addl	$16, %edx
-	cmpl	nr_copy_pages,%eax
-	jb copy_loop
-	.p2align 4,,7
+	movl  pagedir_nosave, %eax
+	test %eax, %eax
+	je   copy_loop_end
+	movl  $1024, %edx
+
+copy_loop_start:
+	movl  0xc(%eax), %ebp
+	xorl  %ebx, %ebx
+	leal  0x0(%esi),%esi
+
+copy_one_pgdir:
+	movl  0x4(%eax),%edi
+	test %edi, %edi
+	je   copy_loop_end
+
+	movl  (%eax), %esi
+	movl  %edx, %ecx
+	repz movsl %ds:(%esi),%es:(%edi)
+
+	incl  %ebx
+	addl  $0x10, %eax
+	cmpl  $0xff, %ebx
+	jbe  copy_one_pgdir
+	test %ebp, %ebp
+	movl  %ebp, %eax
+	jne  copy_loop_start
+copy_loop_end:
 
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
-- 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
