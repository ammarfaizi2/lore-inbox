Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVKEQlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVKEQlW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVKEQd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:33:58 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:22219 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932107AbVKEQdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:49 -0500
Message-Id: <20051105162710.631787000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:26:52 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/25] net: move socket ioctl32 to net/compat.c
Content-Disposition: inline; filename=netioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is very experimental and completely untested.

A substantial amount of the compat_ioctl code deals with
socked ioctls. This patch moves all socket ioctl conversions
over to net/compat.c in order to get it closer to the
respective device drivers.

It also adds the infrastructure to do compat_ioctl specific
to proto_ops, which will be used in further patches.

Also, the SIOCDEVPRIVATE handling is now local to a single
file and can probably be made driver specific in the
future.

All the conversion handlers are basically unmodified
in order to minimize the risk of silently breaking stuff.

CC: netdev@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/fs/compat_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat_ioctl.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/fs/compat_ioctl.c	2005-11-05 02:41:18.000000000 +0100
@@ -413,408 +413,6 @@
 	return err;
 }
 
-#ifdef CONFIG_NET
-static int do_siocgstamp(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct compat_timeval __user *up = compat_ptr(arg);
-	struct timeval ktv;
-	mm_segment_t old_fs = get_fs();
-	int err;
-
-	set_fs(KERNEL_DS);
-	err = sys_ioctl(fd, cmd, (unsigned long)&ktv);
-	set_fs(old_fs);
-	if(!err) {
-		err = put_user(ktv.tv_sec, &up->tv_sec);
-		err |= __put_user(ktv.tv_usec, &up->tv_usec);
-	}
-	return err;
-}
-
-struct ifmap32 {
-	compat_ulong_t mem_start;
-	compat_ulong_t mem_end;
-	unsigned short base_addr;
-	unsigned char irq;
-	unsigned char dma;
-	unsigned char port;
-};
-
-struct ifreq32 {
-#define IFHWADDRLEN     6
-#define IFNAMSIZ        16
-        union {
-                char    ifrn_name[IFNAMSIZ];            /* if name, e.g. "en0" */
-        } ifr_ifrn;
-        union {
-                struct  sockaddr ifru_addr;
-                struct  sockaddr ifru_dstaddr;
-                struct  sockaddr ifru_broadaddr;
-                struct  sockaddr ifru_netmask;
-                struct  sockaddr ifru_hwaddr;
-                short   ifru_flags;
-                compat_int_t     ifru_ivalue;
-                compat_int_t     ifru_mtu;
-                struct  ifmap32 ifru_map;
-                char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
-		char	ifru_newname[IFNAMSIZ];
-                compat_caddr_t ifru_data;
-	    /* XXXX? ifru_settings should be here */
-        } ifr_ifru;
-};
-
-struct ifconf32 {
-        compat_int_t	ifc_len;                        /* size of buffer       */
-        compat_caddr_t  ifcbuf;
-};
-
-static int dev_ifname32(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct net_device *dev;
-	struct ifreq32 ifr32;
-	int err;
-
-	if (copy_from_user(&ifr32, compat_ptr(arg), sizeof(ifr32)))
-		return -EFAULT;
-
-	dev = dev_get_by_index(ifr32.ifr_ifindex);
-	if (!dev)
-		return -ENODEV;
-
-	strlcpy(ifr32.ifr_name, dev->name, sizeof(ifr32.ifr_name));
-	dev_put(dev);
-	
-	err = copy_to_user(compat_ptr(arg), &ifr32, sizeof(ifr32));
-	return (err ? -EFAULT : 0);
-}
-
-static int dev_ifconf(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ifconf32 ifc32;
-	struct ifconf ifc;
-	struct ifconf __user *uifc;
-	struct ifreq32 __user *ifr32;
-	struct ifreq __user *ifr;
-	unsigned int i, j;
-	int err;
-
-	if (copy_from_user(&ifc32, compat_ptr(arg), sizeof(struct ifconf32)))
-		return -EFAULT;
-
-	if (ifc32.ifcbuf == 0) {
-		ifc32.ifc_len = 0;
-		ifc.ifc_len = 0;
-		ifc.ifc_req = NULL;
-		uifc = compat_alloc_user_space(sizeof(struct ifconf));
-	} else {
-		size_t len =((ifc32.ifc_len / sizeof (struct ifreq32)) + 1) *
-			sizeof (struct ifreq);
-		uifc = compat_alloc_user_space(sizeof(struct ifconf) + len);
-		ifc.ifc_len = len;
-		ifr = ifc.ifc_req = (void __user *)(uifc + 1);
-		ifr32 = compat_ptr(ifc32.ifcbuf);
-		for (i = 0; i < ifc32.ifc_len; i += sizeof (struct ifreq32)) {
-			if (copy_in_user(ifr, ifr32, sizeof(struct ifreq32)))
-				return -EFAULT;
-			ifr++;
-			ifr32++; 
-		}
-	}
-	if (copy_to_user(uifc, &ifc, sizeof(struct ifconf)))
-		return -EFAULT;
-
-	err = sys_ioctl (fd, SIOCGIFCONF, (unsigned long)uifc);	
-	if (err)
-		return err;
-
-	if (copy_from_user(&ifc, uifc, sizeof(struct ifconf))) 
-		return -EFAULT;
-
-	ifr = ifc.ifc_req;
-	ifr32 = compat_ptr(ifc32.ifcbuf);
-	for (i = 0, j = 0; i < ifc32.ifc_len && j < ifc.ifc_len;
-	     i += sizeof (struct ifreq32), j += sizeof (struct ifreq)) {
-		if (copy_in_user(ifr32, ifr, sizeof (struct ifreq32)))
-			return -EFAULT;
-		ifr32++;
-		ifr++;
-	}
-
-	if (ifc32.ifcbuf == 0) {
-		/* Translate from 64-bit structure multiple to
-		 * a 32-bit one.
-		 */
-		i = ifc.ifc_len;
-		i = ((i / sizeof(struct ifreq)) * sizeof(struct ifreq32));
-		ifc32.ifc_len = i;
-	} else {
-		if (i <= ifc32.ifc_len)
-			ifc32.ifc_len = i;
-		else
-			ifc32.ifc_len = i - sizeof (struct ifreq32);
-	}
-	if (copy_to_user(compat_ptr(arg), &ifc32, sizeof(struct ifconf32)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int ethtool_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ifreq __user *ifr;
-	struct ifreq32 __user *ifr32;
-	u32 data;
-	void __user *datap;
-	
-	ifr = compat_alloc_user_space(sizeof(*ifr));
-	ifr32 = compat_ptr(arg);
-
-	if (copy_in_user(&ifr->ifr_name, &ifr32->ifr_name, IFNAMSIZ))
-		return -EFAULT;
-
-	if (get_user(data, &ifr32->ifr_ifru.ifru_data))
-		return -EFAULT;
-
-	datap = compat_ptr(data);
-	if (put_user(datap, &ifr->ifr_ifru.ifru_data))
-		return -EFAULT;
-
-	return sys_ioctl(fd, cmd, (unsigned long) ifr);
-}
-
-static int bond_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ifreq kifr;
-	struct ifreq __user *uifr;
-	struct ifreq32 __user *ifr32 = compat_ptr(arg);
-	mm_segment_t old_fs;
-	int err;
-	u32 data;
-	void __user *datap;
-
-	switch (cmd) {
-	case SIOCBONDENSLAVE:
-	case SIOCBONDRELEASE:
-	case SIOCBONDSETHWADDR:
-	case SIOCBONDCHANGEACTIVE:
-		if (copy_from_user(&kifr, ifr32, sizeof(struct ifreq32)))
-			return -EFAULT;
-
-		old_fs = get_fs();
-		set_fs (KERNEL_DS);
-		err = sys_ioctl (fd, cmd, (unsigned long)&kifr);
-		set_fs (old_fs);
-
-		return err;
-	case SIOCBONDSLAVEINFOQUERY:
-	case SIOCBONDINFOQUERY:
-		uifr = compat_alloc_user_space(sizeof(*uifr));
-		if (copy_in_user(&uifr->ifr_name, &ifr32->ifr_name, IFNAMSIZ))
-			return -EFAULT;
-
-		if (get_user(data, &ifr32->ifr_ifru.ifru_data))
-			return -EFAULT;
-
-		datap = compat_ptr(data);
-		if (put_user(datap, &uifr->ifr_ifru.ifru_data))
-			return -EFAULT;
-
-		return sys_ioctl (fd, cmd, (unsigned long)uifr);
-	default:
-		return -EINVAL;
-	};
-}
-
-int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ifreq __user *u_ifreq64;
-	struct ifreq32 __user *u_ifreq32 = compat_ptr(arg);
-	char tmp_buf[IFNAMSIZ];
-	void __user *data64;
-	u32 data32;
-
-	if (copy_from_user(&tmp_buf[0], &(u_ifreq32->ifr_ifrn.ifrn_name[0]),
-			   IFNAMSIZ))
-		return -EFAULT;
-	if (__get_user(data32, &u_ifreq32->ifr_ifru.ifru_data))
-		return -EFAULT;
-	data64 = compat_ptr(data32);
-
-	u_ifreq64 = compat_alloc_user_space(sizeof(*u_ifreq64));
-
-	/* Don't check these user accesses, just let that get trapped
-	 * in the ioctl handler instead.
-	 */
-	if (copy_to_user(&u_ifreq64->ifr_ifrn.ifrn_name[0], &tmp_buf[0],
-			 IFNAMSIZ))
-		return -EFAULT;
-	if (__put_user(data64, &u_ifreq64->ifr_ifru.ifru_data))
-		return -EFAULT;
-
-	return sys_ioctl(fd, cmd, (unsigned long) u_ifreq64);
-}
-
-static int dev_ifsioc(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ifreq ifr;
-	struct ifreq32 __user *uifr32;
-	struct ifmap32 __user *uifmap32;
-	mm_segment_t old_fs;
-	int err;
-	
-	uifr32 = compat_ptr(arg);
-	uifmap32 = &uifr32->ifr_ifru.ifru_map;
-	switch (cmd) {
-	case SIOCSIFMAP:
-		err = copy_from_user(&ifr, uifr32, sizeof(ifr.ifr_name));
-		err |= __get_user(ifr.ifr_map.mem_start, &uifmap32->mem_start);
-		err |= __get_user(ifr.ifr_map.mem_end, &uifmap32->mem_end);
-		err |= __get_user(ifr.ifr_map.base_addr, &uifmap32->base_addr);
-		err |= __get_user(ifr.ifr_map.irq, &uifmap32->irq);
-		err |= __get_user(ifr.ifr_map.dma, &uifmap32->dma);
-		err |= __get_user(ifr.ifr_map.port, &uifmap32->port);
-		if (err)
-			return -EFAULT;
-		break;
-	default:
-		if (copy_from_user(&ifr, uifr32, sizeof(*uifr32)))
-			return -EFAULT;
-		break;
-	}
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, cmd, (unsigned long)&ifr);
-	set_fs (old_fs);
-	if (!err) {
-		switch (cmd) {
-		/* TUNSETIFF is defined as _IOW, it should be _IORW
-		 * as the data is copied back to user space, but that
-		 * cannot be fixed without breaking all existing apps.
-		 */
-		case TUNSETIFF:
-		case SIOCGIFFLAGS:
-		case SIOCGIFMETRIC:
-		case SIOCGIFMTU:
-		case SIOCGIFMEM:
-		case SIOCGIFHWADDR:
-		case SIOCGIFINDEX:
-		case SIOCGIFADDR:
-		case SIOCGIFBRDADDR:
-		case SIOCGIFDSTADDR:
-		case SIOCGIFNETMASK:
-		case SIOCGIFTXQLEN:
-			if (copy_to_user(uifr32, &ifr, sizeof(*uifr32)))
-				return -EFAULT;
-			break;
-		case SIOCGIFMAP:
-			err = copy_to_user(uifr32, &ifr, sizeof(ifr.ifr_name));
-			err |= __put_user(ifr.ifr_map.mem_start, &uifmap32->mem_start);
-			err |= __put_user(ifr.ifr_map.mem_end, &uifmap32->mem_end);
-			err |= __put_user(ifr.ifr_map.base_addr, &uifmap32->base_addr);
-			err |= __put_user(ifr.ifr_map.irq, &uifmap32->irq);
-			err |= __put_user(ifr.ifr_map.dma, &uifmap32->dma);
-			err |= __put_user(ifr.ifr_map.port, &uifmap32->port);
-			if (err)
-				err = -EFAULT;
-			break;
-		}
-	}
-	return err;
-}
-
-struct rtentry32 {
-        u32   		rt_pad1;
-        struct sockaddr rt_dst;         /* target address               */
-        struct sockaddr rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
-        struct sockaddr rt_genmask;     /* target network mask (IP)     */
-        unsigned short  rt_flags;
-        short           rt_pad2;
-        u32   		rt_pad3;
-        unsigned char   rt_tos;
-        unsigned char   rt_class;
-        short           rt_pad4;
-        short           rt_metric;      /* +1 for binary compatibility! */
-        /* char * */ u32 rt_dev;        /* forcing the device at add    */
-        u32   		rt_mtu;         /* per route MTU/Window         */
-        u32   		rt_window;      /* Window clamping              */
-        unsigned short  rt_irtt;        /* Initial RTT                  */
-
-};
-
-struct in6_rtmsg32 {
-	struct in6_addr		rtmsg_dst;
-	struct in6_addr		rtmsg_src;
-	struct in6_addr		rtmsg_gateway;
-	u32			rtmsg_type;
-	u16			rtmsg_dst_len;
-	u16			rtmsg_src_len;
-	u32			rtmsg_metric;
-	u32			rtmsg_info;
-	u32			rtmsg_flags;
-	s32			rtmsg_ifindex;
-};
-
-static int routing_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	int ret;
-	void *r = NULL;
-	struct in6_rtmsg r6;
-	struct rtentry r4;
-	char devname[16];
-	u32 rtdev;
-	mm_segment_t old_fs = get_fs();
-	
-	struct socket *mysock = sockfd_lookup(fd, &ret);
-
-	if (mysock && mysock->sk && mysock->sk->sk_family == AF_INET6) { /* ipv6 */
-		struct in6_rtmsg32 __user *ur6 = compat_ptr(arg);
-		ret = copy_from_user (&r6.rtmsg_dst, &(ur6->rtmsg_dst),
-			3 * sizeof(struct in6_addr));
-		ret |= __get_user (r6.rtmsg_type, &(ur6->rtmsg_type));
-		ret |= __get_user (r6.rtmsg_dst_len, &(ur6->rtmsg_dst_len));
-		ret |= __get_user (r6.rtmsg_src_len, &(ur6->rtmsg_src_len));
-		ret |= __get_user (r6.rtmsg_metric, &(ur6->rtmsg_metric));
-		ret |= __get_user (r6.rtmsg_info, &(ur6->rtmsg_info));
-		ret |= __get_user (r6.rtmsg_flags, &(ur6->rtmsg_flags));
-		ret |= __get_user (r6.rtmsg_ifindex, &(ur6->rtmsg_ifindex));
-		
-		r = (void *) &r6;
-	} else { /* ipv4 */
-		struct rtentry32 __user *ur4 = compat_ptr(arg);
-		ret = copy_from_user (&r4.rt_dst, &(ur4->rt_dst),
-					3 * sizeof(struct sockaddr));
-		ret |= __get_user (r4.rt_flags, &(ur4->rt_flags));
-		ret |= __get_user (r4.rt_metric, &(ur4->rt_metric));
-		ret |= __get_user (r4.rt_mtu, &(ur4->rt_mtu));
-		ret |= __get_user (r4.rt_window, &(ur4->rt_window));
-		ret |= __get_user (r4.rt_irtt, &(ur4->rt_irtt));
-		ret |= __get_user (rtdev, &(ur4->rt_dev));
-		if (rtdev) {
-			ret |= copy_from_user (devname, compat_ptr(rtdev), 15);
-			r4.rt_dev = devname; devname[15] = 0;
-		} else
-			r4.rt_dev = NULL;
-
-		r = (void *) &r4;
-	}
-
-	if (ret) {
-		ret = -EFAULT;
-		goto out;
-	}
-
-	set_fs (KERNEL_DS);
-	ret = sys_ioctl (fd, cmd, (unsigned long) r);
-	set_fs (old_fs);
-
-out:
-	if (mysock)
-		sockfd_put(mysock);
-
-	return ret;
-}
-#endif
-
 struct hd_geometry32 {
 	unsigned char heads;
 	unsigned char sectors;
@@ -1146,127 +744,6 @@
 	return err;
 }
 
