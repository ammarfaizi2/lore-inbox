Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVGIMls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVGIMls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 08:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVGIMls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 08:41:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58059 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261354AbVGIMlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 08:41:46 -0400
Date: Sat, 9 Jul 2005 14:41:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050709124105.GB4665@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507082145.08877.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> | new stack-footprint maximum: krootimage/2846, 1204 bytes.
> | new stack-footprint maximum: konqueror/2938, 836 bytes.

btw., that's quite borderline to overflow. STACK_WARN is 512 bytes, i.e.  
another 324 bytes of stack footprint and you'd trigger an overflow 
warning. The worst-case stack footprint that your .config has is 1300+ 
bytes (zlib). Does openvpn trigger any zlib functionality? Also, the 
worst-case stack footprint you had was an XFS trace. Below i've attached 
a printout of all stackframes that are larger than 256 bytes (using your 
.config).

	Ingo

-----------------------------
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 12
EXTRAVERSION = -RT-V0.7.51-18

(gdb) 
(gdb) ####################################
(gdb) # c049d976, stack size: 1368 bytes #
(gdb) ####################################
(gdb) 0xc049d976 is in inflate_dynamic (inflate.c:765).
760	/*
761	 * We use `noinline' here to prevent gcc-3.5 from using too much stack space
762	 */
763	STATIC int noinline INIT inflate_dynamic(void)
764	/* decompress an inflated type 2 (dynamic Huffman codes) block. */
765	{
766	  int i;                /* temporary variables */
767	  unsigned j;
768	  unsigned l;           /* last length */
769	  unsigned m;           /* mask for bit lengths table */
(gdb) 770	  unsigned n;           /* number of lengths to get */
771	  struct huft *tl;      /* literal/length code table */
772	  struct huft *td;      /* distance code table */
773	  int bl;               /* lookup bits for tl */
774	  int bd;               /* lookup bits for td */
775	  unsigned nb;          /* number of bit length codes */
776	  unsigned nl;          /* number of literal/length codes */
777	  unsigned nd;          /* number of distance codes */
778	#ifdef PKZIP_BUG_WORKAROUND
779	  unsigned ll[288+32];  /* literal/length and distance code lengths */
(gdb) 
(gdb) ####################################
(gdb) # c049d7b5, stack size: 1196 bytes #
(gdb) ####################################
(gdb) 0xc049d7b5 is in inflate_fixed (inflate.c:711).
706	 */
707	STATIC int noinline INIT inflate_fixed(void)
708	/* decompress an inflated type 1 (fixed Huffman codes) block.  We should
709	   either replace this with a custom decoder, or at least precompute the
710	   Huffman tables. */
711	{
712	  int i;                /* temporary variable */
713	  struct huft *tl;      /* literal/length code table */
714	  struct huft *td;      /* distance code table */
715	  int bl;               /* lookup bits for tl */
(gdb) 716	  int bd;               /* lookup bits for td */
717	  unsigned l[288];      /* length list for huft_build */
718	
719	DEBG("<fix");
720	
721	  /* set up literal table */
722	  for (i = 0; i < 144; i++)
723	    l[i] = 8;
724	  for (; i < 256; i++)
725	    l[i] = 9;
(gdb) 
(gdb) ####################################
(gdb) # c0228ec3, stack size:  764 bytes #
(gdb) ####################################
(gdb) 0xc0228ec3 is in calc_mode_timings (drivers/video/fbmon.c:317).
312		else
313			return 0;
314	}
315	
316	static void calc_mode_timings(int xres, int yres, int refresh, struct fb_videomode *mode)
317	{
318		struct fb_var_screeninfo var;
319		struct fb_info info;
320		
321		var.xres = xres;
(gdb) 322		var.yres = yres;
323		fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON, 
324			    refresh, &var, &info);
325		mode->xres = xres;
326		mode->yres = yres;
327		mode->pixclock = var.pixclock;
328		mode->refresh = refresh;
329		mode->left_margin = var.left_margin;
330		mode->right_margin = var.right_margin;
331		mode->upper_margin = var.upper_margin;
(gdb) 
(gdb) ####################################
(gdb) # c0208e26, stack size:  600 bytes #
(gdb) ####################################
(gdb) 0xc0208e26 is in semctl_main (ipc/sem.c:586).
581		sem_unlock(sma);
582		return err;
583	}
584	
585	static int semctl_main(int semid, int semnum, int cmd, int version, union semun arg)
586	{
587		struct sem_array *sma;
588		struct sem* curr;
589		int err;
590		ushort fast_sem_io[SEMMSL_FAST];
(gdb) 591		ushort* sem_io = fast_sem_io;
592		int nsems;
593	
594		sma = sem_lock(semid);
595		if(sma==NULL)
596			return -EINVAL;
597	
598		nsems = sma->sem_nsems;
599	
600		err=-EIDRM;
(gdb) 
(gdb) ####################################
(gdb) # c02de0f3, stack size:  572 bytes #
(gdb) ####################################
(gdb) 0xc02de0f3 is in ip_setsockopt (net/ipv4/ip_sockglue.c:385).
380	 *	Socket option code for IP. This is the end of the line after any TCP,UDP etc options on
381	 *	an IP socket.
382	 */
383	
384	int ip_setsockopt(struct sock *sk, int level, int optname, char __user *optval, int optlen)
385	{
386		struct inet_sock *inet = inet_sk(sk);
387		int val=0,err;
388	
389		if (level != SOL_IP)
(gdb) 390			return -ENOPROTOOPT;
391	
392		if (((1<<optname) & ((1<<IP_PKTINFO) | (1<<IP_RECVTTL) | 
393				    (1<<IP_RECVOPTS) | (1<<IP_RECVTOS) | 
394				    (1<<IP_RETOPTS) | (1<<IP_TOS) | 
395				    (1<<IP_TTL) | (1<<IP_HDRINCL) | 
396				    (1<<IP_MTU_DISCOVER) | (1<<IP_RECVERR) | 
397				    (1<<IP_ROUTER_ALERT) | (1<<IP_FREEBIND))) || 
398					optname == IP_MULTICAST_TTL || 
399					optname == IP_MULTICAST_LOOP) { 
(gdb) 
(gdb) ####################################
(gdb) # c0209846, stack size:  488 bytes #
(gdb) ####################################
(gdb) 0xc0209846 is in sys_semtimedop (ipc/sem.c:1057).
1052		return un;
1053	}
1054	
1055	asmlinkage long sys_semtimedop(int semid, struct sembuf __user *tsops,
1056				unsigned nsops, const struct timespec __user *timeout)
1057	{
1058		int error = -EINVAL;
1059		struct sem_array *sma;
1060		struct sembuf fast_sops[SEMOPM_FAST];
1061		struct sembuf* sops = fast_sops, *sop;
(gdb) 1062		struct sem_undo *un;
1063		int undos = 0, decrease = 0, alter = 0, max;
1064		struct sem_queue queue;
1065		unsigned long jiffies_left = 0;
1066	
1067		if (nsops < 1 || semid < 0)
1068			return -EINVAL;
1069		if (nsops > sc_semopm)
1070			return -E2BIG;
1071		if(nsops > SEMOPM_FAST) {
(gdb) 
(gdb) ####################################
(gdb) # c02decd6, stack size:  460 bytes #
(gdb) ####################################
(gdb) 0xc02decd6 is in ip_getsockopt (net/ipv4/ip_sockglue.c:877).
872	 *	Get the options. Note for future reference. The GET of IP options gets the
873	 *	_received_ ones. The set sets the _sent_ ones.
874	 */
875	
876	int ip_getsockopt(struct sock *sk, int level, int optname, char __user *optval, int __user *optlen)
877	{
878		struct inet_sock *inet = inet_sk(sk);
879		int val;
880		int len;
881		
(gdb) 882		if(level!=SOL_IP)
883			return -EOPNOTSUPP;
884	
885	#ifdef CONFIG_IP_MROUTE
886		if(optname>=MRT_BASE && optname <=MRT_BASE+10)
887		{
888			return ip_mroute_getsockopt(sk,optname,optval,optlen);
889		}
890	#endif
891	
(gdb) 
(gdb) ####################################
(gdb) # c0252146, stack size:  432 bytes #
(gdb) ####################################
(gdb) 0xc0252146 is in extract_buf (drivers/char/random.c:760).
755	
756		return nbytes;
757	}
758	
759	static void extract_buf(struct entropy_store *r, __u8 *out)
760	{
761		int i, x;
762		__u32 data[16], buf[5 + SHA_WORKSPACE_WORDS];
763	
764		sha_init(buf);
(gdb) 765		/*
766		 * As we hash the pool, we mix intermediate values of
767		 * the hash back into the pool.  This eliminates
768		 * backtracking attacks (where the attacker knows
769		 * the state of the pool plus the current outputs, and
770		 * attempts to find previous ouputs), unless the hash
771		 * function can be inverted.
772		 */
773		for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
774			sha_transform(buf, (__u8 *)r->pool+i, buf + 5);
(gdb) 
(gdb) ####################################
(gdb) # c02a0a26, stack size:  416 bytes #
(gdb) ####################################
(gdb) 0xc02a0a26 is in pcmcia_device_query (drivers/pcmcia/ds.c:436).
431	
432	/*
433	 * pcmcia_device_query -- determine information about a pcmcia device
434	 */
435	static int pcmcia_device_query(struct pcmcia_device *p_dev)
436	{
437		cistpl_manfid_t manf_id;
438		cistpl_funcid_t func_id;
439		cistpl_vers_1_t	vers1;
440		unsigned int i;
(gdb) 441	
442		if (!pccard_read_tuple(p_dev->socket, p_dev->func,
443				       CISTPL_MANFID, &manf_id)) {
444			p_dev->manf_id = manf_id.manf;
445			p_dev->card_id = manf_id.card;
446			p_dev->has_manf_id = 1;
447			p_dev->has_card_id = 1;
448		}
449	
450		if (!pccard_read_tuple(p_dev->socket, p_dev->func,
(gdb) 
(gdb) ####################################
(gdb) # c0169503, stack size:  408 bytes #
(gdb) ####################################
(gdb) 0xc0169503 is in blkdev_get (fs/block_dev.c:663).
658			bdput(bdev);
659		return ret;
660	}
661	
662	int blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags)
663	{
664		/*
665		 * This crockload is due to bad choice of ->open() type.
666		 * It will go away.
667		 * For now, block device ->open() routine must _not_
(gdb) 668		 * examine anything in 'inode' argument except ->i_rdev.
669		 */
670		struct file fake_file = {};
671		struct dentry fake_dentry = {};
672		fake_file.f_mode = mode;
673		fake_file.f_flags = flags;
674		fake_file.f_dentry = &fake_dentry;
675		fake_dentry.d_inode = bdev->bd_inode;
676	
677		return do_open(bdev, &fake_file);
(gdb) 
(gdb) ####################################
(gdb) # c013ebf4, stack size:  388 bytes #
(gdb) ####################################
(gdb) 0xc013ebf4 is in __print_symbol (kernel/kallsyms.c:234).
229		return NULL;
230	}
231	
232	/* Replace "%s" in format with address, or returns -errno. */
233	void __print_symbol(const char *fmt, unsigned long address)
234	{
235		char *modname;
236		const char *name;
237		unsigned long offset, size;
238		char namebuf[KSYM_NAME_LEN+1];
(gdb) 239		char buffer[sizeof("%s+%#lx/%#lx [%s]") + KSYM_NAME_LEN +
240			    2*(BITS_PER_LONG*3/10) + MODULE_NAME_LEN + 1];
241	
242		name = kallsyms_lookup(address, &size, &offset, &modname, namebuf);
243	
244		if (!name)
245			sprintf(buffer, "0x%lx", address);
246		else {
247			if (modname)
248				sprintf(buffer, "%s+%#lx/%#lx [%s]", name, offset,
(gdb) 
(gdb) ####################################
(gdb) # c020a773, stack size:  368 bytes #
(gdb) ####################################
(gdb) 0xc020a773 is in sys_shmctl (ipc/shm.c:409).
404			}
405		}
406	}
407	
408	asmlinkage long sys_shmctl (int shmid, int cmd, struct shmid_ds __user *buf)
409	{
410		struct shm_setbuf setbuf;
411		struct shmid_kernel *shp;
412		int err, version;
413	
(gdb) 414		if (cmd < 0 || shmid < 0) {
415			err = -EINVAL;
416			goto out;
417		}
418	
419		version = ipc_parse_version(&cmd);
420	
421		switch (cmd) { /* replace with proc interface ? */
422		case IPC_INFO:
423		{
(gdb) 
(gdb) ####################################
(gdb) # c01ad8b6, stack size:  348 bytes #
(gdb) ####################################
(gdb) 0xc01ad8b6 is in xfs_bmapi (fs/xfs/xfs_bmap.c:4530).
4525						   controls a.g. for allocs */
4526		xfs_extlen_t	total,		/* total blocks needed */
4527		xfs_bmbt_irec_t	*mval,		/* output: map values */
4528		int		*nmap,		/* i/o: mval size/count */
4529		xfs_bmap_free_t	*flist)		/* i/o: list extents to free */
4530	{
4531		xfs_fsblock_t	abno;		/* allocated block number */
4532		xfs_extlen_t	alen;		/* allocated extent length */
4533		xfs_fileoff_t	aoff;		/* allocated file offset */
4534		xfs_bmalloca_t	bma;		/* args for xfs_bmap_alloc */
(gdb) 4535		char		contig;		/* allocation must be one extent */
4536		xfs_btree_cur_t	*cur;		/* bmap btree cursor */
4537		char		delay;		/* this request is for delayed alloc */
4538		xfs_fileoff_t	end;		/* end of mapped file region */
4539		int		eof;		/* we've hit the end of extent list */
4540		xfs_bmbt_rec_t	*ep;		/* extent list entry pointer */
4541		int		error;		/* error return */
4542		char		exact;		/* don't do all of wasdelayed extent */
4543		xfs_bmbt_irec_t	got;		/* current extent list record */
4544		xfs_ifork_t	*ifp;		/* inode fork pointer */
(gdb) 
(gdb) ####################################
(gdb) # c0191e66, stack size:  344 bytes #
(gdb) ####################################
(gdb) 0xc0191e66 is in show_stat (fs/proc/proc_misc.c:327).
322		.llseek		= seq_lseek,
323		.release	= seq_release,
324	};
325	
326	static int show_stat(struct seq_file *p, void *v)
327	{
328		int i;
329		unsigned long jif;
330		cputime64_t user, nice, system, idle, iowait, irq, softirq, steal;
331		u64 sum = 0;
(gdb) 332	
333		user = nice = system = idle = iowait =
334			irq = softirq = steal = cputime64_zero;
335		jif = - wall_to_monotonic.tv_sec;
336		if (wall_to_monotonic.tv_nsec)
337			--jif;
338	
339		for_each_cpu(i) {
340			int j;
341	
(gdb) 
(gdb) ####################################
(gdb) # c0191af6, stack size:  344 bytes #
(gdb) ####################################
(gdb) 0xc0191af6 is in meminfo_read_proc (fs/proc/proc_misc.c:119).
114		return proc_calc_metrics(page, start, off, count, eof, len);
115	}
116	
117	static int meminfo_read_proc(char *page, char **start, off_t off,
118					 int count, int *eof, void *data)
119	{
120		struct sysinfo i;
121		int len;
122		struct page_state ps;
123		unsigned long inactive;
(gdb) 124		unsigned long active;
125		unsigned long free;
126		unsigned long committed;
127		unsigned long allowed;
128		struct vmalloc_info vmi;
129		long cached;
130	
131		get_page_state(&ps);
132		get_zone_counts(&active, &inactive, &free);
133	
(gdb) 
(gdb) ####################################
(gdb) # c017f553, stack size:  344 bytes #
(gdb) ####################################
(gdb) 0xc017f553 is in sys_pivot_root (fs/namespace.c:1280).
1275	 *    though, so you may need to say mount --bind /nfs/my_root /nfs/my_root
1276	 *    first.
1277	 */
1278	
1279	asmlinkage long sys_pivot_root(const char __user *new_root, const char __user *put_old)
1280	{
1281		struct vfsmount *tmp;
1282		struct nameidata new_nd, old_nd, parent_nd, root_parent, user_nd;
1283		int error;
1284	
(gdb) 1285		if (!capable(CAP_SYS_ADMIN))
1286			return -EPERM;
1287	
1288		lock_kernel();
1289	
1290		error = __user_walk(new_root, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
1291		if (error)
1292			goto out0;
1293		error = -EINVAL;
1294		if (!check_mnt(new_nd.mnt))
(gdb) 
(gdb) ####################################
(gdb) # c01dc746, stack size:  340 bytes #
(gdb) ####################################
(gdb) 0xc01dc746 is in xfs_swapext (fs/xfs/xfs_dfrag.c:69).
64	 * Syssgi interface for swapext
65	 */
66	int
67	xfs_swapext(
68		xfs_swapext_t	__user *sxp)
69	{
70		xfs_swapext_t	sx;
71		xfs_inode_t     *ip=NULL, *tip=NULL, *ips[2];
72		xfs_trans_t     *tp;
73		xfs_mount_t     *mp;
(gdb) 74		xfs_bstat_t	*sbp;
75		struct file	*fp = NULL, *tfp = NULL;
76		vnode_t		*vp, *tvp;
77		bhv_desc_t      *bdp, *tbdp;
78		vn_bhv_head_t   *bhp, *tbhp;
79		uint		lock_flags=0;
80		int		ilf_fields, tilf_fields;
81		int		error = 0;
82		xfs_ifork_t	tempif, *ifp, *tifp;
83		__uint64_t	tmp;
(gdb) 
(gdb) ####################################
(gdb) # c011ad66, stack size:  340 bytes #
(gdb) ####################################
(gdb) 0xc011ad66 is in mm_init (kernel/fork.c:353).
348	#define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
349	
350	#include <linux/init_task.h>
351	
352	static struct mm_struct * mm_init(struct mm_struct * mm)
353	{
354		atomic_set(&mm->mm_users, 1);
355		atomic_set(&mm->mm_count, 1);
356		init_rwsem(&mm->mmap_sem);
357		INIT_LIST_HEAD(&mm->mmlist);
(gdb) 358		mm->core_waiters = 0;
359		mm->nr_ptes = 0;
360		spin_lock_init(&mm->page_table_lock);
361		rwlock_init(&mm->ioctx_list_lock);
362		mm->ioctx_list = NULL;
363		mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
364		INIT_LIST_HEAD(&mm->delayed_drop);
365		mm->free_area_cache = TASK_UNMAPPED_BASE;
366	
367		if (likely(!mm_alloc_pgd(mm))) {
(gdb) 
(gdb) ####################################
(gdb) # c0298a03, stack size:  336 bytes #
(gdb) ####################################
(gdb) 0xc0298a03 is in mmc_ioctl (drivers/cdrom/cdrom.c:2623).
2618		return cdo->generic_packet(cdi, &cgc);
2619	}
2620	
2621	static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
2622			     unsigned long arg)
2623	{		
2624		struct cdrom_device_ops *cdo = cdi->ops;
2625		struct packet_command cgc;
2626		struct request_sense sense;
2627		unsigned char buffer[32];
(gdb) 2628		int ret = 0;
2629	
2630		memset(&cgc, 0, sizeof(cgc));
2631	
2632		/* build a unified command and queue it through
2633		   cdo->generic_packet() */
2634		switch (cmd) {
2635		case CDROMREADRAW:
2636		case CDROMREADMODE1:
2637		case CDROMREADMODE2: {
(gdb) 
(gdb) ####################################
(gdb) # c02077d3, stack size:  336 bytes #
(gdb) ####################################
(gdb) 0xc02077d3 is in sys_msgctl (ipc/msg.c:328).
323			return -EINVAL;
324		}
325	}
326	
327	asmlinkage long sys_msgctl (int msqid, int cmd, struct msqid_ds __user *buf)
328	{
329		int err, version;
330		struct msg_queue *msq;
331		struct msq_setbuf setbuf;
332		struct kern_ipc_perm *ipcp;
(gdb) 333		
334		if (msqid < 0 || cmd < 0)
335			return -EINVAL;
336	
337		version = ipc_parse_version(&cmd);
338	
339		switch (cmd) {
340		case IPC_INFO: 
341		case MSG_INFO: 
342		{ 
(gdb) 
(gdb) ####################################
(gdb) # c0190996, stack size:  336 bytes #
(gdb) ####################################
(gdb) 0xc0190996 is in do_task_stat (fs/proc/array.c:314).
309	#endif
310		return buffer - orig;
311	}
312	
313	static int do_task_stat(struct task_struct *task, char * buffer, int whole)
314	{
315		unsigned long vsize, eip, esp, wchan = ~0UL;
316		long priority, nice;
317		int tty_pgrp = -1, tty_nr = 0;
318		sigset_t sigign, sigcatch;
(gdb) 319		char state;
320		int res;
321	 	pid_t ppid, pgid = -1, sid = -1;
322		int num_threads = 0;
323		struct mm_struct *mm;
324		unsigned long long start_time;
325		unsigned long cmin_flt = 0, cmaj_flt = 0;
326		unsigned long  min_flt = 0,  maj_flt = 0;
327		cputime_t cutime, cstime, utime, stime;
328		unsigned long rsslim = 0;
(gdb) 
(gdb) ####################################
(gdb) # c02014f3, stack size:  332 bytes #
(gdb) ####################################
(gdb) 0xc02014f3 is in linvfs_mknod (fs/xfs/linux-2.6/xfs_iops.c:114).
109	linvfs_mknod(
110		struct inode	*dir,
111		struct dentry	*dentry,
112		int		mode,
113		dev_t		rdev)
114	{
115		struct inode	*ip;
116		vattr_t		va;
117		vnode_t		*vp = NULL, *dvp = LINVFS_GET_VP(dir);
118		xfs_acl_t	*default_acl = NULL;
(gdb) 119		attrexists_t	test_default_acl = _ACL_DEFAULT_EXISTS;
120		int		error;
121	
122		/*
123		 * Irix uses Missed'em'V split, but doesn't want to see
124		 * the upper 5 bits of (14bit) major.
125		 */
126		if (!sysv_valid_dev(rdev) || MAJOR(rdev) & ~0x1ff)
127			return -EINVAL;
128	
(gdb) 
(gdb) ####################################
(gdb) # c0192f96, stack size:  332 bytes #
(gdb) ####################################
(gdb) 0xc0192f96 is in elf_kcore_store_hdr (fs/proc/kcore.c:143).
138	/*
139	 * store an ELF coredump header in the supplied buffer
140	 * nphdr is the number of elf_phdr to insert
141	 */
142	static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
143	{
144		struct elf_prstatus prstatus;	/* NT_PRSTATUS */
145		struct elf_prpsinfo prpsinfo;	/* NT_PRPSINFO */
146		struct elf_phdr *nhdr, *phdr;
147		struct elfhdr *elf;
(gdb) 148		struct memelfnote notes[3];
149		off_t offset = 0;
150		struct kcore_list *m;
151	
152		/* setup ELF header */
153		elf = (struct elfhdr *) bufp;
154		bufp += sizeof(struct elfhdr);
155		offset += sizeof(struct elfhdr);
156		memcpy(elf->e_ident, ELFMAG, SELFMAG);
157		elf->e_ident[EI_CLASS]	= ELF_CLASS;
(gdb) 
(gdb) ####################################
(gdb) # c02d3076, stack size:  328 bytes #
(gdb) ####################################
(gdb) 0xc02d3076 is in rt_cache_seq_show (net/ipv4/route.c:292).
287		if (v && v != SEQ_START_TOKEN)
288			rcu_read_unlock_bh();
289	}
290	
291	static int rt_cache_seq_show(struct seq_file *seq, void *v)
292	{
293		if (v == SEQ_START_TOKEN)
294			seq_printf(seq, "%-127s\n",
295				   "Iface\tDestination\tGateway \tFlags\t\tRefCnt\tUse\t"
296				   "Metric\tSource\t\tMTU\tWindow\tIRTT\tTOS\tHHRef\t"
(gdb) 297				   "HHUptod\tSpecDst");
298		else {
299			struct rtable *r = v;
300			char temp[256];
301	
302			sprintf(temp, "%s\t%08lX\t%08lX\t%8X\t%d\t%u\t%d\t"
303				      "%08lX\t%d\t%u\t%u\t%02X\t%d\t%1d\t%08X",
304				r->u.dst.dev ? r->u.dst.dev->name : "*",
305				(unsigned long)r->rt_dst, (unsigned long)r->rt_gateway,
306				r->rt_flags, atomic_read(&r->u.dst.__refcnt),
(gdb) 
(gdb) ####################################
(gdb) # c02953a5, stack size:  320 bytes #
(gdb) ####################################
(gdb) 0xc02953a5 is in mo_open_write (drivers/cdrom/cdrom.c:814).
809	
810		return ret;
811	}
812	
813	static int mo_open_write(struct cdrom_device_info *cdi)
814	{
815		struct packet_command cgc;
816		char buffer[255];
817		int ret;
818	
(gdb) 819		init_cdrom_command(&cgc, &buffer, 4, CGC_DATA_READ);
820		cgc.quiet = 1;
821	
822		/*
823		 * obtain write protect information as per
824		 * drivers/scsi/sd.c:sd_read_write_protect_flag
825		 */
826	
827		ret = cdrom_mode_sense(cdi, &cgc, GPMODE_ALL_PAGES, 0);
828		if (ret)
(gdb) 
(gdb) ####################################
(gdb) # c0227bd3, stack size:  320 bytes #
(gdb) ####################################
(gdb) 0xc0227bd3 is in fb_ioctl (drivers/video/fbmem.c:769).
764	}
765	
766	static int 
767	fb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
768		 unsigned long arg)
769	{
770		int fbidx = iminor(inode);
771		struct fb_info *info = registered_fb[fbidx];
772		struct fb_ops *fb = info->fbops;
773		struct fb_var_screeninfo var;
(gdb) 774		struct fb_fix_screeninfo fix;
775		struct fb_con2fbmap con2fb;
776		struct fb_cmap_user cmap;
777		struct fb_event event;
778		void __user *argp = (void __user *)arg;
779		int i;
780		
781		if (!fb)
782			return -ENODEV;
783		switch (cmd) {
(gdb) 
(gdb) ####################################
(gdb) # c02fdec3, stack size:  312 bytes #
(gdb) ####################################
(gdb) 0xc02fdec3 is in icmp_send (net/ipv4/icmp.c:434).
429	 *			MUST NOT reply to a multicast/broadcast MAC address.
430	 *			MUST reply to only the first fragment.
431	 */
432	
433	void icmp_send(struct sk_buff *skb_in, int type, int code, u32 info)
434	{
435		struct iphdr *iph;
436		int room;
437		struct icmp_bxm icmp_param;
438		struct rtable *rt = (struct rtable *)skb_in->dst;
(gdb) 439		struct ipcm_cookie ipc;
440		u32 saddr;
441		u8  tos;
442	
443		if (!rt)
444			goto out;
445	
446		/*
447		 *	Find the original header. It is expected to be valid, of course.
448		 *	Check this, icmp_send is called from the most obscure devices
(gdb) 
(gdb) ####################################
(gdb) # c01ea456, stack size:  308 bytes #
(gdb) ####################################
(gdb) 0xc01ea456 is in xfs_trans_init (fs/xfs/xfs_trans.c:82).
77	 * in the mount structure.
78	 */
79	void
80	xfs_trans_init(
81		xfs_mount_t	*mp)
82	{
83		xfs_trans_reservations_t	*resp;
84	
85		resp = &(mp->m_reservations);
86		resp->tr_write =
(gdb) 87			(uint)(XFS_CALC_WRITE_LOG_RES(mp) + XFS_DQUOT_LOGRES(mp));
88		resp->tr_itruncate =
89			(uint)(XFS_CALC_ITRUNCATE_LOG_RES(mp) + XFS_DQUOT_LOGRES(mp));
90		resp->tr_rename =
91			(uint)(XFS_CALC_RENAME_LOG_RES(mp) + XFS_DQUOT_LOGRES(mp));
92		resp->tr_link = (uint)XFS_CALC_LINK_LOG_RES(mp);
93		resp->tr_remove =
94			(uint)(XFS_CALC_REMOVE_LOG_RES(mp) + XFS_DQUOT_LOGRES(mp));
95		resp->tr_symlink =
96			(uint)(XFS_CALC_SYMLINK_LOG_RES(mp) + XFS_DQUOT_LOGRES(mp));
(gdb) 
(gdb) ####################################
(gdb) # c022af86, stack size:  300 bytes #
(gdb) ####################################
(gdb) 0xc022af86 is in store_mode (drivers/video/fbsysfs.c:108).
103		return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d-%d\n", m, mode->xres, mode->yres, mode->refresh);
104	}
105	
106	static ssize_t store_mode(struct class_device *class_device, const char * buf,
107				  size_t count)
108	{
109		struct fb_info *fb_info =
110			(struct fb_info *)class_get_devdata(class_device);
111		char mstr[100];
112		struct fb_var_screeninfo var;
(gdb) 113		struct fb_modelist *modelist;
114		struct fb_videomode *mode;
115		struct list_head *pos;
116		size_t i;
117		int err;
118	
119		memset(&var, 0, sizeof(var));
120	
121		list_for_each(pos, &fb_info->modelist) {
122			modelist = list_entry(pos, struct fb_modelist, list);
(gdb) 
(gdb) ####################################
(gdb) # c049cae6, stack size:  292 bytes #
(gdb) ####################################
(gdb) 0xc049cae6 is in huft_build (inflate.c:293).
288	/* Given a list of code lengths and a maximum table size, make a set of
289	   tables to decode that set of codes.  Return zero on success, one if
290	   the given code set is incomplete (the tables are still built in this
291	   case), two if the input is invalid (all zero length codes or an
292	   oversubscribed set of lengths), and three if not enough memory. */
293	{
294	  unsigned a;                   /* counter for codes of length k */
295	  unsigned c[BMAX+1];           /* bit length count table */
296	  unsigned f;                   /* i repeats in table every f entries */
297	  int g;                        /* maximum code length */
(gdb) 298	  int h;                        /* table level */
299	  register unsigned i;          /* counter, current code */
300	  register unsigned j;          /* counter */
301	  register int k;               /* number of bits in current code */
302	  int l;                        /* bits per table (returned in m) */
303	  register unsigned *p;         /* pointer into c[], b[], or v[] */
304	  register struct huft *q;      /* points to current table */
305	  struct huft r;                /* table entry for structure assignment */
306	  struct huft *u[BMAX];         /* table stack */
307	  unsigned *v;                  /* values in order of bit length */
(gdb) 
(gdb) ####################################
(gdb) # c02b9426, stack size:  288 bytes #
(gdb) ####################################
(gdb) 0xc02b9426 is in sys_sendmsg (net/socket.c:1692).
1687	/*
1688	 *	BSD sendmsg interface
1689	 */
1690	
1691	asmlinkage long sys_sendmsg(int fd, struct msghdr __user *msg, unsigned flags)
1692	{
1693		struct compat_msghdr __user *msg_compat = (struct compat_msghdr __user *)msg;
1694		struct socket *sock;
1695		char address[MAX_SOCK_ADDR];
1696		struct iovec iovstack[UIO_FASTIOV], *iov = iovstack;
(gdb) 1697		unsigned char ctl[sizeof(struct cmsghdr) + 20];	/* 20 is size of ipv6_pktinfo */
1698		unsigned char *ctl_buf = ctl;
1699		struct msghdr msg_sys;
1700		int err, ctl_len, iov_size, total_len;
1701		
1702		err = -EFAULT;
1703		if (MSG_CMSG_COMPAT & flags) {
1704			if (get_compat_msghdr(&msg_sys, msg_compat))
1705				return -EFAULT;
1706		} else if (copy_from_user(&msg_sys, msg, sizeof(struct msghdr)))
(gdb) 
(gdb) ####################################
(gdb) # c01825c3, stack size:  288 bytes #
(gdb) ####################################
(gdb) 0xc01825c3 is in setxattr (fs/xattr.c:27).
22	 * Extended attribute SET operations
23	 */
24	static long
25	setxattr(struct dentry *d, char __user *name, void __user *value,
26		 size_t size, int flags)
27	{
28		int error;
29		void *kvalue = NULL;
30		char kname[XATTR_NAME_MAX + 1];
31	
(gdb) 32		if (flags & ~(XATTR_CREATE|XATTR_REPLACE))
33			return -EINVAL;
34	
35		error = strncpy_from_user(kname, name, sizeof(kname));
36		if (error == 0 || error == sizeof(kname))
37			error = -ERANGE;
38		if (error < 0)
39			return error;
40	
41		if (size) {
(gdb) 
(gdb) ####################################
(gdb) # c01828a3, stack size:  284 bytes #
(gdb) ####################################
(gdb) 0xc01828a3 is in getxattr (fs/xattr.c:120).
115	/*
116	 * Extended attribute GET operations
117	 */
118	static ssize_t
119	getxattr(struct dentry *d, char __user *name, void __user *value, size_t size)
120	{
121		ssize_t error;
122		void *kvalue = NULL;
123		char kname[XATTR_NAME_MAX + 1];
124	
(gdb) 125		error = strncpy_from_user(kname, name, sizeof(kname));
126		if (error == 0 || error == sizeof(kname))
127			error = -ERANGE;
128		if (error < 0)
129			return error;
130	
131		if (size) {
132			if (size > XATTR_SIZE_MAX)
133				size = XATTR_SIZE_MAX;
134			kvalue = kmalloc(size, GFP_KERNEL);
(gdb) 
(gdb) ####################################
(gdb) # c02dd456, stack size:  280 bytes #
(gdb) ####################################
(gdb) 0xc02dd456 is in ip_send_reply (net/ipv4/ip_output.c:1276).
1271	 *
1272	 *	LATER: switch from ip_build_xmit to ip_append_*
1273	 */
1274	void ip_send_reply(struct sock *sk, struct sk_buff *skb, struct ip_reply_arg *arg,
1275			   unsigned int len)
1276	{
1277		struct inet_sock *inet = inet_sk(sk);
1278		struct {
1279			struct ip_options	opt;
1280			char			data[40];
(gdb) 1281		} replyopts;
1282		struct ipcm_cookie ipc;
1283		u32 daddr;
1284		struct rtable *rt = (struct rtable*)skb->dst;
1285	
1286		if (ip_options_echo(&replyopts.opt, skb))
1287			return;
1288	
1289		daddr = ipc.addr = rt->rt_src;
1290		ipc.opt = NULL;
(gdb) 
(gdb) ####################################
(gdb) # c0182d33, stack size:  280 bytes #
(gdb) ####################################
(gdb) 0xc0182d33 is in removexattr (fs/xattr.c:289).
284	/*
285	 * Extended attribute REMOVE operations
286	 */
287	static long
288	removexattr(struct dentry *d, char __user *name)
289	{
290		int error;
291		char kname[XATTR_NAME_MAX + 1];
292	
293		error = strncpy_from_user(kname, name, sizeof(kname));
(gdb) 294		if (error == 0 || error == sizeof(kname))
295			error = -ERANGE;
296		if (error < 0)
297			return error;
298	
299		error = -EOPNOTSUPP;
300		if (d->d_inode->i_op && d->d_inode->i_op->removexattr) {
301			error = security_inode_removexattr(d, kname);
302			if (error)
303				goto out;
(gdb) 
(gdb) ####################################
(gdb) # c02b1f86, stack size:  276 bytes #
(gdb) ####################################
(gdb) 0xc02b1f86 is in cpufreq_add_dev (drivers/cpufreq/cpufreq.c:568).
563	 * cpufreq_add_dev - add a CPU device
564	 *
565	 * Adds the cpufreq interface for a CPU device. 
566	 */
567	static int cpufreq_add_dev (struct sys_device * sys_dev)
568	{
569		unsigned int cpu = sys_dev->id;
570		int ret = 0;
571		struct cpufreq_policy new_policy;
572		struct cpufreq_policy *policy;
(gdb) 573		struct freq_attr **drv_attr;
574		unsigned long flags;
575		unsigned int j;
576	
577		cpufreq_debug_disable_ratelimit();
578		dprintk("adding CPU %u\n", cpu);
579	
580	#ifdef CONFIG_SMP
581		/* check whether a different CPU already registered this
582		 * CPU because it is in the same boat. */
(gdb) 
(gdb) ####################################
(gdb) # c02b1c73, stack size:  276 bytes #
(gdb) ####################################
(gdb) 0xc02b1c73 is in store_scaling_governor (drivers/cpufreq/cpufreq.c:406).
401	/**
402	 * store_scaling_governor - store policy for the specified CPU
403	 */
404	static ssize_t store_scaling_governor (struct cpufreq_policy * policy, 
405					       const char *buf, size_t count) 
406	{
407		unsigned int ret = -EINVAL;
408		char	str_governor[16];
409		struct cpufreq_policy new_policy;
410	
(gdb) 411		ret = cpufreq_get_policy(&new_policy, policy->cpu);
412		if (ret)
413			return ret;
414	
415		ret = sscanf (buf, "%15s", str_governor);
416		if (ret != 1)
417			return -EINVAL;
418	
419		if (cpufreq_parse_governor(str_governor, &new_policy.policy, &new_policy.governor))
420			return -EINVAL;
(gdb) 
(gdb) ####################################
(gdb) # c04b4bb5, stack size:  272 bytes #
(gdb) ####################################
(gdb) 0xc04b4bb5 is in pirq_peer_trick (arch/i386/pci/irq.c:96).
91	 *  bridges.  It's a gross hack, but since there are no other known
92	 *  ways how to get a list of buses, we have to go this way.
93	 */
94	
95	static void __init pirq_peer_trick(void)
96	{
97		struct irq_routing_table *rt = pirq_table;
98		u8 busmap[256];
99		int i;
100		struct irq_info *e;
(gdb) 101	
102		memset(busmap, 0, sizeof(busmap));
103		for(i=0; i < (rt->size - sizeof(struct irq_routing_table)) / sizeof(struct irq_info); i++) {
104			e = &rt->slots[i];
105	#ifdef DEBUG
106			{
107				int j;
108				DBG("%02x:%02x slot=%02x", e->bus, e->devfn/8, e->slot);
109				for(j=0; j<4; j++)
110					DBG(" %d:%02x/%04x", j, e->irq[j].link, e->irq[j].bitmap);
(gdb) 
(gdb) ####################################
(gdb) # c02b3003, stack size:  272 bytes #
(gdb) ####################################
(gdb) 0xc02b3003 is in cpufreq_update_policy (drivers/cpufreq/cpufreq.c:1391).
1386	 *
1387	 *	Usefull for policy notifiers which have different necessities
1388	 *	at different times.
1389	 */
1390	int cpufreq_update_policy(unsigned int cpu)
1391	{
1392		struct cpufreq_policy *data = cpufreq_cpu_get(cpu);
1393		struct cpufreq_policy policy;
1394		int ret = 0;
1395	
(gdb) 1396		if (!data)
1397			return -ENODEV;
1398	
1399		down(&data->lock);
1400	
1401		dprintk("updating policy for CPU %u\n", cpu);
1402		memcpy(&policy, 
1403		       data,
1404		       sizeof(struct cpufreq_policy));
1405		policy.min = data->user_policy.min;
(gdb) 
(gdb) ####################################
(gdb) # c0297193, stack size:  268 bytes #
(gdb) ####################################
(gdb) 0xc0297193 is in dvd_read_bca (drivers/cdrom/cdrom.c:1831).
1826		kfree(buf);
1827		return ret;
1828	}
1829	
1830	static int dvd_read_bca(struct cdrom_device_info *cdi, dvd_struct *s)
1831	{
1832		int ret;
1833		u_char buf[4 + 188];
1834		struct packet_command cgc;
1835		struct cdrom_device_ops *cdo = cdi->ops;
(gdb) 1836	
1837		init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
1838		cgc.cmd[0] = GPCMD_READ_DVD_STRUCTURE;
1839		cgc.cmd[7] = s->type;
1840		cgc.cmd[9] = cgc.buflen = 0xff;
1841	
1842		if ((ret = cdo->generic_packet(cdi, &cgc)))
1843			return ret;
1844	
1845		s->bca.len = buf[0] << 8 | buf[1];
(gdb) 
(gdb) ####################################
(gdb) # c01d9e46, stack size:  268 bytes #
(gdb) ####################################
(gdb) 0xc01d9e46 is in xfs_iomap_write_delay (fs/xfs/xfs_iomap.c:552).
547		xfs_off_t	offset,
548		size_t		count,
549		int		ioflag,
550		xfs_bmbt_irec_t *ret_imap,
551		int		*nmaps)
552	{
553		xfs_mount_t	*mp = ip->i_mount;
554		xfs_iocore_t	*io = &ip->i_iocore;
555		xfs_fileoff_t	offset_fsb;
556		xfs_fileoff_t	last_fsb;
(gdb) 557		xfs_fsize_t	isize;
558		xfs_fsblock_t	firstblock;
559		int		nimaps;
560		int		error;
561		xfs_bmbt_irec_t imap[XFS_WRITE_IMAPS];
562		int		aeof;
563		int		fsynced = 0;
564	
565		ASSERT(ismrlocked(&ip->i_lock, MR_UPDATE) != 0);
566	
(gdb) 
(gdb) ####################################
(gdb) # c01cd5b6, stack size:  268 bytes #
(gdb) ####################################
(gdb) 0xc01cd5b6 is in xfs_ialloc_ag_alloc (fs/xfs/xfs_ialloc.c:138).
133	STATIC int				/* error code or 0 */
134	xfs_ialloc_ag_alloc(
135		xfs_trans_t	*tp,		/* transaction pointer */
136		xfs_buf_t	*agbp,		/* alloc group buffer */
137		int		*alloc)
138	{
139		xfs_agi_t	*agi;		/* allocation group header */
140		xfs_alloc_arg_t	args;		/* allocation argument structure */
141		int		blks_per_cluster;  /* fs blocks per inode cluster */
142		xfs_btree_cur_t	*cur;		/* inode btree cursor */
(gdb) 143		xfs_daddr_t	d;		/* disk addr of buffer */
144		int		error;
145		xfs_buf_t	*fbuf;		/* new free inodes' buffer */
146		xfs_dinode_t	*free;		/* new free inode structure */
147		int		i;		/* inode counter */
148		int		j;		/* block counter */
149		int		nbufs;		/* num bufs of new inodes */
150		xfs_agino_t	newino;		/* new first inode's number */
151		xfs_agino_t	newlen;		/* new number of inodes */
152		int		ninodes;	/* num inodes per buf */
(gdb) 
(gdb) ####################################
(gdb) # c0178186, stack size:  268 bytes #
(gdb) ####################################
(gdb) 0xc0178186 is in locks_remove_flock (fs/locks.c:1859).
1854	
1855	/*
1856	 * This function is called on the last close of an open file.
1857	 */
1858	void locks_remove_flock(struct file *filp)
1859	{
1860		struct inode * inode = filp->f_dentry->d_inode; 
1861		struct file_lock *fl;
1862		struct file_lock **before;
1863	
(gdb) 1864		if (!inode->i_flock)
1865			return;
1866	
1867		if (filp->f_op && filp->f_op->flock) {
1868			struct file_lock fl = {
1869				.fl_pid = current->tgid,
1870				.fl_file = filp,
1871				.fl_flags = FL_FLOCK,
1872				.fl_type = F_UNLCK,
1873				.fl_end = OFFSET_MAX,
(gdb) 
(gdb) ####################################
(gdb) # c012bc04, stack size:  268 bytes #
(gdb) ####################################
(gdb) 0xc012bc04 is in sys_reboot (kernel/sys.c:372).
367	 * You can also set the meaning of the ctrl-alt-del-key here.
368	 *
369	 * reboot doesn't sync: do that yourself before calling this.
370	 */
371	asmlinkage long sys_reboot(int magic1, int magic2, unsigned int cmd, void __user * arg)
372	{
373		char buffer[256];
374	
375		/* We only trust the superuser with rebooting the system. */
376		if (!capable(CAP_SYS_BOOT))
(gdb) 377			return -EPERM;
378	
379		/* For safety, we require "magic" arguments. */
380		if (magic1 != LINUX_REBOOT_MAGIC1 ||
381		    (magic2 != LINUX_REBOOT_MAGIC2 &&
382		                magic2 != LINUX_REBOOT_MAGIC2A &&
383				magic2 != LINUX_REBOOT_MAGIC2B &&
384		                magic2 != LINUX_REBOOT_MAGIC2C))
385			return -EINVAL;
386	
(gdb) 
(gdb) ####################################
(gdb) # c02b96d6, stack size:  264 bytes #
(gdb) ####################################
(gdb) 0xc02b96d6 is in sys_recvmsg (net/socket.c:1786).
1781	/*
1782	 *	BSD recvmsg interface
1783	 */
1784	
1785	asmlinkage long sys_recvmsg(int fd, struct msghdr __user *msg, unsigned int flags)
1786	{
1787		struct compat_msghdr __user *msg_compat = (struct compat_msghdr __user *)msg;
1788		struct socket *sock;
1789		struct iovec iovstack[UIO_FASTIOV];
1790		struct iovec *iov=iovstack;
(gdb) 1791		struct msghdr msg_sys;
1792		unsigned long cmsg_ptr;
1793		int err, iov_size, total_len, len;
1794	
1795		/* kernel mode address */
1796		char addr[MAX_SOCK_ADDR];
1797	
1798		/* user mode address pointers */
1799		struct sockaddr __user *uaddr;
1800		int __user *uaddr_len;
(gdb) 
(gdb) ####################################
(gdb) # c0280a83, stack size:  260 bytes #
(gdb) ####################################
(gdb) 0xc0280a83 is in generic_ide_resume (drivers/ide/ide.c:1238).
1233	
1234		return ide_do_drive_cmd(drive, &rq, ide_wait);
1235	}
1236	
1237	static int generic_ide_resume(struct device *dev)
1238	{
1239		ide_drive_t *drive = dev->driver_data;
1240		struct request rq;
1241		struct request_pm_state rqpm;
1242		ide_task_t args;
(gdb) 1243	
1244		memset(&rq, 0, sizeof(rq));
1245		memset(&rqpm, 0, sizeof(rqpm));
1246		memset(&args, 0, sizeof(args));
1247		rq.flags = REQ_PM_RESUME;
1248		rq.special = &args;
1249		rq.pm = &rqpm;
1250		rqpm.pm_step = ide_pm_state_start_resume;
1251		rqpm.pm_state = 0;
1252	
(gdb) 
(gdb) ####################################
(gdb) # c02809e3, stack size:  260 bytes #
(gdb) ####################################
(gdb) 0xc02809e3 is in generic_ide_suspend (drivers/ide/ide.c:1219).
1214	}
1215	
1216	EXPORT_SYMBOL(system_bus_clock);
1217	
1218	static int generic_ide_suspend(struct device *dev, pm_message_t state)
1219	{
1220		ide_drive_t *drive = dev->driver_data;
1221		struct request rq;
1222		struct request_pm_state rqpm;
1223		ide_task_t args;
(gdb) 1224	
1225		memset(&rq, 0, sizeof(rq));
1226		memset(&rqpm, 0, sizeof(rqpm));
1227		memset(&args, 0, sizeof(args));
1228		rq.flags = REQ_PM_SUSPEND;
1229		rq.special = &args;
1230		rq.pm = &rqpm;
1231		rqpm.pm_step = ide_pm_state_start_suspend;
1232		rqpm.pm_state = state;
1233	
(gdb) 
(gdb) ####################################
(gdb) # c0277623, stack size:  260 bytes #
(gdb) ####################################
(gdb) 0xc0277623 is in blkpg_ioctl (drivers/block/ioctl.c:10).
5	#include <linux/buffer_head.h>
6	#include <linux/smp_lock.h>
7	#include <asm/uaccess.h>
8	
9	static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user *arg)
10	{
11		struct block_device *bdevp;
12		struct gendisk *disk;
13		struct blkpg_ioctl_arg a;
14		struct blkpg_partition p;
(gdb) 15		long long start, length;
16		int part;
17		int i;
18	
19		if (!capable(CAP_SYS_ADMIN))
20			return -EACCES;
21		if (copy_from_user(&a, arg, sizeof(struct blkpg_ioctl_arg)))
22			return -EFAULT;
23		if (copy_from_user(&p, a.data, sizeof(struct blkpg_partition)))
24			return -EFAULT;
(gdb) 
(gdb) ####################################
(gdb) # c01a99b6, stack size:  256 bytes #
(gdb) ####################################
(gdb) 0xc01a99b6 is in xfs_bmap_alloc (fs/xfs/xfs_bmap.c:2154).
2149	 * It figures out where to ask the underlying allocator to put the new extent.
2150	 */
2151	STATIC int				/* error */
2152	xfs_bmap_alloc(
2153		xfs_bmalloca_t	*ap)		/* bmap alloc argument struct */
2154	{
2155		xfs_fsblock_t	adjust;		/* adjustment to block numbers */
2156		xfs_alloctype_t	atype=0;	/* type for allocation routines */
2157		int		error;		/* error return value */
2158		xfs_agnumber_t	fb_agno;	/* ag number of ap->firstblock */
(gdb) 2159		xfs_mount_t	*mp;		/* mount point structure */
2160		int		nullfb;		/* true if ap->firstblock isn't set */
2161		int		rt;		/* true if inode is realtime */
2162	#ifdef __KERNEL__
2163		xfs_extlen_t	prod=0;		/* product factor for allocators */
2164		xfs_extlen_t	ralen=0;	/* realtime allocation length */
2165	#endif
2166	
2167	#define	ISVALID(x,y)	\
2168		(rt ? \
(gdb) 
