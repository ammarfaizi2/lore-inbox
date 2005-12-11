Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbVLKFmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbVLKFmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbVLKFmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:42:12 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:13811 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161095AbVLKFmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:42:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=CYSagQcZJJAMuAOGqHsHFsX7HYbnJ7kJZMhcpoKpVxnIOJsDJ3P9gBs2DIC8ugXD6IPM8sSz8EAdsKuCdJZM8EmBVcO+220L+X/28oxKVouB3UfZiPgfNktIwE0P4EDniljzil5ySSl39Yrm0+EPsDUIIEBTBeaS3MQ9QtN5688=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Reduce nr of ptr derefs in drivers/pci/hotplug/rpaphp_pci.c
Date: Sun, 11 Dec 2005 06:42:38 +0100
User-Agent: KMail/1.9
Cc: lxie@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, greg@kroah.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512110642.38672.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to reduce the nr. of pointer dereferences in
drivers/pci/hotplug/rpaphp_pci.c

Benefits:
 - micro speed optimization due to fewer pointer derefs
 - generated code should be slightly smaller
 - better readability

note: due to lack of both hardware and cross-compile tools this patch is,
      unfortunately, completely untested.

Please review and consider for inclusion.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/pci/hotplug/rpaphp_pci.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.15-rc5-git1-orig/drivers/pci/hotplug/rpaphp_pci.c	2005-12-04 18:48:04.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/pci/hotplug/rpaphp_pci.c	2005-12-11 03:59:31.000000000 +0100
@@ -370,13 +370,14 @@ EXPORT_SYMBOL_GPL(rpaphp_unconfig_pci_ad
 
 static int setup_pci_hotplug_slot_info(struct slot *slot)
 {
+	struct hotplug_slot_info *hotplug_slot_info = slot->hotplug_slot->info;
+
 	dbg("%s Initilize the PCI slot's hotplug->info structure ...\n",
 	    __FUNCTION__);
-	rpaphp_get_power_status(slot, &slot->hotplug_slot->info->power_status);
+	rpaphp_get_power_status(slot, &hotplug_slot_info->power_status);
 	rpaphp_get_pci_adapter_status(slot, 1,
-				      &slot->hotplug_slot->info->
-				      adapter_status);
-	if (slot->hotplug_slot->info->adapter_status == NOT_VALID) {
+				      &hotplug_slot_info->adapter_status);
+	if (hotplug_slot_info->adapter_status == NOT_VALID) {
 		err("%s: NOT_VALID: skip dn->full_name=%s\n",
 		    __FUNCTION__, slot->dn->full_name);
 		return -EINVAL;



