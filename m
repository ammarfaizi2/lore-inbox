Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbTJHW40 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 18:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTJHW40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 18:56:26 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:52414 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261429AbTJHWzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 18:55:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pavel Machek <pavel@suse.cz>, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] cleanup of compat_ioctl functions
Date: Thu, 9 Oct 2003 00:49:50 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200310081809.42859.arnd@arndb.de> <20031008140207.666a62c9.davem@redhat.com> <20031008213544.GB1238@elf.ucw.cz>
In-Reply-To: <20031008213544.GB1238@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310090049.50925.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 October 2003 23:35, Pavel Machek wrote:
> > That doesn't make any sense, the fact that fs/compat_ioctl.c isn't
> > using the proper compat user pointer accessor macros is a bug,
> > so just fix that.
> >
> > It defeats the whole purpose of this compat layer if people still
> > need to duplicate the code in some cases.
>
> Agreed, your changes are trivial and reviewed extremely easily. That
> is not going to break anything. Okay, I guess no need to change __u16
> into anything...

Ok, here is a new version of the patch, this time only changing those
lines that bite us on s390 and adding the FIXMEs, but leaving out
all __user annotations and other cleanups.

	Arnd <><

===== fs/compat_ioctl.c 1.10 vs edited =====
--- 1.10/fs/compat_ioctl.c	Sun Oct  5 08:08:05 2003
+++ edited/fs/compat_ioctl.c	Thu Oct  9 00:37:49 2003
@@ -128,7 +128,7 @@
 	set_fs (KERNEL_DS);
 	err = sys_ioctl(fd, cmd, (unsigned long)&val);
 	set_fs (old_fs);
-	if (!err && put_user(val, (u32 *)arg))
+	if (!err && put_user(val, (u32 *)compat_ptr(arg)))
 		return -EFAULT;
 	return err;
 }
@@ -139,12 +139,12 @@
 	int err;
 	unsigned long val;
 	
-	if(get_user(val, (u32 *)arg))
+	if(get_user(val, (u32 *) compat_ptr(arg)))
 		return -EFAULT;
 	set_fs (KERNEL_DS);
 	err = sys_ioctl(fd, cmd, (unsigned long)&val);
 	set_fs (old_fs);
-	if (!err && put_user(val, (u32 *)arg))
+	if (!err && put_user(val, (u32 *) compat_ptr(arg)))
 		return -EFAULT;
 	return err;
 }
@@ -158,9 +158,9 @@
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
@@ -212,7 +212,7 @@
 
 	if(get_user(tmp, &up->base))
 		return -EFAULT;
-	kp->base = (void *) ((unsigned long)tmp);
+	kp->base = compat_ptr(tmp);
 	__get_user(kp->height, &up->height);
 	__get_user(kp->width, &up->width);
 	__get_user(kp->depth, &up->depth);
@@ -336,7 +336,7 @@
 		unsigned long vx;
 	} karg;
 	mm_segment_t old_fs = get_fs();
-	void *up = (void *)arg;
+	void *up = compat_ptr(arg);
 	int err = 0;
 
 	/* First, convert the command. */
@@ -404,7 +404,7 @@
 
 static int do_siocgstamp(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct compat_timeval *up = (struct compat_timeval *)arg;
+	struct compat_timeval *up = compat_ptr(arg);
 	struct timeval ktv;
 	mm_segment_t old_fs = get_fs();
 	int err;
@@ -463,7 +463,7 @@
 	struct ifreq32 ifr32;
 	int err;
 
-	if (copy_from_user(&ifr32, (struct ifreq32 *)arg, sizeof(struct ifreq32)))
+	if (copy_from_user(&ifr32, compat_ptr(arg), sizeof(ifr32)))
 		return -EFAULT;
 
 	dev = dev_get_by_index(ifr32.ifr_ifindex);
@@ -473,7 +473,7 @@
 	strlcpy(ifr32.ifr_name, dev->name, sizeof(ifr32.ifr_name));
 	dev_put(dev);
 	
-	err = copy_to_user((struct ifreq32 *)arg, &ifr32, sizeof(struct ifreq32));
+	err = copy_to_user(compat_ptr(arg), &ifr32, sizeof(ifr32));
 	return (err ? -EFAULT : 0);
 }
 #endif
