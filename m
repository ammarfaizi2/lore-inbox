Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWGRS1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWGRS1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWGRS1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:27:38 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:63913 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932198AbWGRS1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:27:38 -0400
Date: Tue, 18 Jul 2006 14:22:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: show_registers(): try harder to print failing
  code
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Message-ID: <200607181425_MC3-1-C556-424A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

show_registers() tries to dump failing code starting 43 bytes
before the offending instruction, but this address can be bad,
for example in a device driver where the failing instruction is
less than 43 bytes from the start of the driver's code.  When that
happens, try to dump code starting at the failing instruction
instead of printing no code at all.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc1-32.orig/arch/i386/kernel/traps.c
+++ 2.6.18-rc1-32/arch/i386/kernel/traps.c
@@ -307,6 +307,8 @@ void show_registers(struct pt_regs *regs
 	 */
 	if (in_kernel) {
 		u8 __user *eip;
+		int code_bytes = 64;
+		unsigned char c;
 
 		printk("\n" KERN_EMERG "Stack: ");
 		show_stack_log_lvl(NULL, regs, (unsigned long *)esp, KERN_EMERG);
@@ -314,9 +316,12 @@ void show_registers(struct pt_regs *regs
 		printk(KERN_EMERG "Code: ");
 
 		eip = (u8 __user *)regs->eip - 43;
-		for (i = 0; i < 64; i++, eip++) {
-			unsigned char c;
-
+		if (eip < (u8 __user *)PAGE_OFFSET || __get_user(c, eip)) {
+			/* try starting at EIP */
+			eip = (u8 __user *)regs->eip;
+			code_bytes = 32;
+		}
+		for (i = 0; i < code_bytes; i++, eip++) {
 			if (eip < (u8 __user *)PAGE_OFFSET || __get_user(c, eip)) {
 				printk(" Bad EIP value.");
 				break;
-- 
Chuck
