Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUBLVoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUBLVob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:44:31 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.27]:20411 "EHLO
	mwinf0402.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266617AbUBLVmM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:42:12 -0500
Date: Thu, 12 Feb 2004 22:41:52 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Will Cohen <wcohen@redhat.com>,
       John Levon <levon@movementarian.org>
Subject: [PATCH] oprofile add Pentium Mobile support
Message-ID: <20040212224152.GE316@zaniah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, all

apply cleanly to 2.6.3-rc2


From: Will Cohen <wcohen@redhat.com>

Add oprofile support for Pentium Mobile (P6 core). Pentium Mobile needs
to unmask LVPTC vector, since it doesn't hurt other P6 core based cpus
we do it unconditionally for all these.

This patch require userspace tools >= 0.8 (only in sourceforge cvs currently)


regards,
Phil


diff -uprN -X /home/phe/dontdiff-2.6.0 linux-temp/arch/i386/oprofile/nmi_int.c linux-2.5/arch/i386/oprofile/nmi_int.c
--- linux-temp/arch/i386/oprofile/nmi_int.c	2004-02-12 22:00:59.000000000 +0000
+++ linux-2.5/arch/i386/oprofile/nmi_int.c	2004-02-12 22:27:31.000000000 +0000
@@ -335,7 +335,9 @@ static int __init ppro_init(void)
 	if (cpu_model > 0xd)
 		return 0;
 
-	if (cpu_model > 5) {
+	if (cpu_model == 9) {
+		nmi_ops.cpu_type = "i386/p6_mobile";
+	} else if (cpu_model > 5) {
 		nmi_ops.cpu_type = "i386/piii";
 	} else if (cpu_model > 2) {
 		nmi_ops.cpu_type = "i386/pii";
diff -uprN -X /home/phe/dontdiff-2.6.0 linux-temp/arch/i386/oprofile/op_model_ppro.c linux-2.5/arch/i386/oprofile/op_model_ppro.c
--- linux-temp/arch/i386/oprofile/op_model_ppro.c	2004-02-12 22:00:59.000000000 +0000
+++ linux-2.5/arch/i386/oprofile/op_model_ppro.c	2004-02-12 22:27:31.000000000 +0000
@@ -13,6 +13,7 @@
 #include <linux/oprofile.h>
 #include <asm/ptrace.h>
 #include <asm/msr.h>
+#include <asm/apic.h>
  
 #include "op_x86_model.h"
 #include "op_counter.h"
@@ -101,6 +102,10 @@ static int ppro_check_ctrs(unsigned int 
 		}
 	}
 
+	/* Only P6 based Pentium M need to re-unmask the apic vector but it
+	 * doesn't hurt other P6 variant */
+	apic_write(APIC_LVTPC, apic_read(APIC_LVTPC) & ~APIC_LVT_MASKED);
+
 	/* We can't work out if we really handled an interrupt. We
 	 * might have caught a *second* counter just after overflowing
 	 * the interrupt for this counter then arrives
