Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317929AbSGPSfa>; Tue, 16 Jul 2002 14:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSGPSf3>; Tue, 16 Jul 2002 14:35:29 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:529 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317929AbSGPSf2>;
	Tue, 16 Jul 2002 14:35:28 -0400
Date: Tue, 16 Jul 2002 11:37:25 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, t-kouchi@mvf.biglobe.ne.jp
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI Hotplug changes for 2.4.19-rc1-ac6
Message-ID: <20020716183724.GC3731@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.4.19-rc1-ac6 that fixes a bug in the PCI core
for PCI hotplug drivers.  When pci_scan_slot() is called,
pci_name_device() can eventually be called, which uses data declared as
__initdata, instead of __devinitdata.  This patch from Takayoshi KOCHI
<t-kouchi@mvf.biglobe.ne.jp> fixes this problem (thanks also to him for
finding the bug in the first place.)

thanks,

greg k-h

diff -Nru a/drivers/pci/names.c b/drivers/pci/names.c
--- a/drivers/pci/names.c	Tue Jul 16 11:27:01 2002
+++ b/drivers/pci/names.c	Tue Jul 16 11:27:01 2002
@@ -32,18 +32,18 @@
  * real memory.. Parse the same file multiple times
  * to get all the info.
  */
-#define VENDOR( vendor, name )		static char __vendorstr_##vendor[] __initdata = name;
+#define VENDOR( vendor, name )		static char __vendorstr_##vendor[] __devinitdata = name;
 #define ENDVENDOR()
-#define DEVICE( vendor, device, name ) 	static char __devicestr_##vendor##device[] __initdata = name;
+#define DEVICE( vendor, device, name ) 	static char __devicestr_##vendor##device[] __devinitdata = name;
 #include "devlist.h"
 
 
-#define VENDOR( vendor, name )		static struct pci_device_info __devices_##vendor[] __initdata = {
+#define VENDOR( vendor, name )		static struct pci_device_info __devices_##vendor[] __devinitdata = {
 #define ENDVENDOR()			};
 #define DEVICE( vendor, device, name )	{ 0x##device, 0, __devicestr_##vendor##device },
 #include "devlist.h"
 
-static struct pci_vendor_info __initdata pci_vendor_list[] = {
+static struct pci_vendor_info __devinitdata pci_vendor_list[] = {
 #define VENDOR( vendor, name )		{ 0x##vendor, sizeof(__devices_##vendor) / sizeof(struct pci_device_info), __vendorstr_##vendor, __devices_##vendor },
 #define ENDVENDOR()
 #define DEVICE( vendor, device, name )
@@ -121,7 +121,7 @@
 
 #else
 
-void __init pci_name_device(struct pci_dev *dev)
+void __devinit pci_name_device(struct pci_dev *dev)
 {
 }
 
