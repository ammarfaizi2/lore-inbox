Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTJHQQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 12:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTJHQQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 12:16:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:51383 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261687AbTJHQPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 12:15:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup of compat_ioctl functions
Date: Wed, 8 Oct 2003 18:09:42 +0200
User-Agent: KMail/1.5.3
Cc: Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310081809.42859.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my reworked patch for cleaning up compat_ioctl, with the main
purpose of making it usable for s390. Every single change here should
be trivial, but there are a lot of them.

The changes are:

- audit all 32 bit pointer accesses and make them use compat_ioctl(),
  because of the necessary conversion on s390
- introduce ULONG_IOCTL() which is used instead of COMPATIBLE_IOCTL()
  for all ioctls that have their argument encoded in 'arg' instead
  of the memory pointed to by arg. Same reason as above.
- strictly use 'int h(unsigned, unsigned, unsigned long, struct file*)'
  prototypes for all handlers called from sys32_ioctl. Not required,
  but type checking is usually considered a good idea.
- mark (almost) all user space pointers with '__user' for use with
  sparse. This found one error in sg_build_iovec() where a user
  pointer is dereferenced.
- remove most #ifdefs in <linux/compat_ioctl.h>: They don't make
  any sense if the respective handlers in fs/compat_ioctl.c are
  not disabled as well and they are potentially harmful (the
  CONFIG_BLK_DEV_DM e.g. was insufficient).
- comment out  COMPATIBLE_IOCTL(SIOCSIFBR) and
  COMPATIBLE_IOCTL(SIOCGIFBR), they appear to require a handler

BTW: while auditing the COMPATIBLE_IOCTL list for possible uses of
direct argument passing, I found no real handler for these ioctls:

- SIOCSIFLINK, SIOCSRARP, SIOCGRARP, SIOCDRARP
- BLKSECTSET
- CLEAR_ARRAY, SET_DISK_INFO, WRITE_RAID_INFO, UNPROTECT_ARRAY, 
  PROTECT_ARRAY

Does anyone know whether they are all still needed or what happened
to them?

	Arnd <><

===== fs/compat_ioctl.c 1.10 vs edited =====
--- 1.10/fs/compat_ioctl.c	Sun Oct  5 10:08:05 2003
+++ edited/fs/compat_ioctl.c	Mon Oct  6 17:14:42 2003
@@ -119,7 +119,8 @@
 #define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
 #define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)
 
-static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int w_long(unsigned int fd, unsigned int cmd,
+		unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	int err;
@@ -128,28 +129,30 @@
 	set_fs (KERNEL_DS);
 	err = sys_ioctl(fd, cmd, (unsigned long)&val);
 	set_fs (old_fs);
-	if (!err && put_user(val, (u32 *)arg))
+	if (!err && put_user(val, (u32 __user *)compat_ptr(arg)))
 		return -EFAULT;
 	return err;
 }
  
-static int rw_long(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int rw_long(unsigned int fd, unsigned int cmd,
+		unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	int err;
 	unsigned long val;
 	
-	if(get_user(val, (u32 *)arg))
+	if(get_user(val, (u32 __user *) compat_ptr(arg)))
 		return -EFAULT;
 	set_fs (KERNEL_DS);
 	err = sys_ioctl(fd, cmd, (unsigned long)&val);
 	set_fs (old_fs);
-	if (!err && put_user(val, (u32 *)arg))
+	if (!err && put_user(val, (u32 __user *) compat_ptr(arg)))
 		return -EFAULT;
 	return err;
 }
 
-static int do_ext2_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_ext2_ioctl(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	/* These are just misnamed, they actually get/put from/to user an int */
 	switch (cmd) {
@@ -158,9 +161,9 @@
 	case EXT2_IOC32_GETVERSION: cmd = EXT2_IOC_GETVERSION; break;
 	case EXT2_IOC32_SETVERSION: cmd = EXT2_IOC_SETVERSION; break;
 	}
-	return sys_ioctl(fd, cmd, arg);
+	return sys_ioctl(fd, cmd, (unsigned long)compat_ptr(arg));
 }
- 
+
 struct video_tuner32 {
 	compat_int_t tuner;
 	char name[32];
@@ -169,7 +172,7 @@
 	u16 mode, signal;
 };
 
-static int get_video_tuner32(struct video_tuner *kp, struct video_tuner32 *up)
+static int get_video_tuner32(struct video_tuner *kp, struct video_tuner32 __user *up)
 {
 	int i;
 
@@ -185,7 +188,7 @@
 	return 0;
 }
 
-static int put_video_tuner32(struct video_tuner *kp, struct video_tuner32 *up)
+static int put_video_tuner32(struct video_tuner *kp, struct video_tuner32 __user *up)
 {
 	int i;
 
@@ -206,13 +209,13 @@
 	compat_int_t height, width, depth, bytesperline;
 };
 
-static int get_video_buffer32(struct video_buffer *kp, struct video_buffer32 *up)
+static int get_video_buffer32(struct video_buffer *kp, struct video_buffer32 __user *up)
 {
 	u32 tmp;
 
 	if(get_user(tmp, &up->base))
 		return -EFAULT;
-	kp->base = (void *) ((unsigned long)tmp);
+	kp->base = compat_ptr(tmp);
 	__get_user(kp->height, &up->height);
 	__get_user(kp->width, &up->width);
 	__get_user(kp->depth, &up->depth);
@@ -220,7 +223,7 @@
 	return 0;
 }
 
-static int put_video_buffer32(struct video_buffer *kp, struct video_buffer32 *up)
+static int put_video_buffer32(struct video_buffer *kp, struct video_buffer32 __user *up)
 {
 	u32 tmp = (u32)((unsigned long)kp->base);
 
@@ -253,9 +256,9 @@
 		kfree(cp);
 }
 
-static int get_video_window32(struct video_window *kp, struct video_window32 *up)
+static int get_video_window32(struct video_window *kp, struct video_window32 __user *up)
 {
-	struct video_clip32 *ucp;
+	struct video_clip32 __user *ucp;
 	struct video_clip *kcp;
 	int nclips, err, i;
 	u32 tmp;
@@ -305,7 +308,7 @@
 }
 
 /* You get back everything except the clips... */
-static int put_video_window32(struct video_window *kp, struct video_window32 *up)
+static int put_video_window32(struct video_window *kp, struct video_window32 __user *up)
 {
 	if(put_user(kp->x, &up->x))
 		return -EFAULT;
@@ -327,7 +330,8 @@
 #define VIDIOCGFREQ32		_IOR('v',14, u32)
 #define VIDIOCSFREQ32		_IOW('v',15, u32)
 
-static int do_video_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_video_ioctl(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	union {
 		struct video_tuner vt;
@@ -336,7 +340,7 @@
 		unsigned long vx;
 	} karg;
 	mm_segment_t old_fs = get_fs();
-	void *up = (void *)arg;
+	void __user *up = compat_ptr(arg);
 	int err = 0;
 
 	/* First, convert the command. */
@@ -366,7 +370,7 @@
 		break;
 
 	case VIDIOCSFREQ:
-		err = get_user(karg.vx, (u32 *)up);
+		err = get_user(karg.vx, (u32 __user *)up);
 		break;
 	};
 	if(err)
@@ -402,9 +406,10 @@
 	return err;
 }
 
-static int do_siocgstamp(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_siocgstamp(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
-	struct compat_timeval *up = (struct compat_timeval *)arg;
+	struct compat_timeval __user *up = compat_ptr(arg);
 	struct timeval ktv;
 	mm_segment_t old_fs = get_fs();
 	int err;
@@ -457,13 +462,16 @@
 };
 
 #ifdef CONFIG_NET
-static int dev_ifname32(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int dev_ifname32(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	struct net_device *dev;
 	struct ifreq32 ifr32;
+	struct ifreq32 __user *uifr32;
 	int err;
 
-	if (copy_from_user(&ifr32, (struct ifreq32 *)arg, sizeof(struct ifreq32)))
+	uifr32 = compat_ptr(arg);
+	if (copy_from_user(&ifr32, uifr32, sizeof(ifr32)))
 		return -EFAULT;
 
 	dev = dev_get_by_index(ifr32.ifr_ifindex);
@@ -473,22 +481,25 @@
 	strlcpy(ifr32.ifr_name, dev->name, sizeof(ifr32.ifr_name));
 	dev_put(dev);
 	
-	err = copy_to_user((struct ifreq32 *)arg, &ifr32, sizeof(struct ifreq32));
+	err = copy_to_user(uifr32, &ifr32, sizeof(ifr32));
 	return (err ? -EFAULT : 0);
 }
 #endif
 
-static int dev_ifconf(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int dev_ifconf(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
+	struct ifconf32 __user *uifc32;
 	struct ifconf32 ifc32;
 	struct ifconf ifc;
-	struct ifreq32 *ifr32;
+	struct ifreq32 __user *ifr32;
 	struct ifreq *ifr;
 	mm_segment_t old_fs;
 	unsigned int i, j;
 	int err;
 
-	if (copy_from_user(&ifc32, (struct ifconf32 *)arg, sizeof(struct ifconf32)))
+	uifc32 = compat_ptr(arg);
+	if (copy_from_user(&ifc32, uifc32, sizeof(ifc32)))
 		return -EFAULT;
 
 	if(ifc32.ifcbuf == 0) {
@@ -498,6 +509,7 @@
 	} else {
 		ifc.ifc_len = ((ifc32.ifc_len / sizeof (struct ifreq32)) + 1) *
 			sizeof (struct ifreq);
+		/* should the size be limited? -arnd */
 		ifc.ifc_buf = kmalloc (ifc.ifc_len, GFP_KERNEL);
 		if (!ifc.ifc_buf)
 			return -ENOMEM;
@@ -543,7 +555,7 @@
 				else
 					ifc32.ifc_len = i - sizeof (struct ifreq32);
 			}
-			if (copy_to_user((struct ifconf32 *)arg, &ifc32, sizeof(struct ifconf32)))
+			if (copy_to_user(uifc32, &ifc32, sizeof(ifc32)))
 				err = -EFAULT;
 		}
 	}
@@ -552,15 +564,16 @@
 	return err;
 }
 
-static int ethtool_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int ethtool_ioctl(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
-	struct ifreq *ifr;
-	struct ifreq32 *ifr32;
+	struct ifreq __user *ifr;
+	struct ifreq32 __user *ifr32;
 	u32 data;
-	void *datap;
+	void __user *datap;
 	
 	ifr = compat_alloc_user_space(sizeof(*ifr));
-	ifr32 = (struct ifreq32 *) arg;
+	ifr32 = compat_ptr(arg);
 
 	if (copy_in_user(&ifr->ifr_name, &ifr32->ifr_name, IFNAMSIZ))
 		return -EFAULT;
@@ -568,22 +581,23 @@
 	if (get_user(data, &ifr32->ifr_ifru.ifru_data))
 		return -EFAULT;
 
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &ifr->ifr_ifru.ifru_data))
 		return -EFAULT;
 
 	return sys_ioctl(fd, cmd, (unsigned long) ifr);
 }
 
-static int bond_ioctl(unsigned long fd, unsigned int cmd, unsigned long arg)
+static int bond_ioctl(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	struct ifreq kifr;
-	struct ifreq *uifr;
-	struct ifreq32 *ifr32 = (struct ifreq32 *) arg;
+	struct ifreq __user *uifr;
+	struct ifreq32 __user *ifr32 = compat_ptr(arg);
 	mm_segment_t old_fs;
 	int err;
 	u32 data;
-	void *datap;
+	void __user *datap;
 
 	switch (cmd) {
 	case SIOCBONDENSLAVE:
@@ -618,12 +632,13 @@
 	};
 }
 
-int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
-	struct ifreq *u_ifreq64;
-	struct ifreq32 *u_ifreq32 = (struct ifreq32 *) arg;
+	struct ifreq __user *u_ifreq64;
+	struct ifreq32 __user *u_ifreq32 = compat_ptr(arg);
 	char tmp_buf[IFNAMSIZ];
