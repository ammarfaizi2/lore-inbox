Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWGJGQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWGJGQJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 02:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWGJGQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 02:16:08 -0400
Received: from mga03.intel.com ([143.182.124.21]:12150 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751354AbWGJGQH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 02:16:07 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="63495173:sNHT7050427454"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [patch] fix boot with acpi=off
Date: Mon, 10 Jul 2006 02:15:57 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECFA46@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] fix boot with acpi=off
Thread-Index: AcaijClwEml2Pv6+RaSjLrkONPlWKABWknCw
From: "Brown, Len" <len.brown@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Cc: <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2006 06:15:59.0691 (UTC) FILETIME=[500569B0:01C6A3E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-acpi@vger.kernel.org to cc]

acpi=off used to be handled by acpi_bus_register_driver()
for these drivers.

But now acpi_lock_ac_dir() and acpi_lock_battery_dir()
for procfs are inserted before that in the _init functions.

This will be a problem for sbs.c also.

Vladimir,
Any reason that the procfs stuff can't be after the
acpi_bus_register_driver()
calls?  Under what conditions could these lock functions fail?

-Len


>-----Original Message-----
>From: Pavel Machek [mailto:pavel@ucw.cz] 
>Sent: Saturday, July 08, 2006 8:44 AM
>To: kernel list; Andrew Morton; Brown, Len
>Subject: [patch] fix boot with acpi=off
>
>With acpi=off and acpi_ac/battery compiled into kernel, acpi breaks
>boot. This fixes it.
>
>Signed-off-by: Pavel Machek <pavel@suse.cz>
>
>---
>commit 30b8ecda788b096fbd7088808f9af65c41c3a83d
>tree 3c28088018932f9ceb18bcf980507474d4a50c4e
>parent 05f70501240c6ad5f852f13c187ee55579ad7bb8
>author <pavel@amd.ucw.cz> Sat, 08 Jul 2006 14:43:13 +0200
>committer <pavel@amd.ucw.cz> Sat, 08 Jul 2006 14:43:13 +0200
>
> drivers/acpi/ac.c      |    2 ++
> drivers/acpi/battery.c |    3 +++
> 2 files changed, 5 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
>index 24ccf81..432b6b7 100644
>--- a/drivers/acpi/ac.c
>+++ b/drivers/acpi/ac.c
>@@ -285,6 +285,8 @@ static int __init acpi_ac_init(void)
> {
> 	int result;
> 
>+	if (acpi_disabled)
>+		return -ENODEV;
> 
> 	acpi_ac_dir = acpi_lock_ac_dir();
> 	if (!acpi_ac_dir)
>diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>index 2ce9b35..5af1f64 100644
>--- a/drivers/acpi/battery.c
>+++ b/drivers/acpi/battery.c
>@@ -764,6 +764,9 @@ static int __init acpi_battery_init(void
> {
> 	int result;
> 
>+	if (acpi_disabled)
>+		return -ENODEV;
>+
> 	acpi_battery_dir = acpi_lock_battery_dir();
> 	if (!acpi_battery_dir)
> 		return -ENODEV;
>
>-- 
>(english) http://www.livejournal.com/~pavelmachek
>(cesky, pictures) 
>http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
