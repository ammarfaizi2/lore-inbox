Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVDEBcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVDEBcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 21:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVDEBcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 21:32:09 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:10837 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261485AbVDEBcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 21:32:00 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jaco Kroon <jaco@kroon.co.za>
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
Date: Mon, 4 Apr 2005 20:25:31 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Sebastian Piechocki <sebekpi@poczta.onet.pl>
References: <425166F9.1040800@kroon.co.za> <d120d50005040417151987558d@mail.gmail.com> <4251DD5A.2020801@kroon.co.za>
In-Reply-To: <4251DD5A.2020801@kroon.co.za>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504042025.31645.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 April 2005 19:35, Jaco Kroon wrote:
> Dmitry Torokhov wrote:
> 
> > A-haa.. Well, in that case we'll cheat ;) and just disable MUX mode
> > for your Toshiba via a DMI quirk, like we do for certain Fujitsus. If
> > there is no external port there is no reason to have the controller in
> > MUX mode.
> > 
> > Could you please send me output of 'dmidecode' utility?
> 
> Ah yes.  Your lucky it's only a 37KB download.  Some nice tools...
> 
> It's a _lot_ of output so I'm again rather attaching it (gzipped).
>

Ok, great! Please try the patch below (against 2.6.12-rc{1|2}).
 
> Would this quirk also imply usb-handoff?
>

No, just nomux. We are still battling whether we shoudl have usb-handoff on
by default.
 
> One (hopefully) last query, lspci reports the following device (which I
> assume is the SD card reader):
> 
> 0000:02:04.2 Class 0805: ENE Technology Inc: Unknown device 0550
> 
> How can one confirm what this is?

Not sure, sorry.

-- 
Dmitry

===================================================================

Input: automatically disable MUX mode on Toshiba Satellite P10
       because it interferes with ALPS touchpad detection and
       causes horrible death on reboot. Since P10 does not have
       external PS/2 ports MUX mode does not have any advantages
       over legacy mode anyway.


 i8042-x86ia64io.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

Index: dtor/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- dtor.orig/drivers/input/serio/i8042-x86ia64io.h
+++ dtor/drivers/input/serio/i8042-x86ia64io.h
@@ -88,9 +88,11 @@ static struct dmi_system_id __initdata i
 };
 
 /*
- * Some Fujitsu notebooks are ahving trouble with touhcpads if
+ * Some Fujitsu notebooks are having trouble with touchpads if
  * active multiplexing mode is activated. Luckily they don't have
  * external PS/2 ports so we can safely disable it.
+ * ... apparently some Toshibas don't like MUX mode either and
+ * die horrible death on reboot.
  */
 static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
 	{
@@ -121,6 +123,13 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
 		},
 	},
+	{
+		.ident = "Toshiba P10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
+		},
+	},
 	{ }
 };
 
