Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbUKVRPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbUKVRPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbUKVRGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:06:38 -0500
Received: from [220.248.27.114] ([220.248.27.114]:29825 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262209AbUKVQ7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:59:20 -0500
Date: Tue, 23 Nov 2004 00:58:46 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATH] swsusp update 2/3
Message-ID: <20041122165846.GB10609@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122110247.GB1063@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 12:02:47PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Yes, I'd like to get rid of "too many continuous pages" problem
> > > before. Small problem is that it needs to update x86-64 too, but I
> > I have not x86-64, so I have no chance to do it.
> 
> I have access to x86-64, so I can do it...
> 								Pavel
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--- linux-2.6.9-ppc-g4-peval/arch/i386/power/swsusp.S	2004-10-20 15:58:34.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/arch/i386/power/swsusp.S	2004-11-22 17:17:19.000000000 +0800
@@ -31,25 +31,59 @@
 	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
-	movl	pagedir_nosave, %ebx
-	xorl	%eax, %eax
-	xorl	%edx, %edx
+	mov pagedir_nosave, %edx
+	test %edx, %edx
+	mov  %edx, swsusp_pbe_pgdir
+	je   copy_loop_end
+
+copy_loop_start:
+	mov  swsusp_pbe_pgdir, %edx
+	mov  0xc(%edx), %eax
+	mov  %eax, swsusp_pbe_next
+	xor  %eax, %eax
+	mov  %eax, swsusp_pbe_nums
+
+	lea  0x0(%esi,1), %esi
+	lea  0x0(%edi,1), %edi
+	mov  0x4(%edx),%eax
+	test %eax, %eax
+	je   copy_loop_end
 	.p2align 4,,7
 
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
+copy_one_pgdir:
+	xor  %ecx, %ecx
+	lea  0x0(%esi,1), %esi
 	.p2align 4,,7
 
+copy_one_page:
+	mov  0x4(%edx), %eax
+	mov  (%edx), %edx
+	mov  (%edx,%ecx,4), %edx
+	mov  %edx,(%eax,%ecx,4)
+	inc  %ecx
+	cmp  $0x3ff, %ecx
+	ja	 copy_one_pgdir_end
+	mov  swsusp_pbe_pgdir, %edx
+	jmp  copy_one_page
+	.p2align 4,,7
+
+copy_one_pgdir_end: 
+	mov  swsusp_pbe_nums, %eax
+	mov  swsusp_pbe_pgdir, %edx
+	inc  %eax
+	mov  %eax, swsusp_pbe_nums
+
+	add  $0x10, %edx
+	cmp  $0xfe, %eax
+	mov  %edx, swsusp_pbe_pgdir
+
+	jbe  copy_one_pgdir
+	mov  swsusp_pbe_next, %eax
+	test %eax, %eax
+	mov  %eax, swsusp_pbe_pgdir
+	jne  copy_loop_start
+copy_loop_end:
+
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_ebx, %ebx

-- 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
