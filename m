Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262592AbTCRWQM>; Tue, 18 Mar 2003 17:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262591AbTCRWQM>; Tue, 18 Mar 2003 17:16:12 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2052 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262736AbTCRWMN>;
	Tue, 18 Mar 2003 17:12:13 -0500
Date: Tue, 18 Mar 2003 21:25:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: sfr@canb.auug.org.au, kernel list <linux-kernel@vger.kernel.org>
Subject: sys32_ioctl -> compact_sys_ioctl patches
Message-ID: <20030318202524.GA132@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried posting ioctl32 patches to Linus several times, and got
nothing back.

Patches were tested at x86-64 and sparc64, and general attitude seems
to be "anything that gets code out of ioctl32.c is welcome".

Do you think you could try to push them through?

								Pavel

%patch
Index: linux-quilt/arch/ia64/ia32/ia32_entry.S
--- .pc/ioc/arch/ia64/ia32/ia32_entry.S	2003-03-18 18:34:08.000000000 +0100
+++ arch/ia64/ia32/ia32_entry.S	2003-03-18 17:22:21.000000000 +0100
@@ -252,7 +252,7 @@
 	data8 sys_acct
 	data8 sys_umount	  /* recycled never used phys( */
 	data8 sys32_ni_syscall	  /* old lock syscall holder */
-	data8 sys32_ioctl
+	data8 compat_sys_ioctl
 	data8 sys32_fcntl	  /* 55 */
 	data8 sys32_ni_syscall	  /* old mpx syscall holder */
 	data8 sys_setpgid
Index: linux-quilt/arch/ia64/ia32/ia32_ioctl.c
--- .pc/ioc/arch/ia64/ia32/ia32_ioctl.c	2003-03-18 18:34:08.000000000 +0100
+++ arch/ia64/ia32/ia32_ioctl.c	2003-03-18 17:22:21.000000000 +0100
@@ -293,221 +293,3 @@
 	}
 	return err;
 }
-
-asmlinkage long
-sys32_ioctl (unsigned int fd, unsigned int cmd, unsigned int arg)
-{
-	long ret;
-
-	switch (IOCTL_NR(cmd)) {
-	      case IOCTL_NR(VFAT_IOCTL_READDIR_SHORT):
-	      case IOCTL_NR(VFAT_IOCTL_READDIR_BOTH): {
-		      struct linux32_dirent *d32 = P(arg);
-		      struct dirent d[2];
-
-		      ret = DO_IOCTL(fd, _IOR('r', _IOC_NR(cmd),
-					      struct dirent [2]),
-				     (unsigned long) d);
-		      if (ret < 0)
-			  return ret;
-
-		      if (put_dirent32(d, d32) || put_dirent32(d + 1, d32 + 1))
-			  return -EFAULT;
-
-		      return ret;
-	      }
-		case IOCTL_NR(SIOCGIFCONF):
-		{
-			struct ifconf32 {
-				int		ifc_len;
-				unsigned int	ifc_ptr;
-			} ifconf32;
-			struct ifconf ifconf;
-			int i, n;
-			char *p32, *p64;
-			char buf[32];	/* sizeof IA32 ifreq structure */
-
-			if (copy_from_user(&ifconf32, P(arg), sizeof(ifconf32)))
-				return -EFAULT;
-			ifconf.ifc_len = ifconf32.ifc_len;
-			ifconf.ifc_req = P(ifconf32.ifc_ptr);
-			ret = DO_IOCTL(fd, SIOCGIFCONF, &ifconf);
-			ifconf32.ifc_len = ifconf.ifc_len;
-			if (copy_to_user(P(arg), &ifconf32, sizeof(ifconf32)))
-				return -EFAULT;
-			n = ifconf.ifc_len / sizeof(struct ifreq);
-			p32 = P(ifconf32.ifc_ptr);
-			p64 = P(ifconf32.ifc_ptr);
-			for (i = 0; i < n; i++) {
-				if (copy_from_user(buf, p64, sizeof(struct ifreq)))
-					return -EFAULT;
-				if (copy_to_user(p32, buf, sizeof(buf)))
-					return -EFAULT;
-				p32 += sizeof(buf);
-				p64 += sizeof(struct ifreq);
-			}
-			return ret;
-		}
-
-	      case IOCTL_NR(DRM_IOCTL_VERSION):
-	      {
-		      drm_version_t ver;
-		      struct {
-			      int	version_major;
-			      int	version_minor;
-			      int	version_patchlevel;
-			      unsigned int name_len;
-			      unsigned int name; /* pointer */
-			      unsigned int date_len;
-			      unsigned int date; /* pointer */
-			      unsigned int desc_len;
-			      unsigned int desc; /* pointer */
-		      } ver32;
-
-		      if (copy_from_user(&ver32, P(arg), sizeof(ver32)))
-			      return -EFAULT;
-		      ver.name_len = ver32.name_len;
-		      ver.name = P(ver32.name);
-		      ver.date_len = ver32.date_len;
-		      ver.date = P(ver32.date);
-		      ver.desc_len = ver32.desc_len;
-		      ver.desc = P(ver32.desc);
-		      ret = DO_IOCTL(fd, DRM_IOCTL_VERSION, &ver);
-		      if (ret >= 0) {
-			      ver32.version_major = ver.version_major;
-			      ver32.version_minor = ver.version_minor;
-			      ver32.version_patchlevel = ver.version_patchlevel;
-			      ver32.name_len = ver.name_len;
-			      ver32.date_len = ver.date_len;
-			      ver32.desc_len = ver.desc_len;
-			      if (copy_to_user(P(arg), &ver32, sizeof(ver32)))
-				      return -EFAULT;
-		      }
-		      return ret;
-	      }
-
-	      case IOCTL_NR(DRM_IOCTL_GET_UNIQUE):
-	      {
-		      drm_unique_t un;
-		      struct {
-			      unsigned int unique_len;
-			      unsigned int unique;
-		      } un32;
-
-		      if (copy_from_user(&un32, P(arg), sizeof(un32)))
-			      return -EFAULT;
-		      un.unique_len = un32.unique_len;
-		      un.unique = P(un32.unique);
-		      ret = DO_IOCTL(fd, DRM_IOCTL_GET_UNIQUE, &un);
-		      if (ret >= 0) {
-			      un32.unique_len = un.unique_len;
-			      if (copy_to_user(P(arg), &un32, sizeof(un32)))
-				      return -EFAULT;
-		      }
-		      return ret;
-	      }
-	      case IOCTL_NR(DRM_IOCTL_SET_UNIQUE):
-	      case IOCTL_NR(DRM_IOCTL_ADD_MAP):
-	      case IOCTL_NR(DRM_IOCTL_ADD_BUFS):
-	      case IOCTL_NR(DRM_IOCTL_MARK_BUFS):
-	      case IOCTL_NR(DRM_IOCTL_INFO_BUFS):
-	      case IOCTL_NR(DRM_IOCTL_MAP_BUFS):
-	      case IOCTL_NR(DRM_IOCTL_FREE_BUFS):
-	      case IOCTL_NR(DRM_IOCTL_ADD_CTX):
-	      case IOCTL_NR(DRM_IOCTL_RM_CTX):
-	      case IOCTL_NR(DRM_IOCTL_MOD_CTX):
-	      case IOCTL_NR(DRM_IOCTL_GET_CTX):
-	      case IOCTL_NR(DRM_IOCTL_SWITCH_CTX):
-	      case IOCTL_NR(DRM_IOCTL_NEW_CTX):
-	      case IOCTL_NR(DRM_IOCTL_RES_CTX):
-
-	      case IOCTL_NR(DRM_IOCTL_AGP_ACQUIRE):
-	      case IOCTL_NR(DRM_IOCTL_AGP_RELEASE):
-	      case IOCTL_NR(DRM_IOCTL_AGP_ENABLE):
-	      case IOCTL_NR(DRM_IOCTL_AGP_INFO):
-	      case IOCTL_NR(DRM_IOCTL_AGP_ALLOC):
-	      case IOCTL_NR(DRM_IOCTL_AGP_FREE):
-	      case IOCTL_NR(DRM_IOCTL_AGP_BIND):
-	      case IOCTL_NR(DRM_IOCTL_AGP_UNBIND):
-
-		/* Mga specific ioctls */
-
-	      case IOCTL_NR(DRM_IOCTL_MGA_INIT):
-
-		/* I810 specific ioctls */
-
-	      case IOCTL_NR(DRM_IOCTL_I810_GETBUF):
-	      case IOCTL_NR(DRM_IOCTL_I810_COPY):
-
-	      case IOCTL_NR(MTIOCGET):
-	      case IOCTL_NR(MTIOCPOS):
-	      case IOCTL_NR(MTIOCGETCONFIG):
-	      case IOCTL_NR(MTIOCSETCONFIG):
-	      case IOCTL_NR(PPPIOCSCOMPRESS):
-	      case IOCTL_NR(PPPIOCGIDLE):
-	      case IOCTL_NR(NCP_IOC_GET_FS_INFO_V2):
-	      case IOCTL_NR(NCP_IOC_GETOBJECTNAME):
-	      case IOCTL_NR(NCP_IOC_SETOBJECTNAME):
-	      case IOCTL_NR(NCP_IOC_GETPRIVATEDATA):
-	      case IOCTL_NR(NCP_IOC_SETPRIVATEDATA):
-	      case IOCTL_NR(NCP_IOC_GETMOUNTUID2):
-	      case IOCTL_NR(CAPI_MANUFACTURER_CMD):
-	      case IOCTL_NR(VIDIOCGTUNER):
-	      case IOCTL_NR(VIDIOCSTUNER):
-	      case IOCTL_NR(VIDIOCGWIN):
-	      case IOCTL_NR(VIDIOCSWIN):
-	      case IOCTL_NR(VIDIOCGFBUF):
-	      case IOCTL_NR(VIDIOCSFBUF):
-	      case IOCTL_NR(MGSL_IOCSPARAMS):
-	      case IOCTL_NR(MGSL_IOCGPARAMS):
-	      case IOCTL_NR(ATM_GETNAMES):
-	      case IOCTL_NR(ATM_GETLINKRATE):
-	      case IOCTL_NR(ATM_GETTYPE):
-	      case IOCTL_NR(ATM_GETESI):
-	      case IOCTL_NR(ATM_GETADDR):
-	      case IOCTL_NR(ATM_RSTADDR):
-	      case IOCTL_NR(ATM_ADDADDR):
-	      case IOCTL_NR(ATM_DELADDR):
-	      case IOCTL_NR(ATM_GETCIRANGE):
-	      case IOCTL_NR(ATM_SETCIRANGE):
-	      case IOCTL_NR(ATM_SETESI):
-	      case IOCTL_NR(ATM_SETESIF):
-	      case IOCTL_NR(ATM_GETSTAT):
-	      case IOCTL_NR(ATM_GETSTATZ):
-	      case IOCTL_NR(ATM_GETLOOP):
-	      case IOCTL_NR(ATM_SETLOOP):
-	      case IOCTL_NR(ATM_QUERYLOOP):
-	      case IOCTL_NR(ENI_SETMULT):
-	      case IOCTL_NR(NS_GETPSTAT):
-		/* case IOCTL_NR(NS_SETBUFLEV): This is a duplicate case with ZATM_GETPOOLZ */
-	      case IOCTL_NR(ZATM_GETPOOLZ):
-	      case IOCTL_NR(ZATM_GETPOOL):
-	      case IOCTL_NR(ZATM_SETPOOL):
-	      case IOCTL_NR(ZATM_GETTHIST):
-	      case IOCTL_NR(IDT77105_GETSTAT):
-	      case IOCTL_NR(IDT77105_GETSTATZ):
-	      case IOCTL_NR(IXJCTL_TONE_CADENCE):
-	      case IOCTL_NR(IXJCTL_FRAMES_READ):
-	      case IOCTL_NR(IXJCTL_FRAMES_WRITTEN):
-	      case IOCTL_NR(IXJCTL_READ_WAIT):
-	      case IOCTL_NR(IXJCTL_WRITE_WAIT):
-	      case IOCTL_NR(IXJCTL_DRYBUFFER_READ):
-	      case IOCTL_NR(I2OHRTGET):
-	      case IOCTL_NR(I2OLCTGET):
-	      case IOCTL_NR(I2OPARMSET):
-	      case IOCTL_NR(I2OPARMGET):
-	      case IOCTL_NR(I2OSWDL):
-	      case IOCTL_NR(I2OSWUL):
-	      case IOCTL_NR(I2OSWDEL):
-	      case IOCTL_NR(I2OHTML):
-		break;
-	      default:
-		return sys_ioctl(fd, cmd, (unsigned long)arg);
-
-		case IOCTL_NR(SG_IO):
-			return(sg_ioctl_trans(fd, cmd, arg));
-
-	}
-	printk(KERN_ERR "%x:unimplemented IA32 ioctl system call\n", cmd);
-	return -EINVAL;
-}
Index: linux-quilt/arch/mips64/kernel/ioctl32.c
--- .pc/ioc/arch/mips64/kernel/ioctl32.c	2003-03-18 18:34:09.000000000 +0100
+++ arch/mips64/kernel/ioctl32.c	2003-03-16 18:51:04.000000000 +0100
@@ -822,70 +822,3 @@
 
 #define NR_IOCTL32_HANDLERS	(sizeof(ioctl32_handler_table) /	\
 				 sizeof(ioctl32_handler_table[0]))
