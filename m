Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280934AbRKGTch>; Wed, 7 Nov 2001 14:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280933AbRKGTc0>; Wed, 7 Nov 2001 14:32:26 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:1009 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S280928AbRKGTcL>;
	Wed, 7 Nov 2001 14:32:11 -0500
Date: Wed, 7 Nov 2001 11:27:26 -0800
From: Brian Beattie <alchemy@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Alternate routing algorithims for md/multipath
Message-ID: <20011107112720.A1518@w-beattie1.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have been working on adding some features to the md/multipath module. 
At this point what I have is probably more a starting point for
discussion, than a true prototype.

Changes:

Add two new fields to the personality information in the superblock, to
specify the routing algorithm and a parameter (if needed).

Change Superblock version number to 91.

Add support for new superblock to raidtools

Add support for /proc/sys/dev and sysctl for simple monitoring and
control of md/multipath.

Add support for alternative routing algorithms.

Change name of function multipath_read_balance to multipath_path_select
because the function has nothing to do with "read balanceing".

Add simple round robin routing.
----

I am including four patches.  The first is a small bug fix.  The second
adds some simple support for /proc/sys and sysctl for monitoring and
control of md/multipath.  The third adds support for /proc/sys.  The
last adds support for alternative routing algorithms and round robin
routing.

As was pointed out, this round robin scheme will probably have pretty
poor performance and is really only done as an example.  I have not yet
done any performance measurements, but plan to do so next week after I
get back from ALS.  I will be looking at ways to do round robin routing
in a way that performs well.

I would like to hear any comments or suggestions people might have.

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.bugfix1"

