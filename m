Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbTAaIaK>; Fri, 31 Jan 2003 03:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267727AbTAaIaJ>; Fri, 31 Jan 2003 03:30:09 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:51975 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S267725AbTAaIaI>;
	Fri, 31 Jan 2003 03:30:08 -0500
Date: Fri, 31 Jan 2003 11:34:45 +0300
To: linux-kernel@vger.kernel.org
Subject: [PATCH] enable i386 SMP kernel build without ioapic support
Message-ID: <20030131083445.GB9682@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all again,

this trivial patch (against 2.5.59) moves enable_NMI_through_LVT0()
function from i386/kernel/io_apic.c to i386/kernel/apic.c

This patch allows building SMP kernel without ioapic support included, as
needed for visws subarch.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-apic

diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/arch/i386/kernel/apic.c linux-2.5.59/arch/i386/kernel/apic.c
--- linux-2.5.59.vanilla/arch/i386/kernel/apic.c	Wed Jan 15 20:37:20 2003
+++ linux-2.5.59/arch/i386/kernel/apic.c	Sun Jan 19 18:43:10 2003
@@ -54,6 +54,18 @@
 int prof_old_multiplier[NR_CPUS] = { 1, };
 int prof_counter[NR_CPUS] = { 1, };
 
+void enable_NMI_through_LVT0 (void * dummy)
+{
+	unsigned int v, ver;
+
+	ver = apic_read(APIC_LVR);
+	ver = GET_APIC_VERSION(ver);
+	v = APIC_DM_NMI;			/* unmask and set to NMI */
+	if (!APIC_INTEGRATED(ver))		/* 82489DX */
+		v |= APIC_LVT_LEVEL_TRIGGER;
+	apic_write_around(APIC_LVT0, v);
+}
+
 int get_maxlvt(void)
 {
 	unsigned int v, ver, maxlvt;
diff -urN -X /usr/share/dontdiff linux-2.5.59.vanilla/arch/i386/kernel/io_apic.c linux-2.5.59/arch/i386/kernel/io_apic.c
--- linux-2.5.59.vanilla/arch/i386/kernel/io_apic.c	Mon Jan 27 18:24:59 2003
+++ linux-2.5.59/arch/i386/kernel/io_apic.c	Sun Jan 19 18:43:10 2003
@@ -1499,18 +1499,6 @@
 	end_lapic_irq
 };
 
-void enable_NMI_through_LVT0 (void * dummy)
-{
-	unsigned int v, ver;
-
-	ver = apic_read(APIC_LVR);
-	ver = GET_APIC_VERSION(ver);
-	v = APIC_DM_NMI;			/* unmask and set to NMI */
-	if (!APIC_INTEGRATED(ver))		/* 82489DX */
-		v |= APIC_LVT_LEVEL_TRIGGER;
-	apic_write_around(APIC_LVT0, v);
-}
-
 static void setup_nmi (void)
 {
 	/*

--lEGEL1/lMxI0MVQ2--