-struct sock_fprog32 {
-	unsigned short	len;
-	compat_caddr_t	filter;
-};
-
-#define PPPIOCSPASS32	_IOW('t', 71, struct sock_fprog32)
-#define PPPIOCSACTIVE32	_IOW('t', 70, struct sock_fprog32)
-
-static int ppp_sock_fprog_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct sock_fprog32 __user *u_fprog32 = compat_ptr(arg);
-	struct sock_fprog __user *u_fprog64 = compat_alloc_user_space(sizeof(struct sock_fprog));
-	void __user *fptr64;
-	u32 fptr32;
-	u16 flen;
-
-	if (get_user(flen, &u_fprog32->len) ||
-	    get_user(fptr32, &u_fprog32->filter))
-		return -EFAULT;
-
-	fptr64 = compat_ptr(fptr32);
-
-	if (put_user(flen, &u_fprog64->len) ||
-	    put_user(fptr64, &u_fprog64->filter))
-		return -EFAULT;
-
-	if (cmd == PPPIOCSPASS32)
-		cmd = PPPIOCSPASS;
-	else
-		cmd = PPPIOCSACTIVE;
-
-	return sys_ioctl(fd, cmd, (unsigned long) u_fprog64);
-}
-
-struct ppp_option_data32 {
-	compat_caddr_t	ptr;
-	u32			length;
-	compat_int_t		transmit;
-};
-#define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
-
-struct ppp_idle32 {
-	compat_time_t xmit_idle;
-	compat_time_t recv_idle;
-};
-#define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
-
-static int ppp_gidle(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ppp_idle __user *idle;
-	struct ppp_idle32 __user *idle32;
-	__kernel_time_t xmit, recv;
-	int err;
-
-	idle = compat_alloc_user_space(sizeof(*idle));
-	idle32 = compat_ptr(arg);
-
-	err = sys_ioctl(fd, PPPIOCGIDLE, (unsigned long) idle);
-
-	if (!err) {
-		if (get_user(xmit, &idle->xmit_idle) ||
-		    get_user(recv, &idle->recv_idle) ||
-		    put_user(xmit, &idle32->xmit_idle) ||
-		    put_user(recv, &idle32->recv_idle))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-static int ppp_scompress(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ppp_option_data __user *odata;
-	struct ppp_option_data32 __user *odata32;
-	__u32 data;
-	void __user *datap;
-
-	odata = compat_alloc_user_space(sizeof(*odata));
-	odata32 = compat_ptr(arg);
-
-	if (get_user(data, &odata32->ptr))
-		return -EFAULT;
-
-	datap = compat_ptr(data);
-	if (put_user(datap, &odata->ptr))
-		return -EFAULT;
-
-	if (copy_in_user(&odata->length, &odata32->length,
-			 sizeof(__u32) + sizeof(int)))
-		return -EFAULT;
-
-	return sys_ioctl(fd, PPPIOCSCOMPRESS, (unsigned long) odata);
-}
-
-static int ppp_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	int err;
-
-	switch (cmd) {
-	case PPPIOCGIDLE32:
-		err = ppp_gidle(fd, cmd, arg);
-		break;
-
-	case PPPIOCSCOMPRESS32:
-		err = ppp_scompress(fd, cmd, arg);
-		break;
-
-	default:
-		do {
-			static int count;
-			if (++count <= 20)
-				printk("ppp_ioctl: Unknown cmd fd(%d) "
-				       "cmd(%08x) arg(%08x)\n",
-				       (int)fd, (unsigned int)cmd, (unsigned int)arg);
-		} while(0);
-		err = -EINVAL;
-		break;
-	};
-
-	return err;
-}
-
 
 struct mtget32 {
 	compat_long_t	mt_type;
@@ -1664,171 +1141,6 @@
 	return err;
 }
 
-struct atmif_sioc32 {
-        compat_int_t	number;
-        compat_int_t	length;
-        compat_caddr_t	arg;
-};
-
-struct atm_iobuf32 {
-	compat_int_t	length;
-	compat_caddr_t	buffer;
-};
-
-#define ATM_GETLINKRATE32 _IOW('a', ATMIOC_ITF+1, struct atmif_sioc32)
-#define ATM_GETNAMES32    _IOW('a', ATMIOC_ITF+3, struct atm_iobuf32)
-#define ATM_GETTYPE32     _IOW('a', ATMIOC_ITF+4, struct atmif_sioc32)
-#define ATM_GETESI32	  _IOW('a', ATMIOC_ITF+5, struct atmif_sioc32)
-#define ATM_GETADDR32	  _IOW('a', ATMIOC_ITF+6, struct atmif_sioc32)
-#define ATM_RSTADDR32	  _IOW('a', ATMIOC_ITF+7, struct atmif_sioc32)
-#define ATM_ADDADDR32	  _IOW('a', ATMIOC_ITF+8, struct atmif_sioc32)
-#define ATM_DELADDR32	  _IOW('a', ATMIOC_ITF+9, struct atmif_sioc32)
-#define ATM_GETCIRANGE32  _IOW('a', ATMIOC_ITF+10, struct atmif_sioc32)
-#define ATM_SETCIRANGE32  _IOW('a', ATMIOC_ITF+11, struct atmif_sioc32)
-#define ATM_SETESI32      _IOW('a', ATMIOC_ITF+12, struct atmif_sioc32)
-#define ATM_SETESIF32     _IOW('a', ATMIOC_ITF+13, struct atmif_sioc32)
-#define ATM_GETSTAT32     _IOW('a', ATMIOC_SARCOM+0, struct atmif_sioc32)
-#define ATM_GETSTATZ32    _IOW('a', ATMIOC_SARCOM+1, struct atmif_sioc32)
-#define ATM_GETLOOP32	  _IOW('a', ATMIOC_SARCOM+2, struct atmif_sioc32)
-#define ATM_SETLOOP32	  _IOW('a', ATMIOC_SARCOM+3, struct atmif_sioc32)
-#define ATM_QUERYLOOP32	  _IOW('a', ATMIOC_SARCOM+4, struct atmif_sioc32)
-
-static struct {
-        unsigned int cmd32;
-        unsigned int cmd;
-} atm_ioctl_map[] = {
-        { ATM_GETLINKRATE32, ATM_GETLINKRATE },
-	{ ATM_GETNAMES32,    ATM_GETNAMES },
-        { ATM_GETTYPE32,     ATM_GETTYPE },
-        { ATM_GETESI32,      ATM_GETESI },
-        { ATM_GETADDR32,     ATM_GETADDR },
-        { ATM_RSTADDR32,     ATM_RSTADDR },
-        { ATM_ADDADDR32,     ATM_ADDADDR },
-        { ATM_DELADDR32,     ATM_DELADDR },
-        { ATM_GETCIRANGE32,  ATM_GETCIRANGE },
-	{ ATM_SETCIRANGE32,  ATM_SETCIRANGE },
-	{ ATM_SETESI32,      ATM_SETESI },
-	{ ATM_SETESIF32,     ATM_SETESIF },
-	{ ATM_GETSTAT32,     ATM_GETSTAT },
-	{ ATM_GETSTATZ32,    ATM_GETSTATZ },
-	{ ATM_GETLOOP32,     ATM_GETLOOP },
-	{ ATM_SETLOOP32,     ATM_SETLOOP },
-	{ ATM_QUERYLOOP32,   ATM_QUERYLOOP }
-};
-
-#define NR_ATM_IOCTL (sizeof(atm_ioctl_map)/sizeof(atm_ioctl_map[0]))
-
-
-static int do_atm_iobuf(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct atm_iobuf   __user *iobuf;
-	struct atm_iobuf32 __user *iobuf32;
-	u32 data;
-	void __user *datap;
-	int len, err;
-
-	iobuf = compat_alloc_user_space(sizeof(*iobuf));
-	iobuf32 = compat_ptr(arg);
-
-	if (get_user(len, &iobuf32->length) ||
-	    get_user(data, &iobuf32->buffer))
-		return -EFAULT;
-	datap = compat_ptr(data);
-	if (put_user(len, &iobuf->length) ||
-	    put_user(datap, &iobuf->buffer))
-		return -EFAULT;
-
-	err = sys_ioctl(fd, cmd, (unsigned long)iobuf);
-
-	if (!err) {
-		if (copy_in_user(&iobuf32->length, &iobuf->length,
-				 sizeof(int)))
-			err = -EFAULT;
-	}
-
-	return err;
-}
-
-static int do_atmif_sioc(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-        struct atmif_sioc   __user *sioc;
-	struct atmif_sioc32 __user *sioc32;
-	u32 data;
-	void __user *datap;
-	int err;
-        
-	sioc = compat_alloc_user_space(sizeof(*sioc));
-	sioc32 = compat_ptr(arg);
-
-	if (copy_in_user(&sioc->number, &sioc32->number, 2 * sizeof(int)) ||
-	    get_user(data, &sioc32->arg))
-		return -EFAULT;
-	datap = compat_ptr(data);
-	if (put_user(datap, &sioc->arg))
-		return -EFAULT;
-
-	err = sys_ioctl(fd, cmd, (unsigned long) sioc);
-
-	if (!err) {
-		if (copy_in_user(&sioc32->length, &sioc->length,
-				 sizeof(int)))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-static int do_atm_ioctl(unsigned int fd, unsigned int cmd32, unsigned long arg)
-{
-        int i;
-        unsigned int cmd = 0;
-        
-	switch (cmd32) {
-	case SONET_GETSTAT:
-	case SONET_GETSTATZ:
-	case SONET_GETDIAG:
-	case SONET_SETDIAG:
-	case SONET_CLRDIAG:
-	case SONET_SETFRAMING:
-	case SONET_GETFRAMING:
-	case SONET_GETFRSENSE:
-		return do_atmif_sioc(fd, cmd32, arg);
-	}
-
-	for (i = 0; i < NR_ATM_IOCTL; i++) {
-		if (cmd32 == atm_ioctl_map[i].cmd32) {
-			cmd = atm_ioctl_map[i].cmd;
-			break;
-		}
-	}
-	if (i == NR_ATM_IOCTL)
-	        return -EINVAL;
-        
-        switch (cmd) {
-	case ATM_GETNAMES:
-		return do_atm_iobuf(fd, cmd, arg);
-	    
-	case ATM_GETLINKRATE:
-        case ATM_GETTYPE:
-        case ATM_GETESI:
-        case ATM_GETADDR:
-        case ATM_RSTADDR:
-        case ATM_ADDADDR:
-        case ATM_DELADDR:
-        case ATM_GETCIRANGE:
-	case ATM_SETCIRANGE:
-	case ATM_SETESI:
-	case ATM_SETESIF:
-	case ATM_GETSTAT:
-	case ATM_GETSTATZ:
-	case ATM_GETLOOP:
-	case ATM_SETLOOP:
-	case ATM_QUERYLOOP:
-                return do_atmif_sioc(fd, cmd, arg);
-        }
-
-        return -EINVAL;
-}
-
 static __attribute_used__ int 
 ret_einval(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -2641,65 +1953,6 @@
 	return sys_ioctl(fd, cmd, (unsigned long)tdata);
 }
 
-struct compat_iw_point {
-	compat_caddr_t pointer;
-	__u16 length;
-	__u16 flags;
-};
-
-static int do_wireless_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct iwreq __user *iwr;
-	struct iwreq __user *iwr_u;
-	struct iw_point __user *iwp;
-	struct compat_iw_point __user *iwp_u;
-	compat_caddr_t pointer;
-	__u16 length, flags;
-
-	iwr_u = compat_ptr(arg);
-	iwp_u = (struct compat_iw_point __user *) &iwr_u->u.data;
-	iwr = compat_alloc_user_space(sizeof(*iwr));
-	if (iwr == NULL)
-		return -ENOMEM;
-
-	iwp = &iwr->u.data;
-
-	if (!access_ok(VERIFY_WRITE, iwr, sizeof(*iwr)))
-		return -EFAULT;
-
-	if (__copy_in_user(&iwr->ifr_ifrn.ifrn_name[0],
-			   &iwr_u->ifr_ifrn.ifrn_name[0],
-			   sizeof(iwr->ifr_ifrn.ifrn_name)))
-		return -EFAULT;
-
-	if (__get_user(pointer, &iwp_u->pointer) ||
-	    __get_user(length, &iwp_u->length) ||
-	    __get_user(flags, &iwp_u->flags))
-		return -EFAULT;
-
-	if (__put_user(compat_ptr(pointer), &iwp->pointer) ||
-	    __put_user(length, &iwp->length) ||
-	    __put_user(flags, &iwp->flags))
-		return -EFAULT;
-
-	return sys_ioctl(fd, cmd, (unsigned long) iwr);
-}
-
-/* Since old style bridge ioctl's endup using SIOCDEVPRIVATE
- * for some operations; this forces use of the newer bridge-utils that
- * use compatiable ioctls
- */
-static int old_bridge_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	u32 tmp;
-
-	if (get_user(tmp, (u32 __user *) arg))
-		return -EFAULT;
-	if (tmp == BRCTL_GET_VERSION)
-		return BRCTL_VERSION + 1;
-	return -EINVAL;
-}
-
 #if defined(CONFIG_NCP_FS) || defined(CONFIG_NCP_FS_MODULE)
 struct ncp_ioctl_request_32 {
 	u32 function;
@@ -2893,59 +2146,6 @@
 #ifdef DECLARES
 HANDLE_IOCTL(MEMREADOOB32, mtd_rw_oob)
 HANDLE_IOCTL(MEMWRITEOOB32, mtd_rw_oob)
-#ifdef CONFIG_NET
-HANDLE_IOCTL(SIOCGIFNAME, dev_ifname32)
-HANDLE_IOCTL(SIOCGIFCONF, dev_ifconf)
-HANDLE_IOCTL(SIOCGIFFLAGS, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFFLAGS, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFMETRIC, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFMETRIC, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFMTU, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFMTU, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFMEM, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFMEM, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFHWADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFHWADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCADDMULTI, dev_ifsioc)
-HANDLE_IOCTL(SIOCDELMULTI, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFINDEX, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFMAP, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFMAP, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFADDR, dev_ifsioc)
-
-/* ioctls used by appletalk ddp.c */
-HANDLE_IOCTL(SIOCATALKDIFADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCDIFADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCSARP, dev_ifsioc)
-HANDLE_IOCTL(SIOCDARP, dev_ifsioc)
-
-HANDLE_IOCTL(SIOCGIFBRDADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFBRDADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFDSTADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFDSTADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFNETMASK, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFNETMASK, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFPFLAGS, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFPFLAGS, dev_ifsioc)
-HANDLE_IOCTL(SIOCGIFTXQLEN, dev_ifsioc)
-HANDLE_IOCTL(SIOCSIFTXQLEN, dev_ifsioc)
-HANDLE_IOCTL(TUNSETIFF, dev_ifsioc)
-HANDLE_IOCTL(SIOCETHTOOL, ethtool_ioctl)
-HANDLE_IOCTL(SIOCBONDENSLAVE, bond_ioctl)
-HANDLE_IOCTL(SIOCBONDRELEASE, bond_ioctl)
-HANDLE_IOCTL(SIOCBONDSETHWADDR, bond_ioctl)
-HANDLE_IOCTL(SIOCBONDSLAVEINFOQUERY, bond_ioctl)
-HANDLE_IOCTL(SIOCBONDINFOQUERY, bond_ioctl)
-HANDLE_IOCTL(SIOCBONDCHANGEACTIVE, bond_ioctl)
-HANDLE_IOCTL(SIOCADDRT, routing_ioctl)
-HANDLE_IOCTL(SIOCDELRT, routing_ioctl)
-HANDLE_IOCTL(SIOCBRADDIF, dev_ifsioc)
-HANDLE_IOCTL(SIOCBRDELIF, dev_ifsioc)
-/* Note SIOCRTMSG is no longer, so this is safe and * the user would have seen just an -EINVAL anyways. */
-HANDLE_IOCTL(SIOCRTMSG, ret_einval)
-HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp)
-#endif
 HANDLE_IOCTL(HDIO_GETGEO, hdio_getgeo)
 HANDLE_IOCTL(BLKRAGET, w_long)
 HANDLE_IOCTL(BLKGETSIZE, w_long)
@@ -2973,10 +2173,6 @@
 HANDLE_IOCTL(FDGETFDCSTAT32, fd_ioctl_trans)
 HANDLE_IOCTL(FDWERRORGET32, fd_ioctl_trans)
 HANDLE_IOCTL(SG_IO,sg_ioctl_trans)
-HANDLE_IOCTL(PPPIOCGIDLE32, ppp_ioctl_trans)
-HANDLE_IOCTL(PPPIOCSCOMPRESS32, ppp_ioctl_trans)
-HANDLE_IOCTL(PPPIOCSPASS32, ppp_sock_fprog_ioctl_trans)
-HANDLE_IOCTL(PPPIOCSACTIVE32, ppp_sock_fprog_ioctl_trans)
 HANDLE_IOCTL(MTIOCGET32, mt_ioctl_trans)
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
@@ -3007,31 +2203,6 @@
 /* One SMB ioctl needs translations. */
 #define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
-HANDLE_IOCTL(ATM_GETLINKRATE32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETNAMES32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETTYPE32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETESI32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETADDR32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_RSTADDR32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_ADDADDR32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_DELADDR32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETCIRANGE32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_SETCIRANGE32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_SETESI32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_SETESIF32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETSTAT32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETSTATZ32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETLOOP32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_SETLOOP32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_QUERYLOOP32, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETSTAT, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETSTATZ, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETDIAG, do_atm_ioctl)
-HANDLE_IOCTL(SONET_SETDIAG, do_atm_ioctl)
-HANDLE_IOCTL(SONET_CLRDIAG, do_atm_ioctl)
-HANDLE_IOCTL(SONET_SETFRAMING, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETFRAMING, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_ioctl)
 /* block stuff */
 HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
 HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
@@ -3054,22 +2225,6 @@
 HANDLE_IOCTL(I2C_FUNCS, w_long)
 HANDLE_IOCTL(I2C_RDWR, do_i2c_rdwr_ioctl)
 HANDLE_IOCTL(I2C_SMBUS, do_i2c_smbus_ioctl)
-/* wireless */
-HANDLE_IOCTL(SIOCGIWRANGE, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWSPY, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWSPY, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWTHRSPY, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWTHRSPY, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWAPLIST, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWSCAN, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWESSID, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWESSID, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWNICKN, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWNICKN, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWENCODE, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWENCODE, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIFBR, old_bridge_ioctl)
-HANDLE_IOCTL(SIOCGIFBR, old_bridge_ioctl)
 
 #if defined(CONFIG_NCP_FS) || defined(CONFIG_NCP_FS_MODULE)
 HANDLE_IOCTL(NCP_IOC_NCPREQUEST_32, do_ncp_ncprequest)
Index: linux-2.6.14-rc/include/linux/compat_ioctl.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/compat_ioctl.h	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/include/linux/compat_ioctl.h	2005-11-05 02:41:18.000000000 +0100
@@ -261,31 +261,6 @@
 COMPATIBLE_IOCTL(RTC_WKALM_RD)
 /* Little m */
 COMPATIBLE_IOCTL(MTIOCTOP)
-/* Socket level stuff */
-COMPATIBLE_IOCTL(FIOSETOWN)
-COMPATIBLE_IOCTL(SIOCSPGRP)
-COMPATIBLE_IOCTL(FIOGETOWN)
-COMPATIBLE_IOCTL(SIOCGPGRP)
-COMPATIBLE_IOCTL(SIOCATMARK)
-COMPATIBLE_IOCTL(SIOCSIFLINK)
-COMPATIBLE_IOCTL(SIOCSIFENCAP)
-COMPATIBLE_IOCTL(SIOCGIFENCAP)
-COMPATIBLE_IOCTL(SIOCSIFNAME)
-COMPATIBLE_IOCTL(SIOCSARP)
-COMPATIBLE_IOCTL(SIOCGARP)
-COMPATIBLE_IOCTL(SIOCDARP)
-COMPATIBLE_IOCTL(SIOCSRARP)
-COMPATIBLE_IOCTL(SIOCGRARP)
-COMPATIBLE_IOCTL(SIOCDRARP)
-COMPATIBLE_IOCTL(SIOCADDDLCI)
-COMPATIBLE_IOCTL(SIOCDELDLCI)
-COMPATIBLE_IOCTL(SIOCGMIIPHY)
-COMPATIBLE_IOCTL(SIOCGMIIREG)
-COMPATIBLE_IOCTL(SIOCSMIIREG)
-COMPATIBLE_IOCTL(SIOCGIFVLAN)
-COMPATIBLE_IOCTL(SIOCSIFVLAN)
-COMPATIBLE_IOCTL(SIOCBRADDBR)
-COMPATIBLE_IOCTL(SIOCBRDELBR)
 /* SG stuff */
 COMPATIBLE_IOCTL(SG_SET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_GET_TIMEOUT)
@@ -310,39 +285,6 @@
 COMPATIBLE_IOCTL(SG_GET_REQUEST_TABLE)
 COMPATIBLE_IOCTL(SG_SET_KEEP_ORPHAN)
 COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
-/* PPP stuff */
-COMPATIBLE_IOCTL(PPPIOCGFLAGS)
-COMPATIBLE_IOCTL(PPPIOCSFLAGS)
-COMPATIBLE_IOCTL(PPPIOCGASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCSASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCGUNIT)
-COMPATIBLE_IOCTL(PPPIOCGRASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCSRASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCGMRU)
-COMPATIBLE_IOCTL(PPPIOCSMRU)
-COMPATIBLE_IOCTL(PPPIOCSMAXCID)
-COMPATIBLE_IOCTL(PPPIOCGXASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCSXASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCXFERUNIT)
-/* PPPIOCSCOMPRESS is translated */
-COMPATIBLE_IOCTL(PPPIOCGNPMODE)
-COMPATIBLE_IOCTL(PPPIOCSNPMODE)
-COMPATIBLE_IOCTL(PPPIOCGDEBUG)
-COMPATIBLE_IOCTL(PPPIOCSDEBUG)
-/* PPPIOCSPASS is translated */
-/* PPPIOCSACTIVE is translated */
-/* PPPIOCGIDLE is translated */
-COMPATIBLE_IOCTL(PPPIOCNEWUNIT)
-COMPATIBLE_IOCTL(PPPIOCATTACH)
-COMPATIBLE_IOCTL(PPPIOCDETACH)
-COMPATIBLE_IOCTL(PPPIOCSMRRU)
-COMPATIBLE_IOCTL(PPPIOCCONNECT)
-COMPATIBLE_IOCTL(PPPIOCDISCONN)
-COMPATIBLE_IOCTL(PPPIOCATTCHAN)
-COMPATIBLE_IOCTL(PPPIOCGCHAN)
-/* PPPOX */
-COMPATIBLE_IOCTL(PPPOEIOCSFWD)
-COMPATIBLE_IOCTL(PPPOEIOCDFWD)
 /* LP */
 COMPATIBLE_IOCTL(LPGETSTATUS)
 /* ppdev */
@@ -738,37 +680,6 @@
 COMPATIBLE_IOCTL(I2C_PEC)
 COMPATIBLE_IOCTL(I2C_RETRIES)
 COMPATIBLE_IOCTL(I2C_TIMEOUT)
-/* wireless */
-COMPATIBLE_IOCTL(SIOCSIWCOMMIT)
-COMPATIBLE_IOCTL(SIOCGIWNAME)
-COMPATIBLE_IOCTL(SIOCSIWNWID)
-COMPATIBLE_IOCTL(SIOCGIWNWID)
-COMPATIBLE_IOCTL(SIOCSIWFREQ)
-COMPATIBLE_IOCTL(SIOCGIWFREQ)
-COMPATIBLE_IOCTL(SIOCSIWMODE)
-COMPATIBLE_IOCTL(SIOCGIWMODE)
-COMPATIBLE_IOCTL(SIOCSIWSENS)
-COMPATIBLE_IOCTL(SIOCGIWSENS)
-COMPATIBLE_IOCTL(SIOCSIWRANGE)
-COMPATIBLE_IOCTL(SIOCSIWPRIV)
-COMPATIBLE_IOCTL(SIOCGIWPRIV)
-COMPATIBLE_IOCTL(SIOCSIWSTATS)
-COMPATIBLE_IOCTL(SIOCGIWSTATS)
-COMPATIBLE_IOCTL(SIOCSIWAP)
-COMPATIBLE_IOCTL(SIOCGIWAP)
-COMPATIBLE_IOCTL(SIOCSIWSCAN)
-COMPATIBLE_IOCTL(SIOCSIWRATE)
-COMPATIBLE_IOCTL(SIOCGIWRATE)
-COMPATIBLE_IOCTL(SIOCSIWRTS)
-COMPATIBLE_IOCTL(SIOCGIWRTS)
-COMPATIBLE_IOCTL(SIOCSIWFRAG)
-COMPATIBLE_IOCTL(SIOCGIWFRAG)
-COMPATIBLE_IOCTL(SIOCSIWTXPOW)
-COMPATIBLE_IOCTL(SIOCGIWTXPOW)
-COMPATIBLE_IOCTL(SIOCSIWRETRY)
-COMPATIBLE_IOCTL(SIOCGIWRETRY)
-COMPATIBLE_IOCTL(SIOCSIWPOWER)
-COMPATIBLE_IOCTL(SIOCGIWPOWER)
 /* hiddev */
 COMPATIBLE_IOCTL(HIDIOCGVERSION)
 COMPATIBLE_IOCTL(HIDIOCAPPLICATION)
Index: linux-2.6.14-rc/net/compat.c
===================================================================
--- linux-2.6.14-rc.orig/net/compat.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/net/compat.c	2005-11-05 02:41:18.000000000 +0100
@@ -24,6 +24,20 @@
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/security.h>
 
+/* these are all for ioctl */
+#include <linux/atalk.h>
+#include <linux/atmdev.h>
+#include <linux/ipv6_route.h>
+#include <linux/ppp_defs.h>
+#include <linux/route.h>
+#include <linux/sockios.h>
+#include <linux/sonet.h>
+#include <linux/wireless.h>
+#include <linux/if_bridge.h>
+#include <linux/if_ppp.h>
+#include <linux/if_pppox.h>
+#include <linux/if_tun.h>
+
 #include <net/scm.h>
 #include <net/sock.h>
 #include <asm/uaccess.h>
@@ -602,3 +616,951 @@
 	}
 	return ret;
 }
