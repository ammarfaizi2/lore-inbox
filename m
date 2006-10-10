Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWJJUqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWJJUqh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWJJUqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:46:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:50241 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030329AbWJJUqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:46:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=A97LP8+BQ3KORVg6Hh5dr3NuJlp9t+v/oP/Zg013bXEHiHbyuojL/4wn+dbD/HQVo/ksFqqBBC9zwMCvnvwd+OnoNTu2ijed3kKpx7O3OcZroyLx5rpN8vn0Uw0qyFvBsi6h+oPxdrY+Y+yeVgeOb6ayetZS2lu1dyfPockauxA=
Message-ID: <452C06A6.4030408@gmail.com>
Date: Tue, 10 Oct 2006 16:46:30 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: akpm@osdl.org, jgarzik@pobox.com
CC: linville@tuxdriver.com, linux-kernel@vger.kernel.org
Subject: [PATCH] airo.c: check returned values
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

create_proc_entry() can fail and return NULL in setup_proc_entry(), the
result must be checked before dereferencing. (Coverity ID 1443)

init_wifidev() & setup_proc_entry() can also fail in _init_airo_card().

This adds the checks & cleanup code and removes some whitespace.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

 airo.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 0a33c8a..9d5427a 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -2897,6 +2897,8 @@ static struct net_device *_init_airo_car
 		goto err_out_map;
 	}
 	ai->wifidev = init_wifidev(ai, dev);
+	if (!ai->wifidev)
+		goto err_out_reg;
 
 	set_bit(FLAG_REGISTERED,&ai->flags);
 	airo_print_info(dev->name, "MAC enabled %x:%x:%x:%x:%x:%x",
@@ -2908,11 +2910,18 @@ static struct net_device *_init_airo_car
 		for( i = 0; i < MAX_FIDS; i++ )
 			ai->fids[i] = transmit_allocate(ai,AIRO_DEF_MTU,i>=MAX_FIDS/2);
 
-	setup_proc_entry( dev, dev->priv ); /* XXX check for failure */
+	if (setup_proc_entry(dev, dev->priv) < 0)
+		goto err_out_wifi;
+
 	netif_start_queue(dev);
 	SET_MODULE_OWNER(dev);
 	return dev;
 
+err_out_wifi:
+	unregister_netdev(ai->wifidev);
+	free_netdev(ai->wifidev);
+err_out_reg:
+	unregister_netdev(dev);
 err_out_map:
 	if (test_bit(FLAG_MPI,&ai->flags) && pci) {
 		pci_free_consistent(pci, PCI_SHARED_LEN, ai->shared, ai->shared_dma);
@@ -4495,91 +4504,128 @@ static int setup_proc_entry( struct net_
 	apriv->proc_entry = create_proc_entry(apriv->proc_name,
 					      S_IFDIR|airo_perm,
 					      airo_entry);
-        apriv->proc_entry->uid = proc_uid;
-        apriv->proc_entry->gid = proc_gid;
-        apriv->proc_entry->owner = THIS_MODULE;
+	if (!apriv->proc_entry)
+		goto fail;
+	apriv->proc_entry->uid = proc_uid;
+	apriv->proc_entry->gid = proc_gid;
+	apriv->proc_entry->owner = THIS_MODULE;
 
 	/* Setup the StatsDelta */
 	entry = create_proc_entry("StatsDelta",
 				  S_IFREG | (S_IRUGO&proc_perm),
 				  apriv->proc_entry);
-        entry->uid = proc_uid;
-        entry->gid = proc_gid;
+	if (!entry)
+		goto fail_stats_delta;
+	entry->uid = proc_uid;
+	entry->gid = proc_gid;
 	entry->data = dev;
-        entry->owner = THIS_MODULE;
+	entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_statsdelta_ops);
 
 	/* Setup the Stats */
 	entry = create_proc_entry("Stats",
 				  S_IFREG | (S_IRUGO&proc_perm),
 				  apriv->proc_entry);
-        entry->uid = proc_uid;
-        entry->gid = proc_gid;
+	if (!entry)
+		goto fail_stats;
+	entry->uid = proc_uid;
+	entry->gid = proc_gid;
 	entry->data = dev;
-        entry->owner = THIS_MODULE;
+	entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_stats_ops);
 
 	/* Setup the Status */
 	entry = create_proc_entry("Status",
 				  S_IFREG | (S_IRUGO&proc_perm),
 				  apriv->proc_entry);
-        entry->uid = proc_uid;
-        entry->gid = proc_gid;
+	if (!entry)
+		goto fail_status;
+	entry->uid = proc_uid;
+	entry->gid = proc_gid;
 	entry->data = dev;
-        entry->owner = THIS_MODULE;
+	entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_status_ops);
 
 	/* Setup the Config */
 	entry = create_proc_entry("Config",
 				  S_IFREG | proc_perm,
 				  apriv->proc_entry);