@@ -488,7 +488,7 @@
 	unsigned int i, j;
 	int err;
 
-	if (copy_from_user(&ifc32, (struct ifconf32 *)arg, sizeof(struct ifconf32)))
+	if (copy_from_user(&ifc32, compat_ptr(arg), sizeof(struct ifconf32)))
 		return -EFAULT;
 
 	if(ifc32.ifcbuf == 0) {
@@ -498,6 +498,7 @@
 	} else {
 		ifc.ifc_len = ((ifc32.ifc_len / sizeof (struct ifreq32)) + 1) *
 			sizeof (struct ifreq);
+		/* should the size be limited? -arnd */
 		ifc.ifc_buf = kmalloc (ifc.ifc_len, GFP_KERNEL);
 		if (!ifc.ifc_buf)
 			return -ENOMEM;
@@ -543,7 +544,7 @@
 				else
 					ifc32.ifc_len = i - sizeof (struct ifreq32);
 			}
-			if (copy_to_user((struct ifconf32 *)arg, &ifc32, sizeof(struct ifconf32)))
+			if (copy_to_user(compat_ptr(arg), &ifc32, sizeof(struct ifconf32)))
 				err = -EFAULT;
 		}
 	}
@@ -560,7 +561,7 @@
 	void *datap;
 	
 	ifr = compat_alloc_user_space(sizeof(*ifr));
-	ifr32 = (struct ifreq32 *) arg;
+	ifr32 = compat_ptr(arg);
 
 	if (copy_in_user(&ifr->ifr_name, &ifr32->ifr_name, IFNAMSIZ))
 		return -EFAULT;
@@ -568,18 +569,18 @@
 	if (get_user(data, &ifr32->ifr_ifru.ifru_data))
 		return -EFAULT;
 
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &ifr->ifr_ifru.ifru_data))
 		return -EFAULT;
 
 	return sys_ioctl(fd, cmd, (unsigned long) ifr);
 }
 
-static int bond_ioctl(unsigned long fd, unsigned int cmd, unsigned long arg)
+static int bond_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct ifreq kifr;
 	struct ifreq *uifr;
-	struct ifreq32 *ifr32 = (struct ifreq32 *) arg;
+	struct ifreq32 *ifr32 = compat_ptr(arg);
 	mm_segment_t old_fs;
 	int err;
 	u32 data;
@@ -621,7 +622,7 @@
 int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct ifreq *u_ifreq64;
-	struct ifreq32 *u_ifreq32 = (struct ifreq32 *) arg;
+	struct ifreq32 *u_ifreq32 = compat_ptr(arg);
 	char tmp_buf[IFNAMSIZ];
 	void *data64;
 	u32 data32;
