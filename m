Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUGBVtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUGBVtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUGBVtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:49:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:20612 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264959AbUGBVsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:48:03 -0400
Message-ID: <40E5E5A1.4080003@us.ibm.com>
Date: Fri, 02 Jul 2004 17:45:53 -0500
From: Linda Xie <lxiep@us.ibm.com>
Reply-To: lxiep@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, zh-cn, zh
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
CC: John Rose <johnrose@austin.ibm.com>, Mike Wortman <wortman@us.ibm.com>,
       External List <linuxppc64-dev@lists.linuxppc.org>,
       linux-kernel@vger.kernel.org
Subject: [PATH] rpaphp_add_slot.patch 
Content-Type: multipart/mixed;
 boundary="------------050003060003000009080209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050003060003000009080209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

I found a bug in rpaphp code during DLPAR I/O testing.   When DLPAR ADD 
a non-empty I/O slot to a partition,  an adapter  in the slot  didn't 
get configured. The attached patch fixes that. Please review  and apply 
if there are no objections.

Signed-off-by: Linda Xie <lxie@us.ibm.com>  


Thanks,

Linda

--------------050003060003000009080209
Content-Type: text/plain;
 name="rpaphp_add_slot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rpaphp_add_slot.patch"

diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	Fri Jul  2 15:59:36 2004
+++ b/drivers/pci/hotplug/rpaphp_pci.c	Fri Jul  2 15:59:36 2004
@@ -340,7 +340,6 @@
 	return rc;
 }
 
-
 static void rpaphp_eeh_remove_bus_device(struct pci_dev *dev)
 {
 	eeh_remove_device(dev);
@@ -429,10 +428,26 @@
 				__FUNCTION__, slot->name);
 			goto exit_rc;
 		}
-		if (init_slot_pci_funcs(slot)) {
-			err("%s: init_slot_pci_funcs failed\n", __FUNCTION__);
+
+		if (slot->hotplug_slot->info->adapter_status == NOT_CONFIGURED) {
+			dbg("%s CONFIGURING pci adapter in slot[%s]\n",  
+				__FUNCTION__, slot->name);
+			if (rpaphp_config_pci_adapter(slot)) {
+				err("%s: CONFIG pci adapter failed\n", __FUNCTION__);
+				goto exit_rc;		
+			}
+		} else if (slot->hotplug_slot->info->adapter_status == CONFIGURED) {
+			if (init_slot_pci_funcs(slot)) {
+				err("%s: init_slot_pci_funcs failed\n", __FUNCTION__);
+				goto exit_rc;
+			}
+
+		} else {
+			err("%s: slot[%s]'s adapter_status is NOT_VALID.\n",
+				__FUNCTION__, slot->name);
 			goto exit_rc;
 		}
+		
 		print_slot_pci_funcs(slot);
 		if (!list_empty(&slot->dev.pci_funcs)) {
 			slot->state = CONFIGURED;

--------------050003060003000009080209--