-
-static struct ioctl32_list *ioctl32_hash_table[1024];
-
-static inline int ioctl32_hash(unsigned int cmd)
-{
-	return ((cmd >> 6) ^ (cmd >> 4) ^ cmd) & 0x3ff;
-}
-
-int sys32_ioctl(unsigned int fd, unsigned int cmd, unsigned int arg)
-{
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
-	struct file *filp;
-	struct ioctl32_list *l;
-	int error;
-
-	l = ioctl32_hash_table[ioctl32_hash(cmd)];
-
-	error = -EBADF;
-
-	filp = fget(fd);
-	if (!filp)
-		return error;
-
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
-		goto out;
-	}
-
-	while (l && l->handler.cmd != cmd)
-		l = l->next;
-
-	if (l) {
-		handler = (void *)l->handler.function;
-		error = handler(fd, cmd, arg, filp);
-	} else {
-		error = -EINVAL;
-		printk("unknown ioctl: %08x\n", cmd);
-	}
-out:
-	fput(filp);
-	return error;
-}
-
-static void ioctl32_insert(struct ioctl32_list *entry)
-{
-	int hash = ioctl32_hash(entry->handler.cmd);
-	if (!ioctl32_hash_table[hash])
-		ioctl32_hash_table[hash] = entry;
-	else {
-		struct ioctl32_list *l;
-		l = ioctl32_hash_table[hash];
-		while (l->next)
-			l = l->next;
-		l->next = entry;
-		entry->next = 0;
-	}
-}
-
-static int __init init_ioctl32(void)
-{
-	int i;
-	for (i = 0; i < NR_IOCTL32_HANDLERS; i++)
-		ioctl32_insert(&ioctl32_handler_table[i]);
-	return 0;
-}
-
-__initcall(init_ioctl32);
Index: linux-quilt/arch/mips64/kernel/scall_o32.S
--- .pc/ioc/arch/mips64/kernel/scall_o32.S	2003-03-18 18:34:09.000000000 +0100
+++ arch/mips64/kernel/scall_o32.S	2003-03-18 17:22:23.000000000 +0100
@@ -287,7 +287,7 @@
 	sys	sys_acct	0
 	sys	sys_umount	2
 	sys	sys_ni_syscall	0
-	sys	sys32_ioctl	3
+	sys	compat_sys_ioctl	3
 	sys	sys32_fcntl	3			/* 4055 */
 	sys	sys_ni_syscall	2
 	sys	sys_setpgid	2
Index: linux-quilt/arch/parisc/kernel/ioctl32.c
--- .pc/ioc/arch/parisc/kernel/ioctl32.c	2003-03-18 18:34:09.000000000 +0100
+++ arch/parisc/kernel/ioctl32.c	2003-03-16 18:51:04.000000000 +0100
@@ -3697,146 +3697,3 @@
 COMPATIBLE_IOCTL(PA_PERF_OFF)
 COMPATIBLE_IOCTL(PA_PERF_VERSION)
 IOCTL_TABLE_END
