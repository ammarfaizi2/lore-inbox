Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTE2T7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTE2T7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:59:19 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:61066 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262589AbTE2T6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:58:45 -0400
Date: Thu, 29 May 2003 22:06:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, pavel@suse.cz, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-ID: <20030529200618.GE1454@elf.ucw.cz>
References: <20030528144839.47efdc4f.akpm@digeo.com.suse.lists.linux.kernel> <20030528215551.GB255@elf.ucw.cz.suse.lists.linux.kernel> <p73wuga6rin.fsf@oldwotan.suse.de> <20030529.023203.41634240.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529.023203.41634240.davem@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    This part won't work on sparc64 because it has separate address spaces
>    for user/kernel.
> 
> Yes, in fact I happen to be working in this area hold on...
> 
> I'm redoing Andi's x86_64 ioctl32 bug fixes more cleanly
> for sparc64 by instead using alloc_user_space().
> 
> Sorry Andi, I just couldn't bring myself to allow those bogus
> artificial limits you added just to fix these bugs... :-)
> 
> This work also pointed out many bugs in this area which should
> be fixed by my stuff. (CDROMREAD* ioctls don't take struct cdrom_read
> they take struct cdrom_msf which is compatible, struct
> cdrom_generic_command32 was missing some members, etc. etc.)
> 
> This is a 2.4.x patch but should be easy to push over to the 2.5.x
> ioctl stuff using the appropriate compat types.

It was painfull but easy to port 2.5.X. Here it is.

Andi, can you take uaccess.h part? Davem, does trivial copy_in_user I
created have expected semantics?
								Pavel

--- linux.clean/include/asm-x86_64/uaccess.h	2003-03-18 08:23:12.000000000 -0800
+++ linux/include/asm-x86_64/uaccess.h	2003-05-29 06:06:07.000000000 -0700
@@ -298,6 +298,19 @@
 	}
 }	
 
+static inline int copy_in_user(void *dst, const void *src, unsigned size) 
+{ 
+	int i, ret;
+	unsigned char c;
+	for (i=0; i<size; i++) {
+		ret = copy_from_user(&c, src, 1);
+		if (ret) return ret;
+		ret = copy_to_user(dst, &c, 1);
+		if (ret) return ret;
+	}
+	return ret;
+}	
+
 long strncpy_from_user(char *dst, const char *src, long count);
 long __strncpy_from_user(char *dst, const char *src, long count);
 long strnlen_user(const char *str, long n);
--- linux.clean/include/linux/compat_ioctl.h	2003-05-27 04:52:28.000000000 -0700
+++ linux/include/linux/compat_ioctl.h	2003-05-29 05:35:16.000000000 -0700
@@ -355,6 +355,15 @@
 COMPATIBLE_IOCTL(CDROM_LOCKDOOR)
 COMPATIBLE_IOCTL(CDROM_DEBUG)
 COMPATIBLE_IOCTL(CDROM_GET_CAPABILITY)
+/* Ignore cdrom.h about these next 5 ioctls, they absolutely do
+ * not take a struct cdrom_read, instead they take a struct cdrom_msf
+ * which is compatible.
+ */
+COMPATIBLE_IOCTL(CDROMREADMODE2)
+COMPATIBLE_IOCTL(CDROMREADMODE1)
+COMPATIBLE_IOCTL(CDROMREADRAW)
+COMPATIBLE_IOCTL(CDROMREADCOOKED)
+COMPATIBLE_IOCTL(CDROMREADALL)
 /* DVD ioctls */
 COMPATIBLE_IOCTL(DVD_READ_STRUCT)
 COMPATIBLE_IOCTL(DVD_WRITE_STRUCT)

--- linux.clean/fs/compat_ioctl.c	2003-05-27 07:36:47.000000000 -0700
+++ linux/fs/compat_ioctl.c	2003-05-29 05:55:16.000000000 -0700
@@ -554,74 +554,27 @@
 
 static int ethtool_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct ifreq ifr;
-	mm_segment_t old_fs;
-	int err, len;
-	u32 data, ethcmd;
+	struct ifreq *ifr;
+	struct ifreq32 *ifr32;
+	u32 data;
+	void *datap;
 	
-	if (copy_from_user(&ifr, (struct ifreq32 *)arg, sizeof(struct ifreq32)))
-		return -EFAULT;
-	ifr.ifr_data = (__kernel_caddr_t)get_zeroed_page(GFP_KERNEL);
-	if (!ifr.ifr_data)
-		return -EAGAIN;
-
-	__get_user(data, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_data));
-
-	if (get_user(ethcmd, (u32 *)compat_ptr(data))) {
-		err = -EFAULT;
-		goto out;
-	}
-	switch (ethcmd) {
-	case ETHTOOL_GDRVINFO:	len = sizeof(struct ethtool_drvinfo); break;
-	case ETHTOOL_GMSGLVL:
-	case ETHTOOL_SMSGLVL:
-	case ETHTOOL_GLINK:
-	case ETHTOOL_NWAY_RST:  len = sizeof(struct ethtool_value); break;
-	case ETHTOOL_GREGS: {
-		struct ethtool_regs *regaddr = compat_ptr(data);
-		/* darned variable size arguments */
-		if (get_user(len, (u32 *)&regaddr->len)) {
-			err = -EFAULT;
-			goto out;
-		}
-		if (len > PAGE_SIZE - sizeof(struct ethtool_regs)) { 
-			err = -EINVAL;
-			goto out;
-		}			
-		len += sizeof(struct ethtool_regs);
-		break;
-	}
-	case ETHTOOL_GSET:
-	case ETHTOOL_SSET:      len = sizeof(struct ethtool_cmd); break;
-	default:
-               err = -EOPNOTSUPP;
-               goto out;
-	}
+	ifr = compat_alloc_user_space(sizeof(*ifr));
+	ifr32 = (struct ifreq32 *) arg;
 
