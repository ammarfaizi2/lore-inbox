Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTIYP6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 11:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTIYP6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 11:58:45 -0400
Received: from mail2.uu.nl ([131.211.16.76]:21416 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S261297AbTIYP6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 11:58:22 -0400
Subject: zr36120 2.6.x port (was: Re: [Mjpeg-users] DC30+ can't capture
	size greater than 224x168)
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Pauline Middelink <middelink@polyware.nl>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
In-Reply-To: <20030925102635.GA25634@polyware.nl>
References: <BAY7-F62oStVwgTlLlJ0001924a@hotmail.com>
	 <1064478814.2220.326.camel@shrek.bitfreak.net>
	 <20030925084932.GA22441@polyware.nl>
	 <1064484678.2227.465.camel@shrek.bitfreak.net>
	 <20030925102635.GA25634@polyware.nl>
Content-Type: multipart/mixed; boundary="=-JRcRE5dMZm9C6P9JcFXc"
Message-Id: <1064505583.2228.716.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 17:59:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JRcRE5dMZm9C6P9JcFXc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Pauline,

[CC: to kernel, since it matters a bit there...]

On Thu, 2003-09-25 at 12:26, Pauline Middelink wrote:
> Regarding the patch: would be nice.

It was easier than I thought (all code is in zr36120.c, the i2c
(zr36120_i2c.c) was a piece of cake and zr36120_mem.c is untouched). See
attachment. I have no clue whether it works, but this is how my driver
does it.

Changes:
* move to new i2c
* move to new videodev
* implement a zoran_vdev_release() function to free memory after it's no
longer in use (this is a hack imo, but it's the suggested way of doing
it... There was an article somewhere about it and it's also been
discussed on the v4l mailinglist... Can't find a link, though)
* proper module use-counting
* changed a __put_user() call somewhere because it failed to compile
here - not sure whether this is a real issue or just a local error
(RH90)... Probably some macro change in 2.6.x. It still does the same
thing, but in a different way.
* add zr36120 i2c HW id
* it compiles in my local 2.6.x tree

It accepts I2C_DRIVERID_TUNER as tuner (tuner.ko) and
I2C_DRIVERID_SAA7110 as decoder (saa7110.ko). If there's any others that
need adding, simply add them to the case: list.

Things left to do (for you ;) ): v4l2 (sounds like a good thing, though
it'll take some time), multiple opens (if you want), and (IIRC, Gerd?)
videodev + vbidev fops should be the same. This wasn't the case in
2.4.x, but it's the case in 2.6.x, I think. I'm actually not totally
sure, I think Gerd knows more about this, and can give you some pointers
to how others have done this.

Please let me know the results. :).

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>
Linux Video/Multimedia developer

--=-JRcRE5dMZm9C6P9JcFXc
Content-Disposition: attachment; filename=zr36120.diff
Content-Type: text/plain; name=zr36120.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test4/drivers/media/video/zr36120-old/i2c-id.h	2003-09-25 16:52:52.000000000 +0200
+++ linux-2.6.0-test4/include/linux/i2c-id.h	2003-09-25 16:53:50.000000000 +0200
@@ -95,7 +95,6 @@
 #define I2C_DRIVERID_DS1307	47     /* DS1307 real time clock	*/
 #define I2C_DRIVERID_ADV7175	48     /* ADV 7175/7176 video encoder	*/
 #define I2C_DRIVERID_SAA7114	49	/* video decoder		*/
-#define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
 #define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
 #define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
 #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
@@ -220,6 +219,7 @@
 #define I2C_HW_B_IXP425 0x17	/* GPIO on IXP425 systems		*/
 #define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 #define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
+#define I2C_HW_B_ZR36120 0x20	/* Zoran 36120/36125 based boards	*/
 
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
--- linux-2.6.0-test4/drivers/media/video/zr36120-old/zr36120.c	2003-09-25 12:21:18.000000000 +0200
+++ linux-2.6.0-test4/drivers/media/video/zr36120.c	2003-09-25 17:43:38.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
 #include <linux/signal.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
@@ -39,8 +40,8 @@
 #include <linux/version.h>
 #include <asm/uaccess.h>
 
-#include "tuner.h"
 #include "zr36120.h"
+#include <media/tuner.h>
 #include "zr36120_mem.h"
 
 /* mark an required function argument unused - lintism */
@@ -338,7 +339,7 @@
 }
 
 static