@@ -647,23 +648,27 @@
 static int dev_ifsioc(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct ifreq ifr;
+	struct ifreq32 *uifr32;
+	struct ifmap32 *uifmap32;
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
@@ -684,17 +689,17 @@
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
@@ -748,25 +753,28 @@
 	struct socket *mysock = sockfd_lookup(fd, &ret);
 
 	if (mysock && mysock->sk && mysock->sk->sk_family == AF_INET6) { /* ipv6 */
-		ret = copy_from_user (&r6.rtmsg_dst, &(((struct in6_rtmsg32 *)arg)->rtmsg_dst),
+		struct in6_rtmsg32 *ur6 = compat_ptr(arg);
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
+		struct rtentry32 *ur4 = compat_ptr(arg);
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
@@ -780,7 +788,7 @@
 		return -EFAULT;
 
 	set_fs (KERNEL_DS);
-	ret = sys_ioctl (fd, cmd, (long) r);
+	ret = sys_ioctl (fd, cmd, (unsigned long) r);
 	set_fs (old_fs);
 
 	if (mysock)
@@ -800,14 +808,16 @@
 {
 	mm_segment_t old_fs = get_fs();
 	struct hd_geometry geo;
+	struct hd_geometry32 *ugeo;
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
@@ -845,7 +855,7 @@
 
 	if (get_user(data, ptr32))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, ptr64))
 		return -EFAULT;
 	return 0;
@@ -858,7 +868,7 @@
 	int err;
 
 	cmap = compat_alloc_user_space(sizeof(*cmap));
-	cmap32 = (struct fb_cmap32 *) arg;
+	cmap32 = compat_ptr(arg);
 
 	if (copy_in_user(&cmap->start, &cmap32->start, 2 * sizeof(__u32)))
 		return -EFAULT;
@@ -918,7 +928,7 @@
 	struct fb_fix_screeninfo32 *fix32;
 	int err;
 
-	fix32 = (struct fb_fix_screeninfo32 *) arg;
+	fix32 = compat_ptr(arg);
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -972,7 +982,7 @@
 	set_fs(old_fs);
 
 	if(error == 0) {
-		uvp = (unsigned int *)arg;
+		uvp = compat_ptr(arg);
 		if(put_user(kval, uvp))
 			error = -EFAULT;
 	}
@@ -1022,12 +1032,12 @@
 
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
 
@@ -1040,7 +1050,7 @@
 	void *dxferp;
 	int err;
 
-	sgio32 = (sg_io_hdr32_t *) arg;
+	sgio32 = compat_ptr(arg);
 	if (get_user(iovec_count, &sgio32->iovec_count))
 		return -EFAULT;
 
@@ -1067,7 +1077,7 @@
 
 	if (get_user(data, &sgio32->dxferp))
 		return -EFAULT;
-	dxferp = (void *) (unsigned long) data;
+	dxferp = compat_ptr(data);
 	if (iovec_count) {
 		if (sg_build_iovec(sgio, dxferp, iovec_count))
 			return -EFAULT;
@@ -1081,11 +1091,11 @@
 
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
@@ -1098,7 +1108,7 @@
 
 	if (get_user(data, &sgio32->usr_ptr))
 		return -EFAULT;
-	if (put_user((void *)(unsigned long)data, &sgio->usr_ptr))
+	if (put_user(compat_ptr(data), &sgio->usr_ptr))
 		return -EFAULT;
 
 	if (copy_in_user(&sgio->status, &sgio32->status,
@@ -1137,7 +1147,7 @@
 
 static int ppp_sock_fprog_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct sock_fprog32 *u_fprog32 = (struct sock_fprog32 *) arg;
+	struct sock_fprog32 *u_fprog32 = compat_ptr(arg);
 	struct sock_fprog *u_fprog64 = compat_alloc_user_space(sizeof(struct sock_fprog));
 	void *fptr64;
 	u32 fptr32;
@@ -1182,7 +1192,7 @@
 	int err;
 
 	idle = compat_alloc_user_space(sizeof(*idle));
-	idle32 = (struct ppp_idle32 *) arg;
+	idle32 = compat_ptr(arg);
 
 	err = sys_ioctl(fd, PPPIOCGIDLE, (unsigned long) idle);
 
@@ -1204,12 +1214,12 @@
 	void *datap;
 
 	odata = compat_alloc_user_space(sizeof(*odata));
-	odata32 = (struct ppp_option_data32 *) arg;
+	odata32 = compat_ptr(arg);
 
 	if (get_user(data, &odata32->ptr))
 		return -EFAULT;
 
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &odata->ptr))
 		return -EFAULT;
 
@@ -1293,8 +1303,11 @@
 {
 	mm_segment_t old_fs = get_fs();
 	struct mtconfiginfo info;
+	struct mtconfiginfo32 *uinfo32;
 	struct mtget get;
+	struct mtget32 *umget32;
 	struct mtpos pos;
+	struct mtpos32 *upos32;
 	unsigned long kcmd;
 	void *karg;
 	int err = 0;
@@ -1315,15 +1328,17 @@
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
+				     (char *)&uinfo32->debug
+				     + sizeof(uinfo32->debug), sizeof(__u32));
 		if (err)
 			return -EFAULT;
 		break;
@@ -1344,26 +1359,29 @@
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
+		err |= __copy_to_user((char *)&uinfo32->debug
+			    		   + sizeof(uinfo32->debug),
 					   (char *)&info.debug + sizeof(info.debug), sizeof(__u32));
 		break;
 	case MTIOCSETCONFIG32:
@@ -1399,7 +1417,7 @@
 	void *datap;
 
 	cdread_audio = compat_alloc_user_space(sizeof(*cdread_audio));
-	cdread_audio32 = (struct cdrom_read_audio32 *) arg;
+	cdread_audio32 = compat_ptr(arg);
 
 	if (copy_in_user(&cdread_audio->addr,
 			 &cdread_audio32->addr,
@@ -1409,7 +1427,7 @@
 
 	if (get_user(data, &cdread_audio32->buf))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &cdread_audio->buf))
 		return -EFAULT;
 
@@ -1423,7 +1441,7 @@
 
 	if (get_user(data, ptr32))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, ptr64))
 		return -EFAULT;
 
@@ -1437,7 +1455,7 @@
 	unsigned char dir;
 
 	cgc = compat_alloc_user_space(sizeof(*cgc));
-	cgc32 = (struct cdrom_generic_command32 *) arg;
+	cgc32 = compat_ptr(arg);
 
 	if (copy_in_user(&cgc->cmd, &cgc32->cmd, sizeof(cgc->cmd)) ||
 	    __cgc_do_ptr((void **) &cgc->buffer, &cgc32->buffer) ||
@@ -1507,16 +1525,18 @@
 {
 	mm_segment_t old_fs = get_fs();
 	struct loop_info l;
+	struct loop_info32 *ul;
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
@@ -1530,12 +1550,12 @@
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
@@ -1585,10 +1605,11 @@
 	compat_caddr_t chardata;	/* font data in expanded form */
 };
 
-static int do_fontx_ioctl(unsigned int fd, int cmd, struct consolefontdesc32 *user_cfd, struct file *file)
+static int do_fontx_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)
 {
 	struct consolefontdesc cfdarg;
 	struct console_font_op op;
+	struct consolefontdesc32 *user_cfd = compat_ptr(arg);
 	int i, perm;
 
 	perm = vt_check(file);
@@ -1640,9 +1661,10 @@
 	compat_caddr_t data;    /* font data with height fixed to 32 */
 };
                                         
-static int do_kdfontop_ioctl(unsigned int fd, unsigned int cmd, struct console_font_op32 *fontop, struct file *file)
+static int do_kdfontop_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)
 {
 	struct console_font_op op;
+	struct console_font_op32 *fontop = compat_ptr(arg);
 	int perm = vt_check(file), i;
 	struct vt_struct *vt;
 	
@@ -1668,9 +1690,10 @@
 	compat_caddr_t entries;
 };
 
