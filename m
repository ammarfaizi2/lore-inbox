Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWBEFCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWBEFCf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 00:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWBEFCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 00:02:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47625 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030266AbWBEFCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 00:02:34 -0500
Date: Sun, 5 Feb 2006 06:02:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       "Gabriel C." <crazy@pimpmylinux.org>, da.crew@gmx.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] let only ACX_PCI/ACX_USB be user-visible and select ACX accordingly
Message-ID: <20060205050232.GB5271@stusta.de>
References: <20060130133833.7b7a3f8e@zwerg> <200601311658.09423.vda@ilport.com.ua> <20060131221637.GJ3986@stusta.de> <200602010857.04964.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602010857.04964.vda@ilport.com.ua>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 08:57:04AM +0200, Denis Vlasenko wrote:
> On Wednesday 01 February 2006 00:16, Adrian Bunk wrote:
> > > > > CONFIG_ACX=y
> > > > > # CONFIG_ACX_PCI is not set
> > > > > # CONFIG_ACX_USB is not set
> > > > > 
> > > > > This won't fly. You must select at least one.
> > > > > 
> > > > > Attached patch will check for this and #error out.
> > > > > Andrew, do not apply to -mm, I'll send you bigger update today.
> > > > 
> > > > Is there any way to move this into a Kconfig file?  That seems nicer
> > > > than having #ifdefs in source code to check for a configuration error.
> > > 
> > > Can't think of any at the moment.
> > 
> > There are two possible solutions ("offer" means "is user visible"):
> > - only offer ACX and always build ACX_PCI/ACX_USB depending on the
> >   availability of PCI/USB
> > - only offer ACX_PCI and ACX_USB which select ACX
> > 
> > If you tell me which you prefer I can send a patch.
> 
> Second one sounds okay to me.

The patch is below.

I've promised a bit too much, there's one small problem in this patch:

If the user says y to one option and m to the other, the driver is built 
statically supporting both.