-	void *data64;
+	void __user *data64;
 	u32 data32;
 
 	if (copy_from_user(&tmp_buf[0], &(u_ifreq32->ifr_ifrn.ifrn_name[0]),
@@ -644,26 +659,31 @@
 	return sys_ioctl(fd, cmd, (unsigned long) u_ifreq64);
 }
 
-static int dev_ifsioc(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int dev_ifsioc(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	struct ifreq ifr;
+	struct ifreq32 __user *uifr32;
+	struct ifmap32 __user *uifmap32;
 	mm_segment_t old_fs;
 	int err;
 	
+	uifr32 = compat_ptr(arg);
+	uifmap32 = &uifr32->ifr_ifru.ifru_map;
 	switch (cmd) {
 	case SIOCSIFMAP:
-		err = copy_from_user(&ifr, (struct ifreq32 *)arg, sizeof(ifr.ifr_name));
-		err |= __get_user(ifr.ifr_map.mem_start, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.mem_start));
-		err |= __get_user(ifr.ifr_map.mem_end, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.mem_end));
-		err |= __get_user(ifr.ifr_map.base_addr, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.base_addr));
-		err |= __get_user(ifr.ifr_map.irq, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.irq));
-		err |= __get_user(ifr.ifr_map.dma, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.dma));
-		err |= __get_user(ifr.ifr_map.port, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.port));
+		err = copy_from_user(&ifr, uifr32, sizeof(ifr.ifr_name));
+		err |= __get_user(ifr.ifr_map.mem_start, &uifmap32->mem_start);
+		err |= __get_user(ifr.ifr_map.mem_end, &uifmap32->mem_end);
+		err |= __get_user(ifr.ifr_map.base_addr, &uifmap32->base_addr);
+		err |= __get_user(ifr.ifr_map.irq, &uifmap32->irq);
+		err |= __get_user(ifr.ifr_map.dma, &uifmap32->dma);
+		err |= __get_user(ifr.ifr_map.port, &uifmap32->port);
 		if (err)
 			return -EFAULT;
 		break;
 	default:
-		if (copy_from_user(&ifr, (struct ifreq32 *)arg, sizeof(struct ifreq32)))
+		if (copy_from_user(&ifr, uifr32, sizeof(*uifr32)))
 			return -EFAULT;
 		break;
 	}
@@ -684,17 +704,17 @@
 		case SIOCGIFDSTADDR:
 		case SIOCGIFNETMASK:
 		case SIOCGIFTXQLEN:
-			if (copy_to_user((struct ifreq32 *)arg, &ifr, sizeof(struct ifreq32)))
+			if (copy_to_user(uifr32, &ifr, sizeof(*uifr32)))
 				return -EFAULT;
 			break;
 		case SIOCGIFMAP:
-			err = copy_to_user((struct ifreq32 *)arg, &ifr, sizeof(ifr.ifr_name));
-			err |= __put_user(ifr.ifr_map.mem_start, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.mem_start));
-			err |= __put_user(ifr.ifr_map.mem_end, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.mem_end));
-			err |= __put_user(ifr.ifr_map.base_addr, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.base_addr));
-			err |= __put_user(ifr.ifr_map.irq, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.irq));
-			err |= __put_user(ifr.ifr_map.dma, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.dma));
-			err |= __put_user(ifr.ifr_map.port, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_map.port));
+			err = copy_to_user(uifr32, &ifr, sizeof(ifr.ifr_name));
+			err |= __put_user(ifr.ifr_map.mem_start, &uifmap32->mem_start);
+			err |= __put_user(ifr.ifr_map.mem_end, &uifmap32->mem_end);
+			err |= __put_user(ifr.ifr_map.base_addr, &uifmap32->base_addr);
+			err |= __put_user(ifr.ifr_map.irq, &uifmap32->irq);
+			err |= __put_user(ifr.ifr_map.dma, &uifmap32->dma);
+			err |= __put_user(ifr.ifr_map.port, &uifmap32->port);
 			if (err)
 				err = -EFAULT;
 			break;
@@ -735,7 +755,8 @@
 	s32			rtmsg_ifindex;
 };
 