-
-unsigned int ioctl32_hash_table[1024];
-
-extern inline unsigned long ioctl32_hash(unsigned long cmd)
-{
-	return ((cmd >> 6) ^ (cmd >> 4) ^ cmd) & 0x3ff;
-}
-
-static void ioctl32_insert_translation(struct ioctl_trans *trans)
-{
-	unsigned long hash;
-	struct ioctl_trans *t;
-
-	hash = ioctl32_hash (trans->cmd);
-	if (!ioctl32_hash_table[hash])
-		ioctl32_hash_table[hash] = (u32)(long)trans;
-	else {
-		t = (struct ioctl_trans *)(long)ioctl32_hash_table[hash];
-		while (t->next)
-			t = (struct ioctl_trans *)(long)t->next;
-		trans->next = 0;
-		t->next = (u32)(long)trans;
-	}
-}
-
-static int __init init_sys32_ioctl(void)
-{
-	int i;
-	extern struct ioctl_trans ioctl_translations[], ioctl_translations_end[];
-
-	for (i = 0; &ioctl_translations[i] < &ioctl_translations_end[0]; i++)
-		ioctl32_insert_translation(&ioctl_translations[i]);
-	return 0;
-}
-
-__initcall(init_sys32_ioctl);
-
-static struct ioctl_trans *additional_ioctls;
-
-/* Always call these with kernel lock held! */
-
-int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
-{
-	int i;
-
-panic("register_ioctl32_conversion() is B0RKEN! Called by %p\n", __builtin_return_address(0));
-
-	if (!additional_ioctls) {
-		additional_ioctls = module_map(PAGE_SIZE);
-		if (!additional_ioctls)
-			return -ENOMEM;
-		memset(additional_ioctls, 0, PAGE_SIZE);
-	}
-	for (i = 0; i < PAGE_SIZE/sizeof(struct ioctl_trans); i++)
-		if (!additional_ioctls[i].cmd)
-			break;
-	if (i == PAGE_SIZE/sizeof(struct ioctl_trans))
-		return -ENOMEM;
-	additional_ioctls[i].cmd = cmd;
-	if (!handler)
-		additional_ioctls[i].handler = (u32)(long)sys_ioctl;
-	else
-		additional_ioctls[i].handler = (u32)(long)handler;
-	ioctl32_insert_translation(&additional_ioctls[i]);
-	return 0;
-}
-
-int unregister_ioctl32_conversion(unsigned int cmd)
-{
-	unsigned long hash = ioctl32_hash(cmd);
-	struct ioctl_trans *t, *t1;
-
-	t = (struct ioctl_trans *)(long)ioctl32_hash_table[hash];
-	if (!t) return -EINVAL;
-	if (t->cmd == cmd && t >= additional_ioctls &&
-	    (unsigned long)t < ((unsigned long)additional_ioctls) + PAGE_SIZE) {
-		ioctl32_hash_table[hash] = t->next;
-		t->cmd = 0;
-		return 0;
-	} else while (t->next) {
-		t1 = (struct ioctl_trans *)(long)t->next;
-		if (t1->cmd == cmd && t1 >= additional_ioctls &&
-		    (unsigned long)t1 < ((unsigned long)additional_ioctls) + PAGE_SIZE) {
-			t1->cmd = 0;
-			t->next = t1->next;
-			return 0;
-		}
-		t = t1;
-	}
-	return -EINVAL;
-}
-
-asmlinkage int sys32_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct file * filp;
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
-	unsigned long pafnptr[4];
-	extern char __gp;
-	struct ioctl_trans *t;
-	int error = -EBADF;
-
-	filp = fget(fd);
-	if(!filp)
-		goto out2;
-
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
-		goto out;
-	}
-
-	/* intercept private networking ioctl() calls here since it is
-	 * an onerous task to figure out which ones of the HANDLE_IOCTL
-	 * list map to these values.
-	 */
-	if (cmd >= SIOCDEVPRIVATE && cmd <= SIOCDEVPRIVATE + 0xf) {
-		error = siocprivate(fd, cmd, arg);
-		goto out;
-	}
-
-	t = (struct ioctl_trans *)(long)ioctl32_hash_table [ioctl32_hash (cmd)];
-
-	while (t && t->cmd != cmd)
-		t = (struct ioctl_trans *)(long)t->next;
-	if (t) {
-		handler = (void *) pafnptr;
-		pafnptr[0] = pafnptr[1] = 0UL;
-		pafnptr[2] = (unsigned long) t->handler;
-		pafnptr[3] = A(&__gp);
-		error = handler(fd, cmd, arg, filp);
-	} else {
-		static int count = 0;
-		if (++count <= 20)
-			printk(KERN_WARNING
-				"sys32_ioctl: Unknown cmd fd(%d) "
-				"cmd(%08x) arg(%08x)\n",
-				(int)fd, (unsigned int)cmd, (unsigned int)arg);
-		error = -EINVAL;
-	}
-out:
-	fput(filp);
-out2:
-	return error;
-}
Index: linux-quilt/arch/parisc/kernel/syscall.S
--- .pc/ioc/arch/parisc/kernel/syscall.S	2003-03-18 18:34:09.000000000 +0100
+++ arch/parisc/kernel/syscall.S	2003-03-18 17:26:18.000000000 +0100
@@ -407,8 +407,7 @@
 	ENTRY_SAME(umount)
 	/* struct sockaddr... */
 	ENTRY_SAME(getpeername)
-	/* This one's a huge ugly mess */
-	ENTRY_DIFF(ioctl)
+	ENTRY_COMP(ioctl)
 	ENTRY_COMP(fcntl)		/* 55 */
 	ENTRY_SAME(socketpair)
 	ENTRY_SAME(setpgid)
Index: linux-quilt/arch/ppc64/kernel/ioctl32.c
--- .pc/ioc/arch/ppc64/kernel/ioctl32.c	2003-03-18 18:34:09.000000000 +0100
+++ arch/ppc64/kernel/ioctl32.c	2003-03-16 18:51:04.000000000 +0100
@@ -4474,129 +4474,3 @@
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset),
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64),
 };
-
-unsigned long ioctl32_hash_table[1024];
-
-static inline unsigned long ioctl32_hash(unsigned long cmd)
-{
-	return ((cmd >> 6) ^ (cmd >> 4) ^ cmd) & 0x3ff;
-}
-
-static void ioctl32_insert_translation(struct ioctl_trans *trans)
-{
-	unsigned long hash;
-	struct ioctl_trans *t;
-
-	hash = ioctl32_hash (trans->cmd);
-	if (!ioctl32_hash_table[hash])
-		ioctl32_hash_table[hash] = (long)trans;
-	else {
-		t = (struct ioctl_trans *)ioctl32_hash_table[hash];
-		while (t->next)
-			t = (struct ioctl_trans *)(long)t->next;
-		trans->next = 0;
-		t->next = (long)trans;
-	}
-}
-
-static int __init init_sys32_ioctl(void)
-{
-        int i, size = sizeof(ioctl_translations) / sizeof(struct ioctl_trans);
-        for (i=0; i < size ;i++)
-                ioctl32_insert_translation(&ioctl_translations[i]);
-	return 0;
-}
-
-__initcall(init_sys32_ioctl);
-
-static struct ioctl_trans *additional_ioctls;
-
-/* Always call these with kernel lock held! */
-
-int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
-{
-	int i;
-	if (!additional_ioctls) {
-		additional_ioctls = (struct ioctl_trans *)get_zeroed_page(GFP_KERNEL);
-		if (!additional_ioctls)
-			return -ENOMEM;
-	}
-	for (i = 0; i < PAGE_SIZE/sizeof(struct ioctl_trans); i++) {
-		if (!additional_ioctls[i].cmd)
-			break;
-		if (additional_ioctls[i].cmd == cmd)
-			printk("duplicate ioctl found: %x\n", cmd);
-	}
-	if (i == PAGE_SIZE/sizeof(struct ioctl_trans))
-		return -ENOMEM;
-	additional_ioctls[i].cmd = cmd;
-	if (!handler)
-		additional_ioctls[i].handler = (long)sys_ioctl;
-	else
-		additional_ioctls[i].handler = (long)handler;
-	ioctl32_insert_translation(&additional_ioctls[i]);
-	return 0;
-}
-
-int unregister_ioctl32_conversion(unsigned int cmd)
-{
-	unsigned long hash = ioctl32_hash(cmd);
-	struct ioctl_trans *t, *t1;
-
-	t = (struct ioctl_trans *)ioctl32_hash_table[hash];
-	if (!t) return -EINVAL;
-	if (t->cmd == cmd && t >= additional_ioctls &&
-	    (unsigned long)t < ((unsigned long)additional_ioctls) + PAGE_SIZE) {
-		ioctl32_hash_table[hash] = t->next;
-		t->cmd = 0;
-		return 0;
-	} else while (t->next) {
-		t1 = (struct ioctl_trans *)t->next;
-		if (t1->cmd == cmd && t1 >= additional_ioctls &&
-		    (unsigned long)t1 < ((unsigned long)additional_ioctls) + PAGE_SIZE) {
-			t1->cmd = 0;
-			t->next = t1->next;
-			return 0;
-		}
-		t = t1;
-	}
-	return -EINVAL;
-}
-
-asmlinkage int sys32_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct file * filp;
-	int error = -EBADF;
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
-	struct ioctl_trans *t;
-
-	filp = fget(fd);
-	if (!filp)
-		goto out2;
-
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
-		goto out;
-	}
-
-	t = (struct ioctl_trans *)ioctl32_hash_table [ioctl32_hash (cmd)];
-
-	while (t && t->cmd != cmd)
-		t = (struct ioctl_trans *)t->next;
-	if (t) {
-		handler = (void *)t->handler;
-		error = handler(fd, cmd, arg, filp);
-	} else {
-		static int count = 0;
-		if (++count <= 20)
-			printk("sys32_ioctl(%s:%d): Unknown cmd fd(%d) "
-			       "cmd(%08x) arg(%08x)\n",
-			       current->comm, current->pid,
-			       (int)fd, (unsigned int)cmd, (unsigned int)arg);
-		error = -EINVAL;
-	}
-out:
-	fput(filp);
-out2:
-	return error;
-}
Index: linux-quilt/arch/ppc64/kernel/misc.S
--- .pc/ioc/arch/ppc64/kernel/misc.S	2003-03-18 18:34:09.000000000 +0100
+++ arch/ppc64/kernel/misc.S	2003-03-18 17:26:33.000000000 +0100
@@ -556,8 +556,8 @@
 	.llong .sys_acct
 	.llong .sys32_umount
 	.llong .sys_ni_syscall		/* old lock syscall */
