Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290215AbSBKTWV>; Mon, 11 Feb 2002 14:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290229AbSBKTWG>; Mon, 11 Feb 2002 14:22:06 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:58091 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290215AbSBKTVb>; Mon, 11 Feb 2002 14:21:31 -0500
Subject: [Fwd: Re: FC & MULTIPATH !? (any hope?)]
From: Brian Beattie <alchemy@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 11 Feb 2002 11:21:15 -0800
Message-Id: <1013455275.827.8.camel@w-beattie1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 03:33, Mario Mikocevic wrote: 
> Hi,
> 
> is there any hope of working combination of MULTIPATH with FC !?
> 
> At the moment I am using raid option multipath but it's one way
> street, when one FC connection dies it successfully switches onto
> another FC connection but when that second dies aswell, mount point
> is in a limbo, no switching back to first FC connection.
> 
> Any other solutions, patches ?!
> 
In case you all thought I had disapperaded or forgotten about this, I
didn't, but I did have a nasty cold that hung around for two weeks. 

Any way what I have is the attached patch that was made to 2.4.18-pre4. 
It applies cleanly and compiles against 2.4.18-pre9, though it has not
been tested.  In fact the patch has not been heavily tested, I need to
come up with a way to cause a fault on a single path on my test machine.

The interface I have implemented uses sysctl, which shows up in /proc
under /proc/sys if you have procfs enabled, this is what I have been
using.  Under /proc/sys I have created a hierarchy:
multipath/
	version		disk#/
			|
		config	drive#/
			|
	fault  operational  recover  state

As an example, my test system with a multipathed drive (/dev/md0) has
two paths, the tree looks like:

/proc/sys/dev# ls -R multipath
multipath:
0  version

multipath/0:
0  1  config

multipath/0/0:
fault  operational  recover  state

multipath/0/1:
fault  operational  recover  state

To recover a faulted path "0", write a non-zero acsii string to the file
"/proc/sys/dev/multipath/0/0/recover".  This will set the field recover
in the multipath_info struct.  This will be checked the next
"make_request" if the drive is marked as faulted, the drive will be
marked as spare, if not it is ignored.  In either case, the recover
field will be cleared.

I am planning to design a user level daemon to do auto-recovery, and
will think about cleaning this whole thing up, as well as testing it
more.  I'd really like any comments or requests anybody might have.

Beattie.

Brian Beattie<alchemy@us.ibm.com>
IBM LTC Storage IO
----


diff -u -r --exclude-from=../dontdiff ../linux/drivers/md/multipath.c ./drivers/md/multipath.c
--- ../linux/drivers/md/multipath.c	Fri Feb  8 10:45:02 2002
+++ ./drivers/md/multipath.c	Thu Feb  7 16:23:46 2002
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/raid/multipath.h>
+#include <linux/sysctl.h>
 #include <asm/atomic.h>
 
 #define MAJOR_NR MD_MAJOR
@@ -46,6 +47,67 @@
 #define PRINTK(x...)  do { } while (0)
 #endif
 
