Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312883AbSDJMhJ>; Wed, 10 Apr 2002 08:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312998AbSDJMgo>; Wed, 10 Apr 2002 08:36:44 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:5132 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312997AbSDJMf2>; Wed, 10 Apr 2002 08:35:28 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 10 Apr 2002 13:13:40 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.8-pre v4l usb cam fixes
Message-ID: <20020410131340.B26486@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adapts most (all but usbvideo) v4l usb drivers to the
2.5.8-pre1 videodev fixes.

  Gerd

==============================[ cut here ]==============================
#   drivers/usb/media/vicam.c
#     1.14 02/04/08 12:18:56 kraxel@bytesex.org +9 -4
#     adapt v4l usb cam drivers to 2.4.8-pre1 videodev fixes.
# 
#   drivers/usb/media/stv680.c
#     1.12 02/04/08 12:18:56 kraxel@bytesex.org +9 -4
#     adapt v4l usb cam drivers to 2.4.8-pre1 videodev fixes.
# 
#   drivers/usb/media/se401.c
#     1.16 02/04/08 12:18:56 kraxel@bytesex.org +9 -4
#     adapt v4l usb cam drivers to 2.4.8-pre1 videodev fixes.
# 
#   drivers/usb/media/pwc-if.c
#     1.20 02/04/08 12:18:56 kraxel@bytesex.org +11 -5
#     adapt v4l usb cam drivers to 2.4.8-pre1 videodev fixes.
# 
#   drivers/usb/media/ov511.c
#     1.24 02/04/08 12:18:56 kraxel@bytesex.org +7 -6
#     adapt v4l usb cam drivers to 2.4.8-pre1 videodev fixes.
# 
#   drivers/usb/media/dsbr100.c
#     1.10 02/04/08 12:18:56 kraxel@bytesex.org +9 -5
#     adapt v4l usb cam drivers to 2.4.8-pre1 videodev fixes.
# 
# ChangeSet
#   1.586 02/04/08 11:32:47 kraxel@bytesex.org +6 -0
#   adapt v4l usb cam drivers to 2.4.8-pre1 videodev fixes.
# 
======================================================================
diff -Nru a/drivers/usb/media/dsbr100.c b/drivers/usb/media/dsbr100.c
--- a/drivers/usb/media/dsbr100.c	Mon Apr  8 11:47:55 2002
+++ b/drivers/usb/media/dsbr100.c	Mon Apr  8 11:47:55 2002
@@ -82,7 +82,7 @@
 			 const struct usb_device_id *id);
 static void usb_dsbr100_disconnect(struct usb_device *dev, void *ptr);
 static int usb_dsbr100_ioctl(struct inode *inode, struct file *file,
-			     unsigned int cmd, void *arg);
+			     unsigned int cmd, unsigned long arg);
 static int usb_dsbr100_open(struct inode *inode, struct file *file);
 static int usb_dsbr100_close(struct inode *inode, struct file *file);
 
@@ -103,7 +103,7 @@
 	owner:		THIS_MODULE,
 	open:		usb_dsbr100_open,
 	release:       	usb_dsbr100_close,
-	ioctl:          video_generic_ioctl,
+	ioctl:          usb_dsbr100_ioctl,
 	llseek:         no_llseek,
 };
 static struct video_device usb_dsbr100_radio=
@@ -113,7 +113,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_AZTECH,
 	fops:           &usb_dsbr100_fops,
-	kernel_ioctl:  	usb_dsbr100_ioctl,
 };
 
 static int users = 0;
@@ -212,8 +211,8 @@
 	unlock_kernel();
 }
 
-static int usb_dsbr100_ioctl(struct inode *inode, struct file *file,
-			     unsigned int cmd, void *arg)
+static int usb_dsbr100_do_ioctl(struct inode *inode, struct file *file,
+				unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	usb_dsbr100 *radio=dev->priv;
@@ -299,6 +298,11 @@
 	}
 }
 