-	if (copy_from_user(ifr.ifr_data, compat_ptr(data), len)) {
-		err = -EFAULT;
-		goto out;
-	}
+	if (copy_in_user(&ifr->ifr_name, &ifr32->ifr_name, IFNAMSIZ))
+		return -EFAULT;
 
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, cmd, (unsigned long)&ifr);
-	set_fs (old_fs);
-	if (!err) {
-		u32 data;
+	if (get_user(data, &ifr32->ifr_ifru.ifru_data))
+		return -EFAULT;
 
-		__get_user(data, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_data));
-		len = copy_to_user(compat_ptr(data), ifr.ifr_data, len);
-		if (len)
-			err = -EFAULT;
-	}
+	datap = (void *) (unsigned long) data;
+	if (put_user(datap, &ifr->ifr_ifru.ifru_data))
+		return -EFAULT;
 
-out:
-	free_page((unsigned long)ifr.ifr_data);
-	return err;
+	return sys_ioctl(fd, cmd, (unsigned long) ifr);
 }
 
-
 static int bond_ioctl(unsigned long fd, unsigned int cmd, unsigned long arg)
 {
 	struct ifreq ifr;
@@ -894,65 +847,113 @@
 	compat_caddr_t	transp;
 };
 
-static int fb_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+static int do_cmap_ptr(__u16 **ptr64, __u32 *ptr32)
 {
-	mm_segment_t old_fs = get_fs();
-	u32 red = 0, green = 0, blue = 0, transp = 0;
+	__u32 data;
+	void *datap;
+
+	if (get_user(data, ptr32))
+		return -EFAULT;
+	datap = (void *) (unsigned long) data;
+	if (put_user(datap, ptr64))
+		return -EFAULT;
+	return 0;
+}
+
+static int fb_getput_cmap(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct fb_cmap *cmap;
+	struct fb_cmap32 *cmap32;
+	int err;
+
+	cmap = compat_alloc_user_space(sizeof(*cmap));
+	cmap32 = (struct fb_cmap32 *) arg;
+
+	if (copy_in_user(&cmap->start, &cmap32->start, 2 * sizeof(__u32)))
+		return -EFAULT;
+
+	if (do_cmap_ptr(&cmap->red, &cmap32->red) ||
+	    do_cmap_ptr(&cmap->green, &cmap32->green) ||
+	    do_cmap_ptr(&cmap->blue, &cmap32->blue) ||
+	    do_cmap_ptr(&cmap->transp, &cmap32->transp))
+		return -EFAULT;
+
+	err = sys_ioctl(fd, cmd, (unsigned long) cmap);
+
+	if (!err) {
+		if (copy_in_user(&cmap32->start,
+				 &cmap->start,
+				 2 * sizeof(__u32)))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
+				  struct fb_fix_screeninfo32 *fix32)
+{
+	__u32 data;
+	int err;
+
+	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix32->id));
+
+	data = (__u32) (unsigned long) fix->smem_start;
+	err |= put_user(data, &fix32->smem_start);
+
+	err |= put_user(fix->smem_len, &fix32->smem_len);
+	err |= put_user(fix->type, &fix32->type);
+	err |= put_user(fix->type_aux, &fix32->type_aux);
+	err |= put_user(fix->visual, &fix32->visual);
+	err |= put_user(fix->xpanstep, &fix32->xpanstep);
+	err |= put_user(fix->ypanstep, &fix32->ypanstep);
+	err |= put_user(fix->ywrapstep, &fix32->ywrapstep);
+	err |= put_user(fix->line_length, &fix32->line_length);
+
+	data = (__u32) (unsigned long) fix->mmio_start;
+	err |= put_user(data, &fix32->mmio_start);
+
+	err |= put_user(fix->mmio_len, &fix32->mmio_len);
+	err |= put_user(fix->accel, &fix32->accel);
+	err |= copy_to_user(fix32->reserved, fix->reserved,
+			    sizeof(fix->reserved));
+
+	return err;
+}
+
+static int fb_get_fscreeninfo(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs;
 	struct fb_fix_screeninfo fix;
-	struct fb_cmap cmap;
-	void *karg;
-	int err = 0;
+	struct fb_fix_screeninfo32 *fix32;
+	int err;
+
+	fix32 = (struct fb_fix_screeninfo32 *) arg;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = sys_ioctl(fd, cmd, (unsigned long) &fix);
+	set_fs(old_fs);
+
+	if (!err)
+		err = do_fscreeninfo_to_user(&fix, fix32);
+
+	return err;
+}
+
+static int fb_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	int err;
 
