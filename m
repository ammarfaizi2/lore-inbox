Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290155AbSAKW7Z>; Fri, 11 Jan 2002 17:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290159AbSAKW7Q>; Fri, 11 Jan 2002 17:59:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:20355 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S290155AbSAKW6w>;
	Fri, 11 Jan 2002 17:58:52 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Jan 2002 22:58:50 GMT
Message-Id: <UTC200201112258.WAA342022.aeb@cwi.nl>
To: linux@cwi.nl, linux-kernel@vger.kernel.org
Subject: [PATCH] BSD partitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.2.0-pre1 we have some broken code in check_and_add_bsd_partition.
It was fixed a little in 2.2.2, but it is still broken.
Now that people complained I sent a fixed version to Alan and Marcelo.

However, the actual job of check_and_add_bsd_partition() has nothing
to do with BSD or msdos, so I removed the "_bsd" and moved it to
check.c, and also changed its function a bit.

Andries


diff -u --recursive --new-file ../linux-2.5.2-pre11/linux/fs/partitions/check.c ./linux/fs/partitions/check.c
--- ../linux-2.5.2-pre11/linux/fs/partitions/check.c	Fri Jan 11 21:54:02 2002
+++ ./linux/fs/partitions/check.c	Fri Jan 11 23:11:04 2002
@@ -480,3 +480,28 @@
 
 	return 0;
 }
+
+/*
+ * Make sure that a proposed subpartition is strictly contained inside
+ * the parent partition.  If all is well, call add_gd_partition().
+ */
+int
+check_and_add_subpartition(struct gendisk *hd, int super_minor, int minor,
+			   int sub_start, int sub_size)
+{
+	int start = hd->part[super_minor].start_sect;
+	int size = hd->part[super_minor].nr_sects;
+
+	if (start == sub_start && size == sub_size) {
+		/* full parent partition, we have it already */
+		return 0;
+	}
+
+	if (start <= sub_start && start+size >= sub_start+sub_size) {
+		add_gd_partition(hd, minor, sub_start, sub_size);
+		return 1;
+	}
+
+	printk("bad subpartition - ignored\n");
+	return 0;
+}
diff -u --recursive --new-file ../linux-2.5.2-pre11/linux/fs/partitions/check.h ./linux/fs/partitions/check.h
--- ../linux-2.5.2-pre11/linux/fs/partitions/check.h	Fri Jan 11 21:54:02 2002
+++ ./linux/fs/partitions/check.h	Fri Jan 11 23:07:51 2002
@@ -7,4 +7,10 @@
  */
 void add_gd_partition(struct gendisk *hd, int minor, int start, int size);
 
+/*
+ * check_and_add_subpartition does the same for subpartitions
+ */
+int check_and_add_subpartition(struct gendisk *hd, int super_minor,
+			       int minor, int sub_start, int sub_size);
+
 extern int warn_no_part;
diff -u --recursive --new-file ../linux-2.5.2-pre11/linux/fs/partitions/msdos.c ./linux/fs/partitions/msdos.c
--- ../linux-2.5.2-pre11/linux/fs/partitions/msdos.c	Thu Oct 11 17:07:07 2001
+++ ./linux/fs/partitions/msdos.c	Fri Jan 11 23:24:23 2002
@@ -255,50 +255,6 @@
 }
 
 #ifdef CONFIG_BSD_DISKLABEL
-static void
-check_and_add_bsd_partition(struct gendisk *hd, struct bsd_partition *bsd_p,
-	int minor, int *current_minor)
-{
-	struct hd_struct *lin_p;
-		/* check relative position of partitions.  */
-	for (lin_p = hd->part + 1 + minor;
-	     lin_p - hd->part - minor < *current_minor; lin_p++) {
-			/* no relationship -> try again */
-		if (lin_p->start_sect + lin_p->nr_sects <= le32_to_cpu(bsd_p->p_offset) ||
-		    lin_p->start_sect >= le32_to_cpu(bsd_p->p_offset) + le32_to_cpu(bsd_p->p_size))
-			continue;	
-			/* equal -> no need to add */
-		if (lin_p->start_sect == le32_to_cpu(bsd_p->p_offset) && 
-			lin_p->nr_sects == le32_to_cpu(bsd_p->p_size)) 
-			return;
-			/* bsd living within dos partition */
-		if (lin_p->start_sect <= le32_to_cpu(bsd_p->p_offset) && lin_p->start_sect 
-			+ lin_p->nr_sects >= le32_to_cpu(bsd_p->p_offset) + le32_to_cpu(bsd_p->p_size)) {
-#ifdef DEBUG_BSD_DISKLABEL
-			printk("w: %d %ld+%ld,%d+%d", 
-				lin_p - hd->part, 
-				lin_p->start_sect, lin_p->nr_sects, 
-				le32_to_cpu(bsd_p->p_offset),
-				le32_to_cpu(bsd_p->p_size));
-#endif
-			break;
-		}
-	 /* ouch: bsd and linux overlap. Don't even try for that partition */
-#ifdef DEBUG_BSD_DISKLABEL
-		printk("???: %d %ld+%ld,%d+%d",
-			lin_p - hd->part, lin_p->start_sect, lin_p->nr_sects,
-			le32_to_cpu(bsd_p->p_offset), le32_to_cpu(bsd_p->p_size));
-#endif
-		printk("???");
-		return;
-	} /* if the bsd partition is not currently known to linux, we end
-	   * up here 
-	   */
-	add_gd_partition(hd, *current_minor, le32_to_cpu(bsd_p->p_offset),
-			 le32_to_cpu(bsd_p->p_size));
-	(*current_minor)++;
-}
-
 /* 
  * Create devices for BSD partitions listed in a disklabel, under a
  * dos-like partition. See extended_partition() for more information.
@@ -320,16 +276,22 @@
 		put_dev_sector(sect);
 		return;
 	}
-	printk(" %s: <%s", partition_name(hd, minor, buf), name);
+	printk(" %s: <%s:", partition_name(hd, minor, buf), name);
 
 	if (le16_to_cpu(l->d_npartitions) < max_partitions)
 		max_partitions = le16_to_cpu(l->d_npartitions);
-	for (p = l->d_partitions; p - l->d_partitions <  max_partitions; p++) {
+	for (p = l->d_partitions; p - l->d_partitions < max_partitions; p++) {
+		int bsd_start, bsd_size;
+
 		if ((*current_minor & mask) == 0)
 			break;
 		if (p->p_fstype == BSD_FS_UNUSED) 
 			continue;
-		check_and_add_bsd_partition(hd, p, minor, current_minor);
+		bsd_start = le32_to_cpu(p->p_offset);
+		bsd_size = le32_to_cpu(p->p_size);
+		if (check_and_add_subpartition(hd, minor, *current_minor,
+					       bsd_start, bsd_size))
+			(*current_minor)++;
 	}
 	put_dev_sector(sect);
 	printk(" >\n");
