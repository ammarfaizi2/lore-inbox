Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTEZRUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTEZRSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:18:47 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:10213 "EHLO
	d06lmsgate-4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S261872AbTEZRQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:16:28 -0400
Date: Mon, 26 May 2003 19:26:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (6/10): 31 bit compat.
Message-ID: <20030526172615.GG3748@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 32 bit compatability fixes:
 - Fix compat entries in the system call table.
 - Update to new compat_ioctl mechanism.
 - Define compat_alloc_user_space.

diffstat:
 arch/s390/kernel/compat_ioctl.c   |  405 +++++++++++++++-----------------------
 arch/s390/kernel/compat_wrapper.S |   27 ++
 arch/s390/kernel/s390_ksyms.c     |   14 -
 arch/s390/kernel/syscalls.S       |   18 -
 include/asm-s390/compat.h         |   11 +
 include/linux/compat_ioctl.h      |   22 ++
 6 files changed, 231 insertions(+), 266 deletions(-)

diff -urN linux-2.5/arch/s390/kernel/compat_ioctl.c linux-2.5-s390/arch/s390/kernel/compat_ioctl.c
--- linux-2.5/arch/s390/kernel/compat_ioctl.c	Mon May  5 01:53:34 2003
+++ linux-2.5-s390/arch/s390/kernel/compat_ioctl.c	Mon May 26 19:20:46 2003
@@ -11,32 +11,57 @@
  *
  */
 
-#include <linux/types.h>
 #include <linux/compat.h>
+#include <linux/init.h>
+#include <linux/ioctl32.h>
 #include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/sched.h>
 #include <linux/mm.h>
-#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+
+#include <asm/ioctls.h>
+#include <asm/types.h>
+#include <asm/uaccess.h>
+
+#include <linux/blk.h>
+#include <linux/blkpg.h>
+#include <linux/cdrom.h>
+#include <linux/dm-ioctl.h>
+#include <linux/elevator.h>
 #include <linux/file.h>
-#include <linux/vt.h>
+#include <linux/fs.h>
+#include <linux/hdreg.h>
 #include <linux/kd.h>
+#include <linux/loop.h>
+#include <linux/lp.h>
+#include <linux/mtio.h>
 #include <linux/netdevice.h>
+#include <linux/nbd.h>
+#include <linux/ppp_defs.h>
+#include <linux/raid/md_u.h>
+#include <linux/random.h>
+#include <linux/raw.h>
 #include <linux/route.h>
+#include <linux/vt.h>
+#include <linux/watchdog.h>
+
+#include <linux/auto_fs.h>
+#include <linux/devfs_fs.h>
 #include <linux/ext2_fs.h>
-#include <linux/hdreg.h>
+#include <linux/smb_fs.h>
+
 #include <linux/if_bonding.h>
-#include <linux/blkpg.h>
-#include <linux/blk.h>
-#include <linux/dm-ioctl.h>
-#include <linux/loop.h>
-#include <linux/elevator.h>
-#include <asm/types.h>
-#include <asm/uaccess.h>
+#include <linux/if_ppp.h>
+#include <linux/if_pppox.h>
+#include <linux/if_tun.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_ioctl.h>
+#include <scsi/sg.h>
+
 #include <asm/dasd.h>
-#include <asm/tape390.h>
 #include <asm/sockios.h>
-#include <asm/ioctls.h>
+#include <asm/tape390.h>
 
 #include "compat_linux.h"
 
@@ -49,7 +74,8 @@
 	__u32		start;
 };  
 
-static inline int hd_geometry_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static inline int hd_geometry_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg,
+				    struct file *f)
 {
 	struct hd_geometry32 *hg32 = (struct hd_geometry32 *) A(arg);
 	struct hd_geometry hg;
@@ -112,7 +138,8 @@
         __u32	ifcbuf;
 };
 
