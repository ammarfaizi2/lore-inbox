Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262636AbSJLB2x>; Fri, 11 Oct 2002 21:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262645AbSJLB2w>; Fri, 11 Oct 2002 21:28:52 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:63461 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S262636AbSJLB2P>; Fri, 11 Oct 2002 21:28:15 -0400
Date: Fri, 11 Oct 2002 18:27:24 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [BK PATCH] console changes 3
Message-ID: <Pine.LNX.4.33.0210111825480.2595-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Seperation of some framebuffer code from the console code. Moving away
come of the code from the global variable currcon to using a struct
vc_data that reperents each VC.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.714.6.3, 2002-10-09 11:55:52-07:00, jsimmons@maxwell.earthlink.net
  Started to nuke the gloabl currcon variable. I changed over the unimap and font handling functions to use struct vc_data instead. I also seperated out the framebuffer code from the VT code since very soon the framebuffer will be able to function without a VT.


 arch/mips64/kernel/ioctl32.c  |    3
 arch/ppc64/kernel/ioctl32.c   |   67 +++++++++++--------
 arch/sparc64/kernel/ioctl32.c |   34 +++++++---
 arch/x86_64/ia32/ia32_ioctl.c |   35 +++++++---
 drivers/char/consolemap.c     |  142 ++++++++++++++++++++----------------------
 drivers/char/keyboard.c       |    1
 drivers/char/selection.c      |    4 -
 drivers/char/vc_screen.c      |    1
 drivers/char/vt.c             |   65 +++++++++----------
 drivers/char/vt_ioctl.c       |   44 ++++++-------
 drivers/video/dummycon.c      |    1
 drivers/video/mdacon.c        |    3
 drivers/video/newport_con.c   |    1
 drivers/video/promcon.c       |   13 +--
 drivers/video/sticon.c        |    1
 drivers/video/vgacon.c        |    9 +-
 include/linux/consolemap.h    |    6 -
 include/linux/vt_kern.h       |   25 +++----
 include/video/fbcon.h         |    2
 19 files changed, 246 insertions(+), 211 deletions(-)


diff -Nru a/arch/mips64/kernel/ioctl32.c b/arch/mips64/kernel/ioctl32.c
--- a/arch/mips64/kernel/ioctl32.c	Fri Oct 11 18:17:53 2002
+++ b/arch/mips64/kernel/ioctl32.c	Fri Oct 11 18:17:53 2002
@@ -619,6 +619,8 @@
 	IOCTL32_DEFAULT(FIONBIO),
 	IOCTL32_DEFAULT(FIONREAD),

+#ifdef CONFIG_VT
+
 	IOCTL32_DEFAULT(PIO_FONT),
 	IOCTL32_DEFAULT(GIO_FONT),
 	IOCTL32_DEFAULT(KDSIGACCEPT),
@@ -662,6 +664,7 @@
 	IOCTL32_DEFAULT(VT_RESIZEX),
 	IOCTL32_DEFAULT(VT_LOCKSWITCH),
 	IOCTL32_DEFAULT(VT_UNLOCKSWITCH),
+#endif

 #ifdef CONFIG_NET
 	/* Socket level stuff */
diff -Nru a/arch/ppc64/kernel/ioctl32.c b/arch/ppc64/kernel/ioctl32.c
--- a/arch/ppc64/kernel/ioctl32.c	Fri Oct 11 18:17:54 2002
+++ b/arch/ppc64/kernel/ioctl32.c	Fri Oct 11 18:17:54 2002
@@ -1794,6 +1794,8 @@

 static int do_fontx_ioctl(unsigned int fd, int cmd, struct consolefontdesc32 *user_cfd, struct file *file)
 {
+	struct tty_struct *tty = (struct tty_struct *) file->private_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
 	struct consolefontdesc cfdarg;
 	struct console_font_op op;
 	int i, perm;
@@ -1816,7 +1818,7 @@
 		op.height = cfdarg.charheight;
 		op.charcount = cfdarg.charcount;
 		op.data = cfdarg.chardata;
-		return con_font_op(fg_console, &op);
+		return con_font_op(vc, &op);
 	case GIO_FONTX:
 		if (!cfdarg.chardata)
 			return 0;
@@ -1826,7 +1828,7 @@
 		op.height = cfdarg.charheight;
 		op.charcount = cfdarg.charcount;
 		op.data = cfdarg.chardata;
-		i = con_font_op(fg_console, &op);
+		i = con_font_op(vc, &op);
 		if (i)
 			return i;
 		cfdarg.charheight = op.height;
@@ -1849,9 +1851,10 @@

 static int do_kdfontop_ioctl(unsigned int fd, unsigned int cmd, struct console_font_op32 *fontop, struct file *file)
 {
-	struct console_font_op op;
+	struct tty_struct *tty = (struct tty_struct *) file->private_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
 	int perm = vt_check(file), i;
-	struct vt_struct *vt;
+	struct console_font_op op;

 	if (perm < 0) return perm;

@@ -1861,8 +1864,7 @@
 		return -EPERM;
 	op.data = (unsigned char *)A(((struct console_font_op32 *)&op)->data);
 	op.flags |= KD_FONT_FLAG_OLD;
-	vt = (struct vt_struct *)((struct tty_struct *)file->private_data)->driver_data;
-	i = con_font_op(vt->vc_num, &op);
+	i = con_font_op(vc, &op);
 	if (i) return i;
 	((struct console_font_op32 *)&op)->data = (unsigned long)op.data;
 	if (copy_to_user((void *) fontop, &op, sizeof(struct console_font_op32)))
@@ -1870,6 +1872,33 @@
 	return 0;
 }

+struct unimapdesc32 {
+	unsigned short entry_ct;
+	u32 entries;
+};
+
+static int do_unimap_ioctl(unsigned int fd, unsigned int cmd, struct unimapdesc32 *user_ud, struct file *file)
+{
+	struct tty_struct *tty = (struct tty_struct *) file->private_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
+	int perm = vt_check(file);
+	struct unimapdesc32 tmp;
+
+	if (perm < 0) return perm;
+	if (copy_from_user(&tmp, user_ud, sizeof tmp))
+		return -EFAULT;
+	switch (cmd) {
+	case PIO_UNIMAP:
+		if (!perm) return -EPERM;
+		return con_set_unimap(vc, tmp.entry_ct, (struct unipair *)A(tmp.entries));
+	case GIO_UNIMAP:
+		return con_get_unimap(vc, tmp.entry_ct, &(user_ud->entry_ct), (struct unipair *)A(tmp.entries));
+	}
+	return 0;
+}
+#endif /* CONFIG_VT */
+
+#ifdef CONFIG_FB
 struct fb_fix_screeninfo32 {
 	char id[16];			/* identification string eg "TT Builtin" */
 	unsigned int smem_start;	/* Start of frame buffer mem */
@@ -1993,30 +2022,8 @@
 	}
 	return err;
 }
+#endif /* CONFIG_FB */