-static int do_unimap_ioctl(unsigned int fd, unsigned int cmd, struct unimapdesc32 *user_ud, struct file *file)
+static int do_unimap_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)
 {
 	struct unimapdesc32 tmp;
+	struct unimapdesc32 *user_ud = compat_ptr(arg);
 	int perm = vt_check(file);
 	
 	if (perm < 0) return perm;
@@ -1701,7 +1724,7 @@
 	set_fs(old_fs);
 
 	if (err >= 0)
-		err = put_user(kuid, (compat_pid_t *)arg);
+		err = put_user(kuid, (compat_pid_t *)compat_ptr(arg));
 
 	return err;
 }
@@ -1770,12 +1793,12 @@
 	int len, err;
 
 	iobuf = compat_alloc_user_space(sizeof(*iobuf));
-	iobuf32 = (struct atm_iobuf32 *) arg;
+	iobuf32 = compat_ptr(arg);
 
 	if (get_user(len, &iobuf32->length) ||
 	    get_user(data, &iobuf32->buffer))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(len, &iobuf->length) ||
 	    put_user(datap, &iobuf->buffer))
 		return -EFAULT;
@@ -1800,12 +1823,12 @@
 	int err;
         
 	sioc = compat_alloc_user_space(sizeof(*sioc));
-	sioc32 = (struct atmif_sioc32 *) arg;
+	sioc32 = compat_ptr(arg);
 
 	if (copy_in_user(&sioc->number, &sioc32->number, 2 * sizeof(int)) ||
 	    get_user(data, &sioc32->arg))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &sioc->arg))
 		return -EFAULT;
 