-static int dev_ifname32(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int dev_ifname32(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	struct ireq32 *uir32 = (struct ireq32 *) A(arg);
 	struct net_device *dev;
@@ -137,8 +164,8 @@
 	return 0;
 }
 
-static inline int dev_ifconf(unsigned int fd, unsigned int cmd,
-			     unsigned long arg)
+static int dev_ifconf(unsigned int fd, unsigned int cmd,
+		      unsigned long arg, struct file *f)
 {
 	struct ioconf32 *uifc32 = (struct ioconf32 *) A(arg);
 	struct ifconf32 ifc32;
@@ -202,7 +229,8 @@
 	return err;
 }
 
-static int bond_ioctl(unsigned long fd, unsigned int cmd, unsigned long arg)
+static int bond_ioctl(unsigned int fd, unsigned int cmd,
+		      unsigned long arg, struct file *f)
 {
 	struct ifreq ifr;
 	mm_segment_t old_fs;
@@ -254,8 +282,8 @@
 	return err;
 }
 
-static inline int dev_ifsioc(unsigned int fd, unsigned int cmd,
-			     unsigned long arg)
+static int dev_ifsioc(unsigned int fd, unsigned int cmd,
+			     unsigned long arg, struct file *f)
 {
 	struct ifreq32 *uifr = (struct ifreq32 *) A(arg);
 	struct ifreq ifr;
@@ -335,7 +363,8 @@
 	unsigned short	rt_irtt;	/* Initial RTT			*/
 };
 
-static inline int routing_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int routing_ioctl(unsigned int fd, unsigned int cmd,
+			 unsigned long arg, struct file *f)
 {
 	struct rtentry32 *ur = (struct rtentry32 *) A(arg);
 	struct rtentry r;
@@ -364,7 +393,8 @@
 	return ret;
 }
 
-static int do_ext2_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_ext2_ioctl(unsigned int fd, unsigned int cmd,
+			 unsigned long arg, struct file *f)
 {
 	/* These are just misnamed, they actually get/put from/to user an int */
 	switch (cmd) {
@@ -392,7 +422,8 @@
 	char			reserved[4];
 };
 
-static int loop_status(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int loop_status(unsigned int fd, unsigned int cmd,
+		       unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	struct loop_info l;
@@ -448,10 +479,12 @@
 	u32 data;
 };
                                 
-static int blkpg_ioctl_trans(unsigned int fd, unsigned int cmd, struct blkpg_ioctl_arg32 *arg)
+static int blkpg_ioctl_trans(unsigned int fd, unsigned int cmd,
+			     unsigned long uarg, struct file *f)
 {
 	struct blkpg_ioctl_arg a;
 	struct blkpg_partition p;
+	struct blkpg_ioctl_arg32 *arg = (void*)A(uarg);
 	int err;
 	mm_segment_t old_fs = get_fs();
 	
@@ -541,7 +574,7 @@
 #define ICAZ90HARDRESET _IOC(_IOC_NONE, ICA_IOCTL_MAGIC, 0x12, 0)
 #define ICAZ90HARDERROR _IOC(_IOC_NONE, ICA_IOCTL_MAGIC, 0x13, 0)
 
-static int do_rsa_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_rsa_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	int err = 0;
@@ -622,7 +655,8 @@
 	return err;
 }
 
-static int do_rsa_crt_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_rsa_crt_ioctl(unsigned int fd, unsigned int cmd,
+			    unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	int err = 0;
@@ -745,7 +779,8 @@
 	return err;
 }
 
-static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg,
+		  struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	int err;
@@ -759,216 +794,106 @@
 	return err;
 }
 
-struct ioctl32_handler {
-	unsigned int cmd;
-	int (*function)(unsigned int, unsigned int, unsigned long);
-};
-
-struct ioctl32_list {
-	struct ioctl32_handler handler;
-	struct ioctl32_list *next;
-};
-
-#define IOCTL32_DEFAULT(cmd)		{ { cmd, (void *) sys_ioctl }, 0 }
-#define IOCTL32_HANDLER(cmd, handler)	{ { cmd, (void *) handler }, 0 }
-
-static struct ioctl32_list ioctl32_handler_table[] = {
-	IOCTL32_DEFAULT(FIBMAP),
-	IOCTL32_DEFAULT(FIGETBSZ),
-
-	IOCTL32_DEFAULT(DASDAPIVER),
-	IOCTL32_DEFAULT(BIODASDDISABLE),
-	IOCTL32_DEFAULT(BIODASDENABLE),
-	IOCTL32_DEFAULT(BIODASDRSRV),
-	IOCTL32_DEFAULT(BIODASDRLSE),
-	IOCTL32_DEFAULT(BIODASDSLCK),
-	IOCTL32_DEFAULT(BIODASDINFO),
-	IOCTL32_DEFAULT(BIODASDFMT),
-
-	IOCTL32_DEFAULT(TAPE390_DISPLAY),
-
-	IOCTL32_DEFAULT(BLKROSET),
-	IOCTL32_DEFAULT(BLKROGET),
-	IOCTL32_DEFAULT(BLKRRPART),
-	IOCTL32_DEFAULT(BLKFLSBUF),
-	IOCTL32_DEFAULT(BLKRASET),
-	IOCTL32_DEFAULT(BLKFRASET),
-	IOCTL32_DEFAULT(BLKSECTSET),
-	IOCTL32_DEFAULT(BLKSSZGET),
-	IOCTL32_DEFAULT(BLKBSZGET),
-	IOCTL32_DEFAULT(BLKGETSIZE64),
-
-	IOCTL32_HANDLER(HDIO_GETGEO, hd_geometry_ioctl),
-
-	IOCTL32_DEFAULT(TCGETA),
-	IOCTL32_DEFAULT(TCSETA),
-	IOCTL32_DEFAULT(TCSETAW),
-	IOCTL32_DEFAULT(TCSETAF),
-	IOCTL32_DEFAULT(TCSBRK),
-	IOCTL32_DEFAULT(TCSBRKP),
-	IOCTL32_DEFAULT(TCXONC),
-	IOCTL32_DEFAULT(TCFLSH),
-	IOCTL32_DEFAULT(TCGETS),
-	IOCTL32_DEFAULT(TCSETS),
-	IOCTL32_DEFAULT(TCSETSW),
-	IOCTL32_DEFAULT(TCSETSF),
-	IOCTL32_DEFAULT(TIOCLINUX),
-
-	IOCTL32_DEFAULT(TIOCGETD),
-	IOCTL32_DEFAULT(TIOCSETD),
-	IOCTL32_DEFAULT(TIOCEXCL),
-	IOCTL32_DEFAULT(TIOCNXCL),
-	IOCTL32_DEFAULT(TIOCCONS),
-	IOCTL32_DEFAULT(TIOCGSOFTCAR),
-	IOCTL32_DEFAULT(TIOCSSOFTCAR),
-	IOCTL32_DEFAULT(TIOCSWINSZ),
-	IOCTL32_DEFAULT(TIOCGWINSZ),
-	IOCTL32_DEFAULT(TIOCMGET),
-	IOCTL32_DEFAULT(TIOCMBIC),
-	IOCTL32_DEFAULT(TIOCMBIS),
-	IOCTL32_DEFAULT(TIOCMSET),
-	IOCTL32_DEFAULT(TIOCPKT),
-	IOCTL32_DEFAULT(TIOCNOTTY),
-	IOCTL32_DEFAULT(TIOCSTI),
-	IOCTL32_DEFAULT(TIOCOUTQ),
-	IOCTL32_DEFAULT(TIOCSPGRP),
-	IOCTL32_DEFAULT(TIOCGPGRP),
-	IOCTL32_DEFAULT(TIOCSCTTY),
-	IOCTL32_DEFAULT(TIOCGPTN),
-	IOCTL32_DEFAULT(TIOCSPTLCK),
-	IOCTL32_DEFAULT(TIOCGSERIAL),
-	IOCTL32_DEFAULT(TIOCSSERIAL),
-	IOCTL32_DEFAULT(TIOCSERGETLSR),
-
-	IOCTL32_DEFAULT(FIOCLEX),
-	IOCTL32_DEFAULT(FIONCLEX),
-	IOCTL32_DEFAULT(FIOASYNC),
-	IOCTL32_DEFAULT(FIONBIO),
-	IOCTL32_DEFAULT(FIONREAD),
-
-	IOCTL32_DEFAULT(PIO_FONT),
-	IOCTL32_DEFAULT(GIO_FONT),
-	IOCTL32_DEFAULT(KDSIGACCEPT),
-	IOCTL32_DEFAULT(KDGETKEYCODE),
-	IOCTL32_DEFAULT(KDSETKEYCODE),
-	IOCTL32_DEFAULT(KIOCSOUND),
-	IOCTL32_DEFAULT(KDMKTONE),
-	IOCTL32_DEFAULT(KDGKBTYPE),
-	IOCTL32_DEFAULT(KDSETMODE),
-	IOCTL32_DEFAULT(KDGETMODE),
-	IOCTL32_DEFAULT(KDSKBMODE),
-	IOCTL32_DEFAULT(KDGKBMODE),
-	IOCTL32_DEFAULT(KDSKBMETA),
-	IOCTL32_DEFAULT(KDGKBMETA),
-	IOCTL32_DEFAULT(KDGKBENT),
-	IOCTL32_DEFAULT(KDSKBENT),
-	IOCTL32_DEFAULT(KDGKBSENT),
-	IOCTL32_DEFAULT(KDSKBSENT),
-	IOCTL32_DEFAULT(KDGKBDIACR),
-	IOCTL32_DEFAULT(KDSKBDIACR),
-	IOCTL32_DEFAULT(KDGKBLED),
-	IOCTL32_DEFAULT(KDSKBLED),
-	IOCTL32_DEFAULT(KDGETLED),
-	IOCTL32_DEFAULT(KDSETLED),
-	IOCTL32_DEFAULT(GIO_SCRNMAP),
-	IOCTL32_DEFAULT(PIO_SCRNMAP),
-	IOCTL32_DEFAULT(GIO_UNISCRNMAP),
-	IOCTL32_DEFAULT(PIO_UNISCRNMAP),
-	IOCTL32_DEFAULT(PIO_FONTRESET),
-	IOCTL32_DEFAULT(PIO_UNIMAPCLR),
-
-	IOCTL32_DEFAULT(VT_SETMODE),
-	IOCTL32_DEFAULT(VT_GETMODE),
-	IOCTL32_DEFAULT(VT_GETSTATE),
-	IOCTL32_DEFAULT(VT_OPENQRY),
-	IOCTL32_DEFAULT(VT_ACTIVATE),
-	IOCTL32_DEFAULT(VT_WAITACTIVE),
-	IOCTL32_DEFAULT(VT_RELDISP),
-	IOCTL32_DEFAULT(VT_DISALLOCATE),
-	IOCTL32_DEFAULT(VT_RESIZE),
-	IOCTL32_DEFAULT(VT_RESIZEX),
-	IOCTL32_DEFAULT(VT_LOCKSWITCH),
-	IOCTL32_DEFAULT(VT_UNLOCKSWITCH),
-
-	IOCTL32_DEFAULT(SIOCGSTAMP),
-
-	IOCTL32_DEFAULT(DM_VERSION),
-	IOCTL32_DEFAULT(DM_REMOVE_ALL),
-	IOCTL32_DEFAULT(DM_DEV_CREATE),
-	IOCTL32_DEFAULT(DM_DEV_REMOVE),
-	IOCTL32_DEFAULT(DM_DEV_RELOAD),
-	IOCTL32_DEFAULT(DM_DEV_SUSPEND),
-	IOCTL32_DEFAULT(DM_DEV_RENAME),
-	IOCTL32_DEFAULT(DM_DEV_DEPS),
-	IOCTL32_DEFAULT(DM_DEV_STATUS),
-	IOCTL32_DEFAULT(DM_TARGET_STATUS),
-	IOCTL32_DEFAULT(DM_TARGET_WAIT),
-
-	IOCTL32_DEFAULT(LOOP_SET_FD),
-	IOCTL32_DEFAULT(LOOP_CLR_FD),
-
-	IOCTL32_HANDLER(SIOCGIFNAME, dev_ifname32),
-	IOCTL32_HANDLER(SIOCGIFCONF, dev_ifconf),
-	IOCTL32_HANDLER(SIOCGIFFLAGS, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFFLAGS, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFMETRIC, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFMETRIC, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFMTU, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFMTU, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFMEM, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFMEM, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFHWADDR, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFHWADDR, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCADDMULTI, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCDELMULTI, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFINDEX, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFMAP, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFMAP, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFADDR, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFADDR, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFBRDADDR, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFBRDADDR, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFDSTADDR, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFDSTADDR, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFNETMASK, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFNETMASK, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFPFLAGS, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFPFLAGS, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCGIFTXQLEN, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCSIFTXQLEN, dev_ifsioc),
-	IOCTL32_HANDLER(SIOCADDRT, routing_ioctl),
-	IOCTL32_HANDLER(SIOCDELRT, routing_ioctl),
-
-	IOCTL32_HANDLER(SIOCBONDENSLAVE, bond_ioctl),
-	IOCTL32_HANDLER(SIOCBONDRELEASE, bond_ioctl),
-	IOCTL32_HANDLER(SIOCBONDSETHWADDR, bond_ioctl),
-	IOCTL32_HANDLER(SIOCBONDSLAVEINFOQUERY, bond_ioctl),
-	IOCTL32_HANDLER(SIOCBONDINFOQUERY, bond_ioctl),
-	IOCTL32_HANDLER(SIOCBONDCHANGEACTIVE, bond_ioctl),
-
-	IOCTL32_HANDLER(EXT2_IOC32_GETFLAGS, do_ext2_ioctl),
-	IOCTL32_HANDLER(EXT2_IOC32_SETFLAGS, do_ext2_ioctl),
-	IOCTL32_HANDLER(EXT2_IOC32_GETVERSION, do_ext2_ioctl),
-	IOCTL32_HANDLER(EXT2_IOC32_SETVERSION, do_ext2_ioctl),
-
-	IOCTL32_HANDLER(LOOP_SET_STATUS, loop_status),
-	IOCTL32_HANDLER(LOOP_GET_STATUS, loop_status),
-
-	IOCTL32_HANDLER(ICARSAMODEXPO, do_rsa_ioctl),
-	IOCTL32_HANDLER(ICARSACRT, do_rsa_crt_ioctl),
-	IOCTL32_HANDLER(ICARSAMODMULT, do_rsa_ioctl),
-	IOCTL32_DEFAULT(ICAZ90STATUS),
-	IOCTL32_DEFAULT(ICAZ90QUIESCE),
-	IOCTL32_DEFAULT(ICAZ90HARDRESET),
-	IOCTL32_DEFAULT(ICAZ90HARDERROR),
-
-	IOCTL32_HANDLER(BLKRAGET, w_long),
-	IOCTL32_HANDLER(BLKGETSIZE, w_long),
-	IOCTL32_HANDLER(BLKFRAGET, w_long),
-	IOCTL32_HANDLER(BLKSECTGET, w_long),
-	IOCTL32_HANDLER(BLKPG, blkpg_ioctl_trans)
+int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd,
+			 unsigned long arg, struct file *f)
+{
+	/* siocdevprivate cannot be emulated properly */
+	return -EINVAL;
+}
 
-};
+#define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd), NULL)
+#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (handler), NULL },
+#define IOCTL_TABLE_START \
+	struct ioctl_trans ioctl_start[] = {
+#define IOCTL_TABLE_END \
+	}; struct ioctl_trans ioctl_end[0];
+
+IOCTL_TABLE_START
+#include <linux/compat_ioctl.h>
+
+COMPATIBLE_IOCTL(DASDAPIVER)
+COMPATIBLE_IOCTL(BIODASDDISABLE)
+COMPATIBLE_IOCTL(BIODASDENABLE)
+COMPATIBLE_IOCTL(BIODASDRSRV)
+COMPATIBLE_IOCTL(BIODASDRLSE)
+COMPATIBLE_IOCTL(BIODASDSLCK)
+COMPATIBLE_IOCTL(BIODASDINFO)
+COMPATIBLE_IOCTL(BIODASDFMT)
+
+COMPATIBLE_IOCTL(TAPE390_DISPLAY)
+COMPATIBLE_IOCTL(BLKRASET)
+COMPATIBLE_IOCTL(BLKFRASET)
+COMPATIBLE_IOCTL(BLKBSZGET)
+COMPATIBLE_IOCTL(BLKGETSIZE64)
+
+HANDLE_IOCTL(HDIO_GETGEO, hd_geometry_ioctl)
+
+COMPATIBLE_IOCTL(TCSBRKP)
+
+COMPATIBLE_IOCTL(TIOCGSERIAL)
+COMPATIBLE_IOCTL(TIOCSSERIAL)
+
+COMPATIBLE_IOCTL(SIOCGSTAMP)
+
+HANDLE_IOCTL(SIOCGIFNAME, dev_ifname32)
+HANDLE_IOCTL(SIOCGIFCONF, dev_ifconf)
+HANDLE_IOCTL(SIOCGIFFLAGS, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFFLAGS, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFMETRIC, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFMETRIC, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFMTU, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFMTU, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFMEM, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFMEM, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFHWADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFHWADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCADDMULTI, dev_ifsioc)
+HANDLE_IOCTL(SIOCDELMULTI, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFINDEX, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFMAP, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFMAP, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFBRDADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFBRDADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFDSTADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFDSTADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFNETMASK, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFNETMASK, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFPFLAGS, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFPFLAGS, dev_ifsioc)
+HANDLE_IOCTL(SIOCGIFTXQLEN, dev_ifsioc)
+HANDLE_IOCTL(SIOCSIFTXQLEN, dev_ifsioc)
+HANDLE_IOCTL(SIOCADDRT, routing_ioctl)
+HANDLE_IOCTL(SIOCDELRT, routing_ioctl)
+HANDLE_IOCTL(SIOCBONDENSLAVE, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDRELEASE, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDSETHWADDR, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDSLAVEINFOQUERY, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDINFOQUERY, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDCHANGEACTIVE, bond_ioctl)
+
+HANDLE_IOCTL(EXT2_IOC32_GETFLAGS, do_ext2_ioctl)
+HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
+HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)
+HANDLE_IOCTL(EXT2_IOC32_SETVERSION, do_ext2_ioctl)
+
+HANDLE_IOCTL(LOOP_SET_STATUS, loop_status)
+HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)
+
+HANDLE_IOCTL(ICARSAMODEXPO, do_rsa_ioctl)
+HANDLE_IOCTL(ICARSACRT, do_rsa_crt_ioctl)
+HANDLE_IOCTL(ICARSAMODMULT, do_rsa_ioctl)
+
+COMPATIBLE_IOCTL(ICAZ90STATUS)
+COMPATIBLE_IOCTL(ICAZ90QUIESCE)
+COMPATIBLE_IOCTL(ICAZ90HARDRESET)
+COMPATIBLE_IOCTL(ICAZ90HARDERROR)
+
+HANDLE_IOCTL(BLKRAGET, w_long)
+HANDLE_IOCTL(BLKGETSIZE, w_long)
+HANDLE_IOCTL(BLKFRAGET, w_long)
+HANDLE_IOCTL(BLKSECTGET, w_long)
+HANDLE_IOCTL(BLKPG, blkpg_ioctl_trans)
 
