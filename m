Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270856AbRHOTmQ>; Wed, 15 Aug 2001 15:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271390AbRHOTmI>; Wed, 15 Aug 2001 15:42:08 -0400
Received: from dsl254-035-224.sea1.dsl.speakeasy.net ([216.254.35.224]:39305
	"EHLO dhcp12.pdx.beattie-home.net") by vger.kernel.org with ESMTP
	id <S270856AbRHOTly>; Wed, 15 Aug 2001 15:41:54 -0400
Date: Mon, 23 Jul 2001 13:32:43 -0700
From: Brian Beattie <bbeattie@sequent.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: md/multipath: Multipath, Multiport support and prototype patch for round robin routing
Message-ID: <20010723133242.B970@dyn9-47-16-69.des.beaverton.ibm.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at the multipath support Ingo Molnar added to md as
included in RedHat 7.1.  I'm looking at various improvements that might
be possible.  To try to get some discussion going, I posting some ideas
of things I thgink could be improved, and some patches for a prototype
to add round robin routing.

Some of the things that I think could be done that would improve md, in
no particular order: different routing options ( prefered route, round
robin, static weighted, dynamic weighted ), improved error handeling,
automatic route recovery, automatic device discovery, automatic device
identification.  Some of these may not be feasible and others may have
some other features.

All comments welcome

-- 
Brian Beattie
IBM Linux Technology Center
bbeattie@sequent.com
503.578.5899  Des2-3C-5

--------------------- patch -------------------------
diff -rc linux-2.4.2/drivers/md/multipath.c linux/drivers/md/multipath.c
*** linux-2.4.2/drivers/md/multipath.c	Sun Apr  8 15:22:24 2001
--- linux/drivers/md/multipath.c	Wed Jul 11 18:25:08 2001
***************
*** 25,30 ****
--- 25,31 ----
  #include <linux/module.h>
  #include <linux/malloc.h>
  #include <linux/raid/multipath.h>
+ #include <linux/sysctl.h>
  #include <asm/atomic.h>
  
  #define MAJOR_NR MD_MAJOR
***************
*** 46,51 ****
--- 47,92 ----
  #define PRINTK(x...)  do { } while (0)
  #endif
  
+ static char multipath_version[] =
+ 		{ "MD/LVM Multipath Storage Device Driver: ver 0.0.1" };
+ 
+ static int multipath_proc_readstr (ctl_table *, int, struct file *, void *,
+ 		size_t *);
+ static int multipath_proc_read_dev (ctl_table *, int, struct file *, void *,
+ 		size_t *);
+ 
+ static struct ctl_table_header *multipath_table_header;
+ 
+ static struct multipath_dev_table multipath_dev_template = {
+         "",
+ 	{
+ 		{MULTIPATH_ROUTING, "routing", NULL, sizeof(int), 0644,
+ 			NULL, &proc_dointvec},
+ 		{MULTIPATH_CONF, "config", NULL, 0, 0444, NULL,
+ 			&multipath_proc_read_dev},
+ 		{0},
+ 	},
+ 	{{MULTIPATH_DEV, NULL, NULL, 0, 0555, NULL},{0}},
+ 	{{DEV_MULTIPATH, "multipath", NULL, 0, 0555, NULL},{0}},
+ 	{{CTL_DEV, "dev", NULL, 0, 0555, NULL},{0}}
+ 	
+ };
+ 
+ static ctl_table multipath_ver_table[] = {
+ 	{MULTIPATH_VER, "version", &multipath_version,
+ 		sizeof(multipath_version), 0444, NULL, &multipath_proc_readstr},
+ 	{0}
+ };
+ 
+ static ctl_table multipath_dir_table[] = {
+ 	{DEV_MULTIPATH, "multipath", NULL, 0, 0555, multipath_ver_table},
+ 	{0}
+ };
+ 
+ static ctl_table multipath_root_table[] = {
+ 	{CTL_DEV, "dev", NULL, 0, 0555, multipath_dir_table},
+ 	{0}
+ };
  
  static mdk_personality_t multipath_personality;
  static md_spinlock_t retry_list_lock = MD_SPIN_LOCK_UNLOCKED;
***************
*** 53,58 ****
--- 94,244 ----
  
  static int multipath_diskop(mddev_t *mddev, mdp_disk_t **d, int state);
  
