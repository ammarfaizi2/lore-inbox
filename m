Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263769AbTCVR2d>; Sat, 22 Mar 2003 12:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263772AbTCVR2d>; Sat, 22 Mar 2003 12:28:33 -0500
Received: from verein.lst.de ([212.34.181.86]:20486 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S263769AbTCVR22>;
	Sat, 22 Mar 2003 12:28:28 -0500
Date: Sat, 22 Mar 2003 18:39:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: bcollins@debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bring back Al's devfs changes in dv1394
Message-ID: <20030322183926.A21623@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	bcollins@debian.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

needed to get the only callder of devfs_mk_dir where the first argument
is not NULL back in shape.  Also a nice code cleanup..


--- a/drivers/ieee1394/dv1394.c	Sat Mar 22 15:36:34 2003
+++ b/drivers/ieee1394/dv1394.c	Sat Mar 22 15:36:34 2003
@@ -177,15 +177,6 @@
 
 static struct hpsb_highlevel *hl_handle; /* = NULL; */
 
-static LIST_HEAD(dv1394_devfs);
-struct dv1394_devfs_entry {
-	struct list_head list;
-    devfs_handle_t devfs;
-	char name[32];
-	struct dv1394_devfs_entry *parent;
-};
-static spinlock_t dv1394_devfs_lock = SPIN_LOCK_UNLOCKED;
-
 /* translate from a struct file* to the corresponding struct video_card* */
 
 static inline struct video_card* file_to_video_card(struct file *file)
@@ -2456,137 +2447,25 @@
 };
 
 