@@ -1888,25 +1911,32 @@
 	compat_int_t datalen;
 	compat_caddr_t data;
 };
-                                
-static int blkpg_ioctl_trans(unsigned int fd, unsigned int cmd, struct blkpg_ioctl_arg32 *arg)
+
+static int blkpg_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct blkpg_ioctl_arg a;
+	struct blkpg_ioctl_arg32 *ua32;
 	struct blkpg_partition p;
+	struct blkpg_partition *up32;
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
@@ -1930,18 +1960,18 @@
 
 static int do_blkbszget(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-       return sys_ioctl(fd, BLKBSZGET, arg);
+       return sys_ioctl(fd, BLKBSZGET, (unsigned long)compat_ptr(arg));
 }
 
 static int do_blkbszset(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-       return sys_ioctl(fd, BLKBSZSET, arg);
+       return sys_ioctl(fd, BLKBSZSET, (unsigned long)compat_ptr(arg));
 }
 
 static int do_blkgetsize64(unsigned int fd, unsigned int cmd,
                           unsigned long arg)
 {
-       return sys_ioctl(fd, BLKGETSIZE64, arg);
+       return sys_ioctl(fd, BLKGETSIZE64, (unsigned long)compat_ptr(arg));
 }
 
 /* Bluetooth ioctls */
@@ -2078,23 +2108,25 @@
 		case FDDEFPRM32:
 		case FDGETPRM32:
 		{
+			struct floppy_struct32 *uf;
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
@@ -2104,32 +2136,34 @@
 		case FDSETDRVPRM32:
 		case FDGETDRVPRM32:
 		{
+			struct floppy_drive_params32 *uf;
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
@@ -2174,83 +2208,90 @@
 			err |= __put_user(f->rate, &((struct floppy_struct32 *)arg)->rate);
 			err |= __put_user(f->spec1, &((struct floppy_struct32 *)arg)->spec1);
 			err |= __put_user(f->fmt_gap, &((struct floppy_struct32 *)arg)->fmt_gap);
-			err |= __put_user((u64)f->name, &((struct floppy_struct32 *)arg)->name);
+			err |= __put_user((u64)f->name, (compat_caddr_t*)&((struct floppy_struct32 *)arg)->name);
 			break;
 		}
 		case FDGETDRVPRM32:
 		{
+			struct floppy_drive_params32 *uf;
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
+			struct floppy_drive_struct32 *uf;
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
+			struct floppy_fdc_state32 *uf;
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
+			err |= __copy_to_user((char *)&uf->address + sizeof(uf->address),
 					   (char *)&f->address + sizeof(f->address), sizeof(int));
-			err |= __put_user(f->driver_version, &((struct floppy_fdc_state32 *)arg)->driver_version);
-			err |= __copy_to_user(((struct floppy_fdc_state32 *)arg)->track, f->track, sizeof(f->track));
+			err |= __put_user(f->driver_version, &uf->driver_version);
+			err |= __copy_to_user(uf->track, f->track, sizeof(f->track));
 			break;
 		}
 		case FDWERRORGET32:
 		{
+			struct floppy_write_errors32 *uf;
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
@@ -2275,7 +2316,7 @@
 static int mtd_rw_oob(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct mtd_oob_buf	*buf = compat_alloc_user_space(sizeof(*buf));
-	struct mtd_oob_buf32	*buf32 = (struct mtd_oob_buf32 *) arg;
+	struct mtd_oob_buf32	*buf32 = compat_ptr(arg);
 	u32 data;
 	char *datap;
 	unsigned int real_cmd;
@@ -2288,7 +2329,7 @@
 			 2 * sizeof(u32)) ||
 	    get_user(data, &buf32->ptr))
 		return -EFAULT;
-	datap = (void *) (unsigned long) data;
+	datap = compat_ptr(data);
 	if (put_user(datap, &buf->ptr))
 		return -EFAULT;
 
@@ -2322,7 +2363,7 @@
         return ret;
 }
 
