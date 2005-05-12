Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVELIRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVELIRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVELIRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:17:03 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:27419
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261327AbVELIQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:16:09 -0400
Message-Id: <s2831ed8.056@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:16:31 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] adjust i386 watchdog tick calculation
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part7655BACF.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part7655BACF.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Get the i386 watchdog tick calculation into a state where it can also
be used on CPUs with frequencies beyond 4GHz, and it consolidates the
calculation into a single place (for potential furture adjustments).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/nmi.c linux-2.6.12-rc4/ar=
ch/i386/kernel/nmi.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/nmi.c	2005-05-11 =
17:27:52.239252272 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/nmi.c	2005-05-11 17:50:36.2498911=
36 +0200
@@ -28,8 +28,7 @@
 #include <linux/sysctl.h>
=20
 #include <asm/smp.h>
-#include <asm/mtrr.h>
-#include <asm/mpspec.h>
+#include <asm/div64.h>
 #include <asm/nmi.h>
=20
 #include "mach_traps.h"
@@ -324,6 +323,16 @@ static void clear_msr_range(unsigned int
 		wrmsr(base+i, 0, 0);
 }
=20
+static inline void write_watchdog_counter(const char *descr)
+{
+	u64 count =3D (u64)cpu_khz * 1000;
+
+	do_div(count, nmi_hz);
+	if(descr)
+		Dprintk("setting %s to -0x%08Lx\n", descr, count);
+	wrmsrl(nmi_perfctr_msr, 0 - count);
+}
+
 static void setup_k7_watchdog(void)
 {
 	unsigned int evntsel;
@@ -339,8 +348,7 @@ static void setup_k7_watchdog(void)
 		| K7_NMI_EVENT;
=20
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	write_watchdog_counter("K7_PERFCTR0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |=3D K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -361,8 +369,7 @@ static void setup_p6_watchdog(void)
 		| P6_NMI_EVENT;
=20
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
-	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
+	write_watchdog_counter("P6_PERFCTR0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |=3D P6_EVNTSEL0_ENABLE;
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
@@ -402,8 +409,7 @@ static int setup_p4_watchdog(void)
=20
 	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
 	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
-	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*100=
0));
-	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
+	write_watchdog_counter("P4_IQ_COUNTER0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 	return 1;
@@ -518,7 +524,7 @@ void nmi_watchdog_tick (struct pt_regs *
 			 * other P6 variant */
 			apic_write(APIC_LVTPC, APIC_DM_NMI);
 		}
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		write_watchdog_counter(NULL);
 	}
 }
=20



--=__Part7655BACF.0__=
Content-Type: text/plain; name="linux-2.6.12-rc4-i386-watchdog.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-i386-watchdog.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Get the i386 watchdog tick calculation into a state where it can also
be used on CPUs with frequencies beyond 4GHz, and it consolidates the
calculation into a single place (for potential furture adjustments).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/arch/i386/kernel/nmi.c linux-2.6.12-rc4/arch/i386/kernel/nmi.c
--- linux-2.6.12-rc4.base/arch/i386/kernel/nmi.c	2005-05-11 17:27:52.239252272 +0200
+++ linux-2.6.12-rc4/arch/i386/kernel/nmi.c	2005-05-11 17:50:36.249891136 +0200
@@ -28,8 +28,7 @@
 #include <linux/sysctl.h>
 
 #include <asm/smp.h>
-#include <asm/mtrr.h>
-#include <asm/mpspec.h>
+#include <asm/div64.h>
 #include <asm/nmi.h>
 
 #include "mach_traps.h"
@@ -324,6 +323,16 @@ static void clear_msr_range(unsigned int
 		wrmsr(base+i, 0, 0);
 }
 
+static inline void write_watchdog_counter(const char *descr)
+{
+	u64 count = (u64)cpu_khz * 1000;
+
+	do_div(count, nmi_hz);
+	if(descr)
+		Dprintk("setting %s to -0x%08Lx\n", descr, count);
+	wrmsrl(nmi_perfctr_msr, 0 - count);
+}
+
 static void setup_k7_watchdog(void)
 {
 	unsigned int evntsel;
@@ -339,8 +348,7 @@ static void setup_k7_watchdog(void)
 		| K7_NMI_EVENT;
 
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	write_watchdog_counter("K7_PERFCTR0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -361,8 +369,7 @@ static void setup_p6_watchdog(void)
 		| P6_NMI_EVENT;
 
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
-	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
+	write_watchdog_counter("P6_PERFCTR0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= P6_EVNTSEL0_ENABLE;
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
@@ -402,8 +409,7 @@ static int setup_p4_watchdog(void)
 
 	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
 	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
-	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
+	write_watchdog_counter("P4_IQ_COUNTER0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 	return 1;
@@ -518,7 +524,7 @@ void nmi_watchdog_tick (struct pt_regs *
 			 * other P6 variant */
 			apic_write(APIC_LVTPC, APIC_DM_NMI);
 		}
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		write_watchdog_counter(NULL);
 	}
 }
 

--=__Part7655BACF.0__=--
