Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbUKXICY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUKXICY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbUKXICY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:02:24 -0500
Received: from [220.248.27.114] ([220.248.27.114]:40370 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262316AbUKXICS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:02:18 -0500
Date: Wed, 24 Nov 2004 16:03:38 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATH] 11-24 swsusp update 2/3
Message-ID: <20041124080338.GB3455@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <200411221254.40732.rjw@sisk.pl> <1101160249.7962.52.camel@desktop.cunninghams> <20041123215402.GE25926@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123215402.GE25926@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--i386.diff--

--- linux-2.6.9-ppc-g4-peval/arch/i386/power/swsusp.S	2004-10-20 15:58:34.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/arch/i386/power/swsusp.S	2004-11-24 14:08:31.000000000 +0800
@@ -31,24 +31,33 @@
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