-void zoran_irq(int irq, void *dev_id, struct pt_regs * regs)
+irqreturn_t zoran_irq(int irq, void *dev_id, struct pt_regs * regs)
 {
 	u32 stat,estat;
 	int count = 0;
@@ -350,7 +351,7 @@
 		stat=zrread(ZORAN_ISR);
 		estat=stat & zrread(ZORAN_ICR);
 		if (!estat)
-			return;
+			break;
 		zrwrite(estat,ZORAN_ISR);
 		IDEBUG(printk(CARD_DEBUG "estat %08x\n",CARD,estat));
 		IDEBUG(printk(CARD_DEBUG " stat %08x\n",CARD,stat));
@@ -381,6 +382,8 @@
 			printk(CARD_ERR "IRQ lockup, cleared int mask\n",CARD);
 		}
 	}
+
+	return IRQ_HANDLED;
 }
 
 static
@@ -389,7 +392,7 @@
 	int	rv;
 
 	/* set the new video norm */
-	rv = i2c_control_device(&(ztv->i2c), I2C_DRIVERID_VIDEODECODER, DECODER_SET_NORM, &norm);
+	rv = zoran_i2c_command(ztv, DECODER_SET_NORM, &norm);
 	if (rv)
 		return rv;
 	ztv->norm = norm;
@@ -398,7 +401,7 @@
 	channel = ztv->card->video_mux[channel] & CHANNEL_MASK;
 
 	/* set the new channel */
-	rv = i2c_control_device(&(ztv->i2c), I2C_DRIVERID_VIDEODECODER, DECODER_SET_INPUT, &channel);
+	rv = zoran_i2c_command(ztv, DECODER_SET_INPUT, &channel);
 	return rv;
 }
 
@@ -735,7 +738,7 @@
 	ztv->picture.brightness=128<<8;
 	ztv->picture.hue=128<<8;
 	ztv->picture.contrast=216<<7;
-	i2c_control_device(&ztv->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_PICTURE, &ztv->picture);
+	zoran_i2c_command(ztv, DECODER_SET_PICTURE, &ztv->picture);
 
 	/* default to the composite input since my camera is there */
 	zoran_muxsel(ztv, 0, VIDEO_MODE_PAL);
@@ -757,11 +760,44 @@
 /*
  * Open a zoran card. Right now the flags are just a hack
  */
-static int zoran_open(struct video_device *dev, int flags)
+static
+int zoran_open(struct inode* inode, struct file* file)
 {
-	struct zoran *ztv = (struct zoran*)dev;
+	unsigned int minor = minor(inode->i_rdev);
+	struct zoran *ztv = NULL;
 	struct vidinfo* item;
 	char* pos;
+	int i;
+
+	if (!try_module_get(THIS_MODULE)) {
+		printk(KERN_ERR "failed to acquire lock on myself\n");
+		return -EIO;
+	}
+
+	/* find the device */
+	for (i = 0; i < zoran_cards; i++) {
+		if (zorans[i].video_dev->minor == minor) {
+			ztv = &zorans[i];
+			break;
+		}
+	}
+	if (!ztv)
+		return -ENODEV;
+
+	if (ztv->have_decoder &&
+	    !try_module_get(ztv->decoder->driver->owner)) {
+		printk(KERN_ERR "Failed to acquire lock on TV decoder\n");
+		module_put(THIS_MODULE);
+		return -EIO;
+	} 
+	if (ztv->have_tuner &&
+	    !try_module_get(ztv->tuner->driver->owner)) {
+		printk(KERN_ERR "Failed to acquire lock on TV tuner\n");
+		if (ztv->have_decoder)
+			module_put(ztv->decoder->driver->owner);
+		module_put(THIS_MODULE);
+		return -EIO;
+	}
 
 	DEBUG(printk(CARD_DEBUG "open(dev,%d)\n",CARD,flags));
 
@@ -773,6 +809,11 @@
 		ztv->fbuffer = bmalloc(ZORAN_MAX_FBUFSIZE);
 	if (!ztv->fbuffer) {
 		/* could not get a buffer, bail out */
+		module_put(THIS_MODULE);
+		if (ztv->have_decoder)
+			module_put(ztv->decoder->driver->owner);
+		if (ztv->have_tuner)
+			module_put(ztv->tuner->driver->owner);
 		return -ENOBUFS;
 	}
 	/* at this time we _always_ have a framebuffer */
@@ -783,6 +824,11 @@
 	if (!ztv->overinfo.overlay) {
 		/* could not get an overlay buffer, bail out */
 		bfree(ztv->fbuffer, ZORAN_MAX_FBUFSIZE);
+		module_put(THIS_MODULE);
+		if (ztv->have_decoder)
+			module_put(ztv->decoder->driver->owner);
+		if (ztv->have_tuner)
+			module_put(ztv->tuner->driver->owner);
 		return -ENOBUFS;
 	}
 	/* at this time we _always_ have a overlay */
@@ -798,22 +844,26 @@
 	}
 
 	/* do the common part of all open's */
-	zoran_common_open(ztv, flags);
+	zoran_common_open(ztv, file->f_flags);
+
+	file->private_data = ztv;
 
 	return 0;
 }
 
 static
