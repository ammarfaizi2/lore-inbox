Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbUKJEdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUKJEdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 23:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbUKJEdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 23:33:08 -0500
Received: from mail.gmx.de ([213.165.64.20]:36999 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261868AbUKJEbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 23:31:38 -0500
X-Authenticated: #21910825
Message-ID: <419199A3.3050806@gmx.net>
Date: Wed, 10 Nov 2004 05:31:31 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Partitioned loop devices, support for 127 Partitions on SATA,
 IDE and SCSI
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

having seen the problems people have when switching from traditional IDE
drivers to libata if they have more than 15 partitions, I decided to do
something against it. With this patch (and recreating /dev/loop* nodes)
it is possible to support up to 127 partitions per loop device
regardless what the underlying device supports. It works for me
and has the added bonus that it will be in compatibility mode as long
as you don't specify the max_part parameter.

To make migration to the new loop version easy, the new default loop
behaviour is exactly the same as the old one, so you should not notice
any breakage. However, if you decide to enable partitioned loop support
by specifying the max_part parameter, loop devices will have major
number 240, currently reserved for local/experimental use, and loopN
will have the minor range [N*max_part, (N+1)*max_part-1].

For even easier migration, the partition table will NOT be read by
default on losetup so you even can use unpartitioned loop devices when
being no longer in compat mode. If you want to activate partitions for
/dev/loopN, just issue "blockdev --rereadpt /dev/loopN" and the
partitions will magically appear in /sys/block/loopN/.

Demo follows:
linux:~ # ls /sys/block/hdb/
.       hdb12  hdb19  hdb25  hdb32  hdb39  hdb46  hdb52  hdb59  hdb8
..      hdb13  hdb2   hdb26  hdb33  hdb40  hdb47  hdb53  hdb6   hdb9
dev     hdb14  hdb20  hdb27  hdb34  hdb41  hdb48  hdb54  hdb60  queue
device  hdb15  hdb21  hdb28  hdb35  hdb42  hdb49  hdb55  hdb61  range
hdb1    hdb16  hdb22  hdb29  hdb36  hdb43  hdb5   hdb56  hdb62  removable
hdb10   hdb17  hdb23  hdb30  hdb37  hdb44  hdb50  hdb57  hdb63  size
hdb11   hdb18  hdb24  hdb31  hdb38  hdb45  hdb51  hdb58  hdb7   stat
linux:~ # losetup /dev/loop0 /dev/hdb
linux:~ # ls /sys/block/loop0/
.  ..  dev  range  removable  size  stat
linux:~ # blockdev --rereadpt /dev/loop0
linux:~ # ls /sys/block/loop0/
.         loop0p17  loop0p27  loop0p38  loop0p49  loop0p59  loop0p69  loop0p79
..        loop0p18  loop0p28  loop0p39  loop0p5   loop0p6   loop0p7   loop0p8
dev       loop0p19  loop0p29  loop0p40  loop0p50  loop0p60  loop0p70  loop0p80
loop0p1   loop0p2   loop0p30  loop0p41  loop0p51  loop0p61  loop0p71  loop0p81
loop0p10  loop0p20  loop0p31  loop0p42  loop0p52  loop0p62  loop0p72  loop0p82
loop0p11  loop0p21  loop0p32  loop0p43  loop0p53  loop0p63  loop0p73  loop0p83
loop0p12  loop0p22  loop0p33  loop0p44  loop0p54  loop0p64  loop0p74  loop0p9
loop0p13  loop0p23  loop0p34  loop0p45  loop0p55  loop0p65  loop0p75  range
loop0p14  loop0p24  loop0p35  loop0p46  loop0p56  loop0p66  loop0p76  removable
loop0p15  loop0p25  loop0p36  loop0p47  loop0p57  loop0p67  loop0p77  size
loop0p16  loop0p26  loop0p37  loop0p48  loop0p58  loop0p68  loop0p78  stat
linux:~ # mount /dev/loop0p83 /mnt/
linux:~ # cat /sys/block/loop0/dev
240:0
linux:~ # dmesg|tail -6
 loop0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21
 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40
 p41 p42 p43 p44 p45 p46 p47 p48 p49 p50 p51 p52 p53 p54 p55 p56 p57 p58 p59
 p60 p61 p62 p63 p64 p65 p66 p67 p68 p69 p70 p71 p72 p73 p74 p75 p76 p77 p78
 p79 p80 p81 p82 p83 >
ReiserFS: loop0p83: found reiserfs format "3.6" with standard journal
ReiserFS: loop0p83: using ordered data mode
ReiserFS: loop0p83: journal params: device loop0p83, size 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
ReiserFS: loop0p83: checking transaction log (loop0p83)
ReiserFS: loop0p83: Using r5 hash to sort names
linux:~ #

Have fun!
Carl-Daniel
http://www.hailfinger.org/


Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>

--- ./linux-2.6.9/drivers/block/loop.c~	2004-11-05 14:28:06.000000000 +0100
+++ ./linux-2.6.9/drivers/block/loop.c	2004-11-10 04:53:47.978496392 +0100
@@ -39,6 +39,9 @@
  * Support up to 256 loop devices
  * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
  *
+ * Support partitioned loop devices.
+ * Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
+ *
  * Still To Fix:
  * - Advisory locking is ignored here.
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
@@ -71,6 +74,7 @@
 #include <asm/uaccess.h>

 static int max_loop = 8;
+static int max_part = 1;
 static struct loop_device *loop_dev;
 static struct gendisk **disks;

@@ -759,7 +763,9 @@
 static int loop_clr_fd(struct loop_device *lo, struct block_device *bdev)
 {
 	struct file *filp = lo->lo_backing_file;
+	struct gendisk *disk = disks[lo->lo_number];
 	int gfp = lo->old_gfp_mask;
+	int p, res;

 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
@@ -792,8 +798,17 @@
 	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
 	memset(lo->lo_crypt_name, 0, LO_NAME_SIZE);
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
+
+	res = invalidate_partition(disk, 0);
+	if (res) {
+		printk(KERN_WARNING "loop: invalidate_partition(disk, 0) for loop%i returned %i!\n", lo->lo_number, res);
+		/* return res; */
+	}
+	for (p = 1; p < disk->minors; p++)
+		delete_partition(disk, p);
+
 	invalidate_bdev(bdev, 0);
-	set_capacity(disks[lo->lo_number], 0);
+	set_capacity(disk, 0);
 	bd_set_size(bdev, 0);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
 	lo->lo_state = Lo_unbound;
@@ -1075,8 +1090,11 @@
  */
 module_param(max_loop, int, 0);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");
+module_param(max_part, int, 0);
+MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device (1-128)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
+MODULE_ALIAS_BLOCKDEV_MAJOR(MY_DYN_MAJOR_START);

 int loop_register_transfer(struct loop_func_table *funcs)
 {
@@ -1124,7 +1142,21 @@
 		max_loop = 8;
 	}

-	if (register_blkdev(LOOP_MAJOR, "loop"))
+	if (max_part < 1 || max_part > 128) {
+		printk(KERN_WARNING "loop: invalid max_part (must be between"
+				    " 1 and 128), using default (1)\n");
+		max_part = 1;
+	}
+
+	if (max_loop * max_part > (1 << MINORBITS)) {
+		printk(KERN_WARNING "loop: max_loop*max_part is too big (must"
+				"be <=%u), using default for both\n",
+				(1 << MINORBITS));
+		max_loop = 8;
+		max_part = 1;
+	}
+
+	if (register_blkdev((max_part > 1) ? MY_DYN_MAJOR_START : LOOP_MAJOR, "loop"))
 		return -EIO;

 	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
@@ -1137,7 +1169,7 @@
 		goto out_mem2;

 	for (i = 0; i < max_loop; i++) {
-		disks[i] = alloc_disk(1);
+		disks[i] = alloc_disk(max_part);
 		if (!disks[i])
 			goto out_mem3;
 	}
@@ -1157,8 +1189,8 @@
 		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
-		disk->major = LOOP_MAJOR;
-		disk->first_minor = i;
+		disk->major = (max_part > 1) ? MY_DYN_MAJOR_START : LOOP_MAJOR;
+		disk->first_minor = i * (max_part);
 		disk->fops = &lo_fops;
 		sprintf(disk->disk_name, "loop%d", i);
 		sprintf(disk->devfs_name, "loop/%d", i);
@@ -1169,7 +1201,8 @@
 	/* We cannot fail after we call this, so another loop!*/
 	for (i = 0; i < max_loop; i++)
 		add_disk(disks[i]);
-	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
+	printk(KERN_INFO "loop: loaded (max %d devices, max %d partitions per"
+			" device)\n", max_loop, max_part);
 	return 0;

 out_mem4:
@@ -1184,7 +1217,7 @@
 out_mem2:
 	kfree(loop_dev);
 out_mem1:
-	unregister_blkdev(LOOP_MAJOR, "loop");
+	unregister_blkdev((max_part > 1) ? MY_DYN_MAJOR_START : LOOP_MAJOR, "loop");
 	printk(KERN_ERR "loop: ran out of memory\n");
 	return -ENOMEM;
 }
@@ -1199,7 +1232,7 @@
 		put_disk(disks[i]);
 	}
 	devfs_remove("loop");
-	if (unregister_blkdev(LOOP_MAJOR, "loop"))
+	if (unregister_blkdev((max_part > 1) ? MY_DYN_MAJOR_START : LOOP_MAJOR, "loop"))
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");

 	kfree(disks);
@@ -1216,5 +1249,12 @@
 	return 1;
 }

+static int __init max_part_setup(char *str)
+{
+	max_part = simple_strtol(str, NULL, 0);
+	return 1;
+}
+
 __setup("max_loop=", max_loop_setup);
+__setup("max_part=", max_part_setup);
 #endif
--- ./linux-2.6.9/include/linux/major.h~	2004-10-18 23:53:43.000000000 +0200
+++ ./linux-2.6.9/include/linux/major.h	2004-11-08 05:59:11.000000000 +0100
@@ -165,4 +165,6 @@

 #define VIOTAPE_MAJOR		230

+#define MY_DYN_MAJOR_START	240
+
 #endif