+ static int multipath_proc_register_dev(mddev_t *md )
+ {
+ 	struct multipath_dev_table *t;
+ 	multipath_conf_t *conf = mddev_to_conf(md);
+ 
+ 	t = &(conf->ctl_tbl);
+ 
+ 	memcpy(t, &multipath_dev_template, sizeof(*t));
+ 
+ 	/* fill in fields */
+ 	sprintf( t->mdname, "%d", md->__minor );
+ 
+ 	t->dir[0].procname = t->mdname;
+ 
+ 	t->md[0].data = &conf->routing;
+ 	t->md[1].data = md;
+ 	
+ 	t->dev[0].child = t->mp;
+ 	t->mp[0].child = t->dir;
+ 	t->dir[0].child = t->md;
+ 	
+ 	conf->tbl = register_sysctl_table( t->dev, 1 );
+ 
+ 	return 0;
+ }
+ 
+ static int multipath_proc_unregister_dev( mddev_t *md )
+ {
+ 	multipath_conf_t *conf = mddev_to_conf(md);
+ 
+ 	unregister_sysctl_table( conf->tbl );
+ 
+ 	return 0;
+ } 
+ 
+ 
+ static int multipath_proc_readstr (ctl_table *tbl, int write, struct file *f,
+ 		void *buffer, size_t *lenp)
+ {
+ 	int	n;
+ 
+ 	if ( write )
+ 		return -EACCES;		/* readonly string */
+ 
+ 		/* check for no or zero length data, or data allready read */
+ 	if (!tbl->data || !tbl->maxlen || !*lenp || f->f_pos )
+ 	{
+ 		*lenp = 0;
+ 		return 0;
+ 	}
+ 	
+ 	n = strlen(tbl->data);
+ 
+ 	if (n > tbl->maxlen)
+ 		n = tbl->maxlen;
+ 		
+ 	if ( n > *lenp )
+ 		n = *lenp;
+ 
+ 	if ( n )
+ 		if(copy_to_user( buffer, multipath_version, n))
+ 			return -EFAULT;
+ 	if ( n  < *lenp )
+ 	{
+ 		if(put_user('\n', ((char *)buffer) + n) )
+ 			return -EFAULT;
+ 		n++;
+ 	}
+ 	*lenp = n;
+ 	f->f_pos += n;
+ 
+ 	return 0;
+ }
+ 
+ static int multipath_proc_read_dev (ctl_table *t, int w, struct file *f,
+ 		void *b, size_t *s)
+ {
+ 	mddev_t			*md;
+ 	multipath_conf_t	*conf;
+ 	struct multipath_info	*info;
+ 	int			path, len, i;
+ #define LEN_HDR 48
+ #define LEN_DSK 85
+ 
+ 	if (!t->data || !*s || f->f_pos )
+ 	{
+ 		*s = 0;
+ 		return 0;
+ 	}
+ 
+ 	if ( w )
+ 		return -EACCES;		/* readonly */
+ 
+ 	md = t->data;
+ 	conf = mddev_to_conf( md );
+ 
+ 	if ( f->f_pos == 0 )
+ 	{
+ 		if ( *s < LEN_HDR )	/* must be big enough to handle the */
+ 			return -EFAULT;	/* size of the next sprintf */
+ 
+ 		sprintf( b, "nr_disks %3d: raid_disks %3d: working_disks %3d\n",
+ 			conf->nr_disks&255, conf->raid_disks&255,
+ 			conf->working_disks&255 );
+ 
+ 		len = strlen( b );
+ 		if ( *s < len )	/* check for overflow */
+ 			return -EFAULT;
+ 
+ 		if ( *s < len + LEN_DSK )
+ 		{
+ 			*s = len;
+ 			f->f_pos = len;
+ 			return 0;
+ 		}
+ 	}
+ 
+ 
+ 	for ( path = 0; path < conf->nr_disks; path++ )
+ 	{
+ 		info = &conf->multipaths[path];
+ 
+ 		sprintf( b + len,
+ 			"%3d: disk %3d: dev %3d.%3d\n"
+ 			"\tworking %c: write only %c: spare %c: used %c "
+ 			"ops %10d\n",
+ 			info->number&255, info->raid_disk&255, MAJOR(info->dev),
+ 			MINOR(info->dev),
+ 			info->operational? 'y' : 'n',
+ 			info->write_only? 'y' : 'n',
+ 			info->spare? 'y' : 'n',
+ 			info->used_slot? 'y' : 'n',
+ 			info->nr_ops );
+ 		len = strlen( b );
+ 		if ( *s < len + LEN_DSK )
+ 			break;
+ 	}
+ 
+ 	*s = len;
+ 	f->f_pos = len;
+ 	return 0;
+ #undef LEN_HDR
+ #undef LEN_DSK
+ }
+ 
  static struct buffer_head *multipath_alloc_bh(multipath_conf_t *conf, int cnt)
  {
  	/* return a linked list of "cnt" struct buffer_heads.
***************
*** 364,387 ****
  }
  
  /*
-  * This routine returns the disk from which the requested read should
-  * be done. It bookkeeps the last read position for every disk
-  * in array and when new read requests come, the disk which last
-  * position is nearest to the request, is chosen.
-  *
-  * TODO: now if there are 2 multipaths in the same 2 devices, performance
-  * degrades dramatically because position is multipath, not device based.
-  * This should be changed to be device based. Also atomic sequential
-  * reads should be somehow balanced.
   */
  
! static int multipath_read_balance (multipath_conf_t *conf)
  {
! 	int disk;
  
- 	for (disk = 0; disk < conf->raid_disks; disk++)	
  		if (conf->multipaths[disk].operational)
! 			return disk;
  	BUG();
  	return 0;
  }
--- 550,588 ----
  }
  
  /*
   */
  
