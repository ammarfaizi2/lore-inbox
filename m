Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVDLVCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVDLVCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVDLUnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:43:20 -0400
Received: from mail.aknet.ru ([217.67.122.194]:60424 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262175AbVDLTrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:47:17 -0400
Message-ID: <425C25D3.7010703@aknet.ru>
Date: Tue, 12 Apr 2005 23:47:31 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: petkov@uni-muenster.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: [patch 2/3]: entry.S trap return fixes
References: <20050411012532.58593bc1.akpm@osdl.org>	<1113209793l.7664l.1l@werewolf.able.es>	<20050411024322.786b83de.akpm@osdl.org>	<200504112359.40487.petkov@uni-muenster.de>	<20050411152243.22835d96.akpm@osdl.org>	<425B4C92.1070507@aknet.ru> <20050411212712.0dbd821d.akpm@osdl.org>
In-Reply-To: <20050411212712.0dbd821d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040201060302050803010702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040201060302050803010702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

do_debug() returns void, do_int3() too when
!CONFIG_KPROBES.
This patch fixes the CONFIG_KPROBES variant
of do_int3() to return void too and adjusts
the entry.S accordingly.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------040201060302050803010702
Content-Type: text/x-patch;
 name="kgdbfix1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kgdbfix1.diff"

--- linux/arch/i386/kernel/entry.S.old	2005-04-12 09:47:38.000000000 +0400
+++ linux/arch/i386/kernel/entry.S	2005-04-12 11:13:03.000000000 +0400
@@ -550,8 +550,6 @@
 	xorl %edx,%edx			# error code 0
 	movl %esp,%eax			# pt_regs pointer
 	call do_debug
-	testl %eax,%eax
-	jnz restore_all
 	jmp ret_from_exception
 
 /*
@@ -632,8 +630,6 @@
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_int3
-	testl %eax,%eax
-	jnz restore_all
 	jmp ret_from_exception
 
 ENTRY(overflow)
--- linux/arch/i386/kernel/traps.c.old	2005-04-12 09:47:38.000000000 +0400
+++ linux/arch/i386/kernel/traps.c	2005-04-12 10:59:54.000000000 +0400
@@ -695,16 +695,15 @@
 }
 
 #ifdef CONFIG_KPROBES
-fastcall int do_int3(struct pt_regs *regs, long error_code)
+fastcall void do_int3(struct pt_regs *regs, long error_code)
 {
 	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
 			== NOTIFY_STOP)
-		return 1;
+		return;
 	/* This is an interrupt gate, because kprobes wants interrupts
 	disabled.  Normal trap handlers don't. */
 	restore_interrupts(regs);
 	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
-	return 0;
 }
 #endif
 

--------------040201060302050803010702--
