Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUESK3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUESK3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUESK3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:29:15 -0400
Received: from qfep04.superonline.com ([212.252.122.161]:25772 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S263295AbUESK2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:28:51 -0400
Message-ID: <40AB36D6.3080808@superonline.com>
Date: Wed, 19 May 2004 13:28:38 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] 2.4.27-pre3  backout acpi_fixed_pwr_button
Content-Type: multipart/mixed;
 boundary="------------090804020702010408020502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090804020702010408020502
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

Marcelo:

2.4.27-pre3 still seems to have the acpi_fixed_pwr_button and
acpi_fixed_sleep_button changes in it, which oopses for me
upon module unload. Sergey Vlasov's response to my report is
attached. The original oops report is here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108405180820535&w=2

If you don't have another fix for it, please apply the included
patch in order to back that out.

Regards,
Özkan Sezer

--------------090804020702010408020502
Content-Type: text/plain;
 name="button-rmmod-oops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="button-rmmod-oops.patch"

X-UIDL: 1084210475.26274.qsol01,S=4197
X-Mozilla-Status: 0011
X-Mozilla-Status2: 00000000
Return-Path: <vsu@altlinux.ru>
Delivered-To: sezero@superonline.com
Received: (qmail 26269 invoked from network); 10 May 2004 17:34:35 -0000
Received: from unknown ([212.252.122.201])
          (envelope-sender <>)
          by qsol01.superonline.com (qmail-ldap-1.03) with QMQP
          for <>; 10 May 2004 17:34:35 -0000
Delivered-To: CLUSTERHOST vfep01.superonline.com sezero@superonline.com
Received: (qmail 32592 invoked from network); 10 May 2004 17:34:15 -0000
Received: from unknown (HELO ns1.murom.ru) ([213.177.124.6])
          (envelope-sender <vsu@altlinux.ru>)
          by vfep01.superonline.com (qmail-ldap-1.03) with SMTP
          for <sezero@superonline.com>; 10 May 2004 17:34:14 -0000
Received: from [172.16.7.8] (helo=sirius.home)
	by ns1.murom.ru with smtp (Exim 4.30)
	id 1BNEfC-0002tR-7Z
	for sezero@superonline.com; Mon, 10 May 2004 21:34:02 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: OOPS :  2.4.27-pre2 + latest ACPI
Date: Mon, 10 May 2004 21:34:02 +0400
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2004.05.10.17.34.01.383608@altlinux.ru>
References: <409D50AE.2020908@superonline.com> <409D52D3.5080500@superonline.com> <409DE596.8000808@superonline.com>
To: "O.Sezer" <sezero@superonline.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-From: vsu@altlinux.ru
X-Spam-Checker-Version: SpamAssassin 2.60-superonline (1.212-2003-09-23-exp) 
	on vfep03
X-Spam-Version: SpamAssassin Superonline
X-Spam-Status: No, hits=0.0 required=40.0 tests=BAYES_50 autolearn=no 
	version=2.60-superonline
X-Spam-Level: 

On Sun, 09 May 2004 11:02:30 +0300, O.Sezer wrote:

> I backed-out the new module hunks and the
> oops went-away. Seems like there are still
> problems with the module unloading code.

Looks like a free memory access - at acpi_button_remove() button->handle
was trashed by 0x5a5a5a5a.

Does the patch below (on top of the new ACPI changes) fix this?  Seems
that the special handling for fixed-feature buttons is unneeded at least
for 2.4.x - acpi_bus_unregister_driver() works for them.


--- linux/drivers/acpi/button.c.button-rmmod-oops	2004-05-09 19:45:09 +0400
+++ linux/drivers/acpi/button.c	2004-05-10 21:18:56 +0400
@@ -69,8 +69,6 @@
    -------------------------------------------------------------------------- */
 
 static struct proc_dir_entry	*acpi_button_dir;
-extern struct acpi_device 	*acpi_fixed_pwr_button;
-extern struct acpi_device	*acpi_fixed_sleep_button;
 
 static int
 acpi_button_read_info (
@@ -514,12 +512,6 @@
 {
 	ACPI_FUNCTION_TRACE("acpi_button_exit");
 
-	if(acpi_fixed_pwr_button) 
-		acpi_button_remove(acpi_fixed_pwr_button, ACPI_BUS_TYPE_POWER_BUTTON);
-
-	if(acpi_fixed_sleep_button)
-		acpi_button_remove(acpi_fixed_sleep_button, ACPI_BUS_TYPE_SLEEP_BUTTON);
-
 	acpi_bus_unregister_driver(&acpi_button_driver);
 
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
--- linux/drivers/acpi/bus.c.button-rmmod-oops	2004-05-09 19:45:09 +0400
+++ linux/drivers/acpi/bus.c	2004-05-10 21:21:06 +0400
@@ -1769,23 +1769,15 @@
 }
 
 
-struct acpi_device *acpi_fixed_pwr_button;
-struct acpi_device *acpi_fixed_sleep_button;
-
-EXPORT_SYMBOL(acpi_fixed_pwr_button);
-EXPORT_SYMBOL(acpi_fixed_sleep_button);
-
 static int
 acpi_bus_scan_fixed (
 	struct acpi_device	*root)
 {
 	int			result = 0;
+	struct acpi_device	*device = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_scan_fixed");
 
-	acpi_fixed_pwr_button = NULL;
-	acpi_fixed_sleep_button = NULL;
-
 	if (!root)
 		return_VALUE(-ENODEV);
 
@@ -1793,11 +1785,11 @@
 	 * Enumerate all fixed-feature devices.
 	 */
 	if (acpi_fadt.pwr_button == 0)
-		result = acpi_bus_add(&acpi_fixed_pwr_button, acpi_root, 
+		result = acpi_bus_add(&device, acpi_root, 
 			NULL, ACPI_BUS_TYPE_POWER_BUTTON);
 
 	if (acpi_fadt.sleep_button == 0)
-		result = acpi_bus_add(&acpi_fixed_sleep_button, acpi_root, 
+		result = acpi_bus_add(&device, acpi_root, 
 			NULL, ACPI_BUS_TYPE_SLEEP_BUTTON);
 
 	return_VALUE(result);

--- ./drivers/acpi/Makefile.orig
+++ ./drivers/acpi/Makefile
@@ -14,7 +14,7 @@
 
 EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
 
-export-objs 	:= acpi_ksyms.o processor.o bus.o
+export-objs 	:= acpi_ksyms.o processor.o
 
 obj-$(CONFIG_ACPI)	:= acpi_ksyms.o 
 


--------------090804020702010408020502--

