Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTDTQzI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTDTQzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:55:08 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:17813 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S263632AbTDTQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:55:05 -0400
Date: Sun, 20 Apr 2003 13:03:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH][2.5.68] 16-byte align x86 IRQ entry points
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200304201306_MC3-1-3537-116@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 How can I further test this patch?  (It boots...)

 It should be harmless; at worst it will add about 1K to an
SMP or IOAPIC kernel.

 If it works it should reduce interrupt latency.



--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@ -382,29 +382,31 @
 ENTRY(interrupt)
 .text
 
-vector=0
+	.align 16,0x90
 ENTRY(irq_entries_start)
+vector=0
 .rept NR_IRQS
-	ALIGN
 1:	pushl $vector-256
 	jmp common_interrupt
+	.align 16,0x90
 .data
 	.long 1b
 .text
 vector=vector+1
 .endr
 
-	ALIGN
+/* aligned 16 */
 common_interrupt:
 	SAVE_ALL
 	call do_IRQ
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
+	.align 16,0x90;			\
 ENTRY(name)				\
 	pushl $nr-256;			\
 	SAVE_ALL			\
-	call smp_/**/name;	\
+	call smp_/**/name;		\
 	jmp ret_from_intr;
 
 /* The include is where all of the SMP etc. interrupts come from */


------
 Chuck