-void zoran_close(struct video_device* dev)
+int zoran_close(struct inode* inode, struct file* file)
 {
-	struct zoran *ztv = (struct zoran*)dev;
+	struct zoran *ztv = file->private_data;
 
+	UNUSED(inode);
 	DEBUG(printk(CARD_DEBUG "close(dev)\n",CARD));
 
 	/* driver specific closure */
 	clear_bit(STATE_OVERLAY, &ztv->state);
 
 	zoran_common_close(ztv);
+	file->private_data = NULL;
 
         /*
          *      This is sucky but right now I can't find a good way to
@@ -831,6 +881,13 @@
 		kfree( ztv->overinfo.overlay );
 	ztv->overinfo.overlay = 0;
 
+	module_put(THIS_MODULE);
+	if (ztv->have_decoder)
+		module_put(ztv->decoder->driver->owner);
+	if (ztv->have_tuner)
+		module_put(ztv->tuner->driver->owner);
+
+	return 0;
 }
 
 /*
@@ -841,13 +898,15 @@
  * be released as soon as possible to prevent lock contention.
  */
 static
-long zoran_read(struct video_device* dev, char* buf, unsigned long count, int nonblock)
+ssize_t zoran_read(struct file* file, char* buf, size_t count, loff_t* ppos)
 {
-	struct zoran *ztv = (struct zoran*)dev;
+	struct zoran *ztv = file->private_data;
 	unsigned long max;
 	struct vidinfo* unused = 0;
 	struct vidinfo* done = 0;
+	int nonblock = file->f_flags & O_NONBLOCK;
 
+	UNUSED(ppos);
 	DEBUG(printk(CARD_DEBUG "zoran_read(%p,%ld,%d)\n",CARD,buf,count,nonblock));
 
 	/* find ourself a free or completed buffer */
@@ -935,18 +994,18 @@
 }
 
 static
-long zoran_write(struct video_device* dev, const char* buf, unsigned long count, int nonblock)
+ssize_t zoran_write(struct file* file, const char* data, size_t count, loff_t* ppos)
 {
-	struct zoran *ztv = (struct zoran *)dev;
-	UNUSED(ztv); UNUSED(dev); UNUSED(buf); UNUSED(count); UNUSED(nonblock);
+	struct zoran *ztv = file->private_data;
+	UNUSED(ztv); UNUSED(data); UNUSED(count); UNUSED(ppos);
 	DEBUG(printk(CARD_DEBUG "zoran_write\n",CARD));
 	return -EINVAL;
 }
 
 static
-unsigned int zoran_poll(struct video_device *dev, struct file *file, poll_table *wait)
+unsigned int zoran_poll(struct file* file, poll_table* wait)
 {
-	struct zoran *ztv = (struct zoran *)dev;
+	struct zoran *ztv = file->private_data;
 	struct vidinfo* item;
 	unsigned int mask = 0;
 
@@ -976,9 +1035,11 @@
 }
 
 static
-int zoran_ioctl(struct video_device* dev, unsigned int cmd, void *arg)
+int zoran_do_ioctl(struct inode* inode, struct file* file, unsigned int cmd, void* arg)
 {
-	struct zoran* ztv = (struct zoran*)dev;
+	struct zoran *ztv = file->private_data;
+
+	UNUSED(inode);
 
 	switch (cmd) {
 	 case VIDIOCGCAP:
@@ -986,7 +1047,7 @@
 		struct video_capability c;
 		DEBUG(printk(CARD_DEBUG "VIDIOCGCAP\n",CARD));
 
-		strcpy(c.name,ztv->video_dev.name);
+		strcpy(c.name,ztv->video_dev->name);
 		c.type = VID_TYPE_CAPTURE|
 			 VID_TYPE_OVERLAY|
 			 VID_TYPE_CLIPPING|
@@ -1161,7 +1222,7 @@
 		write_unlock_irq(&ztv->lock);
 
 		/* tell the decoder */
-		i2c_control_device(&ztv->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_SET_PICTURE, &p);
+		zoran_i2c_command(ztv, DECODER_SET_PICTURE, &p);
 		break;
 	 }
 
@@ -1408,8 +1469,8 @@
 	 {
 		struct video_unit vu;
 		DEBUG(printk(CARD_DEBUG "VIDIOCGUNIT\n",CARD));
-		vu.video = ztv->video_dev.minor;
-		vu.vbi = ztv->vbi_dev.minor;
+		vu.video = ztv->video_dev->minor;
+		vu.vbi = ztv->vbi_dev->minor;
 		vu.radio = VIDEO_NO_UNIT;
 		vu.audio = VIDEO_NO_UNIT;
 		vu.teletext = VIDEO_NO_UNIT;
@@ -1435,7 +1496,7 @@
 
 		if (ztv->have_tuner) {
 			int fixme = v;
-			if (i2c_control_device(&(ztv->i2c), I2C_DRIVERID_TUNER, TUNER_SET_TVFREQ, &fixme) < 0)
+			if (zoran_i2c_tuner_command(ztv, TUNER_SET_TVFREQ, &fixme) < 0)
 				return -EAGAIN;
 		}
 		ztv->tuner_freq = v;
@@ -1461,10 +1522,18 @@
 }
 
 static
-int zoran_mmap(struct vm_area_struct *vma, struct video_device* dev, const char* adr, unsigned long size)
+int zoran_ioctl (struct inode* inode, struct file* file, unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, zoran_do_ioctl);
+}
+
+
+static
+int zoran_mmap (struct file* file, struct vm_area_struct* vma)
 {
-	struct zoran* ztv = (struct zoran*)dev;
-	unsigned long start = (unsigned long)adr;
+	struct zoran *ztv = file->private_data;
+	unsigned long size = (vma->vm_end - vma->vm_start);
+	unsigned long start = vma->vm_start;
 	unsigned long pos;
 
 	DEBUG(printk(CARD_DEBUG "zoran_mmap(0x%p,%ld)\n",CARD,adr,size));
@@ -1486,27 +1555,55 @@
 	return 0;
 }
 
-static struct video_device zr36120_template=
+static
+void zoran_vdev_release(struct video_device* vdev)
 {
+        kfree(vdev);
+}
+
+static struct file_operations zoran_fops = {
 	.owner		= THIS_MODULE,
-	.name		= "UNSET",
-	.type		= VID_TYPE_TUNER|VID_TYPE_CAPTURE|VID_TYPE_OVERLAY,
-	.hardware	= VID_HARDWARE_ZR36120,
 	.open		= zoran_open,
-	.close		= zoran_close,
+	.release	= zoran_close,
+	.ioctl		= zoran_ioctl,
+	.llseek		= no_llseek,
 	.read		= zoran_read,
 	.write		= zoran_write,
-	.poll		= zoran_poll,
-	.ioctl		= zoran_ioctl,
 	.mmap		= zoran_mmap,
+	.poll		= zoran_poll,
+};
+
+static struct video_device zr36120_template=
+{
+	.owner		= THIS_MODULE,
+	.name		= "UNSET",
+	.type		= VID_TYPE_TUNER|VID_TYPE_CAPTURE|VID_TYPE_OVERLAY,
+	.hardware	= VID_HARDWARE_ZR36120,
+	.fops		= &zoran_fops,
+	.release	= zoran_vdev_release,
 	.minor		= -1,
 };
 
 static
-int vbi_open(struct video_device *dev, int flags)
+int vbi_open(struct inode* inode, struct file* file)
 {
-	struct zoran *ztv = (struct zoran*)dev->priv;
+	unsigned int minor = minor(inode->i_rdev);
+	struct zoran *ztv = NULL;
 	struct vidinfo* item;
+	int i;
+
+	if (!try_module_get(THIS_MODULE)) {
+		printk(KERN_ERR "failed to acquire lock on myself\n");
+		return -EIO;
+	}
+
+	/* find the device */
+	for (i = 0; i < zoran_cards; i++) {
+		if (zorans[i].video_dev->minor == minor) {
+			ztv = &zorans[i];
+			break;
+		}
+	}
 
 	DEBUG(printk(CARD_DEBUG "vbi_open(dev,%d)\n",CARD,flags));
 
@@ -1533,6 +1630,7 @@
 					item->memadr = 0;
 					item->busadr = 0;
 				}
+				module_put(THIS_MODULE);
 				return -ENOBUFS;
 			}
 		}
