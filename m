Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284398AbRLRR4V>; Tue, 18 Dec 2001 12:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284386AbRLRR4L>; Tue, 18 Dec 2001 12:56:11 -0500
Received: from goliath.siemens.de ([194.138.37.131]:15284 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S284361AbRLRRz4>; Tue, 18 Dec 2001 12:55:56 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: Dave Jones <davej@suse.de>
Cc: Mandrake kernel list <kernel@mandrakesoft.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>,
        Cooker list <cooker@linux-mandrake.com>
Subject: PATCH: apm.c - detection of brokern APM Idle call implementation
In-Reply-To: <Pine.LNX.4.33.0112170431060.11563-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112170431060.11563-100000@Appserv.suse.de>
Content-Type: multipart/mixed; boundary="=-oFwIQ6Nfk2KNFUROT3Fn"
Message-Id: <1008698004.2273.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Date: 18 Dec 2001 20:54:47 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oFwIQ6Nfk2KNFUROT3Fn
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: quoted-printable

On =F0=CE=C4, 2001-12-17 at 06:34, Dave Jones wrote:
> On 16 Dec 2001, Borsenkow Andrej wrote:
>=20
> > I thought once about run-time detection - if BIOS reports that Idle =
does
> > not slow down CPU try Idle call once and compare jiffies (probably
> > repeat several times to be sure). Is it sensible?
>=20
> A far simpler way would be to add DMI blacklist entries for the =
BIOSes
> that don't do this, although this assumes the problem machine has a =
DMI
> compliant BIOS.
>=20

Well, the following three-liners (+ comments) seems to do it. It checks
if clock was advanced after return from APM Idle - if not we assume =
BIOS
did not halt CPU and do it ourselves. The addidional condition &&
!current->need_resched is for the case when BIOS did halt CPU and
non-clock interrupt happened that waked up somebody else. But may be I
am just plain paranoid. The code has no impact for "BIOS slows CPU"
case.

It works here for broken BIOS. I appreciate if people with good BIOS
test it.=20

-andrej


--=-oFwIQ6Nfk2KNFUROT3Fn
Content-Disposition: attachment; filename=apm-idle-2.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-diff; charset=KOI8-R

--- apm.c.bor	Tue Dec 18 20:30:08 2001
+++ apm.c	Tue Dec 18 20:42:24 2001
@@ -1381,13 +1381,18 @@
 		 */
 		if (apm_do_idle() !=3D -1) {
 			unsigned long start =3D jiffies;
+			unsigned long before;
 			while ((!exit_kapmd) && system_idle()) {
-				if (apm_do_idle()) {
+				before =3D jiffies;
+				if (apm_do_idle() || (jiffies =3D=3D before && =
!current->need_resched)) {
 					set_current_state(TASK_INTERRUPTIBLE);
 					/* APM needs us to snooze .. either
 					   the BIOS call failed (-1) or it
 					   slowed the clock (1). We sleep
-					   until it talks to us again */
+					   until it talks to us again.
+					   If clock did not advance CPU was
+					   not halted by BIOS so we do it
+					   now*/
 					schedule_timeout(1);
 				}
 				if ((jiffies - start) > APM_CHECK_TIMEOUT) {

--=-oFwIQ6Nfk2KNFUROT3Fn--