! static int multipath_route_select( multipath_conf_t *conf)
  {
! 	struct multipath_info	*info;
! 	int	disk, next;
! 
! 	switch( conf->routing )
! 	{
! 	case 0:
! 		for (disk = 0; disk < conf->nr_disks; disk++)	
! 			if (conf->multipaths[disk].operational)
! 				return disk;
! 		break;
! 	case 1:
! 		for (disk = 0; disk < conf->nr_disks; disk++)
! 			if (conf->multipaths[disk].operational)
! 				break;
  
  		if (conf->multipaths[disk].operational)
! 		{
! 			if (disk == conf->nr_disks)
! 				next = 0;
! 			else
! 				next = disk + 1;
! 			conf->multipaths[disk].operational = 0;
! 			conf->multipaths[next].operational = 1;
! 			return next;
! 		}
! 		break;
! 	default:
! 		break;
! 	}
  	BUG();
  	return 0;
  }
***************
*** 437,443 ****
  	/*
  	 * read balancing logic:
  	 */
! 	multipath = conf->multipaths + multipath_read_balance(conf);
  
  	bh_req = &r1_bh->bh_req;
  	memcpy(bh_req, bh, sizeof(*bh));
--- 638,644 ----
  	/*
  	 * read balancing logic:
  	 */
! 	multipath = conf->multipaths + multipath_route_select(conf);
  
  	bh_req = &r1_bh->bh_req;
  	memcpy(bh_req, bh, sizeof(*bh));
***************
*** 448,453 ****
--- 649,657 ----
  	bh_req->b_end_io = multipath_end_request;
  	bh_req->b_private = r1_bh;
  	generic_make_request (rw, bh_req);
+ 
+ 	multipath->nr_ops++;
+ 
  	return 0;
  }
  
***************
*** 697,702 ****
--- 901,907 ----
  	 * Switch the spare disk to write-only mode:
  	 */
  	case DISKOP_SPARE_WRITE:
+ printk("MD: DISKOP_SPARE_WRITE\n");
  		sdisk = conf->multipaths + spare_disk;
  		sdisk->operational = 1;
  		sdisk->write_only = 1;
***************
*** 705,710 ****
--- 910,916 ----
  	 * Deactivate a spare disk:
  	 */
  	case DISKOP_SPARE_INACTIVE:
+ printk("MD: DISKOP_SPARE_INACTIVE\n");
  		sdisk = conf->multipaths + spare_disk;
  		sdisk->operational = 0;
  		sdisk->write_only = 0;
***************
*** 717,722 ****
--- 923,929 ----
  	 * property)
  	 */
  	case DISKOP_SPARE_ACTIVE:
+ printk("MD: DISKOP_SPARE_ACTIVE\n");
  		sdisk = conf->multipaths + spare_disk;
  		fdisk = conf->multipaths + failed_disk;
  
***************
*** 1040,1045 ****
--- 1247,1258 ----
  	}
  	memset(conf, 0, sizeof(*conf));
  