-/*** DEVFS HELPERS *********************************************************/
-
-struct dv1394_devfs_entry *
-dv1394_devfs_find( char *name)
-{
-	struct list_head *lh;
-	struct dv1394_devfs_entry *p;
-
-	spin_lock( &dv1394_devfs_lock);
-	if(!list_empty(&dv1394_devfs)) {
-		list_for_each(lh, &dv1394_devfs) {
-			p = list_entry(lh, struct dv1394_devfs_entry, list);
-			if(!strncmp(p->name, name, sizeof(p->name))) {
-				goto found;
-			}
-		}
-	}
-	p = NULL;
-	
-found:
-	spin_unlock( &dv1394_devfs_lock);
-	return p;
-}
-
 #ifdef CONFIG_DEVFS_FS
 static int dv1394_devfs_add_entry(struct video_card *video)
 {
-	char buf[32];
-	struct dv1394_devfs_entry *p;
-	struct dv1394_devfs_entry *parent;
+	char buf[64];
 
-	p = kmalloc(sizeof(struct dv1394_devfs_entry), GFP_KERNEL);
-	if(!p) {
-		printk(KERN_ERR "dv1394: cannot allocate dv1394_devfs_entry\n");
-		goto err;
-	}
-	memset(p, 0, sizeof(struct dv1394_devfs_entry));
-	
-	snprintf(buf, sizeof(buf), "dv/host%d/%s", (video->id>>2),
-						(video->pal_or_ntsc == DV1394_NTSC ? "NTSC" : "PAL"));
-		
-	parent = dv1394_devfs_find(buf);
-	if (parent == NULL) {
-		printk(KERN_ERR "dv1394: unable to locate parent devfs of %s\n", buf);
-		goto err_free;
-	}
-	
-	video->devfs_handle = devfs_register(
-						 parent->devfs,
-					     (video->mode == MODE_RECEIVE ? "in" : "out"),
-						 DEVFS_FL_NONE,
-					     IEEE1394_MAJOR,
+	snprintf(buf, sizeof(buf), "ieee1394/dv/host%d/%s/%s",
+		(video->id>>2),
+		(video->pal_or_ntsc == DV1394_NTSC ? "NTSC" : "PAL"),
+		(video->mode == MODE_RECEIVE ? "in" : "out"));
+
+	video->devfs_handle = devfs_register(NULL, buf, 0, IEEE1394_MAJOR,
 					     IEEE1394_MINOR_BLOCK_DV1394*16 + video->id,
 					     S_IFCHR | S_IRUGO | S_IWUGO,
-					     &dv1394_fops,
-					     (void*) video);
-	p->devfs = video->devfs_handle;
-
-	if (p->devfs == NULL) {
-		printk(KERN_ERR "dv1394: unable to create /dev/ieee1394/%s/%s\n",
-			parent->name,
-			(video->mode == MODE_RECEIVE ? "in" : "out"));
-		goto err_free;
-	}
-	
-	spin_lock( &dv1394_devfs_lock);
-	INIT_LIST_HEAD(&p->list);
-	list_add_tail(&p->list, &dv1394_devfs);
-	spin_unlock( &dv1394_devfs_lock);
-	
-	return 0;
-	
- err_free:
-	kfree(p);
- err:
-	return -ENOMEM;
-}
-
-static int
-dv1394_devfs_add_dir( char *name,
-					struct dv1394_devfs_entry *parent, 
-					struct dv1394_devfs_entry **out)
-{
-	struct dv1394_devfs_entry *p;
-
-	p = kmalloc(sizeof(struct dv1394_devfs_entry), GFP_KERNEL);
-	if(!p) {
-		printk(KERN_ERR "dv1394: cannot allocate dv1394_devfs_entry\n");
-		goto err;
-	}
-	memset(p, 0, sizeof(struct dv1394_devfs_entry));
-	
-	if (parent == NULL) {
-		snprintf(p->name, sizeof(p->name), "%s", name);
-		p->devfs = devfs_mk_dir(ieee1394_devfs_handle, name, NULL);
-	} else {
-		snprintf(p->name, sizeof(p->name), "%s/%s", parent->name, name);
-		p->devfs = devfs_mk_dir(parent->devfs, name, NULL);
-	}
-	if (p->devfs == NULL) {
-		printk(KERN_ERR "dv1394: unable to create /dev/ieee1394/%s\n", p->name);
-		goto err_free;
+					     &dv1394_fops, video);
+	if (video->devfs_handle == NULL) {
+		printk(KERN_ERR "dv1394: unable to create /dev/%s\n", buf);
+		return -ENOMEM;
 	}
-
-	p->parent = parent;
-	if (out != NULL) *out = p;
-
-	spin_lock( &dv1394_devfs_lock);
-	INIT_LIST_HEAD(&p->list);
-	list_add_tail(&p->list, &dv1394_devfs);
-	spin_unlock( &dv1394_devfs_lock);
-
 	return 0;
-	
- err_free:
-	kfree(p);
- err:
-	return -ENOMEM;
-}
-
-void dv1394_devfs_del( char *name)
-{
-	struct dv1394_devfs_entry *p = dv1394_devfs_find(name);
-	if (p != NULL) {
-		devfs_unregister(p->devfs);
-		
-		spin_lock( &dv1394_devfs_lock);
-		list_del(&p->list);
-		spin_unlock( &dv1394_devfs_lock);
-		kfree(p);
-	}
 }
 #endif /* CONFIG_DEVFS_FS */
 
@@ -2664,7 +2543,7 @@
 	
 #ifdef CONFIG_DEVFS_FS
 	if (dv1394_devfs_add_entry(video) < 0)
-			goto err_free;
+		goto err_free;
 #endif
 
 	debug_printk("dv1394: dv1394_init() OK on ID %d\n", video->id);
@@ -2687,8 +2566,9 @@
 		(video->pal_or_ntsc == DV1394_NTSC ? "NTSC" : "PAL"),
 		(video->mode == MODE_RECEIVE ? "in" : "out")
 		);
+
 #ifdef CONFIG_DEVFS_FS
-	dv1394_devfs_del(buf);
+	devfs_remove("ieee1394/%s", buf);
 #endif
 #ifdef CONFIG_PROC_FS
 	dv1394_procfs_del(buf);