-	.llong .sys32_ioctl
-	.llong .compat_sys_fcntl	/* 55 */
+	.llong .compat_sys_ioctl
+	.llong .compat_sys_fcntl		/* 55 */
 	.llong .sys_ni_syscall		/* old mpx syscall */
 	.llong .sys32_setpgid
 	.llong .sys_ni_syscall		/* old ulimit syscall */
Index: linux-quilt/arch/s390x/kernel/ioctl32.c
--- .pc/ioc/arch/s390x/kernel/ioctl32.c	2003-03-18 18:34:09.000000000 +0100
+++ arch/s390x/kernel/ioctl32.c	2003-03-16 18:51:04.000000000 +0100
@@ -971,113 +971,3 @@
 
 #define NR_IOCTL32_HANDLERS	(sizeof(ioctl32_handler_table) /	\
 				 sizeof(ioctl32_handler_table[0]))
-
-static struct ioctl32_list *ioctl32_hash_table[1024];
-
-static inline int ioctl32_hash(unsigned int cmd)
-{
-	return ((cmd >> 6) ^ (cmd >> 4) ^ cmd) & 0x3ff;
-}
-
-int sys32_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
-	struct file *filp;
-	struct ioctl32_list *l;
-	int error;
-
-	l = ioctl32_hash_table[ioctl32_hash(cmd)];
-
-	error = -EBADF;
-
-	filp = fget(fd);
-	if (!filp)
-		return error;
-
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
-		goto out;
-	}
-
-	while (l && l->handler.cmd != cmd)
-		l = l->next;
-
-	if (l) {
-		handler = (void *)l->handler.function;
-		error = handler(fd, cmd, arg, filp);
-	} else {
-		error = -EINVAL;
-		printk("unknown ioctl: %08x\n", cmd);
-	}
-out:
-	fput(filp);
-	return error;
-}
-
-static void ioctl32_insert(struct ioctl32_list *entry)
-{
-	int hash = ioctl32_hash(entry->handler.cmd);
-
-	entry->next = 0;
-	if (!ioctl32_hash_table[hash])
-		ioctl32_hash_table[hash] = entry;
-	else {
-		struct ioctl32_list *l;
-		l = ioctl32_hash_table[hash];
-		while (l->next)
-			l = l->next;
-		l->next = entry;
-	}
-}
-
-int register_ioctl32_conversion(unsigned int cmd,
-				int (*handler)(unsigned int, unsigned int,
-					       unsigned long, struct file *))
-{
-	struct ioctl32_list *l, *new;
-	int hash;
-
-	hash = ioctl32_hash(cmd);
-	for (l = ioctl32_hash_table[hash]; l != NULL; l = l->next)
-		if (l->handler.cmd == cmd)
-			return -EBUSY;
-	new = kmalloc(sizeof(struct ioctl32_list), GFP_KERNEL);
-	if (new == NULL)
-		return -ENOMEM;
-	new->handler.cmd = cmd;
-	new->handler.function = (void *) handler;
-	ioctl32_insert(new);
-	return 0;
-}
-
-int unregister_ioctl32_conversion(unsigned int cmd)
-{
-	struct ioctl32_list *p, *l;
-	int hash;
-
-	hash = ioctl32_hash(cmd);
-	p = NULL;
-	for (l = ioctl32_hash_table[hash]; l != NULL; l = l->next) {
-		if (l->handler.cmd == cmd)
-			break;
-		p = l;
-	}
-	if (l == NULL)
-		return -ENOENT;
-	if (p == NULL)
-		ioctl32_hash_table[hash] = l->next;
-	else
-		p->next = l->next;
-	kfree(l);
-	return 0;
-}
-
-static int __init init_ioctl32(void)
-{
-	int i;
-	for (i = 0; i < NR_IOCTL32_HANDLERS; i++)
-		ioctl32_insert(&ioctl32_handler_table[i]);
-	return 0;
-}
-
-__initcall(init_ioctl32);
Index: linux-quilt/arch/s390x/kernel/wrapper32.S
--- .pc/ioc/arch/s390x/kernel/wrapper32.S	2003-03-18 18:34:09.000000000 +0100
+++ arch/s390x/kernel/wrapper32.S	2003-03-18 17:22:24.000000000 +0100
@@ -225,7 +225,7 @@
 	llgfr	%r2,%r2			# unsigned int
 	llgfr	%r3,%r3			# unsigned int
 	llgfr	%r4,%r4			# unsigned int
-	jg	sys32_ioctl		# branch to system call
+	jg	compat_sys_ioctl		# branch to system call
 
 	.globl  compat_sys_fcntl_wrapper 
 compat_sys_fcntl_wrapper:
Index: linux-quilt/arch/sparc64/kernel/ioctl32.c
--- .pc/ioc/arch/sparc64/kernel/ioctl32.c	2003-03-18 18:34:09.000000000 +0100
+++ arch/sparc64/kernel/ioctl32.c	2003-03-18 17:22:25.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/compat.h>
+#include <linux/ioctl32.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -679,7 +680,7 @@
 	return (void *) (usp - len);
 }
 
-static int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct ifreq *u_ifreq64;
 	struct ifreq32 *u_ifreq32 = (struct ifreq32 *) arg;
@@ -4275,16 +4276,14 @@
 #define BNEPGETCONNLIST	_IOR('B', 210, int)
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
 
-struct ioctl_trans {
-	unsigned int cmd;
-	unsigned int handler;
-	unsigned int next;
-};
+typedef int (* ioctl32_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
 
-#define COMPATIBLE_IOCTL(cmd) asm volatile(".word %0, sys_ioctl, 0" : : "i" (cmd));
-#define HANDLE_IOCTL(cmd,handler) asm volatile(".word %0, %1, 0" : : "i" (cmd), "i" (handler));
-#define IOCTL_TABLE_START void ioctl32_foo(void) { asm volatile(".data\nioctl_translations:");
-#define IOCTL_TABLE_END asm volatile("\nioctl_translations_end:\n\t.previous"); }
+#define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
+#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl32_handler_t)(handler), NULL },
+#define IOCTL_TABLE_START \
+	struct ioctl_trans ioctl_start[] = {
+#define IOCTL_TABLE_END \
+	}; struct ioctl_trans ioctl_end[0];
 
 IOCTL_TABLE_START
 /* List here exlicitly which ioctl's are known to have
@@ -5220,134 +5219,3 @@
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
 HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
 IOCTL_TABLE_END
-
-unsigned int ioctl32_hash_table[1024];
-
-static inline unsigned long ioctl32_hash(unsigned long cmd)
-{
-	return ((cmd >> 6) ^ (cmd >> 4) ^ cmd) & 0x3ff;
-}
-
-static void ioctl32_insert_translation(struct ioctl_trans *trans)
-{
-	unsigned long hash;
-	struct ioctl_trans *t;
-
-	hash = ioctl32_hash (trans->cmd);
-	if (!ioctl32_hash_table[hash])
-		ioctl32_hash_table[hash] = (u32)(long)trans;
-	else {
-		t = (struct ioctl_trans *)(long)ioctl32_hash_table[hash];
-		while (t->next)
-			t = (struct ioctl_trans *)(long)t->next;
-		trans->next = 0;
-		t->next = (u32)(long)trans;
-	}
-}
-
-static int __init init_sys32_ioctl(void)
-{
-	int i;
-	extern struct ioctl_trans ioctl_translations[], ioctl_translations_end[];
-
-	for (i = 0; &ioctl_translations[i] < &ioctl_translations_end[0]; i++)
-		ioctl32_insert_translation(&ioctl_translations[i]);
-	return 0;
-}
-
-__initcall(init_sys32_ioctl);
-
-static struct ioctl_trans *additional_ioctls;
-
-/* Always call these with kernel lock held! */
-
-int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
-{
-	int i;
-	if (!additional_ioctls) {
-		additional_ioctls = vmalloc(PAGE_SIZE);
-		if (!additional_ioctls)
-			return -ENOMEM;
-		memset(additional_ioctls, 0, PAGE_SIZE);
-	}
-	for (i = 0; i < PAGE_SIZE/sizeof(struct ioctl_trans); i++)
-		if (!additional_ioctls[i].cmd)
-			break;
-	if (i == PAGE_SIZE/sizeof(struct ioctl_trans))
-		return -ENOMEM;
-	additional_ioctls[i].cmd = cmd;
-	if (!handler)
-		additional_ioctls[i].handler = (u32)(long)sys_ioctl;
-	else
-		additional_ioctls[i].handler = (u32)(long)handler;
-	ioctl32_insert_translation(&additional_ioctls[i]);
-	return 0;
-}
-
-int unregister_ioctl32_conversion(unsigned int cmd)
-{
-	unsigned long hash = ioctl32_hash(cmd);
-	struct ioctl_trans *t, *t1;
-
-	t = (struct ioctl_trans *)(long)ioctl32_hash_table[hash];
-	if (!t) return -EINVAL;
-	if (t->cmd == cmd && t >= additional_ioctls &&
-	    (unsigned long)t < ((unsigned long)additional_ioctls) + PAGE_SIZE) {
-		ioctl32_hash_table[hash] = t->next;
-		t->cmd = 0;
-		t->next = 0;
-		return 0;
-	} else while (t->next) {
-		t1 = (struct ioctl_trans *)(long)t->next;
-		if (t1->cmd == cmd && t1 >= additional_ioctls &&
-		    (unsigned long)t1 < ((unsigned long)additional_ioctls) + PAGE_SIZE) {
-			t->next = t1->next;
-			t1->cmd = 0;
-			t1->next = 0;
-			return 0;
-		}
-		t = t1;
-	}
-	return -EINVAL;
-}
-
-asmlinkage int sys32_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct file * filp;
-	int error = -EBADF;
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
-	struct ioctl_trans *t;
-
-	filp = fget(fd);
-	if(!filp)
-		goto out2;
-
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
-		goto out;
-	}
-
-	t = (struct ioctl_trans *)(long)ioctl32_hash_table [ioctl32_hash (cmd)];
-
-	while (t && t->cmd != cmd)
-		t = (struct ioctl_trans *)(long)t->next;
-	if (t) {
-		handler = (void *)(long)t->handler;
-		error = handler(fd, cmd, arg, filp);
-	} else if (cmd >= SIOCDEVPRIVATE &&
-		   cmd <= (SIOCDEVPRIVATE + 15)) {
-		error = siocdevprivate_ioctl(fd, cmd, arg);
-	} else {
-		static int count;
-		if (++count <= 20)
-			printk("sys32_ioctl(%s:%d): Unknown cmd fd(%d) "
-			       "cmd(%08x) arg(%08x)\n",
-			       current->comm, current->pid,
-			       (int)fd, (unsigned int)cmd, (unsigned int)arg);
-		error = -EINVAL;
-	}
-out:
-	fput(filp);
-out2:
-	return error;
-}
Index: linux-quilt/arch/sparc64/kernel/sparc64_ksyms.c
--- .pc/ioc/arch/sparc64/kernel/sparc64_ksyms.c	2003-03-18 18:34:09.000000000 +0100
+++ arch/sparc64/kernel/sparc64_ksyms.c	2003-03-18 17:22:25.000000000 +0100
@@ -90,7 +90,7 @@
 extern int svr4_getcontext(svr4_ucontext_t *uc, struct pt_regs *regs);
 extern int svr4_setcontext(svr4_ucontext_t *uc, struct pt_regs *regs);
 extern int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