-#define NR_IOCTL32_HANDLERS	(sizeof(ioctl32_handler_table) /	\
-				 sizeof(ioctl32_handler_table[0]))
+IOCTL_TABLE_END
diff -urN linux-2.5/arch/s390/kernel/compat_wrapper.S linux-2.5-s390/arch/s390/kernel/compat_wrapper.S
--- linux-2.5/arch/s390/kernel/compat_wrapper.S	Mon May  5 01:53:57 2003
+++ linux-2.5-s390/arch/s390/kernel/compat_wrapper.S	Mon May 26 19:20:46 2003
@@ -220,12 +220,12 @@
 	lgfr	%r3,%r3			# int
 	jg	sys_umount		# branch to system call
 
-	.globl  sys32_ioctl_wrapper 
-sys32_ioctl_wrapper:
+	.globl  compat_sys_ioctl_wrapper
+compat_sys_ioctl_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgfr	%r3,%r3			# unsigned int
 	llgfr	%r4,%r4			# unsigned int
-	jg	sys32_ioctl		# branch to system call
+	jg	compat_sys_ioctl	# branch to system call
 
 	.globl  compat_sys_fcntl_wrapper 
 compat_sys_fcntl_wrapper:
@@ -1209,3 +1209,24 @@
 sys32_set_tid_address_wrapper:
 	llgtr	%r2,%r2			# int *
 	jg	sys_set_tid_address	# branch to system call