-	memset(&cmap, 0, sizeof(cmap));
 	switch (cmd) {
 	case FBIOGET_FSCREENINFO:
-		karg = &fix;
+		err = fb_get_fscreeninfo(fd,cmd, arg);
 		break;
-	case FBIOGETCMAP:
-	case FBIOPUTCMAP:
-		karg = &cmap;
-		err = __get_user(cmap.start, &((struct fb_cmap32 *)arg)->start);
-		err |= __get_user(cmap.len, &((struct fb_cmap32 *)arg)->len);
-		err |= __get_user(red, &((struct fb_cmap32 *)arg)->red);
-		err |= __get_user(green, &((struct fb_cmap32 *)arg)->green);
-		err |= __get_user(blue, &((struct fb_cmap32 *)arg)->blue);
-		err |= __get_user(transp, &((struct fb_cmap32 *)arg)->transp);
-		if (err) {
-			err = -EFAULT;
-			goto out;
-		}
-		if (cmap.len > PAGE_SIZE/sizeof(u16)) { 
-			err = -EINVAL;
-			goto out;
-		}
-		err = -ENOMEM;
-		cmap.red = kmalloc(cmap.len * sizeof(__u16), GFP_KERNEL);
-		if (!cmap.red)
-			goto out;
-		cmap.green = kmalloc(cmap.len * sizeof(__u16), GFP_KERNEL);
-		if (!cmap.green)
-			goto out;
-		cmap.blue = kmalloc(cmap.len * sizeof(__u16), GFP_KERNEL);
-		if (!cmap.blue)
-			goto out;
-		if (transp) {
-			cmap.transp = kmalloc(cmap.len * sizeof(__u16), GFP_KERNEL);
-			if (!cmap.transp)
-				goto out;
-		}
-			
-		if (cmd == FBIOGETCMAP)
-			break;
 
-		err = __copy_from_user(cmap.red, compat_ptr(red), cmap.len * sizeof(__u16));
-		err |= __copy_from_user(cmap.green, compat_ptr(green), cmap.len * sizeof(__u16));
-		err |= __copy_from_user(cmap.blue, compat_ptr(blue), cmap.len * sizeof(__u16));
-		if (cmap.transp) err |= __copy_from_user(cmap.transp, compat_ptr(transp), cmap.len * sizeof(__u16));
-		if (err) {
-			err = -EFAULT;
-			goto out;
-		}
+  	case FBIOGETCMAP:
+	case FBIOPUTCMAP:
+		err = fb_getput_cmap(fd, cmd, arg);
 		break;
+
 	default:
 		do {
 			static int count;
@@ -961,47 +962,10 @@
 				       "cmd(%08x) arg(%08lx)\n",
 				       __FUNCTION__, fd, cmd, arg);
 		} while(0);
-		return -ENOSYS;
-	}
-	set_fs(KERNEL_DS);
-	err = sys_ioctl(fd, cmd, (unsigned long)karg);
-	set_fs(old_fs);
-	if (err)
-		goto out;
-	switch (cmd) {
-	case FBIOGET_FSCREENINFO:
-		err = __copy_to_user((char *)((struct fb_fix_screeninfo32 *)arg)->id, (char *)fix.id, sizeof(fix.id));
-		err |= __put_user((__u32)(unsigned long)fix.smem_start, &((struct fb_fix_screeninfo32 *)arg)->smem_start);
-		err |= __put_user(fix.smem_len, &((struct fb_fix_screeninfo32 *)arg)->smem_len);
-		err |= __put_user(fix.type, &((struct fb_fix_screeninfo32 *)arg)->type);
-		err |= __put_user(fix.type_aux, &((struct fb_fix_screeninfo32 *)arg)->type_aux);
-		err |= __put_user(fix.visual, &((struct fb_fix_screeninfo32 *)arg)->visual);
-		err |= __put_user(fix.xpanstep, &((struct fb_fix_screeninfo32 *)arg)->xpanstep);
-		err |= __put_user(fix.ypanstep, &((struct fb_fix_screeninfo32 *)arg)->ypanstep);
-		err |= __put_user(fix.ywrapstep, &((struct fb_fix_screeninfo32 *)arg)->ywrapstep);
-		err |= __put_user(fix.line_length, &((struct fb_fix_screeninfo32 *)arg)->line_length);
-		err |= __put_user((__u32)(unsigned long)fix.mmio_start, &((struct fb_fix_screeninfo32 *)arg)->mmio_start);
-		err |= __put_user(fix.mmio_len, &((struct fb_fix_screeninfo32 *)arg)->mmio_len);
-		err |= __put_user(fix.accel, &((struct fb_fix_screeninfo32 *)arg)->accel);
-		err |= __copy_to_user((char *)((struct fb_fix_screeninfo32 *)arg)->reserved, (char *)fix.reserved, sizeof(fix.reserved));
-		break;
-	case FBIOGETCMAP:
-		err = __copy_to_user(compat_ptr(red), cmap.red, cmap.len * sizeof(__u16));
-		err |= __copy_to_user(compat_ptr(green), cmap.blue, cmap.len * sizeof(__u16));
-		err |= __copy_to_user(compat_ptr(blue), cmap.blue, cmap.len * sizeof(__u16));
-		if (cmap.transp)
-			err |= __copy_to_user(compat_ptr(transp), cmap.transp, cmap.len * sizeof(__u16));
+		err = -ENOSYS;
 		break;
-	case FBIOPUTCMAP:
-		break;
-	}
-	if (err)
-		err = -EFAULT;
+	};
 
-out:	if (cmap.red) kfree(cmap.red);
-	if (cmap.green) kfree(cmap.green);
-	if (cmap.blue) kfree(cmap.blue);
-	if (cmap.transp) kfree(cmap.transp);
 	return err;
 }
 
@@ -1056,141 +1020,118 @@
 	compat_uint_t iov_len;
 } sg_iovec32_t;
 