-extern int sys32_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
+extern int compat_sys_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
 extern long sparc32_open(const char * filename, int flags, int mode);
 extern int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *));
@@ -325,7 +325,7 @@
 EXPORT_SYMBOL(svr4_setcontext);
 EXPORT_SYMBOL(prom_cpu_nodes);
 EXPORT_SYMBOL(sys_ioctl);
-EXPORT_SYMBOL(sys32_ioctl);
+EXPORT_SYMBOL(compat_sys_ioctl);
 EXPORT_SYMBOL(sparc32_open);
 #endif
 
Index: linux-quilt/arch/sparc64/kernel/sunos_ioctl32.c
--- .pc/ioc/arch/sparc64/kernel/sunos_ioctl32.c	2003-03-18 18:34:09.000000000 +0100
+++ arch/sparc64/kernel/sunos_ioctl32.c	2003-03-16 18:51:04.000000000 +0100
@@ -92,7 +92,7 @@
 
 extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
-extern asmlinkage int sys32_ioctl(unsigned int, unsigned int, u32);
+extern asmlinkage int compat_sys_ioctl(unsigned int, unsigned int, u32);
 extern asmlinkage int sys_setsid(void);
 
 asmlinkage int sunos_ioctl (int fd, u32 cmd, u32 arg)
@@ -127,39 +127,39 @@
 	}
 	switch(cmd) {
 	case _IOW('r', 10, struct rtentry32):
-		ret = sys32_ioctl(fd, SIOCADDRT, arg);
+		ret = compat_sys_ioctl(fd, SIOCADDRT, arg);
 		goto out;
 	case _IOW('r', 11, struct rtentry32):
-		ret = sys32_ioctl(fd, SIOCDELRT, arg);
+		ret = compat_sys_ioctl(fd, SIOCDELRT, arg);
 		goto out;
 
 	case _IOW('i', 12, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFADDR, arg);
+		ret = compat_sys_ioctl(fd, SIOCSIFADDR, arg);
 		goto out;
 	case _IOWR('i', 13, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFADDR, arg);
+		ret = compat_sys_ioctl(fd, SIOCGIFADDR, arg);
 		goto out;
 	case _IOW('i', 14, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFDSTADDR, arg);
+		ret = compat_sys_ioctl(fd, SIOCSIFDSTADDR, arg);
 		goto out;
 	case _IOWR('i', 15, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFDSTADDR, arg);
+		ret = compat_sys_ioctl(fd, SIOCGIFDSTADDR, arg);
 		goto out;
 	case _IOW('i', 16, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFFLAGS, arg);
+		ret = compat_sys_ioctl(fd, SIOCSIFFLAGS, arg);
 		goto out;
 	case _IOWR('i', 17, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFFLAGS, arg);
+		ret = compat_sys_ioctl(fd, SIOCGIFFLAGS, arg);
 		goto out;
 	case _IOW('i', 18, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFMEM, arg);
+		ret = compat_sys_ioctl(fd, SIOCSIFMEM, arg);
 		goto out;
 	case _IOWR('i', 19, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFMEM, arg);
+		ret = compat_sys_ioctl(fd, SIOCGIFMEM, arg);
 		goto out;
 
 	case _IOWR('i', 20, struct ifconf32):
-		ret = sys32_ioctl(fd, SIOCGIFCONF, arg);
+		ret = compat_sys_ioctl(fd, SIOCGIFCONF, arg);
 		goto out;
 
 	case _IOW('i', 21, struct ifreq): /* SIOCSIFMTU */
@@ -170,32 +170,32 @@
 		goto out;
 
 	case _IOWR('i', 23, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFBRDADDR, arg);
+		ret = compat_sys_ioctl(fd, SIOCGIFBRDADDR, arg);
 		goto out;
 	case _IOW('i', 24, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFBRDADDR, arg);
+		ret = compat_sys_ioctl(fd, SIOCSIFBRDADDR, arg);
 		goto out;
 	case _IOWR('i', 25, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFNETMASK, arg);
+		ret = compat_sys_ioctl(fd, SIOCGIFNETMASK, arg);
 		goto out;
 	case _IOW('i', 26, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFNETMASK, arg);
+		ret = compat_sys_ioctl(fd, SIOCSIFNETMASK, arg);
 		goto out;
 	case _IOWR('i', 27, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCGIFMETRIC, arg);
+		ret = compat_sys_ioctl(fd, SIOCGIFMETRIC, arg);
 		goto out;
 	case _IOW('i', 28, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCSIFMETRIC, arg);
+		ret = compat_sys_ioctl(fd, SIOCSIFMETRIC, arg);
 		goto out;
 
 	case _IOW('i', 30, struct arpreq):
-		ret = sys32_ioctl(fd, SIOCSARP, arg);
+		ret = compat_sys_ioctl(fd, SIOCSARP, arg);
 		goto out;
 	case _IOWR('i', 31, struct arpreq):
-		ret = sys32_ioctl(fd, SIOCGARP, arg);
+		ret = compat_sys_ioctl(fd, SIOCGARP, arg);
 		goto out;
 	case _IOW('i', 32, struct arpreq):
-		ret = sys32_ioctl(fd, SIOCDARP, arg);
+		ret = compat_sys_ioctl(fd, SIOCDARP, arg);
 		goto out;
 
 	case _IOW('i', 40, struct ifreq32): /* SIOCUPPER */
@@ -209,10 +209,10 @@
 		goto out;
 
 	case _IOW('i', 49, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCADDMULTI, arg);
+		ret = compat_sys_ioctl(fd, SIOCADDMULTI, arg);
 		goto out;
 	case _IOW('i', 50, struct ifreq32):
-		ret = sys32_ioctl(fd, SIOCDELMULTI, arg);
+		ret = compat_sys_ioctl(fd, SIOCDELMULTI, arg);
 		goto out;
 
 	/* FDDI interface ioctls, unsupported. */
@@ -246,7 +246,7 @@
 		ret = -EFAULT;
 		if(get_user(oldval, ptr))
 			goto out;
-		ret = sys32_ioctl(fd, cmd, arg);
+		ret = compat_sys_ioctl(fd, cmd, arg);
 		__get_user(newval, ptr);
 		if(newval == -1) {
 			__put_user(oldval, ptr);
@@ -265,7 +265,7 @@
 		ret = -EFAULT;
 		if(get_user(oldval, ptr))
 			goto out;
-		ret = sys32_ioctl(fd, cmd, arg);
+		ret = compat_sys_ioctl(fd, cmd, arg);
 		__get_user(newval, ptr);
 		if(newval == -1) {
 			__put_user(oldval, ptr);
@@ -277,7 +277,7 @@
 	}
 	};
 
-	ret = sys32_ioctl(fd, cmd, arg);
+	ret = compat_sys_ioctl(fd, cmd, arg);
 	/* so stupid... */
 	ret = (ret == -EINVAL ? -EOPNOTSUPP : ret);
 out:
Index: linux-quilt/arch/sparc64/kernel/systbls.S
--- .pc/ioc/arch/sparc64/kernel/systbls.S	2003-03-18 18:34:09.000000000 +0100
+++ arch/sparc64/kernel/systbls.S	2003-03-18 17:22:25.000000000 +0100
@@ -29,7 +29,7 @@
 	.word sys_chown, sys_sync, sys_kill, compat_sys_newstat, sys32_sendfile
 /*40*/	.word compat_sys_newlstat, sys_dup, sys_pipe, compat_sys_times, sys_getuid
 	.word sys_umount, sys32_setgid16, sys32_getgid16, sys_signal, sys32_geteuid16
-/*50*/	.word sys32_getegid16, sys_acct, sys_nis_syscall, sys_getgid, sys32_ioctl
+/*50*/	.word sys32_getegid16, sys_acct, sys_nis_syscall, sys_getgid, compat_sys_ioctl
 	.word sys_reboot, sys32_mmap2, sys_symlink, sys_readlink, sys32_execve
 /*60*/	.word sys_umask, sys_chroot, compat_sys_newfstat, sys_fstat64, sys_getpagesize
 	.word sys_msync, sys_vfork, sys32_pread64, sys32_pwrite64, sys_geteuid
Index: linux-quilt/arch/sparc64/solaris/ioctl.c
--- .pc/ioc/arch/sparc64/solaris/ioctl.c	2003-03-18 18:34:10.000000000 +0100
+++ arch/sparc64/solaris/ioctl.c	2003-03-16 18:51:04.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/netdevice.h>
 #include <linux/mtio.h>
 #include <linux/time.h>
+#include <linux/compat.h>
 
 #include <net/sock.h>
 
@@ -35,7 +36,7 @@
 
 extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, 
 	unsigned long arg);