-struct unimapdesc32 {
-	unsigned short entry_ct;
-	u32 entries;
-};
-
-static int do_unimap_ioctl(unsigned int fd, unsigned int cmd, struct unimapdesc32 *user_ud, struct file *file)
-{
-	struct unimapdesc32 tmp;
-	int perm = vt_check(file);
-
-	if (perm < 0) return perm;
-	if (copy_from_user(&tmp, user_ud, sizeof tmp))
-		return -EFAULT;
-	switch (cmd) {
-	case PIO_UNIMAP:
-		if (!perm) return -EPERM;
-		return con_set_unimap(fg_console, tmp.entry_ct, (struct unipair *)A(tmp.entries));
-	case GIO_UNIMAP:
-		return con_get_unimap(fg_console, tmp.entry_ct, &(user_ud->entry_ct), (struct unipair *)A(tmp.entries));
-	}
-	return 0;
-}
-#endif /* CONFIG_VT */
 static int do_smb_getmountuid(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	mm_segment_t old_fs = get_fs();
@@ -4465,6 +4472,8 @@
 HANDLE_IOCTL(PIO_UNIMAP, do_unimap_ioctl),
 HANDLE_IOCTL(GIO_UNIMAP, do_unimap_ioctl),
 HANDLE_IOCTL(KDFONTOP, do_kdfontop_ioctl),
+#endif
+#ifdef  CONFIG_FB
 HANDLE_IOCTL(FBIOGET_FSCREENINFO, do_fbioget_fscreeninfo_ioctl),
 HANDLE_IOCTL(FBIOGETCMAP, do_fbiogetcmap_ioctl),
 HANDLE_IOCTL(FBIOPUTCMAP, do_fbioputcmap_ioctl),
diff -Nru a/arch/sparc64/kernel/ioctl32.c b/arch/sparc64/kernel/ioctl32.c
--- a/arch/sparc64/kernel/ioctl32.c	Fri Oct 11 18:17:54 2002
+++ b/arch/sparc64/kernel/ioctl32.c	Fri Oct 11 18:17:54 2002
@@ -873,6 +873,7 @@
 	return err ? -EFAULT : 0;
 }

+#ifdef CONFIG_FB
 struct  fbcmap32 {
 	int             index;          /* first element (0 origin) */
 	int             count;
@@ -1112,6 +1113,7 @@
 	if (cmap.transp) kfree(cmap.transp);
 	return err;
 }
+#endif /* CONFIG_FB */

 static int hdio_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -2077,6 +2079,7 @@

 extern int tty_ioctl(struct inode * inode, struct file * file, unsigned int cmd, unsigned long arg);

