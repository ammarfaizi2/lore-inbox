Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSL3GiR>; Mon, 30 Dec 2002 01:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSL3GiR>; Mon, 30 Dec 2002 01:38:17 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:9131 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266806AbSL3Ghu>;
	Mon, 30 Dec 2002 01:37:50 -0500
Date: Mon, 30 Dec 2002 17:46:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: willy@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs
 7/7  PARISC
Message-Id: <20021230174606.264f827d.sfr@canb.auug.org.au>
In-Reply-To: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
References: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

PARISC specific stuff ...

Is this stuff helpful to you guys?  I know thet the PARISC tree
is somewhat different to the rest of the architectures, but I hope
some of this is possible.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.53/arch/parisc/Kconfig 2.5.53-32bit.1/arch/parisc/Kconfig
--- 2.5.53/arch/parisc/Kconfig	2002-12-10 15:10:16.000000000 +1100
+++ 2.5.53-32bit.1/arch/parisc/Kconfig	2002-12-16 14:51:53.000000000 +1100
@@ -107,6 +107,11 @@
 	  enable this option otherwise. The 64bit kernel is significantly bigger
 	  and slower than the 32bit one.
 
+config COMPAT
+	bool
+	depends PARISC64
+	default y
+
 config PDC_NARROW
 	bool "32-bit firmware"
 	depends on PARISC64
diff -ruN 2.5.53/arch/parisc/kernel/binfmt_elf32.c 2.5.53-32bit.1/arch/parisc/kernel/binfmt_elf32.c
--- 2.5.53/arch/parisc/kernel/binfmt_elf32.c	2002-10-31 14:05:12.000000000 +1100
+++ 2.5.53-32bit.1/arch/parisc/kernel/binfmt_elf32.c	2002-12-16 14:51:53.000000000 +1100
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/elfcore.h>
-#include "sys32.h"		/* struct timeval32 */
+#include <linux/compat.h>		/* struct compat_timeval */
 
 #define elf_prstatus elf_prstatus32
 struct elf_prstatus32
@@ -32,10 +32,10 @@
 	pid_t	pr_ppid;
 	pid_t	pr_pgrp;
 	pid_t	pr_sid;
-	struct timeval32 pr_utime;	/* User time */
-	struct timeval32 pr_stime;	/* System time */
-	struct timeval32 pr_cutime;	/* Cumulative user time */
-	struct timeval32 pr_cstime;	/* Cumulative system time */
+	struct compat_timeval pr_utime;	/* User time */
+	struct compat_timeval pr_stime;	/* System time */
+	struct compat_timeval pr_cutime;	/* Cumulative user time */
+	struct compat_timeval pr_cstime;	/* Cumulative system time */
 	elf_gregset_t pr_reg;	/* GP registers */
 	int pr_fpvalid;		/* True if math co-processor being used.  */
 };
diff -ruN 2.5.53/arch/parisc/kernel/ioctl32.c 2.5.53-32bit.1/arch/parisc/kernel/ioctl32.c
--- 2.5.53/arch/parisc/kernel/ioctl32.c	2002-10-31 14:05:12.000000000 +1100
+++ 2.5.53-32bit.1/arch/parisc/kernel/ioctl32.c	2002-12-30 15:39:44.000000000 +1100
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/compat.h>
 #include "sys32.h"
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -164,7 +165,7 @@
  
 static int do_siocgstamp(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct timeval32 *up = (struct timeval32 *)arg;
+	struct compat_timeval *up = (struct compat_timeval *)arg;
 	struct timeval ktv;
 	mm_segment_t old_fs = get_fs();
 	int err;
@@ -206,13 +207,13 @@
                 struct  ifmap32 ifru_map;
                 char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
 		char	ifru_newname[IFNAMSIZ];
-                __kernel_caddr_t32 ifru_data;
+                compat_caddr_t ifru_data;
         } ifr_ifru;
 };
 
 struct ifconf32 {
         int     ifc_len;                        /* size of buffer       */
-        __kernel_caddr_t32  ifcbuf;
+        compat_caddr_t  ifcbuf;
 };
 
 static int dev_ifname32(unsigned int fd, unsigned int cmd, unsigned long arg)