+
+	.globl  sys_epoll_create_wrapper
+sys_epoll_create_wrapper:
+	lgfr	%r2,%r2			# int
+	jg	sys_epoll_create	# branch to system call
+
+	.globl  sys_epoll_ctl_wrapper
+sys_epoll_ctl_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# int
+	lgfr	%r4,%r4			# int
+	llgtr	%r5,%r5			# struct epoll_event *
+	jg	sys_epoll_ctl		# branch to system call
+
+	.globl  sys_epoll_wait_wrapper
+sys_epoll_wait_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# struct epoll_event *
+	lgfr	%r4,%r4			# int
+	lgfr	%r5,%r5			# int
+	jg	sys_epoll_wait		# branch to system call
diff -urN linux-2.5/arch/s390/kernel/s390_ksyms.c linux-2.5-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.5/arch/s390/kernel/s390_ksyms.c	Mon May 26 19:20:43 2003
+++ linux-2.5-s390/arch/s390/kernel/s390_ksyms.c	Mon May 26 19:20:46 2003
@@ -61,20 +61,6 @@
 EXPORT_SYMBOL(overflowgid);
 EXPORT_SYMBOL(empty_zero_page);
 
-#ifdef CONFIG_S390_SUPPORT
-/*
- * Dynamically add/remove 31 bit ioctl conversion functions.
- */
-extern int register_ioctl32_conversion(unsigned int cmd,
-				       int (*handler)(unsigned int, 
-						      unsigned int,
-						      unsigned long,
-						      struct file *));
-int unregister_ioctl32_conversion(unsigned int cmd);
-EXPORT_SYMBOL(register_ioctl32_conversion);
-EXPORT_SYMBOL(unregister_ioctl32_conversion);
-#endif
-
 /*
  * misc.
  */
