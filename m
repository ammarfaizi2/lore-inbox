Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVFFUz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVFFUz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVFFUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:55:26 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:4279 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261687AbVFFUzH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:55:07 -0400
Date: Mon, 6 Jun 2005 13:54:59 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Hanno =?ISO-8859-1?B?QvZjaw==?= <mail@hboeck.de>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: sziwan@users.sourceforge.net, julien.lerouge@free.fr
Subject: Re: Kernel oops with asus_acpi module
Message-Id: <20050606135459.7ad699ae.rdunlap@xenotime.net>
In-Reply-To: <200506062050.42632.mail@hboeck.de>
References: <200506052340.41074.mail@hboeck.de>
	<200506061929.24663.mail@hboeck.de>
	<20050606114531.763eec37.rdunlap@xenotime.net>
	<200506062050.42632.mail@hboeck.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(back to mailing lists + asus acpi maintainers)


On Mon, 6 Jun 2005 20:50:42 +0200 Hanno Böck wrote:

| Am Montag, 6. Juni 2005 20:45 schrieben Sie:
| > 2 or 3 things:
| >
| > a.  I can't match that Code line to any code in my
| > compiler asus_acpi.o file.  What version of gcc are you using?
| > Can you send me your asus_acpi.o file?
| 
| Attached.
| I'm using gcc4 (but that's probably not the reason, because matthias hentges, 
| who has a debian-system, has the same problem)

Well, gcc4 does have some known issues with the Linux kernel,
although I don't know the specifics of them.

| >
| > b.  That Code line is different from the first one that you posted.
| > That doesn't make much sense to me....
| 
| Don't know why, but maybe because I recompiled the kernel with 
| debugging-support?

OK, I see that part.

I'm including a patch for you to try.  Can you apply and test it
and report back on it, please?

---

From: Randy Dunlap <rdunlap@xenotime.net>
linux-2612-rc5-mm2

model->string.pointer was NULL, so printk of it caused an oops.

Handle ASUS ACPI string descriptor with 0 length or NULL pointer
by trying the Samsung P30 support code exception handling.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 drivers/acpi/asus_acpi.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -Naurp ./drivers/acpi/asus_acpi.c~asus_models ./drivers/acpi/asus_acpi.c
--- ./drivers/acpi/asus_acpi.c~asus_models	2005-03-01 23:37:53.000000000 -0800
+++ ./drivers/acpi/asus_acpi.c	2005-06-06 13:51:40.000000000 -0700
@@ -993,6 +993,7 @@ static int __init asus_hotk_get_info(voi
 	/* Samsung P30 has a device with a valid _HID whose INIT does not 
 	 * return anything. Catch this one and any similar here */
 	if (buffer.pointer == NULL) {
+try_p30:
 		if (asus_info && /* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
 			hotk->model = P30;
@@ -1009,7 +1010,15 @@ static int __init asus_hotk_get_info(voi
 	
 	model = (union acpi_object *) buffer.pointer;
 	if (model->type == ACPI_TYPE_STRING) {
-		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
+		if (!model->string.length || !model->string.pointer) {
+			printk(KERN_WARNING "  model string length or pointer "
+				"is 0, trying P30 exceptions (%u, %p)\n",
+				model->string.length, model->string.pointer);
+			goto try_p30;
+		}
+		else
+			printk(KERN_NOTICE "  %s model detected, ",
+				model->string.pointer);
 	}
 
 	hotk->model = END_MODEL;
