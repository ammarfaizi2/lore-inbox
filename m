Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268407AbTBNMxD>; Fri, 14 Feb 2003 07:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268414AbTBNMxD>; Fri, 14 Feb 2003 07:53:03 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:22030 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268407AbTBNMwf>;
	Fri, 14 Feb 2003 07:52:35 -0500
Date: Fri, 14 Feb 2003 15:57:47 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: allow SMP kernel build without io_apic.c (1/13)
Message-ID: <20030214125747.GA8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

I'm here again, starting another hopeless attempt to submmit
visws subarch support for 2.5. This series of patches was tested
by me and brave people from linux-visws-devel mailing list and
our beloved workstations seem to work well under 2.5.xx.

This patch moves enable_NMI_through_LVT0() function from io_apic.c
to apic.c to allow SMP kernel build without io_apic.c included.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-apic

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/kernel/apic.c linux-2.5.60/arch/i386/kernel/apic.c
--- linux-2.5.60.vanilla/arch/i386/kernel/apic.c	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/kernel/apic.c	Thu Feb 13 20:42:02 2003
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
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/kernel/io_apic.c linux-2.5.60/arch/i386/kernel/io_apic.c
--- linux-2.5.60.vanilla/arch/i386/kernel/io_apic.c	Thu Feb 13 20:29:06 2003
+++ linux-2.5.60/arch/i386/kernel/io_apic.c	Thu Feb 13 20:42:02 2003
@@ -1807,18 +1807,6 @@
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

--OwLcNYc0lM97+oe1--