diff -urN linux-2.5/arch/s390/kernel/syscalls.S linux-2.5-s390/arch/s390/kernel/syscalls.S
--- linux-2.5/arch/s390/kernel/syscalls.S	Mon May  5 01:53:02 2003
+++ linux-2.5-s390/arch/s390/kernel/syscalls.S	Mon May 26 19:20:46 2003
@@ -62,7 +62,7 @@
 SYSCALL(sys_acct,sys_acct,sys32_acct_wrapper)
 SYSCALL(sys_umount,sys_umount,sys32_umount_wrapper)
 NI_SYSCALL							/* old lock syscall */
-SYSCALL(sys_ioctl,sys_ioctl,sys32_ioctl_wrapper)
+SYSCALL(sys_ioctl,sys_ioctl,compat_sys_ioctl_wrapper)
 SYSCALL(sys_fcntl,sys_fcntl,compat_sys_fcntl_wrapper)		/* 55 */
 NI_SYSCALL							/* intel mpx syscall */
 SYSCALL(sys_setpgid,sys_setpgid,sys32_setpgid_wrapper)
@@ -83,9 +83,9 @@
 SYSCALL(sys_sigsuspend_glue,sys_sigsuspend_glue,sys32_sigsuspend_glue)
 SYSCALL(sys_sigpending,sys_sigpending,compat_sys_sigpending_wrapper)
 SYSCALL(sys_sethostname,sys_sethostname,sys32_sethostname_wrapper)