+
+static int do_siocgstamp(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct compat_timeval __user *up = compat_ptr(arg);
+	struct timeval ktv;
+	mm_segment_t old_fs = get_fs();
+	int err;
+
+	set_fs(KERNEL_DS);
+	err = sock_ioctl(file, cmd, (unsigned long)&ktv);
+	set_fs(old_fs);
+	if(!err) {
+		err = put_user(ktv.tv_sec, &up->tv_sec);
+		err |= __put_user(ktv.tv_usec, &up->tv_usec);
+	}
+	return err;
+}
+
+struct ifmap32 {
+	compat_ulong_t mem_start;
+	compat_ulong_t mem_end;
+	unsigned short base_addr;
+	unsigned char irq;
+	unsigned char dma;
+	unsigned char port;
+};
+
+struct ifreq32 {
+#define IFHWADDRLEN     6
+#define IFNAMSIZ        16
+        union {
+                char    ifrn_name[IFNAMSIZ];            /* if name, e.g. "en0" */
+        } ifr_ifrn;
+        union {
+                struct  sockaddr ifru_addr;
+                struct  sockaddr ifru_dstaddr;
+                struct  sockaddr ifru_broadaddr;
+                struct  sockaddr ifru_netmask;
+                struct  sockaddr ifru_hwaddr;
+                short   ifru_flags;
+                compat_int_t     ifru_ivalue;
+                compat_int_t     ifru_mtu;
+                struct  ifmap32 ifru_map;
+                char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
+		char	ifru_newname[IFNAMSIZ];
+                compat_caddr_t ifru_data;
+	    /* XXXX? ifru_settings should be here */
+        } ifr_ifru;
+};
+
+struct ifconf32 {
+        compat_int_t	ifc_len;                        /* size of buffer       */
+        compat_caddr_t  ifcbuf;
+};
+
+static int dev_ifname32(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct net_device *dev;
+	struct ifreq32 ifr32;
+	int err;
+
+	if (copy_from_user(&ifr32, compat_ptr(arg), sizeof(ifr32)))
+		return -EFAULT;
+
+	dev = dev_get_by_index(ifr32.ifr_ifindex);
+	if (!dev)
+		return -ENODEV;
+
+	strlcpy(ifr32.ifr_name, dev->name, sizeof(ifr32.ifr_name));
+	dev_put(dev);
+
+	err = copy_to_user(compat_ptr(arg), &ifr32, sizeof(ifr32));
+	return (err ? -EFAULT : 0);
+}
+
+static int dev_ifconf(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ifconf32 ifc32;
+	struct ifconf ifc;
+	struct ifconf __user *uifc;
+	struct ifreq32 __user *ifr32;
+	struct ifreq __user *ifr;
+	unsigned int i, j;
+	int err;
+
+	if (copy_from_user(&ifc32, compat_ptr(arg), sizeof(struct ifconf32)))
+		return -EFAULT;
+
+	if (ifc32.ifcbuf == 0) {
+		ifc32.ifc_len = 0;
+		ifc.ifc_len = 0;
+		ifc.ifc_req = NULL;
+		uifc = compat_alloc_user_space(sizeof(struct ifconf));
+	} else {
+		size_t len =((ifc32.ifc_len / sizeof (struct ifreq32)) + 1) *
+			sizeof (struct ifreq);
+		uifc = compat_alloc_user_space(sizeof(struct ifconf) + len);
+		ifc.ifc_len = len;
+		ifr = ifc.ifc_req = (void __user *)(uifc + 1);
+		ifr32 = compat_ptr(ifc32.ifcbuf);
+		for (i = 0; i < ifc32.ifc_len; i += sizeof (struct ifreq32)) {
+			if (copy_in_user(ifr, ifr32, sizeof(struct ifreq32)))
+				return -EFAULT;
+			ifr++;
+			ifr32++;
+		}
+	}
+	if (copy_to_user(uifc, &ifc, sizeof(struct ifconf)))
+		return -EFAULT;
+
+	err = sock_ioctl(file, SIOCGIFCONF, (unsigned long)uifc);
+	if (err)
+		return err;
+
+	if (copy_from_user(&ifc, uifc, sizeof(struct ifconf)))
+		return -EFAULT;
+
+	ifr = ifc.ifc_req;
+	ifr32 = compat_ptr(ifc32.ifcbuf);
+	for (i = 0, j = 0; i < ifc32.ifc_len && j < ifc.ifc_len;
+	     i += sizeof (struct ifreq32), j += sizeof (struct ifreq)) {
+		if (copy_in_user(ifr32, ifr, sizeof (struct ifreq32)))
+			return -EFAULT;
+		ifr32++;
+		ifr++;
+	}
+
+	if (ifc32.ifcbuf == 0) {
+		/* Translate from 64-bit structure multiple to
+		 * a 32-bit one.
+		 */
+		i = ifc.ifc_len;
+		i = ((i / sizeof(struct ifreq)) * sizeof(struct ifreq32));
+		ifc32.ifc_len = i;
+	} else {
+		if (i <= ifc32.ifc_len)
+			ifc32.ifc_len = i;
+		else
+			ifc32.ifc_len = i - sizeof (struct ifreq32);
+	}
+	if (copy_to_user(compat_ptr(arg), &ifc32, sizeof(struct ifconf32)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int ethtool_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ifreq __user *ifr;
+	struct ifreq32 __user *ifr32;
+	u32 data;
+	void __user *datap;
+
+	ifr = compat_alloc_user_space(sizeof(*ifr));
+	ifr32 = compat_ptr(arg);
+
+	if (copy_in_user(&ifr->ifr_name, &ifr32->ifr_name, IFNAMSIZ))
+		return -EFAULT;
+
+	if (get_user(data, &ifr32->ifr_ifru.ifru_data))
+		return -EFAULT;
+
+	datap = compat_ptr(data);
+	if (put_user(datap, &ifr->ifr_ifru.ifru_data))
+		return -EFAULT;
+
+	return sock_ioctl(file, cmd, (unsigned long) ifr);
+}
+
+static int bond_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ifreq kifr;
+	struct ifreq __user *uifr;
+	struct ifreq32 __user *ifr32 = compat_ptr(arg);
+	mm_segment_t old_fs;
+	int err;
+	u32 data;
+	void __user *datap;
+
+	switch (cmd) {
+	case SIOCBONDENSLAVE:
+	case SIOCBONDRELEASE:
+	case SIOCBONDSETHWADDR:
+	case SIOCBONDCHANGEACTIVE:
+		if (copy_from_user(&kifr, ifr32, sizeof(struct ifreq32)))
+			return -EFAULT;
+
+		old_fs = get_fs();
+		set_fs (KERNEL_DS);
+		err = sock_ioctl(file, cmd, (unsigned long)&kifr);
+		set_fs (old_fs);
+
+		return err;
+	case SIOCBONDSLAVEINFOQUERY:
+	case SIOCBONDINFOQUERY:
+		uifr = compat_alloc_user_space(sizeof(*uifr));
+		if (copy_in_user(&uifr->ifr_name, &ifr32->ifr_name, IFNAMSIZ))
+			return -EFAULT;
+
+		if (get_user(data, &ifr32->ifr_ifru.ifru_data))
+			return -EFAULT;
+
+		datap = compat_ptr(data);
+		if (put_user(datap, &uifr->ifr_ifru.ifru_data))
+			return -EFAULT;
+
+		return sock_ioctl(file, cmd, (unsigned long)uifr);
+	default:
+		return -EINVAL;
+	};
+}
+
+static int siocdevprivate_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ifreq __user *u_ifreq64;
+	struct ifreq32 __user *u_ifreq32 = compat_ptr(arg);
+	char tmp_buf[IFNAMSIZ];
+	void __user *data64;
+	u32 data32;
+
+	if (copy_from_user(&tmp_buf[0], &(u_ifreq32->ifr_ifrn.ifrn_name[0]),
+			   IFNAMSIZ))
+		return -EFAULT;
+	if (__get_user(data32, &u_ifreq32->ifr_ifru.ifru_data))
+		return -EFAULT;
+	data64 = compat_ptr(data32);
+
+	u_ifreq64 = compat_alloc_user_space(sizeof(*u_ifreq64));
+
+	/* Don't check these user accesses, just let that get trapped
+	 * in the ioctl handler instead.
+	 */
+	if (copy_to_user(&u_ifreq64->ifr_ifrn.ifrn_name[0], &tmp_buf[0],
+			 IFNAMSIZ))
+		return -EFAULT;
+	if (__put_user(data64, &u_ifreq64->ifr_ifru.ifru_data))
+		return -EFAULT;
+
+	return sock_ioctl(file, cmd, (unsigned long) u_ifreq64);
+}
+
+static int dev_ifsioc(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ifreq ifr;
+	struct ifreq32 __user *uifr32;
+	struct ifmap32 __user *uifmap32;
+	mm_segment_t old_fs;
+	int err;
+
+	uifr32 = compat_ptr(arg);
+	uifmap32 = &uifr32->ifr_ifru.ifru_map;
+	switch (cmd) {
+	case SIOCSIFMAP:
+		err = copy_from_user(&ifr, uifr32, sizeof(ifr.ifr_name));
+		err |= __get_user(ifr.ifr_map.mem_start, &uifmap32->mem_start);
+		err |= __get_user(ifr.ifr_map.mem_end, &uifmap32->mem_end);
+		err |= __get_user(ifr.ifr_map.base_addr, &uifmap32->base_addr);
+		err |= __get_user(ifr.ifr_map.irq, &uifmap32->irq);
+		err |= __get_user(ifr.ifr_map.dma, &uifmap32->dma);
+		err |= __get_user(ifr.ifr_map.port, &uifmap32->port);
+		if (err)
+			return -EFAULT;
+		break;
+	default:
+		if (copy_from_user(&ifr, uifr32, sizeof(*uifr32)))
+			return -EFAULT;
+		break;
+	}
+	old_fs = get_fs();
+	set_fs (KERNEL_DS);
+	err = sock_ioctl(file, cmd, (unsigned long)&ifr);
+	set_fs (old_fs);
+	if (!err) {
+		switch (cmd) {
+		/* TUNSETIFF is defined as _IOW, it should be _IORW
+		 * as the data is copied back to user space, but that
+		 * cannot be fixed without breaking all existing apps.
+		 */
+		case TUNSETIFF:
+		case SIOCGIFFLAGS:
+		case SIOCGIFMETRIC:
+		case SIOCGIFMTU:
+		case SIOCGIFMEM:
+		case SIOCGIFHWADDR:
+		case SIOCGIFINDEX:
+		case SIOCGIFADDR:
+		case SIOCGIFBRDADDR:
+		case SIOCGIFDSTADDR:
+		case SIOCGIFNETMASK:
+		case SIOCGIFTXQLEN:
+			if (copy_to_user(uifr32, &ifr, sizeof(*uifr32)))
+				return -EFAULT;
+			break;
+		case SIOCGIFMAP:
+			err = copy_to_user(uifr32, &ifr, sizeof(ifr.ifr_name));
+			err |= __put_user(ifr.ifr_map.mem_start, &uifmap32->mem_start);
+			err |= __put_user(ifr.ifr_map.mem_end, &uifmap32->mem_end);
+			err |= __put_user(ifr.ifr_map.base_addr, &uifmap32->base_addr);
+			err |= __put_user(ifr.ifr_map.irq, &uifmap32->irq);
+			err |= __put_user(ifr.ifr_map.dma, &uifmap32->dma);
+			err |= __put_user(ifr.ifr_map.port, &uifmap32->port);
+			if (err)
+				err = -EFAULT;
+			break;
+		}
+	}
+	return err;
+}
+
+struct rtentry32 {
+        u32   		rt_pad1;
+        struct sockaddr rt_dst;         /* target address               */
+        struct sockaddr rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
+        struct sockaddr rt_genmask;     /* target network mask (IP)     */
+        unsigned short  rt_flags;
+        short           rt_pad2;
+        u32   		rt_pad3;
+        unsigned char   rt_tos;
+        unsigned char   rt_class;
+        short           rt_pad4;
+        short           rt_metric;      /* +1 for binary compatibility! */
+        /* char * */ u32 rt_dev;        /* forcing the device at add    */
+        u32   		rt_mtu;         /* per route MTU/Window         */
+        u32   		rt_window;      /* Window clamping              */
+        unsigned short  rt_irtt;        /* Initial RTT                  */
+
+};
+
+struct in6_rtmsg32 {
+	struct in6_addr		rtmsg_dst;
+	struct in6_addr		rtmsg_src;
+	struct in6_addr		rtmsg_gateway;
+	u32			rtmsg_type;
+	u16			rtmsg_dst_len;
+	u16			rtmsg_src_len;
+	u32			rtmsg_metric;
+	u32			rtmsg_info;
+	u32			rtmsg_flags;
+	s32			rtmsg_ifindex;
+};
+
+static int routing_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+	void *r = NULL;
+	struct in6_rtmsg r6;
+	struct rtentry r4;
+	char devname[16];
+	u32 rtdev;
+	mm_segment_t old_fs = get_fs();
+
+	struct socket *mysock = file->private_data;
+
+	if (mysock && mysock->sk && mysock->sk->sk_family == AF_INET6) { /* ipv6 */
+		struct in6_rtmsg32 __user *ur6 = compat_ptr(arg);
+		ret = copy_from_user (&r6.rtmsg_dst, &(ur6->rtmsg_dst),
+			3 * sizeof(struct in6_addr));
+		ret |= __get_user (r6.rtmsg_type, &(ur6->rtmsg_type));
+		ret |= __get_user (r6.rtmsg_dst_len, &(ur6->rtmsg_dst_len));
+		ret |= __get_user (r6.rtmsg_src_len, &(ur6->rtmsg_src_len));
+		ret |= __get_user (r6.rtmsg_metric, &(ur6->rtmsg_metric));
+		ret |= __get_user (r6.rtmsg_info, &(ur6->rtmsg_info));
+		ret |= __get_user (r6.rtmsg_flags, &(ur6->rtmsg_flags));
+		ret |= __get_user (r6.rtmsg_ifindex, &(ur6->rtmsg_ifindex));
+
+		r = (void *) &r6;
+	} else { /* ipv4 */
+		struct rtentry32 __user *ur4 = compat_ptr(arg);
+		ret = copy_from_user (&r4.rt_dst, &(ur4->rt_dst),
+					3 * sizeof(struct sockaddr));
+		ret |= __get_user (r4.rt_flags, &(ur4->rt_flags));
+		ret |= __get_user (r4.rt_metric, &(ur4->rt_metric));
+		ret |= __get_user (r4.rt_mtu, &(ur4->rt_mtu));
+		ret |= __get_user (r4.rt_window, &(ur4->rt_window));
+		ret |= __get_user (r4.rt_irtt, &(ur4->rt_irtt));
+		ret |= __get_user (rtdev, &(ur4->rt_dev));
+		if (rtdev) {
+			ret |= copy_from_user (devname, compat_ptr(rtdev), 15);
+			r4.rt_dev = devname; devname[15] = 0;
+		} else
+			r4.rt_dev = NULL;
+
+		r = (void *) &r4;
+	}
+
+	if (ret) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	set_fs (KERNEL_DS);
+	ret = sock_ioctl(file, cmd, (unsigned long) r);
+	set_fs (old_fs);
+
+out:
+	if (mysock)
+		sockfd_put(mysock);
+
+	return ret;
+}
+
+struct atmif_sioc32 {
+        compat_int_t	number;
+        compat_int_t	length;
+        compat_caddr_t	arg;
+};
+
+struct atm_iobuf32 {
+	compat_int_t	length;
+	compat_caddr_t	buffer;
+};
+
+#define ATM_GETLINKRATE32 _IOW('a', ATMIOC_ITF+1, struct atmif_sioc32)
+#define ATM_GETNAMES32    _IOW('a', ATMIOC_ITF+3, struct atm_iobuf32)
+#define ATM_GETTYPE32     _IOW('a', ATMIOC_ITF+4, struct atmif_sioc32)
+#define ATM_GETESI32	  _IOW('a', ATMIOC_ITF+5, struct atmif_sioc32)
+#define ATM_GETADDR32	  _IOW('a', ATMIOC_ITF+6, struct atmif_sioc32)
+#define ATM_RSTADDR32	  _IOW('a', ATMIOC_ITF+7, struct atmif_sioc32)
+#define ATM_ADDADDR32	  _IOW('a', ATMIOC_ITF+8, struct atmif_sioc32)
+#define ATM_DELADDR32	  _IOW('a', ATMIOC_ITF+9, struct atmif_sioc32)
+#define ATM_GETCIRANGE32  _IOW('a', ATMIOC_ITF+10, struct atmif_sioc32)
+#define ATM_SETCIRANGE32  _IOW('a', ATMIOC_ITF+11, struct atmif_sioc32)
+#define ATM_SETESI32      _IOW('a', ATMIOC_ITF+12, struct atmif_sioc32)
+#define ATM_SETESIF32     _IOW('a', ATMIOC_ITF+13, struct atmif_sioc32)
+#define ATM_GETSTAT32     _IOW('a', ATMIOC_SARCOM+0, struct atmif_sioc32)
+#define ATM_GETSTATZ32    _IOW('a', ATMIOC_SARCOM+1, struct atmif_sioc32)
+#define ATM_GETLOOP32	  _IOW('a', ATMIOC_SARCOM+2, struct atmif_sioc32)
+#define ATM_SETLOOP32	  _IOW('a', ATMIOC_SARCOM+3, struct atmif_sioc32)
+#define ATM_QUERYLOOP32	  _IOW('a', ATMIOC_SARCOM+4, struct atmif_sioc32)
+
+static struct {
+        unsigned int cmd32;
+        unsigned int cmd;
+} atm_ioctl_map[] = {
+        { ATM_GETLINKRATE32, ATM_GETLINKRATE },
+	{ ATM_GETNAMES32,    ATM_GETNAMES },
+        { ATM_GETTYPE32,     ATM_GETTYPE },
+        { ATM_GETESI32,      ATM_GETESI },
+        { ATM_GETADDR32,     ATM_GETADDR },
+        { ATM_RSTADDR32,     ATM_RSTADDR },
+        { ATM_ADDADDR32,     ATM_ADDADDR },
+        { ATM_DELADDR32,     ATM_DELADDR },
+        { ATM_GETCIRANGE32,  ATM_GETCIRANGE },
+	{ ATM_SETCIRANGE32,  ATM_SETCIRANGE },
+	{ ATM_SETESI32,      ATM_SETESI },
+	{ ATM_SETESIF32,     ATM_SETESIF },
+	{ ATM_GETSTAT32,     ATM_GETSTAT },
+	{ ATM_GETSTATZ32,    ATM_GETSTATZ },
+	{ ATM_GETLOOP32,     ATM_GETLOOP },
+	{ ATM_SETLOOP32,     ATM_SETLOOP },
+	{ ATM_QUERYLOOP32,   ATM_QUERYLOOP }
+};
+
+#define NR_ATM_IOCTL (sizeof(atm_ioctl_map)/sizeof(atm_ioctl_map[0]))
+
+
+static int do_atm_iobuf(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct atm_iobuf   __user *iobuf;
+	struct atm_iobuf32 __user *iobuf32;
+	u32 data;
+	void __user *datap;
+	int len, err;
+
+	iobuf = compat_alloc_user_space(sizeof(*iobuf));
+	iobuf32 = compat_ptr(arg);
+
+	if (get_user(len, &iobuf32->length) ||
+	    get_user(data, &iobuf32->buffer))
+		return -EFAULT;
+	datap = compat_ptr(data);
+	if (put_user(len, &iobuf->length) ||
+	    put_user(datap, &iobuf->buffer))
+		return -EFAULT;
+
+	err = sock_ioctl(file, cmd, (unsigned long)iobuf);
+
+	if (!err) {
+		if (copy_in_user(&iobuf32->length, &iobuf->length,
+				 sizeof(int)))
+			err = -EFAULT;
+	}
+
+	return err;
+}
+
+static int do_atmif_sioc(struct file *file, unsigned int cmd, unsigned long arg)
+{
+        struct atmif_sioc   __user *sioc;
+	struct atmif_sioc32 __user *sioc32;
+	u32 data;
+	void __user *datap;
+	int err;
+
+	sioc = compat_alloc_user_space(sizeof(*sioc));
+	sioc32 = compat_ptr(arg);
+
+	if (copy_in_user(&sioc->number, &sioc32->number, 2 * sizeof(int)) ||
+	    get_user(data, &sioc32->arg))
+		return -EFAULT;
+	datap = compat_ptr(data);
+	if (put_user(datap, &sioc->arg))
+		return -EFAULT;
+
+	err = sock_ioctl(file, cmd, (unsigned long) sioc);
+
+	if (!err) {
+		if (copy_in_user(&sioc32->length, &sioc->length,
+				 sizeof(int)))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+static int do_atm_ioctl(struct file *file, unsigned int cmd32, unsigned long arg)
+{
+        int i;
+        unsigned int cmd = 0;
+
+	switch (cmd32) {
+	case SONET_GETSTAT:
+	case SONET_GETSTATZ:
+	case SONET_GETDIAG:
+	case SONET_SETDIAG:
+	case SONET_CLRDIAG:
+	case SONET_SETFRAMING:
+	case SONET_GETFRAMING:
+	case SONET_GETFRSENSE:
+		return do_atmif_sioc(file, cmd32, arg);
+	}
+
+	for (i = 0; i < NR_ATM_IOCTL; i++) {
+		if (cmd32 == atm_ioctl_map[i].cmd32) {
+			cmd = atm_ioctl_map[i].cmd;
+			break;
+		}
+	}
+	if (i == NR_ATM_IOCTL)
+	        return -EINVAL;
+
+        switch (cmd) {
+	case ATM_GETNAMES:
+		return do_atm_iobuf(file, cmd, arg);
+
+	case ATM_GETLINKRATE:
+        case ATM_GETTYPE:
+        case ATM_GETESI:
+        case ATM_GETADDR:
+        case ATM_RSTADDR:
+        case ATM_ADDADDR:
+        case ATM_DELADDR:
+        case ATM_GETCIRANGE:
+	case ATM_SETCIRANGE:
+	case ATM_SETESI:
+	case ATM_SETESIF:
+	case ATM_GETSTAT:
+	case ATM_GETSTATZ:
+	case ATM_GETLOOP:
+	case ATM_SETLOOP:
+	case ATM_QUERYLOOP:
+                return do_atmif_sioc(file, cmd, arg);
+        }
+
+        return -EINVAL;
+}
+
+struct sock_fprog32 {
+	unsigned short	len;
+	compat_caddr_t	filter;
+};
+
+#define PPPIOCSPASS32	_IOW('t', 71, struct sock_fprog32)
+#define PPPIOCSACTIVE32	_IOW('t', 70, struct sock_fprog32)
+
+static int ppp_sock_fprog_ioctl_trans(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct sock_fprog32 __user *u_fprog32 = compat_ptr(arg);
+	struct sock_fprog __user *u_fprog64 = compat_alloc_user_space(sizeof(struct sock_fprog));
+	void __user *fptr64;
+	u32 fptr32;
+	u16 flen;
+
+	if (get_user(flen, &u_fprog32->len) ||
+	    get_user(fptr32, &u_fprog32->filter))
+		return -EFAULT;
+
+	fptr64 = compat_ptr(fptr32);
+
+	if (put_user(flen, &u_fprog64->len) ||
+	    put_user(fptr64, &u_fprog64->filter))
+		return -EFAULT;
+
+	if (cmd == PPPIOCSPASS32)
+		cmd = PPPIOCSPASS;
+	else
+		cmd = PPPIOCSACTIVE;
+
+	return sock_ioctl(file, cmd, (unsigned long) u_fprog64);
+}
+
+struct ppp_option_data32 {
+	compat_caddr_t	ptr;
+	u32			length;
+	compat_int_t		transmit;
+};
+#define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
+
+struct ppp_idle32 {
+	compat_time_t xmit_idle;
+	compat_time_t recv_idle;
+};
+#define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
+
+static int ppp_gidle(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ppp_idle __user *idle;
+	struct ppp_idle32 __user *idle32;
+	__kernel_time_t xmit, recv;
+	int err;
+
+	idle = compat_alloc_user_space(sizeof(*idle));
+	idle32 = compat_ptr(arg);
+
+	err = sock_ioctl(file, PPPIOCGIDLE, (unsigned long) idle);
+
+	if (!err) {
+		if (get_user(xmit, &idle->xmit_idle) ||
+		    get_user(recv, &idle->recv_idle) ||
+		    put_user(xmit, &idle32->xmit_idle) ||
+		    put_user(recv, &idle32->recv_idle))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+static int ppp_scompress(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ppp_option_data __user *odata;
+	struct ppp_option_data32 __user *odata32;
+	__u32 data;
+	void __user *datap;
+
+	odata = compat_alloc_user_space(sizeof(*odata));
+	odata32 = compat_ptr(arg);
+
+	if (get_user(data, &odata32->ptr))
+		return -EFAULT;
+
+	datap = compat_ptr(data);
+	if (put_user(datap, &odata->ptr))
+		return -EFAULT;
+
+	if (copy_in_user(&odata->length, &odata32->length,
+			 sizeof(__u32) + sizeof(int)))
+		return -EFAULT;
+
+	return sock_ioctl(file, PPPIOCSCOMPRESS, (unsigned long) odata);
+}
+
+static int ppp_ioctl_trans(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int err;
+
+	switch (cmd) {
+	case PPPIOCGIDLE32:
+		err = ppp_gidle(file, cmd, arg);
+		break;
+
+	case PPPIOCSCOMPRESS32:
+		err = ppp_scompress(file, cmd, arg);
+		break;
+
+	default:
+		do {
+			static int count;
+			if (++count <= 20)
+				printk("ppp_ioctl: Unknown cmd(%08x) arg(%08x)\n",
+				       (unsigned int)cmd, (unsigned int)arg);
+		} while(0);
+		err = -EINVAL;
+		break;
+	};
+
+	return err;
+}
+
+struct compat_iw_point {
+	compat_caddr_t pointer;
+	__u16 length;
+	__u16 flags;
+};
+
+static int do_wireless_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct iwreq __user *iwr;
+	struct iwreq __user *iwr_u;
+	struct iw_point __user *iwp;
+	struct compat_iw_point __user *iwp_u;
+	compat_caddr_t pointer;
+	__u16 length, flags;
+
+	iwr_u = compat_ptr(arg);
+	iwp_u = (struct compat_iw_point __user *) &iwr_u->u.data;
+	iwr = compat_alloc_user_space(sizeof(*iwr));
+	if (iwr == NULL)
+		return -ENOMEM;
+
+	iwp = &iwr->u.data;
+
+	if (!access_ok(VERIFY_WRITE, iwr, sizeof(*iwr)))
+		return -EFAULT;
+
+	if (__copy_in_user(&iwr->ifr_ifrn.ifrn_name[0],
+			   &iwr_u->ifr_ifrn.ifrn_name[0],
+			   sizeof(iwr->ifr_ifrn.ifrn_name)))
+		return -EFAULT;
+
+	if (__get_user(pointer, &iwp_u->pointer) ||
+	    __get_user(length, &iwp_u->length) ||
+	    __get_user(flags, &iwp_u->flags))
+		return -EFAULT;
+
+	if (__put_user(compat_ptr(pointer), &iwp->pointer) ||
+	    __put_user(length, &iwp->length) ||
+	    __put_user(flags, &iwp->flags))
+		return -EFAULT;
+
+	return sock_ioctl(file, cmd, (unsigned long) iwr);
+}
+
+/* Since old style bridge ioctl's endup using SIOCDEVPRIVATE
+ * for some operations; this forces use of the newer bridge-utils that
+ * use compatiable ioctls
+ */
+static int old_bridge_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	u32 tmp;
+
+	if (get_user(tmp, (u32 __user *) arg))
+		return -EFAULT;
+	if (tmp == BRCTL_GET_VERSION)
+		return BRCTL_VERSION + 1;
+	return -EINVAL;
+}
+
+long compat_sock_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15))
+		return siocdevprivate_ioctl(file, cmd, arg);
+
+	switch (cmd) {
+#define HANDLE_IOCTL(type, handler) \
+	case type: return handler(file, cmd, arg);
+#define COMPATIBLE_IOCTL(type) \
+	case type: return sock_ioctl(file, cmd, arg);
+#define INVAL_IOCTL(type) \
+	case type: return -EINVAL;
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
+
+/* ioctls used by appletalk ddp.c */
+HANDLE_IOCTL(SIOCATALKDIFADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCDIFADDR, dev_ifsioc)
+
+HANDLE_IOCTL(SIOCSARP, dev_ifsioc)
+HANDLE_IOCTL(SIOCDARP, dev_ifsioc)
+
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
+HANDLE_IOCTL(TUNSETIFF, dev_ifsioc)
+HANDLE_IOCTL(SIOCETHTOOL, ethtool_ioctl)
+HANDLE_IOCTL(SIOCBONDENSLAVE, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDRELEASE, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDSETHWADDR, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDSLAVEINFOQUERY, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDINFOQUERY, bond_ioctl)
+HANDLE_IOCTL(SIOCBONDCHANGEACTIVE, bond_ioctl)
+HANDLE_IOCTL(SIOCADDRT, routing_ioctl)
+HANDLE_IOCTL(SIOCDELRT, routing_ioctl)
+HANDLE_IOCTL(SIOCBRADDIF, dev_ifsioc)
+HANDLE_IOCTL(SIOCBRDELIF, dev_ifsioc)
+/* Note SIOCRTMSG is no longer, so this is safe and * the user would have seen just an -EINVAL anyways. */
+INVAL_IOCTL(SIOCRTMSG)
+HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp)
+/* atm */
+HANDLE_IOCTL(ATM_GETLINKRATE32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_GETNAMES32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_GETTYPE32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_GETESI32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_GETADDR32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_RSTADDR32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_ADDADDR32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_DELADDR32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_GETCIRANGE32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_SETCIRANGE32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_SETESI32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_SETESIF32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_GETSTAT32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_GETSTATZ32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_GETLOOP32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_SETLOOP32, do_atm_ioctl)
+HANDLE_IOCTL(ATM_QUERYLOOP32, do_atm_ioctl)
+HANDLE_IOCTL(SONET_GETSTAT, do_atm_ioctl)
+HANDLE_IOCTL(SONET_GETSTATZ, do_atm_ioctl)
+HANDLE_IOCTL(SONET_GETDIAG, do_atm_ioctl)
+HANDLE_IOCTL(SONET_SETDIAG, do_atm_ioctl)
+HANDLE_IOCTL(SONET_CLRDIAG, do_atm_ioctl)
+HANDLE_IOCTL(SONET_SETFRAMING, do_atm_ioctl)
+HANDLE_IOCTL(SONET_GETFRAMING, do_atm_ioctl)
+HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_ioctl)
+/* ppp */
+HANDLE_IOCTL(PPPIOCGIDLE32, ppp_ioctl_trans)
+HANDLE_IOCTL(PPPIOCSCOMPRESS32, ppp_ioctl_trans)
+HANDLE_IOCTL(PPPIOCSPASS32, ppp_sock_fprog_ioctl_trans)
+HANDLE_IOCTL(PPPIOCSACTIVE32, ppp_sock_fprog_ioctl_trans)
+/* wireless */
+HANDLE_IOCTL(SIOCGIWRANGE, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCSIWSPY, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCGIWSPY, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCSIWTHRSPY, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCGIWTHRSPY, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCGIWAPLIST, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCGIWSCAN, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCSIWESSID, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCGIWESSID, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCSIWNICKN, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCGIWNICKN, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCSIWENCODE, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCGIWENCODE, do_wireless_ioctl)
+HANDLE_IOCTL(SIOCSIFBR, old_bridge_ioctl)
+HANDLE_IOCTL(SIOCGIFBR, old_bridge_ioctl)
+
+COMPATIBLE_IOCTL(FIOSETOWN)
+COMPATIBLE_IOCTL(SIOCSPGRP)
+COMPATIBLE_IOCTL(FIOGETOWN)
+COMPATIBLE_IOCTL(SIOCGPGRP)
+COMPATIBLE_IOCTL(SIOCATMARK)
+COMPATIBLE_IOCTL(SIOCSIFLINK)
+COMPATIBLE_IOCTL(SIOCSIFENCAP)
+COMPATIBLE_IOCTL(SIOCGIFENCAP)
+COMPATIBLE_IOCTL(SIOCSIFNAME)
+//COMPATIBLE_IOCTL(SIOCSARP)
+COMPATIBLE_IOCTL(SIOCGARP)
+//COMPATIBLE_IOCTL(SIOCDARP)
+COMPATIBLE_IOCTL(SIOCSRARP)
+COMPATIBLE_IOCTL(SIOCGRARP)
+COMPATIBLE_IOCTL(SIOCDRARP)
+COMPATIBLE_IOCTL(SIOCADDDLCI)
+COMPATIBLE_IOCTL(SIOCDELDLCI)
+COMPATIBLE_IOCTL(SIOCGMIIPHY)
+COMPATIBLE_IOCTL(SIOCGMIIREG)
+COMPATIBLE_IOCTL(SIOCSMIIREG)
+COMPATIBLE_IOCTL(SIOCGIFVLAN)
+COMPATIBLE_IOCTL(SIOCSIFVLAN)
+COMPATIBLE_IOCTL(SIOCBRADDBR)
+COMPATIBLE_IOCTL(SIOCBRDELBR)
+/* wireless */
+COMPATIBLE_IOCTL(SIOCSIWCOMMIT)
+COMPATIBLE_IOCTL(SIOCGIWNAME)
+COMPATIBLE_IOCTL(SIOCSIWNWID)
+COMPATIBLE_IOCTL(SIOCGIWNWID)
+COMPATIBLE_IOCTL(SIOCSIWFREQ)
+COMPATIBLE_IOCTL(SIOCGIWFREQ)
+COMPATIBLE_IOCTL(SIOCSIWMODE)
+COMPATIBLE_IOCTL(SIOCGIWMODE)
+COMPATIBLE_IOCTL(SIOCSIWSENS)
+COMPATIBLE_IOCTL(SIOCGIWSENS)
+COMPATIBLE_IOCTL(SIOCSIWRANGE)
+COMPATIBLE_IOCTL(SIOCSIWPRIV)
+COMPATIBLE_IOCTL(SIOCGIWPRIV)
+COMPATIBLE_IOCTL(SIOCSIWSTATS)
+COMPATIBLE_IOCTL(SIOCGIWSTATS)
+COMPATIBLE_IOCTL(SIOCSIWAP)
+COMPATIBLE_IOCTL(SIOCGIWAP)
+COMPATIBLE_IOCTL(SIOCSIWSCAN)
+COMPATIBLE_IOCTL(SIOCSIWRATE)
+COMPATIBLE_IOCTL(SIOCGIWRATE)
+COMPATIBLE_IOCTL(SIOCSIWRTS)
+COMPATIBLE_IOCTL(SIOCGIWRTS)
+COMPATIBLE_IOCTL(SIOCSIWFRAG)
+COMPATIBLE_IOCTL(SIOCGIWFRAG)
+COMPATIBLE_IOCTL(SIOCSIWTXPOW)
+COMPATIBLE_IOCTL(SIOCGIWTXPOW)
+COMPATIBLE_IOCTL(SIOCSIWRETRY)
+COMPATIBLE_IOCTL(SIOCGIWRETRY)
+COMPATIBLE_IOCTL(SIOCSIWPOWER)
+COMPATIBLE_IOCTL(SIOCGIWPOWER)
+/* PPP stuff */
+COMPATIBLE_IOCTL(PPPIOCGFLAGS)
+COMPATIBLE_IOCTL(PPPIOCSFLAGS)
+COMPATIBLE_IOCTL(PPPIOCGASYNCMAP)
+COMPATIBLE_IOCTL(PPPIOCSASYNCMAP)
+COMPATIBLE_IOCTL(PPPIOCGUNIT)
+COMPATIBLE_IOCTL(PPPIOCGRASYNCMAP)
+COMPATIBLE_IOCTL(PPPIOCSRASYNCMAP)
+COMPATIBLE_IOCTL(PPPIOCGMRU)
+COMPATIBLE_IOCTL(PPPIOCSMRU)
+COMPATIBLE_IOCTL(PPPIOCSMAXCID)
+COMPATIBLE_IOCTL(PPPIOCGXASYNCMAP)
+COMPATIBLE_IOCTL(PPPIOCSXASYNCMAP)
+COMPATIBLE_IOCTL(PPPIOCXFERUNIT)
+/* PPPIOCSCOMPRESS is translated */
+COMPATIBLE_IOCTL(PPPIOCGNPMODE)
+COMPATIBLE_IOCTL(PPPIOCSNPMODE)
+COMPATIBLE_IOCTL(PPPIOCGDEBUG)
+COMPATIBLE_IOCTL(PPPIOCSDEBUG)
+/* PPPIOCSPASS is translated */
+/* PPPIOCSACTIVE is translated */
+/* PPPIOCGIDLE is translated */
+COMPATIBLE_IOCTL(PPPIOCNEWUNIT)
+COMPATIBLE_IOCTL(PPPIOCATTACH)
+COMPATIBLE_IOCTL(PPPIOCDETACH)
+COMPATIBLE_IOCTL(PPPIOCSMRRU)
+COMPATIBLE_IOCTL(PPPIOCCONNECT)
+COMPATIBLE_IOCTL(PPPIOCDISCONN)
+COMPATIBLE_IOCTL(PPPIOCATTCHAN)
+COMPATIBLE_IOCTL(PPPIOCGCHAN)
+/* PPPOX */
+COMPATIBLE_IOCTL(PPPOEIOCSFWD)
+COMPATIBLE_IOCTL(PPPOEIOCDFWD)
+	}
+	return -ENOIOCTLCMD;
+}
Index: linux-2.6.14-rc/net/socket.c
===================================================================
--- linux-2.6.14-rc.orig/net/socket.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/net/socket.c	2005-11-05 02:41:18.000000000 +0100
@@ -107,8 +107,6 @@
 static int sock_close(struct inode *inode, struct file *file);
 static unsigned int sock_poll(struct file *file,
 			      struct poll_table_struct *wait);
