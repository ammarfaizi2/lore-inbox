Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUCDMrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUCDMrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:47:46 -0500
Received: from smtp03.web.de ([217.72.192.158]:27147 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261821AbUCDMrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:47:42 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: linux-kernel@vger.kernel.org
Subject: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Date: Thu, 4 Mar 2004 13:47:35 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rVyRAGOsoPd4Tso"
Message-Id: <200403041347.39756.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_rVyRAGOsoPd4Tso
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

a few days ago I noticed that my Athlon 3000+ was relatively hot (49C) 
although it was completely idle. At that time I was running 2.6.3-mm3 with 
ACPI and IOAPIC-support enabled.

As I tried 2.6.3, the idle temperature was at normal 39C. So I did do some 
binary search with the -bk patches and found the patch that causes the high 
idle temperature. It is ChangeSet@1.1626 aka 8259-timer-ack-fix.patch.

A patch to revert that ChangeSet for 2.6.4-rc1-mm2 is attached.

Best regards
   Thomas Schlichter

P.S.: The high idle temperature only shows if the  IOAPIC is used.
P.P.S: I already sent this mail last saturday, but as it seems to have never 
reached LKML I send it again. I'm sorry if you got it twice!

--Boundary-00=_rVyRAGOsoPd4Tso
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="revert-8259-timer-ack-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="revert-8259-timer-ack-fix.patch"

=2D-- linux-2.6.4-rc1-mm2/arch/i386/kernel/io_apic.c.orig	2004-03-03 14:56:=
10.000000000 +0100
+++ linux-2.6.4-rc1-mm2/arch/i386/kernel/io_apic.c	2004-03-03 17:35:03.0000=
00000 +0100
@@ -2157,10 +2157,6 @@ static inline void check_timer(void)
 {
 	int pin1, pin2;
 	int vector;
=2D	unsigned int ver;
=2D
=2D	ver =3D apic_read(APIC_LVR);
=2D	ver =3D GET_APIC_VERSION(ver);
=20
 	/*
 	 * get/set the timer IRQ vector:
@@ -2174,17 +2170,11 @@ static inline void check_timer(void)
 	 * mode for the 8259A whenever interrupts are routed
 	 * through I/O APICs.  Also IRQ0 has to be enabled in
 	 * the 8259A which implies the virtual wire has to be
=2D	 * disabled in the local APIC.  Finally timer interrupts
=2D	 * need to be acknowledged manually in the 8259A for
=2D	 * do_slow_timeoffset() and for the i82489DX when using
=2D	 * the NMI watchdog.
+	 * disabled in the local APIC.
 	 */
 	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
 	init_8259A(1);
=2D	if (nmi_watchdog =3D=3D NMI_IO_APIC && !APIC_INTEGRATED(ver))
=2D		timer_ack =3D 1;
=2D	else
=2D		timer_ack =3D !cpu_has_tsc;
+	timer_ack =3D 1;
 	enable_8259A_irq(0);
=20
 	pin1 =3D find_isa_irq_pin(0, mp_INT);
@@ -2202,8 +2192,7 @@ static inline void check_timer(void)
 				disable_8259A_irq(0);
 				setup_nmi();
 				enable_8259A_irq(0);
=2D				if (check_nmi_watchdog() < 0);
=2D					timer_ack =3D !cpu_has_tsc;
+				check_nmi_watchdog();
 			}
 			return;
 		}
@@ -2226,8 +2215,7 @@ static inline void check_timer(void)
 				add_pin_to_irq(0, 0, pin2);
 			if (nmi_watchdog =3D=3D NMI_IO_APIC) {
 				setup_nmi();
=2D				if (check_nmi_watchdog() < 0);
=2D					timer_ack =3D !cpu_has_tsc;
+				check_nmi_watchdog();
 			}
 			return;
 		}

--Boundary-00=_rVyRAGOsoPd4Tso--