@@ -576,7 +577,7 @@
 
 struct fb_fix_screeninfo32 {
 	char			id[16];
-        __kernel_caddr_t32	smem_start;
+        compat_caddr_t	smem_start;
 	__u32			smem_len;
 	__u32			type;
 	__u32			type_aux;
@@ -585,7 +586,7 @@
 	__u16			ypanstep;
 	__u16			ywrapstep;
 	__u32			line_length;
-        __kernel_caddr_t32	mmio_start;
+        compat_caddr_t	mmio_start;
 	__u32			mmio_len;
 	__u32			accel;
 	__u16			reserved[3];
@@ -594,10 +595,10 @@
 struct fb_cmap32 {
 	__u32			start;
 	__u32			len;
-	__kernel_caddr_t32	red;
-	__kernel_caddr_t32	green;
-	__kernel_caddr_t32	blue;
-	__kernel_caddr_t32	transp;
+	compat_caddr_t	red;
+	compat_caddr_t	green;
+	compat_caddr_t	blue;
+	compat_caddr_t	transp;
 };
 
 static int fb_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
@@ -752,7 +753,7 @@
 	unsigned char	rate;
 	unsigned char	spec1;
 	unsigned char	fmt_gap;
-	const __kernel_caddr_t32 name;
+	const compat_caddr_t name;
 };
 
 struct floppy_drive_params32 {
@@ -791,7 +792,7 @@
 	int		fd_ref;
 	int		fd_device;
 	int		last_checked;
-	__kernel_caddr_t32 dmabuf;
+	compat_caddr_t dmabuf;
 	int		bufblocks;
 };
 
@@ -1053,15 +1054,15 @@
 }
 
 struct ppp_option_data32 {
-	__kernel_caddr_t32	ptr;
+	compat_caddr_t	ptr;
 	__u32			length;
 	int			transmit;
 };
 #define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
 
 struct ppp_idle32 {
-	__kernel_time_t32 xmit_idle;
-	__kernel_time_t32 recv_idle;
+	compat_time_t xmit_idle;
+	compat_time_t recv_idle;
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
@@ -1135,8 +1136,8 @@
 	__u32	mt_dsreg;
 	__u32	mt_gstat;
 	__u32	mt_erreg;
-	__kernel_daddr_t32	mt_fileno;
-	__kernel_daddr_t32	mt_blkno;
+	compat_daddr_t	mt_fileno;
+	compat_daddr_t	mt_blkno;
 };
 #define MTIOCGET32	_IOR('m', 2, struct mtget32)
 
@@ -1255,7 +1256,7 @@
 
 struct cdrom_read32 {
 	int			cdread_lba;
-	__kernel_caddr_t32	cdread_bufaddr;
+	compat_caddr_t	cdread_bufaddr;
 	int			cdread_buflen;
 };
 
@@ -1263,16 +1264,16 @@
 	union cdrom_addr	addr;
 	u_char			addr_format;
 	int			nframes;
-	__kernel_caddr_t32	buf;
+	compat_caddr_t	buf;
 };
 
 struct cdrom_generic_command32 {
 	unsigned char		cmd[CDROM_PACKET_SIZE];
-	__kernel_caddr_t32	buffer;
+	compat_caddr_t	buffer;
 	unsigned int		buflen;
 	int			stat;
-	__kernel_caddr_t32	sense;
-	__kernel_caddr_t32	reserved[3];
+	compat_caddr_t	sense;
+	compat_caddr_t	reserved[3];
 };
 
 static int cdrom_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
@@ -1281,7 +1282,7 @@
 	struct cdrom_read cdread;
 	struct cdrom_read_audio cdreadaudio;
 	struct cdrom_generic_command cgc;
-	__kernel_caddr_t32 addr;
+	compat_caddr_t addr;
 	char *data = 0;
 	void *karg;
 	int err = 0;
@@ -1365,9 +1366,9 @@
 
 struct loop_info32 {
 	int			lo_number;      /* ioctl r/o */
-	__kernel_dev_t32	lo_device;      /* ioctl r/o */
+	compat_dev_t	lo_device;      /* ioctl r/o */
 	unsigned int		lo_inode;       /* ioctl r/o */
-	__kernel_dev_t32	lo_rdevice;     /* ioctl r/o */
+	compat_dev_t	lo_rdevice;     /* ioctl r/o */
 	int			lo_offset;
 	int			lo_encrypt_type;
 	int			lo_encrypt_key_size;    /* ioctl w/o */
@@ -1576,7 +1577,7 @@
 	set_fs(old_fs);
 
 	if (err >= 0)
-		err = put_user(kuid, (__kernel_uid_t32 *)arg);
+		err = put_user(kuid, (compat_uid_t *)arg);
 
 	return err;
 }