+static char multipath_version[] =
+	{ "MD/LVM Multipath Storage Device Driver: ver 0.0.3" };
+
+static int multipath_proc_readstr (ctl_table *, int, struct file *, void *,
+	size_t *);
+static int multipath_proc_read_dev (ctl_table *, int, struct file *, void *,
+	size_t *);
+static int multipath_proc_disk_fault (ctl_table *, int, struct file *, void *,
+	size_t *);
+
+static void mark_disk_recovered (mddev_t *, int);
+
+static struct ctl_table_header *multipath_table_header;
+
+static struct multipath_disk_table multipath_disk_template = {
+	"",
+	NULL,
+	{
+		{MULTIPATH_DSTATE, "state", NULL, 0, 0444, NULL,
+			&proc_dointvec},
+		{MULTIPATH_DFAULT, "fault", NULL, 0, 0444, NULL,
+			&multipath_proc_disk_fault},
+		{MULTIPATH_OPER, "operational", NULL, 0, 0444, NULL,
+			&proc_dointvec},
+		{MULTIPATH_OPER, "recover", NULL, 0, 0644, NULL,
+			&proc_dointvec},
+		{0},
+	},
+	{{MULTIPATH_DISK, NULL, NULL, 0, 0555, NULL}, {0} },
+	{{MULTIPATH_DEV, NULL, NULL, 0, 0555, NULL},{0} },
+	{{DEV_MULTIPATH, "multipath", NULL, 0, 0555, NULL},{0}},
+	{{CTL_DEV, "dev", NULL, 0, 0555, NULL},{0}}
+};
+
+static struct multipath_dev_table multipath_dev_template = {
+	"",
+	NULL,
+	{
+		{MULTIPATH_CONF, "config", NULL, 0, 0444, NULL,
+			 &multipath_proc_read_dev},
+		{0},
+	},
+	{{MULTIPATH_DEV, NULL, NULL, 0, 0555, NULL},{0}},
+	{{DEV_MULTIPATH, "multipath", NULL, 0, 0555, NULL},{0}},
+	{{CTL_DEV, "dev", NULL, 0, 0555, NULL},{0}}
+};
+
+static ctl_table multipath_ver_table[] = {
+	{MULTIPATH_VER, "version", &multipath_version,
+		sizeof(multipath_version), 0444, NULL, &multipath_proc_readstr},	{0}
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
@@ -53,7 +115,205 @@
 
 static int multipath_diskop(mddev_t *mddev, mdp_disk_t **d, int state);
 
+static int multipath_proc_register_dev(mddev_t *md, multipath_conf_t *conf)
+{
+	struct multipath_dev_table *t;
+
+	t = &(conf->ctl_tbl);
+
+	memcpy(t, &multipath_dev_template, sizeof(*t));
 
+	/* fill in fields */
+	snprintf( t->mdname, 8, "%d", md->__minor );
+
+	t->dir[0].procname = t->mdname;
+
+	t->md[0].data = md;
+
+	t->dev[0].child = t->mp;
+	t->mp[0].child = t->dir;
+	t->dir[0].child = t->md;
+
+	t->sysctl_header = register_sysctl_table( t->dev, 1 );
+
+	return 0;
+}
+
+static int multipath_proc_unregister_dev( multipath_conf_t *conf )
+{
+	struct multipath_dev_table *t = &conf->ctl_tbl;
+
+	unregister_sysctl_table( t->sysctl_header );
+
+	return 0;
+}
+
+static int multipath_proc_register_disk( multipath_conf_t *conf,
+		struct multipath_info *disk, mdp_disk_t *desc )
+{
+	struct multipath_disk_table *t = &disk->ctl_tbl;
+
+	memcpy(t, &multipath_disk_template, sizeof(*t));
+
+	snprintf( t->mdname, 8, "%d", disk->number );
+
+	t->md[0].procname = t->mdname;
+
+		/* state */
+	t->disk[0].data = &(desc->state);
+	t->disk[0].maxlen = sizeof(desc->state);
+		/* faulty */
+	t->disk[1].data = desc;
+	t->disk[1].maxlen = 0;
+		/* operational */
+	t->disk[2].data = &(disk->operational);
+	t->disk[2].maxlen = sizeof(disk->operational);
+		/* marked for recovery */
+	t->disk[3].data = &(disk->recover);
+	t->disk[3].maxlen = sizeof(disk->recover);
+
+	t->md[0].child = t->disk;
+
+	t->dir[0].procname = conf->ctl_tbl.dir[0].procname;
+
+	t->dir[0].child = t->md;
+	t->mp[0].child = t->dir;
+	t->dev[0].child = t->mp;
+
+	t->sysctl_header = register_sysctl_table(t->dev, 0);
+
+	return 0;
+}
+
+static int multipath_proc_unregister_disk( struct multipath_info *disk )
+{
+	struct multipath_disk_table *t = &disk->ctl_tbl;
+
+	unregister_sysctl_table( t->sysctl_header );
+
+	return 0;
+}
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
+	if (!tbl->data || !tbl->maxlen || !*lenp || f->f_pos ) {
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
+static int multipath_proc_disk_fault (ctl_table *t, int w, struct file *f,
+		void *b, size_t *s)
+{
+	if ( w )
+		return -EACCES;		/* Readonly */
+
+		/* check for no data, or data allready read */
+	if (!t->data || !*s || f->f_pos ) {
+		*s = 0;
+		return 0;
+	}
+
+	snprintf( b, *s, "%c\n", disk_faulty( (mdp_disk_t *)t->data ) ? 'y': 'n' );
+
+	*s = strlen( b );
+	f->f_pos += *s;
+
+	return 0;
+}
+
+
+static int multipath_proc_read_dev (ctl_table *t, int w, struct file *f,
+		void *b, size_t *s)
+{
+	mddev_t			*md;
+	multipath_conf_t	*conf;
+	struct multipath_info	*info;
+	int			path, len = 0;
+#define LEN_HDR 48
+#define LEN_DSK 85
+
+	if (!t->data || !*s || f->f_pos ) {
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
+	if ( f->f_pos == 0 ) {
+		if ( *s < LEN_HDR )	/* must be big enough to handle the */
+			return -EFAULT;	/* size of the next sprintf */
+
+		sprintf( b, "nr_disks %3d: raid_disks %3d: working_disks %3d\n",			conf->nr_disks&255, conf->raid_disks&255,
+			conf->working_disks&255 );
+
+		len = strlen( b );
+		if ( *s < len ) /* check for overflow */
+			return -EFAULT;
+
+		if ( *s < len + LEN_DSK ) {
+			*s = len;
+			f->f_pos = len;
+			return 0;
+		}
+	}
+
+	for ( path = 0; path < conf->nr_disks; path++ ) {
+		info = &conf->multipaths[path];
+
+		sprintf( b + len,
+			"%3d: disk %3d: dev %3d.%3d\n"
+			"\tworking %c: spare %c: used %c "
+			"ops %10d\n",
+			info->number&255, info->raid_disk&255, MAJOR(info->dev),			MINOR(info->dev),
+			info->operational? 'y' : 'n',
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
 
 static struct multipath_bh *multipath_alloc_mpbh(multipath_conf_t *conf)
 {
@@ -245,10 +505,14 @@
 	struct buffer_head *bh_req;
 	struct multipath_bh * mp_bh;
 	struct multipath_info *multipath;
+	int disk;
 
 	if (!buffer_locked(bh))
 		BUG();
 	
+	for (disk = 0; disk < conf->raid_disks; disk++)
+		if (conf->multipaths[disk].recover)
+			mark_disk_recovered( mddev, disk );
 /*
  * make_request() can abort the operation when READA is being
  * used and no empty request is available.
@@ -277,6 +541,9 @@
 /*	bh_req->b_rsector = bh->n_rsector; */
 	bh_req->b_end_io = multipath_end_request;
 	bh_req->b_private = mp_bh;
+
+	multipath->nr_ops++;
+
 	generic_make_request (rw, bh_req);
 	return 0;
 }
@@ -305,6 +572,27 @@
 "multipath: IO failure on %s, disabling IO path. \n" \
 "	Operation continuing on %d IO paths.\n"
 
+#define REG_D_ERROR KERN_ERR \
+"multipath: proc_register failed for disk %d\n"
+
+static void mark_disk_recovered (mddev_t *mddev, int recovered)
+{
+	multipath_conf_t *conf = mddev_to_conf(mddev);
+	struct multipath_info *multipath = conf->multipaths+recovered;
+	mdp_super_t *sb = mddev->sb;
+
+	multipath->recover = 0;
+
+	if ( !disk_faulty(sb->disks+multipath->number) )
+		return;		/* only disks marked faulty can be recovered */
+
+	sb->active_disks++;
+	sb->working_disks++;
+	sb->failed_disks--;
+	mark_disk_spare( sb->disks+multipath->number);
+	md_wakeup_thread(conf->thread);
+}
+
 static void mark_disk_bad (mddev_t *mddev, int failed)
 {
 	multipath_conf_t *conf = mddev_to_conf(mddev);
@@ -312,6 +600,7 @@
 	mdp_super_t *sb = mddev->sb;
 
 	multipath->operational = 0;
+	multipath->recover = 0;
 	mark_disk_faulty(sb->disks+multipath->number);
 	mark_disk_nonsync(sb->disks+multipath->number);
 	mark_disk_inactive(sb->disks+multipath->number);
@@ -399,14 +688,6 @@
 	int i;
 	struct multipath_info *tmp;
 
-	printk("MULTIPATH conf printout:\n");
-	if (!conf) {
-		printk("(conf==NULL)\n");
-		return;
-	}
-	printk(" --- wd:%d rd:%d nd:%d\n", conf->working_disks,
-			 conf->raid_disks, conf->nr_disks);
-
 	for (i = 0; i < MD_SB_DISKS; i++) {
 		tmp = conf->multipaths + i;
 		if (tmp->spare || tmp->operational || tmp->number ||
@@ -633,6 +914,9 @@
 		rdisk->dev = MKDEV(0,0);
 		rdisk->used_slot = 0;
 		conf->nr_disks--;
+
+		multipath_proc_unregister_disk( rdisk );
+
 		break;
 
 	case DISKOP_HOT_ADD_DISK:
@@ -654,6 +938,9 @@
 		adisk->used_slot = 1;
 		conf->nr_disks++;
 
+		if (multipath_proc_register_disk( conf, adisk, added_desc ) )
+			printk(REG_D_ERROR, adisk->number);
+
 		break;
 
 	default:
@@ -824,6 +1111,9 @@
 #define THREAD_ERROR KERN_ERR \
 "multipath: couldn't allocate thread for md%d\n"
 
+#define REG_ERROR KERN_ERR \
+"multipath: proc_register failed for md%d\n"
+
 static int multipath_run (mddev_t *mddev)
 {
 	multipath_conf_t *conf;
@@ -855,6 +1145,11 @@
 	}
 	memset(conf, 0, sizeof(*conf));
 
+	if (multipath_proc_register_dev(mddev, conf)) {
+		printk(REG_ERROR, mdidx(mddev));
+		goto out_free_conf;
+	}
+
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		if (rdev->faulty) {
 			/* this is a "should never happen" case and if it */
@@ -908,6 +1203,7 @@
 		} else
 			mark_disk_spare(desc);
 
+		multipath_proc_register_disk( conf, disk, desc );
 		if(!num_rdevs++) def_rdev = rdev;
 	}
 	if(!conf->working_disks && num_rdevs) {
@@ -1031,11 +1327,21 @@
 #undef NONE_OPERATIONAL
 #undef SB_DIFFERENCES
 #undef ARRAY_IS_ACTIVE
+#undef REG_ERROR
+#undef REG_D_ERROR
 
 static int multipath_stop (mddev_t *mddev)
 {
 	multipath_conf_t *conf = mddev_to_conf(mddev);
+	int i, disks = MD_SB_DISKS;
+
+		/* unregister all disks */
+	for (i = 0; i < disks; i++) {
+		if (conf->multipaths[i].used_slot )
+			multipath_proc_unregister_disk( &conf->multipaths[i] );
+	}
 
+	multipath_proc_unregister_dev( conf );
 	md_unregister_thread(conf->thread);
 	multipath_shrink_mpbh(conf);
 	kfree(conf);
@@ -1057,11 +1363,13 @@
 
 static int md__init multipath_init (void)
 {
+	multipath_table_header = register_sysctl_table(multipath_root_table, 1);
 	return register_md_personality (MULTIPATH, &multipath_personality);
 }
 
 static void multipath_exit (void)
 {
+	unregister_sysctl_table(multipath_table_header);
 	unregister_md_personality (MULTIPATH);
 }
 
Only in ./include/linux: modules
diff -u -r --exclude-from=../dontdiff ../linux/include/linux/raid/multipath.h ./include/linux/raid/multipath.h
--- ../linux/include/linux/raid/multipath.h	Mon Nov 12 09:51:56 2001
+++ ./include/linux/raid/multipath.h	Thu Feb  7 16:10:40 2002
@@ -2,19 +2,43 @@
 #define _MULTIPATH_H
 
 #include <linux/raid/md.h>
+#include <linux/sysctl.h>
+
+struct multipath_dev_table {
+	char		mdname[8];
+	struct ctl_table_header	*sysctl_header;
+	ctl_table	md[3];
+	ctl_table	dir[2];
+	ctl_table	mp[2];
+	ctl_table	dev[2];
+};
+
+struct multipath_disk_table {
+	char		mdname[8];
+	struct ctl_table_header	*sysctl_header;
+	ctl_table	disk[5];
+	ctl_table	md[2];
+	ctl_table	dir[2];
+	ctl_table	mp[2];
+	ctl_table	dev[2];
+};
 
 struct multipath_info {
 	int		number;
 	int		raid_disk;
 	kdev_t		dev;
+	struct multipath_disk_table	ctl_tbl;
 
 	/*
 	 * State bits:
 	 */
 	int		operational;
 	int		spare;
+	int		recover;	/* marked for retry after failure */
 
 	int		used_slot;
+
+	unsigned int	nr_ops;
 };
 
 struct multipath_private_data {
@@ -37,6 +61,8 @@
 	int			freer1_blocked;
 	int			freer1_cnt;
 	md_wait_queue_head_t	wait_buffer;
+	int			last;	/* last used route */
+	struct multipath_dev_table	ctl_tbl;
 };
 
 typedef struct multipath_private_data multipath_conf_t;
diff -u -r --exclude-from=../dontdiff ../linux/include/linux/sysctl.h ./include/linux/sysctl.h
--- ../linux/include/linux/sysctl.h	Mon Nov 26 05:29:17 2001
+++ ./include/linux/sysctl.h	Mon Feb  4 14:13:46 2002
@@ -553,7 +553,8 @@
 	DEV_HWMON=2,
 	DEV_PARPORT=3,
 	DEV_RAID=4,
-	DEV_MAC_HID=5
+	DEV_MAC_HID=5,
+	DEV_MULTIPATH=6
 };
 
 /* /proc/sys/dev/cdrom */
@@ -575,6 +576,26 @@
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
+	MULTIPATH_CONF=2,
+	MULTIPATH_DISK=3
+};
+
+/* /proc/sys/dev/multipath/md n/disk n */
+enum {
+	MULTIPATH_DSTATE=1,
+	MULTIPATH_DFAULT=2,
+	MULTIPATH_OPER=3
 };
 
 /* /proc/sys/dev/parport/default */

