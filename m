Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312988AbSDJMgO>; Wed, 10 Apr 2002 08:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312998AbSDJMfb>; Wed, 10 Apr 2002 08:35:31 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:1292 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312988AbSDJMfO>; Wed, 10 Apr 2002 08:35:14 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 10 Apr 2002 13:01:36 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.8-pre radio driver fixes
Message-ID: <20020410130136.B26389@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adapts the radio drivers to the -pre1 videodev bugfix and
makes them compile again.

This one depends on the zoltrix radio fix being applied.

  Gerd

==============================[ cut here ]==============================
# ChangeSet
#   1.587 02/04/08 10:03:57 kraxel@bytesex.org +14 -0
#   adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-zoltrix.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-typhoon.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +10 -5
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-trust.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-terratec.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-sf16fmi.c
#     1.8 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-rtrack2.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-maxiradio.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +6 -6
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-maestro.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +8 -6
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-gemtek.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-gemtek-pci.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-cadet.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +8 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-aztech.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/radio-aimslab.c
#     1.6 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
#   drivers/media/radio/miropcm20-radio.c
#     1.9 02/03/19 18:24:00 kraxel@bytesex.org +9 -4
#     adapt v4l radio drivers to 2.5.8-pre1 videodev fix.
# 
======================================================================
diff -Nru a/drivers/media/radio/miropcm20-radio.c b/drivers/media/radio/miropcm20-radio.c
--- a/drivers/media/radio/miropcm20-radio.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/miropcm20-radio.c	Mon Apr  8 10:18:08 2002
@@ -121,8 +121,8 @@
 	return 0;
 }
 
-static int pcm20_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg)
+static int pcm20_do_ioctl(struct inode *inode, struct file *file,
+			  unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct pcm20_device *pcm20 = dev->priv;
@@ -210,6 +210,12 @@
 	}
 }
 
+static int pcm20_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, pcm20_do_ioctl);
+}
+
 static struct pcm20_device pcm20_unit = {
 	freq:   87*16000,
 	muted:  1,
@@ -220,7 +226,7 @@
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		pcm20_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -230,7 +236,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_RTRACK,
 	fops:           &pcm20_fops,
-	kernel_ioctl:	pcm20_ioctl,
 	priv:		&pcm20_unit
 };
 
diff -Nru a/drivers/media/radio/radio-aimslab.c b/drivers/media/radio/radio-aimslab.c
--- a/drivers/media/radio/radio-aimslab.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-aimslab.c	Mon Apr  8 10:18:08 2002
@@ -213,8 +213,8 @@
 	return 1;		/* signal present		*/
 }
 
-static int rt_ioctl(struct inode *inode, struct file *file,
-		    unsigned int cmd, void *arg)
+static int rt_do_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct rt_device *rt=dev->priv;
@@ -291,13 +291,19 @@
 	}
 }
 
+static int rt_ioctl(struct inode *inode, struct file *file,
+		    unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, rt_do_ioctl);
+}
+
 static struct rt_device rtrack_unit;
 
 static struct file_operations rtrack_fops = {
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:	        rt_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -308,7 +314,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_RTRACK,
 	fops:           &rtrack_fops,
-	kernel_ioctl:	rt_ioctl,
 };
 
 static int __init rtrack_init(void)
diff -Nru a/drivers/media/radio/radio-aztech.c b/drivers/media/radio/radio-aztech.c
--- a/drivers/media/radio/radio-aztech.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-aztech.c	Mon Apr  8 10:18:08 2002
@@ -157,8 +157,8 @@
 	return 0;
 }
 
-static int az_ioctl(struct inode *inode, struct file *file,
-		    unsigned int cmd, void *arg)
+static int az_do_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct az_device *az = dev->priv;
@@ -243,13 +243,19 @@
 	}
 }
 
+static int az_ioctl(struct inode *inode, struct file *file,
+		    unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, az_do_ioctl);
+}
+
 static struct az_device aztech_unit;
 
 static struct file_operations aztech_fops = {
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		az_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -260,7 +266,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_AZTECH,
 	fops:           &aztech_fops,
-	kernel_ioctl:   az_ioctl,
 };
 
 static int __init aztech_init(void)
diff -Nru a/drivers/media/radio/radio-cadet.c b/drivers/media/radio/radio-cadet.c
--- a/drivers/media/radio/radio-cadet.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-cadet.c	Mon Apr  8 10:18:08 2002
@@ -384,8 +384,8 @@
 
 
 