@@ -1585,12 +1586,12 @@
 struct atmif_sioc32 {
         int                number;
         int                length;
-        __kernel_caddr_t32 arg;
+        compat_caddr_t arg;
 };
 
 struct atm_iobuf32 {
 	int                length;
-	__kernel_caddr_t32 buffer;
+	compat_caddr_t buffer;
 };
 
 #define ATM_GETLINKRATE32 _IOW('a', ATMIOC_ITF+1, struct atmif_sioc32)
@@ -1651,7 +1652,7 @@
 
 	iobuf.length = iobuf32.length;
 
-	if (iobuf32.buffer == (__kernel_caddr_t32) NULL || iobuf32.length == 0) {
+	if (iobuf32.buffer == (compat_caddr_t) NULL || iobuf32.length == 0) {
 		iobuf.buffer = (void*)(unsigned long)iobuf32.buffer;
 	} else {
 		iobuf.buffer = kmalloc(iobuf.length, GFP_KERNEL);
@@ -1705,7 +1706,7 @@
         sioc.number = sioc32.number;
         sioc.length = sioc32.length;
         
-	if (sioc32.arg == (__kernel_caddr_t32) NULL || sioc32.length == 0) {
+	if (sioc32.arg == (compat_caddr_t) NULL || sioc32.length == 0) {
 		sioc.arg = (void*)(unsigned long)sioc32.arg;
         } else {
                 sioc.arg = kmalloc(sioc.length, GFP_KERNEL);
@@ -1863,7 +1864,7 @@
 } lv_status_byindex_req32_t;
 
 typedef struct {
-	__kernel_dev_t32 dev;
+	compat_dev_t dev;
 	u32   lv;
 } lv_status_bydev_req32_t;
 
@@ -3627,7 +3628,7 @@
 HANDLE_IOCTL(EXT2_IOC32_SETVERSION, do_ext2_ioctl)
 #if 0
 /* One SMB ioctl needs translations. */
-#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, __kernel_uid_t32)
+#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
 #endif
 HANDLE_IOCTL(ATM_GETLINKRATE32, do_atm_ioctl)
diff -ruN 2.5.53/arch/parisc/kernel/signal32.c 2.5.53-32bit.1/arch/parisc/kernel/signal32.c
--- 2.5.53/arch/parisc/kernel/signal32.c	2002-10-31 14:05:13.000000000 +1100
+++ 2.5.53-32bit.1/arch/parisc/kernel/signal32.c	2002-12-16 14:51:53.000000000 +1100
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 #include "sys32.h"
@@ -175,7 +176,7 @@
 typedef struct {
 	unsigned int ss_sp;
 	int ss_flags;
-	__kernel_size_t32 ss_size;
+	compat_size_t ss_size;
 } stack_t32;
 
 int 
diff -ruN 2.5.53/arch/parisc/kernel/sys32.h 2.5.53-32bit.1/arch/parisc/kernel/sys32.h
--- 2.5.53/arch/parisc/kernel/sys32.h	2002-10-31 14:05:13.000000000 +1100
+++ 2.5.53-32bit.1/arch/parisc/kernel/sys32.h	2002-12-16 14:51:53.000000000 +1100
@@ -12,11 +12,6 @@
     set_fs (old_fs); \
 }
 
-struct timeval32 {
-	int tv_sec;
-	int tv_usec;
-};
-
 typedef __u32 __sighandler_t32;
 
 #include <linux/signal.h>
diff -ruN 2.5.53/arch/parisc/kernel/sys_parisc32.c 2.5.53-32bit.1/arch/parisc/kernel/sys_parisc32.c
--- 2.5.53/arch/parisc/kernel/sys_parisc32.c	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.53-32bit.1/arch/parisc/kernel/sys_parisc32.c	2002-12-30 15:38:41.000000000 +1100
@@ -16,7 +16,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -52,6 +51,7 @@
 #include <linux/mman.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
+#include <linux/compat.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -386,74 +386,12 @@
  * code available in case it's useful to others. -PB
  */
 
-/* from utime.h */
-struct utimbuf32 {
-	__kernel_time_t32 actime;
-	__kernel_time_t32 modtime;
-};
-
-asmlinkage long sys32_utime(char *filename, struct utimbuf32 *times)
-{
-    struct utimbuf32 times32;
-    struct utimbuf times64;
-    extern long sys_utime(char *filename, struct utimbuf *times);
-    char *fname;
-    long ret;
-
-    if (!times)
-    	return sys_utime(filename, NULL);
-
-    /* get the 32-bit struct from user space */
-    if (copy_from_user(&times32, times, sizeof times32))
-    	return -EFAULT;
-
-    /* convert it into the 64-bit one */
-    times64.actime = times32.actime;
-    times64.modtime = times32.modtime;
-
-    /* grab the file name */
-    fname = getname(filename);
-
-    KERNEL_SYSCALL(ret, sys_utime, fname, &times64);
-
-    /* free the file name */
-    putname(fname);
-
-    return ret;
-}
-
-struct tms32 {
-	__kernel_clock_t32 tms_utime;
-	__kernel_clock_t32 tms_stime;
-	__kernel_clock_t32 tms_cutime;
-	__kernel_clock_t32 tms_cstime;
-};
-                                
-asmlinkage long sys32_times(struct tms32 *tbuf)
-{
-	struct tms t;
-	long ret;
-	extern asmlinkage long sys_times(struct tms * tbuf);
-int err;
-	
-	KERNEL_SYSCALL(ret, sys_times, tbuf ? &t : NULL);
-	if (tbuf) {
-		err = put_user (t.tms_utime, &tbuf->tms_utime);
-		err |= __put_user (t.tms_stime, &tbuf->tms_stime);
-		err |= __put_user (t.tms_cutime, &tbuf->tms_cutime);
-		err |= __put_user (t.tms_cstime, &tbuf->tms_cstime);
-		if (err)
-			ret = -EFAULT;
-	}
-	return ret;
-}
-
 struct flock32 {
 	short l_type;
 	short l_whence;
-	__kernel_off_t32 l_start;
-	__kernel_off_t32 l_len;
-	__kernel_pid_t32 l_pid;
+	compat_off_t l_start;
+	compat_off_t l_len;
+	compat_pid_t l_pid;
 };
 
 
@@ -584,71 +522,42 @@
 }
 #endif /* CONFIG_SYSCTL */
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 static int
-put_timespec32(struct timespec32 *u, struct timespec *t)
+put_compat_timespec(struct compat_timespec *u, struct timespec *t)
 {
-	struct timespec32 t32;
+	struct compat_timespec t32;
 	t32.tv_sec = t->tv_sec;
 	t32.tv_nsec = t->tv_nsec;
 	return copy_to_user(u, &t32, sizeof t32);
 }
 
-asmlinkage int sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	struct timespec32 t32;
-	int ret;
-	extern asmlinkage int sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp);
-	
-	if (copy_from_user(&t32, rqtp, sizeof t32))
-		return -EFAULT;
-	t.tv_sec = t32.tv_sec;
-	t.tv_nsec = t32.tv_nsec;
-
-	DBG(("sys32_nanosleep({%d, %d})\n", t32.tv_sec, t32.tv_nsec));
-
-	KERNEL_SYSCALL(ret, sys_nanosleep, &t, rmtp ? &t : NULL);
-	if (rmtp && ret == -EINTR) {
-		if (put_timespec32(rmtp, &t))
-			return -EFAULT;
-	}
-	return ret;
-}
-
 asmlinkage long sys32_sched_rr_get_interval(pid_t pid,
-	struct timespec32 *interval)
+	struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
 	extern asmlinkage long sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 	
 	KERNEL_SYSCALL(ret, sys_sched_rr_get_interval, pid, &t);