+#ifdef CONFIG_VT
 static int vt_check(struct file *file)
 {
 	struct tty_struct *tty;
@@ -2109,6 +2112,8 @@

 static int do_fontx_ioctl(unsigned int fd, int cmd, struct consolefontdesc32 *user_cfd, struct file *file)
 {
+	struct tty_struct *tty = (struct tty_struct *)file->private_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
 	struct consolefontdesc cfdarg;
 	struct console_font_op op;
 	int i, perm;
@@ -2131,7 +2136,7 @@
 		op.height = cfdarg.charheight;
 		op.charcount = cfdarg.charcount;
 		op.data = cfdarg.chardata;
-		return con_font_op(fg_console, &op);
+		return con_font_op(vc, &op);
 	case GIO_FONTX:
 		if (!cfdarg.chardata)
 			return 0;
@@ -2141,7 +2146,7 @@
 		op.height = cfdarg.charheight;
 		op.charcount = cfdarg.charcount;
 		op.data = cfdarg.chardata;
-		i = con_font_op(fg_console, &op);
+		i = con_font_op(vc, &op);
 		if (i)
 			return i;
 		cfdarg.charheight = op.height;
@@ -2164,9 +2169,10 @@

 static int do_kdfontop_ioctl(unsigned int fd, unsigned int cmd, struct console_font_op32 *fontop, struct file *file)
 {
-	struct console_font_op op;
+	struct tty_struct *tty = (struct tty_struct *)file->private_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
 	int perm = vt_check(file), i;
-	struct vt_struct *vt;
+	struct console_font_op op;

 	if (perm < 0) return perm;

@@ -2176,8 +2182,7 @@
 		return -EPERM;
 	op.data = (unsigned char *)A(((struct console_font_op32 *)&op)->data);
 	op.flags |= KD_FONT_FLAG_OLD;
-	vt = (struct vt_struct *)((struct tty_struct *)file->private_data)->driver_data;
-	i = con_font_op(vt->vc_num, &op);
+	i = con_font_op(vc, &op);
 	if (i) return i;
 	((struct console_font_op32 *)&op)->data = (unsigned long)op.data;
 	if (copy_to_user((void *) fontop, &op, sizeof(struct console_font_op32)))
@@ -2192,8 +2197,10 @@

 static int do_unimap_ioctl(unsigned int fd, unsigned int cmd, struct unimapdesc32 *user_ud, struct file *file)
 {
-	struct unimapdesc32 tmp;
+	struct tty_struct *tty = (struct tty_struct *)file->private_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
 	int perm = vt_check(file);
+	struct unimapdesc32 tmp;

 	if (perm < 0) return perm;
 	if (copy_from_user(&tmp, user_ud, sizeof tmp))
@@ -2201,12 +2208,13 @@
 	switch (cmd) {
 	case PIO_UNIMAP:
 		if (!perm) return -EPERM;
-		return con_set_unimap(fg_console, tmp.entry_ct, (struct unipair *)A(tmp.entries));
+		return con_set_unimap(vc, tmp.entry_ct, (struct unipair *)A(tmp.entries));
 	case GIO_UNIMAP:
-		return con_get_unimap(fg_console, tmp.entry_ct, &(user_ud->entry_ct), (struct unipair *)A(tmp.entries));
+		return con_get_unimap(vc, tmp.entry_ct, &(user_ud->entry_ct), (struct unipair *)A(tmp.entries));
 	}
 	return 0;
 }
+#endif /* CONFIG_VT */

 static int do_smb_getmountuid(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -4273,6 +4281,7 @@
 COMPATIBLE_IOCTL(TIOCSSERIAL)
 COMPATIBLE_IOCTL(TIOCSERGETLSR)
 COMPATIBLE_IOCTL(TIOCSLTC)
+#ifdef CONFIG_FB
 /* Big F */
 COMPATIBLE_IOCTL(FBIOGTYPE)
 COMPATIBLE_IOCTL(FBIOSATTR)
@@ -4293,6 +4302,7 @@
 COMPATIBLE_IOCTL(FBIOPUT_CURSORSTATE)
 COMPATIBLE_IOCTL(FBIOGET_CON2FBMAP)
 COMPATIBLE_IOCTL(FBIOPUT_CON2FBMAP)
+#endif
 /* Little f */
 COMPATIBLE_IOCTL(FIOCLEX)
 COMPATIBLE_IOCTL(FIONCLEX)
@@ -4423,6 +4433,7 @@
 COMPATIBLE_IOCTL(TUNSETIFF)
 COMPATIBLE_IOCTL(TUNSETPERSIST)
 COMPATIBLE_IOCTL(TUNSETOWNER)
+#ifdef CONFIG_VT
 /* Big V */
 COMPATIBLE_IOCTL(VT_SETMODE)
 COMPATIBLE_IOCTL(VT_GETMODE)
@@ -4436,6 +4447,7 @@
 COMPATIBLE_IOCTL(VT_RESIZEX)
 COMPATIBLE_IOCTL(VT_LOCKSWITCH)
 COMPATIBLE_IOCTL(VT_UNLOCKSWITCH)
+#endif
 /* Little v */
 COMPATIBLE_IOCTL(VUIDSFORMAT)
 COMPATIBLE_IOCTL(VUIDGFORMAT)
@@ -5007,12 +5019,14 @@
 HANDLE_IOCTL(0x1260, broken_blkgetsize)
 HANDLE_IOCTL(BLKSECTGET, w_long)
 HANDLE_IOCTL(BLKPG, blkpg_ioctl_trans)
+#ifdef CONFIG_FB
 HANDLE_IOCTL(FBIOPUTCMAP32, fbiogetputcmap)
 HANDLE_IOCTL(FBIOGETCMAP32, fbiogetputcmap)
 HANDLE_IOCTL(FBIOSCURSOR32, fbiogscursor)
 HANDLE_IOCTL(FBIOGET_FSCREENINFO, fb_ioctl_trans)
 HANDLE_IOCTL(FBIOGETCMAP, fb_ioctl_trans)
 HANDLE_IOCTL(FBIOPUTCMAP, fb_ioctl_trans)
+#endif
 HANDLE_IOCTL(HDIO_GET_UNMASKINTR, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_DMA, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_32BIT, hdio_ioctl_trans)
@@ -5048,11 +5062,13 @@
 HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
+#ifdef CONFIG_VT
 HANDLE_IOCTL(PIO_FONTX, do_fontx_ioctl)
 HANDLE_IOCTL(GIO_FONTX, do_fontx_ioctl)
 HANDLE_IOCTL(PIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(GIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(KDFONTOP, do_kdfontop_ioctl)
+#endif
 HANDLE_IOCTL(EXT2_IOC32_GETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)
diff -Nru a/arch/x86_64/ia32/ia32_ioctl.c b/arch/x86_64/ia32/ia32_ioctl.c
--- a/arch/x86_64/ia32/ia32_ioctl.c	Fri Oct 11 18:17:53 2002
+++ b/arch/x86_64/ia32/ia32_ioctl.c	Fri Oct 11 18:17:53 2002
@@ -790,6 +790,7 @@
 	return err ? -EFAULT : 0;
 }

+#ifdef CONFIG_FB
 struct  fbcmap32 {
 	int             index;          /* first element (0 origin) */
 	int             count;
@@ -930,6 +931,7 @@
 	if (cmap.transp) kfree(cmap.transp);
 	return err;
 }
+#endif /* CONFIG_FB */

 static int hdio_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -1633,6 +1635,8 @@

 extern int tty_ioctl(struct inode * inode, struct file * file, unsigned int cmd, unsigned long arg);

+#ifdef CONFIG_VT
+
 static int vt_check(struct file *file)
 {
 	struct tty_struct *tty;
@@ -1665,6 +1669,8 @@

 static int do_fontx_ioctl(unsigned int fd, int cmd, struct consolefontdesc32 *user_cfd, struct file *file)
 {
+	struct tty_struct *tty = (struct tty_struct *)file->private_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
 	struct consolefontdesc cfdarg;
 	struct console_font_op op;
 	int i, perm;
@@ -1687,7 +1693,7 @@
 		op.height = cfdarg.charheight;
 		op.charcount = cfdarg.charcount;
 		op.data = cfdarg.chardata;
-		return con_font_op(fg_console, &op);
+		return con_font_op(vc, &op);
 	case GIO_FONTX:
 		if (!cfdarg.chardata)
 			return 0;
@@ -1697,7 +1703,7 @@
 		op.height = cfdarg.charheight;
 		op.charcount = cfdarg.charcount;
 		op.data = cfdarg.chardata;
-		i = con_font_op(fg_console, &op);
+		i = con_font_op(vc, &op);
 		if (i)
 			return i;
 		cfdarg.charheight = op.height;
@@ -1720,9 +1726,10 @@

 static int do_kdfontop_ioctl(unsigned int fd, unsigned int cmd, struct console_font_op32 *fontop, struct file *file)
 {
-	struct console_font_op op;
+	struct tty_struct *tty = (struct tty_struct *)file->private_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
 	int perm = vt_check(file), i;
-	struct vt_struct *vt;
+	struct console_font_op op;

 	if (perm < 0) return perm;

@@ -1732,8 +1739,7 @@
 		return -EPERM;
 	op.data = (unsigned char *)A(((struct console_font_op32 *)&op)->data);
 	op.flags |= KD_FONT_FLAG_OLD;
-	vt = (struct vt_struct *)((struct tty_struct *)file->private_data)->driver_data;
-	i = con_font_op(vt->vc_num, &op);
+	i = con_font_op(vc, &op);
 	if (i) return i;
 	((struct console_font_op32 *)&op)->data = (unsigned long)op.data;
 	if (copy_to_user((void *) fontop, &op, sizeof(struct console_font_op32)))
@@ -1748,8 +1754,10 @@

 static int do_unimap_ioctl(unsigned int fd, unsigned int cmd, struct unimapdesc32 *user_ud, struct file *file)
 {
-	struct unimapdesc32 tmp;
+	struct tty_struct *tty = (struct tty_struct *)file->private_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
 	int perm = vt_check(file);
+	struct unimapdesc32 tmp;

 	if (perm < 0) return perm;
 	if (copy_from_user(&tmp, user_ud, sizeof tmp))
@@ -1757,12 +1765,13 @@
 	switch (cmd) {
 	case PIO_UNIMAP:
 		if (!perm) return -EPERM;
-		return con_set_unimap(fg_console, tmp.entry_ct, (struct unipair *)A(tmp.entries));
+		return con_set_unimap(vc, tmp.entry_ct, (struct unipair *)A(tmp.entries));
 	case GIO_UNIMAP:
-		return con_get_unimap(fg_console, tmp.entry_ct, &(user_ud->entry_ct), (struct unipair *)A(tmp.entries));
+		return con_get_unimap(vc, tmp.entry_ct, &(user_ud->entry_ct), (struct unipair *)A(tmp.entries));
 	}
 	return 0;
 }
+#endif /* CONFIG_VT */

 static int do_smb_getmountuid(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -3172,6 +3181,7 @@
 COMPATIBLE_IOCTL(TIOCGPTN)
 COMPATIBLE_IOCTL(TIOCSPTLCK)
 COMPATIBLE_IOCTL(TIOCSERGETLSR)
+#ifdef CONFIG_FB
 COMPATIBLE_IOCTL(FBIOGET_VSCREENINFO)
 COMPATIBLE_IOCTL(FBIOPUT_VSCREENINFO)
 COMPATIBLE_IOCTL(FBIOPAN_DISPLAY)
@@ -3182,6 +3192,7 @@
 COMPATIBLE_IOCTL(FBIOPUT_CURSORSTATE)
 COMPATIBLE_IOCTL(FBIOGET_CON2FBMAP)
 COMPATIBLE_IOCTL(FBIOPUT_CON2FBMAP)
+#endif
 /* Little f */
 COMPATIBLE_IOCTL(FIOCLEX)
 COMPATIBLE_IOCTL(FIONCLEX)
@@ -3291,6 +3302,7 @@
 COMPATIBLE_IOCTL(SCSI_IOCTL_TAGGED_DISABLE)
 COMPATIBLE_IOCTL(SCSI_IOCTL_GET_BUS_NUMBER)
 COMPATIBLE_IOCTL(SCSI_IOCTL_SEND_COMMAND)
+#ifdef CONFIG_VT
 /* Big V */
 COMPATIBLE_IOCTL(VT_SETMODE)
 COMPATIBLE_IOCTL(VT_GETMODE)
@@ -3304,6 +3316,7 @@
 COMPATIBLE_IOCTL(VT_RESIZEX)
 COMPATIBLE_IOCTL(VT_LOCKSWITCH)
 COMPATIBLE_IOCTL(VT_UNLOCKSWITCH)
+#endif
 /* Little v, the video4linux ioctls */
 COMPATIBLE_IOCTL(VIDIOCGCAP)
 COMPATIBLE_IOCTL(VIDIOCGCHAN)
@@ -3747,8 +3760,10 @@
 HANDLE_IOCTL(0x1260, broken_blkgetsize)
 HANDLE_IOCTL(BLKSECTGET, w_long)
 HANDLE_IOCTL(BLKPG, blkpg_ioctl_trans)
+#ifdef CONFIG_FB
 HANDLE_IOCTL(FBIOGETCMAP, fb_ioctl_trans)
 HANDLE_IOCTL(FBIOPUTCMAP, fb_ioctl_trans)
+#endif
 HANDLE_IOCTL(HDIO_GET_UNMASKINTR, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_DMA, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_32BIT, hdio_ioctl_trans)
@@ -3779,11 +3794,13 @@
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
 HANDLE_IOCTL(LOOP_SET_STATUS, loop_status)
 HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)
+#ifdef CONFIG_VT
 HANDLE_IOCTL(PIO_FONTX, do_fontx_ioctl)
 HANDLE_IOCTL(GIO_FONTX, do_fontx_ioctl)
 HANDLE_IOCTL(PIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(GIO_UNIMAP, do_unimap_ioctl)
 HANDLE_IOCTL(KDFONTOP, do_kdfontop_ioctl)
+#endif
 HANDLE_IOCTL(EXT2_IOC32_GETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)
diff -Nru a/drivers/char/consolemap.c b/drivers/char/consolemap.c
--- a/drivers/char/consolemap.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/char/consolemap.c	Fri Oct 11 18:17:53 2002
@@ -19,7 +19,6 @@
 #include <linux/tty.h>
 #include <asm/uaccess.h>
 #include <linux/consolemap.h>
-#include <linux/console_struct.h>
 #include <linux/vt_kern.h>

 static unsigned short translations[][256] = {
@@ -182,7 +181,7 @@

 static struct uni_pagedir *dflt;

-static void set_inverse_transl(struct vc_data *conp, struct uni_pagedir *p, int i)
+static void set_inverse_transl(struct vc_data *vc, struct uni_pagedir *p, int i)
 {
 	int j, glyph;
 	unsigned short *t = translations[i];
@@ -199,7 +198,7 @@
 	memset(q, 0, MAX_GLYPH);

 	for (j = 0; j < E_TABSZ; j++) {
-		glyph = conv_uni_to_pc(conp, t[j]);
+		glyph = conv_uni_to_pc(vc, t[j]);
 		if (glyph >= 0 && glyph < MAX_GLYPH && q[glyph] < 32) {
 			/* prefer '-' above SHY etc. */
 		  	q[glyph] = j;
@@ -207,10 +206,10 @@
 	}
 }

-unsigned short *set_translate(int m,int currcons)
+void set_translate(struct vc_data *vc, int m)
 {
-	inv_translate[currcons] = m;
-	return translations[m];
+	inv_translate[vc->vc_num] = m;
+	vc->vc_translate = translations[m];
 }

 /*
@@ -220,29 +219,32 @@
  *    was active, or using Unicode.
  * Still, it is now possible to a certain extent to cut and paste non-ASCII.
  */
-unsigned char inverse_translate(struct vc_data *conp, int glyph)
+unsigned char inverse_translate(struct vc_data *vc, int glyph)
 {
 	struct uni_pagedir *p;
 	if (glyph < 0 || glyph >= MAX_GLYPH)
 		return 0;
-	else if (!(p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc) ||
-		 !p->inverse_translations[inv_translate[conp->vc_num]])
+	else if (!(p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc) ||
+		 !p->inverse_translations[inv_translate[vc->vc_num]])
 		return glyph;
 	else
-		return p->inverse_translations[inv_translate[conp->vc_num]][glyph];
+		return p->inverse_translations[inv_translate[vc->vc_num]][glyph];
 }

 static void update_user_maps(void)
 {
-	int i;
 	struct uni_pagedir *p, *q = NULL;
+	struct vc_data *vc;
+	int i;

 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
-		if (!vc_cons_allocated(i))
+		vc = vc_cons[i].d;
+
+		if (!vc)
 			continue;
-		p = (struct uni_pagedir *)*vc_cons[i].d->vc_uni_pagedir_loc;
+		p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 		if (p && p != q) {
-			set_inverse_transl(vc_cons[i].d, p, USER_MAP);
+			set_inverse_transl(vc, p, USER_MAP);
 			q = p;
 		}
 	}
@@ -256,7 +258,7 @@
  * 0xf000-0xf0ff "transparent" Unicodes) whereas the "new" variants set
  * Unicodes explicitly.
  */
-int con_set_trans_old(unsigned char * arg)
+int con_set_trans_old(struct vc_data *vc, unsigned char * arg)
 {
 	int i;
 	unsigned short *p = translations[USER_MAP];
@@ -275,7 +277,7 @@
 	return 0;
 }

-int con_get_trans_old(unsigned char * arg)
+int con_get_trans_old(struct vc_data *vc, unsigned char * arg)
 {
 	int i, ch;
 	unsigned short *p = translations[USER_MAP];
@@ -286,13 +288,13 @@

 	for (i=0; i<E_TABSZ ; i++)
 	  {
-	    ch = conv_uni_to_pc(vc_cons[fg_console].d, p[i]);
+	    ch = conv_uni_to_pc(vc, p[i]);
 	    __put_user((ch & ~0xff) ? 0 : ch, arg+i);
 	  }
 	return 0;
 }

-int con_set_trans_new(ushort * arg)
+int con_set_trans_new(struct vc_data *vc, ushort * arg)
 {
 	int i;
 	unsigned short *p = translations[USER_MAP];
@@ -312,7 +314,7 @@
 	return 0;
 }

-int con_get_trans_new(ushort * arg)
+int con_get_trans_new(struct vc_data *vc, ushort * arg)
 {
 	int i;
 	unsigned short *p = translations[USER_MAP];
@@ -363,28 +365,29 @@
 		}
 }

-void con_free_unimap(int con)
+void con_free_unimap(struct vc_data *vc)
 {
 	struct uni_pagedir *p;
-	struct vc_data *conp = vc_cons[con].d;

-	p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
+	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 	if (!p) return;
-	*conp->vc_uni_pagedir_loc = 0;
+	*vc->vc_uni_pagedir_loc = 0;
 	if (--p->refcount) return;
 	con_release_unimap(p);
 	kfree(p);
 }

-static int con_unify_unimap(struct vc_data *conp, struct uni_pagedir *p)
+static int con_unify_unimap(struct vc_data *vc, struct uni_pagedir *p)
 {
 	int i, j, k;
 	struct uni_pagedir *q;

 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
-		if (!vc_cons_allocated(i))
+		struct vc_data *tmp = vc_cons[i].d;
+
+		if (!tmp)
 			continue;
-		q = (struct uni_pagedir *)*vc_cons[i].d->vc_uni_pagedir_loc;
+		q = (struct uni_pagedir *)*tmp->vc_uni_pagedir_loc;
 		if (!q || q == p || q->sum != p->sum)
 			continue;
 		for (j = 0; j < 32; j++) {
@@ -407,7 +410,7 @@
 		}
 		if (j == 32) {
 			q->refcount++;
-			*conp->vc_uni_pagedir_loc = (unsigned long)q;
+			*vc->vc_uni_pagedir_loc = (unsigned long)q;
 			con_release_unimap(p);
 			kfree(p);
 			return 1;
@@ -443,12 +446,11 @@
 }

 /* ui is a leftover from using a hashtable, but might be used again */
-int con_clear_unimap(int con, struct unimapinit *ui)
+int con_clear_unimap(struct vc_data *vc, struct unimapinit *ui)
 {
 	struct uni_pagedir *p, *q;
-	struct vc_data *conp = vc_cons[con].d;

-	p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
+	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 	if (p && p->readonly) return -EIO;
 	if (!p || --p->refcount) {
 		q = (struct uni_pagedir *)kmalloc(sizeof(*p), GFP_KERNEL);
@@ -458,7 +460,7 @@
 		}
 		memset(q, 0, sizeof(*q));
 		q->refcount=1;
-		*conp->vc_uni_pagedir_loc = (unsigned long)q;
+		*vc->vc_uni_pagedir_loc = (unsigned long)q;
 	} else {
 		if (p == dflt) dflt = NULL;
 		p->refcount++;
@@ -469,13 +471,12 @@
 }

 int
-con_set_unimap(int con, ushort ct, struct unipair *list)
+con_set_unimap(struct vc_data *vc, ushort ct, struct unipair *list)
 {
-	int err = 0, err1, i;
 	struct uni_pagedir *p, *q;
-	struct vc_data *conp = vc_cons[con].d;
-
-	p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
+	int err = 0, err1, i;
+
+	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 	if (p->readonly) return -EIO;

 	if (!ct) return 0;
@@ -484,10 +485,10 @@
 		int j, k;
 		u16 **p1, *p2, l;

-		err1 = con_clear_unimap(con, NULL);
+		err1 = con_clear_unimap(vc, NULL);
 		if (err1) return err1;

-		q = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
+		q = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 		for (i = 0, l = 0; i < 32; i++)
 		if ((p1 = p->uni_pgdir[i]))
 			for (j = 0; j < 32; j++)
@@ -497,7 +498,7 @@
 					err1 = con_insert_unipair(q, l, p2[k]);
 					if (err1) {
 						p->refcount++;
-						*conp->vc_uni_pagedir_loc = (unsigned long)p;
+						*vc->vc_uni_pagedir_loc = (unsigned long)p;
 						con_release_unimap(q);
 						kfree(q);
 						return err1;
@@ -516,12 +517,11 @@
 			list++;
 	}

-	if (con_unify_unimap(conp, p))
+	if (con_unify_unimap(vc, p))
 		return err;

 	for (i = 0; i <= 3; i++)
-		set_inverse_transl(conp, p, i); /* Update all inverse translations */
-
+		set_inverse_transl(vc, p, i); /* Update all inverse translations */
 	return err;
 }

@@ -531,19 +531,18 @@
    PIO_FONTRESET ioctl is called. */

 int
-con_set_default_unimap(int con)
+con_set_default_unimap(struct vc_data *vc)
 {
 	int i, j, err = 0, err1;
 	u16 *q;
 	struct uni_pagedir *p;
-	struct vc_data *conp = vc_cons[con].d;

 	if (dflt) {
-		p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
+		p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 		if (p == dflt)
 			return 0;
 		dflt->refcount++;
-		*conp->vc_uni_pagedir_loc = (unsigned long)dflt;
+		*vc->vc_uni_pagedir_loc = (unsigned long)dflt;
 		if (p && --p->refcount) {
 			con_release_unimap(p);
 			kfree(p);
@@ -552,11 +551,10 @@
 	}

 	/* The default font is always 256 characters */
-
-	err = con_clear_unimap(con,NULL);
+	err = con_clear_unimap(vc, NULL);
 	if (err) return err;

-	p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
+	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 	q = dfont_unitable;

 	for (i = 0; i < 256; i++)
@@ -566,46 +564,43 @@
 				err = err1;
 		}

-	if (con_unify_unimap(conp, p)) {
-		dflt = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
+	if (con_unify_unimap(vc, p)) {
+		dflt = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 		return err;
 	}

 	for (i = 0; i <= 3; i++)
-		set_inverse_transl(conp, p, i);	/* Update all inverse translations */
+		set_inverse_transl(vc, p, i);	/* Update all inverse translations */
 	dflt = p;
 	return err;
 }

 int
-con_copy_unimap(int dstcon, int srccon)
+con_copy_unimap(struct vc_data *dst, struct vc_data *src)
 {
-	struct vc_data *sconp = vc_cons[srccon].d;
-	struct vc_data *dconp = vc_cons[dstcon].d;
 	struct uni_pagedir *q;

-	if (!vc_cons_allocated(srccon) || !*sconp->vc_uni_pagedir_loc)
+	if (!src || !*src->vc_uni_pagedir_loc)
 		return -EINVAL;
-	if (*dconp->vc_uni_pagedir_loc == *sconp->vc_uni_pagedir_loc)
+	if (*dst->vc_uni_pagedir_loc == *src->vc_uni_pagedir_loc)
 		return 0;
-	con_free_unimap(dstcon);
-	q = (struct uni_pagedir *)*sconp->vc_uni_pagedir_loc;
+	con_free_unimap(dst);
+	q = (struct uni_pagedir *)*src->vc_uni_pagedir_loc;
 	q->refcount++;
-	*dconp->vc_uni_pagedir_loc = (long)q;
+	*dst->vc_uni_pagedir_loc = (long)q;
 	return 0;
 }

 int
-con_get_unimap(int con, ushort ct, ushort *uct, struct unipair *list)
+con_get_unimap(struct vc_data *vc, ushort ct, ushort *uct, struct unipair *list)
 {
 	int i, j, k, ect;
 	u16 **p1, *p2;
 	struct uni_pagedir *p;
-	struct vc_data *conp = vc_cons[con].d;

 	ect = 0;
-	if (*conp->vc_uni_pagedir_loc) {
-		p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
+	if (*vc->vc_uni_pagedir_loc) {
+		p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 		for (i = 0; i < 32; i++)
 		if ((p1 = p->uni_pgdir[i]))
 			for (j = 0; j < 32; j++)
@@ -625,16 +620,16 @@
 	return ((ect <= ct) ? 0 : -ENOMEM);
 }

-void con_protect_unimap(int con, int rdonly)
+void con_protect_unimap(struct vc_data *vc, int rdonly)
 {
 	struct uni_pagedir *p = (struct uni_pagedir *)
-		*vc_cons[con].d->vc_uni_pagedir_loc;
+		*vc->vc_uni_pagedir_loc;

 	if (p) p->readonly = rdonly;
 }

 int
-conv_uni_to_pc(struct vc_data *conp, long ucs)
+conv_uni_to_pc(struct vc_data *vc, long ucs)
 {
 	int h;
 	u16 **p1, *p2;
@@ -655,10 +650,10 @@
 	else if ((ucs & ~UNI_DIRECT_MASK) == UNI_DIRECT_BASE)
 		return ucs & UNI_DIRECT_MASK;

-	if (!*conp->vc_uni_pagedir_loc)
+	if (!*vc->vc_uni_pagedir_loc)
 		return -3;

-	p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc;
+	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 	if ((p1 = p->uni_pgdir[ucs >> 11]) &&
 	    (p2 = p1[(ucs >> 6) & 0x1f]) &&
 	    (h = p2[ucs & 0x3f]) < MAX_GLYPH)
@@ -677,7 +672,10 @@
 {
 	int i;

-	for (i = 0; i < MAX_NR_CONSOLES; i++)
-		if (vc_cons_allocated(i) && !*vc_cons[i].d->vc_uni_pagedir_loc)
-			con_set_default_unimap(i);
+	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		struct vc_data *vc = vc_cons[i].d;
+
+		if (vc && !*vc->vc_uni_pagedir_loc)
+			con_set_default_unimap(vc);
+	}
 }
diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/char/keyboard.c	Fri Oct 11 18:17:53 2002
@@ -35,7 +35,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>

-#include <linux/console_struct.h>
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
 #include <linux/vt_kern.h>
diff -Nru a/drivers/char/selection.c b/drivers/char/selection.c
--- a/drivers/char/selection.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/char/selection.c	Fri Oct 11 18:17:53 2002
@@ -22,7 +22,6 @@

 #include <linux/vt_kern.h>
 #include <linux/consolemap.h>
-#include <linux/console_struct.h>
 #include <linux/selection.h>

 #ifndef MIN
@@ -288,7 +287,8 @@
  */
 int paste_selection(struct tty_struct *tty)
 {
-	struct vt_struct *vt = (struct vt_struct *) tty->driver_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
+	struct vt_struct *vt = vt_cons[vc->vc_num];
 	int	pasted = 0, count;
 	DECLARE_WAITQUEUE(wait, current);

diff -Nru a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/char/vc_screen.c	Fri Oct 11 18:17:53 2002
@@ -32,7 +32,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/vt_kern.h>
-#include <linux/console_struct.h>
 #include <linux/selection.h>
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/char/vt.c	Fri Oct 11 18:17:53 2002
@@ -90,7 +90,6 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
-#include <linux/console_struct.h>
 #include <linux/kbd_kern.h>
 #include <linux/consolemap.h>
 #include <linux/timer.h>
@@ -669,7 +668,7 @@
 	    vt_cons[currcons] = (struct vt_struct *)(p+sizeof(struct vc_data));
 	    visual_init(currcons, 1);
 	    if (!*vc_cons[currcons].d->vc_uni_pagedir_loc)
-		con_set_default_unimap(currcons);
+		con_set_default_unimap(vc_cons[currcons].d);
 	    q = (long)kmalloc(screenbuf_size, GFP_KERNEL);
 	    if (!q) {
 		kfree((char *) p);
@@ -1073,9 +1072,8 @@
 				  * control chars if defined, don't set
 				  * bit 8 on output.
 				  */
-				translate = set_translate(charset == 0
-						? G0_charset
-						: G1_charset,currcons);
+				set_translate(vc_cons[currcons].d, charset == 0 ?
+						G0_charset : G1_charset);
 				disp_ctrl = 0;
 				toggle_meta = 0;
 				break;
@@ -1083,7 +1081,7 @@
 				  * Select first alternate font, lets
 				  * chars < 32 be displayed as ROM chars.
 				  */
-				translate = set_translate(IBMPC_MAP,currcons);
+				set_translate(vc_cons[currcons].d, IBMPC_MAP);
 				disp_ctrl = 1;
 				toggle_meta = 0;
 				break;
@@ -1091,7 +1089,7 @@
 				  * Select second alternate font, toggle
 				  * high bit before displaying as ROM char.
 				  */
-				translate = set_translate(IBMPC_MAP,currcons);
+				set_translate(vc_cons[currcons].d, IBMPC_MAP);
 				disp_ctrl = 1;
 				toggle_meta = 1;
 				break;
@@ -1373,7 +1371,7 @@
 	color		= s_color;
 	G0_charset	= saved_G0;
 	G1_charset	= saved_G1;
-	translate	= set_translate(charset ? G1_charset : G0_charset,currcons);
+	set_translate(vc_cons[currcons].d, charset ? G1_charset : G0_charset);
 	update_attr(currcons);
 	need_wrap = 0;
 }
@@ -1389,7 +1387,7 @@
 	bottom		= video_num_lines;
 	vc_state	= ESnormal;
 	ques		= 0;
-	translate	= set_translate(LAT1_MAP,currcons);
+	set_translate(vc_cons[currcons].d, LAT1_MAP);
 	G0_charset	= LAT1_MAP;
 	G1_charset	= GRAF_MAP;
 	charset		= 0;
@@ -1474,12 +1472,12 @@
 		return;
 	case 14:
 		charset = 1;
-		translate = set_translate(G1_charset,currcons);
+		set_translate(vc_cons[currcons].d, G1_charset);
 		disp_ctrl = 1;
 		return;
 	case 15:
 		charset = 0;
-		translate = set_translate(G0_charset,currcons);
+		set_translate(vc_cons[currcons].d, G0_charset);
 		disp_ctrl = 0;
 		return;
 	case 24: case 26:
@@ -1786,7 +1784,7 @@
 		else if (c == 'K')
 			G0_charset = USER_MAP;
 		if (charset == 0)
-			translate = set_translate(G0_charset,currcons);
+			set_translate(vc_cons[currcons].d, G0_charset);
 		vc_state = ESnormal;
 		return;
 	case ESsetG1:
@@ -1799,7 +1797,7 @@
 		else if (c == 'K')
 			G1_charset = USER_MAP;
 		if (charset == 1)
-			translate = set_translate(G1_charset,currcons);
+			set_translate(vc_cons[currcons].d, G1_charset);
 		vc_state = ESnormal;
 		return;
 	default:
@@ -1834,9 +1832,9 @@
 #endif

 	int c, tc, ok, n = 0, draw_x = -1;
-	unsigned int currcons;
+	unsigned int currcons = minor(tty->device) - tty->driver.minor_start;
 	unsigned long draw_from = 0, draw_to = 0;
-	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
+	struct vc_data *vc = (struct vc_data *)tty->driver_data;
 	u16 himask, charmask;
 	const unsigned char *orig_buf = NULL;
 	int orig_count;
@@ -1844,13 +1842,12 @@
 	if (in_interrupt())
 		return count;

-	currcons = vt->vc_num;
-	if (!vc_cons_allocated(currcons)) {
+	if (!vc) {
 	    /* could this happen? */
 	    static int error = 0;
 	    if (!error) {
 		error = 1;
-		printk("con_write: tty %d not allocated\n", currcons+1);
+		printk("con_write: tty %d not allocated\n", currcons + 1);
 	    }
 	    return 0;
 	}
@@ -2308,7 +2305,8 @@

 static void con_unthrottle(struct tty_struct *tty)
 {
-	struct vt_struct *vt = (struct vt_struct *) tty->driver_data;
+	struct vc_data *vc = (struct vc_data *) tty->driver_data;
+	struct vt_struct *vt = vt_cons[vc->vc_num];

 	wake_up_interruptible(&vt->paste_wait);
 }
@@ -2345,7 +2343,7 @@

 static void con_flush_chars(struct tty_struct *tty)
 {
-	struct vt_struct *vt;
+	struct vc_data *vc;

 	if (in_interrupt())	/* from flush_to_ldisc */
 		return;
@@ -2354,9 +2352,9 @@

 	/* if we race with con_close(), vt may be null */
 	acquire_console_sem();
-	vt = (struct vt_struct *)tty->driver_data;
-	if (vt)
-		set_cursor(vt->vc_num);
+	vc = (struct vc_data *)tty->driver_data;
+	if (vc)
+		set_cursor(vc->vc_num);
 	release_console_sem();
 }

@@ -2375,7 +2373,7 @@
 		return i;

 	vt_cons[currcons]->vc_num = currcons;
-	tty->driver_data = vt_cons[currcons];
+	tty->driver_data = vc_cons[currcons].d;
 	vc_cons[currcons].d->vc_tty = tty;

 	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
@@ -2389,15 +2387,15 @@

 static void con_close(struct tty_struct *tty, struct file * filp)
 {
-	struct vt_struct *vt;
+	struct vc_data *vc;

 	if (!tty)
 		return;
 	if (tty->count != 1) return;
 	vcs_make_devfs (minor(tty->device) - tty->driver.minor_start, 1);
-	vt = (struct vt_struct*)tty->driver_data;
-	if (vt)
-		vc_cons[vt->vc_num].d->vc_tty = NULL;
+	vc = (struct vc_data *)tty->driver_data;
+	if (vc)
+		vc_cons[vc->vc_num].d->vc_tty = NULL;
 	tty->driver_data = 0;
 }

@@ -2845,12 +2843,13 @@

 #define max_font_size 65536

-int con_font_op(int currcons, struct console_font_op *op)
+int con_font_op(struct vc_data *vc, struct console_font_op *op)
 {
-	int rc = -EINVAL;
+	struct console_font_op old_op;
 	int size = max_font_size, set;
+	int currcons = vc->vc_num;
+	int rc = -EINVAL;
 	u8 *temp = NULL;
-	struct console_font_op old_op;

 	if (vt_cons[currcons]->vc_mode != KD_TEXT)
 		goto quit;
@@ -2891,7 +2890,7 @@
 	} else if (op->op == KD_FONT_OP_GET)
 		set = 0;
 	else
-		return sw->con_font_op(vc_cons[currcons].d, op);
+		return sw->con_font_op(vc, op);
 	if (op->data) {
 		temp = kmalloc(size, GFP_KERNEL);
 		if (!temp)
@@ -2904,7 +2903,7 @@
 	}

 	acquire_console_sem();
-	rc = sw->con_font_op(vc_cons[currcons].d, op);
+	rc = sw->con_font_op(vc, op);
 	release_console_sem();

 	op->data = old_op.data;
diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
--- a/drivers/char/vt_ioctl.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/char/vt_ioctl.c	Fri Oct 11 18:17:53 2002
@@ -279,7 +279,7 @@
 }

 static inline int
-do_fontx_ioctl(int cmd, struct consolefontdesc *user_cfd, int perm)
+do_fontx_ioctl(struct vc_data *vc, int cmd, struct consolefontdesc *user_cfd, int perm)
 {
 	struct consolefontdesc cfdarg;
 	struct console_font_op op;
@@ -298,7 +298,7 @@
 		op.height = cfdarg.charheight;
 		op.charcount = cfdarg.charcount;
 		op.data = cfdarg.chardata;
-		return con_font_op(fg_console, &op);
+		return con_font_op(vc, &op);
 	case GIO_FONTX: {
 		op.op = KD_FONT_OP_GET;
 		op.flags = KD_FONT_FLAG_OLD;
@@ -306,7 +306,7 @@
 		op.height = cfdarg.charheight;
 		op.charcount = cfdarg.charcount;
 		op.data = cfdarg.chardata;
-		i = con_font_op(fg_console, &op);
+		i = con_font_op(vc, &op);
 		if (i)
 			return i;
 		cfdarg.charheight = op.height;
@@ -320,7 +320,7 @@
 }

 static inline int
-do_unimap_ioctl(int cmd, struct unimapdesc *user_ud,int perm)
+do_unimap_ioctl(struct vc_data *vc, int cmd, struct unimapdesc *user_ud,int perm)
 {
 	struct unimapdesc tmp;
 	int i = 0;
@@ -336,9 +336,9 @@
 	case PIO_UNIMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_unimap(fg_console, tmp.entry_ct, tmp.entries);
+		return con_set_unimap(vc, tmp.entry_ct, tmp.entries);
 	case GIO_UNIMAP:
-		return con_get_unimap(fg_console, tmp.entry_ct, &(user_ud->entry_ct), tmp.entries);
+		return con_get_unimap(vc, tmp.entry_ct, &(user_ud->entry_ct), tmp.entries);
 	}
 	return 0;
 }
@@ -350,13 +350,13 @@
 int vt_ioctl(struct tty_struct *tty, struct file * file,
 	     unsigned int cmd, unsigned long arg)
 {
-	int i, perm;
+	struct vc_data *vc = (struct vc_data *)tty->driver_data;
+	struct kbd_struct * kbd;
 	unsigned int console;
 	unsigned char ucval;
-	struct kbd_struct * kbd;
-	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
+	int i, perm;

-	console = vt->vc_num;
+	console = vc->vc_num;

 	if (!vc_cons_allocated(console)) 	/* impossible? */
 		return -ENOIOCTLCMD;
@@ -869,7 +869,7 @@
 		op.height = 0;
 		op.charcount = 256;
 		op.data = (char *) arg;
-		return con_font_op(fg_console, &op);
+		return con_font_op(vc, &op);
 	}

 	case GIO_FONT: {
@@ -880,7 +880,7 @@
 		op.height = 32;
 		op.charcount = 256;
 		op.data = (char *) arg;
-		return con_font_op(fg_console, &op);
+		return con_font_op(vc, &op);
 	}

 	case PIO_CMAP:
@@ -893,7 +893,7 @@

 	case PIO_FONTX:
 	case GIO_FONTX:
-		return do_fontx_ioctl(cmd, (struct consolefontdesc *)arg, perm);
+		return do_fontx_ioctl(vc, cmd, (struct consolefontdesc *)arg, perm);

 	case PIO_FONTRESET:
 	{
@@ -909,9 +909,9 @@
 		struct console_font_op op;
 		op.op = KD_FONT_OP_SET_DEFAULT;
 		op.data = NULL;
-		i = con_font_op(fg_console, &op);
+		i = con_font_op(vc, &op);
 		if (i) return i;
-		con_set_default_unimap(fg_console);
+		con_set_default_unimap(vc);
 		return 0;
 		}
 #endif
@@ -923,7 +923,7 @@
 			return -EFAULT;
 		if (!perm && op.op != KD_FONT_OP_GET)
 			return -EPERM;
-		i = con_font_op(console, &op);
+		i = con_font_op(vc, &op);
 		if (i) return i;
 		if (copy_to_user((void *) arg, &op, sizeof(op)))
 			return -EFAULT;
@@ -933,18 +933,18 @@
 	case PIO_SCRNMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_trans_old((unsigned char *)arg);
+		return con_set_trans_old(vc, (unsigned char *)arg);

 	case GIO_SCRNMAP:
-		return con_get_trans_old((unsigned char *)arg);
+		return con_get_trans_old(vc, (unsigned char *)arg);

 	case PIO_UNISCRNMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_trans_new((unsigned short *)arg);
+		return con_set_trans_new(vc, (unsigned short *)arg);

 	case GIO_UNISCRNMAP:
-		return con_get_trans_new((unsigned short *)arg);
+		return con_get_trans_new(vc, (unsigned short *)arg);

 	case PIO_UNIMAPCLR:
 	      { struct unimapinit ui;
@@ -952,13 +952,13 @@
 			return -EPERM;
 		i = copy_from_user(&ui, (void *)arg, sizeof(struct unimapinit));
 		if (i) return -EFAULT;
-		con_clear_unimap(fg_console, &ui);
+		con_clear_unimap(vc, &ui);
 		return 0;
 	      }

 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
-		return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, perm);
+		return do_unimap_ioctl(vc, cmd, (struct unimapdesc *)arg, perm);

 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))
diff -Nru a/drivers/video/dummycon.c b/drivers/video/dummycon.c
--- a/drivers/video/dummycon.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/video/dummycon.c	Fri Oct 11 18:17:53 2002
@@ -9,7 +9,6 @@
 #include <linux/kdev_t.h>
 #include <linux/tty.h>
 #include <linux/console.h>
-#include <linux/console_struct.h>
 #include <linux/vt_kern.h>
 #include <linux/init.h>

diff -Nru a/drivers/video/mdacon.c b/drivers/video/mdacon.c
--- a/drivers/video/mdacon.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/video/mdacon.c	Fri Oct 11 18:17:53 2002
@@ -33,7 +33,6 @@
 #include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/console.h>
-#include <linux/console_struct.h>
 #include <linux/string.h>
 #include <linux/kd.h>
 #include <linux/slab.h>
@@ -377,7 +376,7 @@

 static void mdacon_deinit(struct vc_data *c)
 {
-	/* con_set_default_unimap(c->vc_num); */
+	/* con_set_default_unimap(c); */

 	if (mda_display_fg == c)
 		mda_display_fg = NULL;
diff -Nru a/drivers/video/newport_con.c b/drivers/video/newport_con.c
--- a/drivers/video/newport_con.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/video/newport_con.c	Fri Oct 11 18:17:53 2002
@@ -16,7 +16,6 @@
 #include <linux/kd.h>
 #include <linux/selection.h>
 #include <linux/console.h>
-#include <linux/console_struct.h>
 #include <linux/vt_kern.h>
 #include <linux/mm.h>
 #include <linux/module.h>
diff -Nru a/drivers/video/promcon.c b/drivers/video/promcon.c
--- a/drivers/video/promcon.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/video/promcon.c	Fri Oct 11 18:17:53 2002
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/console.h>
-#include <linux/console_struct.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
 #include <linux/fb.h>
@@ -156,9 +155,9 @@
 			k++;
 		}
 	set_fs(KERNEL_DS);
-	con_clear_unimap(conp->vc_num, NULL);
-	con_set_unimap(conp->vc_num, k, p);
-	con_protect_unimap(conp->vc_num, 1);
+	con_clear_unimap(conp, NULL);
+	con_set_unimap(conp, k, p);
+	con_protect_unimap(conp, 1);
 	set_fs(old_fs);
 	kfree(p);
 }
@@ -176,7 +175,7 @@
 	p = *conp->vc_uni_pagedir_loc;
 	if (conp->vc_uni_pagedir_loc == &conp->vc_uni_pagedir ||
 	    !--conp->vc_uni_pagedir_loc[1])
-		con_free_unimap(conp->vc_num);
+		con_free_unimap(conp);
 	conp->vc_uni_pagedir_loc = promcon_uni_pagedir;
 	promcon_uni_pagedir[1]++;
 	if (!promcon_uni_pagedir[0] && p) {
@@ -193,9 +192,9 @@
 {
 	/* When closing the last console, reset video origin */
 	if (!--promcon_uni_pagedir[1])
-		con_free_unimap(conp->vc_num);
+		con_free_unimap(conp);
 	conp->vc_uni_pagedir_loc = &conp->vc_uni_pagedir;
-	con_set_default_unimap(conp->vc_num);
+	con_set_default_unimap(conp);
 }

 static int
diff -Nru a/drivers/video/sticon.c b/drivers/video/sticon.c
--- a/drivers/video/sticon.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/video/sticon.c	Fri Oct 11 18:17:53 2002
@@ -49,7 +49,6 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/console.h>
-#include <linux/console_struct.h>
 #include <linux/errno.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
diff -Nru a/drivers/video/vgacon.c b/drivers/video/vgacon.c
--- a/drivers/video/vgacon.c	Fri Oct 11 18:17:53 2002
+++ b/drivers/video/vgacon.c	Fri Oct 11 18:17:53 2002
@@ -41,7 +41,6 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/console.h>
-#include <linux/console_struct.h>
 #include <linux/string.h>
 #include <linux/kd.h>
 #include <linux/slab.h>
@@ -334,11 +333,11 @@
 	p = *c->vc_uni_pagedir_loc;
 	if (c->vc_uni_pagedir_loc == &c->vc_uni_pagedir ||
 	    !--c->vc_uni_pagedir_loc[1])
-		con_free_unimap(c->vc_num);
+		con_free_unimap(c);
 	c->vc_uni_pagedir_loc = vgacon_uni_pagedir;
 	vgacon_uni_pagedir[1]++;
 	if (!vgacon_uni_pagedir[0] && p)
-		con_set_default_unimap(c->vc_num);
+		con_set_default_unimap(c);
 }

 static inline void vga_set_mem_top(struct vc_data *c)
@@ -352,10 +351,10 @@
 	if (!--vgacon_uni_pagedir[1]) {
 		c->vc_visible_origin = vga_vram_base;
 		vga_set_mem_top(c);
-		con_free_unimap(c->vc_num);
+		con_free_unimap(c);
 	}
 	c->vc_uni_pagedir_loc = &c->vc_uni_pagedir;
-	con_set_default_unimap(c->vc_num);
+	con_set_default_unimap(c);
 }

 static u8 vgacon_build_attr(struct vc_data *c, u8 color, u8 intensity, u8 blink, u8 underline, u8 reverse)
diff -Nru a/include/linux/consolemap.h b/include/linux/consolemap.h
--- a/include/linux/consolemap.h	Fri Oct 11 18:17:54 2002
+++ b/include/linux/consolemap.h	Fri Oct 11 18:17:54 2002
@@ -10,6 +10,6 @@

 struct vc_data;

-extern unsigned char inverse_translate(struct vc_data *conp, int glyph);
-extern unsigned short *set_translate(int m,int currcons);
-extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
+extern unsigned char inverse_translate(struct vc_data *vc, int glyph);
+extern void set_translate(struct vc_data *vc, int m);
+extern int conv_uni_to_pc(struct vc_data *vc, long ucs);
diff -Nru a/include/linux/vt_kern.h b/include/linux/vt_kern.h
--- a/include/linux/vt_kern.h	Fri Oct 11 18:17:53 2002
+++ b/include/linux/vt_kern.h	Fri Oct 11 18:17:53 2002
@@ -7,6 +7,7 @@
  */

 #include <linux/config.h>
+#include <linux/console_struct.h>
 #include <linux/vt.h>
 #include <linux/kd.h>
 #include <linux/tty.h>
@@ -51,7 +52,7 @@
 void do_blank_screen(int gfx_mode);
 void unblank_screen(void);
 void poke_blanked_console(void);
-int con_font_op(int currcons, struct console_font_op *op);
+int con_font_op(struct vc_data *vc, struct console_font_op *op);
 int con_set_cmap(unsigned char *cmap);
 int con_get_cmap(unsigned char *cmap);
 void scrollback(int);
@@ -69,17 +70,17 @@
 struct unimapinit;
 struct unipair;

-int con_set_trans_old(unsigned char * table);
-int con_get_trans_old(unsigned char * table);
-int con_set_trans_new(unsigned short * table);
-int con_get_trans_new(unsigned short * table);
-int con_clear_unimap(int currcons, struct unimapinit *ui);
-int con_set_unimap(int currcons, ushort ct, struct unipair *list);
-int con_get_unimap(int currcons, ushort ct, ushort *uct, struct unipair *list);
-int con_set_default_unimap(int currcons);
-void con_free_unimap(int currcons);
-void con_protect_unimap(int currcons, int rdonly);
-int con_copy_unimap(int dstcons, int srccons);
+int con_set_trans_old(struct vc_data *vc, unsigned char * table);
+int con_get_trans_old(struct vc_data *vc, unsigned char * table);
+int con_set_trans_new(struct vc_data *vc, unsigned short * table);
+int con_get_trans_new(struct vc_data *vc, unsigned short * table);
+int con_clear_unimap(struct vc_data *vc, struct unimapinit *ui);
+int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair *list);
+int con_get_unimap(struct vc_data *vc, ushort ct, ushort *uct, struct unipair *list);
+int con_set_default_unimap(struct vc_data *vc);
+void con_free_unimap(struct vc_data *vc);
+void con_protect_unimap(struct vc_data *vc, int rdonly);
+int con_copy_unimap(struct vc_data *dst, struct vc_data *src);

 /* vt.c */

diff -Nru a/include/video/fbcon.h b/include/video/fbcon.h
--- a/include/video/fbcon.h	Fri Oct 11 18:17:53 2002
+++ b/include/video/fbcon.h	Fri Oct 11 18:17:53 2002
@@ -13,8 +13,8 @@

 #include <linux/config.h>
 #include <linux/types.h>
-#include <linux/console_struct.h>
 #include <linux/vt_buffer.h>
+#include <linux/vt_kern.h>

 #include <asm/io.h>


===================================================================


This BitKeeper patch contains the following changesets:
1.714.6.3
## Wrapped with gzip_uu ##


begin 664 bkpatch2473
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
`
end