-static long sock_ioctl(struct file *file,
-		      unsigned int cmd, unsigned long arg);
 static int sock_fasync(int fd, struct file *filp, int on);
 static ssize_t sock_readv(struct file *file, const struct iovec *vector,
 			  unsigned long count, loff_t *ppos);
@@ -130,6 +128,9 @@
 	.aio_write =	sock_aio_write,
 	.poll =		sock_poll,
 	.unlocked_ioctl = sock_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = compat_sock_ioctl,
+#endif
 	.mmap =		sock_mmap,
 	.open =		sock_no_open,	/* special open code to disallow open via /proc */
 	.release =	sock_close,
@@ -834,7 +835,7 @@
  *	what to do with it - that's up to the protocol still.
  */
 
-static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	struct socket *sock;
 	void __user *argp = (void __user *)arg;
Index: linux-2.6.14-rc/fs/compat.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat.c	2005-11-05 02:41:14.000000000 +0100
+++ linux-2.6.14-rc/fs/compat.c	2005-11-05 02:41:18.000000000 +0100
@@ -27,7 +27,6 @@
 #include <linux/ioctl32.h>
 #include <linux/ioctl.h>
 #include <linux/init.h>
-#include <linux/sockios.h>	/* for SIOCDEVPRIVATE */
 #include <linux/smb.h>
 #include <linux/smb_mount.h>
 #include <linux/ncp_mount.h>