-SYSCALL(sys_setrlimit,sys_setrlimit,sys32_setrlimit_wrapper)	/* 75 */
-SYSCALL(sys_old_getrlimit,sys_getrlimit,sys32_old_getrlimit_wrapper)
-SYSCALL(sys_getrusage,sys_getrusage,sys32_getrusage_wrapper)
+SYSCALL(sys_setrlimit,sys_setrlimit,compat_sys_setrlimit_wrapper)	/* 75 */
+SYSCALL(sys_old_getrlimit,sys_getrlimit,compat_sys_old_getrlimit_wrapper)
+SYSCALL(sys_getrusage,sys_getrusage,compat_sys_getrusage_wrapper)
 SYSCALL(sys_gettimeofday,sys_gettimeofday,sys32_gettimeofday_wrapper)
 SYSCALL(sys_settimeofday,sys_settimeofday,sys32_settimeofday_wrapper)
 SYSCALL(sys_getgroups16,sys_ni_syscall,sys32_getgroups16_wrapper)	/* 80 old getgroups16 syscall */
@@ -122,7 +122,7 @@
 SYSCALL(sys_vhangup,sys_vhangup,sys_vhangup)
 NI_SYSCALL							/* old "idle" system call */
 NI_SYSCALL							/* vm86old for i386 */
-SYSCALL(sys_wait4,sys_wait4,sys32_wait4_wrapper)
+SYSCALL(sys_wait4,sys_wait4,compat_sys_wait4_wrapper)
 SYSCALL(sys_swapoff,sys_swapoff,sys32_swapoff_wrapper)		/* 115 */
 SYSCALL(sys_sysinfo,sys_sysinfo,sys32_sysinfo_wrapper)
 SYSCALL(sys_ipc,sys_ipc,sys32_ipc_wrapper)
@@ -199,7 +199,7 @@
 NI_SYSCALL							/* streams1 */
 NI_SYSCALL							/* streams2 */
 SYSCALL(sys_vfork_glue,sys_vfork_glue,sys_vfork_glue)		/* 190 */
-SYSCALL(sys_getrlimit,sys_getrlimit,sys32_getrlimit_wrapper)
+SYSCALL(sys_getrlimit,sys_getrlimit,compat_sys_getrlimit_wrapper)
 SYSCALL(sys_mmap2,sys_mmap2,sys32_mmap2_wrapper)
 SYSCALL(sys_truncate64,sys_ni_syscall,sys32_truncate64_wrapper)
 SYSCALL(sys_ftruncate64,sys_ni_syscall,sys32_ftruncate64_wrapper)
@@ -257,9 +257,9 @@
 SYSCALL(sys_io_submit,sys_io_submit,sys_ni_syscall)
 SYSCALL(sys_io_cancel,sys_io_cancel,sys_ni_syscall)
 SYSCALL(sys_exit_group,sys_exit_group,sys32_exit_group_wrapper)
