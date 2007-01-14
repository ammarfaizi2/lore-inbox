Return-Path: <linux-kernel-owner+w=401wt.eu-S1751006AbXANBBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbXANBBM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbXANBBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:01:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52760 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbXANBBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:01:06 -0500
Subject: [patch 04/12] mark struct file_operations const 4
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:54:27 -0800
Message-Id: <1168736067.3123.325.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 04/12] mark struct file_operations const

Many struct file_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6/drivers/macintosh/adb.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/adb.c
+++ linux-2.6/drivers/macintosh/adb.c
@@ -885,7 +885,7 @@ out:
 	return ret;
 }
 
-static struct file_operations adb_fops = {
+static const struct file_operations adb_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= adb_read,
Index: linux-2.6/drivers/macintosh/ans-lcd.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/ans-lcd.c
+++ linux-2.6/drivers/macintosh/ans-lcd.c
@@ -121,7 +121,7 @@ anslcd_open( struct inode * inode, struc
 	return 0;
 }
 
-struct file_operations anslcd_fops = {
+const struct file_operations anslcd_fops = {
 	.write	= anslcd_write,
 	.ioctl	= anslcd_ioctl,
 	.open	= anslcd_open,
Index: linux-2.6/drivers/macintosh/apm_emu.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/apm_emu.c
+++ linux-2.6/drivers/macintosh/apm_emu.c
@@ -501,7 +501,7 @@ static int apm_emu_get_info(char *buf, c
 	return p - buf;
 }
 
-static struct file_operations apm_bios_fops = {
+static const struct file_operations apm_bios_fops = {
 	.owner		= THIS_MODULE,
 	.read		= do_read,
 	.poll		= do_poll,
Index: linux-2.6/drivers/macintosh/nvram.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/nvram.c
+++ linux-2.6/drivers/macintosh/nvram.c
@@ -100,7 +100,7 @@ static int nvram_ioctl(struct inode *ino
 	return 0;
 }
 
-struct file_operations nvram_fops = {
+const struct file_operations nvram_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= nvram_llseek,
 	.read		= read_nvram,
Index: linux-2.6/drivers/macintosh/smu.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/smu.c
+++ linux-2.6/drivers/macintosh/smu.c
@@ -1277,7 +1277,7 @@ static int smu_release(struct inode *ino
 }
 
 
-static struct file_operations smu_device_fops = {
+static const struct file_operations smu_device_fops = {
 	.llseek		= no_llseek,
 	.read		= smu_read,
 	.write		= smu_write,
Index: linux-2.6/drivers/macintosh/via-pmu68k.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-pmu68k.c
+++ linux-2.6/drivers/macintosh/via-pmu68k.c
@@ -1040,7 +1040,7 @@ static int pmu_ioctl(struct inode * inod
 	return -EINVAL;
 }
 
-static struct file_operations pmu_device_fops = {
+static const struct file_operations pmu_device_fops = {
 	.read		= pmu_read,
 	.write		= pmu_write,
 	.ioctl		= pmu_ioctl,
Index: linux-2.6/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6/drivers/macintosh/via-pmu.c
@@ -2673,7 +2673,7 @@ pmu_ioctl(struct inode * inode, struct f
 	return error;
 }
 
-static struct file_operations pmu_device_fops = {
+static const struct file_operations pmu_device_fops = {
 	.read		= pmu_read,
 	.write		= pmu_write,
 	.poll		= pmu_fpoll,
Index: linux-2.6/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-ioctl.c
+++ linux-2.6/drivers/md/dm-ioctl.c
@@ -1473,7 +1473,7 @@ static int ctl_ioctl(struct inode *inode
 	return r;
 }
 
-static struct file_operations _ctl_fops = {
+static const struct file_operations _ctl_fops = {
 	.ioctl	 = ctl_ioctl,
 	.owner	 = THIS_MODULE,
 };
Index: linux-2.6/drivers/md/md.c
===================================================================
--- linux-2.6.orig/drivers/md/md.c
+++ linux-2.6/drivers/md/md.c
@@ -4917,7 +4917,7 @@ static unsigned int mdstat_poll(struct f
 	return mask;
 }
 
-static struct file_operations md_seq_fops = {
+static const struct file_operations md_seq_fops = {
 	.owner		= THIS_MODULE,
 	.open           = md_seq_open,
 	.read           = seq_read,
Index: linux-2.6/drivers/media/common/saa7146_fops.c
===================================================================
--- linux-2.6.orig/drivers/media/common/saa7146_fops.c
+++ linux-2.6/drivers/media/common/saa7146_fops.c
@@ -416,7 +416,7 @@ static ssize_t fops_write(struct file *f
 	}
 }
 
-static struct file_operations video_fops =
+static const struct file_operations video_fops =
 {
 	.owner		= THIS_MODULE,
 	.open		= fops_open,
Index: linux-2.6/drivers/media/radio/dsbr100.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/dsbr100.c
+++ linux-2.6/drivers/media/radio/dsbr100.c
@@ -144,7 +144,7 @@ struct dsbr100_device {
 
 
 /* File system interface */
-static struct file_operations usb_dsbr100_fops = {
+static const struct file_operations usb_dsbr100_fops = {
 	.owner =	THIS_MODULE,
 	.open =		usb_dsbr100_open,
 	.release =     	usb_dsbr100_close,
Index: linux-2.6/drivers/media/radio/miropcm20-radio.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/miropcm20-radio.c
+++ linux-2.6/drivers/media/radio/miropcm20-radio.c
@@ -216,7 +216,7 @@ static struct pcm20_device pcm20_unit = 
 	.muted  = 1,
 };
 
-static struct file_operations pcm20_fops = {
+static const struct file_operations pcm20_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/miropcm20-rds.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/miropcm20-rds.c
+++ linux-2.6/drivers/media/radio/miropcm20-rds.c
@@ -105,7 +105,7 @@ static ssize_t rds_f_read(struct file *f
 	}
 }
 
-static struct file_operations rds_fops = {
+static const struct file_operations rds_fops = {
 	.owner		= THIS_MODULE,
 	.read		= rds_f_read,
 	.open		= rds_f_open,
Index: linux-2.6/drivers/media/radio/radio-aimslab.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-aimslab.c
+++ linux-2.6/drivers/media/radio/radio-aimslab.c
@@ -358,7 +358,7 @@ static int rt_ioctl(struct inode *inode,
 
 static struct rt_device rtrack_unit;
 
-static struct file_operations rtrack_fops = {
+static const struct file_operations rtrack_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-aztech.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-aztech.c
+++ linux-2.6/drivers/media/radio/radio-aztech.c
@@ -314,7 +314,7 @@ static int az_ioctl(struct inode *inode,
 
 static struct az_device aztech_unit;
 
-static struct file_operations aztech_fops = {
+static const struct file_operations aztech_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-cadet.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-cadet.c
+++ linux-2.6/drivers/media/radio/radio-cadet.c
@@ -507,7 +507,7 @@ cadet_poll(struct file *file, struct pol
 }
 
 
-static struct file_operations cadet_fops = {
+static const struct file_operations cadet_fops = {
 	.owner		= THIS_MODULE,
 	.open		= cadet_open,
 	.release       	= cadet_release,
Index: linux-2.6/drivers/media/radio/radio-gemtek.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-gemtek.c
+++ linux-2.6/drivers/media/radio/radio-gemtek.c
@@ -296,7 +296,7 @@ static int gemtek_ioctl(struct inode *in
 
 static struct gemtek_device gemtek_unit;
 
-static struct file_operations gemtek_fops = {
+static const struct file_operations gemtek_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-gemtek-pci.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-gemtek-pci.c
+++ linux-2.6/drivers/media/radio/radio-gemtek-pci.c
@@ -346,7 +346,7 @@ MODULE_DEVICE_TABLE( pci, gemtek_pci_id 
 
 static int mx = 1;
 
-static struct file_operations gemtek_pci_fops = {
+static const struct file_operations gemtek_pci_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-maestro.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-maestro.c
+++ linux-2.6/drivers/media/radio/radio-maestro.c
@@ -99,7 +99,7 @@ static struct pci_driver maestro_r_drive
 	.remove		= __devexit_p(maestro_remove),
 };
 
-static struct file_operations maestro_fops = {
+static const struct file_operations maestro_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-maxiradio.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-maxiradio.c
+++ linux-2.6/drivers/media/radio/radio-maxiradio.c
@@ -91,7 +91,7 @@ module_param(radio_nr, int, 0);
 static int radio_ioctl(struct inode *inode, struct file *file,
 		       unsigned int cmd, unsigned long arg);
 
-static struct file_operations maxiradio_fops = {
+static const struct file_operations maxiradio_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-rtrack2.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-rtrack2.c
+++ linux-2.6/drivers/media/radio/radio-rtrack2.c
@@ -262,7 +262,7 @@ static int rt_ioctl(struct inode *inode,
 
 static struct rt_device rtrack2_unit;
 
-static struct file_operations rtrack2_fops = {
+static const struct file_operations rtrack2_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-sf16fmi.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-sf16fmi.c
+++ linux-2.6/drivers/media/radio/radio-sf16fmi.c
@@ -265,7 +265,7 @@ static int fmi_ioctl(struct inode *inode
 
 static struct fmi_device fmi_unit;
 
-static struct file_operations fmi_fops = {
+static const struct file_operations fmi_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-sf16fmr2.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-sf16fmr2.c
+++ linux-2.6/drivers/media/radio/radio-sf16fmr2.c
@@ -410,7 +410,7 @@ static int fmr2_ioctl(struct inode *inod
 
 static struct fmr2_device fmr2_unit;
 
-static struct file_operations fmr2_fops = {
+static const struct file_operations fmr2_fops = {
 	.owner          = THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-terratec.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-terratec.c
+++ linux-2.6/drivers/media/radio/radio-terratec.c
@@ -338,7 +338,7 @@ static int tt_ioctl(struct inode *inode,
 
 static struct tt_device terratec_unit;
 
-static struct file_operations terratec_fops = {
+static const struct file_operations terratec_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-trust.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-trust.c
+++ linux-2.6/drivers/media/radio/radio-trust.c
@@ -325,7 +325,7 @@ static int tr_ioctl(struct inode *inode,
 	return video_usercopy(inode, file, cmd, arg, tr_do_ioctl);
 }
 
-static struct file_operations trust_fops = {
+static const struct file_operations trust_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-typhoon.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-typhoon.c
+++ linux-2.6/drivers/media/radio/radio-typhoon.c
@@ -318,7 +318,7 @@ static struct typhoon_device typhoon_uni
 	.mutefreq	= CONFIG_RADIO_TYPHOON_MUTEFREQ,
 };
 
-static struct file_operations typhoon_fops = {
+static const struct file_operations typhoon_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/radio/radio-zoltrix.c
===================================================================
--- linux-2.6.orig/drivers/media/radio/radio-zoltrix.c
+++ linux-2.6/drivers/media/radio/radio-zoltrix.c
@@ -373,7 +373,7 @@ static int zol_ioctl(struct inode *inode
 
 static struct zol_device zoltrix_unit;
 
-static struct file_operations zoltrix_fops =
+static const struct file_operations zoltrix_fops =
 {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
Index: linux-2.6/drivers/media/video/arv.c
===================================================================
--- linux-2.6.orig/drivers/media/video/arv.c
+++ linux-2.6/drivers/media/video/arv.c
@@ -742,7 +742,7 @@ void ar_release(struct video_device *vfd
  * Video4Linux Module functions
  *
  ****************************************************************************/
-static struct file_operations ar_fops = {
+static const struct file_operations ar_fops = {
 	.owner		= THIS_MODULE,
 	.open		= video_exclusive_open,
 	.release	= video_exclusive_release,
Index: linux-2.6/drivers/media/video/bt8xx/bttv-driver.c
===================================================================
--- linux-2.6.orig/drivers/media/video/bt8xx/bttv-driver.c
+++ linux-2.6/drivers/media/video/bt8xx/bttv-driver.c
@@ -3174,7 +3174,7 @@ bttv_mmap(struct file *file, struct vm_a
 	return videobuf_mmap_mapper(bttv_queue(fh),vma);
 }
 
-static struct file_operations bttv_fops =
+static const struct file_operations bttv_fops =
 {
 	.owner	  = THIS_MODULE,
 	.open	  = bttv_open,
@@ -3332,7 +3332,7 @@ static unsigned int radio_poll(struct fi
 	return cmd.result;
 }
 
-static struct file_operations radio_fops =
+static const struct file_operations radio_fops =
 {
 	.owner	  = THIS_MODULE,
 	.open	  = radio_open,
Index: linux-2.6/drivers/media/video/bw-qcam.c
===================================================================
--- linux-2.6.orig/drivers/media/video/bw-qcam.c
+++ linux-2.6/drivers/media/video/bw-qcam.c
@@ -871,7 +871,7 @@ static ssize_t qcam_read(struct file *fi
 	return len;
 }
 
-static struct file_operations qcam_fops = {
+static const struct file_operations qcam_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/video/cafe_ccic.c
===================================================================
--- linux-2.6.orig/drivers/media/video/cafe_ccic.c
+++ linux-2.6/drivers/media/video/cafe_ccic.c
@@ -1715,7 +1715,7 @@ static void cafe_v4l_dev_release(struct 
  * clone it for specific real devices.
  */
 
-static struct file_operations cafe_v4l_fops = {
+static const struct file_operations cafe_v4l_fops = {
 	.owner = THIS_MODULE,
 	.open = cafe_v4l_open,
 	.release = cafe_v4l_release,
@@ -1969,7 +1969,7 @@ static ssize_t cafe_dfs_read_regs(struct
 			s - cafe_debug_buf);
 }
 
-static struct file_operations cafe_dfs_reg_ops = {
+static const struct file_operations cafe_dfs_reg_ops = {
 	.owner = THIS_MODULE,
 	.read = cafe_dfs_read_regs,
 	.open = cafe_dfs_open
@@ -1995,7 +1995,7 @@ static ssize_t cafe_dfs_read_cam(struct 
 			s - cafe_debug_buf);
 }
 
-static struct file_operations cafe_dfs_cam_ops = {
+static const struct file_operations cafe_dfs_cam_ops = {
 	.owner = THIS_MODULE,
 	.read = cafe_dfs_read_cam,
 	.open = cafe_dfs_open
Index: linux-2.6/drivers/media/video/cpia2/cpia2_v4l.c
===================================================================
--- linux-2.6.orig/drivers/media/video/cpia2/cpia2_v4l.c
+++ linux-2.6/drivers/media/video/cpia2/cpia2_v4l.c
@@ -1924,7 +1924,7 @@ static void reset_camera_struct_v4l(stru
 /***
  * The v4l video device structure initialized for this device
  ***/
-static struct file_operations fops_template = {
+static const struct file_operations fops_template = {
 	.owner		= THIS_MODULE,
 	.open		= cpia2_open,
 	.release	= cpia2_close,
Index: linux-2.6/drivers/media/video/cpia.c
===================================================================
--- linux-2.6.orig/drivers/media/video/cpia.c
+++ linux-2.6/drivers/media/video/cpia.c
@@ -3791,7 +3791,7 @@ static int cpia_mmap(struct file *file, 
 	return 0;
 }
 
-static struct file_operations cpia_fops = {
+static const struct file_operations cpia_fops = {
 	.owner		= THIS_MODULE,
 	.open		= cpia_open,
 	.release       	= cpia_close,
Index: linux-2.6/drivers/media/video/c-qcam.c
===================================================================
--- linux-2.6.orig/drivers/media/video/c-qcam.c
+++ linux-2.6/drivers/media/video/c-qcam.c
@@ -684,7 +684,7 @@ static ssize_t qcam_read(struct file *fi
 }
 
 /* video device template */
-static struct file_operations qcam_fops = {
+static const struct file_operations qcam_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/video/cx88/cx88-blackbird.c
===================================================================
--- linux-2.6.orig/drivers/media/video/cx88/cx88-blackbird.c
+++ linux-2.6/drivers/media/video/cx88/cx88-blackbird.c
@@ -1051,7 +1051,7 @@ mpeg_mmap(struct file *file, struct vm_a
 	return videobuf_mmap_mapper(&fh->mpegq, vma);
 }
 
-static struct file_operations mpeg_fops =
+static const struct file_operations mpeg_fops =
 {
 	.owner	       = THIS_MODULE,
 	.open	       = mpeg_open,
Index: linux-2.6/drivers/media/video/cx88/cx88-video.c
===================================================================
--- linux-2.6.orig/drivers/media/video/cx88/cx88-video.c
+++ linux-2.6/drivers/media/video/cx88/cx88-video.c
@@ -1808,7 +1808,7 @@ static irqreturn_t cx8800_irq(int irq, v
 /* ----------------------------------------------------------- */
 /* exported stuff                                              */
 
-static struct file_operations video_fops =
+static const struct file_operations video_fops =
 {
 	.owner	       = THIS_MODULE,
 	.open	       = video_open,
@@ -1839,7 +1839,7 @@ static struct video_device cx8800_vbi_te
 	.minor         = -1,
 };
 
-static struct file_operations radio_fops =
+static const struct file_operations radio_fops =
 {
 	.owner         = THIS_MODULE,
 	.open          = video_open,
Index: linux-2.6/drivers/media/video/dabusb.c
===================================================================
--- linux-2.6.orig/drivers/media/video/dabusb.c
+++ linux-2.6/drivers/media/video/dabusb.c
@@ -696,7 +696,7 @@ static int dabusb_ioctl (struct inode *i
 	return ret;
 }
 
-static struct file_operations dabusb_fops =
+static const struct file_operations dabusb_fops =
 {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
Index: linux-2.6/drivers/media/video/em28xx/em28xx-video.c
===================================================================
--- linux-2.6.orig/drivers/media/video/em28xx/em28xx-video.c
+++ linux-2.6/drivers/media/video/em28xx/em28xx-video.c
@@ -1480,7 +1480,7 @@ static int em28xx_v4l2_ioctl(struct inod
 	return ret;
 }
 
-static struct file_operations em28xx_v4l_fops = {
+static const struct file_operations em28xx_v4l_fops = {
 	.owner = THIS_MODULE,
 	.open = em28xx_v4l2_open,
 	.release = em28xx_v4l2_close,
Index: linux-2.6/drivers/media/video/et61x251/et61x251_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/et61x251/et61x251_core.c
+++ linux-2.6/drivers/media/video/et61x251/et61x251_core.c
@@ -2454,7 +2454,7 @@ static int et61x251_ioctl(struct inode* 
 }
 
 
-static struct file_operations et61x251_fops = {
+static const struct file_operations et61x251_fops = {
 	.owner = THIS_MODULE,
 	.open =    et61x251_open,
 	.release = et61x251_release,
Index: linux-2.6/drivers/media/video/meye.c
===================================================================
--- linux-2.6.orig/drivers/media/video/meye.c
+++ linux-2.6/drivers/media/video/meye.c
@@ -1748,7 +1748,7 @@ static int meye_mmap(struct file *file, 
 	return 0;
 }
 
-static struct file_operations meye_fops = {
+static const struct file_operations meye_fops = {
 	.owner		= THIS_MODULE,
 	.open		= meye_open,
 	.release	= meye_release,
Index: linux-2.6/drivers/media/video/ov511.c
===================================================================
--- linux-2.6.orig/drivers/media/video/ov511.c
+++ linux-2.6/drivers/media/video/ov511.c
@@ -4653,7 +4653,7 @@ ov51x_v4l1_mmap(struct file *file, struc
 	return 0;
 }
 
-static struct file_operations ov511_fops = {
+static const struct file_operations ov511_fops = {
 	.owner =	THIS_MODULE,
 	.open =		ov51x_v4l1_open,
 	.release =	ov51x_v4l1_close,
Index: linux-2.6/drivers/media/video/pms.c
===================================================================
--- linux-2.6.orig/drivers/media/video/pms.c
+++ linux-2.6/drivers/media/video/pms.c
@@ -881,7 +881,7 @@ static ssize_t pms_read(struct file *fil
 	return len;
 }
 
-static struct file_operations pms_fops = {
+static const struct file_operations pms_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
===================================================================
--- linux-2.6.orig/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
+++ linux-2.6/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
@@ -986,7 +986,7 @@ static unsigned int pvr2_v4l2_poll(struc
 }
 
 
-static struct file_operations vdev_fops = {
+static const struct file_operations vdev_fops = {
 	.owner      = THIS_MODULE,
 	.open       = pvr2_v4l2_open,
 	.release    = pvr2_v4l2_release,
Index: linux-2.6/drivers/media/video/pwc/pwc-if.c
===================================================================
--- linux-2.6.orig/drivers/media/video/pwc/pwc-if.c
+++ linux-2.6/drivers/media/video/pwc/pwc-if.c
@@ -152,7 +152,7 @@ static int  pwc_video_ioctl(struct inode
 			    unsigned int ioctlnr, unsigned long arg);
 static int  pwc_video_mmap(struct file *file, struct vm_area_struct *vma);
 
-static struct file_operations pwc_fops = {
+static const struct file_operations pwc_fops = {
 	.owner =	THIS_MODULE,
 	.open =		pwc_video_open,
 	.release =     	pwc_video_close,
Index: linux-2.6/drivers/media/video/saa5246a.c
===================================================================
--- linux-2.6.orig/drivers/media/video/saa5246a.c
+++ linux-2.6/drivers/media/video/saa5246a.c
@@ -817,7 +817,7 @@ static void __exit cleanup_saa_5246a (vo
 module_init(init_saa_5246a);
 module_exit(cleanup_saa_5246a);
 
-static struct file_operations saa_fops = {
+static const struct file_operations saa_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = saa5246a_open,
 	.release = saa5246a_release,
Index: linux-2.6/drivers/media/video/saa5249.c
===================================================================
--- linux-2.6.orig/drivers/media/video/saa5249.c
+++ linux-2.6/drivers/media/video/saa5249.c
@@ -699,7 +699,7 @@ static void __exit cleanup_saa_5249 (voi
 module_init(init_saa_5249);
 module_exit(cleanup_saa_5249);
 
-static struct file_operations saa_fops = {
+static const struct file_operations saa_fops = {
 	.owner		= THIS_MODULE,
 	.open		= saa5249_open,
 	.release       	= saa5249_release,
Index: linux-2.6/drivers/media/video/saa7134/saa7134-empress.c
===================================================================
--- linux-2.6.orig/drivers/media/video/saa7134/saa7134-empress.c
+++ linux-2.6/drivers/media/video/saa7134/saa7134-empress.c
@@ -319,7 +319,7 @@ static int ts_ioctl(struct inode *inode,
 	return video_usercopy(inode, file, cmd, arg, ts_do_ioctl);
 }
 
-static struct file_operations ts_fops =
+static const struct file_operations ts_fops =
 {
 	.owner	  = THIS_MODULE,
 	.open	  = ts_open,
Index: linux-2.6/drivers/media/video/saa7134/saa7134-oss.c
===================================================================
--- linux-2.6.orig/drivers/media/video/saa7134/saa7134-oss.c
+++ linux-2.6/drivers/media/video/saa7134/saa7134-oss.c
@@ -563,7 +563,7 @@ static unsigned int dsp_poll(struct file
 	return mask;
 }
 
-struct file_operations saa7134_dsp_fops = {
+const struct file_operations saa7134_dsp_fops = {
 	.owner   = THIS_MODULE,
 	.open    = dsp_open,
 	.release = dsp_release,
@@ -804,7 +804,7 @@ static int mixer_ioctl(struct inode *ino
 	}
 }
 
-struct file_operations saa7134_mixer_fops = {
+const struct file_operations saa7134_mixer_fops = {
 	.owner   = THIS_MODULE,
 	.open    = mixer_open,
 	.release = mixer_release,
Index: linux-2.6/drivers/media/video/saa7134/saa7134-video.c
===================================================================
--- linux-2.6.orig/drivers/media/video/saa7134/saa7134-video.c
+++ linux-2.6/drivers/media/video/saa7134/saa7134-video.c
@@ -2336,7 +2336,7 @@ static int radio_ioctl(struct inode *ino
 	return video_usercopy(inode, file, cmd, arg, radio_do_ioctl);
 }
 
-static struct file_operations video_fops =
+static const struct file_operations video_fops =
 {
 	.owner	  = THIS_MODULE,
 	.open	  = video_open,
@@ -2349,7 +2349,7 @@ static struct file_operations video_fops
 	.llseek   = no_llseek,
 };
 
-static struct file_operations radio_fops =
+static const struct file_operations radio_fops =
 {
 	.owner	  = THIS_MODULE,
 	.open	  = video_open,
Index: linux-2.6/drivers/media/video/se401.c
===================================================================
--- linux-2.6.orig/drivers/media/video/se401.c
+++ linux-2.6/drivers/media/video/se401.c
@@ -1185,7 +1185,7 @@ static int se401_mmap(struct file *file,
 	return 0;
 }
 
-static struct file_operations se401_fops = {
+static const struct file_operations se401_fops = {
 	.owner =	THIS_MODULE,
 	.open =         se401_open,
 	.release =      se401_close,
Index: linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/sn9c102/sn9c102_core.c
+++ linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
@@ -2736,7 +2736,7 @@ static int sn9c102_ioctl(struct inode* i
 
 /*****************************************************************************/
 
-static struct file_operations sn9c102_fops = {
+static const struct file_operations sn9c102_fops = {
 	.owner = THIS_MODULE,
 	.open =    sn9c102_open,
 	.release = sn9c102_release,
Index: linux-2.6/drivers/media/video/stradis.c
===================================================================
--- linux-2.6.orig/drivers/media/video/stradis.c
+++ linux-2.6/drivers/media/video/stradis.c
@@ -1901,7 +1901,7 @@ static int saa_release(struct inode *ino
 	return 0;
 }
 
-static struct file_operations saa_fops = {
+static const struct file_operations saa_fops = {
 	.owner = THIS_MODULE,
 	.open = saa_open,
 	.release = saa_release,
Index: linux-2.6/drivers/media/video/stv680.c
===================================================================
--- linux-2.6.orig/drivers/media/video/stv680.c
+++ linux-2.6/drivers/media/video/stv680.c
@@ -1380,7 +1380,7 @@ static ssize_t stv680_read (struct file 
 	return realcount;
 }				/* stv680_read */
 
-static struct file_operations stv680_fops = {
+static const struct file_operations stv680_fops = {
 	.owner =	THIS_MODULE,
 	.open =		stv_open,
 	.release =     	stv_close,
Index: linux-2.6/drivers/media/video/tvmixer.c
===================================================================
--- linux-2.6.orig/drivers/media/video/tvmixer.c
+++ linux-2.6/drivers/media/video/tvmixer.c
@@ -228,7 +228,7 @@ static struct i2c_driver driver = {
 	.detach_client   = tvmixer_clients,
 };
 
-static struct file_operations tvmixer_fops = {
+static const struct file_operations tvmixer_fops = {
 	.owner		= THIS_MODULE,
 	.llseek         = no_llseek,
 	.ioctl          = tvmixer_ioctl,
Index: linux-2.6/drivers/media/video/usbvideo/usbvideo.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvideo/usbvideo.c
+++ linux-2.6/drivers/media/video/usbvideo/usbvideo.c
@@ -945,7 +945,7 @@ static int usbvideo_find_struct(struct u
 	return rv;
 }
 
-static struct file_operations usbvideo_fops = {
+static const struct file_operations usbvideo_fops = {
 	.owner =  THIS_MODULE,
 	.open =   usbvideo_v4l_open,
 	.release =usbvideo_v4l_close,
Index: linux-2.6/drivers/media/video/usbvideo/vicam.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvideo/vicam.c
+++ linux-2.6/drivers/media/video/usbvideo/vicam.c
@@ -1234,7 +1234,7 @@ static inline void vicam_create_proc_ent
 static inline void vicam_destroy_proc_entry(void *ptr) { }
 #endif
 
-static struct file_operations vicam_fops = {
+static const struct file_operations vicam_fops = {
 	.owner		= THIS_MODULE,
 	.open		= vicam_open,
 	.release	= vicam_close,
Index: linux-2.6/drivers/media/video/usbvision/usbvision-video.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvision/usbvision-video.c
+++ linux-2.6/drivers/media/video/usbvision/usbvision-video.c
@@ -1476,7 +1476,7 @@ static int usbvision_vbi_ioctl(struct in
 //
 
 // Video template
-static struct file_operations usbvision_fops = {
+static const struct file_operations usbvision_fops = {
 	.owner             = THIS_MODULE,
 	.open		= usbvision_v4l2_open,
 	.release	= usbvision_v4l2_close,
@@ -1497,7 +1497,7 @@ static struct video_device usbvision_vid
 
 
 // Radio template
-static struct file_operations usbvision_radio_fops = {
+static const struct file_operations usbvision_radio_fops = {
 	.owner             = THIS_MODULE,
 	.open		= usbvision_radio_open,
 	.release	= usbvision_radio_close,
@@ -1518,7 +1518,7 @@ static struct video_device usbvision_rad
 
 
 // vbi template
-static struct file_operations usbvision_vbi_fops = {
+static const struct file_operations usbvision_vbi_fops = {
 	.owner             = THIS_MODULE,
 	.open		= usbvision_vbi_open,
 	.release	= usbvision_vbi_close,
Index: linux-2.6/drivers/media/video/videodev.c
===================================================================
--- linux-2.6.orig/drivers/media/video/videodev.c
+++ linux-2.6/drivers/media/video/videodev.c
@@ -1561,7 +1561,7 @@ out:
 }
 
 
-static struct file_operations video_fops;
+static const struct file_operations video_fops;
 
 /**
  *	video_register_device - register video4linux devices
@@ -1709,7 +1709,7 @@ void video_unregister_device(struct vide
 /*
  * Video fs operations
  */
-static struct file_operations video_fops=
+static const struct file_operations video_fops=
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
Index: linux-2.6/drivers/media/video/vino.c
===================================================================
--- linux-2.6.orig/drivers/media/video/vino.c
+++ linux-2.6/drivers/media/video/vino.c
@@ -4390,7 +4390,7 @@ static int vino_ioctl(struct inode *inod
 // __initdata
 static int vino_init_stage = 0;
 
-static struct file_operations vino_fops = {
+static const struct file_operations vino_fops = {
 	.owner		= THIS_MODULE,
 	.open		= vino_open,
 	.release	= vino_close,
Index: linux-2.6/drivers/media/video/vivi.c
===================================================================
--- linux-2.6.orig/drivers/media/video/vivi.c
+++ linux-2.6/drivers/media/video/vivi.c
@@ -1285,7 +1285,7 @@ vivi_mmap(struct file *file, struct vm_a
 	return ret;
 }
 
-static struct file_operations vivi_fops = {
+static const struct file_operations vivi_fops = {
 	.owner		= THIS_MODULE,
 	.open           = vivi_open,
 	.release        = vivi_release,
Index: linux-2.6/drivers/media/video/w9966.c
===================================================================
--- linux-2.6.orig/drivers/media/video/w9966.c
+++ linux-2.6/drivers/media/video/w9966.c
@@ -183,7 +183,7 @@ static int w9966_v4l_ioctl(struct inode 
 static ssize_t w9966_v4l_read(struct file *file, char __user *buf,
 			      size_t count, loff_t *ppos);
 
-static struct file_operations w9966_fops = {
+static const struct file_operations w9966_fops = {
 	.owner		= THIS_MODULE,
 	.open           = video_exclusive_open,
 	.release        = video_exclusive_release,
Index: linux-2.6/drivers/media/video/w9968cf.c
===================================================================
--- linux-2.6.orig/drivers/media/video/w9968cf.c
+++ linux-2.6/drivers/media/video/w9968cf.c
@@ -399,7 +399,7 @@ MODULE_PARM_DESC(specific_debug,
  ****************************************************************************/
 
 /* Video4linux interface */
-static struct file_operations w9968cf_fops;
+static const struct file_operations w9968cf_fops;
 static int w9968cf_open(struct inode*, struct file*);
 static int w9968cf_release(struct inode*, struct file*);
 static int w9968cf_mmap(struct file*, struct vm_area_struct*);
@@ -3466,7 +3466,7 @@ ioctl_fail:
 }
 
 
-static struct file_operations w9968cf_fops = {
+static const struct file_operations w9968cf_fops = {
 	.owner =   THIS_MODULE,
 	.open =    w9968cf_open,
 	.release = w9968cf_release,
Index: linux-2.6/drivers/media/video/zc0301/zc0301_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/zc0301/zc0301_core.c
+++ linux-2.6/drivers/media/video/zc0301/zc0301_core.c
@@ -1871,7 +1871,7 @@ static int zc0301_ioctl(struct inode* in
 }
 
 
-static struct file_operations zc0301_fops = {
+static const struct file_operations zc0301_fops = {
 	.owner =   THIS_MODULE,
 	.open =    zc0301_open,
 	.release = zc0301_release,
Index: linux-2.6/drivers/media/video/zoran_driver.c
===================================================================
--- linux-2.6.orig/drivers/media/video/zoran_driver.c
+++ linux-2.6/drivers/media/video/zoran_driver.c
@@ -4680,7 +4680,7 @@ zoran_mmap (struct file           *file,
 	return 0;
 }
 
-static struct file_operations zoran_fops = {
+static const struct file_operations zoran_fops = {
 	.owner = THIS_MODULE,
 	.open = zoran_open,
 	.release = zoran_close,
Index: linux-2.6/drivers/media/video/zoran_procfs.c
===================================================================
--- linux-2.6.orig/drivers/media/video/zoran_procfs.c
+++ linux-2.6/drivers/media/video/zoran_procfs.c
@@ -186,7 +186,7 @@ static ssize_t zoran_write(struct file *
 	return count;
 }
 
-static struct file_operations zoran_operations = {
+static const struct file_operations zoran_operations = {
 	.open		= zoran_open,
 	.read		= seq_read,
 	.write		= zoran_write,
Index: linux-2.6/drivers/message/fusion/mptctl.c
===================================================================
--- linux-2.6.orig/drivers/message/fusion/mptctl.c
+++ linux-2.6/drivers/message/fusion/mptctl.c
@@ -2718,7 +2718,7 @@ mptctl_hp_targetinfo(unsigned long arg)
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 
-static struct file_operations mptctl_fops = {
+static const struct file_operations mptctl_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
 	.release =	mptctl_release,


