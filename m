Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268866AbTCCXSl>; Mon, 3 Mar 2003 18:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbTCCXSk>; Mon, 3 Mar 2003 18:18:40 -0500
Received: from [195.39.17.254] ([195.39.17.254]:21764 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S268878AbTCCXRt>;
	Mon, 3 Mar 2003 18:17:49 -0500
Date: Tue, 4 Mar 2003 00:27:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: sys32_ioctl -> compat_ioctl -- other 64bit archs
Message-ID: <20030303232738.GA25886@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is rest of patches. These have not been tested, and probably
break something; but it was broken before: there were races around
ioctl callback registration. Hopefully this is good starting
point. Please apply,
							Pavel

--- clean/arch/ia64/ia32/ia32_entry.S	2003-03-03 23:32:35.000000000 +0100
+++ linux/arch/ia64/ia32/ia32_entry.S	2003-02-26 22:45:26.000000000 +0100
@@ -252,7 +252,7 @@
 	data8 sys_acct
 	data8 sys_umount	  /* recycled never used phys( */
 	data8 sys32_ni_syscall	  /* old lock syscall holder */
-	data8 sys32_ioctl
+	data8 compat_ioctl
 	data8 sys32_fcntl	  /* 55 */
 	data8 sys32_ni_syscall	  /* old mpx syscall holder */
 	data8 sys_setpgid
--- clean/arch/ia64/ia32/ia32_ioctl.c	2003-03-03 23:32:35.000000000 +0100
+++ linux/arch/ia64/ia32/ia32_ioctl.c	2003-02-26 22:46:32.000000000 +0100
@@ -295,221 +295,3 @@
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
--- clean/arch/mips64/kernel/ioctl32.c	2003-03-03 23:33:05.000000000 +0100
+++ linux/arch/mips64/kernel/ioctl32.c	2003-02-26 22:47:59.000000000 +0100
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
--- clean/arch/mips64/kernel/scall_o32.S	2003-03-03 23:33:05.000000000 +0100
+++ linux/arch/mips64/kernel/scall_o32.S	2003-02-26 22:47:14.000000000 +0100
@@ -287,7 +287,7 @@
 	sys	sys_acct	0
 	sys	sys_umount	2
 	sys	sys_ni_syscall	0
-	sys	sys32_ioctl	3
+	sys	compat_ioctl	3
 	sys	sys32_fcntl	3			/* 4055 */
 	sys	sys_ni_syscall	2
 	sys	sys_setpgid	2
--- clean/arch/parisc/kernel/ioctl32.c	2003-03-03 23:33:11.000000000 +0100
+++ linux/arch/parisc/kernel/ioctl32.c	2003-02-24 22:36:18.000000000 +0100
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
--- clean/arch/ppc64/kernel/ioctl32.c	2003-03-03 23:33:35.000000000 +0100
+++ linux/arch/ppc64/kernel/ioctl32.c	2003-02-28 15:33:48.000000000 +0100
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
--- clean/arch/ppc64/kernel/misc.S	2003-03-03 23:33:35.000000000 +0100
+++ linux/arch/ppc64/kernel/misc.S	2003-02-26 22:38:21.000000000 +0100
@@ -556,7 +556,7 @@
 	.llong .sys_acct
 	.llong .sys32_umount
 	.llong .sys_ni_syscall		/* old lock syscall */
-	.llong .sys32_ioctl
+	.llong .compat_ioctl
 	.llong .sys32_fcntl		/* 55 */
 	.llong .sys_ni_syscall		/* old mpx syscall */
 	.llong .sys32_setpgid
--- clean/arch/s390x/kernel/ioctl32.c	2003-03-03 23:33:39.000000000 +0100
+++ linux/arch/s390x/kernel/ioctl32.c	2003-02-20 10:48:20.000000000 +0100
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
--- clean/arch/s390x/kernel/wrapper32.S	2003-03-03 23:33:40.000000000 +0100
+++ linux/arch/s390x/kernel/wrapper32.S	2003-02-26 22:24:07.000000000 +0100
@@ -225,7 +225,7 @@
 	llgfr	%r2,%r2			# unsigned int
 	llgfr	%r3,%r3			# unsigned int
 	llgfr	%r4,%r4			# unsigned int
-	jg	sys32_ioctl		# branch to system call
+	jg	compat_ioctl		# branch to system call
 
 	.globl  sys32_fcntl_wrapper 
 sys32_fcntl_wrapper:

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
