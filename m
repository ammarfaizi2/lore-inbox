Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318662AbSHEQMn>; Mon, 5 Aug 2002 12:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318643AbSHEQLk>; Mon, 5 Aug 2002 12:11:40 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:61326 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318650AbSHEQJ0>; Mon, 5 Aug 2002 12:09:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
Organization: IBM Deutschland Entwicklung GmbH
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 14/18 support for partition labels in devfs
Date: Mon, 5 Aug 2002 19:50:10 +0200
User-Agent: KMail/1.4.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com>
In-Reply-To: <200208051830.50713.arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208051950.10785.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new feature to the partition code. It will automatically
generate links in the device filesystem from the label name of a dasd to
the device node. This is only needed if the device filesystem is used.

diff -urN linux-2.4.19-rc3/fs/partitions/check.c linux-2.4.19-s390/fs/partitions/check.c
--- linux-2.4.19-rc3/fs/partitions/check.c	Wed Jul 24 17:14:40 2002
+++ linux-2.4.19-s390/fs/partitions/check.c	Wed Jul 24 17:12:17 2002
@@ -85,7 +85,7 @@
 #ifdef CONFIG_ARCH_S390
 int (*genhd_dasd_name)(char*,int,int,struct gendisk*) = NULL;
 int (*genhd_dasd_ioctl)(struct inode *inp, struct file *filp,
-			    unsigned int no, unsigned long data);
+			unsigned int no, unsigned long data);
 EXPORT_SYMBOL(genhd_dasd_name);
 EXPORT_SYMBOL(genhd_dasd_ioctl);
 #endif
@@ -277,6 +277,7 @@
 	int devnum = minor >> dev->minor_shift;
 	devfs_handle_t dir;
 	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
+	umode_t devfs_perm  = S_IFBLK | S_IRUSR | S_IWUSR;
 	char devname[16];
 
 	if (dev->part[minor + part].de) return;
@@ -284,11 +285,14 @@
 	if (!dir) return;
 	if ( dev->flags && (dev->flags[devnum] & GENHD_FL_REMOVABLE) )
 		devfs_flags |= DEVFS_FL_REMOVABLE;
+	if (is_read_only(MKDEV(dev->major, minor+part))) {
+	        devfs_perm &= ~(S_IWUSR);
+	}
 	sprintf (devname, "part%d", part);
 	dev->part[minor + part].de =
 	    devfs_register (dir, devname, devfs_flags,
 			    dev->major, minor + part,
-			    S_IFBLK | S_IRUSR | S_IWUSR,
+			    devfs_perm,
 			    dev->fops, NULL);
 }
 
@@ -300,12 +304,16 @@
 	int devnum = minor >> dev->minor_shift;
 	devfs_handle_t dir, slave;
 	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
+	umode_t devfs_perm  = S_IFBLK | S_IRUSR | S_IWUSR;
 	char dirname[64], symlink[16];
 	static devfs_handle_t devfs_handle;
 
 	if (dev->part[minor].de) return;
 	if ( dev->flags && (dev->flags[devnum] & GENHD_FL_REMOVABLE) )
 		devfs_flags |= DEVFS_FL_REMOVABLE;
+	if (is_read_only(MKDEV(dev->major, minor))) {
+	        devfs_perm &= ~(S_IWUSR);
+	}
 	if (dev->de_arr) {
 		dir = dev->de_arr[devnum];
 		if (!dir)  /*  Aware driver wants to block disc management  */
@@ -327,7 +335,7 @@
 			  dirname + pos, &slave, NULL);
 	dev->part[minor].de =
 	    devfs_register (dir, "disc", devfs_flags, dev->major, minor,
-			    S_IFBLK | S_IRUSR | S_IWUSR, dev->fops, NULL);
+			    devfs_perm, dev->fops, NULL);
 	devfs_auto_unregister (dev->part[minor].de, slave);
 	if (!dev->de_arr)
 		devfs_auto_unregister (slave, dir);
@@ -355,6 +363,10 @@
 		dev->part[minor].de = NULL;
 		devfs_dealloc_unique_number (&disc_numspace,
 					     dev->part[minor].number);
+		if(dev->label_arr && dev->label_arr[minor >> dev->minor_shift]) {
+			devfs_unregister(dev->label_arr[minor >> dev->minor_shift]);
+			dev->label_arr[minor >> dev->minor_shift] = NULL;
+		}
 	}
 #endif  /*  CONFIG_DEVFS_FS  */
 }
@@ -409,6 +421,93 @@
 		for (i = first_minor; i < end_minor; i++)
 			dev->sizes[i] = dev->part[i].nr_sects >> (BLOCK_SIZE_BITS - 9);
 	}