-static int cadet_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg)
+static int cadet_do_ioctl(struct inode *inode, struct file *file,
+			  unsigned int cmd, void *arg)
 {
 	switch(cmd)
 	{
@@ -497,6 +497,11 @@
 	}
 }
 
+static int cadet_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, cadet_do_ioctl);
+}
 
 static int cadet_open(struct inode *inode, struct file *file)
 {
@@ -523,7 +528,7 @@
 	open:		cadet_open,
 	release:       	cadet_release,
 	read:		cadet_read,
-	ioctl:		video_generic_ioctl,
+	ioctl:		cadet_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -534,7 +539,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_CADET,
 	fops:           &cadet_fops,
-	kernel_ioctl:	cadet_ioctl,
 };
 
 static int isapnp_cadet_probe(void)
diff -Nru a/drivers/media/radio/radio-gemtek-pci.c b/drivers/media/radio/radio-gemtek-pci.c
--- a/drivers/media/radio/radio-gemtek-pci.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-gemtek-pci.c	Mon Apr  8 10:18:08 2002
@@ -177,8 +177,8 @@
 	return ( inb( card->iobase ) & 0x08 ) ? 0 : 1;
 }
 
-static int gemtek_pci_ioctl(struct inode *inode, struct file *file,
-			    unsigned int cmd, void *arg)
+static int gemtek_pci_do_ioctl(struct inode *inode, struct file *file,
+			       unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct gemtek_pci_card *card = dev->priv;
@@ -272,6 +272,12 @@
 	}
 }
 
+static int gemtek_pci_ioctl(struct inode *inode, struct file *file,
+			    unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, gemtek_pci_do_ioctl);
+}
+
 enum {
 	GEMTEK_PR103
 };
@@ -295,7 +301,7 @@
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		gemtek_pci_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -305,7 +311,6 @@
 	type:          VID_TYPE_TUNER,
 	hardware:      VID_HARDWARE_GEMTEK,
 	fops:          &gemtek_pci_fops,
-	kernel_ioctl:  gemtek_pci_ioctl,
 };
 
 static int __devinit gemtek_pci_probe( struct pci_dev *pci_dev, const struct pci_device_id *pci_id )
diff -Nru a/drivers/media/radio/radio-gemtek.c b/drivers/media/radio/radio-gemtek.c
--- a/drivers/media/radio/radio-gemtek.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-gemtek.c	Mon Apr  8 10:18:08 2002
@@ -138,8 +138,8 @@
 	return 1;		/* signal present */
 }
 
-static int gemtek_ioctl(struct inode *inode, struct file *file,
-			unsigned int cmd, void *arg)
+static int gemtek_do_ioctl(struct inode *inode, struct file *file,
+			   unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct gemtek_device *rt=dev->priv;
@@ -220,13 +220,19 @@
 	}
 }
 
+static int gemtek_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, gemtek_do_ioctl);
+}
+
 static struct gemtek_device gemtek_unit;
 
 static struct file_operations gemtek_fops = {
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		gemtek_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -237,7 +243,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_GEMTEK,
 	fops:           &gemtek_fops,
-	kernel_ioctl:	gemtek_ioctl,
 };
 
 static int __init gemtek_init(void)
diff -Nru a/drivers/media/radio/radio-maestro.c b/drivers/media/radio/radio-maestro.c
--- a/drivers/media/radio/radio-maestro.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-maestro.c	Mon Apr  8 10:18:08 2002
@@ -65,13 +65,13 @@
 MODULE_PARM(radio_nr, "i");
 
 static int radio_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg);
+		       unsigned int cmd, unsigned long arg);
 
 static struct file_operations maestro_fops = {
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		radio_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -82,7 +82,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_SF16MI,
 	fops:           &maestro_fops,
-	kernel_ioctl:	radio_ioctl,
 };
 
 static struct radio_device
@@ -175,10 +174,12 @@
 	sleep_125ms();
 }
 
