Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266722AbUFYMAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266722AbUFYMAR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUFYMAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:00:17 -0400
Received: from gprs214-83.eurotel.cz ([160.218.214.83]:14976 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266725AbUFYL7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 07:59:55 -0400
Date: Fri, 25 Jun 2004 13:59:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp.S: meaningfull assembly labels
Message-ID: <20040625115936.GA2849@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This introduces meaningfull labels instead of .L1234, meaning code is
readable, kills alignment where unneccessary, and kills TLB flush that
was only pure paranoia (and slows it down a lot on emulated
systems). Please apply,

								Pavel

--- linux-cvs//arch/i386/power/swsusp.S	2004-05-25 17:41:18.000000000 +0200
+++ linux/arch/i386/power/swsusp.S	2004-06-24 14:39:01.000000000 +0200
@@ -18,7 +18,7 @@
 ENTRY(do_magic)
 	pushl %ebx
 	cmpl $0,8(%esp)
-	jne .L1450
+	jne resume
 	call do_magic_suspend_1
 	call save_processor_state
 
@@ -33,21 +33,21 @@
 	pushfl ; popl saved_context_eflags
 
 	call do_magic_suspend_2
-	jmp .L1449
-	.p2align 4,,7
-.L1450:
+	popl %ebx
+	ret
+
+resume:
 	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
 	call do_magic_resume_1
 	movl $0,loop
 	cmpl $0,nr_copy_pages
-	je .L1453
-	.p2align 4,,7
-.L1455:
+	je copy_done
+copy_loop:
 	movl $0,loop2
 	.p2align 4,,7
-.L1459:
+copy_one_page:
 	movl pagedir_nosave,%ecx
 	movl loop,%eax
 	movl loop2,%edx
@@ -56,23 +56,21 @@
 	movl (%ecx,%eax),%eax
 	movb (%edx,%eax),%al
 	movb %al,(%edx,%ebx)
-	movl %cr3, %eax;              
-	movl %eax, %cr3;  # flush TLB 
 
 	movl loop2,%eax
 	leal 1(%eax),%edx
 	movl %edx,loop2
 	movl %edx,%eax
 	cmpl $4095,%eax
-	jbe .L1459
+	jbe copy_one_page
 	movl loop,%eax
 	leal 1(%eax),%edx
 	movl %edx,loop
 	movl %edx,%eax
 	cmpl nr_copy_pages,%eax
-	jb .L1455
-	.p2align 4,,7
-.L1453:
+	jb copy_loop
+
+copy_done:
 	movl $__USER_DS,%eax
 
 	movw %ax, %ds
@@ -88,7 +86,6 @@
 	call restore_processor_state
 	pushl saved_context_eflags ; popfl
 	call do_magic_resume_2
-.L1449:
 	popl %ebx
 	ret
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