-SYSCALL(sys_epoll_create,sys_epoll_create,sys_ni_syscall)
-SYSCALL(sys_epoll_ctl,sys_epoll_ctl,sys_ni_syscall)		/* 250 */
-SYSCALL(sys_epoll_wait,sys_epoll_wait,sys_ni_syscall)
+SYSCALL(sys_epoll_create,sys_epoll_create,sys_epoll_create_wrapper)
+SYSCALL(sys_epoll_ctl,sys_epoll_ctl,sys_epoll_ctl_wrapper)	/* 250 */
+SYSCALL(sys_epoll_wait,sys_epoll_wait,sys_epoll_wait_wrapper)
 SYSCALL(sys_set_tid_address,sys_set_tid_address,sys32_set_tid_address_wrapper)
 SYSCALL(sys_fadvise64,sys_fadvise64,sys_ni_syscall)
 SYSCALL(sys_timer_create,sys_timer_create,sys_ni_syscall)
diff -urN linux-2.5/include/asm-s390/compat.h linux-2.5-s390/include/asm-s390/compat.h
--- linux-2.5/include/asm-s390/compat.h	Mon May  5 01:53:02 2003
+++ linux-2.5-s390/include/asm-s390/compat.h	Mon May 26 19:20:46 2003
@@ -4,6 +4,7 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/sched.h>
 
 #define COMPAT_USER_HZ	100
 
@@ -122,4 +123,14 @@
 	return (void *)(unsigned long)(uptr & 0x7fffffffUL);
 }
 
+static inline void *compat_alloc_user_space(long len)
+{
+	unsigned long stack;
+
+	stack = KSTK_ESP(current);
+	if (test_thread_flag(TIF_31BIT))
+		stack &= 0x7fffffffUL;
+	return (void *) (stack - len);
+}
+
 #endif /* _ASM_S390X_COMPAT_H */
diff -urN linux-2.5/include/linux/compat_ioctl.h linux-2.5-s390/include/linux/compat_ioctl.h
--- linux-2.5/include/linux/compat_ioctl.h	Mon May  5 01:53:42 2003
+++ linux-2.5-s390/include/linux/compat_ioctl.h	Mon May 26 19:20:46 2003
@@ -38,12 +38,14 @@
 COMPATIBLE_IOCTL(TIOCGPTN)
 COMPATIBLE_IOCTL(TIOCSPTLCK)
 COMPATIBLE_IOCTL(TIOCSERGETLSR)
+#ifdef CONFIG_FB
 /* Big F */
 COMPATIBLE_IOCTL(FBIOGET_VSCREENINFO)
 COMPATIBLE_IOCTL(FBIOPUT_VSCREENINFO)
 COMPATIBLE_IOCTL(FBIOPAN_DISPLAY)
 COMPATIBLE_IOCTL(FBIOGET_CON2FBMAP)
 COMPATIBLE_IOCTL(FBIOPUT_CON2FBMAP)
+#endif
 /* Little f */
 COMPATIBLE_IOCTL(FIOCLEX)
 COMPATIBLE_IOCTL(FIONCLEX)
@@ -65,6 +67,7 @@
 COMPATIBLE_IOCTL(HDIO_DRIVE_CMD)
 COMPATIBLE_IOCTL(HDIO_SET_PIO_MODE)
 COMPATIBLE_IOCTL(HDIO_SET_NICE)
+#ifndef CONFIG_ARCH_S390
 /* 0x02 -- Floppy ioctls */
 COMPATIBLE_IOCTL(FDMSGON)
 COMPATIBLE_IOCTL(FDMSGOFF)
@@ -82,6 +85,7 @@
 COMPATIBLE_IOCTL(FDTWADDLE)
 COMPATIBLE_IOCTL(FDFMTTRK)
 COMPATIBLE_IOCTL(FDRAWCMD)
+#endif
 /* 0x12 */
 COMPATIBLE_IOCTL(BLKROSET)
 COMPATIBLE_IOCTL(BLKROGET)
@@ -186,6 +190,7 @@
 COMPATIBLE_IOCTL(VT_RESIZEX)
 COMPATIBLE_IOCTL(VT_LOCKSWITCH)
 COMPATIBLE_IOCTL(VT_UNLOCKSWITCH)
+#if defined(CONFIG_VIDEO_DEV) || defined(CONFIG_VIDEO_DEV_MODULE)
 /* Little v */
 /* Little v, the video4linux ioctls (conflict?) */
 COMPATIBLE_IOCTL(VIDIOCGCAP)
@@ -212,6 +217,8 @@
 COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+5, int))
 COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+6, int))
 COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+7, int))
+#endif
+#if defined(CONFIG_RTC) || defined (CONFIG_RTC_MODULE)
 /* Little p (/dev/rtc, /dev/envctrl, etc.) */
 COMPATIBLE_IOCTL(RTC_AIE_ON)
 COMPATIBLE_IOCTL(RTC_AIE_OFF)
