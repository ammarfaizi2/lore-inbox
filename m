Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVELI1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVELI1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVELI1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:27:16 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:60956
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261325AbVELI0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:26:50 -0400
Message-Id: <s2832159.057@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:27:09 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] adjust x86-64 watchdog tick calculation
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartF7D43B4D.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartF7D43B4D.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Get the x86-64 watchdog tick calculation into a state where it can also
be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
default (as is already done on i386).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/arch/x86_64/kernel/nmi.c linux-2.6.12-rc4/=
arch/x86_64/kernel/nmi.c
--- linux-2.6.12-rc4.base/arch/x86_64/kernel/nmi.c	2005-05-11 =
17:27:54.848855552 +0200
+++ linux-2.6.12-rc4/arch/x86_64/kernel/nmi.c	2005-05-11 17:50:36.2578899=
20 +0200
@@ -57,7 +57,7 @@ static unsigned int lapic_nmi_owner;
 int nmi_active;		/* oprofile uses this */
 int panic_on_timeout;
=20
-unsigned int nmi_watchdog =3D NMI_DEFAULT;
+unsigned int nmi_watchdog =3D NMI_NONE;
 static unsigned int nmi_hz =3D HZ;
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
=20
@@ -325,7 +325,7 @@ static void setup_k7_watchdog(void)
 		| K7_NMI_EVENT;
=20
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz*1000) / nmi_hz);
+	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |=3D K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -404,7 +404,7 @@ void nmi_watchdog_tick (struct pt_regs *
 		alert_counter[cpu] =3D 0;
 	}
 	if (nmi_perfctr_msr)
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		wrmsrl(nmi_perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
 }
=20
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)



--=__PartF7D43B4D.1__=
Content-Type: text/plain; name="linux-2.6.12-rc4-x86_64-watchdog.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-x86_64-watchdog.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Get the x86-64 watchdog tick calculation into a state where it can also
be used with nmi_hz other than 1Hz. Also do not turn on the watchdog by
default (as is already done on i386).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/arch/x86_64/kernel/nmi.c linux-2.6.12-rc4/arch/x86_64/kernel/nmi.c
--- linux-2.6.12-rc4.base/arch/x86_64/kernel/nmi.c	2005-05-11 17:27:54.848855552 +0200
+++ linux-2.6.12-rc4/arch/x86_64/kernel/nmi.c	2005-05-11 17:50:36.257889920 +0200
@@ -57,7 +57,7 @@ static unsigned int lapic_nmi_owner;
 int nmi_active;		/* oprofile uses this */
 int panic_on_timeout;
 
-unsigned int nmi_watchdog = NMI_DEFAULT;
+unsigned int nmi_watchdog = NMI_NONE;
 static unsigned int nmi_hz = HZ;
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 
@@ -325,7 +325,7 @@ static void setup_k7_watchdog(void)
 		| K7_NMI_EVENT;
 
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz*1000) / nmi_hz);
+	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -404,7 +404,7 @@ void nmi_watchdog_tick (struct pt_regs *
 		alert_counter[cpu] = 0;
 	}
 	if (nmi_perfctr_msr)
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		wrmsrl(nmi_perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
 }
 
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)

--=__PartF7D43B4D.1__=--