@@ -2726,13 +2606,11 @@
 	spin_unlock_irqrestore(&dv1394_cards_lock, flags);
 
 	n = (video->id >> 2);
+
 #ifdef CONFIG_DEVFS_FS
-	snprintf(buf, sizeof(buf), "dv/host%d/NTSC", n);
-	dv1394_devfs_del(buf);
-	snprintf(buf, sizeof(buf), "dv/host%d/PAL", n);
-	dv1394_devfs_del(buf);
-	snprintf(buf, sizeof(buf), "dv/host%d", n);
-	dv1394_devfs_del(buf);
+	devfs_remove("ieee1394/dv/host%d/NTSC", n);
+	devfs_remove("ieee1394/dv/host%d/PAL", n);
+	devfs_remove("ieee1394/dv/host%d", n);
 #endif
 
 #ifdef CONFIG_PROC_FS
@@ -2770,15 +2648,12 @@
 #endif
 
 #ifdef CONFIG_DEVFS_FS
-{
-	struct dv1394_devfs_entry *devfs_entry = dv1394_devfs_find("dv");
-	if (devfs_entry != NULL) {
-		snprintf(buf, sizeof(buf), "host%d", ohci->id);
-		dv1394_devfs_add_dir(buf, devfs_entry, &devfs_entry);
-		dv1394_devfs_add_dir("NTSC", devfs_entry, NULL);
-		dv1394_devfs_add_dir("PAL", devfs_entry, NULL);
-	}
-}
+	snprintf(buf, sizeof(buf), "ieee1394/dv/host%d", ohci->id);
+	devfs_mk_dir(NULL, buf, NULL);
+	snprintf(buf, sizeof(buf), "ieee1394/dv/host%d/NTSC", ohci->id);
+	devfs_mk_dir(NULL, buf, NULL);
+	snprintf(buf, sizeof(buf), "ieee1394/dv/host%d/PAL", ohci->id);
+	devfs_mk_dir(NULL, buf, NULL);
 #endif
 	
 	dv1394_init(ohci, DV1394_NTSC, MODE_RECEIVE);
@@ -3028,7 +2903,7 @@
 	hpsb_unregister_highlevel (hl_handle);
 	ieee1394_unregister_chardev(IEEE1394_MINOR_BLOCK_DV1394);
 #ifdef CONFIG_DEVFS_FS
-	dv1394_devfs_del("dv");
+	devfs_remove("ieee1394/dv");
 #endif
 #ifdef CONFIG_PROC_FS
 	dv1394_procfs_del("dv");
@@ -3047,8 +2922,7 @@
 	}
 
 #ifdef CONFIG_DEVFS_FS
-	ret = dv1394_devfs_add_dir("dv", NULL, NULL);
-	if (ret < 0) {
+	if (!devfs_mk_dir(NULL, "ieee1394/dv", NULL)) {
 		printk(KERN_ERR "dv1394: unable to create /dev/ieee1394/dv\n");
 		ieee1394_unregister_chardev(IEEE1394_MINOR_BLOCK_DV1394);
 		return -ENOMEM;
@@ -3061,7 +2935,7 @@
 		printk(KERN_ERR "dv1394: unable to create /proc/bus/ieee1394/dv\n");
 		ieee1394_unregister_chardev(IEEE1394_MINOR_BLOCK_DV1394);
 #ifdef CONFIG_DEVFS_FS
-		dv1394_devfs_del("dv");
+		devfs_remove("ieee1394/dv");
 #endif
 		return -ENOMEM;
 	}
@@ -3072,7 +2946,7 @@
 		printk(KERN_ERR "dv1394: hpsb_register_highlevel failed\n");
 		ieee1394_unregister_chardev(IEEE1394_MINOR_BLOCK_DV1394);
 #ifdef CONFIG_DEVFS_FS
-		dv1394_devfs_del("dv");
+		devfs_remove("ieee1394/dv");
 #endif
 #ifdef CONFIG_PROC_FS
 		dv1394_procfs_del("dv");