-static int routing_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int routing_ioctl(unsigned int fd, unsigned int cmd,
+			 unsigned long arg, struct file *f)
 {
 	int ret;
 	void *r = NULL;
@@ -748,25 +769,28 @@
 	struct socket *mysock = sockfd_lookup(fd, &ret);
 
 	if (mysock && mysock->sk && mysock->sk->sk_family == AF_INET6) { /* ipv6 */
-		ret = copy_from_user (&r6.rtmsg_dst, &(((struct in6_rtmsg32 *)arg)->rtmsg_dst),
+		struct in6_rtmsg32 __user *ur6 = compat_ptr(arg);
+		ret = copy_from_user (&r6.rtmsg_dst, &(ur6->rtmsg_dst),
 			3 * sizeof(struct in6_addr));
-		ret |= __get_user (r6.rtmsg_type, &(((struct in6_rtmsg32 *)arg)->rtmsg_type));
-		ret |= __get_user (r6.rtmsg_dst_len, &(((struct in6_rtmsg32 *)arg)->rtmsg_dst_len));
-		ret |= __get_user (r6.rtmsg_src_len, &(((struct in6_rtmsg32 *)arg)->rtmsg_src_len));
-		ret |= __get_user (r6.rtmsg_metric, &(((struct in6_rtmsg32 *)arg)->rtmsg_metric));
-		ret |= __get_user (r6.rtmsg_info, &(((struct in6_rtmsg32 *)arg)->rtmsg_info));
-		ret |= __get_user (r6.rtmsg_flags, &(((struct in6_rtmsg32 *)arg)->rtmsg_flags));
-		ret |= __get_user (r6.rtmsg_ifindex, &(((struct in6_rtmsg32 *)arg)->rtmsg_ifindex));
+		ret |= __get_user (r6.rtmsg_type, &(ur6->rtmsg_type));
+		ret |= __get_user (r6.rtmsg_dst_len, &(ur6->rtmsg_dst_len));
+		ret |= __get_user (r6.rtmsg_src_len, &(ur6->rtmsg_src_len));
+		ret |= __get_user (r6.rtmsg_metric, &(ur6->rtmsg_metric));
+		ret |= __get_user (r6.rtmsg_info, &(ur6->rtmsg_info));
+		ret |= __get_user (r6.rtmsg_flags, &(ur6->rtmsg_flags));
+		ret |= __get_user (r6.rtmsg_ifindex, &(ur6->rtmsg_ifindex));
 		
 		r = (void *) &r6;
 	} else { /* ipv4 */
-		ret = copy_from_user (&r4.rt_dst, &(((struct rtentry32 *)arg)->rt_dst), 3 * sizeof(struct sockaddr));
-		ret |= __get_user (r4.rt_flags, &(((struct rtentry32 *)arg)->rt_flags));
-		ret |= __get_user (r4.rt_metric, &(((struct rtentry32 *)arg)->rt_metric));
-		ret |= __get_user (r4.rt_mtu, &(((struct rtentry32 *)arg)->rt_mtu));
-		ret |= __get_user (r4.rt_window, &(((struct rtentry32 *)arg)->rt_window));
-		ret |= __get_user (r4.rt_irtt, &(((struct rtentry32 *)arg)->rt_irtt));
-		ret |= __get_user (rtdev, &(((struct rtentry32 *)arg)->rt_dev));
+		struct rtentry32 __user *ur4 = compat_ptr(arg);
+		ret = copy_from_user (&r4.rt_dst, &(ur4->rt_dst),
+					3 * sizeof(struct sockaddr));
+		ret |= __get_user (r4.rt_flags, &(ur4->rt_flags));
+		ret |= __get_user (r4.rt_metric, &(ur4->rt_metric));
+		ret |= __get_user (r4.rt_mtu, &(ur4->rt_mtu));
+		ret |= __get_user (r4.rt_window, &(ur4->rt_window));
+		ret |= __get_user (r4.rt_irtt, &(ur4->rt_irtt));
+		ret |= __get_user (rtdev, &(ur4->rt_dev));
 		if (rtdev) {
 			ret |= copy_from_user (devname, compat_ptr(rtdev), 15);
 			r4.rt_dev = devname; devname[15] = 0;
@@ -780,7 +804,7 @@
 		return -EFAULT;
 
 	set_fs (KERNEL_DS);
-	ret = sys_ioctl (fd, cmd, (long) r);
+	ret = sys_ioctl (fd, cmd, (unsigned long) r);
 	set_fs (old_fs);
 
 	if (mysock)
@@ -796,18 +820,21 @@
 	u32 start;
 };
                         
-static int hdio_getgeo(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int hdio_getgeo(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	struct hd_geometry geo;
+	struct hd_geometry32 __user *ugeo;
 	int err;
 	
 	set_fs (KERNEL_DS);
 	err = sys_ioctl(fd, HDIO_GETGEO, (unsigned long)&geo);
 	set_fs (old_fs);
+	ugeo = compat_ptr(arg);
 	if (!err) {
-		err = copy_to_user ((struct hd_geometry32 *)arg, &geo, 4);
-		err |= __put_user (geo.start, &(((struct hd_geometry32 *)arg)->start));
+		err = copy_to_user (ugeo, &geo, 4);
+		err |= __put_user (geo.start, &ugeo->start);
 	}
 	return err ? -EFAULT : 0;
 }
@@ -838,14 +865,14 @@
 	compat_caddr_t	transp;
 };
 
-static int do_cmap_ptr(__u16 **ptr64, __u32 *ptr32)
+static int do_cmap_ptr(__u16 __user **ptr64, __u32 __user *ptr32)
 {
 	__u32 data;
-	void *datap;
+	void __user *datap;
 
 	if (get_user(data, ptr32))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, ptr64))
 		return -EFAULT;
 	return 0;
@@ -853,12 +880,12 @@
 
 static int fb_getput_cmap(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct fb_cmap *cmap;
-	struct fb_cmap32 *cmap32;
+	struct fb_cmap __user *cmap;
+	struct fb_cmap32 __user *cmap32;
 	int err;
 
 	cmap = compat_alloc_user_space(sizeof(*cmap));
-	cmap32 = (struct fb_cmap32 *) arg;
+	cmap32 = compat_ptr(arg);
 
 	if (copy_in_user(&cmap->start, &cmap32->start, 2 * sizeof(__u32)))
 		return -EFAULT;
@@ -881,7 +908,7 @@
 }
 
 static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
-				  struct fb_fix_screeninfo32 *fix32)
+				  struct fb_fix_screeninfo32 __user *fix32)
 {
 	__u32 data;
 	int err;
@@ -915,10 +942,10 @@
 {
 	mm_segment_t old_fs;
 	struct fb_fix_screeninfo fix;
-	struct fb_fix_screeninfo32 *fix32;
+	struct fb_fix_screeninfo32 __user *fix32;
 	int err;
 
-	fix32 = (struct fb_fix_screeninfo32 *) arg;
+	fix32 = compat_ptr(arg);
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -931,7 +958,8 @@
 	return err;
 }
 
-static int fb_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int fb_ioctl_trans(unsigned int fd, unsigned int cmd,
+		unsigned long arg, struct file *f)
 {
 	int err;
 
@@ -960,19 +988,20 @@
 	return err;
 }
 
-static int hdio_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int hdio_ioctl_trans(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	unsigned long kval;
-	unsigned int *uvp;
+	unsigned int __user *uvp;
 	int error;
 
 	set_fs(KERNEL_DS);
-	error = sys_ioctl(fd, cmd, (long)&kval);
+	error = sys_ioctl(fd, cmd, (unsigned long)&kval);
 	set_fs(old_fs);
 
 	if(error == 0) {
-		uvp = (unsigned int *)arg;
+		uvp = compat_ptr(arg);
 		if(put_user(kval, uvp))
 			error = -EFAULT;
 	}
@@ -1011,10 +1040,11 @@
 	compat_uint_t iov_len;
 } sg_iovec32_t;
 
-static int sg_build_iovec(sg_io_hdr_t *sgio, void *dxferp, u16 iovec_count)
+static int sg_build_iovec(sg_io_hdr_t __user *sgio, void __user *dxferp,
+			u16 iovec_count)
 {
-	sg_iovec_t *iov = (sg_iovec_t *) (sgio + 1);
-	sg_iovec32_t *iov32 = dxferp;
+	sg_iovec_t __user *iov = (sg_iovec_t __user *) (sgio + 1);
+	sg_iovec32_t __user *iov32 = dxferp;
 	int i;
 
 	for (i = 0; i < iovec_count; i++) {
@@ -1022,30 +1052,32 @@
 
 		if (get_user(base, &iov32[i].iov_base) ||
 		    get_user(len, &iov32[i].iov_len) ||
-		    put_user((void *)(unsigned long)base, &iov[i].iov_base) ||
+		    put_user(compat_ptr(base), &iov[i].iov_base) ||
 		    put_user(len, &iov[i].iov_len))
 			return -EFAULT;
 	}
 
-	sgio->dxferp = iov;
+	sgio->dxferp = iov; /* FIXME: dereferencing user pointer? */
 	return 0;
 }
 
-static int sg_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int sg_ioctl_trans(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
-	sg_io_hdr_t *sgio;
-	sg_io_hdr32_t *sgio32;
+	sg_io_hdr_t __user *sgio;
+	sg_io_hdr32_t __user *sgio32;
 	u16 iovec_count;
 	u32 data;
-	void *dxferp;
+	void __user *dxferp;
 	int err;
 
-	sgio32 = (sg_io_hdr32_t *) arg;
+	sgio32 = compat_ptr(arg);
 	if (get_user(iovec_count, &sgio32->iovec_count))
 		return -EFAULT;
 
 	{
-		void *new, *top;
+		void __user *new;
+		void __user *top;
 
 		top = compat_alloc_user_space(0);
 		new = compat_alloc_user_space(sizeof(sg_io_hdr_t) +
@@ -1067,7 +1099,7 @@
 
 	if (get_user(data, &sgio32->dxferp))
 		return -EFAULT;
-	dxferp = (void *) (unsigned long) data;
+	dxferp = compat_ptr(data);
 	if (iovec_count) {
 		if (sg_build_iovec(sgio, dxferp, iovec_count))
 			return -EFAULT;
@@ -1077,15 +1109,16 @@
 	}
 
 	{
-		unsigned char *cmdp, *sbp;
+		unsigned char __user *cmdp;
+		unsigned char __user *sbp;
 
 		if (get_user(data, &sgio32->cmdp))
 			return -EFAULT;
-		cmdp = (unsigned char *) (unsigned long) data;
+		cmdp = compat_ptr(data);
 
 		if (get_user(data, &sgio32->sbp))
 			return -EFAULT;
-		sbp = (unsigned char *) (unsigned long) data;
+		sbp = compat_ptr(data);
 
 		if (put_user(cmdp, &sgio->cmdp) ||
 		    put_user(sbp, &sgio->sbp))
@@ -1098,7 +1131,7 @@
 
 	if (get_user(data, &sgio32->usr_ptr))
 		return -EFAULT;
-	if (put_user((void *)(unsigned long)data, &sgio->usr_ptr))
+	if (put_user(compat_ptr(data), &sgio->usr_ptr))
 		return -EFAULT;
 
 	if (copy_in_user(&sgio->status, &sgio32->status,
@@ -1110,7 +1143,7 @@
 	err = sys_ioctl(fd, cmd, (unsigned long) sgio);
 
 	if (err >= 0) {
-		void *datap;
+		void __user *datap;
 
 		if (copy_in_user(&sgio32->pack_id, &sgio->pack_id,
 				 sizeof(int)) ||
@@ -1135,14 +1168,18 @@
 #define PPPIOCSPASS32	_IOW('t', 71, struct sock_fprog32)
 #define PPPIOCSACTIVE32	_IOW('t', 70, struct sock_fprog32)
 
-static int ppp_sock_fprog_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int ppp_sock_fprog_ioctl_trans(unsigned int fd, unsigned int cmd,
+					unsigned long arg, struct file *f)
 {
-	struct sock_fprog32 *u_fprog32 = (struct sock_fprog32 *) arg;
-	struct sock_fprog *u_fprog64 = compat_alloc_user_space(sizeof(struct sock_fprog));
-	void *fptr64;
+	struct sock_fprog32 __user *u_fprog32;
+	struct sock_fprog __user *u_fprog64;
+	void __user *fptr64;
 	u32 fptr32;
 	u16 flen;
 
+	u_fprog32 = compat_ptr(arg);
+	u_fprog64 = compat_alloc_user_space(sizeof(struct sock_fprog));
+
 	if (get_user(flen, &u_fprog32->len) ||
 	    get_user(fptr32, &u_fprog32->filter))
 		return -EFAULT;
@@ -1174,15 +1211,14 @@
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
-static int ppp_gidle(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int ppp_gidle(unsigned int fd, unsigned int cmd,
+			struct ppp_idle32 __user *idle32)
 {
-	struct ppp_idle *idle;
-	struct ppp_idle32 *idle32;
+	struct ppp_idle __user *idle;
 	__kernel_time_t xmit, recv;
 	int err;
 
 	idle = compat_alloc_user_space(sizeof(*idle));
-	idle32 = (struct ppp_idle32 *) arg;
 
 	err = sys_ioctl(fd, PPPIOCGIDLE, (unsigned long) idle);
 
@@ -1196,20 +1232,19 @@
 	return err;
 }
 
-static int ppp_scompress(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int ppp_scompress(unsigned int fd, unsigned int cmd,
+			struct ppp_option_data32 __user *odata32)
 {
-	struct ppp_option_data *odata;
-	struct ppp_option_data32 *odata32;
+	struct ppp_option_data __user *odata;
 	__u32 data;
-	void *datap;
+	void __user *datap;
 
 	odata = compat_alloc_user_space(sizeof(*odata));
-	odata32 = (struct ppp_option_data32 *) arg;
 
 	if (get_user(data, &odata32->ptr))
 		return -EFAULT;
 
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &odata->ptr))
 		return -EFAULT;
 
@@ -1220,17 +1255,18 @@
 	return sys_ioctl(fd, PPPIOCSCOMPRESS, (unsigned long) odata);
 }
 
-static int ppp_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int ppp_ioctl_trans(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	int err;
 
 	switch (cmd) {
 	case PPPIOCGIDLE32:
-		err = ppp_gidle(fd, cmd, arg);
+		err = ppp_gidle(fd, cmd, compat_ptr(arg));
 		break;
 
 	case PPPIOCSCOMPRESS32:
-		err = ppp_scompress(fd, cmd, arg);
+		err = ppp_scompress(fd, cmd, compat_ptr(arg));
 		break;
 
 	default:
@@ -1248,7 +1284,6 @@
 	return err;
 }
 
-
 struct mtget32 {
 	compat_long_t	mt_type;
 	compat_long_t	mt_resid;
@@ -1289,12 +1324,16 @@
 #define	MTIOCGETCONFIG32	_IOR('m', 4, struct mtconfiginfo32)
 #define	MTIOCSETCONFIG32	_IOW('m', 5, struct mtconfiginfo32)
 
-static int mt_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int mt_ioctl_trans(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	struct mtconfiginfo info;
+	struct mtconfiginfo32 __user *uinfo32;
 	struct mtget get;
+	struct mtget32 __user *umget32;
 	struct mtpos pos;
+	struct mtpos32 __user *upos32;
 	unsigned long kcmd;
 	void *karg;
 	int err = 0;
@@ -1315,15 +1354,17 @@
 	case MTIOCSETCONFIG32:
 		kcmd = MTIOCSETCONFIG;
 		karg = &info;
-		err = __get_user(info.mt_type, &((struct mtconfiginfo32 *)arg)->mt_type);
-		err |= __get_user(info.ifc_type, &((struct mtconfiginfo32 *)arg)->ifc_type);
-		err |= __get_user(info.irqnr, &((struct mtconfiginfo32 *)arg)->irqnr);
-		err |= __get_user(info.dmanr, &((struct mtconfiginfo32 *)arg)->dmanr);
-		err |= __get_user(info.port, &((struct mtconfiginfo32 *)arg)->port);
-		err |= __get_user(info.debug, &((struct mtconfiginfo32 *)arg)->debug);
-		err |= __copy_from_user((char *)&info.debug + sizeof(info.debug),
-				     (char *)&((struct mtconfiginfo32 *)arg)->debug
-				     + sizeof(((struct mtconfiginfo32 *)arg)->debug), sizeof(__u32));
+		uinfo32 = compat_ptr(arg);
+		err = __get_user(info.mt_type, &uinfo32->mt_type);
+		err |= __get_user(info.ifc_type, &uinfo32->ifc_type);
+		err |= __get_user(info.irqnr, &uinfo32->irqnr);
+		err |= __get_user(info.dmanr, &uinfo32->dmanr);
+		err |= __get_user(info.port, &uinfo32->port);
+		err |= __get_user(info.debug, &uinfo32->debug);
+		err |= __copy_from_user((char *)&info.debug
+				     + sizeof(info.debug),
+				     (char __user *)&uinfo32->debug
+				     + sizeof(uinfo32->debug), sizeof(__u32));
 		if (err)
 			return -EFAULT;
 		break;
@@ -1344,26 +1385,29 @@
 		return err;
 	switch (cmd) {
 	case MTIOCPOS32:
-		err = __put_user(pos.mt_blkno, &((struct mtpos32 *)arg)->mt_blkno);
+		upos32 = compat_ptr(arg);
+		err = __put_user(pos.mt_blkno, &upos32->mt_blkno);
 		break;
 	case MTIOCGET32:
-		err = __put_user(get.mt_type, &((struct mtget32 *)arg)->mt_type);
-		err |= __put_user(get.mt_resid, &((struct mtget32 *)arg)->mt_resid);
-		err |= __put_user(get.mt_dsreg, &((struct mtget32 *)arg)->mt_dsreg);
-		err |= __put_user(get.mt_gstat, &((struct mtget32 *)arg)->mt_gstat);
-		err |= __put_user(get.mt_erreg, &((struct mtget32 *)arg)->mt_erreg);
-		err |= __put_user(get.mt_fileno, &((struct mtget32 *)arg)->mt_fileno);
-		err |= __put_user(get.mt_blkno, &((struct mtget32 *)arg)->mt_blkno);
+		umget32 = compat_ptr(arg);
+		err = __put_user(get.mt_type, &umget32->mt_type);
+		err |= __put_user(get.mt_resid, &umget32->mt_resid);
+		err |= __put_user(get.mt_dsreg, &umget32->mt_dsreg);
+		err |= __put_user(get.mt_gstat, &umget32->mt_gstat);
+		err |= __put_user(get.mt_erreg, &umget32->mt_erreg);
+		err |= __put_user(get.mt_fileno, &umget32->mt_fileno);
+		err |= __put_user(get.mt_blkno, &umget32->mt_blkno);
 		break;
 	case MTIOCGETCONFIG32:
-		err = __put_user(info.mt_type, &((struct mtconfiginfo32 *)arg)->mt_type);
-		err |= __put_user(info.ifc_type, &((struct mtconfiginfo32 *)arg)->ifc_type);
-		err |= __put_user(info.irqnr, &((struct mtconfiginfo32 *)arg)->irqnr);
-		err |= __put_user(info.dmanr, &((struct mtconfiginfo32 *)arg)->dmanr);
-		err |= __put_user(info.port, &((struct mtconfiginfo32 *)arg)->port);
-		err |= __put_user(info.debug, &((struct mtconfiginfo32 *)arg)->debug);
-		err |= __copy_to_user((char *)&((struct mtconfiginfo32 *)arg)->debug
-			    		   + sizeof(((struct mtconfiginfo32 *)arg)->debug),
+		uinfo32 = compat_ptr(arg);
+		err = __put_user(info.mt_type, &uinfo32->mt_type);
+		err |= __put_user(info.ifc_type, &uinfo32->ifc_type);
+		err |= __put_user(info.irqnr, &uinfo32->irqnr);
+		err |= __put_user(info.dmanr, &uinfo32->dmanr);
+		err |= __put_user(info.port, &uinfo32->port);
+		err |= __put_user(info.debug, &uinfo32->debug);
+		err |= __copy_to_user((char __user *)&uinfo32->debug
+			    		   + sizeof(uinfo32->debug),
 					   (char *)&info.debug + sizeof(info.debug), sizeof(__u32));
 		break;
 	case MTIOCSETCONFIG32:
@@ -1391,15 +1435,14 @@
 	compat_caddr_t	reserved[1];
 };
   
-static int cdrom_do_read_audio(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int cdrom_do_read_audio(unsigned int fd, unsigned int cmd,
+			struct cdrom_read_audio32 __user *cdread_audio32)
 {
-	struct cdrom_read_audio *cdread_audio;
-	struct cdrom_read_audio32 *cdread_audio32;
+	struct cdrom_read_audio __user *cdread_audio;
 	__u32 data;
-	void *datap;
+	void __user *datap;
 
 	cdread_audio = compat_alloc_user_space(sizeof(*cdread_audio));
-	cdread_audio32 = (struct cdrom_read_audio32 *) arg;
 
 	if (copy_in_user(&cdread_audio->addr,
 			 &cdread_audio32->addr,
@@ -1409,41 +1452,40 @@
 
 	if (get_user(data, &cdread_audio32->buf))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &cdread_audio->buf))
 		return -EFAULT;
 
 	return sys_ioctl(fd, cmd, (unsigned long) cdread_audio);
 }
 
-static int __cgc_do_ptr(void **ptr64, __u32 *ptr32)
+static int __cgc_do_ptr(void __user **ptr64, __u32 __user *ptr32)
 {
 	u32 data;
-	void *datap;
+	void __user *datap;
 
 	if (get_user(data, ptr32))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, ptr64))
 		return -EFAULT;
 
 	return 0;
 }
 
-static int cdrom_do_generic_command(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int cdrom_do_generic_command(unsigned int fd, unsigned int cmd,
+				struct cdrom_generic_command32 __user *cgc32)
 {
-	struct cdrom_generic_command *cgc;
-	struct cdrom_generic_command32 *cgc32;
+	struct cdrom_generic_command __user *cgc;
 	unsigned char dir;
 
 	cgc = compat_alloc_user_space(sizeof(*cgc));
-	cgc32 = (struct cdrom_generic_command32 *) arg;
 
 	if (copy_in_user(&cgc->cmd, &cgc32->cmd, sizeof(cgc->cmd)) ||
-	    __cgc_do_ptr((void **) &cgc->buffer, &cgc32->buffer) ||
+	    __cgc_do_ptr((void __user **) &cgc->buffer, &cgc32->buffer) ||
 	    copy_in_user(&cgc->buflen, &cgc32->buflen,
 			 (sizeof(unsigned int) + sizeof(int))) ||
-	    __cgc_do_ptr((void **) &cgc->sense, &cgc32->sense))
+	    __cgc_do_ptr((void __user **) &cgc->sense, &cgc32->sense))
 		return -EFAULT;
 
 	if (get_user(dir, &cgc->data_direction) ||
@@ -1460,17 +1502,18 @@
 	return sys_ioctl(fd, cmd, (unsigned long) cgc);
 }
 
-static int cdrom_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int cdrom_ioctl_trans(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	int err;
 
 	switch(cmd) {
 	case CDROMREADAUDIO:
-		err = cdrom_do_read_audio(fd, cmd, arg);
+		err = cdrom_do_read_audio(fd, cmd, compat_ptr(arg));
 		break;
 
 	case CDROM_SEND_PACKET:
-		err = cdrom_do_generic_command(fd, cmd, arg);
+		err = cdrom_do_generic_command(fd, cmd, compat_ptr(arg));
 		break;
 
 	default:
@@ -1503,20 +1546,23 @@
 	char		reserved[4];
 };
 
-static int loop_status(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int loop_status(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	struct loop_info l;
+	struct loop_info32 __user *ul;
 	int err = -EINVAL;
 
+	ul = compat_ptr(arg);
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = get_user(l.lo_number, &((struct loop_info32 *)arg)->lo_number);
-		err |= __get_user(l.lo_device, &((struct loop_info32 *)arg)->lo_device);
-		err |= __get_user(l.lo_inode, &((struct loop_info32 *)arg)->lo_inode);
-		err |= __get_user(l.lo_rdevice, &((struct loop_info32 *)arg)->lo_rdevice);
-		err |= __copy_from_user((char *)&l.lo_offset, (char *)&((struct loop_info32 *)arg)->lo_offset,
-					   8 + (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+		err = get_user(l.lo_number, &ul->lo_number);
+		err |= __get_user(l.lo_device, &ul->lo_device);
+		err |= __get_user(l.lo_inode, &ul->lo_inode);
+		err |= __get_user(l.lo_rdevice, &ul->lo_rdevice);
+		err |= __copy_from_user(&l.lo_offset, &ul->lo_offset,
+		        8 + (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
 		if (err) {
 			err = -EFAULT;
 		} else {
@@ -1530,12 +1576,12 @@
 		err = sys_ioctl (fd, cmd, (unsigned long)&l);
 		set_fs (old_fs);
 		if (!err) {
-			err = put_user(l.lo_number, &((struct loop_info32 *)arg)->lo_number);
-			err |= __put_user(l.lo_device, &((struct loop_info32 *)arg)->lo_device);
-			err |= __put_user(l.lo_inode, &((struct loop_info32 *)arg)->lo_inode);
-			err |= __put_user(l.lo_rdevice, &((struct loop_info32 *)arg)->lo_rdevice);
-			err |= __copy_to_user((char *)&((struct loop_info32 *)arg)->lo_offset,
-					   (char *)&l.lo_offset, (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+			err = put_user(l.lo_number, &ul->lo_number);
+			err |= __put_user(l.lo_device, &ul->lo_device);
+			err |= __put_user(l.lo_inode, &ul->lo_inode);
+			err |= __put_user(l.lo_rdevice, &ul->lo_rdevice);
+			err |= __copy_to_user(&ul->lo_offset, &l.lo_offset,
+				(unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
 			if (err)
 				err = -EFAULT;
 		}
@@ -1585,12 +1631,15 @@
 	compat_caddr_t chardata;	/* font data in expanded form */
 };
 
-static int do_fontx_ioctl(unsigned int fd, int cmd, struct consolefontdesc32 *user_cfd, struct file *file)
+static int do_fontx_ioctl(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *file)
 {
 	struct consolefontdesc cfdarg;
 	struct console_font_op op;
+	struct consolefontdesc32 *user_cfd;
 	int i, perm;
 
+	user_cfd = compat_ptr(arg);
 	perm = vt_check(file);
 	if (perm < 0) return perm;
 	
@@ -1640,15 +1689,18 @@
 	compat_caddr_t data;    /* font data with height fixed to 32 */
 };
                                         
-static int do_kdfontop_ioctl(unsigned int fd, unsigned int cmd, struct console_font_op32 *fontop, struct file *file)
+static int do_kdfontop_ioctl(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *file)
 {
 	struct console_font_op op;
+	struct console_font_op32 __user *fontop;
 	int perm = vt_check(file), i;
 	struct vt_struct *vt;
-	
+
 	if (perm < 0) return perm;
-	
-	if (copy_from_user(&op, (void *) fontop, sizeof(struct console_font_op32)))
+
+	fontop = compat_ptr(arg);
+	if (copy_from_user(&op, fontop, sizeof(*fontop)))
 		return -EFAULT;
 	if (!perm && op.op != KD_FONT_OP_GET)
 		return -EPERM;
@@ -1668,12 +1720,16 @@
 	compat_caddr_t entries;
 };
 
-static int do_unimap_ioctl(unsigned int fd, unsigned int cmd, struct unimapdesc32 *user_ud, struct file *file)
+static int do_unimap_ioctl(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *file)
 {
 	struct unimapdesc32 tmp;
+	struct unimapdesc32 __user *user_ud;
 	int perm = vt_check(file);
 	
-	if (perm < 0) return perm;
+	if (perm < 0)
+		return perm;
+	user_ud = compat_ptr(arg);
 	if (copy_from_user(&tmp, user_ud, sizeof tmp))
 		return -EFAULT;
 	switch (cmd) {
@@ -1686,9 +1742,10 @@
 	return 0;
 }
 
-#endif /* CONFIG_VT */
+#endif
 
-static int do_smb_getmountuid(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_smb_getmountuid(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	mm_segment_t old_fs = get_fs();
 	__kernel_uid_t kuid;
@@ -1701,7 +1758,7 @@
 	set_fs(old_fs);
 
 	if (err >= 0)
-		err = put_user(kuid, (compat_pid_t *)arg);
+		err = put_user(kuid, (compat_pid_t * __user)compat_ptr(arg));
 
 	return err;
 }
@@ -1761,21 +1818,20 @@
 #define NR_ATM_IOCTL (sizeof(atm_ioctl_map)/sizeof(atm_ioctl_map[0]))
 
 
-static int do_atm_iobuf(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_atm_iobuf(unsigned int fd, unsigned int cmd,
+			struct atm_iobuf32 __user *iobuf32)
 {
-	struct atm_iobuf   *iobuf;
-	struct atm_iobuf32 *iobuf32;
+	struct atm_iobuf __user *iobuf;
 	u32 data;
-	void *datap;
+	void __user *datap;
 	int len, err;
 
 	iobuf = compat_alloc_user_space(sizeof(*iobuf));
-	iobuf32 = (struct atm_iobuf32 *) arg;
 
 	if (get_user(len, &iobuf32->length) ||
 	    get_user(data, &iobuf32->buffer))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(len, &iobuf->length) ||
 	    put_user(datap, &iobuf->buffer))
 		return -EFAULT;
@@ -1791,21 +1847,20 @@
 	return err;
 }
 
-static int do_atmif_sioc(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_atmif_sioc(unsigned int fd, unsigned int cmd, 
+			struct atmif_sioc32 __user *sioc32)
 {
-        struct atmif_sioc   *sioc;
-	struct atmif_sioc32 *sioc32;
+        struct atmif_sioc __user *sioc;
 	u32 data;
-	void *datap;
+	void __user *datap;
 	int err;
         
 	sioc = compat_alloc_user_space(sizeof(*sioc));
-	sioc32 = (struct atmif_sioc32 *) arg;
 
 	if (copy_in_user(&sioc->number, &sioc32->number, 2 * sizeof(int)) ||
 	    get_user(data, &sioc32->arg))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &sioc->arg))
 		return -EFAULT;
 
@@ -1819,7 +1874,8 @@
 	return err;
 }
 
-static int do_atm_ioctl(unsigned int fd, unsigned int cmd32, unsigned long arg)
+static int do_atm_ioctl(unsigned int fd, unsigned int cmd32,
+			unsigned long arg, struct file *f)
 {
         int i;
         unsigned int cmd = 0;
@@ -1833,7 +1889,7 @@
 	case SONET_SETFRAMING:
 	case SONET_GETFRAMING:
 	case SONET_GETFRSENSE:
-		return do_atmif_sioc(fd, cmd32, arg);
+		return do_atmif_sioc(fd, cmd32, compat_ptr(arg));
 	}
 
 	for (i = 0; i < NR_ATM_IOCTL; i++) {
@@ -1847,7 +1903,7 @@
         
         switch (cmd) {
 	case ATM_GETNAMES:
-		return do_atm_iobuf(fd, cmd, arg);
+		return do_atm_iobuf(fd, cmd, compat_ptr(arg));
 	    
 	case ATM_GETLINKRATE:
         case ATM_GETTYPE:
@@ -1865,21 +1921,23 @@
 	case ATM_GETLOOP:
 	case ATM_SETLOOP:
 	case ATM_QUERYLOOP:
-                return do_atmif_sioc(fd, cmd, arg);
+                return do_atmif_sioc(fd, cmd, compat_ptr(arg));
         }
 
         return -EINVAL;
 }
 
-static int ret_einval(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int ret_einval(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	return -EINVAL;
 }
 
-static int broken_blkgetsize(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int broken_blkgetsize(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	/* The mkswap binary hard codes it to Intel value :-((( */
-	return w_long(fd, BLKGETSIZE, arg);
+	return w_long(fd, BLKGETSIZE, arg, f);
 }
 
 struct blkpg_ioctl_arg32 {
@@ -1888,25 +1946,33 @@
 	compat_int_t datalen;
 	compat_caddr_t data;
 };
-                                
-static int blkpg_ioctl_trans(unsigned int fd, unsigned int cmd, struct blkpg_ioctl_arg32 *arg)
+
+static int blkpg_ioctl_trans(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	struct blkpg_ioctl_arg a;
+	struct blkpg_ioctl_arg32 __user *ua32;
 	struct blkpg_partition p;
+	struct blkpg_partition __user *up32;
+	compat_caddr_t udata;
 	int err;
 	mm_segment_t old_fs = get_fs();
 	
-	err = get_user(a.op, &arg->op);
-	err |= __get_user(a.flags, &arg->flags);
-	err |= __get_user(a.datalen, &arg->datalen);
-	err |= __get_user((long)a.data, &arg->data);
-	if (err) return err;
+	ua32 = compat_ptr(arg);
+	err = get_user(a.op, &ua32->op);
+	err |= __get_user(a.flags, &ua32->flags);
+	err |= __get_user(a.datalen, &ua32->datalen);
+	err |= __get_user(udata, &ua32->data);
+	up32 = compat_ptr(udata);
+	if (err)
+		return err;
+
 	switch (a.op) {
 	case BLKPG_ADD_PARTITION:
 	case BLKPG_DEL_PARTITION:
 		if (a.datalen < sizeof(struct blkpg_partition))
 			return -EINVAL;
-                if (copy_from_user(&p, a.data, sizeof(struct blkpg_partition)))
+                if (copy_from_user(&p, up32, sizeof(struct blkpg_partition)))
 			return -EFAULT;
 		a.data = &p;
 		set_fs (KERNEL_DS);
@@ -1918,9 +1984,10 @@
 	return err;
 }
 
-static int ioc_settimeout(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int ioc_settimeout(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
-	return rw_long(fd, AUTOFS_IOC_SETTIMEOUT, arg);
+	return rw_long(fd, AUTOFS_IOC_SETTIMEOUT, arg, f);
 }
 
 /* Fix sizeof(sizeof()) breakage */
@@ -1928,20 +1995,22 @@
 #define BLKBSZSET_32   _IOW(0x12,113,int)
 #define BLKGETSIZE64_32        _IOR(0x12,114,int)
 
-static int do_blkbszget(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_blkbszget(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
-       return sys_ioctl(fd, BLKBSZGET, arg);
+       return sys_ioctl(fd, BLKBSZGET, (unsigned long)compat_ptr(arg));
 }
 
-static int do_blkbszset(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_blkbszset(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
-       return sys_ioctl(fd, BLKBSZSET, arg);
+       return sys_ioctl(fd, BLKBSZSET, (unsigned long)compat_ptr(arg));
 }
 
 static int do_blkgetsize64(unsigned int fd, unsigned int cmd,
-                          unsigned long arg)
+                          unsigned long arg, struct file *f)
 {
-       return sys_ioctl(fd, BLKGETSIZE64, arg);
+       return sys_ioctl(fd, BLKGETSIZE64, (unsigned long)compat_ptr(arg));
 }
 
 /* Bluetooth ioctls */
@@ -2058,7 +2127,8 @@
 
 #define NR_FD_IOCTL_TRANS (sizeof(fd_ioctl_trans_table)/sizeof(fd_ioctl_trans_table[0]))
 
-static int fd_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int fd_ioctl_trans(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *filp)
 {
 	mm_segment_t old_fs = get_fs();
 	void *karg = NULL;
@@ -2078,23 +2148,25 @@
 		case FDDEFPRM32:
 		case FDGETPRM32:
 		{
+			struct floppy_struct32 __user *uf;
 			struct floppy_struct *f;
 
+			uf = compat_ptr(arg);
 			f = karg = kmalloc(sizeof(struct floppy_struct), GFP_KERNEL);
 			if (!karg)
 				return -ENOMEM;
 			if (cmd == FDGETPRM32)
 				break;
-			err = __get_user(f->size, &((struct floppy_struct32 *)arg)->size);
-			err |= __get_user(f->sect, &((struct floppy_struct32 *)arg)->sect);
-			err |= __get_user(f->head, &((struct floppy_struct32 *)arg)->head);
-			err |= __get_user(f->track, &((struct floppy_struct32 *)arg)->track);
-			err |= __get_user(f->stretch, &((struct floppy_struct32 *)arg)->stretch);
-			err |= __get_user(f->gap, &((struct floppy_struct32 *)arg)->gap);
-			err |= __get_user(f->rate, &((struct floppy_struct32 *)arg)->rate);
-			err |= __get_user(f->spec1, &((struct floppy_struct32 *)arg)->spec1);
-			err |= __get_user(f->fmt_gap, &((struct floppy_struct32 *)arg)->fmt_gap);
-			err |= __get_user((u64)f->name, &((struct floppy_struct32 *)arg)->name);
+			err = __get_user(f->size, &uf->size);
+			err |= __get_user(f->sect, &uf->sect);
+			err |= __get_user(f->head, &uf->head);
+			err |= __get_user(f->track, &uf->track);
+			err |= __get_user(f->stretch, &uf->stretch);
+			err |= __get_user(f->gap, &uf->gap);
+			err |= __get_user(f->rate, &uf->rate);
+			err |= __get_user(f->spec1, &uf->spec1);
+			err |= __get_user(f->fmt_gap, &uf->fmt_gap);
+			err |= __get_user((u64)f->name, &uf->name);
 			if (err) {
 				err = -EFAULT;
 				goto out;
@@ -2104,32 +2176,34 @@
 		case FDSETDRVPRM32:
 		case FDGETDRVPRM32:
 		{
+			struct floppy_drive_params32 __user *uf;
 			struct floppy_drive_params *f;
 
+			uf = compat_ptr(arg);
 			f = karg = kmalloc(sizeof(struct floppy_drive_params), GFP_KERNEL);
 			if (!karg)
 				return -ENOMEM;
 			if (cmd == FDGETDRVPRM32)
 				break;
-			err = __get_user(f->cmos, &((struct floppy_drive_params32 *)arg)->cmos);
-			err |= __get_user(f->max_dtr, &((struct floppy_drive_params32 *)arg)->max_dtr);
-			err |= __get_user(f->hlt, &((struct floppy_drive_params32 *)arg)->hlt);
-			err |= __get_user(f->hut, &((struct floppy_drive_params32 *)arg)->hut);
-			err |= __get_user(f->srt, &((struct floppy_drive_params32 *)arg)->srt);
-			err |= __get_user(f->spinup, &((struct floppy_drive_params32 *)arg)->spinup);
-			err |= __get_user(f->spindown, &((struct floppy_drive_params32 *)arg)->spindown);
-			err |= __get_user(f->spindown_offset, &((struct floppy_drive_params32 *)arg)->spindown_offset);
-			err |= __get_user(f->select_delay, &((struct floppy_drive_params32 *)arg)->select_delay);
-			err |= __get_user(f->rps, &((struct floppy_drive_params32 *)arg)->rps);
-			err |= __get_user(f->tracks, &((struct floppy_drive_params32 *)arg)->tracks);
-			err |= __get_user(f->timeout, &((struct floppy_drive_params32 *)arg)->timeout);
-			err |= __get_user(f->interleave_sect, &((struct floppy_drive_params32 *)arg)->interleave_sect);
-			err |= __copy_from_user(&f->max_errors, &((struct floppy_drive_params32 *)arg)->max_errors, sizeof(f->max_errors));
-			err |= __get_user(f->flags, &((struct floppy_drive_params32 *)arg)->flags);
-			err |= __get_user(f->read_track, &((struct floppy_drive_params32 *)arg)->read_track);
-			err |= __copy_from_user(f->autodetect, ((struct floppy_drive_params32 *)arg)->autodetect, sizeof(f->autodetect));
-			err |= __get_user(f->checkfreq, &((struct floppy_drive_params32 *)arg)->checkfreq);
-			err |= __get_user(f->native_format, &((struct floppy_drive_params32 *)arg)->native_format);
+			err = __get_user(f->cmos, &uf->cmos);
+			err |= __get_user(f->max_dtr, &uf->max_dtr);
+			err |= __get_user(f->hlt, &uf->hlt);
+			err |= __get_user(f->hut, &uf->hut);
+			err |= __get_user(f->srt, &uf->srt);
+			err |= __get_user(f->spinup, &uf->spinup);
+			err |= __get_user(f->spindown, &uf->spindown);
+			err |= __get_user(f->spindown_offset, &uf->spindown_offset);
+			err |= __get_user(f->select_delay, &uf->select_delay);
+			err |= __get_user(f->rps, &uf->rps);
+			err |= __get_user(f->tracks, &uf->tracks);
+			err |= __get_user(f->timeout, &uf->timeout);
+			err |= __get_user(f->interleave_sect, &uf->interleave_sect);
+			err |= __copy_from_user(&f->max_errors, &uf->max_errors, sizeof(f->max_errors));
+			err |= __get_user(f->flags, &uf->flags);
+			err |= __get_user(f->read_track, &uf->read_track);
+			err |= __copy_from_user(f->autodetect, uf->autodetect, sizeof(f->autodetect));
+			err |= __get_user(f->checkfreq, &uf->checkfreq);
+			err |= __get_user(f->native_format, &uf->native_format);
 			if (err) {
 				err = -EFAULT;
 				goto out;
@@ -2174,83 +2248,90 @@
 			err |= __put_user(f->rate, &((struct floppy_struct32 *)arg)->rate);
 			err |= __put_user(f->spec1, &((struct floppy_struct32 *)arg)->spec1);
 			err |= __put_user(f->fmt_gap, &((struct floppy_struct32 *)arg)->fmt_gap);
-			err |= __put_user((u64)f->name, &((struct floppy_struct32 *)arg)->name);
+			err |= __put_user((u64)f->name, (compat_caddr_t*)&((struct floppy_struct32 *)arg)->name);
 			break;
 		}
 		case FDGETDRVPRM32:
 		{
+			struct floppy_drive_params32 __user *uf;
 			struct floppy_drive_params *f = karg;
 
-			err = __put_user(f->cmos, &((struct floppy_drive_params32 *)arg)->cmos);
-			err |= __put_user(f->max_dtr, &((struct floppy_drive_params32 *)arg)->max_dtr);
-			err |= __put_user(f->hlt, &((struct floppy_drive_params32 *)arg)->hlt);
-			err |= __put_user(f->hut, &((struct floppy_drive_params32 *)arg)->hut);
-			err |= __put_user(f->srt, &((struct floppy_drive_params32 *)arg)->srt);
-			err |= __put_user(f->spinup, &((struct floppy_drive_params32 *)arg)->spinup);
-			err |= __put_user(f->spindown, &((struct floppy_drive_params32 *)arg)->spindown);
-			err |= __put_user(f->spindown_offset, &((struct floppy_drive_params32 *)arg)->spindown_offset);
-			err |= __put_user(f->select_delay, &((struct floppy_drive_params32 *)arg)->select_delay);
-			err |= __put_user(f->rps, &((struct floppy_drive_params32 *)arg)->rps);
-			err |= __put_user(f->tracks, &((struct floppy_drive_params32 *)arg)->tracks);
-			err |= __put_user(f->timeout, &((struct floppy_drive_params32 *)arg)->timeout);
-			err |= __put_user(f->interleave_sect, &((struct floppy_drive_params32 *)arg)->interleave_sect);
-			err |= __copy_to_user(&((struct floppy_drive_params32 *)arg)->max_errors, &f->max_errors, sizeof(f->max_errors));
-			err |= __put_user(f->flags, &((struct floppy_drive_params32 *)arg)->flags);
-			err |= __put_user(f->read_track, &((struct floppy_drive_params32 *)arg)->read_track);
-			err |= __copy_to_user(((struct floppy_drive_params32 *)arg)->autodetect, f->autodetect, sizeof(f->autodetect));
-			err |= __put_user(f->checkfreq, &((struct floppy_drive_params32 *)arg)->checkfreq);
-			err |= __put_user(f->native_format, &((struct floppy_drive_params32 *)arg)->native_format);
+			uf = compat_ptr(arg);
+			err = __put_user(f->cmos, &uf->cmos);
+			err |= __put_user(f->max_dtr, &uf->max_dtr);
+			err |= __put_user(f->hlt, &uf->hlt);
+			err |= __put_user(f->hut, &uf->hut);
+			err |= __put_user(f->srt, &uf->srt);
+			err |= __put_user(f->spinup, &uf->spinup);
+			err |= __put_user(f->spindown, &uf->spindown);
+			err |= __put_user(f->spindown_offset, &uf->spindown_offset);
+			err |= __put_user(f->select_delay, &uf->select_delay);
+			err |= __put_user(f->rps, &uf->rps);
+			err |= __put_user(f->tracks, &uf->tracks);
+			err |= __put_user(f->timeout, &uf->timeout);
+			err |= __put_user(f->interleave_sect, &uf->interleave_sect);
+			err |= __copy_to_user(&uf->max_errors, &f->max_errors, sizeof(f->max_errors));
+			err |= __put_user(f->flags, &uf->flags);
+			err |= __put_user(f->read_track, &uf->read_track);
+			err |= __copy_to_user(uf->autodetect, f->autodetect, sizeof(f->autodetect));
+			err |= __put_user(f->checkfreq, &uf->checkfreq);
+			err |= __put_user(f->native_format, &uf->native_format);
 			break;
 		}
 		case FDGETDRVSTAT32:
 		case FDPOLLDRVSTAT32:
 		{
+			struct floppy_drive_struct32 __user *uf;
 			struct floppy_drive_struct *f = karg;
 
-			err = __put_user(f->flags, &((struct floppy_drive_struct32 *)arg)->flags);
-			err |= __put_user(f->spinup_date, &((struct floppy_drive_struct32 *)arg)->spinup_date);
-			err |= __put_user(f->select_date, &((struct floppy_drive_struct32 *)arg)->select_date);
-			err |= __put_user(f->first_read_date, &((struct floppy_drive_struct32 *)arg)->first_read_date);
-			err |= __put_user(f->probed_format, &((struct floppy_drive_struct32 *)arg)->probed_format);
-			err |= __put_user(f->track, &((struct floppy_drive_struct32 *)arg)->track);
-			err |= __put_user(f->maxblock, &((struct floppy_drive_struct32 *)arg)->maxblock);
-			err |= __put_user(f->maxtrack, &((struct floppy_drive_struct32 *)arg)->maxtrack);
-			err |= __put_user(f->generation, &((struct floppy_drive_struct32 *)arg)->generation);
-			err |= __put_user(f->keep_data, &((struct floppy_drive_struct32 *)arg)->keep_data);
-			err |= __put_user(f->fd_ref, &((struct floppy_drive_struct32 *)arg)->fd_ref);
-			err |= __put_user(f->fd_device, &((struct floppy_drive_struct32 *)arg)->fd_device);
-			err |= __put_user(f->last_checked, &((struct floppy_drive_struct32 *)arg)->last_checked);
-			err |= __put_user((u64)f->dmabuf, &((struct floppy_drive_struct32 *)arg)->dmabuf);
-			err |= __put_user((u64)f->bufblocks, &((struct floppy_drive_struct32 *)arg)->bufblocks);
+			uf = compat_ptr(arg);
+			err = __put_user(f->flags, &uf->flags);
+			err |= __put_user(f->spinup_date, &uf->spinup_date);
+			err |= __put_user(f->select_date, &uf->select_date);
+			err |= __put_user(f->first_read_date, &uf->first_read_date);
+			err |= __put_user(f->probed_format, &uf->probed_format);
+			err |= __put_user(f->track, &uf->track);
+			err |= __put_user(f->maxblock, &uf->maxblock);
+			err |= __put_user(f->maxtrack, &uf->maxtrack);
+			err |= __put_user(f->generation, &uf->generation);
+			err |= __put_user(f->keep_data, &uf->keep_data);
+			err |= __put_user(f->fd_ref, &uf->fd_ref);
+			err |= __put_user(f->fd_device, &uf->fd_device);
+			err |= __put_user(f->last_checked, &uf->last_checked);
+			err |= __put_user((u64)f->dmabuf, &uf->dmabuf);
+			err |= __put_user((u64)f->bufblocks, &uf->bufblocks);
 			break;
 		}
 		case FDGETFDCSTAT32:
 		{
+			struct floppy_fdc_state32 __user *uf;
 			struct floppy_fdc_state *f = karg;
 
-			err = __put_user(f->spec1, &((struct floppy_fdc_state32 *)arg)->spec1);
-			err |= __put_user(f->spec2, &((struct floppy_fdc_state32 *)arg)->spec2);
-			err |= __put_user(f->dtr, &((struct floppy_fdc_state32 *)arg)->dtr);
-			err |= __put_user(f->version, &((struct floppy_fdc_state32 *)arg)->version);
-			err |= __put_user(f->dor, &((struct floppy_fdc_state32 *)arg)->dor);
-			err |= __put_user(f->address, &((struct floppy_fdc_state32 *)arg)->address);
-			err |= __copy_to_user((char *)&((struct floppy_fdc_state32 *)arg)->address
-			    		   + sizeof(((struct floppy_fdc_state32 *)arg)->address),
+			uf = compat_ptr(arg);
+			err = __put_user(f->spec1, &uf->spec1);
+			err |= __put_user(f->spec2, &uf->spec2);
+			err |= __put_user(f->dtr, &uf->dtr);
+			err |= __put_user(f->version, &uf->version);
+			err |= __put_user(f->dor, &uf->dor);
+			err |= __put_user(f->address, &uf->address);
+			err |= __copy_to_user((char __user *)&uf->address + sizeof(uf->address),
 					   (char *)&f->address + sizeof(f->address), sizeof(int));
-			err |= __put_user(f->driver_version, &((struct floppy_fdc_state32 *)arg)->driver_version);
-			err |= __copy_to_user(((struct floppy_fdc_state32 *)arg)->track, f->track, sizeof(f->track));
+			err |= __put_user(f->driver_version, &uf->driver_version);
+			err |= __copy_to_user(uf->track, f->track, sizeof(f->track));
 			break;
 		}
 		case FDWERRORGET32:
 		{
+			struct floppy_write_errors32 __user *uf;
 			struct floppy_write_errors *f = karg;
 
-			err = __put_user(f->write_errors, &((struct floppy_write_errors32 *)arg)->write_errors);
-			err |= __put_user(f->first_error_sector, &((struct floppy_write_errors32 *)arg)->first_error_sector);
-			err |= __put_user(f->first_error_generation, &((struct floppy_write_errors32 *)arg)->first_error_generation);
-			err |= __put_user(f->last_error_sector, &((struct floppy_write_errors32 *)arg)->last_error_sector);
-			err |= __put_user(f->last_error_generation, &((struct floppy_write_errors32 *)arg)->last_error_generation);
-			err |= __put_user(f->badness, &((struct floppy_write_errors32 *)arg)->badness);
+			uf = compat_ptr(arg);
+			err = __put_user(f->write_errors, &uf->write_errors);
+			err |= __put_user(f->first_error_sector, &uf->first_error_sector);
+			err |= __put_user(f->first_error_generation, &uf->first_error_generation);
+			err |= __put_user(f->last_error_sector, &uf->last_error_sector);
+			err |= __put_user(f->last_error_generation, &uf->last_error_generation);
+			err |= __put_user(f->badness, &uf->badness);
 			break;
 		}
 		default:
@@ -2272,12 +2353,13 @@
 #define MEMWRITEOOB32 	_IOWR('M',3,struct mtd_oob_buf32)
 #define MEMREADOOB32 	_IOWR('M',4,struct mtd_oob_buf32)
 
-static int mtd_rw_oob(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int mtd_rw_oob(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
-	struct mtd_oob_buf	*buf = compat_alloc_user_space(sizeof(*buf));
-	struct mtd_oob_buf32	*buf32 = (struct mtd_oob_buf32 *) arg;
+	struct mtd_oob_buf	__user *buf = compat_alloc_user_space(sizeof(*buf));
+	struct mtd_oob_buf32	__user *buf32 = compat_ptr(arg);
 	u32 data;
-	char *datap;
+	char __user *datap;
 	unsigned int real_cmd;
 	int err;
 
@@ -2288,7 +2370,7 @@
 			 2 * sizeof(u32)) ||
 	    get_user(data, &buf32->ptr))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &buf->ptr))
 		return -EFAULT;
 
@@ -2307,7 +2389,7 @@
 #define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
 
 static long
-put_dirent32 (struct dirent *d, struct compat_dirent *d32)
+put_dirent32 (struct dirent *d, struct compat_dirent __user *d32)
 {
         int ret;
 
@@ -2322,11 +2404,13 @@
         return ret;
 }
 
-static int vfat_ioctl32(unsigned fd, unsigned cmd,  void *ptr)
+static int vfat_ioctl32(unsigned fd, unsigned cmd,
+			unsigned long arg, struct file *f)
 {
 	int ret;
 	mm_segment_t oldfs = get_fs();
 	struct dirent d[2];
+	struct compat_dirent __user *ud;
 
 	switch(cmd)
 	{
@@ -2341,21 +2425,24 @@
 	set_fs(KERNEL_DS);
 	ret = sys_ioctl(fd,cmd,(unsigned long)&d);
 	set_fs(oldfs);
+
 	if (ret >= 0) {
-		ret |= put_dirent32(&d[0], (struct compat_dirent *)ptr);
-		ret |= put_dirent32(&d[1], ((struct compat_dirent *)ptr) + 1);
+		ud = compat_ptr(arg);
+		ret |= put_dirent32(&d[0], &ud[0]);
+		ret |= put_dirent32(&d[1], &ud[1]);
 	}
 	return ret;
 }
 
 #define REISERFS_IOC_UNPACK32               _IOW(0xCD,1,int)
 
-static int reiserfs_ioctl32(unsigned fd, unsigned cmd, unsigned long ptr)
+static int reiserfs_ioctl32(unsigned fd, unsigned cmd,
+			unsigned long arg, struct file *f)
 {
         if (cmd == REISERFS_IOC_UNPACK32)
                 cmd = REISERFS_IOC_UNPACK;
 
-        return sys_ioctl(fd,cmd,ptr);
+        return sys_ioctl(fd, cmd, arg);
 }
 
 struct raw32_config_request
@@ -2365,7 +2452,8 @@
         __u64   block_minor;
 } __attribute__((packed));
 
-static int get_raw32_request(struct raw_config_request *req, struct raw32_config_request *user_req)
+static int get_raw32_request(struct raw_config_request *req,
+			struct raw32_config_request __user *user_req)
 {
         __u32   lo_maj, hi_maj, lo_min, hi_min;
         int ret;
@@ -2375,10 +2463,10 @@
                 return ret;
 
         __get_user(req->raw_minor, &user_req->raw_minor);
-        __get_user(lo_maj, (__u32*)&user_req->block_major);
-        __get_user(hi_maj, ((__u32*)(&user_req->block_major) + 1));
-        __get_user(lo_min, (__u32*)&user_req->block_minor);
-        __get_user(hi_min, ((__u32*)(&user_req->block_minor) + 1));
+        __get_user(lo_maj, (__u32 __user*)&user_req->block_major);
+        __get_user(hi_maj, ((__u32 __user*)(&user_req->block_major) + 1));
+        __get_user(lo_min, (__u32 __user*)&user_req->block_minor);
+        __get_user(hi_min, ((__u32 __user*)(&user_req->block_minor) + 1));
 
         req->block_major = lo_maj | (((__u64)hi_maj) << 32);
         req->block_minor = lo_min | (((__u64)lo_min) << 32);
@@ -2386,7 +2474,8 @@
         return ret;
 }
 
-static int set_raw32_request(struct raw_config_request *req, struct raw32_config_request *user_req)
+static int set_raw32_request(struct raw_config_request *req,
+			struct raw32_config_request __user *user_req)
 {
 	int ret;
 
@@ -2403,7 +2492,8 @@
         return ret;
 }
 
-static int raw_ioctl(unsigned fd, unsigned cmd,  void *ptr)
+static int raw_ioctl(unsigned fd, unsigned cmd,
+			unsigned long arg, struct file *f)
 {
         int ret;
 
@@ -2411,7 +2501,7 @@
         case RAW_SETBIND:
         case RAW_GETBIND: {
                 struct raw_config_request req;
-                struct raw32_config_request *user_req = ptr;
+                struct raw32_config_request __user *user_req = compat_ptr(arg);
                 mm_segment_t oldfs = get_fs();
 
                 if ((ret = get_raw32_request(&req, user_req)))
@@ -2427,7 +2517,7 @@
                 break;
         }
         default:
-                ret = sys_ioctl(fd,cmd,(unsigned long)ptr);
+                ret = sys_ioctl(fd,cmd,arg);
                 break;
         }
         return ret;
@@ -2451,25 +2541,26 @@
         compat_uint_t   iomem_base;
         unsigned short  iomem_reg_shift;
         unsigned int    port_high;
+     /* compat_ulong_t  iomap_base FIXME */
         compat_int_t    reserved[1];
 };
 
-static int serial_struct_ioctl(unsigned fd, unsigned cmd,  void *ptr)
+static int serial_struct_ioctl(unsigned fd, unsigned cmd,
+			unsigned long arg, struct file *f)
 {
-        typedef struct serial_struct SS;
         typedef struct serial_struct32 SS32;
-        struct serial_struct32 *ss32 = ptr;
+        struct serial_struct32 __user *ss32 = compat_ptr(arg);
         int err;
         struct serial_struct ss;
         mm_segment_t oldseg = get_fs();
         __u32 udata;
 
         if (cmd == TIOCSSERIAL) {
-                if (verify_area(VERIFY_READ, ss32, sizeof(SS32)))
+                if (verify_area(VERIFY_READ, ss32, sizeof(*ss32)))
                         return -EFAULT;
                 __copy_from_user(&ss, ss32, offsetof(SS32, iomem_base));
                 __get_user(udata, &ss32->iomem_base);
-                ss.iomem_base = compat_ptr(udata);
+                ss.iomem_base = (void __kernel *)compat_ptr(udata);
                 __get_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift);
                 __get_user(ss.port_high, &ss32->port_high);
                 ss.iomap_base = 0UL;
@@ -2478,7 +2569,7 @@
                 err = sys_ioctl(fd,cmd,(unsigned long)(&ss));
         set_fs(oldseg);
         if (cmd == TIOCGSERIAL && err >= 0) {
-                if (verify_area(VERIFY_WRITE, ss32, sizeof(SS32)))
+                if (verify_area(VERIFY_WRITE, ss32, sizeof(*ss32)))
                         return -EFAULT;
                 __copy_to_user(ss32,&ss,offsetof(SS32,iomem_base));
                 __put_user((unsigned long)ss.iomem_base  >> 32 ?
@@ -2503,16 +2594,18 @@
 
 #define USBDEVFS_CONTROL32           _IOWR('U', 0, struct usbdevfs_ctrltransfer32)
 
-static int do_usbdevfs_control(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_usbdevfs_control(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
         struct usbdevfs_ctrltransfer kctrl;
-        struct usbdevfs_ctrltransfer32 *uctrl;
+        struct usbdevfs_ctrltransfer32 __user *uctrl;
         mm_segment_t old_fs;
         __u32 udata;
-        void *uptr, *kptr;
+        void __user *uptr;
+	void *kptr;
         int err;
 
-        uctrl = (struct usbdevfs_ctrltransfer32 *) arg;
+        uctrl = compat_ptr(arg);
 
         if (copy_from_user(&kctrl, uctrl,
                            (sizeof(struct usbdevfs_ctrltransfer32) -
@@ -2536,7 +2629,7 @@
                         goto out;
         }
 
-        kctrl.data = kptr;
+        kctrl.data = (void __user *)kptr;
 
         old_fs = get_fs();
         set_fs(KERNEL_DS);
@@ -2564,16 +2657,18 @@
 
 #define USBDEVFS_BULK32              _IOWR('U', 2, struct usbdevfs_bulktransfer32)
 
-static int do_usbdevfs_bulk(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_usbdevfs_bulk(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
         struct usbdevfs_bulktransfer kbulk;
-        struct usbdevfs_bulktransfer32 *ubulk;
+        struct usbdevfs_bulktransfer32 __user *ubulk;
         mm_segment_t old_fs;
         __u32 udata;
-        void *uptr, *kptr;
+        void __user *uptr;
+	void *kptr;
         int err;
 
-	ubulk = (struct usbdevfs_bulktransfer32 *) arg;
+	ubulk = compat_ptr(arg);
 
         if (get_user(kbulk.ep, &ubulk->ep) ||
             get_user(kbulk.len, &ubulk->len) ||
@@ -2597,7 +2692,7 @@
                         goto out;
         }
 
-        kbulk.data = kptr;
+        kbulk.data = (void __user *)kptr;
 
 	old_fs = get_fs();
         set_fs(KERNEL_DS);
@@ -2758,7 +2853,8 @@
 	return 0;
 }
 
-static int do_usbdevfs_urb(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_usbdevfs_urb(unsigned int fd, unsigned int cmd,
+			unsigned long arg, struct file *f)
 {
 	struct usbdevfs_urb *kurb;
 	struct usbdevfs_urb32 *uurb;
@@ -2768,7 +2864,7 @@
 	unsigned int buflen;
 	int err;
 
-	uurb = (struct usbdevfs_urb32 *) arg;
+	uurb = compat_ptr(arg);
 
 	err = -ENOMEM;
 	kurb = kmalloc(sizeof(struct usbdevfs_urb) +
@@ -2817,7 +2913,8 @@
 #define USBDEVFS_REAPURB32         _IOW('U', 12, u32)
 #define USBDEVFS_REAPURBNDELAY32   _IOW('U', 13, u32)
 
-static int do_usbdevfs_reapurb(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_usbdevfs_reapurb(unsigned int fd, unsigned int cmd,
+				unsigned long arg, struct file *f)
 {
         mm_segment_t old_fs;
         void *kptr;
@@ -2833,7 +2930,7 @@
         set_fs(old_fs);
 
         if (err >= 0 &&
-            put_user((u32)(u64)kptr, (u32 *)arg))
+            put_user((u32)(u64)kptr, (u32 *)compat_ptr(arg)))
                 err = -EFAULT;
 
         return err;
@@ -2846,21 +2943,22 @@
 
 #define USBDEVFS_DISCSIGNAL32      _IOR('U', 14, struct usbdevfs_disconnectsignal32)
 
-static int do_usbdevfs_discsignal(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_usbdevfs_discsignal(unsigned int fd, unsigned int cmd,
+				unsigned long arg, struct file *f)
 {
         struct usbdevfs_disconnectsignal kdis;
-        struct usbdevfs_disconnectsignal32 *udis;
+        struct usbdevfs_disconnectsignal32 __user *udis;
         mm_segment_t old_fs;
         u32 uctx;
         int err;
 
-        udis = (struct usbdevfs_disconnectsignal32 *) arg;
+        udis = compat_ptr(arg);
 
         if (get_user(kdis.signr, &udis->signr) ||
             __get_user(uctx, &udis->context))
                 return -EFAULT;
 
-        kdis.context = (void *) (long)uctx;
+        kdis.context = compat_ptr(uctx);
 
         old_fs = get_fs();
         set_fs(KERNEL_DS);
===== include/linux/compat_ioctl.h 1.10 vs edited =====
--- 1.10/include/linux/compat_ioctl.h	Thu Oct  2 09:12:22 2003
+++ edited/include/linux/compat_ioctl.h	Mon Oct  6 17:50:17 2003
@@ -2,6 +2,14 @@
  * compatible types passed or none at all... Please include
  * only stuff that is compatible on *all architectures*.
  */
+#ifndef COMPATIBLE_IOCTL /* pointer to compatible structure or no argument */
+#define COMPATIBLE_IOCTL(cmd)  HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)sys_ioctl)
+#endif
+
+#ifndef ULONG_IOCTL /* argument is an unsigned long integer, not a pointer */
+#define ULONG_IOCTL(cmd)  HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)sys_ioctl)
+#endif
+
 /* Big T */
 COMPATIBLE_IOCTL(TCGETA)
 COMPATIBLE_IOCTL(TCSETA)
@@ -35,18 +43,16 @@
 COMPATIBLE_IOCTL(TIOCOUTQ)
 COMPATIBLE_IOCTL(TIOCSPGRP)
 COMPATIBLE_IOCTL(TIOCGPGRP)
-COMPATIBLE_IOCTL(TIOCSCTTY)
+ULONG_IOCTL(TIOCSCTTY)
 COMPATIBLE_IOCTL(TIOCGPTN)
 COMPATIBLE_IOCTL(TIOCSPTLCK)
 COMPATIBLE_IOCTL(TIOCSERGETLSR)
-#ifdef CONFIG_FB
 /* Big F */
 COMPATIBLE_IOCTL(FBIOGET_VSCREENINFO)
 COMPATIBLE_IOCTL(FBIOPUT_VSCREENINFO)
 COMPATIBLE_IOCTL(FBIOPAN_DISPLAY)
 COMPATIBLE_IOCTL(FBIOGET_CON2FBMAP)
 COMPATIBLE_IOCTL(FBIOPUT_CON2FBMAP)
-#endif
 /* Little f */
 COMPATIBLE_IOCTL(FIOCLEX)
 COMPATIBLE_IOCTL(FIONCLEX)
@@ -68,7 +74,6 @@
 COMPATIBLE_IOCTL(HDIO_DRIVE_CMD)
 COMPATIBLE_IOCTL(HDIO_SET_PIO_MODE)
 COMPATIBLE_IOCTL(HDIO_SET_NICE)
-#ifdef CONFIG_BLK_DEV_FD
 /* 0x02 -- Floppy ioctls */
 COMPATIBLE_IOCTL(FDMSGON)
 COMPATIBLE_IOCTL(FDMSGOFF)
@@ -86,7 +91,6 @@
 COMPATIBLE_IOCTL(FDTWADDLE)
 COMPATIBLE_IOCTL(FDFMTTRK)
 COMPATIBLE_IOCTL(FDRAWCMD)
-#endif
 /* 0x12 */
 COMPATIBLE_IOCTL(BLKROSET)
 COMPATIBLE_IOCTL(BLKROGET)
@@ -94,8 +98,8 @@
 COMPATIBLE_IOCTL(BLKFLSBUF)
 COMPATIBLE_IOCTL(BLKSECTSET)
 COMPATIBLE_IOCTL(BLKSSZGET)
-COMPATIBLE_IOCTL(BLKRASET)
-COMPATIBLE_IOCTL(BLKFRASET)
+ULONG_IOCTL(BLKRASET)
+ULONG_IOCTL(BLKFRASET)
 /* RAID */
 COMPATIBLE_IOCTL(RAID_VERSION)
 COMPATIBLE_IOCTL(GET_ARRAY_INFO)
@@ -104,20 +108,19 @@
 COMPATIBLE_IOCTL(RAID_AUTORUN)
 COMPATIBLE_IOCTL(CLEAR_ARRAY)
 COMPATIBLE_IOCTL(ADD_NEW_DISK)
-COMPATIBLE_IOCTL(HOT_REMOVE_DISK)
+ULONG_IOCTL(HOT_REMOVE_DISK)
 COMPATIBLE_IOCTL(SET_ARRAY_INFO)
 COMPATIBLE_IOCTL(SET_DISK_INFO)
 COMPATIBLE_IOCTL(WRITE_RAID_INFO)
 COMPATIBLE_IOCTL(UNPROTECT_ARRAY)
 COMPATIBLE_IOCTL(PROTECT_ARRAY)
-COMPATIBLE_IOCTL(HOT_ADD_DISK)
-COMPATIBLE_IOCTL(SET_DISK_FAULTY)
+ULONG_IOCTL(HOT_ADD_DISK)
+ULONG_IOCTL(SET_DISK_FAULTY)
 COMPATIBLE_IOCTL(RUN_ARRAY)
-COMPATIBLE_IOCTL(START_ARRAY)
+ULONG_IOCTL(START_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY_RO)
 COMPATIBLE_IOCTL(RESTART_ARRAY_RW)
-#ifdef CONFIG_BLK_DEV_DM
 /* DM */
 #ifdef CONFIG_DM_IOCTL_V4
 COMPATIBLE_IOCTL(DM_VERSION)
@@ -145,21 +148,20 @@
 COMPATIBLE_IOCTL(DM_TARGET_STATUS)
 COMPATIBLE_IOCTL(DM_TARGET_WAIT)
 #endif
-#endif
 /* Big K */
 COMPATIBLE_IOCTL(PIO_FONT)
 COMPATIBLE_IOCTL(GIO_FONT)
-COMPATIBLE_IOCTL(KDSIGACCEPT)
+ULONG_IOCTL(KDSIGACCEPT)
 COMPATIBLE_IOCTL(KDGETKEYCODE)
 COMPATIBLE_IOCTL(KDSETKEYCODE)
-COMPATIBLE_IOCTL(KIOCSOUND)
-COMPATIBLE_IOCTL(KDMKTONE)
+ULONG_IOCTL(KIOCSOUND)
+ULONG_IOCTL(KDMKTONE)
 COMPATIBLE_IOCTL(KDGKBTYPE)
-COMPATIBLE_IOCTL(KDSETMODE)
+ULONG_IOCTL(KDSETMODE)
 COMPATIBLE_IOCTL(KDGETMODE)
-COMPATIBLE_IOCTL(KDSKBMODE)
+ULONG_IOCTL(KDSKBMODE)
 COMPATIBLE_IOCTL(KDGKBMODE)
-COMPATIBLE_IOCTL(KDSKBMETA)
+ULONG_IOCTL(KDSKBMETA)
 COMPATIBLE_IOCTL(KDGKBMETA)
 COMPATIBLE_IOCTL(KDGKBENT)
 COMPATIBLE_IOCTL(KDSKBENT)
@@ -169,9 +171,9 @@
 COMPATIBLE_IOCTL(KDSKBDIACR)
 COMPATIBLE_IOCTL(KDKBDREP)
 COMPATIBLE_IOCTL(KDGKBLED)
-COMPATIBLE_IOCTL(KDSKBLED)
+ULONG_IOCTL(KDSKBLED)
 COMPATIBLE_IOCTL(KDGETLED)
-COMPATIBLE_IOCTL(KDSETLED)
+ULONG_IOCTL(KDSETLED)
 COMPATIBLE_IOCTL(GIO_SCRNMAP)
 COMPATIBLE_IOCTL(PIO_SCRNMAP)
 COMPATIBLE_IOCTL(GIO_UNISCRNMAP)
@@ -198,15 +200,14 @@
 COMPATIBLE_IOCTL(VT_GETMODE)
 COMPATIBLE_IOCTL(VT_GETSTATE)
 COMPATIBLE_IOCTL(VT_OPENQRY)
-COMPATIBLE_IOCTL(VT_ACTIVATE)
-COMPATIBLE_IOCTL(VT_WAITACTIVE)
-COMPATIBLE_IOCTL(VT_RELDISP)
-COMPATIBLE_IOCTL(VT_DISALLOCATE)
+ULONG_IOCTL(VT_ACTIVATE)
+ULONG_IOCTL(VT_WAITACTIVE)
+ULONG_IOCTL(VT_RELDISP)
+ULONG_IOCTL(VT_DISALLOCATE)
 COMPATIBLE_IOCTL(VT_RESIZE)
 COMPATIBLE_IOCTL(VT_RESIZEX)
 COMPATIBLE_IOCTL(VT_LOCKSWITCH)
 COMPATIBLE_IOCTL(VT_UNLOCKSWITCH)
-#if defined(CONFIG_VIDEO_DEV) || defined(CONFIG_VIDEO_DEV_MODULE)
 /* Little v */
 /* Little v, the video4linux ioctls (conflict?) */
 COMPATIBLE_IOCTL(VIDIOCGCAP)
@@ -233,7 +234,6 @@
 COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+5, int))
 COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+6, int))
 COMPATIBLE_IOCTL(_IOR('v' , BASE_VIDIOCPRIVATE+7, int))
-#endif
 /* Little p (/dev/rtc, /dev/envctrl, etc.) */
 COMPATIBLE_IOCTL(RTC_AIE_ON)
 COMPATIBLE_IOCTL(RTC_AIE_OFF)
@@ -260,8 +260,10 @@
 COMPATIBLE_IOCTL(SIOCSIFLINK)
 COMPATIBLE_IOCTL(SIOCSIFENCAP)
 COMPATIBLE_IOCTL(SIOCGIFENCAP)
+/* FIXME: not compatible
 COMPATIBLE_IOCTL(SIOCSIFBR)
 COMPATIBLE_IOCTL(SIOCGIFBR)
+*/
 COMPATIBLE_IOCTL(SIOCSARP)
 COMPATIBLE_IOCTL(SIOCGARP)
 COMPATIBLE_IOCTL(SIOCDARP)
@@ -279,7 +281,7 @@
 COMPATIBLE_IOCTL(SG_SET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_GET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_EMULATED_HOST)
-COMPATIBLE_IOCTL(SG_SET_TRANSFORM)
+ULONG_IOCTL(SG_SET_TRANSFORM)
 COMPATIBLE_IOCTL(SG_GET_TRANSFORM)
 COMPATIBLE_IOCTL(SG_SET_RESERVED_SIZE)
 COMPATIBLE_IOCTL(SG_GET_RESERVED_SIZE)
@@ -299,7 +301,6 @@
 COMPATIBLE_IOCTL(SG_GET_REQUEST_TABLE)
 COMPATIBLE_IOCTL(SG_SET_KEEP_ORPHAN)
 COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
-#if defined(CONFIG_PPP) || defined(CONFIG_PPP_MODULE)
 /* PPP stuff */
 COMPATIBLE_IOCTL(PPPIOCGFLAGS)
 COMPATIBLE_IOCTL(PPPIOCSFLAGS)
@@ -333,7 +334,6 @@
 /* PPPOX */
 COMPATIBLE_IOCTL(PPPOEIOCSFWD)
 COMPATIBLE_IOCTL(PPPOEIOCDFWD)
-#endif
 /* LP */
 COMPATIBLE_IOCTL(LPGETSTATUS)
 /* CDROM stuff */
@@ -348,7 +348,7 @@
 COMPATIBLE_IOCTL(CDROMEJECT)
 COMPATIBLE_IOCTL(CDROMVOLCTRL)
 COMPATIBLE_IOCTL(CDROMSUBCHNL)
-COMPATIBLE_IOCTL(CDROMEJECT_SW)
+ULONG_IOCTL(CDROMEJECT_SW)
 COMPATIBLE_IOCTL(CDROMMULTISESSION)
 COMPATIBLE_IOCTL(CDROM_GET_MCN)
 COMPATIBLE_IOCTL(CDROMRESET)
@@ -356,16 +356,16 @@
 COMPATIBLE_IOCTL(CDROMSEEK)
 COMPATIBLE_IOCTL(CDROMPLAYBLK)
 COMPATIBLE_IOCTL(CDROMCLOSETRAY)
-COMPATIBLE_IOCTL(CDROM_SET_OPTIONS)
-COMPATIBLE_IOCTL(CDROM_CLEAR_OPTIONS)
-COMPATIBLE_IOCTL(CDROM_SELECT_SPEED)
-COMPATIBLE_IOCTL(CDROM_SELECT_DISC)
-COMPATIBLE_IOCTL(CDROM_MEDIA_CHANGED)
-COMPATIBLE_IOCTL(CDROM_DRIVE_STATUS)
+ULONG_IOCTL(CDROM_SET_OPTIONS)
+ULONG_IOCTL(CDROM_CLEAR_OPTIONS)
+ULONG_IOCTL(CDROM_SELECT_SPEED)
+ULONG_IOCTL(CDROM_SELECT_DISC)
+ULONG_IOCTL(CDROM_MEDIA_CHANGED)
+ULONG_IOCTL(CDROM_DRIVE_STATUS)
 COMPATIBLE_IOCTL(CDROM_DISC_STATUS)
 COMPATIBLE_IOCTL(CDROM_CHANGER_NSLOTS)
-COMPATIBLE_IOCTL(CDROM_LOCKDOOR)
-COMPATIBLE_IOCTL(CDROM_DEBUG)
+ULONG_IOCTL(CDROM_LOCKDOOR)
+ULONG_IOCTL(CDROM_DEBUG)
 COMPATIBLE_IOCTL(CDROM_GET_CAPABILITY)
 /* Ignore cdrom.h about these next 5 ioctls, they absolutely do
  * not take a struct cdrom_read, instead they take a struct cdrom_msf
@@ -381,13 +381,12 @@
 COMPATIBLE_IOCTL(DVD_WRITE_STRUCT)
 COMPATIBLE_IOCTL(DVD_AUTH)
 /* Big L */
-COMPATIBLE_IOCTL(LOOP_SET_FD)
+ULONG_IOCTL(LOOP_SET_FD)
 COMPATIBLE_IOCTL(LOOP_CLR_FD)
 COMPATIBLE_IOCTL(LOOP_GET_STATUS64)
 COMPATIBLE_IOCTL(LOOP_SET_STATUS64)
 /* Big A */
 /* sparc only */
-#if defined(CONFIG_SOUND) || defined (CONFIG_SOUND_MODULE)
 /* Big Q for sound/OSS */
 COMPATIBLE_IOCTL(SNDCTL_SEQ_RESET)
 COMPATIBLE_IOCTL(SNDCTL_SEQ_SYNC)
@@ -542,10 +541,9 @@
 COMPATIBLE_IOCTL(SOUND_MIXER_GETLEVELS)
 COMPATIBLE_IOCTL(SOUND_MIXER_SETLEVELS)
 COMPATIBLE_IOCTL(OSS_GETVERSION)
-#endif
 /* AUTOFS */
-COMPATIBLE_IOCTL(AUTOFS_IOC_READY)
-COMPATIBLE_IOCTL(AUTOFS_IOC_FAIL)
+ULONG_IOCTL(AUTOFS_IOC_READY)
+ULONG_IOCTL(AUTOFS_IOC_FAIL)
 COMPATIBLE_IOCTL(AUTOFS_IOC_CATATONIC)
 COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER)
 COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE)
@@ -572,7 +570,6 @@
 COMPATIBLE_IOCTL(NCP_IOC_SETCHARSETS)
 COMPATIBLE_IOCTL(NCP_IOC_GETDENTRYTTL)
 COMPATIBLE_IOCTL(NCP_IOC_SETDENTRYTTL)
-#if defined(CONFIG_ATM) || defined(CONFIG_ATM_MODULE)
 /* Little a */
 COMPATIBLE_IOCTL(ATMSIGD_CTRL)
 COMPATIBLE_IOCTL(ATMARPD_CTRL)
@@ -589,7 +586,6 @@
 COMPATIBLE_IOCTL(ATMTCP_REMOVE)
 COMPATIBLE_IOCTL(ATMMPC_CTRL)
 COMPATIBLE_IOCTL(ATMMPC_DATA)
-#endif
 /* Big W */
 /* WIOC_GETSUPPORT not yet implemented -E */
 COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
@@ -604,7 +600,6 @@
 COMPATIBLE_IOCTL(RNDADDENTROPY)
 COMPATIBLE_IOCTL(RNDZAPENTCNT)
 COMPATIBLE_IOCTL(RNDCLEARPOOL)
-#if defined(CONFIG_BT) || defined(CONFIG_BT_MODULE)
 /* Bluetooth ioctls */
 COMPATIBLE_IOCTL(HCIDEVUP)
 COMPATIBLE_IOCTL(HCIDEVDOWN)
@@ -635,8 +630,6 @@
 COMPATIBLE_IOCTL(BNEPCONNDEL)
 COMPATIBLE_IOCTL(BNEPGETCONNLIST)
 COMPATIBLE_IOCTL(BNEPGETCONNINFO)
-#endif
-#ifdef CONFIG_PCI
 /* Misc. */
 COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
 COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
@@ -644,8 +637,6 @@
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
-#endif
-#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
 /* USB */
 COMPATIBLE_IOCTL(USBDEVFS_RESETEP)
 COMPATIBLE_IOCTL(USBDEVFS_SETINTERFACE)
@@ -658,8 +649,6 @@
 COMPATIBLE_IOCTL(USBDEVFS_HUB_PORTINFO)
 COMPATIBLE_IOCTL(USBDEVFS_RESET)
 COMPATIBLE_IOCTL(USBDEVFS_CLEAR_HALT)
-#endif
-#if defined(CONFIG_MTD) || defined(CONFIG_MTD_MODULE)
 /* MTD */
 COMPATIBLE_IOCTL(MEMGETINFO)
 COMPATIBLE_IOCTL(MEMERASE)
@@ -667,14 +656,13 @@
 COMPATIBLE_IOCTL(MEMUNLOCK)
 COMPATIBLE_IOCTL(MEMGETREGIONCOUNT)
 COMPATIBLE_IOCTL(MEMGETREGIONINFO)
-#endif
 /* NBD */
-COMPATIBLE_IOCTL(NBD_SET_SOCK)
-COMPATIBLE_IOCTL(NBD_SET_BLKSIZE)
-COMPATIBLE_IOCTL(NBD_SET_SIZE)
+ULONG_IOCTL(NBD_SET_SOCK)
+ULONG_IOCTL(NBD_SET_BLKSIZE)
+ULONG_IOCTL(NBD_SET_SIZE)
 COMPATIBLE_IOCTL(NBD_DO_IT)
 COMPATIBLE_IOCTL(NBD_CLEAR_SOCK)
 COMPATIBLE_IOCTL(NBD_CLEAR_QUE)
 COMPATIBLE_IOCTL(NBD_PRINT_DEBUG)
-COMPATIBLE_IOCTL(NBD_SET_SIZE_BLOCKS)
+ULONG_IOCTL(NBD_SET_SIZE_BLOCKS)
 COMPATIBLE_IOCTL(NBD_DISCONNECT)
===== include/net/sock.h 1.46 vs edited =====
--- 1.46/include/net/sock.h	Wed Jun 18 22:59:01 2003
+++ edited/include/net/sock.h	Mon Oct  6 13:41:20 2003
@@ -1080,6 +1080,7 @@
 extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
 
-int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
+int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, 
+			unsigned long arg, struct file *f);
 
 #endif	/* _SOCK_H */
===== fs/compat.c 1.17 vs edited =====
--- 1.17/fs/compat.c	Fri Sep 26 01:23:21 2003
+++ edited/fs/compat.c	Mon Oct  6 13:41:20 2003
@@ -405,7 +405,7 @@
 		else
 			error = sys_ioctl(fd, cmd, arg);
 	} else if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
-		error = siocdevprivate_ioctl(fd, cmd, arg);
+		error = siocdevprivate_ioctl(fd, cmd, arg, filp);
 	} else {
 		static int count;
 		if (++count <= 50) { 

