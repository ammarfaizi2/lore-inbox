Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbTGOMHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbTGOMHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:07:01 -0400
Received: from mail.convergence.de ([212.84.236.4]:31904 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267314AbTGOMGF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:05 -0400
Subject: [PATCH 1/17] Update the saa7146 driver core
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:53 +0200
Message-Id: <1058271653486@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - fix WRITE_RPS0 and WRITE_RPS1 inlines, fix usage in mxb and budget drivers
[DVB] - export "saa7146_start_preview" and "saa7146_stop_preview" to allow  drivers to start and stop video overlay (necessary for analog module support in the av7110 driver)
[DVB] - fix i2c implementation: some frontend drivers transfer a huge amount of firmware data (> 30kB), speed up the transmission by busy waiting  between byte transfers for bigger transmissions
[DVB] - change ioctl function in various driver to accept a saa7146 filehandle instead of a saa714 device structure
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/common/saa7146_hlp.c linux-2.5.73.work/drivers/media/common/saa7146_hlp.c
--- linux-2.5.73.bk/drivers/media/common/saa7146_hlp.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/common/saa7146_hlp.c	2003-06-18 14:42:12.000000000 +0200
@@ -935,6 +935,7 @@
 static void program_capture_engine(struct saa7146_dev *dev, int planar)
 {
 	struct saa7146_vv *vv = dev->vv_data;
+	int count = 0;
 
 	unsigned long e_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_E_FID_A : CMD_E_FID_B;
 	unsigned long o_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_O_FID_A : CMD_O_FID_B;
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/common/saa7146_vbi.c linux-2.5.73.work/drivers/media/common/saa7146_vbi.c
--- linux-2.5.73.bk/drivers/media/common/saa7146_vbi.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/common/saa7146_vbi.c	2003-06-18 14:44:17.000000000 +0200
@@ -9,6 +9,7 @@
         u32          *cpu;
         dma_addr_t   dma_addr;
 	
+	int count = 0;
 	int i;
 
 	DECLARE_WAITQUEUE(wait, current);
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/ttpci/budget-patch.c linux-2.5.73.work/drivers/media/dvb/ttpci/budget-patch.c
--- linux-2.5.73.bk/drivers/media/dvb/ttpci/budget-patch.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/ttpci/budget-patch.c	2003-06-19 11:33:02.000000000 +0200
@@ -165,6 +165,7 @@
 {
         struct budget_patch *budget;
         int err;
+	int count = 0;
 
         if (!(budget = kmalloc (sizeof(struct budget_patch), GFP_KERNEL)))
                 return -ENOMEM;
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/common/saa7146_i2c.c linux-2.5.73.work/drivers/media/common/saa7146_i2c.c
--- linux-2.5.73.bk/drivers/media/common/saa7146_i2c.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/common/saa7146_i2c.c	2003-06-18 13:52:23.000000000 +0200
@@ -181,9 +181,10 @@
 /* this functions writes out the data-byte 'dword' to the i2c-device.
    it returns 0 if ok, -1 if the transfer failed, -2 if the transfer
    failed badly (e.g. address error) */
-static int saa7146_i2c_writeout(struct saa7146_dev *dev, u32* dword)
+static int saa7146_i2c_writeout(struct saa7146_dev *dev, u32* dword, int short_delay)
 {
 	u32 status = 0, mc2 = 0;
+	int trial = 0;
 	int timeout;
 
 	/* write out i2c-command */
@@ -224,10 +225,13 @@
 		/* wait until we get a transfer done or error */
 		timeout = jiffies + HZ/100 + 1; /* 10ms */
 		while(1) {
+			/**
+			 *  first read usually delivers bogus results...
+			 */
+			saa7146_i2c_status(dev);
 			status = saa7146_i2c_status(dev);
-			if( (0x3 == (status & 0x3)) || (0 == (status & 0x1)) ) {
+			if ((status & 0x3) != 1)
 				break;
-			}
 			if (jiffies > timeout) {
 				/* this is normal when probing the bus
 				 * (no answer from nonexisistant device...)
@@ -235,6 +239,9 @@
 				DEB_I2C(("saa7146_i2c_writeout: timed out waiting for end of xfer\n"));
 				return -EIO;
 			}
+			if ((++trial < 20) && short_delay)
+				udelay(10);
+			else
 			my_wait(dev,1);
 		}
 	}
@@ -277,6 +284,7 @@
 	u32* buffer = dev->d_i2c.cpu_addr;
 	int err = 0;
         int address_err = 0;
+        int short_delay = 0;
 	
 	if (down_interruptible (&dev->i2c_lock))
 		return -ERESTARTSYS;
@@ -292,6 +300,8 @@
 		goto out;
 	}
 
+        if (count > 3) short_delay = 1;
+  
 	do {
 		/* reset the i2c-device if necessary */
 		err = saa7146_i2c_reset(dev);
@@ -302,7 +312,7 @@
 
 		/* write out the u32s one after another */
 		for(i = 0; i < count; i++) {
-			err = saa7146_i2c_writeout(dev, &buffer[i] );
+			err = saa7146_i2c_writeout(dev, &buffer[i], short_delay);
 			if ( 0 != err) {
 				/* this one is unsatisfying: some i2c slaves on some
 				   dvb cards don't acknowledge correctly, so the saa7146
@@ -357,7 +367,7 @@
 	if( 0 == dev->revision ) {
 		u32 zero = 0;
 		saa7146_i2c_reset(dev);
-		if( 0 != saa7146_i2c_writeout(dev, &zero)) {
+		if( 0 != saa7146_i2c_writeout(dev, &zero, short_delay)) {
 			INFO(("revision 0 error. this should never happen.\n"));
 		}
 	}
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/common/saa7146_video.c linux-2.5.73.work/drivers/media/common/saa7146_video.c
--- linux-2.5.73.bk/drivers/media/common/saa7146_video.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/common/saa7146_video.c	2003-06-18 13:57:02.000000000 +0200
@@ -220,7 +220,7 @@
 	}
 }
 
-static int start_preview(struct saa7146_fh *fh)
+int saa7146_start_preview(struct saa7146_fh *fh)
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
@@ -266,12 +266,12 @@
 	return 0;
 }
 
-static int stop_preview(struct saa7146_fh *fh)
+int saa7146_stop_preview(struct saa7146_fh *fh)
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
 
-	DEB_EE(("saa7146.o: stop_preview()\n"));
+	DEB_EE(("saa7146.o: saa7146_stop_preview()\n"));
 
 	/* check if overlay is running */
 	if( 0 == vv->ov_data ) {
@@ -333,8 +333,8 @@
 		if( vv->ov_data != NULL ) {
 			if( fh == vv->ov_data->fh) {
 				spin_lock_irqsave(&dev->slock,flags);
-				stop_preview(fh);
-				start_preview(fh);
+				saa7146_stop_preview(fh);
+				saa7146_start_preview(fh);
 				spin_unlock_irqrestore(&dev->slock,flags);
 			}
 		}
@@ -522,8 +522,8 @@
 		if( 0 != vv->ov_data ) {
 			if( fh == vv->ov_data->fh ) {
 				spin_lock_irqsave(&dev->slock,flags);
-				stop_preview(fh);
-				start_preview(fh);
+				saa7146_stop_preview(fh);
+				saa7146_start_preview(fh);
 				spin_unlock_irqrestore(&dev->slock,flags);
 			}
 		}
@@ -747,12 +747,12 @@
 	
 	if( 0 != (dev->ext->ext_vv_data->ioctls[ee].flags & SAA7146_EXCLUSIVE) ) {
 		DEB_D(("extension handles ioctl exclusive.\n"));
-		result = dev->ext->ext_vv_data->ioctl(dev, cmd, arg);
+		result = dev->ext->ext_vv_data->ioctl(fh, cmd, arg);
 		return result;
 	}
 	if( 0 != (dev->ext->ext_vv_data->ioctls[ee].flags & SAA7146_BEFORE) ) {
 		DEB_D(("extension handles ioctl before.\n"));
-		result = dev->ext->ext_vv_data->ioctl(dev, cmd, arg);
+		result = dev->ext->ext_vv_data->ioctl(fh, cmd, arg);
 		if( -EAGAIN != result ) {
 			return result;
 		}
@@ -968,7 +968,7 @@
 
 		if( vv->ov_data != NULL ) {
 			ov_fh = vv->ov_data->fh;
-			stop_preview(ov_fh);
+			saa7146_stop_preview(ov_fh);
 			restart_overlay = 1;
 		}
 
@@ -983,7 +983,7 @@
 		}
 
 		if( 0 != restart_overlay ) {
-			start_preview(ov_fh);
+			saa7146_start_preview(ov_fh);
 		}
 		up(&dev->lock);
 
@@ -1013,7 +1013,7 @@
 				}
 			}
 			spin_lock_irqsave(&dev->slock,flags);
-			err = start_preview(fh);
+			err = saa7146_start_preview(fh);
 			spin_unlock_irqrestore(&dev->slock,flags);
 		} else {
 			if( vv->ov_data != NULL ) {
@@ -1022,7 +1022,7 @@
 				}
 			}
 			spin_lock_irqsave(&dev->slock,flags);
-			err = stop_preview(fh);
+			err = saa7146_stop_preview(fh);
 			spin_unlock_irqrestore(&dev->slock,flags);
 		}
 		return err;
@@ -1287,7 +1287,7 @@
 	if( 0 != vv->ov_data ) {
 		if( fh == vv->ov_data->fh ) {
 			spin_lock_irqsave(&dev->slock,flags);
-			stop_preview(fh);
+			saa7146_stop_preview(fh);
 			spin_unlock_irqrestore(&dev->slock,flags);
 		}
 	}
@@ -1331,7 +1331,7 @@
 
 	if( vv->ov_data != NULL ) {
 		ov_fh = vv->ov_data->fh;
-		stop_preview(ov_fh);
+		saa7146_stop_preview(ov_fh);
 		restart_overlay = 1;
 	}
 
@@ -1343,7 +1343,7 @@
 
 	/* restart overlay if it was active before */
 	if( 0 != restart_overlay ) {
-		start_preview(ov_fh);
+		saa7146_start_preview(ov_fh);
 	}
 	
 	return ret;
@@ -1360,3 +1360,6 @@
 };
 
 EXPORT_SYMBOL_GPL(saa7146_video_uops);
+
+EXPORT_SYMBOL_GPL(saa7146_start_preview);
+EXPORT_SYMBOL_GPL(saa7146_stop_preview);
diff -uNrwB --new-file linux-2.5.73.bk/include/media/saa7146_vv.h linux-2.5.73.work/include/media/saa7146_vv.h
--- linux-2.5.73.bk/include/media/saa7146_vv.h	2003-06-25 09:46:55.000000000 +0200
+++ linux-2.5.73.work/include/media/saa7146_vv.h	2003-06-18 14:43:38.000000000 +0200
@@ -10,12 +10,10 @@
 #define BUFFER_TIMEOUT     (HZ/2)  /* 0.5 seconds */
 
 #define WRITE_RPS0(x) do { \
-	static int count = 0;	\
 	dev->d_rps0.cpu_addr[ count++ ] = cpu_to_le32(x); \
 	} while (0);
 
 #define WRITE_RPS1(x) do { \
-	static int count = 0;	\
 	dev->d_rps1.cpu_addr[ count++ ] = cpu_to_le32(x); \
 	} while (0);
 
@@ -166,7 +164,7 @@
 	int (*std_callback)(struct saa7146_dev*, struct saa7146_standard *);
 		
 	struct saa7146_extension_ioctls *ioctls;
-	int (*ioctl)(struct saa7146_dev*, unsigned int cmd, void *arg);
+	int (*ioctl)(struct saa7146_fh*, unsigned int cmd, void *arg);
 };
 
 struct saa7146_use_ops  {
@@ -201,6 +199,8 @@
 
 /* from saa7146_video.c */
 extern struct saa7146_use_ops saa7146_video_uops;
+int saa7146_start_preview(struct saa7146_fh *fh);
+int saa7146_stop_preview(struct saa7146_fh *fh);
 
 /* from saa7146_vbi.c */
 extern struct saa7146_use_ops saa7146_vbi_uops;
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/ttpci/budget-av.c linux-2.5.73.work/drivers/media/dvb/ttpci/budget-av.c
--- linux-2.5.73.bk/drivers/media/dvb/ttpci/budget-av.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/ttpci/budget-av.c	2003-06-18 14:06:00.000000000 +0200
@@ -256,8 +256,9 @@
 };
 
 
-static int av_ioctl(struct saa7146_dev *dev, unsigned int cmd, void *arg) 
+static int av_ioctl(struct saa7146_fh *fh, unsigned int cmd, void *arg) 
 {
+	struct saa7146_dev *dev = fh->dev;
 	struct budget_av *budget_av = (struct budget_av*) dev->ext_priv;
 /*
 	struct saa7146_vv *vv = dev->vv_data; 
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/video/dpc7146.c linux-2.5.73.work/drivers/media/video/dpc7146.c
--- linux-2.5.73.bk/drivers/media/video/dpc7146.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/video/dpc7146.c	2003-06-25 12:16:54.000000000 +0200
@@ -246,8 +246,9 @@
 }
 #endif
 
-static int dpc_ioctl(struct saa7146_dev *dev, unsigned int cmd, void *arg) 
+static int dpc_ioctl(struct saa7146_fh *fh, unsigned int cmd, void *arg) 
 {
+	struct saa7146_dev *dev = fh->dev;
 	struct dpc* dpc = (struct dpc*)dev->ext_priv;
 /*
 	struct saa7146_vv *vv = dev->vv_data; 
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/video/mxb.c linux-2.5.73.work/drivers/media/video/mxb.c
--- linux-2.5.73.bk/drivers/media/video/mxb.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/video/mxb.c	2003-06-25 12:16:38.000000000 +0200
@@ -566,8 +566,9 @@
 	return 0;
 }
 
-static int mxb_ioctl(struct saa7146_dev *dev, unsigned int cmd, void *arg) 
+static int mxb_ioctl(struct saa7146_fh *fh, unsigned int cmd, void *arg) 
 {
+	struct saa7146_dev *dev = fh->dev;
 	struct mxb* mxb = (struct mxb*)dev->ext_priv;
 	struct saa7146_vv *vv = dev->vv_data; 
 	