-        entry->uid = proc_uid;
-        entry->gid = proc_gid;
+	if (!entry)
+		goto fail_config;
+	entry->uid = proc_uid;
+	entry->gid = proc_gid;
 	entry->data = dev;
-        entry->owner = THIS_MODULE;
+	entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_config_ops);
 
 	/* Setup the SSID */
 	entry = create_proc_entry("SSID",
 				  S_IFREG | proc_perm,
 				  apriv->proc_entry);
-        entry->uid = proc_uid;
-        entry->gid = proc_gid;
+	if (!entry)
+		goto fail_ssid;
+	entry->uid = proc_uid;
+	entry->gid = proc_gid;
 	entry->data = dev;
-        entry->owner = THIS_MODULE;
+	entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_SSID_ops);
 
 	/* Setup the APList */
 	entry = create_proc_entry("APList",
 				  S_IFREG | proc_perm,
 				  apriv->proc_entry);
-        entry->uid = proc_uid;
-        entry->gid = proc_gid;
+	if (!entry)
+		goto fail_aplist;
+	entry->uid = proc_uid;
+	entry->gid = proc_gid;
 	entry->data = dev;
-        entry->owner = THIS_MODULE;
+	entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_APList_ops);
 
 	/* Setup the BSSList */
 	entry = create_proc_entry("BSSList",
 				  S_IFREG | proc_perm,
 				  apriv->proc_entry);
+	if (!entry)
+		goto fail_bsslist;
 	entry->uid = proc_uid;
 	entry->gid = proc_gid;
 	entry->data = dev;
-        entry->owner = THIS_MODULE;
+	entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_BSSList_ops);
 
 	/* Setup the WepKey */
 	entry = create_proc_entry("WepKey",
 				  S_IFREG | proc_perm,
 				  apriv->proc_entry);
-        entry->uid = proc_uid;
-        entry->gid = proc_gid;
+	if (!entry)
+		goto fail_wepkey;
+	entry->uid = proc_uid;
+	entry->gid = proc_gid;
 	entry->data = dev;
-        entry->owner = THIS_MODULE;
+	entry->owner = THIS_MODULE;
 	SETPROC_OPS(entry, proc_wepkey_ops);
 
 	return 0;
+
+fail_wepkey:
+	remove_proc_entry("BSSList", apriv->proc_entry);
+fail_bsslist:
+	remove_proc_entry("APList", apriv->proc_entry);
+fail_aplist:
+	remove_proc_entry("SSID", apriv->proc_entry);
+fail_ssid:
+	remove_proc_entry("Config", apriv->proc_entry);
+fail_config:
+	remove_proc_entry("Status", apriv->proc_entry);
+fail_status:
+	remove_proc_entry("Stats", apriv->proc_entry);
+fail_stats:
+	remove_proc_entry("StatsDelta", apriv->proc_entry);
+fail_stats_delta:
+	remove_proc_entry(apriv->proc_name, airo_entry);
+fail:
+	return -ENOMEM;
 }
 
 static int takedown_proc_entry( struct net_device *dev,