-	if (put_timespec32(interval, &t))
+	if (put_compat_timespec(interval, &t))
 		return -EFAULT;
 	return ret;
 }
 
-typedef __kernel_time_t32 time_t32;
-
 static int
-put_timeval32(struct timeval32 *u, struct timeval *t)
+put_compat_timeval(struct compat_timeval *u, struct timeval *t)
 {
-	struct timeval32 t32;
+	struct compat_timeval t32;
 	t32.tv_sec = t->tv_sec;
 	t32.tv_usec = t->tv_usec;
 	return copy_to_user(u, &t32, sizeof t32);
 }
 
 static int
-get_timeval32(struct timeval32 *u, struct timeval *t)
+get_compat_timeval(struct compat_timeval *u, struct timeval *t)
 {
 	int err;
-	struct timeval32 t32;
+	struct compat_timeval t32;
 
 	if ((err = copy_from_user(&t32, u, sizeof t32)) == 0)
 	{
@@ -658,10 +567,10 @@
 	return err;
 }
 
-asmlinkage long sys32_time(time_t32 *tloc)
+asmlinkage long sys32_time(compat_time_t *tloc)
 {
     time_t now = get_seconds();
-    time_t32 now32 = now;
+    compat_time_t now32 = now;
 
     if (tloc)
     	if (put_user(now32, tloc))
@@ -671,14 +580,14 @@
 }
 
 asmlinkage int
-sys32_gettimeofday(struct timeval32 *tv, struct timezone *tz)
+sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
     extern void do_gettimeofday(struct timeval *tv);
 
     if (tv) {
 	    struct timeval ktv;
 	    do_gettimeofday(&ktv);
-	    if (put_timeval32(tv, &ktv))
+	    if (put_compat_timeval(tv, &ktv))
 		    return -EFAULT;
     }
     if (tz) {
@@ -690,14 +599,14 @@
 }
 
 asmlinkage int
-sys32_settimeofday(struct timeval32 *tv, struct timezone *tz)
+sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
     struct timeval ktv;
     struct timezone ktz;
     extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
     if (tv) {
-	    if (get_timeval32(tv, &ktv))
+	    if (get_compat_timeval(tv, &ktv))
 		    return -EFAULT;
     }
     if (tz) {
@@ -708,67 +617,9 @@
     return do_sys_settimeofday(tv ? &ktv : NULL, tz ? &ktz : NULL);
 }
 
-struct	itimerval32 {
-	struct	timeval32 it_interval;	/* timer interval */
-	struct	timeval32 it_value;	/* current value */
-};
-
-asmlinkage long sys32_getitimer(int which, struct itimerval32 *ov32)
-{
-	int error = -EFAULT;
-	struct itimerval get_buffer;
-	extern int do_getitimer(int which, struct itimerval *value);
-
-	if (ov32) {
-		error = do_getitimer(which, &get_buffer);
-		if (!error) {
-			struct itimerval32 gb32;
-			gb32.it_interval.tv_sec = get_buffer.it_interval.tv_sec;
-			gb32.it_interval.tv_usec = get_buffer.it_interval.tv_usec;
-			gb32.it_value.tv_sec = get_buffer.it_value.tv_sec;
-			gb32.it_value.tv_usec = get_buffer.it_value.tv_usec;
-			if (copy_to_user(ov32, &gb32, sizeof(gb32)))
-				error = -EFAULT; 
-		}
-	}
-	return error;
-}
-
-asmlinkage long sys32_setitimer(int which, struct itimerval32 *v32,
-			      struct itimerval32 *ov32)
-{
-	struct itimerval set_buffer, get_buffer;
-	struct itimerval32 sb32, gb32;
-	extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ov32);
-	int error;
-
-	if (v32) {
-		if(copy_from_user(&sb32, v32, sizeof(sb32)))
-			return -EFAULT;
-
-		set_buffer.it_interval.tv_sec = sb32.it_interval.tv_sec;
-		set_buffer.it_interval.tv_usec = sb32.it_interval.tv_usec;
-		set_buffer.it_value.tv_sec = sb32.it_value.tv_sec;
-		set_buffer.it_value.tv_usec = sb32.it_value.tv_usec;
-	} else
-		memset((char *) &set_buffer, 0, sizeof(set_buffer));
-
-	error = do_setitimer(which, &set_buffer, ov32 ? &get_buffer : 0);
-	if (error || !ov32)
-		return error;
-
-	gb32.it_interval.tv_sec = get_buffer.it_interval.tv_sec;
-	gb32.it_interval.tv_usec = get_buffer.it_interval.tv_usec;
-	gb32.it_value.tv_sec = get_buffer.it_value.tv_sec;
-	gb32.it_value.tv_usec = get_buffer.it_value.tv_usec;
-	if (copy_to_user(ov32, &gb32, sizeof(gb32)))
-		return -EFAULT; 
-	return 0;
-}
-
 struct rusage32 {
-        struct timeval32 ru_utime;
-        struct timeval32 ru_stime;
+        struct compat_timeval ru_utime;
+        struct compat_timeval ru_stime;
         int    ru_maxrss;
         int    ru_ixrss;
         int    ru_idrss;
@@ -823,7 +674,7 @@
 }
 
 asmlinkage int