-extern asmlinkage int sys32_ioctl(unsigned int fd, unsigned int cmd,
+extern asmlinkage int compat_sys_ioctl(unsigned int fd, unsigned int cmd,
 	u32 arg);
 asmlinkage int solaris_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 
@@ -597,9 +598,9 @@
 {
 	switch (cmd & 0xff) {
 	case 10: /* SIOCADDRT */
-		return sys32_ioctl(fd, SIOCADDRT, arg);
+		return compat_sys_ioctl(fd, SIOCADDRT, arg);
 	case 11: /* SIOCDELRT */
-		return sys32_ioctl(fd, SIOCDELRT, arg);
+		return compat_sys_ioctl(fd, SIOCDELRT, arg);
 	}
 	return -ENOSYS;
 }
@@ -608,45 +609,45 @@
 {
 	switch (cmd & 0xff) {
 	case 12: /* SIOCSIFADDR */
-		return sys32_ioctl(fd, SIOCSIFADDR, arg);
+		return compat_sys_ioctl(fd, SIOCSIFADDR, arg);
 	case 13: /* SIOCGIFADDR */
-		return sys32_ioctl(fd, SIOCGIFADDR, arg);
+		return compat_sys_ioctl(fd, SIOCGIFADDR, arg);
 	case 14: /* SIOCSIFDSTADDR */
-		return sys32_ioctl(fd, SIOCSIFDSTADDR, arg);
+		return compat_sys_ioctl(fd, SIOCSIFDSTADDR, arg);
 	case 15: /* SIOCGIFDSTADDR */
-		return sys32_ioctl(fd, SIOCGIFDSTADDR, arg);
+		return compat_sys_ioctl(fd, SIOCGIFDSTADDR, arg);
 	case 16: /* SIOCSIFFLAGS */
-		return sys32_ioctl(fd, SIOCSIFFLAGS, arg);
+		return compat_sys_ioctl(fd, SIOCSIFFLAGS, arg);
 	case 17: /* SIOCGIFFLAGS */
-		return sys32_ioctl(fd, SIOCGIFFLAGS, arg);
+		return compat_sys_ioctl(fd, SIOCGIFFLAGS, arg);
 	case 18: /* SIOCSIFMEM */
-		return sys32_ioctl(fd, SIOCSIFMEM, arg);
+		return compat_sys_ioctl(fd, SIOCSIFMEM, arg);
 	case 19: /* SIOCGIFMEM */
-		return sys32_ioctl(fd, SIOCGIFMEM, arg);
+		return compat_sys_ioctl(fd, SIOCGIFMEM, arg);
 	case 20: /* SIOCGIFCONF */
-		return sys32_ioctl(fd, SIOCGIFCONF, arg);
+		return compat_sys_ioctl(fd, SIOCGIFCONF, arg);
 	case 21: /* SIOCSIFMTU */
-		return sys32_ioctl(fd, SIOCSIFMTU, arg);
+		return compat_sys_ioctl(fd, SIOCSIFMTU, arg);
 	case 22: /* SIOCGIFMTU */
-		return sys32_ioctl(fd, SIOCGIFMTU, arg);
+		return compat_sys_ioctl(fd, SIOCGIFMTU, arg);
 	case 23: /* SIOCGIFBRDADDR */
-		return sys32_ioctl(fd, SIOCGIFBRDADDR, arg);
+		return compat_sys_ioctl(fd, SIOCGIFBRDADDR, arg);
 	case 24: /* SIOCSIFBRDADDR */
-		return sys32_ioctl(fd, SIOCSIFBRDADDR, arg);
+		return compat_sys_ioctl(fd, SIOCSIFBRDADDR, arg);
 	case 25: /* SIOCGIFNETMASK */
-		return sys32_ioctl(fd, SIOCGIFNETMASK, arg);
+		return compat_sys_ioctl(fd, SIOCGIFNETMASK, arg);
 	case 26: /* SIOCSIFNETMASK */
-		return sys32_ioctl(fd, SIOCSIFNETMASK, arg);
+		return compat_sys_ioctl(fd, SIOCSIFNETMASK, arg);
 	case 27: /* SIOCGIFMETRIC */
-		return sys32_ioctl(fd, SIOCGIFMETRIC, arg);
+		return compat_sys_ioctl(fd, SIOCGIFMETRIC, arg);
 	case 28: /* SIOCSIFMETRIC */
-		return sys32_ioctl(fd, SIOCSIFMETRIC, arg);
+		return compat_sys_ioctl(fd, SIOCSIFMETRIC, arg);
 	case 30: /* SIOCSARP */
-		return sys32_ioctl(fd, SIOCSARP, arg);
+		return compat_sys_ioctl(fd, SIOCSARP, arg);
 	case 31: /* SIOCGARP */
-		return sys32_ioctl(fd, SIOCGARP, arg);
+		return compat_sys_ioctl(fd, SIOCGARP, arg);
 	case 32: /* SIOCDARP */
-		return sys32_ioctl(fd, SIOCDARP, arg);
+		return compat_sys_ioctl(fd, SIOCDARP, arg);
 	case 52: /* SIOCGETNAME */
 	case 53: /* SIOCGETPEER */
 		{
Index: linux-quilt/arch/sparc64/solaris/timod.c
--- .pc/ioc/arch/sparc64/solaris/timod.c	2003-03-18 18:34:10.000000000 +0100
+++ arch/sparc64/solaris/timod.c	2003-03-16 18:51:04.000000000 +0100
@@ -29,8 +29,6 @@
 
 extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, 
 	unsigned long arg);
-extern asmlinkage int sys32_ioctl(unsigned int fd, unsigned int cmd,
-	u32 arg);
 asmlinkage int solaris_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 
 static spinlock_t timod_pagelock = SPIN_LOCK_UNLOCKED;
Index: linux-quilt/arch/x86_64/ia32/ia32_ioctl.c
--- .pc/ioc/arch/x86_64/ia32/ia32_ioctl.c	2003-03-18 18:34:10.000000000 +0100
+++ arch/x86_64/ia32/ia32_ioctl.c	2003-03-16 18:51:04.000000000 +0100
@@ -680,7 +680,7 @@
 	return (void *)regs->rsp - len; 
 }
 
-static int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct ifreq *u_ifreq64;
 	struct ifreq32 *u_ifreq32 = (struct ifreq32 *) arg;
@@ -3578,18 +3578,12 @@
 	return err;
 } 
 
-struct ioctl_trans {
-	unsigned long cmd;
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
-	struct ioctl_trans *next;
-};
-
 #define REF_SYMBOL(handler) if (0) (void)handler;
 #define HANDLE_IOCTL2(cmd,handler) REF_SYMBOL(handler);  asm volatile(".quad %c0, " #handler ",0"::"i" (cmd)); 
 #define HANDLE_IOCTL(cmd,handler) HANDLE_IOCTL2(cmd,handler)
 #define COMPATIBLE_IOCTL(cmd) HANDLE_IOCTL(cmd,sys_ioctl)
-#define IOCTL_TABLE_START void ioctl_dummy(void) { asm volatile("\nioctl_start:\n\t" );
-#define IOCTL_TABLE_END  asm volatile("\nioctl_end:"); }
+#define IOCTL_TABLE_START void ioctl_dummy(void) { asm volatile("\n.global ioctl_start\nioctl_start:\n\t" );
+#define IOCTL_TABLE_END  asm volatile("\n.global ioctl_end;\nioctl_end:\n"); }
 
 IOCTL_TABLE_START
 /* List here explicitly which ioctl's are known to have
@@ -4432,217 +4426,3 @@
 HANDLE_IOCTL(MTRRIOC32_KILL_PAGE_ENTRY, mtrr_ioctl32)
 IOCTL_TABLE_END
 
-#define IOCTL_HASHSIZE 256
-struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
-
-extern struct ioctl_trans ioctl_start[], ioctl_end[]; 
-
-extern struct ioctl_trans ioctl_start[], ioctl_end[]; 
-
-static inline unsigned long ioctl32_hash(unsigned long cmd)
-{
-	return (((cmd >> 6) ^ (cmd >> 4) ^ cmd)) % IOCTL_HASHSIZE;
-}
-
-static void ioctl32_insert_translation(struct ioctl_trans *trans)
-{
-	unsigned long hash;
-	struct ioctl_trans *t;
-
-	hash = ioctl32_hash (trans->cmd);
-	if (!ioctl32_hash_table[hash])
-		ioctl32_hash_table[hash] = trans;
-	else {
-		t = ioctl32_hash_table[hash];
-		while (t->next)
-			t = t->next;
-		trans->next = 0;
-		t->next = trans;
-	}
-}
-
-static int __init init_sys32_ioctl(void)
-{
-	int i;
-
-	for (i = 0; &ioctl_start[i] < &ioctl_end[0]; i++) {
-		if (ioctl_start[i].next != 0) { 
-			printk("ioctl translation %d bad\n",i); 
-			return -1;
-		}
-
-		ioctl32_insert_translation(&ioctl_start[i]);
-	}
-	return 0;
-}
-
-__initcall(init_sys32_ioctl);
-
-static struct ioctl_trans *ioctl_free_list;
-
-/* Never free them really. This avoids SMP races. With a Read-Copy-Update
-   enabled kernel we could just use the RCU infrastructure for this. */
-static void free_ioctl(struct ioctl_trans *t) 
-{ 
-	t->cmd = 0; 
-	mb();
-	t->next = ioctl_free_list;
-	ioctl_free_list = t;
-} 
-
-int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
-{
-	struct ioctl_trans *t;
-	unsigned long hash = ioctl32_hash(cmd);
-
-	lock_kernel(); 
-	for (t = (struct ioctl_trans *)ioctl32_hash_table[hash];
-	     t;
-	     t = t->next) { 
-		if (t->cmd == cmd) {
-			printk("Trying to register duplicated ioctl32 handler %x\n", cmd);
-			unlock_kernel();
-			return -EINVAL; 
-	}
-	} 
-
-	if (ioctl_free_list) { 
-		t = ioctl_free_list; 
-		ioctl_free_list = t->next; 
-	} else { 
-		t = kmalloc(sizeof(struct ioctl_trans), GFP_KERNEL); 
-		if (!t) { 
-			unlock_kernel();
-		return -ENOMEM;
-		}
-	}
-	
-	t->next = NULL;
-	t->cmd = cmd;
-	t->handler = handler; 
-	ioctl32_insert_translation(t);
-
-	unlock_kernel();
-	return 0;
-}
-
-static inline int builtin_ioctl(struct ioctl_trans *t)
-{ 
-	return t >= (struct ioctl_trans *)ioctl_start &&
-	       t < (struct ioctl_trans *)ioctl_end; 
-} 
-
-/* Problem: 
-   This function cannot unregister duplicate ioctls, because they are not
-   unique.
-   When they happen we need to extend the prototype to pass the handler too. */
-
-int unregister_ioctl32_conversion(unsigned int cmd)
-{
-	unsigned long hash = ioctl32_hash(cmd);
-	struct ioctl_trans *t, *t1;
-
-	lock_kernel(); 
-
-	t = (struct ioctl_trans *)ioctl32_hash_table[hash];
-	if (!t) { 
-		unlock_kernel();
-		return -EINVAL;
-	} 
-
-	if (t->cmd == cmd) { 
-		if (builtin_ioctl(t)) {
-			printk("%p tried to unregister builtin ioctl %x\n",
-			       __builtin_return_address(0), cmd);
-		} else { 
-		ioctl32_hash_table[hash] = t->next;
-			free_ioctl(t); 
-			unlock_kernel();
-		return 0;
-		}
-	} 
-	while (t->next) {
-		t1 = (struct ioctl_trans *)(long)t->next;
-		if (t1->cmd == cmd) { 
-			if (builtin_ioctl(t1)) {
-				printk("%p tried to unregister builtin ioctl %x\n",
-				       __builtin_return_address(0), cmd);
-				goto out;
-			} else { 
-			t->next = t1->next;
-				free_ioctl(t1); 
-				unlock_kernel();
-			return 0;
-		}
-		}
-		t = t1;
-	}
-	printk(KERN_ERR "Trying to free unknown 32bit ioctl handler %x\n", cmd);
- out:
-	unlock_kernel();
-	return -EINVAL;
-}
-
-EXPORT_SYMBOL(register_ioctl32_conversion); 
-EXPORT_SYMBOL(unregister_ioctl32_conversion); 
-
-asmlinkage long sys32_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct file * filp;
-	int error = -EBADF;
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
-	struct ioctl_trans *t;
-
-	filp = fget(fd);
-	if(!filp)
-		goto out2;
-
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
-		goto out;
-	}
-
-	t = (struct ioctl_trans *)ioctl32_hash_table [ioctl32_hash (cmd)];
-
-	while (t && t->cmd != cmd)
-		t = (struct ioctl_trans *)t->next;
-	if (t) {
-		handler = t->handler;
-		error = handler(fd, cmd, arg, filp);
-	} else if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
-		error = siocdevprivate_ioctl(fd, cmd, arg);
-	} else {
-		static int count;
-		if (++count <= 50) { 
-			char buf[10];
-			char *path = (char *)__get_free_page(GFP_KERNEL), *fn = "?"; 
-
-			/* find the name of the device. */
-			if (path) {
-				struct file *f = fget(fd); 
-				if (f) {
-					fn = d_path(f->f_dentry, f->f_vfsmnt, 
-						    path, PAGE_SIZE);
-					fput(f);
-				}
-			}
-
-			sprintf(buf,"'%c'", (cmd>>24) & 0x3f); 
-			if (!isprint(buf[1]))
-			    sprintf(buf, "%02x", buf[1]);
-			printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
-			       "cmd(%08x){%s} arg(%08x) on %s\n",
-			       current->comm, current->pid,
-			       (int)fd, (unsigned int)cmd, buf, (unsigned int)arg,
-			       fn);
-			if (path) 
-				free_page((unsigned long)path); 
-		}
-		error = -EINVAL;
-	}
-out:
-	fput(filp);
-out2:
-	return error;
-}
-
Index: linux-quilt/arch/x86_64/ia32/ia32entry.S
--- .pc/ioc/arch/x86_64/ia32/ia32entry.S	2003-03-18 18:34:10.000000000 +0100
+++ arch/x86_64/ia32/ia32entry.S	2003-03-18 17:27:43.000000000 +0100
@@ -254,7 +254,7 @@
 	.quad sys_acct
 	.quad sys_umount			/* new_umount */
 	.quad ni_syscall			/* old lock syscall holder */