-inline static int radio_function(struct video_device *dev, 
+inline static int radio_function(struct inode *inode, struct file *file,
 				 unsigned int cmd, void *arg)
 {
+	struct video_device *dev = video_devdata(file);
 	struct radio_device *card=dev->priv;
+	
 	switch(cmd) {
 		case VIDIOCGCAP: {
 			struct video_capability *v = arg;
@@ -257,13 +258,14 @@
 }
 
 static int radio_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg)
+		       unsigned int cmd, unsigned long arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct radio_device *card=dev->priv;
 	int ret;
+
 	down(&card->lock);
-	ret = radio_function(dev, cmd, arg);
+	ret = video_usercopy(inode, file, cmd, arg, radio_function);
 	up(&card->lock);
 	return ret;
 }
diff -Nru a/drivers/media/radio/radio-maxiradio.c b/drivers/media/radio/radio-maxiradio.c
--- a/drivers/media/radio/radio-maxiradio.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-maxiradio.c	Mon Apr  8 10:18:08 2002
@@ -73,13 +73,13 @@
 
 
 static int radio_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg);
+		       unsigned int cmd, unsigned long arg);
 
 static struct file_operations maxiradio_fops = {
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:	        radio_ioctl,
 	llseek:         no_llseek,
 };
 static struct video_device maxiradio_radio =
@@ -89,7 +89,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_SF16MI,
 	fops:           &maxiradio_fops,
-	kernel_ioctl:	radio_ioctl,
 };
 
 static struct radio_device
@@ -174,9 +173,10 @@
 }
 
 
-inline static int radio_function(struct video_device *dev,
+inline static int radio_function(struct inode *inode, struct file *file,
 				 unsigned int cmd, void *arg)
 {
+	struct video_device *dev = video_devdata(file);
 	struct radio_device *card=dev->priv;
 
 	switch(cmd) {
@@ -267,14 +267,14 @@
 }
 
 static int radio_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg)
+		       unsigned int cmd, unsigned long arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct radio_device *card=dev->priv;
 	int ret;
 	
 	down(&card->lock);
-	ret = radio_function(dev, cmd, arg);
+	ret = video_usercopy(inode, file, cmd, arg, radio_function);
 	up(&card->lock);
 	return ret;
 }
diff -Nru a/drivers/media/radio/radio-rtrack2.c b/drivers/media/radio/radio-rtrack2.c
--- a/drivers/media/radio/radio-rtrack2.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-rtrack2.c	Mon Apr  8 10:18:08 2002
@@ -106,8 +106,8 @@
 	return 1;		/* signal present		*/
 }
 
-static int rt_ioctl(struct inode *inode, struct file *file,
-		    unsigned int cmd, void *arg)
+static int rt_do_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct rt_device *rt=dev->priv;
@@ -186,13 +186,19 @@
 	}
 }
 
+static int rt_ioctl(struct inode *inode, struct file *file,
+		    unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, rt_do_ioctl);
+}
+
 static struct rt_device rtrack2_unit;
 
 static struct file_operations rtrack2_fops = {
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		rt_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -203,7 +209,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_RTRACK2,
 	fops:           &rtrack2_fops,
-	kernel_ioctl:   rt_ioctl,
 };
 
 static int __init rtrack2_init(void)
diff -Nru a/drivers/media/radio/radio-sf16fmi.c b/drivers/media/radio/radio-sf16fmi.c
--- a/drivers/media/radio/radio-sf16fmi.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-sf16fmi.c	Mon Apr  8 10:18:08 2002
@@ -132,8 +132,8 @@
 	return (res & 2) ? 0 : 0xFFFF;
 }
 
-static int fmi_ioctl(struct inode *inode, struct file *file,
-		     unsigned int cmd, void *arg)
+static int fmi_do_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct fmi_device *fmi=dev->priv;
@@ -230,13 +230,19 @@
 	}
 }
 
+static int fmi_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, fmi_do_ioctl);
+}
+
 static struct fmi_device fmi_unit;
 
 static struct file_operations fmi_fops = {
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		fmi_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -247,7 +253,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_SF16MI,
 	fops:           &fmi_fops,
-	kernel_ioctl:   fmi_ioctl,
 };
 
 /* ladis: this is my card. does any other types exist? */
diff -Nru a/drivers/media/radio/radio-terratec.c b/drivers/media/radio/radio-terratec.c
--- a/drivers/media/radio/radio-terratec.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-terratec.c	Mon Apr  8 10:18:08 2002
@@ -185,8 +185,8 @@
 
 /* implement the video4linux api */
 
-static int tt_ioctl(struct inode *inode, struct file *file,
-		    unsigned int cmd, void *arg)
+static int tt_do_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct tt_device *tt=dev->priv;
@@ -263,13 +263,19 @@
 	}
 }
 
