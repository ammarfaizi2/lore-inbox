Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263938AbRFDCmS>; Sun, 3 Jun 2001 22:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263936AbRFDCmJ>; Sun, 3 Jun 2001 22:42:09 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:2311 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S263935AbRFDCmE>; Sun, 3 Jun 2001 22:42:04 -0400
Message-ID: <3B1AF531.C31CB45C@psychosis.com>
Date: Sun, 03 Jun 2001 22:40:49 -0400
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
Organization: www.psychosis.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-raid <linux-raid@vger.kernel.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: md.c - devfs naming fix.
Content-Type: multipart/mixed;
 boundary="------------52D18297EF9355FAD1E9ED81"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------52D18297EF9355FAD1E9ED81
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Changes:
	Cleaned a few printk's

	Removed a meaningless ifndef.

	Moved md= name_to_ kdev_t() processing from md_setup() to
	md_setup_drive. Rewrote it and added devfs_find_handle() call
	to support devfs names for md=. 

The devfs_find_handle() code is now redundant in my patch and
fs/super.c::mount_root(). It probably should be moved directly into
name_to_kdev_t(), no? If this was done the md= code would have worked as is,
except for the devfs code choking on the trailing ',' in the device_names
list. (Richard, want to check for this in the future?)

This diff is against md.c in 2.4.4.
Comments/testing please.

Thanks to Neil Brown for the recommendation...
--------------52D18297EF9355FAD1E9ED81
Content-Type: text/plain; charset=us-ascii;
 name="md-devfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="md-devfs.diff"

--- md.c.orig	Sun Jun  3 13:58:35 2001
+++ md.c	Sun Jun  3 22:14:52 2001
@@ -3520,7 +3520,7 @@
 	max_readahead[MAJOR_NR] = md_maxreadahead;
 	hardsect_size[MAJOR_NR] = md_hardsect_sizes;
 
-	printk("md.c: sizeof(mdp_super_t) = %d\n", (int)sizeof(mdp_super_t));
+	dprintk("md: sizeof(mdp_super_t) = %d\n", (int)sizeof(mdp_super_t));
 
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("mdstat", 0, NULL, md_status_read_proc, NULL);
@@ -3532,7 +3532,7 @@
 	static char * name = "mdrecoveryd";
 	int minor;
 	
