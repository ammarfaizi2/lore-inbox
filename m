Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbTGJIHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 04:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbTGJIDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 04:03:53 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:62226 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S269056AbTGJIDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 04:03:01 -0400
Date: Thu, 10 Jul 2003 09:58:50 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Aschwin Marsman <a.marsman@aYniK.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre4
Message-ID: <20030710075850.GA20790@alpha.home.local>
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva> <Pine.LNX.4.44.0307100717570.18695-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307100717570.18695-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Thu, Jul 10, 2003 at 07:23:32AM +0200, Aschwin Marsman wrote:
> On Wed, 9 Jul 2003, Marcelo Tosatti wrote:
> 
> > Hi,
> > 
> > Here goes -pre4. It contains a lot of updates and fixes.
> > 
> > We decided to include this new code quota code which allows usage of
> > quotas with 32bit UID/GIDs.
> > 
> > Most Toshibas should work now due to an important ACPI fix.
> > 
> > Please help and test.
> 
> I use -pre3 with succes, only power down is currently not working
> (only the discs shutdown, no real poweroff). That's why I disabled
> apm and enabled apm in the kernel with -pre4, but that gives:

I remember having had problems with ACPI because my power off didn't work.
After reading through the code, I noticed that due to erroneous comparisons,
some code path would never be executed, and/or some preparatory work before
entering S5 would be done twice, or could not recover from error, I don't
recall exactly. So I sent the two patches below to the acpi-devel list twice,
but never got any reply.

I don't even know if they still apply, but you can try them anyway, they're
simple.

If I recall correctly, the first one should be enough to poweroff with a simple
"echo 5 > /proc/acpi/sleep", while the second one allows the system to use this
for poweroff.

Cheers,
Willy


--- ./drivers/acpi/system.c-orig	Tue Apr 29 17:39:34 2003
+++ ./drivers/acpi/system.c	Tue Apr 29 19:08:09 2003
@@ -180,7 +180,7 @@
 			return AE_ERROR;
 	}
 
-	if (state < ACPI_STATE_S5) {
+	if (state <= ACPI_STATE_S5) {
 		/* Tell devices to stop I/O and actually save their state.
 		 * It is theoretically possible that something could fail,
 		 * so handle that gracefully..
@@ -277,6 +277,7 @@
 
 	switch (state) {
 	case ACPI_STATE_S1:
+	case ACPI_STATE_S5:
 		barrier();
 		status = acpi_enter_sleep_state(state);
 		break;



--- ./drivers/acpi/system.c-orig	Tue Apr 29 19:09:19 2003
+++ ./drivers/acpi/system.c	Tue Apr 29 19:36:08 2003
@@ -90,9 +90,7 @@
 static void
 acpi_power_off (void)
 {
-	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
-	ACPI_DISABLE_IRQS();
-	acpi_enter_sleep_state(ACPI_STATE_S5);
+	acpi_suspend(ACPI_STATE_S5);
 }
 
 #endif /*CONFIG_PM*/