+static int usb_dsbr100_ioctl(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, usb_dsbr100_do_ioctl);
+}
 
 static int usb_dsbr100_open(struct inode *inode, struct file *file)
 {
diff -Nru a/drivers/usb/media/ov511.c b/drivers/usb/media/ov511.c
--- a/drivers/usb/media/ov511.c	Mon Apr  8 11:47:55 2002
+++ b/drivers/usb/media/ov511.c	Mon Apr  8 11:47:55 2002
@@ -4555,9 +4555,11 @@
 
 /* Do not call this function directly! */
 static int 
-ov51x_v4l1_ioctl_internal(struct usb_ov511 *ov, unsigned int cmd,
-			  void *arg)
+ov51x_v4l1_ioctl_internal(struct inode *inode, struct file *file,
+			  unsigned int cmd, void *arg)
 {
+	struct video_device *vdev = file->private_data;
+	struct usb_ov511 *ov = vdev->priv;
 	PDEBUG(5, "IOCtl: 0x%X", cmd);
 
 	if (!ov->dev)
@@ -5067,7 +5069,7 @@
 
 static int 
 ov51x_v4l1_ioctl(struct inode *inode, struct file *file,
-		 unsigned int cmd, void *arg)
+		 unsigned int cmd, unsigned long arg)
 {
 	struct video_device *vdev = file->private_data;
 	struct usb_ov511 *ov = vdev->priv;
@@ -5076,7 +5078,7 @@
 	if (down_interruptible(&ov->lock))
 		return -EINTR;
 
-	rc = ov51x_v4l1_ioctl_internal(ov, cmd, arg);
+	rc = video_usercopy(inode, file, cmd, arg, ov51x_v4l1_ioctl_internal);
 
 	up(&ov->lock);
 	return rc;
@@ -5284,7 +5286,7 @@
 	release:       	ov51x_v4l1_close,
 	read:		ov51x_v4l1_read,
 	mmap:		ov51x_v4l1_mmap,
-	ioctl:          video_generic_ioctl,
+	ioctl:          ov51x_v4l1_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -5294,7 +5296,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_OV511,
 	fops:           &ov511_fops,
-	kernel_ioctl:	ov51x_v4l1_ioctl,
 };
 
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
diff -Nru a/drivers/usb/media/pwc-if.c b/drivers/usb/media/pwc-if.c
--- a/drivers/usb/media/pwc-if.c	Mon Apr  8 11:47:55 2002
+++ b/drivers/usb/media/pwc-if.c	Mon Apr  8 11:47:55 2002
@@ -126,7 +126,7 @@
 			  size_t count, loff_t *ppos);
 static unsigned int pwc_video_poll(struct file *file, poll_table *wait);
 static int  pwc_video_ioctl(struct inode *inode, struct file *file,
-			    unsigned int ioctlnr, void *arg);
+			    unsigned int ioctlnr, unsigned long arg);
 static int  pwc_video_mmap(struct file *file, struct vm_area_struct *vma);
 
 static struct file_operations pwc_fops = {
@@ -136,7 +136,7 @@
 	read:		pwc_video_read,
 	poll:		pwc_video_poll,
 	mmap:		pwc_video_mmap,
-	ioctl:          video_generic_ioctl,
+	ioctl:          pwc_video_ioctl,
 	llseek:         no_llseek,
 };
 static struct video_device pwc_template = {
@@ -145,7 +145,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_PWC,
 	fops:           &pwc_fops,
-	kernel_ioctl:	pwc_video_ioctl,
 };
 
 /***************************************************************************/
@@ -1171,8 +1170,8 @@
 	return 0;
 }
         
-static int pwc_video_ioctl(struct inode *inode, struct file *file,
-			   unsigned int cmd, void *arg)
+static int pwc_video_do_ioctl(struct inode *inode, struct file *file,
+			      unsigned int cmd, void *arg)
 {
 	struct video_device *vdev = file->private_data;
 	struct pwc_device *pdev;
@@ -1493,6 +1492,13 @@
 	} /* ..switch */
 	return 0;
 }	
+
+static int pwc_video_ioctl(struct inode *inode, struct file *file,
+			   unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, pwc_video_do_ioctl);
+}
+
 
 static int pwc_video_mmap(struct file *file, struct vm_area_struct *vma)
 {
diff -Nru a/drivers/usb/media/se401.c b/drivers/usb/media/se401.c
--- a/drivers/usb/media/se401.c	Mon Apr  8 11:47:55 2002
+++ b/drivers/usb/media/se401.c	Mon Apr  8 11:47:55 2002
@@ -1046,8 +1046,8 @@
 	return 0;
 }
 
-static int se401_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg)
+static int se401_do_ioctl(struct inode *inode, struct file *file,
+			  unsigned int cmd, void *arg)
 {
 	struct video_device *vdev = file->private_data;
         struct usb_se401 *se401 = (struct usb_se401 *)vdev;
@@ -1210,6 +1210,12 @@
         return 0;
 }
 