-	.quad sys32_ioctl
+	.quad compat_sys_ioctl
 	.quad compat_sys_fcntl64		/* 55 */
 	.quad ni_syscall			/* old mpx syscall holder */
 	.quad sys_setpgid
Index: linux-quilt/fs/compat.c
--- .pc/ioc/fs/compat.c	2003-03-18 18:34:10.000000000 +0100
+++ fs/compat.c	2003-03-18 17:22:47.000000000 +0100
@@ -4,7 +4,11 @@
  *  Kernel compatibililty routines for e.g. 32 bit syscall support
  *  on 64 bit kernels.
  *
- *  Copyright (C) 2002 Stephen Rothwell, IBM Corporation
+ *  Copyright (C) 2002       Stephen Rothwell, IBM Corporation
+ *  Copyright (C) 1997-2000  Jakub Jelinek  (jakub@redhat.com)
+ *  Copyright (C) 1998       Eddie C. Dost  (ecd@skynet.be)
+ *  Copyright (C) 2001,2002  Andi Kleen, SuSE Labs 
+ *  Copyright (C) 2003       Pavel Machek (pavel@suse.cz)
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -20,6 +24,12 @@
 #include <linux/namei.h>
 #include <linux/file.h>
 #include <linux/vfs.h>
+#include <linux/ioctl32.h>
+#include <linux/init.h>
+#include <linux/sockios.h>	/* for SIOCDEVPRIVATE */
+#include <linux/fs.h>
+#include <linux/smp_lock.h>
+#include <linux/ctype.h>
 
 #include <asm/uaccess.h>
 
