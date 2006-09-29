Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWI2CxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWI2CxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWI2CxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:53:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:58807 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751377AbWI2CxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:53:10 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 12:52:59 +1000
Message-Id: <1060929025259.15214@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 6] md: Remove MAX_MD_DEVS which is an arbitrary limit.
References: <20060929125047.14064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Once upon a time we needed to fixed limit to the number of md
devices, probably because we preallocated some array.
This need no longer exists, but we still have an arbitrary limit.

So remove MAX_MD_DEVS and allow as many devices as we can fit into the
'minor' part of a device number.

Also remove some useless noise at init time (which reports
MAX_MD_DEVS) and remove MD_THREAD_NAME_MAX which hasn't been used for
a while.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c           |   33 +++++++++++++++------------------
 ./include/linux/raid/md_k.h |    5 +----
 ./init/do_mounts_md.c       |    8 ++------
 3 files changed, 18 insertions(+), 28 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-09-29 11:44:38.000000000 +1000
+++ ./drivers/md/md.c	2006-09-29 11:49:00.000000000 +1000
@@ -3409,6 +3409,7 @@ static void autorun_devices(int part)
 
 	printk(KERN_INFO "md: autorun ...\n");
 	while (!list_empty(&pending_raid_disks)) {
+		int unit;
 		dev_t dev;
 		LIST_HEAD(candidates);
 		rdev0 = list_entry(pending_raid_disks.next,
@@ -3428,16 +3429,19 @@ static void autorun_devices(int part)
 		 * mostly sane superblocks. It's time to allocate the
 		 * mddev.
 		 */
-		if (rdev0->preferred_minor < 0 || rdev0->preferred_minor >= MAX_MD_DEVS) {
+		if (part) {
+			dev = MKDEV(mdp_major,
+				    rdev0->preferred_minor << MdpMinorShift);
+			unit = MINOR(dev) >> MdpMinorShift;
+		} else {
+			dev = MKDEV(MD_MAJOR, rdev0->preferred_minor);
+			unit = MINOR(dev);
+		}
+		if (rdev0->preferred_minor != unit) {
 			printk(KERN_INFO "md: unit number in %s is bad: %d\n",
 			       bdevname(rdev0->bdev, b), rdev0->preferred_minor);
 			break;
 		}
-		if (part)
-			dev = MKDEV(mdp_major,
-				    rdev0->preferred_minor << MdpMinorShift);
-		else
-			dev = MKDEV(MD_MAJOR, rdev0->preferred_minor);
 
 		md_probe(dev, NULL, NULL);
 		mddev = mddev_find(dev);
@@ -5524,22 +5528,15 @@ static void md_geninit(void)
 
 static int __init md_init(void)
 {
-	printk(KERN_INFO "md: md driver %d.%d.%d MAX_MD_DEVS=%d,"
-			" MD_SB_DISKS=%d\n",
-			MD_MAJOR_VERSION, MD_MINOR_VERSION,
-			MD_PATCHLEVEL_VERSION, MAX_MD_DEVS, MD_SB_DISKS);
-	printk(KERN_INFO "md: bitmap version %d.%d\n", BITMAP_MAJOR_HI,
-			BITMAP_MINOR);
-
 	if (register_blkdev(MAJOR_NR, "md"))
 		return -1;
 	if ((mdp_major=register_blkdev(0, "mdp"))<=0) {
 		unregister_blkdev(MAJOR_NR, "md");
 		return -1;
 	}
-	blk_register_region(MKDEV(MAJOR_NR, 0), MAX_MD_DEVS, THIS_MODULE,
-				md_probe, NULL, NULL);
-	blk_register_region(MKDEV(mdp_major, 0), MAX_MD_DEVS<<MdpMinorShift, THIS_MODULE,
+	blk_register_region(MKDEV(MAJOR_NR, 0), 1UL<<MINORBITS, THIS_MODULE,
+			    md_probe, NULL, NULL);
+	blk_register_region(MKDEV(mdp_major, 0), 1UL<<MINORBITS, THIS_MODULE,
 			    md_probe, NULL, NULL);
 
 	register_reboot_notifier(&md_notifier);
@@ -5598,8 +5595,8 @@ static __exit void md_exit(void)
 	mddev_t *mddev;
 	struct list_head *tmp;
 
-	blk_unregister_region(MKDEV(MAJOR_NR,0), MAX_MD_DEVS);
-	blk_unregister_region(MKDEV(mdp_major,0), MAX_MD_DEVS << MdpMinorShift);
+	blk_unregister_region(MKDEV(MAJOR_NR,0), 1U << MINORBITS);
+	blk_unregister_region(MKDEV(mdp_major,0), 1U << MINORBITS);
 
 	unregister_blkdev(MAJOR_NR,"md");
 	unregister_blkdev(mdp_major, "mdp");

diff .prev/include/linux/raid/md_k.h ./include/linux/raid/md_k.h
--- .prev/include/linux/raid/md_k.h	2006-09-29 11:44:34.000000000 +1000
+++ ./include/linux/raid/md_k.h	2006-09-29 11:49:00.000000000 +1000
@@ -31,18 +31,15 @@
 #define	LEVEL_NONE		(-1000000)
 
 #define MaxSector (~(sector_t)0)
-#define MD_THREAD_NAME_MAX 14
 
 typedef struct mddev_s mddev_t;
 typedef struct mdk_rdev_s mdk_rdev_t;
 
-#define MAX_MD_DEVS  256	/* Max number of md dev */
-
 /*
  * options passed in raidrun:
  */
 
-/* Currently this must fix in an 'int' */
+/* Currently this must fit in an 'int' */
 #define MAX_CHUNK_SIZE (1<<30)
 
 /*

diff .prev/init/do_mounts_md.c ./init/do_mounts_md.c
--- .prev/init/do_mounts_md.c	2006-09-29 11:38:46.000000000 +1000
+++ ./init/do_mounts_md.c	2006-09-29 11:49:00.000000000 +1000
@@ -20,7 +20,7 @@ static struct {
 	int level;
 	int chunk;
 	char *device_names;
-} md_setup_args[MAX_MD_DEVS] __initdata;
+} md_setup_args[256] __initdata;
 
 static int md_setup_ents __initdata;
 
@@ -61,10 +61,6 @@ static int __init md_setup(char *str)
 		return 0;
 	}
 	str1 = str;
-	if (minor >= MAX_MD_DEVS) {
-		printk(KERN_WARNING "md: md=%d, Minor device number too high.\n", minor);
-		return 0;
-	}
 	for (ent=0 ; ent< md_setup_ents ; ent++)
 		if (md_setup_args[ent].minor == minor &&
 		    md_setup_args[ent].partitioned == partitioned) {
@@ -72,7 +68,7 @@ static int __init md_setup(char *str)
 			       "Replacing previous definition.\n", partitioned?"d":"", minor);
 			break;
 		}
-	if (ent >= MAX_MD_DEVS) {
+	if (ent >= ARRAY_SIZE(md_setup_args)) {
 		printk(KERN_WARNING "md: md=%s%d - too many md initialisations\n", partitioned?"d":"", minor);
 		return 0;
 	}