+static int se401_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, se401_do_ioctl);
+}
+
 static int se401_read(struct file *file, char *buf,
 		     size_t count, loff_t *ppos)
 {
@@ -1294,7 +1300,7 @@
         release:        se401_close,
         read:           se401_read,
         mmap:           se401_mmap,
-	ioctl:          video_generic_ioctl,
+	ioctl:          se401_ioctl,
 	llseek:         no_llseek,
 };
 static struct video_device se401_template = {
@@ -1303,7 +1309,6 @@
         type:           VID_TYPE_CAPTURE,
         hardware:       VID_HARDWARE_SE401,
 	fops:           &se401_fops,
-        kernel_ioctl:   se401_ioctl,
 };
 
 
diff -Nru a/drivers/usb/media/stv680.c b/drivers/usb/media/stv680.c
--- a/drivers/usb/media/stv680.c	Mon Apr  8 11:47:55 2002
+++ b/drivers/usb/media/stv680.c	Mon Apr  8 11:47:55 2002
@@ -1171,8 +1171,8 @@
 	return 0;
 }
 
-static int stv680_ioctl (struct inode *inode, struct file *file,
-			 unsigned int cmd, void *arg)
+static int stv680_do_ioctl (struct inode *inode, struct file *file,
+			    unsigned int cmd, void *arg)
 {
 	struct video_device *vdev = file->private_data;
 	struct usb_stv *stv680 = (struct usb_stv *) vdev;
@@ -1342,6 +1342,12 @@
 	return 0;
 }
 
+static int stv680_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, stv680_do_ioctl);
+}
+
 static int stv680_mmap (struct file *file, struct vm_area_struct *vma)
 {
 	struct video_device *dev = file->private_data;
@@ -1434,7 +1440,7 @@
 	release:       	stv_close,
 	read:		stv680_read,
 	mmap:		stv680_mmap,
-	ioctl:          video_generic_ioctl,
+	ioctl:          stv680_ioctl,
 	llseek:         no_llseek,
 };
 static struct video_device stv680_template = {
@@ -1443,7 +1449,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_SE401,
 	fops:           &stv680_fops,
-	kernel_ioctl:	stv680_ioctl,
 };
 
 static void *__devinit stv680_probe (struct usb_device *dev, unsigned int ifnum, const struct usb_device_id *id)
diff -Nru a/drivers/usb/media/vicam.c b/drivers/usb/media/vicam.c
--- a/drivers/usb/media/vicam.c	Mon Apr  8 11:47:55 2002
+++ b/drivers/usb/media/vicam.c	Mon Apr  8 11:47:55 2002
@@ -483,8 +483,8 @@
 	return buflen;
 }
 
-static int vicam_v4l_ioctl(struct inode *inode, struct file *file,
-			   unsigned int cmd, void *arg)
+static int vicam_v4l_do_ioctl(struct inode *inode, struct file *file,
+			      unsigned int cmd, void *arg)
 {
 	struct video_device *vdev = file->private_data;
 	struct usb_vicam *vicam = (struct usb_vicam *)vdev;
@@ -593,6 +593,12 @@
         return ret;
 }
 
+static int vicam_v4l_ioctl(struct inode *inode, struct file *file,
+			   unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, vicam_v4l_do_ioctl);
+}
+
 static int vicam_v4l_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct video_device *vdev = file->private_data;
@@ -639,7 +645,7 @@
 	release:       	vicam_v4l_close,
 	read:		vicam_v4l_read,
 	mmap:		vicam_v4l_mmap,