-#define EMU_SG_MAX 128
-
-static int alloc_sg_iovec(sg_io_hdr_t *sgp, u32 uptr32)
+static int sg_build_iovec(sg_io_hdr_t *sgio, void *dxferp, u16 iovec_count)
 {
-	sg_iovec32_t *uiov = compat_ptr(uptr32);
-	sg_iovec_t *kiov;
+	sg_iovec_t *iov = (sg_iovec_t *) (sgio + 1);
+	sg_iovec32_t *iov32 = dxferp;
 	int i;
 
-	if (sgp->iovec_count > EMU_SG_MAX)
-		return -EINVAL;
-	sgp->dxferp = kmalloc(sgp->iovec_count *
-			      sizeof(sg_iovec_t), GFP_KERNEL);
-	if (!sgp->dxferp)
-		return -ENOMEM;
-	memset(sgp->dxferp, 0,
-	       sgp->iovec_count * sizeof(sg_iovec_t));
-
-	kiov = (sg_iovec_t *) sgp->dxferp;
-	for (i = 0; i < sgp->iovec_count; i++) {
-		u32 iov_base32;
-		if (__get_user(iov_base32, &uiov->iov_base) ||
-		    __get_user(kiov->iov_len, &uiov->iov_len))
-			return -EFAULT;
-		if (verify_area(VERIFY_WRITE, compat_ptr(iov_base32), kiov->iov_len))
+	for (i = 0; i < iovec_count; i++) {
+		u32 base, len;
+
+		if (get_user(base, &iov32[i].iov_base) ||
+		    get_user(len, &iov32[i].iov_len) ||
+		    put_user((void *)(unsigned long)base, &iov[i].iov_base) ||
+		    put_user(len, &iov[i].iov_len))
 			return -EFAULT;
-		kiov->iov_base = compat_ptr(iov_base32);
-		uiov++;
-		kiov++;
 	}
 
 	return 0;
 }
 
-static void free_sg_iovec(sg_io_hdr_t *sgp)
-{
-	kfree(sgp->dxferp);
-	sgp->dxferp = NULL;
-}
-
 static int sg_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	sg_io_hdr32_t *sg_io32;
-	sg_io_hdr_t sg_io64;
-	u32 dxferp32, cmdp32, sbp32;
-	mm_segment_t old_fs;
-	int err = 0;
+	sg_io_hdr_t *sgio;
+	sg_io_hdr32_t *sgio32;
+	u16 iovec_count;
+	u32 data;
+	void *dxferp;
+	int err;
 
-	sg_io32 = (sg_io_hdr32_t *)arg;
-	err = __get_user(sg_io64.interface_id, &sg_io32->interface_id);
-	err |= __get_user(sg_io64.dxfer_direction, &sg_io32->dxfer_direction);
-	err |= __get_user(sg_io64.cmd_len, &sg_io32->cmd_len);
-	err |= __get_user(sg_io64.mx_sb_len, &sg_io32->mx_sb_len);
-	err |= __get_user(sg_io64.iovec_count, &sg_io32->iovec_count);
-	err |= __get_user(sg_io64.dxfer_len, &sg_io32->dxfer_len);
-	err |= __get_user(sg_io64.timeout, &sg_io32->timeout);
-	err |= __get_user(sg_io64.flags, &sg_io32->flags);
-	err |= __get_user(sg_io64.pack_id, &sg_io32->pack_id);
-
-	sg_io64.dxferp = NULL;
-	sg_io64.cmdp = NULL;
-	sg_io64.sbp = NULL;
-
-	err |= __get_user(cmdp32, &sg_io32->cmdp);
-	sg_io64.cmdp = kmalloc(sg_io64.cmd_len, GFP_KERNEL);
-	if (copy_from_user(sg_io64.cmdp,
-			   compat_ptr(cmdp32),
-			   sg_io64.cmd_len)) {
-		err = -EFAULT;
-		goto out;
-	}
+	sgio32 = (sg_io_hdr32_t *) arg;
+	if (get_user(iovec_count, &sgio32->iovec_count))
+		return -EFAULT;
 
-	err |= __get_user(sbp32, &sg_io32->sbp);
-	sg_io64.sbp = kmalloc(sg_io64.mx_sb_len, GFP_KERNEL);
-	if (!sg_io64.sbp) {
-		err = -ENOMEM;
-		goto out;
-	}
-	if (copy_from_user(sg_io64.sbp,
-			   compat_ptr(sbp32),
-			   sg_io64.mx_sb_len)) {
-		err = -EFAULT;
-		goto out;
+	{
+		void *new, *top;
+
+		top = compat_alloc_user_space(0);
+		new = compat_alloc_user_space(sizeof(sg_io_hdr_t) +
+				       (iovec_count *
+					sizeof(sg_iovec_t)));
+		if (new > top)
+			return -EINVAL;
+
+		sgio = new;
 	}
 
-	err |= __get_user(dxferp32, &sg_io32->dxferp);
-	if (sg_io64.iovec_count) {
-		int ret;
-
-		if ((ret = alloc_sg_iovec(&sg_io64, dxferp32))) {
-			err = ret;
-			goto out;
-		}
+	/* Ok, now construct.  */
+	if (copy_in_user(&sgio->interface_id, &sgio32->interface_id,
+			 (2 * sizeof(int)) +
+			 (2 * sizeof(unsigned char)) +
+			 (1 * sizeof(unsigned short)) +
+			 (1 * sizeof(unsigned int))))
+		return -EFAULT;
+
+	if (get_user(data, &sgio32->dxferp))
+		return -EFAULT;
+	dxferp = (void *) (unsigned long) data;
+	if (iovec_count) {
+		if (sg_build_iovec(sgio, dxferp, iovec_count))
+			return -EFAULT;
 	} else {
-		err = verify_area(VERIFY_WRITE, compat_ptr(dxferp32), sg_io64.dxfer_len);
-		if (err) 
-			goto out;
+		if (put_user(dxferp, &sgio->dxferp))
+			return -EFAULT;
+	}
+
+	{
+		unsigned char *cmdp, *sbp;
+
+		if (get_user(data, &sgio32->cmdp))
+			return -EFAULT;
+		cmdp = (unsigned char *) (unsigned long) data;
 
-		sg_io64.dxferp = compat_ptr(dxferp32); 
+		if (get_user(data, &sgio32->sbp))
+			return -EFAULT;
+		sbp = (unsigned char *) (unsigned long) data;
+
+		if (put_user(cmdp, &sgio->cmdp) ||
+		    put_user(sbp, &sgio->sbp))
+			return -EFAULT;
 	}
 
-	/* Unused internally, do not even bother to copy it over. */
-	sg_io64.usr_ptr = NULL;
+	if (copy_in_user(&sgio->timeout, &sgio32->timeout,
+			 3 * sizeof(int)))
+		return -EFAULT;
 
-	if (err)
+	if (get_user(data, &sgio32->usr_ptr))
+		return -EFAULT;
+	if (put_user((void *)(unsigned long)data, &sgio->usr_ptr))
 		return -EFAULT;
 
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, cmd, (unsigned long) &sg_io64);
-	set_fs (old_fs);
+	if (copy_in_user(&sgio->status, &sgio32->status,
+			 (4 * sizeof(unsigned char)) +
+			 (2 * sizeof(unsigned (short))) +
+			 (3 * sizeof(int))))
+		return -EFAULT;
 
-	if (err < 0)
-		goto out;
+	err = sys_ioctl(fd, cmd, (unsigned long) sgio);
 
-	err = __put_user(sg_io64.pack_id, &sg_io32->pack_id);
-	err |= __put_user(sg_io64.status, &sg_io32->status);
-	err |= __put_user(sg_io64.masked_status, &sg_io32->masked_status);
-	err |= __put_user(sg_io64.msg_status, &sg_io32->msg_status);
-	err |= __put_user(sg_io64.sb_len_wr, &sg_io32->sb_len_wr);
-	err |= __put_user(sg_io64.host_status, &sg_io32->host_status);
-	err |= __put_user(sg_io64.driver_status, &sg_io32->driver_status);
-	err |= __put_user(sg_io64.resid, &sg_io32->resid);
-	err |= __put_user(sg_io64.duration, &sg_io32->duration);
-	err |= __put_user(sg_io64.info, &sg_io32->info);
-	err |= copy_to_user(compat_ptr(sbp32), sg_io64.sbp, sg_io64.mx_sb_len);
-	if (err)
-		err = -EFAULT;
+	if (err >= 0) {
+		void *datap;
+
+		if (copy_in_user(&sgio32->pack_id, &sgio->pack_id,
+				 sizeof(int)) ||
+		    get_user(datap, &sgio->usr_ptr) ||
+		    put_user((u32)(unsigned long)datap,
+			     &sgio32->usr_ptr) ||
+		    copy_in_user(&sgio32->status, &sgio->status,
+				 (4 * sizeof(unsigned char)) +
+				 (2 * sizeof(unsigned short)) +
+				 (3 * sizeof(int))))
+			err = -EFAULT;
+	}
 
-out:
-	if (sg_io64.cmdp)
-		kfree(sg_io64.cmdp);
-	if (sg_io64.sbp)
-		kfree(sg_io64.sbp);
-	if (sg_io64.dxferp && sg_io64.iovec_count)
-			free_sg_iovec(&sg_io64);
 	return err;
 }
 
@@ -1241,39 +1182,65 @@
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
+static int ppp_gidle(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct ppp_idle *idle;
+	struct ppp_idle32 *idle32;
+	__kernel_time_t xmit, recv;
+	int err;
+
+	idle = compat_alloc_user_space(sizeof(*idle));
+	idle32 = (struct ppp_idle32 *) arg;
+
+	err = sys_ioctl(fd, PPPIOCGIDLE, (unsigned long) idle);
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
+static int ppp_scompress(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct ppp_option_data *odata;
+	struct ppp_option_data32 *odata32;
+	__u32 data;
+	void *datap;
+
+	odata = compat_alloc_user_space(sizeof(*odata));
+	odata32 = (struct ppp_option_data32 *) arg;
+
+	if (get_user(data, &odata32->ptr))
+		return -EFAULT;
+
+	datap = (void *) (unsigned long) data;
+	if (put_user(datap, &odata->ptr))
+		return -EFAULT;
+
+	if (copy_in_user(&odata->length, &odata32->length,
+			 sizeof(__u32) + sizeof(int)))
+		return -EFAULT;
+
+	return sys_ioctl(fd, PPPIOCSCOMPRESS, (unsigned long) odata);
+}
+
 static int ppp_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	mm_segment_t old_fs = get_fs();
-	struct ppp_option_data32 data32;
-	struct ppp_option_data data;
-	struct ppp_idle32 idle32;
-	struct ppp_idle idle;
-	unsigned int kcmd;
-	void *karg;
-	int err = 0;
+	int err;
 
 	switch (cmd) {
 	case PPPIOCGIDLE32:
-		kcmd = PPPIOCGIDLE;
-		karg = &idle;
+		err = ppp_gidle(fd, cmd, arg);
 		break;
+
 	case PPPIOCSCOMPRESS32:
-		if (copy_from_user(&data32, (struct ppp_option_data32 *)arg, sizeof(struct ppp_option_data32)))
-			return -EFAULT;
-		if (data32.length > PAGE_SIZE) 
-			return -EINVAL;
-		data.ptr = kmalloc (data32.length, GFP_KERNEL);
-		if (!data.ptr)
-			return -ENOMEM;
-		if (copy_from_user(data.ptr, compat_ptr(data32.ptr), data32.length)) {
-			kfree(data.ptr);
-			return -EFAULT;
-		}
-		data.length = data32.length;
-		data.transmit = data32.transmit;
-		kcmd = PPPIOCSCOMPRESS;
-		karg = &data;
+		err = ppp_scompress(fd, cmd, arg);
 		break;
+
 	default:
 		do {
 			static int count;
@@ -1282,26 +1249,10 @@
 				       "cmd(%08x) arg(%08x)\n",
 				       (int)fd, (unsigned int)cmd, (unsigned int)arg);
 		} while(0);
-		return -EINVAL;
-	}
-	set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, kcmd, (unsigned long)karg);
-	set_fs (old_fs);
-	switch (cmd) {
-	case PPPIOCGIDLE32:
-		if (err)
-			return err;
-		idle32.xmit_idle = idle.xmit_idle;
-		idle32.recv_idle = idle.recv_idle;
-		if (copy_to_user((struct ppp_idle32 *)arg, &idle32, sizeof(struct ppp_idle32)))
-			return -EFAULT;
-		break;
-	case PPPIOCSCOMPRESS32:
-		kfree(data.ptr);
-		break;
-	default:
+		err = -EINVAL;
 		break;
-	}
+	};
+
 	return err;
 }
 
