Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUIETnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUIETnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 15:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUIETnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 15:43:47 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:44396 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267165AbUIETmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 15:42:25 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Oops and panic while unloading holder of pm_idle
Date: Sun, 5 Sep 2004 18:02:03 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com
References: <200408171728.06262.blaisorblade_spam@yahoo.it> <200408301309.54465.blaisorblade_spam@yahoo.it> <Pine.LNX.4.58.0408301743190.21529@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0408301743190.21529@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7hzOB1FBqLx1qi/"
Message-Id: <200409051802.03976.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_7hzOB1FBqLx1qi/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 23:45, luned=EC 30 agosto 2004, Zwane Mwaikambo ha scritto:
> On Mon, 30 Aug 2004, BlaisorBlade wrote:
> > Alle 00:41, marted=EC 24 agosto 2004, Zwane Mwaikambo ha scritto:
> > > On Thu, 19 Aug 2004, BlaisorBlade wrote:
> > > > (CC me on replies as I'm not subscribed).
> > > >
> > > > A short description, with my hypothesis about how the panic()
> > > > happened:
> > >
> > > There is a short one liner for this which is already in the latest
> > > kernel;
> >
> > Ok, fine, that's a lot better than my fix - and what about the stacking
> > problem? Also there are some other drivers which could need fixing,
> > probably (I've not the time now).

> I don't think we should worry about the stacking problem, in fact it's not
> meant to be stacked at all. Regarding other drivers, there are none that
> i'm aware of that require fixing.
APM must be fixed, too, since it does the same trick. Patch attached (addin=
g=20
comments to explain the synchronize_kernel() call).

> There aren't many users of pm_idle=20
> outside of arch/*/kernel/process.c
Both APM and ACPI set pm_idle, and both can be modular. It seems, however,=
=20
they are the only such ones. And since they APM and ACPI refuse to be both=
=20
loaded, we cannot have (actually) two modules which override pm_idle. So=20
you're right.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_7hzOB1FBqLx1qi/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="barrier-after-pm_idle-removal-apm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="barrier-after-pm_idle-removal-apm.patch"


Add the synchronize_kernel() call, to let the idle thread see the newly set
value of pm_idle before the module is unloaded.
Also explain this both here and in drivers/acpi/processor.c with a comment.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/apm.c   |    5 ++++-
 vanilla-linux-2.6.8.1-paolo/drivers/acpi/processor.c |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/apm.c~barrier-after-pm_idle-removal-apm arch/i386/kernel/apm.c
--- vanilla-linux-2.6.8.1/arch/i386/kernel/apm.c~barrier-after-pm_idle-removal-apm	2004-09-05 17:37:55.196708328 +0200
+++ vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/apm.c	2004-09-05 18:01:17.524522096 +0200
@@ -2360,8 +2360,11 @@ static void __exit apm_exit(void)
 {
 	int	error;
 
-	if (set_pm_idle)
+	if (set_pm_idle) {
 		pm_idle = original_pm_idle;
+		/*Wait the idle thread to read the new value, otherwise we Oops.*/
+		synchronize_kernel();
+	}
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
 	    && (apm_info.connection_version > 0x0100)) {
 		error = apm_engage_power_management(APM_DEVICE_ALL, 0);
diff -puN drivers/acpi/processor.c~barrier-after-pm_idle-removal-apm drivers/acpi/processor.c
--- vanilla-linux-2.6.8.1/drivers/acpi/processor.c~barrier-after-pm_idle-removal-apm	2004-09-05 17:39:04.592158616 +0200
+++ vanilla-linux-2.6.8.1-paolo/drivers/acpi/processor.c	2004-09-05 17:57:29.472191320 +0200
@@ -2375,6 +2375,7 @@ acpi_processor_remove (
 	/* Unregister the idle handler when processor #0 is removed. */
 	if (pr->id == 0) {
 		pm_idle = pm_idle_save;
+		/*Wait the idle thread to read the new value, otherwise we Oops.*/
 		synchronize_kernel();
 	}
 
_

--Boundary-00=_7hzOB1FBqLx1qi/--