-	ioctl:		video_generic_ioctl,
+	ioctl:		vicam_v4l_ioctl,
 	llseek:         no_llseek,
 };
 static struct video_device vicam_template = {
@@ -648,7 +654,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_SE401, /* need to ask for own id */
 	fops:           &vicam_fops,
-	kernel_ioctl:	vicam_v4l_ioctl,
 };
 
 /******************************************************************************
======================================================================
This BitKeeper patch contains the following changesets:
1.586
## Wrapped with gzip_uu ##


begin 664 bkpatch16951
M'XL(`$MGL3P``]69VV[C-A"&KZVG(+`WVZP/)$52E!=>I-T4;=`"#5+L70&#
MIFA'<&P9DNPDK?KN'5**SXXM-P&R2F`&,F?X<\AO>,@']"TS:;<Q3M6CN?<^
MH%^3+.\V!D^YR<QC.TE'\.XV2>!=YR%)QYW!N$/;O#.,'UOS;.#!MS<JUW=H
M8=*LVR!M?_DF?YJ9;N/VYU^^_?[CK>?U>NCKG9J.S)\F1[V>ER?I0MU'V:7*
M[^Z3:3M/U32;F%RU=3(IEE4+BC&%'TX"'W-1$(%94&@2$:(8,1&F3`KFJ?%L
M<OEW/+/&;37?MF=88)\)*@H6,DF]*T3:7`J$:0>S#I:(D*Y/NRSXA&D78U2&
MXW(M#.B30"WL_81>5_=73R,5J5F.%NP>04215A,4I;&-)[2%:)NU96N6&H(6
M<622R"P0!-]D;>\WQ*D?,N]F%5BO5?/Q/*RP]P7-[)#M[U(EI@/B.EF^$!*W
M];)WU.<A"PM,<$@*0H9&#"-IAK[0(J1[PKCA;6*B6&WY9%@23"1$C/EA&(*T
MEP.^[B]9<$+6Q)&`81+`D`<A+H09!D&@1<24AI$_2=J&PY4R/PQ\OT;0#,A8
MER69)&'A,R)%$6E%C0XH>)9#I4X,V;K'E2X>P)^GZYH]Z%8\W!!&!`\+PH@@
MA6!T(`D71`^IHN0T89LNUY4)5D/9(@8*]LVR@-/"ETI0'D1&#`8^&\C3E&VX
M7!M*[`M9:Y)%V2`E&.].,X%%"`ZUPDKI@4_"P`STB>JVG*[T81$(ZI+GX6#;
M;/H60^Z-4C.Z'*>)NMMQM'^X&:4,?!8^EQR[)$OQ6HZE72*[7+R08PE!+?[>
MDJR;NW^@5OK@?B%IWKPP&F>DX"M"0T2\Z[)H-!H(GODTBT=3$Z%XFJ,XT?G]
M-&VNWD)41DBEHQ\^@[E?FKNBX>IVT?(!87W7J[[[I@GU&0P&%#!Q$04[P`K*
M+%=YK%US*Y.HLOJ8Y>E<@Y`I!`==N**)JI?#^![>V<_FL_HM_7H2-=$BB2-T
M835#FRSD*/#^VM_J.4WNMK<;*^\?KY&:?)Y.RW'NSV'SHY/9T\?*NW-86D/]
MYIY`0+S_!=G[B:SR<@T@ZZP-QWG<6A<LCH3+@H<A*7$DHA:.(6JQ=T>C7>..
MTEA%XBP8,0L=%ICC32R<TS.1.((#)12)W;;J-H0.L?<*+&SVON+`IJZ@REW!
MONRSU@^;>7PLH-8!>JJ-8!U\:NU'3P!H:R_J%C3&P1^'6><(HM\[0>6^^CA!
M52C.0NC@RE)Z7<XB5'==.8*1S]@61F5[M8%]&X(V.[]$B/DE0F6YB]!:']SJ
MS0XS5&US:R!4:Z]]G*"M?;8#R"<%!=6R!(A][P"59X:C`%61.(<?$&GQ83+8
MI,>Y[(/F-]N7<=B6B?U-OIM-V6X4GDF"`XP%J2PJCAJ-K2X`0H*3@P0MCV+'
M+ZG^Q['P.$@[1T*+$H.U2#!)RQLL4N]P%;Z_LY4[W1XE:1F*<UB2W$X)]_G,
MP"FSTAZKW%[ENBQVLC+(ZU?"5JF9V*I7E-A5[YH2L8GONLDY`.]9E=;9]3%!
M_%![YV6+-^%W7Q@<P?N!K"[AZN%8XRKP.(I;UX#E+4=0^#C$07G+46]-"U!+
MO#,0RRO-HR16D3AK3>-<ND6-<WN\LIX>;5*N#@=]F&$FG:I7/58Q+NP1KE%9
M5R=Y`PL">%G8`/2<R]:7&715Y:8?J5Q]7AK8F>JZC"X26]>:E'4A/7`<8)L?
MJA+4G$2+M0LK.W=?DVKK^21R#@;-IBM.I=M&5N5.PMHV;EH3=VA;_LM&WQD]
3SN:3'L5"1S(RWG_'"A)-(!H`````
`
end