+ 	if (multipath_proc_register_dev( mddev ))
+ 	{
+ 		printk(ERRORS, mdidx(mddev));
+ 		goto out_free_conf;
+ 	}
+ 
  	ITERATE_RDEV(mddev,rdev,tmp) {
  		if (rdev->faulty) {
  			/* this is a "should never happen" case and if it */
***************
*** 1228,1233 ****
--- 1441,1447 ----
  {
  	multipath_conf_t *conf = mddev_to_conf(mddev);
  
+ 	multipath_proc_unregister_dev( mddev );
  	md_unregister_thread(conf->thread);
  	multipath_shrink_r1bh(conf);
  	multipath_shrink_bh(conf, conf->freebh_cnt);
***************
*** 1250,1260 ****
--- 1464,1478 ----
  
  static int md__init multipath_init (void)
  {
+ 	multipath_table_header = register_sysctl_table(multipath_root_table, 1);
+ 
  	return register_md_personality (MULTIPATH, &multipath_personality);
  }
  
  static void multipath_exit (void)
  {
+ 	unregister_sysctl_table(multipath_table_header);
+ 
  	unregister_md_personality (MULTIPATH);
  }
  
diff -rc linux-2.4.2/include/linux/raid/multipath.h linux/include/linux/raid/multipath.h
*** linux-2.4.2/include/linux/raid/multipath.h	Sun Apr  8 15:56:18 2001
--- linux/include/linux/raid/multipath.h	Wed Jul 11 18:23:07 2001
***************
*** 2,7 ****
--- 2,16 ----
  #define _MULTIPATH_H
  
  #include <linux/raid/md.h>
+ #include <linux/sysctl.h>
+ 
+ struct multipath_dev_table {
+ 	char		mdname[8];
+ 	ctl_table	md[3];
+ 	ctl_table	dir[2];
+ 	ctl_table	mp[2];
+ 	ctl_table	dev[2];
+ };
  
  struct multipath_info {
  	int		number;
***************
*** 18,23 ****
--- 27,33 ----
  	int		spare;
  
  	int		used_slot;
+ 	unsigned int		nr_ops;
  };
  
  struct multipath_private_data {
***************
*** 52,57 ****
--- 62,72 ----
  	md_wait_queue_head_t	wait_done;
  	md_wait_queue_head_t	wait_ready;
  	md_spinlock_t		segment_lock;
+ 	int	last;		/* last used, or prefered route */
+ 	int	routing;	/* routing algorithim 0 = use prefered */
+ 				/*                    1 = round robin etc */
+ 	struct ctl_table_header	*tbl;
+ 	struct multipath_dev_table	ctl_tbl;
  };
  
  typedef struct multipath_private_data multipath_conf_t;
diff -rc linux-2.4.2/include/linux/sysctl.h linux/include/linux/sysctl.h
*** linux-2.4.2/include/linux/sysctl.h	Sun Apr  8 15:47:23 2001
--- linux/include/linux/sysctl.h	Tue Jul 10 16:51:05 2001
***************
*** 594,600 ****
  	DEV_HWMON=2,
  	DEV_PARPORT=3,
  	DEV_RAID=4,
! 	DEV_MAC_HID=5
  };
  
  /* /proc/sys/dev/cdrom */
--- 594,601 ----
  	DEV_HWMON=2,
  	DEV_PARPORT=3,
  	DEV_RAID=4,
! 	DEV_MAC_HID=5,
! 	DEV_MULTIPATH=6
  };
  
  /* /proc/sys/dev/cdrom */
***************
*** 616,621 ****
--- 617,634 ----
  enum {
  	DEV_RAID_SPEED_LIMIT_MIN=1,
  	DEV_RAID_SPEED_LIMIT_MAX=2
+ };
+ 
+ /* /proc/sys/dev/multipath */
+ enum {
+ 	MULTIPATH_VER=1,
+ 	MULTIPATH_DEV=2
+ };
+ 
+ /* /proc/sys/dev/multipath/md n */
+ enum {
+ 	MULTIPATH_ROUTING=1,
+ 	MULTIPATH_CONF=2
  };
  
  /* /proc/sys/dev/parport/default */


----- End forwarded message -----

-- 
Brian Beattie
IBM Linux Technology Center - MPIO/SAN
bbeattie@sequent.com
503.578.5899  Des2-3C-5

