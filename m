Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVHBJMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVHBJMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVHBJMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:12:50 -0400
Received: from gw.alcove.fr ([81.80.245.157]:64700 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261436AbVHBJMu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:12:50 -0400
Subject: Re: Fn key and 2.6.12-rc4
From: Stelian Pop <stelian@popies.net>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <20050802071736.GA22055@baumbart.home.lxtec.de>
References: <20050731190531.GA5629@samweis.home.lxtec.de>
	 <1122838500.17880.16.camel@deep-space-9.dsnet>
	 <20050731200148.GA20179@frodo.home.lxtec.de>
	 <1122844800.17880.19.camel@deep-space-9.dsnet>
	 <20050731214308.GA4346@samweis.home.lxtec.de>
	 <1122847027.17880.47.camel@deep-space-9.dsnet>
	 <20050801171309.GA4624@samweis.home.lxtec.de>
	 <1122921231.22294.5.camel@deep-space-9.dsnet>
	 <20050801185529.GB16623@samweis.home.lxtec.de>
	 <1122929399.22294.27.camel@deep-space-9.dsnet>
	 <20050802071736.GA22055@baumbart.home.lxtec.de>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Aug 2005 11:11:08 +0200
Message-Id: <1122973868.5431.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 02 août 2005 à 09:17 +0200, Elimar Riesebieter a écrit :

> > [ fnkey not working on Apple Powerbooks in -mm tree ]

> > Hmm, there seem to be a lot of divergence between -mm and linus tree
> > here, and this may be the cause of the malfunction. 
> > 
> > Let me do some tests tomorrow with an -mm kernel and see if I find
> > something.

Ok, the -mm tree contains some other input patches which conflict with
my Fn key patch
(input-quirk-for-the-fn-key-on-powerbooks-with-an-usb.patch). The
attached patch makes it work again.

Andrew, please apply.

Stelian.

Newer input patches added a HID_UP_LOGIVENDOR switch case which disrupts
the Apple Powerbooks Fn key patch. Moving a few lines of code from the
'default' switch case to the new location makes it work again.

Signed-off-by: Stelian Pop <stelian@popies.net>

Index: linux-2.6.12-rc4-mm1/drivers/usb/input/hid-input.c
===================================================================
--- linux-2.6.12-rc4-mm1.orig/drivers/usb/input/hid-input.c	2005-08-02 09:44:28.000000000 +0200
+++ linux-2.6.12-rc4-mm1/drivers/usb/input/hid-input.c	2005-08-02 10:57:13.000000000 +0200
@@ -323,6 +323,11 @@
 
 		case HID_UP_MSVENDOR:
 		case HID_UP_LOGIVENDOR:
+
+			if ((device->quirks & HID_QUIRK_POWERBOOK_FN_BUTTON) && (usage->hid == 0x00ff0003)) {
+				map_key_clear(KEY_RIGHTCTRL);
+				break;
+			}
 			goto ignore;
 
 		case HID_UP_LOGIVENDOR2: /* Reported on Logitech Ultra X Media Remote */
@@ -376,10 +381,7 @@
 
 		default:
 		unknown:
-			if ((device->quirks & HID_QUIRK_POWERBOOK_FN_BUTTON) && (usage->hid == 0x00ff0003)) {
-				map_key_clear(KEY_RIGHTCTRL);
-				break;
-			}
+
 			if (field->report_size == 1) {
 				if (field->report->type == HID_OUTPUT_REPORT) {
 					map_led(LED_MISC);
 

-- 
Stelian Pop <stelian@popies.net>