@@ -227,6 +234,7 @@
 COMPATIBLE_IOCTL(RTC_SET_TIME)
 COMPATIBLE_IOCTL(RTC_WKALM_SET)
 COMPATIBLE_IOCTL(RTC_WKALM_RD)
+#endif
 /* Little m */
 COMPATIBLE_IOCTL(MTIOCTOP)
 /* Socket level stuff */
@@ -278,6 +286,7 @@
 COMPATIBLE_IOCTL(SG_GET_REQUEST_TABLE)
 COMPATIBLE_IOCTL(SG_SET_KEEP_ORPHAN)
 COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
+#if defined(CONFIG_PPP) || defined(CONFIG_PPP_MODULE)
 /* PPP stuff */
 COMPATIBLE_IOCTL(PPPIOCGFLAGS)
 COMPATIBLE_IOCTL(PPPIOCSFLAGS)
@@ -311,6 +320,7 @@
 /* PPPOX */
 COMPATIBLE_IOCTL(PPPOEIOCSFWD)
 COMPATIBLE_IOCTL(PPPOEIOCDFWD)
+#endif
 /* LP */
 COMPATIBLE_IOCTL(LPGETSTATUS)
 /* CDROM stuff */
@@ -353,6 +363,7 @@
 COMPATIBLE_IOCTL(LOOP_CLR_FD)
 /* Big A */
 /* sparc only */
+#if defined(CONFIG_SOUND) || defined (CONFIG_SOUND_MODULE)
 /* Big Q for sound/OSS */
 COMPATIBLE_IOCTL(SNDCTL_SEQ_RESET)
 COMPATIBLE_IOCTL(SNDCTL_SEQ_SYNC)
@@ -507,6 +518,7 @@
 COMPATIBLE_IOCTL(SOUND_MIXER_GETLEVELS)
 COMPATIBLE_IOCTL(SOUND_MIXER_SETLEVELS)
 COMPATIBLE_IOCTL(OSS_GETVERSION)
+#endif
 /* AUTOFS */
 COMPATIBLE_IOCTL(AUTOFS_IOC_READY)
 COMPATIBLE_IOCTL(AUTOFS_IOC_FAIL)
@@ -523,6 +535,7 @@
 COMPATIBLE_IOCTL(RAW_GETBIND)
 /* SMB ioctls which do not need any translations */
 COMPATIBLE_IOCTL(SMB_IOC_NEWCONN)
+#if defined(CONFIG_ATM) || defined(CONFIG_ATM_MODULE)
 /* Little a */
 COMPATIBLE_IOCTL(ATMSIGD_CTRL)
 COMPATIBLE_IOCTL(ATMARPD_CTRL)
@@ -539,6 +552,7 @@
 COMPATIBLE_IOCTL(ATMTCP_REMOVE)
 COMPATIBLE_IOCTL(ATMMPC_CTRL)
 COMPATIBLE_IOCTL(ATMMPC_DATA)
+#endif
 #if defined(CONFIG_BLK_DEV_LVM) || defined(CONFIG_BLK_DEV_LVM_MODULE)
 /* 0xfe - lvm */
 COMPATIBLE_IOCTL(VG_SET_EXTENDABLE)
@@ -596,6 +610,7 @@
 COMPATIBLE_IOCTL(RNDADDENTROPY)
 COMPATIBLE_IOCTL(RNDZAPENTCNT)
 COMPATIBLE_IOCTL(RNDCLEARPOOL)
+#if defined(CONFIG_BT) || defined(CONFIG_BT_MODULE)
 /* Bluetooth ioctls */
 COMPATIBLE_IOCTL(HCIDEVUP)
 COMPATIBLE_IOCTL(HCIDEVDOWN)
@@ -615,6 +630,8 @@
 COMPATIBLE_IOCTL(HCISETACLMTU)
 COMPATIBLE_IOCTL(HCISETSCOMTU)
 COMPATIBLE_IOCTL(HCIINQUIRY)
+#endif
+#ifdef CONFIG_PCI
 /* Misc. */
 COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
 COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
@@ -622,6 +639,8 @@
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
+#endif
+#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
 /* USB */
 COMPATIBLE_IOCTL(USBDEVFS_RESETEP)
 COMPATIBLE_IOCTL(USBDEVFS_SETINTERFACE)
@@ -634,6 +653,8 @@
 COMPATIBLE_IOCTL(USBDEVFS_HUB_PORTINFO)
 COMPATIBLE_IOCTL(USBDEVFS_RESET)
 COMPATIBLE_IOCTL(USBDEVFS_CLEAR_HALT)
+#endif
+#if defined(CONFIG_MTD) || defined(CONFIG_MTD_MODULE)
 /* MTD */
 COMPATIBLE_IOCTL(MEMGETINFO)
 COMPATIBLE_IOCTL(MEMERASE)
@@ -641,6 +662,7 @@
 COMPATIBLE_IOCTL(MEMUNLOCK)
 COMPATIBLE_IOCTL(MEMGETREGIONCOUNT)
 COMPATIBLE_IOCTL(MEMGETREGIONINFO)
+#endif
 /* NBD */
 COMPATIBLE_IOCTL(NBD_SET_SOCK)
 COMPATIBLE_IOCTL(NBD_SET_BLKSIZE)
