Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUCILIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUCILIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:08:41 -0500
Received: from smtp01.web.de ([217.72.192.180]:58124 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261867AbUCILId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:08:33 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Philippe Elie <phil.el@wanadoo.fr>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Date: Tue, 9 Mar 2004 12:08:17 +0100
User-Agent: KMail/1.5.4
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
References: <200403090014.03282.thomas.schlichter@web.de> <20040308162947.4d0b831a.akpm@osdl.org> <20040309070127.GA2958@zaniah>
In-Reply-To: <20040309070127.GA2958@zaniah>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kWaTA5KC8zlPk9W"
Message-Id: <200403091208.20556.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_kWaTA5KC8zlPk9W
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag, 9. M=E4rz 2004 08:01 schrieb Philippe Elie:
> On Mon, 08 Mar 2004 at 16:29 +0000, Andrew Morton wrote:

~~ snip ~~

> > Rename Thomas's script to crappy-code-detector.sh and its hit rate goes
> > to 100% ;)
>
> Was this patch so crappy ? http://tinyurl.com/2jbe4 ,
>
> -				check_nmi_watchdog();
> +				if (check_nmi_watchdog() < 0);
> +					timer_ack =3D !cpu_has_tsc

Well, exactly this code made me look for other possible problems... ;-)
As I wrote a few days ago I have problems with that ChangeSet,
  (http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107840458123059&w=3D2)
so I did examine it closer.

My results are:
1. The semicolons behind the if()'s cannot be there intentionally.
2. To fix my problem, timer_ack must be set to 1 for my (integrated) APIC, =
and=20
as my CPU has a TSC, this cannot be correct for me:
=2D	timer_ack =3D 1;
+	if (nmi_watchdog =3D=3D NMI_IO_APIC && !APIC_INTEGRATED(ver))
+		timer_ack =3D 1;
+	else
+		timer_ack =3D !cpu_has_tsc;

I changed that if(...) to
	if (nmi_watchdog =3D=3D NMI_IO_APIC || APIC_INTEGRATED(ver))
which works fine for me here, but I am not 100% sure if this is what the=20
author of the original patch ment and if it still fixes the original=20
problem...

The patch which makes these changes is attached. Perhaps someone else wants=
 to=20
test it, too...

   Thomas Schlichter

P.S.: I tested it with an AMD Athlon 3000+ on a board with a VIA KT400 chip=
set=20
and enabled ACPI and IO-APIC.

--Boundary-00=_kWaTA5KC8zlPk9W
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

--Boundary-00=_kWaTA5KC8zlPk9W--