@@ -130,6 +140,217 @@
 	return error;
 }
 
+
+/* ioctl32 stuff, used by sparc64, parisc, s390x, ppc64, x86_64 */
+
+#define IOCTL_HASHSIZE 256
+struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
+
+extern struct ioctl_trans ioctl_start[], ioctl_end[]; 
+
+static inline unsigned long ioctl32_hash(unsigned long cmd)
+{
+	return (((cmd >> 6) ^ (cmd >> 4) ^ cmd)) % IOCTL_HASHSIZE;
+}
+
+static void ioctl32_insert_translation(struct ioctl_trans *trans)
+{
+	unsigned long hash;
+	struct ioctl_trans *t;
+
+	hash = ioctl32_hash (trans->cmd);
+	if (!ioctl32_hash_table[hash])
+		ioctl32_hash_table[hash] = trans;
+	else {
+		t = ioctl32_hash_table[hash];
+		while (t->next)
+			t = t->next;
+		trans->next = 0;
+		t->next = trans;
+	}
+}
+
+static int __init init_sys32_ioctl(void)
+{
+	int i;
+
+	for (i = 0; &ioctl_start[i] < &ioctl_end[0]; i++) {
+		if (ioctl_start[i].next != 0) { 
+			printk("ioctl translation %d bad\n",i); 
+			return -1;
+		}
+
+		ioctl32_insert_translation(&ioctl_start[i]);
+	}
+	return 0;
+}
+
+__initcall(init_sys32_ioctl);
+
+static struct ioctl_trans *ioctl_free_list;
+
+/* Never free them really. This avoids SMP races. With a Read-Copy-Update
+   enabled kernel we could just use the RCU infrastructure for this. */
+static void free_ioctl(struct ioctl_trans *t) 
+{ 
+	t->cmd = 0; 
+	mb();
+	t->next = ioctl_free_list;
+	ioctl_free_list = t;
+} 
+
+int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
+{
+	struct ioctl_trans *t;
+	unsigned long hash = ioctl32_hash(cmd);
+
+	lock_kernel(); 
+	for (t = (struct ioctl_trans *)ioctl32_hash_table[hash];
+	     t;
+	     t = t->next) { 
+		if (t->cmd == cmd) {
+			printk("Trying to register duplicated ioctl32 handler %x\n", cmd);
+			unlock_kernel();
+			return -EINVAL; 
+		}
+	} 
+
+	if (ioctl_free_list) { 
+		t = ioctl_free_list; 
+		ioctl_free_list = t->next; 
+	} else { 
+		t = kmalloc(sizeof(struct ioctl_trans), GFP_KERNEL); 
+		if (!t) { 
+			unlock_kernel();
+		return -ENOMEM;
+		}
+	}
+	
+	t->next = NULL;
+	t->cmd = cmd;
+	t->handler = handler; 
+	ioctl32_insert_translation(t);
+
+	unlock_kernel();
+	return 0;
+}
+
+static inline int builtin_ioctl(struct ioctl_trans *t)
+{ 
+	return t >= (struct ioctl_trans *)ioctl_start &&
+	       t < (struct ioctl_trans *)ioctl_end; 
+} 
+
+/* Problem: 
+   This function cannot unregister duplicate ioctls, because they are not
+   unique.
+   When they happen we need to extend the prototype to pass the handler too. */
+
+int unregister_ioctl32_conversion(unsigned int cmd)
+{
+	unsigned long hash = ioctl32_hash(cmd);
+	struct ioctl_trans *t, *t1;
+
+	lock_kernel(); 
+
+	t = (struct ioctl_trans *)ioctl32_hash_table[hash];
+	if (!t) { 
+		unlock_kernel();
+		return -EINVAL;
+	} 
+
+	if (t->cmd == cmd) { 
+		if (builtin_ioctl(t)) {
+			printk("%p tried to unregister builtin ioctl %x\n",
+			       __builtin_return_address(0), cmd);
+		} else { 
+		ioctl32_hash_table[hash] = t->next;
+			free_ioctl(t); 
+			unlock_kernel();
+		return 0;
+		}
+	} 
+	while (t->next) {
+		t1 = (struct ioctl_trans *)(long)t->next;
+		if (t1->cmd == cmd) { 
+			if (builtin_ioctl(t1)) {
+				printk("%p tried to unregister builtin ioctl %x\n",
+				       __builtin_return_address(0), cmd);
+				goto out;
+			} else { 
+			t->next = t1->next;
+				free_ioctl(t1); 
+				unlock_kernel();
+			return 0;
+			}
+		}
+		t = t1;
+	}
+	printk(KERN_ERR "Trying to free unknown 32bit ioctl handler %x\n", cmd);
+ out:
+	unlock_kernel();
+	return -EINVAL;
+}
+
+EXPORT_SYMBOL(register_ioctl32_conversion); 
+EXPORT_SYMBOL(unregister_ioctl32_conversion); 
+
+asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct file * filp;
+	int error = -EBADF;
+	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
+	struct ioctl_trans *t;
+
+	filp = fget(fd);
+	if(!filp)
+		goto out2;
+
+	if (!filp->f_op || !filp->f_op->ioctl) {
+		error = sys_ioctl (fd, cmd, arg);
+		goto out;
+	}
+
+	t = (struct ioctl_trans *)ioctl32_hash_table [ioctl32_hash (cmd)];
+
+	while (t && t->cmd != cmd)
+		t = (struct ioctl_trans *)t->next;
+	if (t) {
+		handler = t->handler;
+		error = handler(fd, cmd, arg, filp);
+	} else if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
+		error = siocdevprivate_ioctl(fd, cmd, arg);
+	} else {
+		static int count;
+		if (++count <= 50) { 
+			char buf[10];
+			char *path = (char *)__get_free_page(GFP_KERNEL), *fn = "?"; 
+
+			/* find the name of the device. */
+			if (path) {
+		       		fn = d_path(filp->f_dentry, filp->f_vfsmnt, 
+					    path, PAGE_SIZE);
+			}
+
+			sprintf(buf,"'%c'", (cmd>>24) & 0x3f); 
+			if (!isprint(buf[1]))
+			    sprintf(buf, "%02x", buf[1]);
+			printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
+			       "cmd(%08x){%s} arg(%08x) on %s\n",
+			       current->comm, current->pid,
+			       (int)fd, (unsigned int)cmd, buf, (unsigned int)arg,
+			       fn);
+			if (path) 
+				free_page((unsigned long)path); 
+		}
+		error = -EINVAL;
+	}
+out:
+	fput(filp);
+out2:
+	return error;
+}
+
 static int get_compat_flock(struct flock *kfl, struct compat_flock *ufl)
 {
 	if (!access_ok(VERIFY_READ, ufl, sizeof(*ufl)) ||
Index: linux-quilt/include/linux/ioctl32.h
--- .pc/ioc/include/linux/ioctl32.h	2003-03-18 18:34:10.000000000 +0100
+++ include/linux/ioctl32.h	2003-03-16 18:51:04.000000000 +0100
@@ -19,5 +19,10 @@
 
 extern int unregister_ioctl32_conversion(unsigned int cmd);
 
+struct ioctl_trans {
+	unsigned long cmd;
+	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
+	struct ioctl_trans *next;
+};
 
 #endif

%diffstat
 arch/ia64/ia32/ia32_entry.S         |    2 
 arch/ia64/ia32/ia32_ioctl.c         |  218 ----------------------------------
 arch/mips64/kernel/ioctl32.c        |   67 ----------
 arch/mips64/kernel/scall_o32.S      |    2 
 arch/parisc/kernel/ioctl32.c        |  143 ----------------------
 arch/parisc/kernel/syscall.S        |    3 
 arch/ppc64/kernel/ioctl32.c         |  126 --------------------
 arch/ppc64/kernel/misc.S            |    4 
 arch/s390x/kernel/ioctl32.c         |  110 -----------------
 arch/s390x/kernel/wrapper32.S       |    2 
 arch/sparc64/kernel/ioctl32.c       |  150 +----------------------
 arch/sparc64/kernel/sparc64_ksyms.c |    4 
 arch/sparc64/kernel/sunos_ioctl32.c |   52 ++++----
 arch/sparc64/kernel/systbls.S       |    2 
 arch/sparc64/solaris/ioctl.c        |   47 +++----
 arch/sparc64/solaris/timod.c        |    2 
 arch/x86_64/ia32/ia32_ioctl.c       |  226 ------------------------------------
 arch/x86_64/ia32/ia32entry.S        |    2 
 fs/compat.c                         |  223 +++++++++++++++++++++++++++++++++++
 include/linux/ioctl32.h             |    5 
 20 files changed, 299 insertions(+), 1091 deletions(-)



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
