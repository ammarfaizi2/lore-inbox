Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUH0Qtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUH0Qtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUH0Qtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:49:49 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:62725 "EHLO
	mwinf0401.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266598AbUH0Qs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:48:29 -0400
Date: Fri, 27 Aug 2004 18:52:35 +0200
From: Philippe Elie <phil.el@wanadoo.fr>
To: Zarakin <zarakin@hotpop.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: nmi_watchdog=2 and oprofile - Oops with 2.6.8
Message-ID: <20040827165235.GA561@zaniah>
References: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net> <20040825160107.GA562@zaniah> <005401c48b1b$fae38890$6401a8c0@novustelecom.net> <20040826170214.GA580@zaniah> <00f801c48bfa$f5ccefb0$6401a8c0@novustelecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f801c48bfa$f5ccefb0$6401a8c0@novustelecom.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 at 22:59 +0000, Zarakin wrote:

> Oprofile oops'd this time at p4_setup_ctrs - there seems to be one more loop
> that tries to
> access MSR_IQ_ESCR0/1. I did a small change myself and it seems to work
> fine, on both
> SMP&HT and UP kernels. I was able to start oprofile and get profile sample
> data.

Thanks, I missed this one.

I redo the diff, mangled space in last patch, I added the
nmi.c:clear_msr_range() fix. It must go in 2.6.9 imho, please
Andrew apply.

-- phe

--- linux-2.5/arch/i386/kernel/nmi.c~	2004-06-15 10:52:00.000000000 +0200
+++ linux-2.5/arch/i386/kernel/nmi.c	2004-08-25 17:33:45.000000000 +0200
@@ -376,7 +376,13 @@
 		clear_msr_range(0x3F1, 2);
 	/* MSR 0x3F0 seems to have a default value of 0xFC00, but current
 	   docs doesn't fully define it, so leave it alone for now. */
-	clear_msr_range(0x3A0, 31);
+	if (boot_cpu_data.x86_model >= 0x3) {
+		/* MSR_P4_IQ_ESCR0/1 (0x3ba/0x3bb) removed */
+		clear_msr_range(0x3A0, 26);
+		clear_msr_range(0x3BC, 3);
+	} else {
+		clear_msr_range(0x3A0, 31);
+	}
 	clear_msr_range(0x3C0, 6);
 	clear_msr_range(0x3C8, 6);
 	clear_msr_range(0x3E0, 2);
--- linux-2.5/arch/i386/oprofile/op_model_p4.c.old	2004-08-25 20:00:56.000000000 +0200
+++ linux-2.5/arch/i386/oprofile/op_model_p4.c	2004-08-27 18:35:16.000000000 +0200
@@ -419,9 +419,28 @@
 		msrs->controls[i].addr = addr;
 	}
 	
-	/* 43 ESCR registers in three discontiguous group */
+	/* 43 ESCR registers in three or four discontiguous group */
 	for (addr = MSR_P4_BSU_ESCR0 + stag;
-	     addr <= MSR_P4_SSU_ESCR0; ++i, addr += addr_increment()) { 
+	     addr < MSR_P4_IQ_ESCR0; ++i, addr += addr_increment()) {
+		msrs->controls[i].addr = addr;
+	}
+
+	/* no IQ_ESCR0/1 on some models, we save a seconde time BSU_ESCR0/1
+	 * to avoid special case in nmi_{save|restore}_registers() */
+	if (boot_cpu_data.x86_model >= 0x3) {
+		for (addr = MSR_P4_BSU_ESCR0 + stag;
+		     addr <= MSR_P4_BSU_ESCR1; ++i, addr += addr_increment()) {
+			msrs->controls[i].addr = addr;
+		}
+	} else {
+		for (addr = MSR_P4_IQ_ESCR0 + stag;
+		     addr <= MSR_P4_IQ_ESCR1; ++i, addr += addr_increment()) {
+			msrs->controls[i].addr = addr;
+		}
+	}
+
+	for (addr = MSR_P4_RAT_ESCR0 + stag;
+	     addr <= MSR_P4_SSU_ESCR0; ++i, addr += addr_increment()) {
 		msrs->controls[i].addr = addr;
 	}
 	
@@ -553,7 +572,18 @@
 
 	/* clear all escrs (including those outside our concern) */
 	for (addr = MSR_P4_BSU_ESCR0 + stag;
-	     addr <= MSR_P4_SSU_ESCR0; addr += addr_increment()) { 
+	     addr <  MSR_P4_IQ_ESCR0; addr += addr_increment()) { 
+		wrmsr(addr, 0, 0);
+	}
+
+	/* On older models clear also MSR_P4_IQ_ESCR0/1 */
+	if (boot_cpu_data.x86_model < 0x3) {
+		wrmsr(MSR_P4_IQ_ESCR0, 0, 0);
+		wrmsr(MSR_P4_IQ_ESCR1, 0, 0);
+	}
+
+	for (addr = MSR_P4_RAT_ESCR0 + stag;
+	     addr <= MSR_P4_SSU_ESCR0; ++i, addr += addr_increment()) {
 		wrmsr(addr, 0, 0);
 	}
 	
