Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTEFQPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTEFQOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:14:47 -0400
Received: from mail.convergence.de ([212.84.236.4]:5833 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263924AbTEFQN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:13:57 -0400
Message-ID: <3EB7DA90.6080406@convergence.de>
Date: Tue, 06 May 2003 17:53:52 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][2-11] update the generic saa7146 driver 
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020604060603010509030304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020604060603010509030304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch updates the generic saa7146 driver.

Fixed problems:
- remove some #if LINUX_VERSION_CODE constructions
- sync with the interrupt handler changes in 2.5.69
- add a missing kfree() call which caused the kernel to
   leak 32kB of kmalloc()ed memory. iieek!
- fixed the capture code to handle cards that have swapped
   fields
- added and fixed some debug messages

I know that I introduced some new #if LINUX_VERSION_CODE constructions. 
This is bad and the linuxtv.org team knows it. But most users compile 
and test the drivers under 2.4 so we have to keep the driver to compile 
with 2.4, too.

Please review and apply.

Thanks
Michael Hunold.



--------------020604060603010509030304
Content-Type: text/plain;
 name="02-saa7146-core.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-saa7146-core.diff"

diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/common/saa7146_core.c linux-2.5.69.patch/drivers/media/common/saa7146_core.c
--- linux-2.5.69/drivers/media/common/saa7146_core.c	2003-05-06 13:16:20.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/common/saa7146_core.c	2003-05-06 12:20:34.000000000 +0200
@@ -20,10 +20,6 @@
 
 #include <media/saa7146.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#define KBUILD_MODNAME saa7146
-#endif
-
 /* global variables */
 struct list_head saa7146_devices;
 struct semaphore saa7146_devices_lock;
@@ -191,8 +187,11 @@
 
 /********************************************************************************/
 /* interrupt handler */
-
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+static void interrupt_hw(int irq, void *dev_id, struct pt_regs *regs)
+#else
 static irqreturn_t interrupt_hw(int irq, void *dev_id, struct pt_regs *regs)
+#endif
 {
 	struct saa7146_dev *dev = (struct saa7146_dev*)dev_id;
 	u32 isr = 0;
@@ -203,11 +202,14 @@
 	/* is this our interrupt? */
 	if ( 0 == isr ) {
 		/* nope, some other device */
-		return IRQ_NONE;
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0)
+		return IRQ_RETVAL(0);
+#else
+		return;
+#endif
 	}
 
 	saa7146_write(dev, ISR, isr);
-//	DEB_INT(("0x%08x\n",isr));
 
 	if( 0 != (dev->ext)) {
 		if( 0 != (dev->ext->irq_mask & isr )) {
@@ -254,7 +256,9 @@
 		ERR(("disabling interrupt source(s)!\n"));
 		IER_DISABLE(dev,isr);
 	}
-	return IRQ_HANDLED;
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0)
+	return IRQ_RETVAL(1);
+#endif
 }
 
 /*********************************************************************************/
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/common/saa7146_fops.c linux-2.5.69.patch/drivers/media/common/saa7146_fops.c
--- linux-2.5.69/drivers/media/common/saa7146_fops.c	2003-05-06 13:15:30.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/common/saa7146_fops.c	2003-05-05 13:20:54.000000000 +0200
@@ -1,9 +1,5 @@
 #include <media/saa7146_vv.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#define KBUILD_MODNAME saa7146
-#endif
-
 #define BOARD_CAN_DO_VBI(dev)   (dev->revision != 0 && dev->vv_data->vbi_minor != -1) 
 
 /********************************************************************************/
@@ -416,6 +412,7 @@
 
 	DEB_EE(("dev:%p\n",dev));
  
+ 	kfree(vv->clipping);
  	kfree(vv);
 	dev->vv_data = NULL;
 	dev->vv_callback = NULL;
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/common/saa7146_hlp.c linux-2.5.69.patch/drivers/media/common/saa7146_hlp.c
--- linux-2.5.69/drivers/media/common/saa7146_hlp.c	2003-05-06 13:15:30.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/common/saa7146_hlp.c	2003-04-22 18:30:31.000000000 +0200
@@ -1,9 +1,5 @@
 #include <media/saa7146_vv.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#define KBUILD_MODNAME saa7146
-#endif
-
 #define my_min(type,x,y) \
 	({ type __x = (x), __y = (y); __x < __y ? __x: __y; })
 #define my_max(type,x,y) \
@@ -962,6 +958,12 @@
 	unsigned long e_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_E_FID_A : CMD_E_FID_B;
 	unsigned long o_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_O_FID_A : CMD_O_FID_B;
 
