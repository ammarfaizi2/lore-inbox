Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTFZWiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTFZWha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:37:30 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:18436 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S264060AbTFZWgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:36:06 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.5 3/3] module ref counting for airo.c
Date: Fri, 27 Jun 2003 00:47:41 +0200
User-Agent: KMail/1.5.2
Cc: "linux-net" <linux-net@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20030626225014.5BA7F4FF90@ritz.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clean up airo.c: remove MOD_(INC|DEC)_USE_COUNT, set the owner field instead.
compile tested only. against 2.5.73-bk


--- 1.41/drivers/net/wireless/airo.c	Tue Jun 17 23:28:27 2003
+++ edited/airo.c	Fri Jun 27 00:23:07 2003
@@ -2901,6 +2901,7 @@
 					      airo_entry);
         apriv->proc_entry->uid = proc_uid;
         apriv->proc_entry->gid = proc_gid;
+        apriv->proc_entry->owner = THIS_MODULE;
 
 	/* Setup the StatsDelta */
 	entry = create_proc_entry("StatsDelta",
@@ -2909,6 +2910,7 @@
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
+        entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_statsdelta_ops);
 
 	/* Setup the Stats */
@@ -2918,6 +2920,7 @@
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
+        entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_stats_ops);
 
 	/* Setup the Status */
@@ -2927,6 +2930,7 @@
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
+        entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_status_ops);
 
 	/* Setup the Config */
@@ -2936,6 +2940,7 @@
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
+        entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_config_ops);
 
 	/* Setup the SSID */
@@ -2945,6 +2950,7 @@
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
+        entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_SSID_ops);
 
 	/* Setup the APList */
@@ -2954,6 +2960,7 @@
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
+        entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_APList_ops);
 
 	/* Setup the BSSList */
@@ -2963,6 +2970,7 @@
 	entry->uid = proc_uid;
 	entry->gid = proc_gid;
 	entry->data = dev;
+        entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_BSSList_ops);
 
 	/* Setup the WepKey */
@@ -2972,6 +2980,7 @@
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
+        entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_wepkey_ops);
 
 	return 0;
@@ -3062,8 +3071,6 @@
 	StatusRid status_rid;
 	int i;
 
-	MOD_INC_USE_COUNT;
-
 	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	memset(file->private_data, 0, sizeof(struct proc_data));
@@ -3143,8 +3150,6 @@
 	StatsRid stats;
 	int i, j;
 	int *vals = stats.vals;
-	MOD_INC_USE_COUNT;
-
 
 	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
@@ -3421,8 +3426,6 @@
 	struct airo_info *ai = dev->priv;
 	int i;
 
-	MOD_INC_USE_COUNT;
-
 	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	memset(file->private_data, 0, sizeof(struct proc_data));
@@ -3692,8 +3695,6 @@
 	int j=0;
 	int rc;
 
-	MOD_INC_USE_COUNT;
-
 	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	memset(file->private_data, 0, sizeof(struct proc_data));
@@ -3742,8 +3743,6 @@
 	char *ptr;
 	SsidRid SSID_rid;
 
-	MOD_INC_USE_COUNT;
-
 	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	memset(file->private_data, 0, sizeof(struct proc_data));
@@ -3788,8 +3787,6 @@
 	char *ptr;
 	APListRid APList_rid;
 
-	MOD_INC_USE_COUNT;
-
 	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	memset(file->private_data, 0, sizeof(struct proc_data));
@@ -3840,8 +3837,6 @@
 	/* If doLoseSync is not 1, we won't do a Lose Sync */
 	int doLoseSync = -1;
 
-	MOD_INC_USE_COUNT;
-
 	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	memset(file->private_data, 0, sizeof(struct proc_data));
@@ -3904,7 +3899,6 @@
 {
 	struct proc_data *data = (struct proc_data *)file->private_data;
 	if ( data->on_close != NULL ) data->on_close( inode, file );
-	MOD_DEC_USE_COUNT;
 	if ( data->rbuffer ) kfree( data->rbuffer );
 	if ( data->wbuffer ) kfree( data->wbuffer );
 	kfree( data );