@@ -46,8 +45,9 @@
 #include <linux/rwsem.h>
 #include <linux/acct.h>
 #include <linux/mm.h>
-
-#include <net/sock.h>		/* siocdevprivate_ioctl */
+#include <linux/security.h>
+#include <linux/highmem.h>
+#include <linux/poll.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -346,6 +346,7 @@
 	int error = -EBADF;
 	struct ioctl_trans *t;
 	int fput_needed;
+	static int count;
 
 	filp = fget_light(fd, &fput_needed);
 	if (!filp)
@@ -394,16 +395,9 @@
 			goto found_handler;
 	}
 
-	if (S_ISSOCK(filp->f_dentry->d_inode->i_mode) &&
-	    cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
-		error = siocdevprivate_ioctl(fd, cmd, arg);
-	} else {
-		static int count;
-
-		if (++count <= 50)
-			compat_ioctl_error(filp, fd, cmd, arg);
-		error = -EINVAL;
-	}
+	if (++count <= 50)
+		compat_ioctl_error(filp, fd, cmd, arg);
+	error = -EINVAL;
 
 	goto out_fput;
 
Index: linux-2.6.14-rc/include/linux/socket.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/socket.h	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/include/linux/socket.h	2005-11-05 02:41:18.000000000 +0100
@@ -299,6 +299,10 @@
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, void *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
+struct file;
+extern long sock_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+extern long compat_sock_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
 #endif
 #endif /* not kernel and not glibc */
 #endif /* _LINUX_SOCKET_H */
Index: linux-2.6.14-rc/include/net/sock.h
===================================================================
--- linux-2.6.14-rc.orig/include/net/sock.h	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/include/net/sock.h	2005-11-05 02:41:18.000000000 +0100
@@ -1365,15 +1365,6 @@
 extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
 
-#ifdef CONFIG_NET
-int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
-#else
-static inline int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	return -ENODEV;
-}
-#endif
-
 extern void sk_init(void);
 
 #ifdef CONFIG_SYSCTL
Index: linux-2.6.14-rc/include/linux/net.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/net.h	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/include/linux/net.h	2005-11-05 02:41:18.000000000 +0100
@@ -142,6 +142,8 @@
 				      struct poll_table_struct *wait);
 	int		(*ioctl)     (struct socket *sock, unsigned int cmd,
 				      unsigned long arg);
+	int		(*compat_ioctl)(struct socket *sock, unsigned int cmd,
+				      unsigned long arg);
 	int		(*listen)    (struct socket *sock, int len);
 	int		(*shutdown)  (struct socket *sock, int flags);
 	int		(*setsockopt)(struct socket *sock, int level,

--