-sys32_wait4(__kernel_pid_t32 pid, unsigned int * stat_addr, int options,
+sys32_wait4(compat_pid_t pid, unsigned int * stat_addr, int options,
 	    struct rusage32 * ru)
 {
 	if (!ru)
@@ -841,41 +692,13 @@
 	}
 }
 
-struct stat32 {
-	__kernel_dev_t32		st_dev;		/* dev_t is 32 bits on parisc */
-	__kernel_ino_t32		st_ino;		/* 32 bits */
-	__kernel_mode_t32	st_mode;	/* 16 bits */
-	__kernel_nlink_t32		st_nlink;	/* 16 bits */
-	unsigned short	st_reserved1;	/* old st_uid */
-	unsigned short	st_reserved2;	/* old st_gid */
-	__kernel_dev_t32		st_rdev;
-	__kernel_off_t32		st_size;
-	__kernel_time_t32	st_atime;
-	unsigned int	st_spare1;
-	__kernel_time_t32	st_mtime;
-	unsigned int	st_spare2;
-	__kernel_time_t32	st_ctime;
-	unsigned int	st_spare3;
-	int		st_blksize;
-	int		st_blocks;
-	unsigned int	__unused1;	/* ACL stuff */
-	__kernel_dev_t32		__unused2;	/* network */
-	__kernel_ino_t32		__unused3;	/* network */
-	unsigned int	__unused4;	/* cnodes */
-	unsigned short	__unused5;	/* netsite */
-	short		st_fstype;
-	__kernel_dev_t32		st_realdev;
-	unsigned short	st_basemode;
-	unsigned short	st_spareshort;
-	__kernel_uid_t32		st_uid;
-	__kernel_gid_t32		st_gid;
-	unsigned int	st_spare4[3];
-};
-
-static int cp_new_stat32(struct kstat *stat, struct stat32 *statbuf)
+int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
 	int err;
 