@@ -1429,12 +1380,6 @@
 	return err ? -EFAULT: 0;
 }
 
-struct cdrom_read32 {
-	compat_int_t	cdread_lba;
-	compat_caddr_t	cdread_bufaddr;
-	compat_int_t	cdread_buflen;
-};
-
 struct cdrom_read_audio32 {
 	union cdrom_addr	addr;
 	u8			addr_format;
@@ -1448,60 +1393,94 @@
 	compat_uint_t	buflen;
 	compat_int_t	stat;
 	compat_caddr_t	sense;
-	compat_caddr_t	reserved[3];	/* Oops? it has data_direction, quiet and timeout fields? */
-};
+	unsigned char	data_direction;
+	compat_int_t	quiet;
+	compat_int_t	timeout;
+	compat_caddr_t	reserved[1];
+};
+  
+static int cdrom_do_read_audio(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct cdrom_read_audio *cdread_audio;
+	struct cdrom_read_audio32 *cdread_audio32;
+	__u32 data;
+	void *datap;
+
+	cdread_audio = compat_alloc_user_space(sizeof(*cdread_audio));
+	cdread_audio32 = (struct cdrom_read_audio32 *) arg;
+
+	if (copy_in_user(&cdread_audio->addr,
+			 &cdread_audio32->addr,
+			 (sizeof(*cdread_audio32) -
+			  sizeof(compat_caddr_t))))
+	 	return -EFAULT;
+
+	if (get_user(data, &cdread_audio32->buf))
+		return -EFAULT;
+	datap = (void *) (unsigned long) data;
+	if (put_user(datap, &cdread_audio->buf))
+		return -EFAULT;
+
+	return sys_ioctl(fd, cmd, (unsigned long) cdread_audio);
+}
+
+static int __cgc_do_ptr(void **ptr64, __u32 *ptr32)
+{
+	u32 data;
+	void *datap;
+
+	if (get_user(data, ptr32))
+		return -EFAULT;
+	datap = (void *) (unsigned long) data;
+	if (put_user(datap, ptr64))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int cdrom_do_generic_command(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct cdrom_generic_command *cgc;
+	struct cdrom_generic_command32 *cgc32;
+	unsigned char dir;
+
+	cgc = compat_alloc_user_space(sizeof(*cgc));
+	cgc32 = (struct cdrom_generic_command32 *) arg;
+
+	if (copy_in_user(&cgc->cmd, &cgc32->cmd, sizeof(cgc->cmd)) ||
+	    __cgc_do_ptr((void **) &cgc->buffer, &cgc32->buffer) ||
+	    copy_in_user(&cgc->buflen, &cgc32->buflen,
+			 (sizeof(unsigned int) + sizeof(int))) ||
+	    __cgc_do_ptr((void **) &cgc->sense, &cgc32->sense))
+		return -EFAULT;
+
+	if (get_user(dir, &cgc->data_direction) ||
+	    put_user(dir, &cgc32->data_direction))
+		return -EFAULT;
+
+	if (copy_in_user(&cgc->quiet, &cgc32->quiet,
+			 2 * sizeof(int)))
+		return -EFAULT;
+
+	if (__cgc_do_ptr(&cgc->reserved[0], &cgc32->reserved[0]))
+		return -EFAULT;
+
+	return sys_ioctl(fd, cmd, (unsigned long) cgc);
+}
 
 static int cdrom_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	mm_segment_t old_fs = get_fs();
-	struct cdrom_read cdread;
-	struct cdrom_read_audio cdreadaudio;
-	struct cdrom_generic_command cgc;
-	compat_caddr_t addr;
-	char *data = 0;
-	void *karg;
-	int err = 0;
+	int err;
 
 	switch(cmd) {
-	case CDROMREADMODE2:
-	case CDROMREADMODE1:
-	case CDROMREADRAW:
-	case CDROMREADCOOKED:
-		karg = &cdread;
-		err = __get_user(cdread.cdread_lba, &((struct cdrom_read32 *)arg)->cdread_lba);
-		err |= __get_user(addr, &((struct cdrom_read32 *)arg)->cdread_bufaddr);
-		err |= __get_user(cdread.cdread_buflen, &((struct cdrom_read32 *)arg)->cdread_buflen);
-		if (err)
-			return -EFAULT;
-		if (verify_area(VERIFY_WRITE, compat_ptr(addr), cdread.cdread_buflen))
-			return -EFAULT;
-		cdread.cdread_bufaddr = compat_ptr(addr);
-		break;
 	case CDROMREADAUDIO:
-		karg = &cdreadaudio;
-		err = copy_from_user(&cdreadaudio.addr, &((struct cdrom_read_audio32 *)arg)->addr, sizeof(cdreadaudio.addr));
-		err |= __get_user(cdreadaudio.addr_format, &((struct cdrom_read_audio32 *)arg)->addr_format);
-		err |= __get_user(cdreadaudio.nframes, &((struct cdrom_read_audio32 *)arg)->nframes); 
-		err |= __get_user(addr, &((struct cdrom_read_audio32 *)arg)->buf);
-		if (err)
-			return -EFAULT;
-		
-
-		if (verify_area(VERIFY_WRITE, compat_ptr(addr), cdreadaudio.nframes*2352))
-			return -EFAULT;
-		cdreadaudio.buf = compat_ptr(addr);
+		err = cdrom_do_read_audio(fd, cmd, arg);
 		break;
+
 	case CDROM_SEND_PACKET:
-		karg = &cgc;
-		err = copy_from_user(cgc.cmd, &((struct cdrom_generic_command32 *)arg)->cmd, sizeof(cgc.cmd));
-		err |= __get_user(addr, &((struct cdrom_generic_command32 *)arg)->buffer);
-		err |= __get_user(cgc.buflen, &((struct cdrom_generic_command32 *)arg)->buflen);
-		if (err)
-			return -EFAULT;
-		if (verify_area(VERIFY_WRITE, compat_ptr(addr), cgc.buflen))
-			return -EFAULT;
-		cgc.buffer = compat_ptr(addr);
+		err = cdrom_do_generic_command(fd, cmd, arg);
 		break;
+
 	default:
 		do {
 			static int count;
@@ -1510,14 +1489,11 @@
 				       "cmd(%08x) arg(%08x)\n",
 				       (int)fd, (unsigned int)cmd, (unsigned int)arg);
 		} while(0);
-		return -EINVAL;
-	}
-	set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, cmd, (unsigned long)karg);
-	set_fs (old_fs);
-	if (data)
-		kfree(data);
-	return err ? -EFAULT : 0;
+		err = -EINVAL;
+		break;
+	};
+
+	return err;
 }
 
 struct loop_info32 {
@@ -1547,7 +1523,6 @@
 		err |= __get_user(l.lo_device, &((struct loop_info32 *)arg)->lo_device);
 		err |= __get_user(l.lo_inode, &((struct loop_info32 *)arg)->lo_inode);
 		err |= __get_user(l.lo_rdevice, &((struct loop_info32 *)arg)->lo_rdevice);
-		
 		err |= __copy_from_user((char *)&l.lo_offset, (char *)&((struct loop_info32 *)arg)->lo_offset,
 					   8 + (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
 		if (err) {
@@ -1792,68 +1767,62 @@
 
 static int do_atm_iobuf(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct atm_iobuf32 iobuf32;
-	struct atm_iobuf   iobuf = { 0, NULL };
-	mm_segment_t old_fs;
-	int err;
+	struct atm_iobuf   *iobuf;
+	struct atm_iobuf32 *iobuf32;
+	u32 data;
+	void *datap;
+	int len, err;
 
-	err = copy_from_user(&iobuf32, (struct atm_iobuf32*)arg,
-	    sizeof(struct atm_iobuf32));
-	if (err)
+	iobuf = compat_alloc_user_space(sizeof(*iobuf));
+	iobuf32 = (struct atm_iobuf32 *) arg;
+
+	if (get_user(len, &iobuf32->length) ||
+	    get_user(data, &iobuf32->buffer))
+		return -EFAULT;
+	datap = (void *) (unsigned long) data;
+	if (put_user(len, &iobuf->length) ||
+	    put_user(datap, &iobuf->buffer))
 		return -EFAULT;
 
-	iobuf.length = iobuf32.length;
+	err = sys_ioctl(fd, cmd, (unsigned long)iobuf);
 
-	if (iobuf32.buffer == (compat_caddr_t) NULL || iobuf32.length == 0) {
-		iobuf.buffer = (void*)(unsigned long)iobuf32.buffer;
-	} else {
-		iobuf.buffer = compat_ptr(iobuf32.buffer);
-		if (verify_area(VERIFY_WRITE, iobuf.buffer, iobuf.length))
-			return -EINVAL;
+	if (!err) {
+		if (copy_in_user(&iobuf32->length, &iobuf->length,
+				 sizeof(int)))
+			err = -EFAULT;
 	}
 
-	old_fs = get_fs(); set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, cmd, (unsigned long)&iobuf);      
-	set_fs (old_fs);
-        if(!err)
-	err = __put_user(iobuf.length, &(((struct atm_iobuf32*)arg)->length));
-
 	return err;
 }
 
-
 static int do_atmif_sioc(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-        struct atmif_sioc32 sioc32;
-        struct atmif_sioc   sioc = { 0, 0, NULL };
-        mm_segment_t old_fs;
-        int err;
+        struct atmif_sioc   *sioc;
+	struct atmif_sioc32 *sioc32;
+	u32 data;
+	void *datap;
+	int err;
         
-        err = copy_from_user(&sioc32, (struct atmif_sioc32*)arg,
-			     sizeof(struct atmif_sioc32));
-        if (err)
-                return -EFAULT;
+	sioc = compat_alloc_user_space(sizeof(*sioc));
+	sioc32 = (struct atmif_sioc32 *) arg;
 
-        sioc.number = sioc32.number;
-        sioc.length = sioc32.length;
-        
-	if (sioc32.arg == (compat_caddr_t) NULL || sioc32.length == 0) {
-		sioc.arg = (void*)(unsigned long)sioc32.arg;
-        } else {
-		sioc.arg = compat_ptr(sioc32.arg);
-		if (verify_area(VERIFY_WRITE, sioc.arg, sioc32.length))
-			return -EFAULT;
-        }
-        
-        old_fs = get_fs(); set_fs (KERNEL_DS);
-        err = sys_ioctl (fd, cmd, (unsigned long)&sioc);	
-        set_fs (old_fs);
-	if (!err)
-        err = __put_user(sioc.length, &(((struct atmif_sioc32*)arg)->length));
+	if (copy_in_user(&sioc->number, &sioc32->number, 2 * sizeof(int)) ||
+	    get_user(data, &sioc32->arg))
+		return -EFAULT;
+	datap = (void *) (unsigned long) data;
+	if (put_user(datap, &sioc->arg))
+		return -EFAULT;
+
+	err = sys_ioctl(fd, cmd, (unsigned long) sioc);
+
+	if (!err) {
+		if (copy_in_user(&sioc32->length, &sioc->length,
+				 sizeof(int)))
+			err = -EFAULT;
+	}
 	return err;
 }
 
-
 static int do_atm_ioctl(unsigned int fd, unsigned int cmd32, unsigned long arg)
 {
         int i;
@@ -1871,15 +1840,14 @@
 		return do_atmif_sioc(fd, cmd32, arg);
 	}
 
-		for (i = 0; i < NR_ATM_IOCTL; i++) {
-			if (cmd32 == atm_ioctl_map[i].cmd32) {
-				cmd = atm_ioctl_map[i].cmd;
-				break;
-			}
+	for (i = 0; i < NR_ATM_IOCTL; i++) {
+		if (cmd32 == atm_ioctl_map[i].cmd32) {
+			cmd = atm_ioctl_map[i].cmd;
+			break;
 		}
-	        if (i == NR_ATM_IOCTL) {
+	}
+	if (i == NR_ATM_IOCTL)
 	        return -EINVAL;
-	        }
         
         switch (cmd) {
 	case ATM_GETNAMES:
@@ -2310,36 +2278,33 @@
 
 static int mtd_rw_oob(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	mm_segment_t 			old_fs 	= get_fs();
-	struct mtd_oob_buf32	*uarg 	= (struct mtd_oob_buf32 *)arg;
-	struct mtd_oob_buf		karg;
-	u32 tmp;
-	int ret;
+	struct mtd_oob_buf	*buf = compat_alloc_user_space(sizeof(*buf));
+	struct mtd_oob_buf32	*buf32 = (struct mtd_oob_buf32 *) arg;
+	u32 data;
+	char *datap;
+	unsigned int real_cmd;
+	int err;
 
-	if (get_user(karg.start, &uarg->start) 		||
-	    get_user(karg.length, &uarg->length)	||
-	    get_user(tmp, &uarg->ptr))
-		return -EFAULT;
+	real_cmd = (cmd == MEMREADOOB32) ?
+		MEMREADOOB : MEMWRITEOOB;
 
-	karg.ptr = compat_ptr(tmp); 
-	if (verify_area(VERIFY_WRITE, karg.ptr, karg.length))
+	if (copy_in_user(&buf->start, &buf32->start,
+			 2 * sizeof(u32)) ||
+	    get_user(data, &buf32->ptr))
+		return -EFAULT;
+	datap = (void *) (unsigned long) data;
+	if (put_user(datap, &buf->ptr))
 		return -EFAULT;
 
-	set_fs(KERNEL_DS);
-	if (MEMREADOOB32 == cmd) 
-		ret = sys_ioctl(fd, MEMREADOOB, (unsigned long)&karg);
-	else if (MEMWRITEOOB32 == cmd)
-		ret = sys_ioctl(fd, MEMWRITEOOB, (unsigned long)&karg);
-	else
-		ret = -EINVAL;
-	set_fs(old_fs);
+	err = sys_ioctl(fd, real_cmd, (unsigned long) buf);
 
-	if (0 == ret && cmd == MEMREADOOB32) {
-		ret = put_user(karg.start, &uarg->start);
-		ret |= put_user(karg.length, &uarg->length);
+	if (!err) {
+		if (copy_in_user(&buf32->start, &buf->start,
+				 2 * sizeof(u32)))
+			err = -EFAULT;
 	}
 
-	return ret;
+	return err;
 }	
 
 #undef CODE
@@ -2426,12 +2391,7 @@
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 HANDLE_IOCTL(MTIOCGETCONFIG32, mt_ioctl_trans)
 HANDLE_IOCTL(MTIOCSETCONFIG32, mt_ioctl_trans)
-HANDLE_IOCTL(CDROMREADMODE2, cdrom_ioctl_trans)
-HANDLE_IOCTL(CDROMREADMODE1, cdrom_ioctl_trans)
-HANDLE_IOCTL(CDROMREADRAW, cdrom_ioctl_trans)
-HANDLE_IOCTL(CDROMREADCOOKED, cdrom_ioctl_trans)
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
-HANDLE_IOCTL(CDROMREADALL, cdrom_ioctl_trans)
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
 HANDLE_IOCTL(LOOP_SET_STATUS, loop_status)
 HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
