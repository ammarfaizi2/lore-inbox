Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbUCKARt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbUCKARs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:17:48 -0500
Received: from smtp02.web.de ([217.72.192.151]:7174 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262899AbUCKAQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:16:51 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: ACPI PM Timer vs. C1 halt issue
Date: Thu, 11 Mar 2004 01:15:34 +0100
User-Agent: KMail/1.5.4
Cc: Len Brown <len.brown@intel.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Dominik Brodowski <linux@brodo.de>
References: <404E38B7.5080008@gmx.de> <1078956711.2557.72.camel@dhcppc4> <404F9B5B.6010207@gmx.de>
In-Reply-To: <404F9B5B.6010207@gmx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_o+6TAqhw4WLGQPo"
Message-Id: <200403110115.36257.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_o+6TAqhw4WLGQPo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

As your problem may be similar to mine,
(http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107840458123059&w=3D2)
you may try to boot with ACPI PM timer enabled but with the additional boot=
=20
option 'noapic'. If this also cools down your processor, you maybe should t=
ry=20
the attached patch....

   Thomas

Am Mittwoch, 10. M=E4rz 2004 23:48 schrieb Prakash K. Cheemplavam:
> [snip]
>
> > That said, I don't know what caused the regression you describe.
> > Perhaps you can clarfiy the minimal changes necessary to switch between
> > correct and incorrect behaviour?
>
> Simply use tsc as timesource instead of PM Timer (ie not compiling in
> the latter) and all is cool again (now idle temp is as low as 40=B0C!).
> ACPI as such is included. I attached my current config. I guess one
> could also use a kernel boot parameter to switch between those timers.
>
> I don't know whether it is actual a problem with C1 or whatever. I just
> described my assumption I made. If I disable CPU disconnect, my CPU runs
> hot again even with tsc timer. With ACPI PM timer disconnect makes no
> difference (hot everytime...).
>
> Cheers,
>
> Prakash

--Boundary-00=_o+6TAqhw4WLGQPo
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-8259-timer-ack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fix-8259-timer-ack.diff"

--- linux-2.6.4-rc2-mm1/arch/i386/kernel/io_apic.c.orig	2004-03-08 16:29:14.000000000 +0100
+++ linux-2.6.4-rc2-mm1/arch/i386/kernel/io_apic.c	2004-03-08 17:26:40.000000000 +0100
@@ -2181,7 +2181,7 @@ static inline void check_timer(void)
 	 */
 	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
 	init_8259A(1);
-	if (nmi_watchdog == NMI_IO_APIC && !APIC_INTEGRATED(ver))
+	if (nmi_watchdog == NMI_IO_APIC || APIC_INTEGRATED(ver))
 		timer_ack = 1;
 	else
 		timer_ack = !cpu_has_tsc;
@@ -2202,7 +2202,7 @@ static inline void check_timer(void)
 				disable_8259A_irq(0);
 				setup_nmi();
 				enable_8259A_irq(0);
-				if (check_nmi_watchdog() < 0);
+				if (check_nmi_watchdog() < 0)
 					timer_ack = !cpu_has_tsc;
 			}
 			return;
@@ -2226,7 +2226,7 @@ static inline void check_timer(void)
 				add_pin_to_irq(0, 0, pin2);
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
-				if (check_nmi_watchdog() < 0);
+				if (check_nmi_watchdog() < 0)
 					timer_ack = !cpu_has_tsc;
 			}
 			return;

--Boundary-00=_o+6TAqhw4WLGQPo--

