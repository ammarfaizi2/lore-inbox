Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUGHVcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUGHVcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 17:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUGHVcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 17:32:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2489 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263640AbUGHVcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 17:32:05 -0400
Date: Thu, 8 Jul 2004 17:31:51 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: breed@users.sourceforge.net, fabrice@bellet.info
Subject: [PATCH] fix airo oops-on-removal
Message-ID: <20040708213151.GE13918@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, breed@users.sourceforge.net,
	fabrice@bellet.info
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

airo creates /proc/driver/aironet/<device name> on device activation.
However, the device can be renamed - then on teardown
it tries to remove the wrong directory. The removal of 
/proc/driver/aironet then runs afoul of the BUG_ON() in remove_proc_entry.

This fixes it by keeping a copy of the name of the directory
it created.

(It doesn't actually solve the problem of the stats directory
still being /proc/driver/aironet/eth0 when you rename the device
to, say, 'joe'. But that patch would be a little less trivial.)

Bill

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="airo.patch"

--- linux/drivers/net/wireless/airo.c.old	2004-07-08 17:19:37.856055132 -0400
+++ linux/drivers/net/wireless/airo.c	2004-07-08 17:28:26.720339699 -0400
@@ -1210,6 +1210,7 @@
 	APListRid		*APList;
 #define	PCI_SHARED_LEN		2*MPI_MAX_FIDS*PKTSIZE+RIDSIZE
 	u32			pci_state[16];
+	char			proc_name[IFNAMSIZ];
 };
 
 static inline int bap_read(struct airo_info *ai, u16 *pu16Dst, int bytelen,
@@ -4369,7 +4370,8 @@
 			     struct airo_info *apriv ) {
 	struct proc_dir_entry *entry;
 	/* First setup the device directory */
-	apriv->proc_entry = create_proc_entry(dev->name,
+	strcpy(apriv->proc_name,dev->name);
+	apriv->proc_entry = create_proc_entry(apriv->proc_name,
 					      S_IFDIR|airo_perm,
 					      airo_entry);
         apriv->proc_entry->uid = proc_uid;
@@ -4472,7 +4474,7 @@
 	remove_proc_entry("APList",apriv->proc_entry);
 	remove_proc_entry("BSSList",apriv->proc_entry);
 	remove_proc_entry("WepKey",apriv->proc_entry);
-	remove_proc_entry(dev->name,airo_entry);
+	remove_proc_entry(apriv->proc_name,airo_entry);
 	return 0;
 }
 

--vkogqOf2sHV7VnPd--