-static int vfat_ioctl32(unsigned fd, unsigned cmd,  void *ptr)
+static int vfat_ioctl32(unsigned fd, unsigned cmd, unsigned long arg)
 {
 	int ret;
 	mm_segment_t oldfs = get_fs();
@@ -2342,8 +2383,8 @@
 	ret = sys_ioctl(fd,cmd,(unsigned long)&d);
 	set_fs(oldfs);
 	if (ret >= 0) {
-		ret |= put_dirent32(&d[0], (struct compat_dirent *)ptr);
-		ret |= put_dirent32(&d[1], ((struct compat_dirent *)ptr) + 1);
+		ret |= put_dirent32(&d[0], (struct compat_dirent *)compat_ptr(arg));
+		ret |= put_dirent32(&d[1], ((struct compat_dirent *)compat_ptr(arg)) + 1);
 	}
 	return ret;
 }
@@ -2403,7 +2444,7 @@
         return ret;
 }
 
-static int raw_ioctl(unsigned fd, unsigned cmd,  void *ptr)
+static int raw_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
 {
         int ret;
 
@@ -2411,7 +2452,7 @@
         case RAW_SETBIND:
         case RAW_GETBIND: {
                 struct raw_config_request req;
-                struct raw32_config_request *user_req = ptr;
+                struct raw32_config_request *user_req = compat_ptr(arg);
                 mm_segment_t oldfs = get_fs();
 
                 if ((ret = get_raw32_request(&req, user_req)))
@@ -2427,7 +2468,7 @@
                 break;
         }
         default:
-                ret = sys_ioctl(fd,cmd,(unsigned long)ptr);
+                ret = sys_ioctl(fd, cmd, arg);
                 break;
         }
         return ret;
@@ -2451,14 +2492,15 @@
         compat_uint_t   iomem_base;
         unsigned short  iomem_reg_shift;
         unsigned int    port_high;
+     /* compat_ulong_t  iomap_base FIXME */
         compat_int_t    reserved[1];
 };
 
-static int serial_struct_ioctl(unsigned fd, unsigned cmd,  void *ptr)
+static int serial_struct_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
 {
         typedef struct serial_struct SS;
         typedef struct serial_struct32 SS32;
-        struct serial_struct32 *ss32 = ptr;
+        struct serial_struct32 *ss32 = compat_ptr(arg);
         int err;
         struct serial_struct ss;
         mm_segment_t oldseg = get_fs();
@@ -2512,7 +2554,7 @@
         void *uptr, *kptr;
         int err;
 
-        uctrl = (struct usbdevfs_ctrltransfer32 *) arg;
+        uctrl = compat_ptr(arg);
 
         if (copy_from_user(&kctrl, uctrl,
                            (sizeof(struct usbdevfs_ctrltransfer32) -
@@ -2573,7 +2615,7 @@
         void *uptr, *kptr;
         int err;
 
-	ubulk = (struct usbdevfs_bulktransfer32 *) arg;
+	ubulk = compat_ptr(arg);
 
         if (get_user(kbulk.ep, &ubulk->ep) ||
             get_user(kbulk.len, &ubulk->len) ||
@@ -2768,7 +2810,7 @@
 	unsigned int buflen;
 	int err;
 
-	uurb = (struct usbdevfs_urb32 *) arg;
+	uurb = compat_ptr(arg);
 
 	err = -ENOMEM;
 	kurb = kmalloc(sizeof(struct usbdevfs_urb) +
@@ -2833,7 +2875,7 @@
         set_fs(old_fs);
 
         if (err >= 0 &&
-            put_user((u32)(u64)kptr, (u32 *)arg))
+            put_user((u32)(u64)kptr, (u32 *)compat_ptr(arg)))
                 err = -EFAULT;
 
         return err;
@@ -2854,13 +2896,13 @@
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
--- 1.10/include/linux/compat_ioctl.h	Thu Oct  2 07:12:22 2003
+++ edited/include/linux/compat_ioctl.h	Wed Oct  8 23:31:43 2003
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

