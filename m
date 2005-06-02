Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVFBCt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVFBCt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 22:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFBCt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 22:49:28 -0400
Received: from fmr18.intel.com ([134.134.136.17]:64910 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261575AbVFBCtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 22:49:23 -0400
Subject: [patch]variable overflow after hunderds round of hotplug CPU
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 10:56:36 +0800
Message-Id: <1117680997.7191.8.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm doing the cpu hotplug stress test and found a variable ('ready') is
overflow after several hundreds rounds of cpu hotplug. Here is a fix.

Signed-off-by: Shaohua Li<shaohua.li@intel.com>

--- a/arch/i386/kernel/head.S	2005-05-26 09:19:44.000000000 +0800
+++ b/arch/i386/kernel/head.S	2005-06-02 10:11:28.447685576 +0800
@@ -299,7 +299,6 @@ is386:	movl $2,%ecx		# set MP
 	movl %eax,%cr0
 
 	call check_x87
-	incb ready
 	lgdt cpu_gdt_descr
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
@@ -316,8 +315,9 @@ is386:	movl $2,%ecx		# set MP
 	lldt %ax
 	cld			# gcc2 wants the direction flag cleared at all times
 #ifdef CONFIG_SMP
-	movb ready, %cl	
-	cmpb $1,%cl
+	movb ready, %cl
+	movb $1, ready
+	cmpb $0,%cl
 	je 1f			# the first CPU calls start_kernel
 				# all other CPUs call initialize_secondary
 	call initialize_secondary