diff -b -r -U 5 --exclude=*.o --exclude=.??* linux-2.4.12-ac3/include/linux/raid/md_k.h linux-2.4.12-ac3-md/include/linux/raid/md_k.h
--- linux-2.4.12-ac3/include/linux/raid/md_k.h	Tue Oct 23 04:56:06 2001
+++ linux-2.4.12-ac3-md/include/linux/raid/md_k.h	Fri Oct 19 10:23:45 2001
@@ -43,10 +43,11 @@
 }
 
 static inline int level_to_pers (int level)
 {
 	switch (level) {
+		case -4: return MULTIPATH;
 		case -3: return HSM;
 		case -2: return TRANSLUCENT;
 		case -1: return LINEAR;
 		case 0: return RAID0;
 		case 1: return RAID1;

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.proc-sys"

diff -b -r -U 5 --exclude=*.o --exclude=.??* linux-2.4.12-ac3/drivers/md/multipath.c linux-2.4.12-ac3-md/drivers/md/multipath.c
--- linux-2.4.12-ac3/drivers/md/multipath.c	Sun Sep 30 12:26:06 2001
+++ linux-2.4.12-ac3-md/drivers/md/multipath.c	Tue Oct 23 06:12:15 2001
@@ -23,10 +23,11 @@
  */
 
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/raid/multipath.h>
+#include <linux/sysctl.h>
 #include <asm/atomic.h>
 
 #define MAJOR_NR MD_MAJOR
 #define MD_DRIVER
 #define MD_PERSONALITY
@@ -44,17 +45,199 @@
 #define __inline__
 #else
 #define PRINTK(x...)  do { } while (0)
 #endif
 
+static char multipath_version[] =
+		{ "MD/LVM Multipath Storage Device Driver: ver 0.0.1" };
+
+static int multipath_proc_readstr (ctl_table *, int, struct file *, void *,
+		size_t *);
+static int multipath_proc_read_dev (ctl_table *, int, struct file *, void *,
+		size_t *);
+
+static struct ctl_table_header *multipath_table_header;
+
+static struct multipath_dev_table multipath_dev_template = {
+        "",
+	{
+		{MULTIPATH_CONF, "config", NULL, 0, 0444, NULL,
+			&multipath_proc_read_dev},
+		{0},
+	},
+	{{MULTIPATH_DEV, NULL, NULL, 0, 0555, NULL},{0}},
+	{{DEV_MULTIPATH, "multipath", NULL, 0, 0555, NULL},{0}},
+	{{CTL_DEV, "dev", NULL, 0, 0555, NULL},{0}}
+	
+};
+
+static ctl_table multipath_ver_table[] = {
+	{MULTIPATH_VER, "version", &multipath_version,
+		sizeof(multipath_version), 0444, NULL, &multipath_proc_readstr},
+	{0}
+};
+
+static ctl_table multipath_dir_table[] = {
+	{DEV_MULTIPATH, "multipath", NULL, 0, 0555, multipath_ver_table},
+	{0}
+};
+
+static ctl_table multipath_root_table[] = {
+	{CTL_DEV, "dev", NULL, 0, 0555, multipath_dir_table},
+	{0}
+};
 
 static mdk_personality_t multipath_personality;
 static md_spinlock_t retry_list_lock = MD_SPIN_LOCK_UNLOCKED;
 struct multipath_bh *multipath_retry_list = NULL, **multipath_retry_tail;
 
 static int multipath_diskop(mddev_t *mddev, mdp_disk_t **d, int state);
 
+static int multipath_proc_register_dev(mddev_t *md )
+{
+	struct multipath_dev_table *t;
+	multipath_conf_t *conf = mddev_to_conf(md);
+
+	t = &(conf->ctl_tbl);
+
+	memcpy(t, &multipath_dev_template, sizeof(*t));
+
+	/* fill in fields */
+	sprintf( t->mdname, "%d", md->__minor );
+
+	t->dir[0].procname = t->mdname;
+
+	t->md[1].data = md;
+	
+	t->dev[0].child = t->mp;
+	t->mp[0].child = t->dir;
+	t->dir[0].child = t->md;
+	
+	conf->tbl = register_sysctl_table( t->dev, 1 );
+
+	return 0;
+}
+
+static int multipath_proc_unregister_dev( mddev_t *md )
+{
+	multipath_conf_t *conf = mddev_to_conf(md);
+
+	unregister_sysctl_table( conf->tbl );
+
+	return 0;
+} 
+
+
+static int multipath_proc_readstr (ctl_table *tbl, int write, struct file *f,
+		void *buffer, size_t *lenp)
+{
+	int	n;
+
+	if ( write )
+		return -EACCES;		/* readonly string */
+
+		/* check for no or zero length data, or data allready read */
+	if (!tbl->data || !tbl->maxlen || !*lenp || f->f_pos )
+	{
+		*lenp = 0;
+		return 0;
+	}
+	
+	n = strlen(tbl->data);
+
+	if (n > tbl->maxlen)
+		n = tbl->maxlen;
+		
+	if ( n > *lenp )
+		n = *lenp;
+
+	if ( n )
+		if(copy_to_user( buffer, multipath_version, n))
+			return -EFAULT;
+	if ( n  < *lenp )
+	{
+		if(put_user('\n', ((char *)buffer) + n) )
+			return -EFAULT;
+		n++;
+	}
+	*lenp = n;
+	f->f_pos += n;
+
+	return 0;
+}
+
+static int multipath_proc_read_dev (ctl_table *t, int w, struct file *f,
+		void *b, size_t *s)
+{
+	mddev_t			*md;
+	multipath_conf_t	*conf;
+	struct multipath_info	*info;
+	int			path, len, i;
+#define LEN_HDR 48
+#define LEN_DSK 85
+
+	if (!t->data || !*s || f->f_pos )
+	{
+		*s = 0;
+		return 0;
+	}
+
+	if ( w )
+		return -EACCES;		/* readonly */
+
+	md = t->data;
+	conf = mddev_to_conf( md );
+
+	if ( f->f_pos == 0 )
+	{
+		if ( *s < LEN_HDR )	/* must be big enough to handle the */
+			return -EFAULT;	/* size of the next sprintf */
+
+		sprintf( b, "nr_disks %3d: raid_disks %3d: working_disks %3d\n",
+			conf->nr_disks&255, conf->raid_disks&255,
+			conf->working_disks&255 );
+
+		len = strlen( b );
+		if ( *s < len )	/* check for overflow */
+			return -EFAULT;
+
+		if ( *s < len + LEN_DSK )
+		{
+			*s = len;
+			f->f_pos = len;
+			return 0;
+		}
+	}
+
+
+	for ( path = 0; path < conf->nr_disks; path++ )
+	{
+		info = &conf->multipaths[path];
+
+		sprintf( b + len,
+			"%3d: disk %3d: dev %3d.%3d\n"
+			"\tworking %c: write only %c: spare %c: used %c "
+			"ops %10d\n",
+			info->number&255, info->raid_disk&255, MAJOR(info->dev),
+			MINOR(info->dev),
+			info->operational? 'y' : 'n',
+			info->write_only? 'y' : 'n',
+			info->spare? 'y' : 'n',
+			info->used_slot? 'y' : 'n',
+			info->nr_ops );
+		len = strlen( b );
+		if ( *s < len + LEN_DSK )
+			break;
+	}
+
+	*s = len;
+	f->f_pos = len;
+	return 0;
+#undef LEN_HDR
+#undef LEN_DSK
+}
+
 struct buffer_head *multipath_alloc_bh(multipath_conf_t *conf, int cnt)
 {
 	/* return a linked list of "cnt" struct buffer_heads.
 	 * don't take any off the free list unless we know we can
 	 * get all we need, otherwise we could deadlock
@@ -373,10 +556,11 @@
  * degrades dramatically because position is multipath, not device based.
  * This should be changed to be device based. Also atomic sequential
  * reads should be somehow balanced.
  */
 
+
 static int multipath_read_balance (multipath_conf_t *conf)
 {
 	int disk;
 
 	for (disk = 0; disk < conf->raid_disks; disk++)	
@@ -444,10 +628,13 @@
 	bh_req->b_rdev = multipath->dev;
 /*	bh_req->b_rsector = bh->n_rsector; */
 	bh_req->b_end_io = multipath_end_request;
 	bh_req->b_private = r1_bh;
 	generic_make_request (rw, bh_req);
+
+	multipath->nr_ops++;
+
 	return 0;
 }
 
 static int multipath_status (char *page, mddev_t *mddev)
 {
@@ -1036,10 +1223,16 @@
 		printk(MEM_ERROR, mdidx(mddev));
 		goto out;
 	}
 	memset(conf, 0, sizeof(*conf));
 
+	if (multipath_proc_register_dev( mddev ))
+	{
+		printk(ERRORS, mdidx(mddev));
+		goto out_free_conf;
+	}
+
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		if (rdev->faulty) {
 			/* this is a "should never happen" case and if it */
 			/* ever does happen, a continue; won't help */
 			printk(ERRORS, partition_name(rdev->dev));
@@ -1224,10 +1417,11 @@
 
 static int multipath_stop (mddev_t *mddev)
 {
 	multipath_conf_t *conf = mddev_to_conf(mddev);
 
+	multipath_proc_unregister_dev( mddev );
 	md_unregister_thread(conf->thread);
 	multipath_shrink_mpbh(conf);
 	multipath_shrink_bh(conf, conf->freebh_cnt);
 	kfree(conf);
 	mddev->private = NULL;
@@ -1246,15 +1440,19 @@
 	diskop:		multipath_diskop,
 };
 
 static int md__init multipath_init (void)
 {
+	multipath_table_header = register_sysctl_table(multipath_root_table, 1);
+
 	return register_md_personality (MULTIPATH, &multipath_personality);
 }
 
 static void multipath_exit (void)
 {
+	unregister_sysctl_table(multipath_table_header);
+
 	unregister_md_personality (MULTIPATH);
 }
 
 module_init(multipath_init);
 module_exit(multipath_exit);
diff -b -r -U 5 --exclude=*.o --exclude=.??* linux-2.4.12-ac3/include/linux/raid/multipath.h linux-2.4.12-ac3-md/include/linux/raid/multipath.h
--- linux-2.4.12-ac3/include/linux/raid/multipath.h	Fri Sep 14 14:22:18 2001
+++ linux-2.4.12-ac3-md/include/linux/raid/multipath.h	Tue Oct 23 06:11:44 2001
@@ -1,9 +1,18 @@
 #ifndef _MULTIPATH_H
 #define _MULTIPATH_H
 
 #include <linux/raid/md.h>
+#include <linux/sysctl.h>
+
+struct multipath_dev_table {
+	char		mdname[8];
+	ctl_table	md[3];
+	ctl_table	dir[2];
+	ctl_table	mp[2];
+	ctl_table	dev[2];
+};
 
 struct multipath_info {
 	int		number;
 	int		raid_disk;
 	kdev_t		dev;
@@ -16,10 +25,11 @@
 	int		operational;
 	int		write_only;
 	int		spare;
 
 	int		used_slot;
+	unsigned int		nr_ops;
 };
 
 struct multipath_private_data {
 	mddev_t			*mddev;
 	struct multipath_info	multipaths[MD_SB_DISKS];
@@ -50,10 +60,13 @@
 	int	phase;
 	int	window;
 	md_wait_queue_head_t	wait_done;
 	md_wait_queue_head_t	wait_ready;
 	md_spinlock_t		segment_lock;
+	int	last;		/* last used, or prefered route */
+	struct ctl_table_header	*tbl;
+	struct multipath_dev_table	ctl_tbl;
 };
 
 typedef struct multipath_private_data multipath_conf_t;
 
 /*
diff -b -r -U 5 --exclude=*.o --exclude=.??* linux-2.4.12-ac3/include/linux/sysctl.h linux-2.4.12-ac3-md/include/linux/sysctl.h
--- linux-2.4.12-ac3/include/linux/sysctl.h	Tue Oct 23 04:56:06 2001
+++ linux-2.4.12-ac3-md/include/linux/sysctl.h	Tue Oct 23 04:26:42 2001
@@ -554,11 +554,12 @@
 enum {
 	DEV_CDROM=1,
 	DEV_HWMON=2,
 	DEV_PARPORT=3,
 	DEV_RAID=4,
-	DEV_MAC_HID=5
+	DEV_MAC_HID=5,
+	DEV_MULTIPATH=6
 };
 
 /* /proc/sys/dev/cdrom */
 enum {
 	DEV_CDROM_INFO=1,
@@ -576,10 +577,22 @@
 
 /* /proc/sys/dev/raid */
 enum {
 	DEV_RAID_SPEED_LIMIT_MIN=1,
 	DEV_RAID_SPEED_LIMIT_MAX=2
+};
+
+/* /proc/sys/dev/multipath */
+enum {
+	MULTIPATH_VER=1,
+	MULTIPATH_DEV=2
+};
+
+/* /proc/sys/dev/multipath/md n */
+enum {
+	MULTIPATH_ROUTING=1,
+	MULTIPATH_CONF=2
 };
 
 /* /proc/sys/dev/parport/default */
 enum {
 	DEV_PARPORT_DEFAULT_TIMESLICE=1,

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.raidtools"

Common subdirectories: raidtools/Software-RAID.HOWTO and raidtools-20010914/Software-RAID.HOWTO
diff -U 10 raidtools/common.h raidtools-20010914/common.h
--- raidtools/common.h	Wed Oct 24 05:33:32 2001
+++ raidtools-20010914/common.h	Tue Aug 28 08:26:13 2001
@@ -33,20 +33,20 @@
 
 #define DEBUG				(0)
 #define EXIT_USAGE			(EXIT_FAILURE)
 #define EXIT_VERSION			(0)
 #define MAX_LINE_LENGTH			(100)
 #define ZERO_BUFFER_SIZE		(64)	/* 64kB */
 #define MD_BLK_SIZ			(0x400)
 #define RAID_CONFIG			"/etc/raidtab"
 
 #define MKRAID_MAJOR_VERSION            (0)
-#define MKRAID_MINOR_VERSION            (91)
+#define MKRAID_MINOR_VERSION            (90)
 #define MKRAID_PATCHLEVEL_VERSION       (0)
 
 extern int do_quiet_flag;
 
 #define MIN(a,b)	((a) < (b) ? (a) : (b))
 #define OUT(x...) do { if (!do_quiet_flag) fprintf(stderr,##x); } while (0)
 #define ERR(x...) fprintf(stderr,##x)
 
 #endif
diff -U 10 raidtools/configure raidtools-20010914/configure
--- raidtools/configure	Wed Oct 24 07:13:52 2001
+++ raidtools-20010914/configure	Tue Aug 28 08:27:29 2001
@@ -516,21 +516,21 @@
   else
     ac_n=-n ac_c= ac_t=
   fi
 else
   ac_n= ac_c='\c' ac_t=
 fi
 
 
 
 
-VERS=0.91
+VERS=0.90
 
 
 MAKEFLAGS="-j4"
 
 
 # Extract the first word of "gcc", so it can be a program name with args.
 set dummy gcc; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
 echo "configure:536: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_CC'+set}'`\" = set"; then
diff -U 10 raidtools/configure.in raidtools-20010914/configure.in
--- raidtools/configure.in	Wed Oct 24 07:14:37 2001
+++ raidtools-20010914/configure.in	Tue Aug 28 08:26:15 2001
@@ -1,17 +1,17 @@
 dnl
 dnl Configure.in file for the raidtools
 dnl
 AC_INIT(mkraid.c)
 AC_CONFIG_HEADER(config.h)
 
-VERS=0.91
+VERS=0.90
 AC_SUBST(VERS)
 
 dnl
 dnl doesnt hurt
 dnl
 MAKEFLAGS="-j4"
 AC_SUBST(MAKEFLAGS)
 
 dnl
 dnl Basic autoconf checking
diff -U 10 raidtools/md-int.h raidtools-20010914/md-int.h
--- raidtools/md-int.h	Wed Oct 24 07:10:33 2001
+++ raidtools-20010914/md-int.h	Tue Aug 28 08:26:19 2001
@@ -193,22 +193,21 @@
 	md_u32 working_disks;	/*  3 Number of working disks		      */
 	md_u32 failed_disks;	/*  4 Number of failed disks		      */
 	md_u32 spare_disks;	/*  5 Number of spare disks		      */
 	md_u32 gstate_sreserved[MD_SB_GENERIC_STATE_WORDS - 6];
 
 	/*
 	 * Personality information
 	 */
 	md_u32 layout;		/*  0 the array's physical layout	      */
 	md_u32 chunk_size;	/*  1 chunk size in bytes		      */
-	md_u32 routing;		/*  2 routing algorithim for multipath drive  */
-	md_u32 pstate_reserved[MD_SB_PERSONALITY_WORDS - 3];
+	md_u32 pstate_reserved[MD_SB_PERSONALITY_WORDS - 2];
 
 	/*
 	 * Disks information
 	 */
 	md_descriptor_t disks[MD_SB_DISKS];
 
 	/*
 	 * Reserved
 	 */
 	md_u32 reserved[MD_SB_RESERVED_WORDS];
@@ -221,25 +220,23 @@
 } md_superblock_t;
 
 /*
  * options passed in raidstart:
  */
 
 #define MAX_CHUNK_SIZE (4096*1024)
 
 struct md_param
 {
-	int	personality;	/* 1,2,3,4 */
-	int	chunk_size;	/* in bytes */
-	int	max_fault;	/* unused for now */
-	int	routing;	/* routing algorithim for multipath devices */
-	int	routing_param;	/* arguments to routing algorithim */
+	int			personality;	/* 1,2,3,4 */
+	int			chunk_size;	/* in bytes */
+	int			max_fault;	/* unused for now */
 };
 
 typedef struct md_array_info_s {
 	/*
 	 * Generic constant information
 	 */
 	md_u32 major_version;
 	md_u32 minor_version;
 	md_u32 patch_version;
 	md_u32 ctime;
@@ -258,21 +255,20 @@
 	md_u32 active_disks;	/*  2 Number of currently active disks	      */
 	md_u32 working_disks;	/*  3 Number of working disks		      */
 	md_u32 failed_disks;	/*  4 Number of failed disks		      */
 	md_u32 spare_disks;	/*  5 Number of spare disks		      */
 
 	/*
 	 * Personality information
 	 */
 	md_u32 layout;		/*  0 the array's physical layout	      */
 	md_u32 chunk_size;	/*  1 chunk size in bytes		      */
-	md_u32 routing;		/*  2 routing algorithim for multipath device */
 
 } md_array_info_t;
 
 typedef struct md_disk_info_s {
 	/*
 	 * configuration/status of one particular disk
 	 */
 	md_u32 number;
 	md_u32 major;
 	md_u32 minor;
diff -U 10 raidtools/mkpv.c raidtools-20010914/mkpv.c
--- raidtools/mkpv.c	Wed Oct 24 07:14:11 2001
+++ raidtools-20010914/mkpv.c	Tue Aug 28 08:27:11 2001
@@ -16,21 +16,21 @@
 #include <popt.h>
 #include <sys/mount.h>		/* for BLKGETSIZE */
 #ifndef BLKGETSIZE
 #include <linux/fs.h>          /* for BLKGETSIZE */
 #endif
 #include <sys/sysmacros.h>
 
 #include "lvm-int.h"
 
 #define MKPV_MAJOR_VERSION            (0)
-#define MKPV_MINOR_VERSION            (91)
+#define MKPV_MINOR_VERSION            (90)
 #define MKPV_PATCHLEVEL_VERSION       (0)
 
 void usage (void) {
     printf("usage: mkpv [--configfile] [--version] [--force]\n");
     printf("       [-acfhuv] </dev/md?>*\n");
 }
 
 static long long lvmseek (int fd, unsigned long block)
 {
 	return (raidseek(fd, block*(LVM_BLOCKSIZE/MD_BLK_SIZ)));
diff -U 10 raidtools/parser.c raidtools-20010914/parser.c
--- raidtools/parser.c	Wed Oct 24 05:37:53 2001
+++ raidtools-20010914/parser.c	Tue Aug 28 08:27:13 2001
@@ -202,27 +202,20 @@
 		if (val >= array->param.raid_disks) {
 			fprintf(stderr, "failed-disk should be smaller than raid_disks\n");
 			return 1;
 		}
 		i = array->param.nr_disks - 1;
 		array->disks[i].raid_disk = val;
 		array->disks[i].state |= (1 << MD_DISK_FAULTY);
 		array->param.failed_disks++;
 		return 0;
 	
-	} else if (strcmp(par, "routing") == 0) {
-		if (array->param.level != -4) {
-			fprintf(stderr, "routing parameter only valid for multipath devices\n");
-			return 1;
-		}
-		array->param.routing = val;
-		return 0;
 	}
 	fprintf(stderr, "unrecognized option %s\n", par);
 	return 1;
 }
 
 int parse_config (FILE *fp)
 {
 	int nr = 0;
 	char line[MAX_LINE_LENGTH], par[MAX_LINE_LENGTH], val[MAX_LINE_LENGTH];
 
diff -U 10 raidtools/raid_io.c raidtools-20010914/raid_io.c
--- raidtools/raid_io.c	Wed Oct 24 07:35:19 2001
+++ raidtools-20010914/raid_io.c	Tue Aug 28 08:27:15 2001
@@ -232,22 +232,20 @@
 	printf("State:                   %d%s\n", sb->state, sb->state &
 					 (1 << MD_SB_CLEAN) ? " (clean)" : "");
 	printf("Raid level:              %d\n", sb->level);
 	printf("Individual disk size:    %uMB (%ukB)\n", sb->size /
 					 MD_BLK_SIZ, sb->size);
 	if (sb->level == 4 || sb->level == 5)
 		printf("Chunk size:              %dkB\n", sb->chunk_size / MD_BLK_SIZ);
 	i = sb->layout;
 	if (sb->level == 5)
 		printf("Parity algorithm:        %d (%s)\n", i, i < 4 ? parity_algorithm_table[i] : "unknown");
-	if (sb->level == -4)
-		printf("Routing algorithim:      %d\n", sb->routing );
 	printf("Total number of disks:   %d\n", sb->nr_disks);
 	printf("Number of raid disks:    %d\n", sb->raid_disks);
 	printf("Number of active disks:  %d\n", sb->active_disks);
 	printf("Number of working disks: %d\n", sb->working_disks);
 	printf("Number of failed disks:  %d\n", sb->failed_disks);
 	printf("Number of spare disks:   %d\n", sb->spare_disks);
 	printf("\n");
 
 	for (i = 0; i < sb->nr_disks; i++) {
 		disk = sb->disks + i;
diff -U 10 raidtools/raidlib.c raidtools-20010914/raidlib.c
--- raidtools/raidlib.c	Wed Oct 24 07:38:42 2001
+++ raidtools-20010914/raidlib.c	Tue Aug 28 08:27:17 2001
@@ -412,22 +412,20 @@
 	  case -1: param.personality = LINEAR; break;
 	  case 0:  param.personality = RAID0; break;
 	  case 1:  param.personality = RAID1; break;
 	  case 4:
 	  case 5:  param.personality = RAID5; break;
 	  default: exit (EXIT_FAILURE);
 	}
 
 	param.chunk_size = cfg->array.param.chunk_size;
 
-	param.routing = cfg->array.param.routing;
-
 	fd = open_or_die(cfg->md_name);
 	if (do_mdrun (fd, cfg->md_name, &param)) rc++;
 	break;
 
       case raidstop:
 	return 1;
 
       case raidstop_ro:
 	return 1;
 

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.routing"

diff -b -r -U 5 --exclude=*.o --exclude=.??* linux-2.4.12-ac3/drivers/md/multipath.c linux-2.4.12-ac3-md/drivers/md/multipath.c
--- linux-2.4.12-ac3/drivers/md/multipath.c	Fri Oct 26 15:18:50 2001
+++ linux-2.4.12-ac3-md/drivers/md/multipath.c	Tue Oct 23 06:12:15 2001
@@ -58,12 +58,10 @@
 static struct ctl_table_header *multipath_table_header;
 
 static struct multipath_dev_table multipath_dev_template = {
         "",
 	{
-		{MULTIPATH_ROUTING, "routing", NULL, sizeof(int), 0644,
-			NULL, &proc_dointvec},
 		{MULTIPATH_CONF, "config", NULL, 0, 0444, NULL,
 			&multipath_proc_read_dev},
 		{0},
 	},
 	{{MULTIPATH_DEV, NULL, NULL, 0, 0555, NULL},{0}},
@@ -106,11 +104,10 @@
 	/* fill in fields */
 	sprintf( t->mdname, "%d", md->__minor );
 
 	t->dir[0].procname = t->mdname;
 
-	t->md[0].data = &conf->routing;
 	t->md[1].data = md;
 	
 	t->dev[0].child = t->mp;
 	t->mp[0].child = t->dir;
 	t->dir[0].child = t->md;
@@ -435,11 +432,12 @@
 {
 	multipath_conf_t *conf = mddev_to_conf(mddev);
 	int i, disks = MD_SB_DISKS;
 
 	/*
-	 * Later we do 'routing' now we use the first available disk.
+	 * Later we do read balancing on the read side 
+	 * now we use the first available disk.
 	 */
 
 	for (i = 0; i < disks; i++) {
 		if (conf->multipaths[i].operational) {
 			*rdev = conf->multipaths[i].dev;
@@ -559,43 +557,17 @@
  * This should be changed to be device based. Also atomic sequential
  * reads should be somehow balanced.
  */
 
 
-
-static int multipath_path_select (multipath_conf_t *conf)
+static int multipath_read_balance (multipath_conf_t *conf)
 {
-	struct multipath_info	*info;
-	int	disk, next;
+	int disk;
 
-	switch( conf->routing )
-	{
-	case 0:		/* prefered route method */
 		for (disk = 0; disk < conf->raid_disks; disk++)	
 			if (conf->multipaths[disk].operational)
 				return disk;
-
-	case 1:		/* round robin method */
-		for (disk = 0; disk < conf->nr_disks; disk++)
-			if (conf->multipaths[disk].operational)
-				break;
-
-		if (conf->multipaths[disk].operational)
-		{
-			if (disk == conf->nr_disks)
-				next = 0;
-			else
-				next = disk + 1;
-
-			conf->multipaths[disk].operational = 0;
-			conf->multipaths[next].operational = 1;
-			return next;
-		}
-		break;
-	default:
-		break;
-	}
 	BUG();
 	return 0;
 }
 
 static int multipath_make_request (mddev_t *mddev, int rw,
@@ -638,23 +610,18 @@
 	 * i think the read and write branch should be separated completely,
 	 * since we want to do read balancing on the read side for example.
 	 * Alternative implementations? :) --mingo
 	 */
 
-	/* I am confused by the previous comment, for multipath, read
-	 * balancing is not really a useful concept.  It seems to me that
-	 * what needs to be done here, is route selection. -beattie-
-	 */ 
-
 	r1_bh->master_bh = bh;
 	r1_bh->mddev = mddev;
 	r1_bh->cmd = rw;
 
 	/*
 	 * read balancing logic:
 	 */
-	multipath = conf->multipaths + multipath_path_select(conf);
+	multipath = conf->multipaths + multipath_read_balance(conf);
 
 	bh_req = &r1_bh->bh_req;
 	memcpy(bh_req, bh, sizeof(*bh));
 	bh_req->b_blocknr = bh->b_rsector;
 	bh_req->b_dev = multipath->dev;
diff -b -r -U 5 --exclude=*.o --exclude=.??* linux-2.4.12-ac3/include/linux/autoconf.h linux-2.4.12-ac3-md/include/linux/autoconf.h
--- linux-2.4.12-ac3/include/linux/autoconf.h	Tue Oct 23 07:29:57 2001
+++ linux-2.4.12-ac3-md/include/linux/autoconf.h	Wed Oct 17 09:08:49 2001
@@ -1,7 +1,7 @@
 /*
- * Automatically generated C config: don't edit
+ * Automatically generated by make menuconfig: don't edit
  */
 #define AUTOCONF_INCLUDED
 #define CONFIG_X86 1
 #define CONFIG_ISA 1
 #undef  CONFIG_SBUS
@@ -166,14 +166,10 @@
 #undef  CONFIG_NET_IPIP
 #undef  CONFIG_NET_IPGRE
 #undef  CONFIG_IP_MROUTE
 #undef  CONFIG_INET_ECN
 #undef  CONFIG_SYN_COOKIES
-
-/*
- *  
- */
 #undef  CONFIG_IPX
 #undef  CONFIG_ATALK
 #undef  CONFIG_DECNET
 #undef  CONFIG_BRIDGE
 
@@ -196,14 +192,10 @@
 
 /*
  * IDE, ATA and ATAPI Block devices
  */
 #define CONFIG_BLK_DEV_IDE 1
-
-/*
- * Please see Documentation/ide.txt for help/info on IDE drives
- */
 #undef  CONFIG_BLK_DEV_HD_IDE
 #undef  CONFIG_BLK_DEV_HD
 #define CONFIG_BLK_DEV_IDEDISK 1
 #define CONFIG_IDEDISK_MULTI_MODE 1
 #undef  CONFIG_BLK_DEV_IDEDISK_VENDOR
@@ -218,14 +210,10 @@
 #undef  CONFIG_BLK_DEV_IDECS
 #define CONFIG_BLK_DEV_IDECD 1
 #undef  CONFIG_BLK_DEV_IDETAPE
 #undef  CONFIG_BLK_DEV_IDEFLOPPY
 #undef  CONFIG_BLK_DEV_IDESCSI
-
-/*
- * IDE chipset support/bugfixes
- */
 #define CONFIG_BLK_DEV_CMD640 1
 #undef  CONFIG_BLK_DEV_CMD640_ENHANCED
 #undef  CONFIG_BLK_DEV_ISAPNP
 #define CONFIG_BLK_DEV_RZ1000 1
 #define CONFIG_BLK_DEV_IDEPCI 1
@@ -272,24 +260,16 @@
 
 /*
  * SCSI support
  */
 #define CONFIG_SCSI 1
-
-/*
- * SCSI support type (disk, tape, CD-ROM)
- */
 #define CONFIG_BLK_DEV_SD 1
 #define CONFIG_SD_EXTRA_DEVS (40)
 #undef  CONFIG_CHR_DEV_ST
 #undef  CONFIG_CHR_DEV_OSST
 #undef  CONFIG_BLK_DEV_SR
 #define CONFIG_CHR_DEV_SG 1
-
-/*
- * Some SCSI devices (e.g. CD jukebox) support multiple LUNs
- */
 #define CONFIG_SCSI_DEBUG_QUEUES 1
 #define CONFIG_SCSI_MULTI_LUN 1
 #define CONFIG_SCSI_CONSTANTS 1
 #define CONFIG_SCSI_LOGGING 1
 
@@ -521,18 +501,10 @@
 
 /*
  * Joysticks
  */
 #undef  CONFIG_INPUT_GAMEPORT
-
-/*
- * Input core support is needed for gameports
- */
-
-/*
- * Input core support is needed for joysticks
- */
 #undef  CONFIG_QIC02_TAPE
 
 /*
  * Watchdog Cards
  */
@@ -700,21 +672,13 @@
 
 /*
  * USB support
  */
 #undef  CONFIG_USB
-
-/*
- * USB Controllers
- */
 #undef  CONFIG_USB_UHCI
 #undef  CONFIG_USB_UHCI_ALT
 #undef  CONFIG_USB_OHCI
-
-/*
- * USB Device Class drivers
- */
 #undef  CONFIG_USB_AUDIO
 #undef  CONFIG_USB_BLUETOOTH
 #undef  CONFIG_USB_STORAGE
 #undef  CONFIG_USB_STORAGE_DEBUG
 #undef  CONFIG_USB_STORAGE_DATAFAB
@@ -722,49 +686,21 @@
 #undef  CONFIG_USB_STORAGE_ISD200
 #undef  CONFIG_USB_STORAGE_JUMPSHOT
 #undef  CONFIG_USB_STORAGE_DPCM
 #undef  CONFIG_USB_ACM
 #undef  CONFIG_USB_PRINTER
-
-/*
- * USB Human Interface Devices (HID)
- */
-
-/*
- *   Input core support is needed for USB HID
- */
-
-/*
- * USB Imaging devices
- */
 #undef  CONFIG_USB_DC2XX
 #undef  CONFIG_USB_MDC800
 #undef  CONFIG_USB_SCANNER
 #undef  CONFIG_USB_MICROTEK
 #undef  CONFIG_USB_HPUSBSCSI
-
-/*
- * USB Multimedia devices
- */
-
-/*
- *   Video4Linux support is needed for USB Multimedia device support
- */
-
-/*
- * USB Network adaptors
- */
 #undef  CONFIG_USB_PLUSB
 #undef  CONFIG_USB_PEGASUS
 #undef  CONFIG_USB_KAWETH
 #undef  CONFIG_USB_CATC
 #undef  CONFIG_USB_CDCETHER
 #undef  CONFIG_USB_USBNET
-
-/*
- * USB port drivers
- */
 #undef  CONFIG_USB_USS720
 
 /*
  * USB Serial Converter support
  */
@@ -791,14 +727,10 @@
 #undef  CONFIG_USB_SERIAL_MCT_U232
 #undef  CONFIG_USB_SERIAL_PL2303
 #undef  CONFIG_USB_SERIAL_CYBERJACK
 #undef  CONFIG_USB_SERIAL_XIRCOM
 #undef  CONFIG_USB_SERIAL_OMNINET
-
-/*
- * Miscellaneous USB drivers
- */
 #undef  CONFIG_USB_RIO500
 #undef  CONFIG_USB_ID75
 
 /*
  * Kernel hacking
diff -b -r -U 5 --exclude=*.o --exclude=.??* linux-2.4.12-ac3/include/linux/raid/md_p.h linux-2.4.12-ac3-md/include/linux/raid/md_p.h
--- linux-2.4.12-ac3/include/linux/raid/md_p.h	Fri Oct 26 10:21:34 2001
+++ linux-2.4.12-ac3-md/include/linux/raid/md_p.h	Tue Nov 14 13:16:37 2000
@@ -142,16 +142,13 @@
 	 */
 	__u32 layout;		/*  0 the array's physical layout	      */
 	__u32 chunk_size;	/*  1 chunk size in bytes		      */
 	__u32 root_pv;		/*  2 LV root PV */
 	__u32 root_block;	/*  3 LV root block */
-	__u32 routing;		/*  4 routing algorithim for multipath drive  */
-	__u32 routing_param;	/*  5 data (if needed) for routing */
-	__u32 pstate_reserved[MD_SB_PERSONALITY_WORDS - 6];
+	__u32 pstate_reserved[MD_SB_PERSONALITY_WORDS - 4];
 
 	/*
-
 	 * Disks information
 	 */
 	mdp_disk_t disks[MD_SB_DISKS];
 
 	/*
diff -b -r -U 5 --exclude=*.o --exclude=.??* linux-2.4.12-ac3/include/linux/raid/multipath.h linux-2.4.12-ac3-md/include/linux/raid/multipath.h
--- linux-2.4.12-ac3/include/linux/raid/multipath.h	Fri Oct 26 15:24:42 2001
+++ linux-2.4.12-ac3-md/include/linux/raid/multipath.h	Tue Oct 23 06:11:44 2001
@@ -61,13 +61,10 @@
 	int	window;
 	md_wait_queue_head_t	wait_done;
 	md_wait_queue_head_t	wait_ready;
 	md_spinlock_t		segment_lock;
 	int	last;		/* last used, or prefered route */
-	int	routing;	/* routing algorithim 0 = prefered route */
-				/*                    1 = round robin etc... */
-	int	routing_param;	/* parameter for the above (if needed) */
 	struct ctl_table_header	*tbl;
 	struct multipath_dev_table	ctl_tbl;
 };
 
 typedef struct multipath_private_data multipath_conf_t;

--wac7ysb48OaltWcw--