@@ -1542,7 +1640,7 @@
 	}
 
 	/* do the common part of all open's */
-	zoran_common_open(ztv, flags);
+	zoran_common_open(ztv, file->f_flags);
 
 	set_bit(STATE_VBI, &ztv->state);
 	/* start read-ahead */
@@ -1552,11 +1650,12 @@
 }
 
 static
-void vbi_close(struct video_device *dev)
+int vbi_close(struct inode* inode, struct file* file)
 {
-	struct zoran *ztv = (struct zoran*)dev->priv;
+	struct zoran *ztv = file->private_data;
 	struct vidinfo* item;
 
+	UNUSED(inode);
 	DEBUG(printk(CARD_DEBUG "vbi_close(dev)\n",CARD));
 
 	/* driver specific closure */
@@ -1579,6 +1678,9 @@
 		item->memadr = 0;
 	}
 
+	module_put(THIS_MODULE);
+
+	return 0;
 }
 
 /*
@@ -1589,13 +1691,15 @@
  * be released as soon as possible to prevent lock contention.
  */
 static
-long vbi_read(struct video_device* dev, char* buf, unsigned long count, int nonblock)
+ssize_t vbi_read(struct file* file, char* buf, size_t count, loff_t* ppos)
 {
-	struct zoran *ztv = (struct zoran*)dev->priv;
+	struct zoran *ztv = file->private_data;
 	unsigned long max;
 	struct vidinfo* unused = 0;
 	struct vidinfo* done = 0;
+	int nonblock = file->f_flags & O_NONBLOCK;
 
+	UNUSED(ppos);
 	DEBUG(printk(CARD_DEBUG "vbi_read(0x%p,%ld,%d)\n",CARD,buf,count,nonblock));
 
 	/* find ourself a free or completed buffer */
@@ -1675,6 +1779,7 @@
 	{
 	unsigned char* optr = buf;
 	unsigned char* eptr = buf+count;
+	unsigned long* lptr = --((unsigned long*)eptr);
 
 	/* are we beeing accessed from an old driver? */
 	if (count == 2*19*2048) {
@@ -1727,7 +1832,7 @@
 	/* API compliance:
 	 * place the framenumber (half fieldnr) in the last long
 	 */
-	__put_user(done->fieldnr/2, ((ulong*)eptr)[-1]);
+	__put_user(done->fieldnr/2, lptr);
 	}
 
 	/* keep the engine running */
@@ -1744,9 +1849,9 @@
 }
 
 static
-unsigned int vbi_poll(struct video_device *dev, struct file *file, poll_table *wait)
+unsigned int vbi_poll(struct file* file, poll_table* wait)
 {
-	struct zoran *ztv = (struct zoran*)dev->priv;
+	struct zoran *ztv = file->private_data;
 	struct vidinfo* item;
 	unsigned int mask = 0;
 
@@ -1765,9 +1870,11 @@
 }
 
 static
-int vbi_ioctl(struct video_device *dev, unsigned int cmd, void *arg)
+int vbi_do_ioctl(struct inode* inode, struct file* file, unsigned int cmd, void* arg)
 {
-	struct zoran* ztv = (struct zoran*)dev->priv;
+	struct zoran *ztv = file->private_data;
+
+	UNUSED(inode);
 
 	switch (cmd) {
 	 case VIDIOCGVBIFMT:
@@ -1820,18 +1927,33 @@
 	return 0;
 }
 
-static struct video_device vbi_template=
+static
+int vbi_ioctl(struct inode* inode, struct file* file, unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, vbi_do_ioctl);
+}
+
+
+static struct file_operations vbi_fops =
 {
 	.owner		= THIS_MODULE,
-	.name		= "UNSET",
-	.type		= VID_TYPE_CAPTURE|VID_TYPE_TELETEXT,
-	.hardware	= VID_HARDWARE_ZR36120,
 	.open		= vbi_open,
-	.close		= vbi_close,
+	.release	= vbi_close,
 	.read		= vbi_read,
 	.write		= zoran_write,
+	.llseek		= no_llseek,
 	.poll		= vbi_poll,
 	.ioctl		= vbi_ioctl,
+};
+
+static struct video_device vbi_template=
+{
+	.owner		= THIS_MODULE,
+	.name		= "UNSET",
+	.type		= VID_TYPE_CAPTURE|VID_TYPE_TELETEXT,
+	.hardware	= VID_HARDWARE_ZR36120,
+	.fops		= &vbi_fops,
+	.release	= zoran_vdev_release,
 	.minor		= -1,
 };
 
@@ -1895,6 +2017,7 @@
 {
 	struct zoran *ztv = &zorans[card];
 	int	i;
+	void* alloc_mem1, * alloc_mem2;
 
 	/* if the given cardtype valid? */
 	if (cardtype[card]>=NRTVCARDS) {
@@ -1902,6 +2025,14 @@
 		return -1;
 	}
 
+	if (!(alloc_mem1 = kmalloc(sizeof(struct video_device), GFP_KERNEL)) ||
+	    !(alloc_mem2 = kmalloc(sizeof(struct video_device), GFP_KERNEL))) {
+		printk(KERN_ERR "failed to kmalloc data for video_device entries\n");
+		if (alloc_mem1)
+			kfree(alloc_mem1);
+		return -1;
+	}
+
 	/* reset the zoran */
 	zrand(~ZORAN_PCI_SOFTRESET,ZORAN_PCI);
 	udelay(10);
@@ -1984,34 +2115,35 @@
 	zrwrite(~0, ZORAN_ISR);
 
 	/*
-	 * i2c template
-	 */
-	ztv->i2c = zoran_i2c_bus_template;
-	sprintf(ztv->i2c.name,"zoran-%d",card);
-	ztv->i2c.data = ztv;
-
-	/*
 	 * Now add the template and register the device unit
 	 */
-	ztv->video_dev = zr36120_template;
-	strcpy(ztv->video_dev.name, ztv->i2c.name);
-	ztv->video_dev.priv = ztv;
-	if (video_register_device(&ztv->video_dev, VFL_TYPE_GRABBER, video_nr) < 0)
+	ztv->video_dev = alloc_mem1;
+	memcpy(ztv->video_dev, &zr36120_template, sizeof(struct video_device));
+	strcpy(ztv->video_dev->name, ztv->i2c_adapter.name);
+	ztv->video_dev->priv = ztv;
+	if (video_register_device(ztv->video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
+		kfree(alloc_mem1);
+		kfree(alloc_mem2);
 		return -1;
+	}
 
-	ztv->vbi_dev = vbi_template;
-	strcpy(ztv->vbi_dev.name, ztv->i2c.name);
-	ztv->vbi_dev.priv = ztv;
-	if (video_register_device(&ztv->vbi_dev, VFL_TYPE_VBI, vbi_nr) < 0) {
-		video_unregister_device(&ztv->video_dev);
+	ztv->vbi_dev = alloc_mem2;
+	memcpy(ztv->vbi_dev, &vbi_template, sizeof(struct video_device));
+	strcpy(ztv->vbi_dev->name, ztv->i2c_adapter.name);
+	ztv->vbi_dev->priv = ztv;
+	if (video_register_device(ztv->vbi_dev, VFL_TYPE_VBI, vbi_nr) < 0) {
+		video_unregister_device(ztv->video_dev);
+		kfree(alloc_mem1);
+		kfree(alloc_mem2);
 		return -1;
 	}
-	i2c_register_bus(&ztv->i2c);
+	ztv->i2cbr = 0;
+	zoran_i2c_load(ztv);
 
 	/* set interrupt mask - the PIN enable will be set later */
 	zrwrite(ZORAN_ICR_GIRQ0|ZORAN_ICR_GIRQ1|ZORAN_ICR_CODE, ZORAN_ICR);
 
-	printk(KERN_INFO "%s: installed %s\n",ztv->i2c.name,ztv->card->name);
+	printk(KERN_INFO "%s: installed %s\n",ztv->i2c_adapter.name,ztv->card->name);
 	return 0;
 }
 
@@ -2040,14 +2172,14 @@
 		free_irq(ztv->dev->irq,ztv);
  
     		/* unregister i2c_bus */
-		i2c_unregister_bus((&ztv->i2c));
+		zoran_i2c_unload(ztv);
 
 		/* unmap and free memory */
 		if (ztv->zoran_mem)
 			iounmap(ztv->zoran_mem);
 
-		video_unregister_device(&ztv->video_dev);
-		video_unregister_device(&ztv->vbi_dev);
+		video_unregister_device(ztv->video_dev);
+		video_unregister_device(ztv->vbi_dev);
 	}
 }
 
--- linux-2.6.0-test4/drivers/media/video/zr36120-old/zr36120.h	2003-09-25 12:21:18.000000000 +0200
+++ linux-2.6.0-test4/drivers/media/video/zr36120.h	2003-09-25 16:43:44.000000000 +0200
@@ -26,7 +26,8 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
-#include <linux/i2c-old.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
 #include <linux/videodev.h>
 
 #include <asm/io.h>
@@ -39,9 +40,6 @@
 #define IDEBUG(x...)			/* Debug interrupt handler */
 #define PDEBUG		0		/* Debug PCI writes */
 
-/* defined in zr36120_i2c */
-extern struct i2c_bus zoran_i2c_bus_template;
-
 #define	ZORAN_MAX_FBUFFERS	2
 #define	ZORAN_MAX_FBUFFER	(768*576*2)
 #define	ZORAN_MAX_FBUFSIZE	(ZORAN_MAX_FBUFFERS*ZORAN_MAX_FBUFFER)
@@ -91,14 +89,19 @@
 
 struct zoran 
 {
-	struct video_device video_dev;
+	struct video_device* video_dev;
 #define CARD_DEBUG	KERN_DEBUG "%s(%lu): "
 #define CARD_INFO	KERN_INFO "%s(%lu): "
 #define CARD_ERR	KERN_ERR "%s(%lu): "
-#define CARD		ztv->video_dev.name,ztv->fieldnr
+#define CARD		ztv->video_dev->name,ztv->fieldnr
 
 	/* zoran chip specific details */
-	struct i2c_bus	i2c;		/* i2c registration data	*/
+	struct i2c_adapter i2c_adapter;	/* i2c registration data	*/
+	struct i2c_algo_bit_data
+			i2c_algo; 	/* i2c bit-banging algorithm	*/
+	unsigned int	i2cbr;		/* i2c state cache		*/
+	struct i2c_client* decoder,
+			 * tuner;	/* pointer to the decoder+tuner	*/
 	struct pci_dev*	dev;		/* ptr to PCI device		*/
 	ulong		zoran_adr;	/* bus address of IO memory	*/
 	char*		zoran_mem;	/* kernel address of IO memory	*/
@@ -119,7 +122,7 @@
 	wait_queue_head_t grabq;	/* grabbers queue		*/
 
 	/* VBI details */
-	struct video_device vbi_dev;
+	struct video_device *vbi_dev;
 	struct vidinfo	readinfo[2];	/* VBI data - flip buffers	*/
 	wait_queue_head_t vbiq;		/* vbi queue			*/
 
@@ -143,6 +146,12 @@
 	uint		vidHeight;	/* calculated */
 };
 
+/* defined in zr36120_i2c */
+extern int	zoran_i2c_load		(struct zoran *ztv);
+extern void	zoran_i2c_unload	(struct zoran *ztv);
+extern int	zoran_i2c_command	(struct zoran *ztv, int cmd, void *data);
+extern int	zoran_i2c_tuner_command	(struct zoran *ztv, int cmd, void *data);
+
 #define zrwrite(dat,adr)    writel((dat),(char *) (ztv->zoran_mem+(adr)))
 #define zrread(adr)         readl(ztv->zoran_mem+(adr))
 
--- linux-2.6.0-test4/drivers/media/video/zr36120-old/zr36120_i2c.c	2003-09-25 12:21:18.000000000 +0200
+++ linux-2.6.0-test4/drivers/media/video/zr36120_i2c.c	2003-09-25 17:30:03.000000000 +0200
@@ -26,8 +26,8 @@
 #include <linux/video_decoder.h>
 #include <asm/uaccess.h>
 
-#include "tuner.h"
 #include "zr36120.h"
+#include <media/tuner.h>
 
 /* ----------------------------------------------------------------------- */
 /* I2C functions							   */
@@ -37,37 +37,60 @@
 
 #define I2C_DELAY   10
 
-static void i2c_setlines(struct i2c_bus *bus,int ctrl,int data)
+/* software I2C functions */
+static int zoran_i2c_getsda (void* data)
+{
+	struct zoran* ztv = (struct zoran*)data;
+	return zrread(ZORAN_I2C) & (ztv->card->swapi2c ? ZORAN_I2C_SCL : ZORAN_I2C_SDA);
+}
+
+static
+int zoran_i2c_getscl (void* data)
+{
+	struct zoran* ztv = (struct zoran*)data;
+	return zrread(ZORAN_I2C) & (ztv->card->swapi2c ? ZORAN_I2C_SDA : ZORAN_I2C_SCL);
+}
+
+static
+void zoran_i2c_setsda (void* data, int state)
+{
+	struct zoran* ztv = (struct zoran*)data;
+	if (state)
+		ztv->i2cbr |= (ztv->card->swapi2c ? ZORAN_I2C_SCL : ZORAN_I2C_SDA);
+	else
+		ztv->i2cbr &= ~(ztv->card->swapi2c ? ZORAN_I2C_SCL : ZORAN_I2C_SDA);
+	zrwrite(ztv->i2cbr, ZORAN_I2C);
+}
+
+static
+void zoran_i2c_setscl (void* data, int state)
 {
-	struct zoran *ztv = (struct zoran*)bus->data;
-	unsigned int b = 0;
-	if (data) b |= ztv->card->swapi2c ? ZORAN_I2C_SCL : ZORAN_I2C_SDA;
-	if (ctrl) b |= ztv->card->swapi2c ? ZORAN_I2C_SDA : ZORAN_I2C_SCL;
-	zrwrite(b, ZORAN_I2C);
-	udelay(I2C_DELAY);
-}
-
-static int i2c_getdataline(struct i2c_bus *bus)
-{
-	struct zoran *ztv = (struct zoran*)bus->data;
-	if (ztv->card->swapi2c)
-		return zrread(ZORAN_I2C) & ZORAN_I2C_SCL;
-	return zrread(ZORAN_I2C) & ZORAN_I2C_SDA;
+	struct zoran* ztv = (struct zoran*)data;
+	if (state)
+		ztv->i2cbr |= (ztv->card->swapi2c ? ZORAN_I2C_SDA : ZORAN_I2C_SCL);
+	else
+		ztv->i2cbr &= ~(ztv->card->swapi2c ? ZORAN_I2C_SDA : ZORAN_I2C_SCL);
+	zrwrite(ztv->i2cbr, ZORAN_I2C);
 }
 
 static
-void attach_inform(struct i2c_bus *bus, int id)
+int attach_inform(struct i2c_client* client)
 {
-	struct zoran *ztv = (struct zoran*)bus->data;
+	struct zoran* ztv = (struct zoran*)i2c_get_adapdata(client->adapter);
 	struct video_decoder_capability dc;
 	int rv;
 
-	switch (id) {
-	 case I2C_DRIVERID_VIDEODECODER:
+	if (ztv->users > 0) {
+		printk(KERN_ERR "cannot connect i2c devices while running\n");
+		return -EBUSY;
+	}
+
+	switch (client->driver->id) {
+	 case I2C_DRIVERID_SAA7110:
 		DEBUG(printk(CARD_INFO "decoder attached\n",CARD));
 
 		/* fetch the capabilites of the decoder */
-		rv = i2c_control_device(&ztv->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_GET_CAPABILITIES, &dc);
+		rv = zoran_i2c_command(ztv, DECODER_GET_CAPABILITIES, &dc);
 		if (rv) {
 			DEBUG(printk(CARD_DEBUG "decoder is not V4L aware!\n",CARD));
 			break;
@@ -85,23 +108,25 @@
 		DEBUG(printk(CARD_INFO "tuner attached\n",CARD));
 		if (ztv->tuner_type >= 0)
 		{
-			if (i2c_control_device(&ztv->i2c,I2C_DRIVERID_TUNER,TUNER_SET_TYPE,&ztv->tuner_type)<0)
+			if (zoran_i2c_tuner_command(ztv ,TUNER_SET_TYPE,&ztv->tuner_type)<0)
 			DEBUG(printk(CARD_INFO "attach_inform; tuner won't be set to type %d\n",CARD,ztv->tuner_type));
 		}
 		break;
 	 default:
 		DEBUG(printk(CARD_INFO "attach_inform; unknown device id=%d\n",CARD,id));
-		break;
+		return -1;
 	}
+
+	return 0;
 }
 
 static
-void detach_inform(struct i2c_bus *bus, int id)
+int detach_inform(struct i2c_client* client)
 {
-	struct zoran *ztv = (struct zoran*)bus->data;
+	struct zoran *ztv = (struct zoran*)i2c_get_adapdata(client->adapter);
 
-	switch (id) {
-	 case I2C_DRIVERID_VIDEODECODER:
+	switch (client->driver->id) {
+	 case I2C_DRIVERID_SAA7110:
 		ztv->have_decoder = 0;
 		DEBUG(printk(CARD_INFO "decoder detached\n",CARD));
 		break;
@@ -113,21 +138,57 @@
 		DEBUG(printk(CARD_INFO "detach_inform; unknown device id=%d\n",CARD,id));
 		break;
 	}
+
+	return 0;
+}
+
+static struct i2c_algo_bit_data zoran_i2c_bit_data_template = {
+	.setsda = zoran_i2c_setsda,
+	.setscl = zoran_i2c_setscl,
+	.getsda = zoran_i2c_getsda,
+	.getscl = zoran_i2c_getscl,
+	.udelay = I2C_DELAY,
+	.mdelay = 0,
+	.timeout = 100,
+};
+
+static struct i2c_adapter zoran_i2c_adapter_template = {
+	.name = "ZR36120",
+	.id = I2C_HW_B_ZR36120,
+	.algo = NULL,
+	.client_register = attach_inform,
+	.client_unregister = detach_inform,
+};
+
+int zoran_i2c_load (struct zoran *ztv)
+{
+	memcpy(&ztv->i2c_algo, &zoran_i2c_bit_data_template,
+	       sizeof(struct i2c_algo_bit_data));
+	ztv->i2c_algo.data = ztv;
+	memcpy(&ztv->i2c_adapter, &zoran_i2c_adapter_template,
+	       sizeof(struct i2c_adapter));
+	i2c_set_adapdata(&ztv->i2c_adapter, ztv);
+	ztv->i2c_adapter.algo_data = &ztv->i2c_algo;
+	return i2c_bit_add_bus(&ztv->i2c_adapter);
+}
+
+void zoran_i2c_unload (struct zoran *ztv)
+{
+	i2c_bit_del_bus(&ztv->i2c_adapter);
 }
 
-struct i2c_bus zoran_i2c_bus_template =
+int zoran_i2c_command (struct zoran *ztv, int cmd, void *data)
 {
-	"ZR36120",
-	I2C_BUSID_ZORAN,
-	NULL,
+	if (!ztv->decoder)
+		return -EIO;
 
-	SPIN_LOCK_UNLOCKED,
+	return ztv->decoder->driver->command(ztv->decoder, cmd, data);
+}
 
-	attach_inform,
-	detach_inform,
+int zoran_i2c_tuner_command (struct zoran *ztv, int cmd, void *data)
+{
+	if (!ztv->tuner)
+		return -EIO;
 
-	i2c_setlines,
-	i2c_getdataline,
-	NULL,
-	NULL
-};
+	return ztv->tuner->driver->command(ztv->tuner, cmd, data);
+}

--=-JRcRE5dMZm9C6P9JcFXc--