+	if (stat->size > MAX_NON_LFS)
+		return -EOVERFLOW;
+
 	err  = put_user(stat->dev, &statbuf->st_dev);
 	err |= put_user(stat->ino, &statbuf->st_ino);
 	err |= put_user(stat->mode, &statbuf->st_mode);
@@ -883,8 +706,6 @@
 	err |= put_user(0, &statbuf->st_reserved1);
 	err |= put_user(0, &statbuf->st_reserved2);
 	err |= put_user(stat->rdev, &statbuf->st_rdev);
-	if (stat->size > MAX_NON_LFS)
-		return -EOVERFLOW;
 	err |= put_user(stat->size, &statbuf->st_size);
 	err |= put_user(stat->atime, &statbuf->st_atime);
 	err |= put_user(0, &statbuf->st_spare1);
@@ -912,42 +733,9 @@
 	return err;
 }
 
-asmlinkage long sys32_newstat(char * filename, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int error = vfs_stat(filename, &stat);
-
-	if (!error) 
-		error = cp_new_stat32(&stat, statbuf);
-	
-	return error;
-}
-
-asmlinkage long sys32_newlstat(char * filename, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int error = vfs_lstat(filename, &stat);
-
-	if (!error)
-		error = cp_new_stat32(&stat, statbuf);
-
-	return error;
-}
-
-asmlinkage long sys32_newfstat(unsigned int fd, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int error = vfs_fstat(fd, &stat);
-
-	if (!error)
-		error = cp_new_stat32(&stat, statbuf);
-
-	return error;
-}
-
 struct linux32_dirent {
 	u32	d_ino;
-	__kernel_off_t32	d_off;
+	compat_off_t	d_off;
 	u16	d_reclen;
 	char	d_name[1];
 };
@@ -1302,7 +1090,7 @@
 }
 
 static int
