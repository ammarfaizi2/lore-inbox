Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265593AbSKAEBN>; Thu, 31 Oct 2002 23:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265596AbSKAEBM>; Thu, 31 Oct 2002 23:01:12 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:46608 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265593AbSKAEBI>; Thu, 31 Oct 2002 23:01:08 -0500
Date: Fri, 1 Nov 2002 04:07:29 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: [PATCH] fix APIC errors on oprofile restore
Message-ID: <20021101040729.GB5269@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *187T5l-000LyG-00*WqMwNrIdDt6* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


See comment. Please apply. By Philippe Elie

tested on two UP boxen and my SMP box

thanks
john


diff -Naur -X dontdiff linux-linus/arch/i386/oprofile/nmi_int.c linux/arch/i386/oprofile/nmi_int.c
--- linux-linus/arch/i386/oprofile/nmi_int.c	Wed Oct 30 03:28:21 2002
+++ linux/arch/i386/oprofile/nmi_int.c	Wed Oct 30 03:51:58 2002
@@ -135,9 +135,19 @@
 
 static void nmi_cpu_shutdown(void * dummy)
 {
+	unsigned int v;
 	int cpu = smp_processor_id();
 	struct op_msrs * msrs = &cpu_msrs[cpu];
+ 
+	/* restoring APIC_LVTPC can trigger an apic error because the delivery
+	 * mode and vector nr combination can be illegal. That's by design: on
+	 * power on apic lvt contain a zero vector nr which are legal only for
+	 * NMI delivery mode. So inhibit apic err before restoring lvtpc
+	 */
+	v = apic_read(APIC_LVTERR);
+	apic_write(APIC_LVTERR, v | APIC_LVT_MASKED);
 	apic_write(APIC_LVTPC, saved_lvtpc[cpu]);
+	apic_write(APIC_LVTERR, v);
 	nmi_restore_registers(msrs);
 }
 