+	if( 0 != (dev->ext->ext_vv_data->flags & SAA7146_EXT_SWAP_ODD_EVEN)) {
+		unsigned long tmp = e_wait;
+		e_wait = o_wait;
+		o_wait = tmp;
+	}
+
 	/* write beginning of rps-program */
 	count = 0;
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/common/saa7146_i2c.c linux-2.5.69.patch/drivers/media/common/saa7146_i2c.c
--- linux-2.5.69/drivers/media/common/saa7146_i2c.c	2003-05-06 13:15:30.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/common/saa7146_i2c.c	2003-04-25 11:17:47.000000000 +0200
@@ -1,9 +1,5 @@
 #include <media/saa7146_vv.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#define KBUILD_MODNAME saa7146
-#endif
-
 /* helper function */
 static
 void my_wait(struct saa7146_dev *dev, long ms)
@@ -382,7 +378,9 @@
 {
 	struct saa7146_dev* dev = i2c_get_adapdata(adapter);
 	
-	DEB_I2C(("adapter: '%s'.\n", adapter->dev.name));
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+	DEB_I2C(("adapter: '%s'.\n", adapter->name));
+#endif
 	
 	/* use helper function to transfer data */
 	return saa7146_i2c_transfer(dev, msg, num, adapter->retries);
@@ -411,8 +409,13 @@
 
 	if( NULL != i2c_adapter ) {
 		memset(i2c_adapter,0,sizeof(struct i2c_adapter));
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+		strcpy(i2c_adapter->name, dev->name);	
+		i2c_adapter->data	   = dev;
+#else
 		strcpy(i2c_adapter->dev.name, dev->name);	
 		i2c_set_adapdata(i2c_adapter,dev);
+#endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
 		i2c_adapter->id 	   = I2C_ALGO_SAA7146;
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/common/saa7146_vbi.c linux-2.5.69.patch/drivers/media/common/saa7146_vbi.c
--- linux-2.5.69/drivers/media/common/saa7146_vbi.c	2003-05-06 13:15:30.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/common/saa7146_vbi.c	2003-04-22 18:30:31.000000000 +0200
@@ -1,9 +1,5 @@
 #include <media/saa7146_vv.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#define KBUILD_MODNAME saa7146
-#endif
-
 static int vbi_pixel_to_capture = 720 * 2;
 
 static
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/common/saa7146_video.c linux-2.5.69.patch/drivers/media/common/saa7146_video.c
--- linux-2.5.69/drivers/media/common/saa7146_video.c	2003-05-06 13:15:30.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/common/saa7146_video.c	2003-04-22 18:30:31.000000000 +0200
@@ -1,9 +1,5 @@
 #include <media/saa7146_vv.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#define KBUILD_MODNAME saa7146
-#endif
-
 static
 int memory = 32;
 
@@ -434,20 +430,25 @@
 	case V4L2_CID_BRIGHTNESS:
 		value = saa7146_read(dev, BCS_CTRL);
 		c->value = 0xff & (value >> 24);
+		DEB_D(("V4L2_CID_BRIGHTNESS: %d\n",c->value));
 		break;
 	case V4L2_CID_CONTRAST:
 		value = saa7146_read(dev, BCS_CTRL);
 		c->value = 0x7f & (value >> 16);
+		DEB_D(("V4L2_CID_CONTRAST: %d\n",c->value));
 		break;
 	case V4L2_CID_SATURATION:
 		value = saa7146_read(dev, BCS_CTRL);
 		c->value = 0x7f & (value >> 0);
+		DEB_D(("V4L2_CID_SATURATION: %d\n",c->value));
 		break;
 	case V4L2_CID_VFLIP:
 		c->value = vv->vflip;
+		DEB_D(("V4L2_CID_VFLIP: %d\n",c->value));
 		break;
 	case V4L2_CID_HFLIP:
 		c->value = vv->hflip;
+		DEB_D(("V4L2_CID_HFLIP: %d\n",c->value));
 		break;
 	default:
 		return -EINVAL;
@@ -876,7 +877,7 @@
 			return -EINVAL;	
 		}
 
-		DEB_EE(("VIDIOC_ENUMSTD: type:%d, index:%d\n",f->type,f->index));
+		DEB_EE(("VIDIOC_ENUM_FMT: type:%d, index:%d\n",f->type,f->index));
 		return 0;
 	}
 	case VIDIOC_QUERYCTRL:
@@ -974,6 +975,8 @@
 		
 		struct saa7146_fh *ov_fh = NULL;
 						
+		DEB_EE(("VIDIOC_S_STD\n"));
+
 		if( 0 != vv->streaming ) {
 			return -EBUSY;
 		}

--------------020604060603010509030304--