-qm_modules(char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_modules(char *buf, size_t bufsize, compat_size_t *ret)
 {
 	struct module *mod;
 	size_t nmod, space, len;
@@ -1337,7 +1125,7 @@
 }
 
 static int
-qm_deps(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_deps(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 
@@ -1374,7 +1162,7 @@
 }
 
 static int
-qm_refs(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_refs(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t nrefs, space, len;
 	struct module_ref *ref;
@@ -1418,7 +1206,7 @@
 }
 
 static inline int
-qm_symbols(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_symbols(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 	struct module_symbol *s;
@@ -1477,7 +1265,7 @@
 }
 
 static inline int
-qm_info(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_info(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	int error = 0;
 
@@ -1505,7 +1293,7 @@
 	return error;
 }
 
-asmlinkage int sys32_query_module(char *name_user, int which, char *buf, __kernel_size_t32 bufsize, __kernel_size_t32 *ret)
+asmlinkage int sys32_query_module(char *name_user, int which, char *buf, compat_size_t bufsize, compat_size_t *ret)
 {
 	struct module *mod;
 	int err;
@@ -1776,14 +1564,14 @@
         u32               msg_name;
         int               msg_namelen;
         u32               msg_iov;
-        __kernel_size_t32 msg_iovlen;
+        compat_size_t msg_iovlen;
         u32               msg_control;
-        __kernel_size_t32 msg_controllen;
+        compat_size_t msg_controllen;
         unsigned          msg_flags;
 };
 
 struct cmsghdr32 {
-        __kernel_size_t32 cmsg_len;
+        compat_size_t cmsg_len;
         int               cmsg_level;
         int               cmsg_type;
 };
@@ -1917,7 +1705,7 @@
 {
 	struct cmsghdr32 *ucmsg;
 	struct cmsghdr *kcmsg, *kcmsg_base;
-	__kernel_size_t32 ucmlen;
+	compat_size_t ucmlen;
 	__kernel_size_t kcmlen, tmp;
 
 	kcmlen = 0;
@@ -2283,7 +2071,7 @@
 		err = move_addr_to_user(addr, kern_msg.msg_namelen, uaddr, uaddr_len);
 	if(cmsg_ptr != 0 && err >= 0) {
 		unsigned long ucmsg_ptr = ((unsigned long)kern_msg.msg_control);
-		__kernel_size_t32 uclen = (__kernel_size_t32) (ucmsg_ptr - cmsg_ptr);
+		compat_size_t uclen = (compat_size_t) (ucmsg_ptr - cmsg_ptr);
 		err |= __put_user(uclen, &user_msg->msg_controllen);
 	}
 	if(err >= 0)
@@ -2590,7 +2378,7 @@
 #define DIVIDE_ROUND_UP(x,y) (((x)+(y)-1)/(y))
 
 asmlinkage long
-sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, struct timeval32 *tvp)
+sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, struct compat_timeval *tvp)
 {
 	fd_set_bits fds;
 	char *bits;
@@ -2599,7 +2387,7 @@
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
-		struct timeval32 tv32;
+		struct compat_timeval tv32;
 		time_t sec, usec;
 
 		if ((ret = copy_from_user(&tv32, tvp, sizeof tv32)))
@@ -2768,7 +2556,7 @@
 	char			ex_client[NFSCLNT_IDMAX+1];
 	char			ex_path[NFS_MAXPATHLEN+1];
 	__kernel_dev_t		ex_dev;
-	__kernel_ino_t32	ex_ino;
+	compat_ino_t	ex_ino;
 	int			ex_flags;
 	__kernel_uid_t		ex_anon_uid;
 	__kernel_gid_t		ex_anon_gid;
@@ -2778,19 +2566,19 @@
 struct nfsctl_fhparm32 {
 	struct sockaddr		gf_addr;
 	__kernel_dev_t		gf_dev;
-	__kernel_ino_t32	gf_ino;
+	compat_ino_t	gf_ino;
 	int			gf_version;
 };
 
 /* UGIDUPDATE */
 struct nfsctl_uidmap32 {
-	__kernel_caddr_t32	ug_ident;
+	compat_caddr_t	ug_ident;
 	__kernel_uid_t		ug_uidbase;
 	int			ug_uidlen;
-	__kernel_caddr_t32	ug_udimap;
+	compat_caddr_t	ug_udimap;
 	__kernel_gid_t		ug_gidbase;
 	int			ug_gidlen;
-	__kernel_caddr_t32	ug_gdimap;
+	compat_caddr_t	ug_gdimap;
 };
 
 struct nfsctl_arg32 {
@@ -2903,8 +2691,8 @@
     __u32 dqb_ihardlimit;
     __u32 dqb_isoftlimit;
     __u32 dqb_curinodes;
-    __kernel_time_t32 dqb_btime;
-    __kernel_time_t32 dqb_itime;
+    compat_time_t dqb_btime;
+    compat_time_t dqb_itime;
 };
                                 
 
@@ -2965,7 +2753,7 @@
 	int tolerance;		/* clock frequency tolerance (ppm)
 				 * (read only)
 				 */
-	struct timeval32 time;	/* (read only) */
+	struct compat_timeval time;	/* (read only) */
 	int tick;		/* (modified) usecs between clock ticks */
 
 	int ppsfreq;           /* pps frequency (scaled ppm) (ro) */
diff -ruN 2.5.53/include/asm-parisc/compat.h 2.5.53-32bit.1/include/asm-parisc/compat.h
--- 2.5.53/include/asm-parisc/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.53-32bit.1/include/asm-parisc/compat.h	2002-12-30 15:44:32.000000000 +1100
@@ -0,0 +1,67 @@
+#ifndef _ASM_PARISC_COMPAT_H
+#define _ASM_PARISC_COMPAT_H
+/*
+ * Architecture specific compatibility types
+ */
+#include <linux/types.h>
+
+#define COMPAT_USER_HZ	100
+
+typedef u32		compat_size_t;
+typedef s32		compat_ssize_t;
+typedef s32		compat_time_t;
+typedef s32		compat_clock_t;
+typedef s32		compat_pid_t;
+typedef u32		compat_uid_t;
+typedef u32		compat_gid_t;
+typedef u16		compat_mode_t;
+typedef u32		compat_ino_t;
+typedef u32		compat_dev_t;
+typedef s32		compat_off_t;
+typedef u16		compat_nlink_t;
+typedef u16		compat_ipc_pid_t;
+typedef s32		compat_daddr_t;
+typedef u32		compat_caddr_t;
+
+struct compat_timespec {
+	compat_time_t	tv_sec;
+	s32		tv_nsec;
+};
+
+struct compat_timeval {
+	compat_time_t	tv_sec;
+	s32		tv_usec;
+};
+
+struct compat_stat {
+	compat_dev_t	st_dev;		/* dev_t is 32 bits on parisc */
+	compat_ino_t	st_ino;		/* 32 bits */
+	compat_mode_t	st_mode;	/* 16 bits */
+	compat_nlink_t	st_nlink;	/* 16 bits */
+	u16		st_reserved1;	/* old st_uid */
+	u16		st_reserved2;	/* old st_gid */
+	compat_dev_t	st_rdev;
+	compat_off_t	st_size;
+	compat_time_t	st_atime;
+	u32		st_spare1;
+	compat_time_t	st_mtime;
+	u32		st_spare2;
+	compat_time_t	st_ctime;
+	u32		st_spare3;
+	s32		st_blksize;
+	s32		st_blocks;
+	u32		__unused1;	/* ACL stuff */
+	compat_dev_t	__unused2;	/* network */
+	compat_ino_t	__unused3;	/* network */
+	u32		__unused4;	/* cnodes */
+	u16		__unused5;	/* netsite */
+	short		st_fstype;
+	compat_dev_t	st_realdev;
+	u16		st_basemode;
+	u16		st_spareshort;
+	compat_uid_t	st_uid;
+	compat_gid_t	st_gid;
+	u32		st_spare4[3];
+};
+
+#endif /* _ASM_PARISC_COMPAT_H */
diff -ruN 2.5.53/include/asm-parisc/posix_types.h 2.5.53-32bit.1/include/asm-parisc/posix_types.h
--- 2.5.53/include/asm-parisc/posix_types.h	2002-10-31 14:06:07.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-parisc/posix_types.h	2002-12-30 15:44:48.000000000 +1100
@@ -55,27 +55,6 @@
 typedef __kernel_uid_t __kernel_old_uid_t;
 typedef __kernel_gid_t __kernel_old_gid_t;
 
-#if defined(__KERNEL__) && defined(__LP64__)
-/* Now 32bit compatibility types */
-typedef unsigned int		__kernel_dev_t32;
-typedef unsigned int		__kernel_ino_t32;
-typedef unsigned short		__kernel_mode_t32;
-typedef unsigned short		__kernel_nlink_t32;
-typedef int			__kernel_off_t32;
-typedef int			__kernel_pid_t32;
-typedef unsigned short		__kernel_ipc_pid_t32;
-typedef unsigned int		__kernel_uid_t32;
-typedef unsigned int		__kernel_gid_t32;
-typedef unsigned int		__kernel_size_t32;
-typedef int			__kernel_ssize_t32;
-typedef int			__kernel_ptrdiff_t32;
-typedef int			__kernel_time_t32;
-typedef int			__kernel_suseconds_t32;
-typedef int			__kernel_clock_t32;
-typedef int			__kernel_daddr_t32;
-typedef unsigned int		__kernel_caddr_t32;
-#endif
-
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
 #undef __FD_SET