+}
+
+/*
+ * This function creates a link from /dev/labels/<labelname> to the devfs
+ * device directory. The device driver must allocate memory to the label_arr
+ * for this to work.
+ * This enables devices/partition tables that support labels to be accessed
+ * by that name instead of the device name (which can change if devices are
+ * moved around).
+ *
+ * Current restictions:
+ *   - Only the first device that uses a certain label creates the link
+ *     (which can also be good in case there is a backup device)
+ *   - When removing devices that created labels previously suppressed
+ *     devices won't show up.
+ */
+void register_disk_label(struct gendisk *hd, int minor, char *label) {
+#ifdef CONFIG_DEVFS_FS
+	int                   disknum         = minor >> hd->minor_shift;
+	static devfs_handle_t devfs_label_dir = NULL;
+	int                   i;
+
+	/*
+	 * Check the given label. Trailing whitespaces are removed. Otherwise
+	 * only alphanumeric characters are allowed. (fstab)
+	 * Added [$#%@] since these are allowed by fdasd and seem
+	 * to work in fstab.
+	 */
+	for(i=0; label[i] != '\0'; i++);
+	for(i--; i >= 0; i--) {
+		if(label[i] == ' ' && label[i+1] == '\0') {
+			label[i] = '\0';
+			continue;
+		}
+		if(
+			label[i] == '$' || label[i] == '#' ||
+			label[i] == '@' || label[i] == '%'
+		)
+			continue;
+		if(label[i] >= 'a' && label[i] <= 'z')
+			continue;
+		if(label[i] >= 'A' && label[i] <= 'Z')
+			continue;
+		if(label[i] >= '0' && label[i] <= '9')
+			continue;
+
+		printk(KERN_WARNING "\nregister_disk_label: invalid character(s)"
+			" in label <%s>\n", label);
+		printk(KERN_WARNING "register_label: refusing to create devfs entry.\n");
+		return;
+	}
+
+	if(!hd->label_arr)
+		return;
+
+	if(!devfs_label_dir)
+		if(!(devfs_label_dir = devfs_mk_dir(NULL, "labels", NULL)))
+			return;
+
+	if(hd->label_arr[disknum]) {
+		if(strcmp(devfs_get_name(hd->label_arr[disknum], NULL), label) == 0)
+			return;
+
+		devfs_unregister(hd->label_arr[disknum]);
+		hd->label_arr[disknum] = NULL;
+	}
+	if(!devfs_find_handle(devfs_label_dir, label, 0, 0, 0, 0)) {
+		int  pos      = 0;
+		char path[64];
+
+		if(hd->de_arr) {
+			if(!hd->de_arr[disknum])
+				return;
+
+			pos = devfs_generate_path(hd->de_arr[disknum], path+3, sizeof(path)-3);
+			if(pos < 0)
+				return;
+
+			strncpy(path+pos, "../", 3);
+		} else {
+			sprintf(path, "../%s/disc/%d", hd->major_name, disknum);
+		}
+		devfs_mk_symlink(
+			devfs_label_dir, label, DEVFS_FL_DEFAULT, path+pos,
+			&hd->label_arr[disknum], NULL);
+	}
+#endif
 }
 
 unsigned char *read_dev_sector(struct block_device *bdev, unsigned long n, Sector *p)
diff -urN linux-2.4.19-rc3/fs/partitions/check.h linux-2.4.19-s390/fs/partitions/check.h
--- linux-2.4.19-rc3/fs/partitions/check.h	Tue Oct  2 05:03:26 2001
+++ linux-2.4.19-s390/fs/partitions/check.h	Wed Jul 24 17:01:16 2002
@@ -13,4 +13,6 @@
 	page_cache_release(p.v);
 }
 
+void register_disk_label(struct gendisk *hd, int minor, char *label);
+
 extern int warn_no_part;
diff -urN linux-2.4.19-rc3/fs/partitions/ibm.c linux-2.4.19-s390/fs/partitions/ibm.c
--- linux-2.4.19-rc3/fs/partitions/ibm.c	Wed Jul 24 17:14:40 2002
+++ linux-2.4.19-s390/fs/partitions/ibm.c	Wed Jul 24 17:01:16 2002
@@ -123,6 +123,7 @@
 	data = read_dev_sector(bdev, info->label_block*(blocksize/512), &sect);
 	if (data == NULL)
 		goto out_readerr;
+
 	strncpy (type, data, 4);
 	if ((!info->FBA_layout) && (!strcmp(info->type, "ECKD")))
 		strncpy(name, data + 8, 6);
@@ -134,6 +135,9 @@
 	EBCASC(type, 4);
 	EBCASC(name, 6);
 
+	if(name[0] != '\0')
+		register_disk_label(hd, MINOR(to_kdev_t(bdev->bd_dev)), name);
+
 	/*
 	 * Three different types: CMS1, VOL1 and LNX1/unlabeled
 	 */
@@ -214,7 +218,7 @@
 		// add_gd_partition(hd, first_part_minor - 1, 0, size);
 		add_gd_partition(hd, first_part_minor,
 				 offset*(blocksize >> 9),
-				  size-offset*(blocksize >> 9));
+				 size-offset*(blocksize >> 9));
 	}
 
 	printk("\n");
diff -urN linux-2.4.19-rc3/include/linux/genhd.h linux-2.4.19-s390/include/linux/genhd.h
--- linux-2.4.19-rc3/include/linux/genhd.h	Wed Jul 24 17:14:42 2002
+++ linux-2.4.19-s390/include/linux/genhd.h	Wed Jul 24 17:12:30 2002
@@ -100,6 +100,7 @@
 
 	devfs_handle_t *de_arr;         /* one per physical disc */
 	char *flags;                    /* one per physical disc */
+	devfs_handle_t *label_arr;      /* one per physical disc */
 };
 
 /* drivers/block/genhd.c */