-	printk (KERN_INFO "md driver %d.%d.%d MAX_MD_DEVS=%d, MD_SB_DISKS=%d\n",
+	printk (KERN_INFO "md: md driver %d.%d.%d MAX_MD_DEVS=%d, MD_SB_DISKS=%d\n",
 			MD_MAJOR_VERSION, MD_MINOR_VERSION,
 			MD_PATCHLEVEL_VERSION, MAX_MD_DEVS, MD_SB_DISKS);
 
@@ -3607,7 +3607,7 @@
 	mdk_rdev_t *rdev;
 	int i;
 
-	printk(KERN_INFO "autodetecting RAID arrays\n");
+	printk(KERN_INFO "md: Autodetecting RAID arrays.\n");
 
 	for (i = 0; i < dev_cnt; i++) {
 		kdev_t dev = detected_devices[i];
@@ -3641,6 +3641,7 @@
 	int pers[MAX_MD_DEVS];
 	int chunk[MAX_MD_DEVS];
 	kdev_t devices[MAX_MD_DEVS][MD_SB_DISKS];
+	char *device_names[MAX_MD_DEVS];
 } md_setup_args md__initdata;
 
 /*
@@ -3659,25 +3660,24 @@
  *             md=n,device-list      reads a RAID superblock from the devices
  *             elements in device-list are read by name_to_kdev_t so can be
  *             a hex number or something like /dev/hda1 /dev/sdb
+ * 2001-06-03: Dave Cinege <dcinege@psychosis.com>
+ *		Shifted name_to_kdev_t() and related operations to md_set_drive()
+ *		for later execution. Rewrote section to make devfs compatible.
  */
-#ifndef MODULE
-extern kdev_t name_to_kdev_t(char *line) md__init;
 static int md__init md_setup(char *str)
 {
 	int minor, level, factor, fault, i=0;
-	kdev_t device;
-	char *devnames, *pername = "";
+	char *pername = "";
 
 	if (get_option(&str, &minor) != 2) {	/* MD Number */
 		printk("md: Too few arguments supplied to md=.\n");
 		return 0;
 	}
 	if (minor >= MAX_MD_DEVS) {
-		printk ("md: Minor device number too high.\n");
+		printk ("md: md=%d, Minor device number too high.\n", minor);
 		return 0;
-	} else if (md_setup_args.device_set[minor]) {
-		printk ("md: Warning - md=%d,... has been specified twice;\n"
-			"    will discard the first definition.\n", minor);
+	} else if (md_setup_args.device_names[minor]) {
+		printk ("md: md=%d, Specified more then once. Replacing previous definition.\n", minor);
 	}
 	switch (get_option(&str, &level)) {	/* RAID Personality */
 	case 2: /* could be 0 or -1.. */
@@ -3714,30 +3714,13 @@
 		md_setup_args.pers[minor] = 0;
 		pername="super-block";
 	}
-	devnames = str;
-	for (; i<MD_SB_DISKS && str; i++) {
-		if ((device = name_to_kdev_t(str))) {
-			md_setup_args.devices[minor][i] = device;
-		} else {
-			printk ("md: Unknown device name, %s.\n", str);
-			return 0;
-		}
-		if ((str = strchr(str, ',')) != NULL)
-			str++;
-	}
-	if (!i) {
-		printk ("md: No devices specified for md%d?\n", minor);
-		return 0;
-	}
-
-	printk ("md: Will configure md%d (%s) from %s, below.\n",
-		minor, pername, devnames);
-	md_setup_args.devices[minor][i] = (kdev_t) 0;
-	md_setup_args.device_set[minor] = 1;
+	
+	md_setup_args.device_names[minor] = str;
+			
 	return 1;
 }
-#endif /* !MODULE */
 
+extern kdev_t name_to_kdev_t(char *line) md__init;
 void md__init md_setup_drive(void)
 {
 	int minor, i;
@@ -3745,16 +3728,50 @@
 	mddev_t*mddev;
 
 	for (minor = 0; minor < MAX_MD_DEVS; minor++) {
+		int err = 0;
+		char *devname;
 		mdu_disk_info_t dinfo;
 
-		int err = 0;
-		if (!md_setup_args.device_set[minor])
-			continue;
-		printk("md: Loading md%d.\n", minor);
+		if ((devname = md_setup_args.device_names[minor]) == 0)	continue;
+	
+		for (i = 0; i < MD_SB_DISKS && devname != 0; i++) {
+
+			char *p, moredev = 0;
+			void *handle;
+	
+			if ((p = strchr(devname, ',')) != NULL) {
+				*p = 0; moredev = 1;	// dc: \0 ',' for devfs_find_handle()
+			}
+
+			dev = name_to_kdev_t(devname);
+			handle = devfs_find_handle(NULL, devname, MAJOR (dev), MINOR (dev),
+						    DEVFS_SPECIAL_BLK, 1);
+			if (handle != 0) {
+				unsigned major, minor;
+				devfs_get_maj_min(handle, &major, &minor);
+				dev = MKDEV(major, minor);
+			}
+			if (dev == 0) {
+				printk ("md: Unknown device name: %s\n", devname);
+				break;
+			}
+			
+			md_setup_args.devices[minor][i] = dev;
+			md_setup_args.device_set[minor] = 1;
+			
+			if (moredev == 1) { *p++ = ','; moredev = 0; }
+			devname = p;
+		}
+		md_setup_args.devices[minor][i] = (kdev_t) 0;
+		
+		if (md_setup_args.device_set[minor] == 0)	continue;
+		
 		if (mddev_map[minor].mddev) {
-			printk(".. md%d already autodetected - use raid=noautodetect\n", minor);
+			printk("md: Ignoring md=%d, already autodetected. (Use raid=noautodetect)\n", minor);
 			continue;
 		}
+		printk("md: Loading md%d: %s\n", minor, md_setup_args.device_names[minor]);
+		
 		mddev = alloc_mddev(MKDEV(MD_MAJOR,minor));
 		if (md_setup_args.pers[minor]) {
 			/* non-persistent */
@@ -3829,7 +3846,7 @@
 int md__init md_run_setup(void)
 {
 	if (raid_setup_args.noautodetect)
-		printk(KERN_INFO "skipping autodetection of RAID arrays\n");
+		printk(KERN_INFO "md: Skipping autodetection of RAID arrays. (raid=noautodetect)\n");
 	else
 		autostart_arrays();
 	md_setup_drive();

--------------52D18297EF9355FAD1E9ED81--