Unfortunately, I don't see any reasonable way to implement this better 
(but I do still prefer this solution over the #error).

> vda

cu
Adrian


<--  snip  -->


Let only ACX_PCI/ACX_USB be user-visible and select ACX accordingly.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/tiacx/Kconfig      |   43 +++++++++++++-----------
 drivers/net/wireless/tiacx/Makefile     |    4 +-
 drivers/net/wireless/tiacx/acx_struct.h |   12 ++----
 drivers/net/wireless/tiacx/common.c     |    8 ++--
 4 files changed, 34 insertions(+), 33 deletions(-)


--- linux-2.6.16-rc1-mm5-full/drivers/net/wireless/tiacx/Kconfig.old	2006-02-05 03:48:32.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/net/wireless/tiacx/Kconfig	2006-02-05 05:31:54.000000000 +0100
@@ -1,25 +1,18 @@
 config ACX
-	tristate "TI acx100/acx111 802.11b/g wireless chipsets"
-	depends on NET_RADIO && EXPERIMENTAL && (USB || PCI)
+	tristate
 	select FW_LOADER
+
+config ACX_PCI
+	tristate "TI acx100/acx111 802.11b/g PCI wireless chipsets"
+	depends on NET_RADIO && EXPERIMENTAL && PCI && (USB || ACX_USB=n)
+	select ACX
+	select ACX_PCI_BOOL
 	---help---
-	A driver for 802.11b/g wireless cards based on
-	Texas Instruments acx100 and acx111 chipsets.
+	Include support for PCI and CardBus 802.11b/g wireless cards
+	based on Texas Instruments acx100 and acx111 chipsets.
 
 	This driver supports Host AP mode that allows
 	your computer to act as an IEEE 802.11 access point.
-	This driver is new and experimental.
-
-	Texas Instruments did not take part in development of this driver
-	in any way, shape or form.
-
-	The driver can be compiled as a module and will be named "acx".
-
-config ACX_PCI
-	bool "TI acx100/acx111 802.11b/g PCI"
-	depends on ACX && PCI
-	---help---
-	Include PCI and CardBus support in acx.
 
 	acx chipsets need their firmware loaded at startup.
 	You will need to provide a firmware image via hotplug.
@@ -44,11 +37,20 @@
 	Firmware files are not covered by GPL and are not distributed
 	with this driver for legal reasons.
 
+config ACX_PCI_BOOL
+	bool
+
 config ACX_USB
-	bool "TI acx100/acx111 802.11b/g USB"
-	depends on ACX && (USB=y || USB=ACX)
+	tristate "TI acx100/acx111 802.11b/g USB wireless chipsets"
+	depends on NET_RADIO && EXPERIMENTAL && USB
+	select ACX
+	select ACX_USB_BOOL
 	---help---
-	Include USB support in acx.
+	Include support for USB 802.11b/g wireless cards
+	based on Texas Instruments acx100 and acx111 chipsets.
+
+	This driver supports Host AP mode that allows
+	your computer to act as an IEEE 802.11 access point.
 
 	There is only one currently known device in this category,
 	D-Link DWL-120+, but newer devices seem to be on the horizon.
@@ -61,3 +63,6 @@
 
 	Firmware files are not covered by GPL and are not distributed
 	with this driver for legal reasons.
+
+config ACX_USB_BOOL
+	bool
--- linux-2.6.16-rc1-mm5-full/drivers/net/wireless/tiacx/Makefile.old	2006-02-05 05:25:03.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/net/wireless/tiacx/Makefile	2006-02-05 05:25:17.000000000 +0100
@@ -1,6 +1,6 @@
 obj-$(CONFIG_ACX) += acx.o
 
-acx-obj-$(CONFIG_ACX_PCI) += pci.o
-acx-obj-$(CONFIG_ACX_USB) += usb.o
+acx-obj-$(CONFIG_ACX_PCI_BOOL) += pci.o
+acx-obj-$(CONFIG_ACX_USB_BOOL) += usb.o
 
 acx-objs := wlan.o conv.o ioctl.o common.o $(acx-obj-y)
--- linux-2.6.16-rc1-mm5-full/drivers/net/wireless/tiacx/acx_struct.h.old	2006-02-05 05:37:13.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/net/wireless/tiacx/acx_struct.h	2006-02-05 05:37:35.000000000 +0100
@@ -105,12 +105,8 @@
 #define DEVTYPE_PCI		0
 #define DEVTYPE_USB		1
 
-#if !defined(CONFIG_ACX_PCI) && !defined(CONFIG_ACX_USB)
-#error Driver must include PCI and/or USB support. You selected neither.
-#endif
-
-#if defined(CONFIG_ACX_PCI)
- #if !defined(CONFIG_ACX_USB)
+#if defined(CONFIG_ACX_PCI_BOOL)
+ #if !defined(CONFIG_ACX_USB_BOOL)
   #define IS_PCI(adev)	1
  #else
   #define IS_PCI(adev)	((adev)->dev_type == DEVTYPE_PCI)
@@ -119,8 +115,8 @@
  #define IS_PCI(adev)	0
 #endif
 
-#if defined(CONFIG_ACX_USB)
- #if !defined(CONFIG_ACX_PCI)
+#if defined(CONFIG_ACX_USB_BOOL)
+ #if !defined(CONFIG_ACX_PCI_BOOL)
   #define IS_USB(adev)	1
  #else
   #define IS_USB(adev)	((adev)->dev_type == DEVTYPE_USB)
--- linux-2.6.16-rc1-mm5-full/drivers/net/wireless/tiacx/common.c.old	2006-02-05 05:37:44.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/net/wireless/tiacx/common.c	2006-02-05 05:38:58.000000000 +0100
@@ -6853,12 +6853,12 @@
 		"recommended, visit http://acx100.sf.net in case "
 		"of further questions/discussion\n");
 
-#if defined(CONFIG_ACX_PCI)
+#if defined(CONFIG_ACX_PCI_BOOL)
 	r1 = acxpci_e_init_module();
 #else
 	r1 = -EINVAL;
 #endif
-#if defined(CONFIG_ACX_USB)
+#if defined(CONFIG_ACX_USB_BOOL)
 	r2 = acxusb_e_init_module();
 #else
 	r2 = -EINVAL;
@@ -6872,10 +6872,10 @@
 static void __exit
 acx_e_cleanup_module(void)
 {
-#if defined(CONFIG_ACX_PCI)
+#if defined(CONFIG_ACX_PCI_BOOL)
 	acxpci_e_cleanup_module();
 #endif
-#if defined(CONFIG_ACX_USB)
+#if defined(CONFIG_ACX_USB_BOOL)
 	acxusb_e_cleanup_module();
 #endif
 }