+static int tt_ioctl(struct inode *inode, struct file *file,
+		    unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, tt_do_ioctl);
+}
+
 static struct tt_device terratec_unit;
 
 static struct file_operations terratec_fops = {
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		tt_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -280,7 +286,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_TERRATEC,
 	fops:           &terratec_fops,
-	kernel_ioctl:	tt_ioctl,
 };
 
 static int __init terratec_init(void)
diff -Nru a/drivers/media/radio/radio-trust.c b/drivers/media/radio/radio-trust.c
--- a/drivers/media/radio/radio-trust.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-trust.c	Mon Apr  8 10:18:08 2002
@@ -154,8 +154,8 @@
 	write_i2c(5, TSA6060T_ADDR, (f << 1) | 1, f >> 7, 0x60 | ((f >> 15) & 1), 0);
 }
 
-static int tr_ioctl(struct inode *inode, struct file *file,
-		    unsigned int cmd, void *arg)
+static int tr_do_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, void *arg)
 {
 	switch(cmd)
 	{
@@ -244,11 +244,17 @@
 	}
 }
 
+static int tr_ioctl(struct inode *inode, struct file *file,
+		    unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, tr_do_ioctl);
+}
+
 static struct file_operations trust_fops = {
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		tr_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -259,7 +265,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_TRUST,
 	fops:           &trust_fops,
-	kernel_ioctl:	tr_ioctl,
 };
 
 static int __init trust_init(void)
diff -Nru a/drivers/media/radio/radio-typhoon.c b/drivers/media/radio/radio-typhoon.c
--- a/drivers/media/radio/radio-typhoon.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-typhoon.c	Mon Apr  8 10:18:08 2002
@@ -70,7 +70,7 @@
 static void typhoon_unmute(struct typhoon_device *dev);
 static int typhoon_setvol(struct typhoon_device *dev, int vol);
 static int typhoon_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, void *arg);
+			 unsigned int cmd, unsigned long arg);
 #ifdef CONFIG_RADIO_TYPHOON_PROC_FS
 static int typhoon_get_info(char *buf, char **start, off_t offset, int len);
 #endif
@@ -163,8 +163,8 @@
 }
 
 
-static int typhoon_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, void *arg)
+static int typhoon_do_ioctl(struct inode *inode, struct file *file,
+			    unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct typhoon_device *typhoon = dev->priv;
@@ -243,6 +243,12 @@
 	}
 }
 
+static int typhoon_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, typhoon_do_ioctl);
+}
+
 static struct typhoon_device typhoon_unit =
 {
 	iobase:		CONFIG_RADIO_TYPHOON_PORT,
@@ -254,7 +260,7 @@
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		typhoon_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -265,7 +271,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_TYPHOON,
 	fops:           &typhoon_fops,
-	kernel_ioctl:	typhoon_ioctl,
 };
 
 #ifdef CONFIG_RADIO_TYPHOON_PROC_FS
diff -Nru a/drivers/media/radio/radio-zoltrix.c b/drivers/media/radio/radio-zoltrix.c
--- a/drivers/media/radio/radio-zoltrix.c	Mon Apr  8 10:18:08 2002
+++ b/drivers/media/radio/radio-zoltrix.c	Mon Apr  8 10:18:08 2002
@@ -215,8 +215,8 @@
 	return 0;
 }
 
-static int zol_ioctl(struct inode *inode, struct file *file,
-		     unsigned int cmd, void *arg)
+static int zol_do_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct zol_device *zol = dev->priv;
@@ -309,6 +309,12 @@
 	}
 }
 
+static int zol_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, zol_do_ioctl);
+}
+
 static struct zol_device zoltrix_unit;
 
 static struct file_operations zoltrix_fops =
@@ -316,7 +322,7 @@
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:		video_generic_ioctl,
+	ioctl:		zol_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -327,7 +333,6 @@
 	type:		VID_TYPE_TUNER,
 	hardware:	VID_HARDWARE_ZOLTRIX,
 	fops:           &zoltrix_fops,
-	kernel_ioctl:  	zol_ioctl,
 };
 
 static int __init zoltrix_init(void)
======================================================================
This BitKeeper patch contains the following changesets:
1.587
## Wrapped with gzip_uu ##


begin 664 bkpatch4815
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
>[/EM]P7?\"X.[S=/JVNL*5R&6@6_`TL*GU-0/```
`
end
