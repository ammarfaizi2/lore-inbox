Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268807AbUIQOml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268807AbUIQOml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUIQOml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:42:41 -0400
Received: from mail.convergence.de ([212.227.36.84]:56223 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268807AbUIQO2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:28:40 -0400
Message-ID: <414AF461.4050707@linuxtv.org>
Date: Fri, 17 Sep 2004 16:27:45 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][4/14] dvb core update
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org>
In-Reply-To: <414AF41A.6060009@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------050708090004060102070404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050708090004060102070404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------050708090004060102070404
Content-Type: text/plain;
 name="04-DVB-dvb-core-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-DVB-dvb-core-update.diff"

- [DVB] remove non-linux compatibility stuff from dvb_functions. rest in peace.
- [DVB] remove home-brewn dvb-i2c stuff. rest in peace.
- [DVB] convert MODULE_PARM() to module_param()
- [DVB] convert dvb_delay() to mdelay()
- [DVB] convert C++ comments to C comments
- [DVB] dvb_ca_en50221: fix for matrix CAMs from Sjoerd Simons, use c99 initializers, Fix for aston CAM read timeout problems, Moved CAM CTRL IF reset to a better place, better debugging with multiple cards (Sjoerd Simons)
- [DVB] dvb-frontend: patch by Wolfgang Fritz: suppress spurious events during tuning,  Do not allow write (and related) ioctls when frontend is opened RDONLY, Properly lock the frontend module on open/close, patch by Christopher Pascoe: remove bogus up(fe->sem) on fe thread exit, patch by Christopher Pascoe: remove bogus up(fe->sem) on fe thread exit
- [DVB] dvb-demux: using spin_lock instead of spin_lock_irq caused a race condition between irq/tasklet and user space task
- [DVB] dvb-core: add sysfs/udev support using "class_simple", prevent Oops when PES filter is set with invalid pes_type, protect feed_list with spin_locks

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dmxdev.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dmxdev.c
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dmxdev.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dmxdev.c	2004-08-18 19:52:17.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/poll.h>
 #include <linux/ioctl.h>
@@ -33,10 +34,11 @@
 #include <asm/system.h>
 
 #include "dmxdev.h"
-#include "dvb_functions.h"
 
-MODULE_PARM(debug,"i");
-static int debug = 0;
+static int debug;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off debugging (default:off).");
 
 #define dprintk	if (debug) printk
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-08-18 19:52:17.000000000 +0200
@@ -32,16 +32,20 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
-#include <asm/semaphore.h>
+#include <asm/rwsem.h>
 #include <asm/atomic.h>
 
 #include "dvb_ca_en50221.h"
-#include "dvb_functions.h"
 #include "dvb_ringbuffer.h"
 
-static int dvb_ca_en50221_debug = 0;
+static int dvb_ca_en50221_debug;
+
+module_param_named(cam_debug, dvb_ca_en50221_debug, int, 0644);
+MODULE_PARM_DESC(dvb_ca_en50221_debug, "enable verbose debug messages");
+
 #define dprintk if (dvb_ca_en50221_debug) printk
 
 #define INIT_TIMEOUT_SECS 5
@@ -108,7 +112,7 @@
         int link_buf_size;
 
         /* semaphore for syncing access to slot structure */
-        struct semaphore sem;
+        struct rw_semaphore sem;
 
         /* buffer for incoming packets */
         struct dvb_ringbuffer rx_buffer;
@@ -199,7 +203,6 @@
 static int dvb_ca_en50221_check_camstatus(struct dvb_ca_private* ca, int slot)
 {
         int slot_status;
-        int status;
         int cam_present_now;
         int cam_changed;
 
@@ -209,9 +212,7 @@
         }
 
         /* poll mode */
-        if ((status = down_interruptible(&ca->slot_info[slot].sem)) != 0) return status;
         slot_status = ca->pub->poll_slot_status(ca->pub, slot);
-        up(&ca->slot_info[slot].sem);
 
         cam_present_now = (slot_status & DVB_CA_EN50221_POLL_CAM_PRESENT) ? 1: 0;
         cam_changed = (slot_status & DVB_CA_EN50221_POLL_CAM_CHANGED) ? 1: 0;
@@ -277,7 +278,7 @@
                 }
 
                 /* wait for a bit */
-                dvb_delay(1);
+                msleep(1);
         }
 
         dprintk("%s failed timeout:%lu\n", __FUNCTION__, jiffies - start);
@@ -360,6 +361,13 @@
 
         /* grab the next tuple length and type */
         if ((_tupleType = ca->pub->read_attribute_mem(ca->pub, slot, _address)) < 0) return _tupleType;
+        if (_tupleType == 0xff) {
+                dprintk("END OF CHAIN TUPLE type:0x%x\n", _tupleType);
+                *address += 2;
+                *tupleType = _tupleType;
+                *tupleLength = 0;
+                return 0;
+        }
         if ((_tupleLength = ca->pub->read_attribute_mem(ca->pub, slot, _address+2)) < 0) return _tupleLength;
         _address += 4;
 
@@ -550,25 +558,22 @@
 
         dprintk ("%s\n", __FUNCTION__);
 
-        /* acquire the slot */
-        if ((status = down_interruptible(&ca->slot_info[slot].sem)) != 0) return status;
-
         /* check if we have space for a link buf in the rx_buffer */
         if (ebuf == NULL) {
-                if (dvb_ringbuffer_free(&ca->slot_info[slot].rx_buffer) <
-                    (ca->slot_info[slot].link_buf_size + DVB_RINGBUFFER_PKTHDRSIZE)) {
+		int buf_free;
+		
+		down_read(&ca->slot_info[slot].sem);
+		buf_free = dvb_ringbuffer_free(&ca->slot_info[slot].rx_buffer);
+		up_read(&ca->slot_info[slot].sem);
+		
+                if (buf_free < (ca->slot_info[slot].link_buf_size + DVB_RINGBUFFER_PKTHDRSIZE)) {
                         status = -EAGAIN;
                         goto exit;
                 }
         }
 
-        /* reset the interface if there's been a tx error */
+        /* check if there is data available */
         if ((status = ca->pub->read_cam_control(ca->pub, slot, CTRLIF_STATUS)) < 0) goto exit;
-        if (status & STATUSREG_TXERR) {
-                ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_LINKINIT;
-                status = -EIO;
-                goto exit;
-        }
         if (!(status & STATUSREG_DA)) {
                 /* no data */
                 status = 0;
@@ -612,20 +617,25 @@
                 buf[i] = status;
         }
 
-        /* check for read error (RE should now go to 0) */
+        /* check for read error (RE should now be 0) */
         if ((status = ca->pub->read_cam_control(ca->pub, slot, CTRLIF_STATUS)) < 0) goto exit;
         if (status & STATUSREG_RE) {
+		ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_LINKINIT;
                 status = -EIO;
                 goto exit;
         }
 
         /* OK, add it to the receive buffer, or copy into external buffer if supplied */
         if (ebuf == NULL) {
+		down_read(&ca->slot_info[slot].sem);
                 dvb_ringbuffer_pkt_write(&ca->slot_info[slot].rx_buffer, buf, bytes_read);
+		up_read(&ca->slot_info[slot].sem);
         } else {
                 memcpy(ebuf, buf, bytes_read);
         }
 
+	dprintk("Received CA packet for slot %i connection id 0x%x last_frag:%i size:0x%x\n", slot, buf[0], (buf[1] & 0x80) == 0, bytes_read);
+
         /* wake up readers when a last_fragment is received */
         if ((buf[1] & 0x80) == 0x00) {
                 wake_up_interruptible(&ca->wait_queue);
@@ -634,7 +643,6 @@
         status = bytes_read;
 
 exit:
-        up(&ca->slot_info[slot].sem);
         return status;
 }
 
@@ -662,19 +670,9 @@
         // sanity check
         if (bytes_write > ca->slot_info[slot].link_buf_size) return -EINVAL;
 
-        /* acquire the slot */
-        if ((status = down_interruptible(&ca->slot_info[slot].sem)) != 0) return status;
-
-        /* reset the interface if there's been a tx error */
+        /* check if interface is actually waiting for us to read from it, or if a read is in progress */
         if ((status = ca->pub->read_cam_control(ca->pub, slot, CTRLIF_STATUS)) < 0) goto exitnowrite;
-        if (status & STATUSREG_TXERR) {
-                ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_LINKINIT;
-                status = -EIO;
-                goto exitnowrite;
-        }
-
-        /* check if interface is actually waiting for us to read from it */
-        if (status & STATUSREG_DA) {
+        if (status & (STATUSREG_DA|STATUSREG_RE)) {
                 status = -EAGAIN;
                 goto exitnowrite;
         }
@@ -702,16 +700,18 @@
         /* check for write error (WE should now be 0) */
         if ((status = ca->pub->read_cam_control(ca->pub, slot, CTRLIF_STATUS)) < 0) goto exit;
         if (status & STATUSREG_WE) {
+		ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_LINKINIT;
                 status = -EIO;
                 goto exit;
         }
         status = bytes_write;
 
+	dprintk("Wrote CA packet for slot %i, connection id 0x%x last_frag:%i size:0x%x\n", slot, buf[0], (buf[1] & 0x80) == 0, bytes_write);
+	
 exit:
         ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND, IRQEN);
 
 exitnowrite:
-        up(&ca->slot_info[slot].sem);
         return status;
 }
 
@@ -729,16 +729,14 @@
  */
 static int dvb_ca_en50221_slot_shutdown(struct dvb_ca_private* ca, int slot)
 {
-        int status;
-
         dprintk ("%s\n", __FUNCTION__);
 
-        if ((status = down_interruptible(&ca->slot_info[slot].sem)) != 0) return status;
+        down_write(&ca->slot_info[slot].sem);
         ca->pub->slot_shutdown(ca->pub, slot);
         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_NONE;
         if (ca->slot_info[slot].rx_buffer.data) vfree(ca->slot_info[slot].rx_buffer.data);
         ca->slot_info[slot].rx_buffer.data = NULL;
-        up(&ca->slot_info[slot].sem);
+        up_write(&ca->slot_info[slot].sem);
 
         /* need to wake up all processes to check if they're now
            trying to write to a defunct CAM */
@@ -821,10 +819,7 @@
                 break;
 
         case DVB_CA_SLOTSTATE_RUNNING:
-                flags = ca->pub->read_cam_control(pubca, slot, CTRLIF_STATUS);
-                if (flags & STATUSREG_DA) {
-                        dvb_ca_en50221_thread_wakeup(ca);
-                }
+		if (ca->open) dvb_ca_en50221_read_data(ca, slot, NULL, 0);
                 break;
         }
 }
@@ -934,7 +929,11 @@
 
         /* setup kernel thread */
         snprintf(name, sizeof(name), "kdvb-ca-%i:%i", ca->dvbdev->adapter->num, ca->dvbdev->id);
-        dvb_kernel_thread_setup(name);
+
+        lock_kernel ();
+        daemonize (name);
+        sigfillset (&current->blocked);
+        unlock_kernel ();
 
         /* choose the correct initial delay */
         dvb_ca_en50221_thread_update_delay(ca);
@@ -993,6 +992,12 @@
                                 break;
 
                         case DVB_CA_SLOTSTATE_VALIDATE:
+                                if (ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND, CMDREG_RS) != 0) {
+                                        printk("dvb_ca: Unable to reset CAM IF\n");
+                                        ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_INVALID;
+                                        dvb_ca_en50221_thread_update_delay(ca);
+                                        break;
+                                }
                                 if (dvb_ca_en50221_parse_attributes(ca, slot) != 0) {
                                         printk("dvb_ca: Invalid PC card inserted :(\n");
                                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_INVALID;
@@ -1054,6 +1058,10 @@
                         case DVB_CA_SLOTSTATE_RUNNING:
                                 if (!ca->open) break;
 
+				// no need to poll if the CAM supports IRQs
+				if (ca->slot_info[slot].da_irq_supported) break;
+
+				// poll mode
                                 pktcount = 0;
                                 while(dvb_ca_en50221_read_data(ca, slot, NULL, 0) > 0) {
                                         if (!ca->open) break;
@@ -1233,7 +1241,7 @@
 			}
                         if (status != -EAGAIN) goto exit;
 
-                        dvb_delay(1);
+                        msleep(1);
                 }
 	        if (!written) {
 		        status = -EIO;
@@ -1266,7 +1274,7 @@
         while((slot_count < ca->slot_count) && (!found)) {
                 if (ca->slot_info[slot].slot_state != DVB_CA_SLOTSTATE_RUNNING) goto nextslot;
 
-                if ((*result = down_interruptible(&ca->slot_info[slot].sem)) != 0) return 1;
+                down_read(&ca->slot_info[slot].sem);
 
                 idx = dvb_ringbuffer_pkt_next(&ca->slot_info[slot].rx_buffer, -1, &fraglen);
                 while(idx != -1) {
@@ -1281,7 +1289,7 @@
                         idx = dvb_ringbuffer_pkt_next(&ca->slot_info[slot].rx_buffer, idx, &fraglen);
                 }
 
-                if (!found) up(&ca->slot_info[slot].sem);
+                if (!found) up_read(&ca->slot_info[slot].sem);
 
 nextslot:
                 slot = (slot + 1) % ca->slot_count;
@@ -1378,7 +1386,7 @@
         status = pktlen;
 
 exit:
-        up(&ca->slot_info[slot].sem);
+        up_read(&ca->slot_info[slot].sem);
         return status;
 }
 
@@ -1406,7 +1414,9 @@
 
         for(i=0; i< ca->slot_count; i++) {
                 if (ca->slot_info[i].slot_state == DVB_CA_SLOTSTATE_RUNNING) {
+		        down_write(&ca->slot_info[i].sem);
                         dvb_ringbuffer_flush(&ca->slot_info[i].rx_buffer);
+		        up_write(&ca->slot_info[i].sem);
                 }
         }
 
@@ -1464,7 +1474,7 @@
         dprintk ("%s\n", __FUNCTION__);
 
         if (dvb_ca_en50221_io_read_condition(ca, &result, &slot) == 1) {
-                up(&ca->slot_info[slot].sem);
+                up_read(&ca->slot_info[slot].sem);
                 mask |= POLLIN;
         }
 
@@ -1475,7 +1485,7 @@
         poll_wait(file, &ca->wait_queue, wait);
 
         if (dvb_ca_en50221_io_read_condition(ca, &result, &slot) == 1) {
-                up(&ca->slot_info[slot].sem);
+                up_read(&ca->slot_info[slot].sem);
                 mask |= POLLIN;
         }
 
@@ -1484,21 +1494,21 @@
 
 
 static struct file_operations dvb_ca_fops = {
-        owner: THIS_MODULE,
-        read: dvb_ca_en50221_io_read,
-        write: dvb_ca_en50221_io_write,
-        ioctl: dvb_ca_en50221_io_ioctl,
-        open: dvb_ca_en50221_io_open,
-        release: dvb_ca_en50221_io_release,
-        poll: dvb_ca_en50221_io_poll,
+        .owner	= THIS_MODULE,
+        .read	= dvb_ca_en50221_io_read,
+        .write	= dvb_ca_en50221_io_write,
+        .ioctl	= dvb_ca_en50221_io_ioctl,
+        .open	= dvb_ca_en50221_io_open,
+        .release= dvb_ca_en50221_io_release,
+        .poll	= dvb_ca_en50221_io_poll,
 };
 
 static struct dvb_device dvbdev_ca = {
-        priv: NULL,
-        users: 1,
-        readers: 1,
-        writers: 1,
-        fops: &dvb_ca_fops,
+        .priv	= NULL,
+        .users	= 1,
+        .readers= 1,
+        .writers= 1,
+        .fops	= &dvb_ca_fops,
 };
 
 
@@ -1559,7 +1569,7 @@
                 ca->slot_info[i].slot_state = DVB_CA_SLOTSTATE_NONE;
                 atomic_set(&ca->slot_info[i].camchange_count, 0);
                 ca->slot_info[i].camchange_type = DVB_CA_EN50221_CAMCHANGE_REMOVED;
-                init_MUTEX(&ca->slot_info[i].sem);
+                init_rwsem(&ca->slot_info[i].sem);
         }
 
         if (signal_pending(current)) {
@@ -1623,6 +1635,3 @@
         pubca->private = NULL;
 }
 
-MODULE_PARM(dvb_ca_en50221_debug,"i");
-
-MODULE_PARM_DESC(dvb_ca_en50221_debug, "enable verbose debug messages");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_ca_en50221.h linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ca_en50221.h
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_ca_en50221.h	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ca_en50221.h	2004-05-14 18:54:27.000000000 +0200
@@ -42,6 +42,9 @@
 /* Structure describing a CA interface */
 struct dvb_ca_en50221 {
 
+	/* NOTE: the read_*, write_* and poll_slot_status functions must use locks as
+	 * they may be called from several threads at once */
+
 	/* functions for accessing attribute memory on the CAM */
 	int (*read_attribute_mem)(struct dvb_ca_en50221* ca, int slot, int address);
 	int (*write_attribute_mem)(struct dvb_ca_en50221* ca, int slot, int address, u8 value);
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_demux.c
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_demux.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_demux.c	2004-08-18 19:52:17.000000000 +0200
@@ -31,7 +31,6 @@
 #include <asm/uaccess.h>
 
 #include "dvb_demux.h"
-#include "dvb_functions.h"
 
 #define NOBUFS  
 /* 
@@ -570,24 +570,30 @@
 
 static void dvb_demux_feed_add(struct dvb_demux_feed *feed)
 {
+	spin_lock(&feed->demux->lock);
 	if (dvb_demux_feed_find(feed)) {
 		printk(KERN_ERR "%s: feed already in list (type=%x state=%x pid=%x)\n",
 				__FUNCTION__, feed->type, feed->state, feed->pid);
-		return;
+		goto out;
 	}
 
 	list_add(&feed->list_head, &feed->demux->feed_list);
+out:
+	spin_unlock(&feed->demux->lock);
 }
 
 static void dvb_demux_feed_del(struct dvb_demux_feed *feed)
 {
+	spin_lock(&feed->demux->lock);
 	if (!(dvb_demux_feed_find(feed))) {
 		printk(KERN_ERR "%s: feed not in list (type=%x state=%x pid=%x)\n",
 				__FUNCTION__, feed->type, feed->state, feed->pid);
-		return;
+		goto out;
 }
 
 	list_del(&feed->list_head);
+out:
+	spin_unlock(&feed->demux->lock);
 }
 
 static int dmx_ts_feed_set (struct dmx_ts_feed* ts_feed, u16 pid, int ts_type, 
@@ -789,7 +795,7 @@
 
 		feed->pid = 0xffff;
 	
-	if (feed->ts_type & TS_DECODER)
+	if (feed->ts_type & TS_DECODER && feed->pes_type < DMX_TS_PES_OTHER)
 		demux->pesfilter[feed->pes_type] = NULL;
 
 	up(&demux->mutex);
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvbdev.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvbdev.c
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvbdev.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvbdev.c	2004-08-18 19:58:18.000000000 +0200
@@ -25,22 +25,26 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/device.h>
 
 #include "dvbdev.h"
-#include "dvb_functions.h"
 
-static int dvbdev_debug = 0;
+static int dvbdev_debug;
+
+module_param(dvbdev_debug, int, 0644);
+MODULE_PARM_DESC(dvbdev_debug, "Turn on/off device debugging (default:off).");
+
 #define dprintk if (dvbdev_debug) printk
 
 static LIST_HEAD(dvb_adapter_list);
 static DECLARE_MUTEX(dvbdev_register_lock);
 
-
-static char *dnames[] = { 
+static const char * const dnames[] = {
         "video", "audio", "sec", "frontend", "demux", "dvr", "ca",
 	"net", "osd"
 };
@@ -49,6 +52,9 @@
 #define DVB_MAX_IDS              4
 #define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
 
+struct class_simple *dvb_class;
+EXPORT_SYMBOL(dvb_class);
+
 static struct dvb_device* dvbdev_find_device (int minor)
 {
 	struct list_head *entry;
@@ -219,6 +224,9 @@
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			"dvb/adapter%d/%s%d", adap->num, dnames[type], id);
 
+	class_simple_device_add(dvb_class, MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
+				NULL, "dvb%d.%s%d", adap->num, dnames[type], id);
+
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, nums2minor(adap->num, type, id),
 		nums2minor(adap->num, type, id));
@@ -235,6 +243,9 @@
 		devfs_remove("dvb/adapter%d/%s%d", dvbdev->adapter->num,
 				dnames[dvbdev->type], dvbdev->id);
 
+	class_simple_device_remove(MKDEV(DVB_MAJOR, nums2minor(dvbdev->adapter->num,
+					dvbdev->type, dvbdev->id)));
+
 		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
 	}
@@ -300,24 +310,95 @@
 
 int dvb_unregister_adapter(struct dvb_adapter *adap)
 {
+	devfs_remove("dvb/adapter%d", adap->num);
+
 	if (down_interruptible (&dvbdev_register_lock))
 		return -ERESTARTSYS;
-        devfs_remove("dvb/adapter%d", adap->num);
 	list_del (&adap->list_head);
 	up (&dvbdev_register_lock);
 	kfree (adap);
 	return 0;
 }
 
+/* if the miracle happens and "generic_usercopy()" is included into
+   the kernel, then this can vanish. please don't make the mistake and
+   define this as video_usercopy(). this will introduce a dependecy
+   to the v4l "videodev.o" module, which is unnecessary for some
+   cards (ie. the budget dvb-cards don't need the v4l module...) */
+int dvb_usercopy(struct inode *inode, struct file *file,
+	             unsigned int cmd, unsigned long arg,
+		     int (*func)(struct inode *inode, struct file *file,
+		     unsigned int cmd, void *arg))
+{
+        char    sbuf[128];
+        void    *mbuf = NULL;
+        void    *parg = NULL;
+        int     err  = -EINVAL;
+
+        /*  Copy arguments into temp kernel buffer  */
+        switch (_IOC_DIR(cmd)) {
+        case _IOC_NONE:
+		/*
+		 * For this command, the pointer is actually an integer
+		 * argument.
+		 */
+		parg = (void *) arg;
+		break;
+        case _IOC_READ: /* some v4l ioctls are marked wrong ... */
+        case _IOC_WRITE:
+        case (_IOC_WRITE | _IOC_READ):
+                if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
+                        parg = sbuf;
+                } else {
+                        /* too big to allocate from stack */
+                        mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
+                        if (NULL == mbuf)
+                                return -ENOMEM;
+                        parg = mbuf;
+                }
+
+                err = -EFAULT;
+                if (copy_from_user(parg, (void __user *)arg, _IOC_SIZE(cmd)))
+                        goto out;
+                break;
+        }
+
+        /* call driver */
+        if ((err = func(inode, file, cmd, parg)) == -ENOIOCTLCMD)
+                err = -EINVAL;
+
+        if (err < 0)
+                goto out;
+
+        /*  Copy results into user buffer  */
+        switch (_IOC_DIR(cmd))
+        {
+        case _IOC_READ:
+        case (_IOC_WRITE | _IOC_READ):
+                if (copy_to_user((void __user *)arg, parg, _IOC_SIZE(cmd)))
+                        err = -EFAULT;
+                break;
+        }
+
+out:
+        if (mbuf)
+                kfree(mbuf);
+
+        return err;
+}
 
 static int __init init_dvbdev(void)
 {
 	int retval;
+
+	if ((retval = register_chrdev(DVB_MAJOR,"DVB", &dvb_device_fops)))
+		printk("dvb-core: unable to get major %d\n", DVB_MAJOR);
+
 	devfs_mk_dir("dvb");
 
-	retval = register_chrdev(DVB_MAJOR,"DVB", &dvb_device_fops);
-	if (retval)
-		printk("video_dev: unable to get major %d\n", DVB_MAJOR);
+	dvb_class = class_simple_create(THIS_MODULE, "dvb");
+	if (IS_ERR(dvb_class))
+		return PTR_ERR(dvb_class);
 
 	return retval;
 }
@@ -327,6 +408,7 @@
 {
 	unregister_chrdev(DVB_MAJOR, "DVB");
         devfs_remove("dvb");
+	class_simple_destroy(dvb_class);
 }
 
 module_init(init_dvbdev);
@@ -336,6 +418,3 @@
 MODULE_AUTHOR("Marcus Metzler, Ralph Metzler, Holger Waechtler");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(dvbdev_debug,"i");
-MODULE_PARM_DESC(dvbdev_debug, "enable verbose debug messages");
-
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvbdev.h linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvbdev.h
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvbdev.h	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvbdev.h	2004-08-18 19:58:18.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/smp_lock.h>
 
 #define DVB_MAJOR 212
 
@@ -92,5 +90,15 @@
 extern int dvb_generic_release (struct inode *inode, struct file *file);
 extern int dvb_generic_ioctl (struct inode *inode, struct file *file,
 			      unsigned int cmd, unsigned long arg);
+
+/* we don't mess with video_usercopy() any more,
+we simply define out own dvb_usercopy(), which will hopefully become
+generic_usercopy()  someday... */
+
+extern int dvb_usercopy(struct inode *inode, struct file *file,
+	                    unsigned int cmd, unsigned long arg,
+			    int (*func)(struct inode *inode, struct file *file,
+			    unsigned int cmd, void *arg));
+			      
 #endif /* #ifndef _DVBDEV_H_ */
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_frontend.c
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-08-18 19:52:17.000000000 +0200
@@ -1,5 +1,6 @@
 /*
- * dvb-core.c: DVB core driver
+ * dvb_frontend.c: DVB frontend tuning interface/thread
+ *
  *
  * Copyright (C) 1999-2001 Ralph  Metzler
  *                         Marcus Metzler
@@ -31,13 +32,33 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/list.h>
 #include <asm/processor.h>
 #include <asm/semaphore.h>
 
 #include "dvb_frontend.h"
 #include "dvbdev.h"
-#include "dvb_functions.h"
+
+static int dvb_frontend_debug;
+static int dvb_shutdown_timeout = 5;
+static int dvb_override_frequency_bending;
+static int dvb_force_auto_inversion;
+static int dvb_override_tune_delay;
+static int do_frequency_bending;
+
+module_param_named(frontend_debug, dvb_frontend_debug, int, 0644);
+MODULE_PARM_DESC(dvb_frontend_debug, "Turn on/off frontend core debugging (default:off).");
+module_param(dvb_shutdown_timeout, int, 0444);
+MODULE_PARM_DESC(dvb_shutdown_timeout, "wait <shutdown_timeout> seconds after close() before suspending hardware");
+module_param(dvb_override_frequency_bending, int, 0444);
+MODULE_PARM_DESC(dvb_override_frequency_bending, "0: normal (default), 1: never use frequency bending, 2: always use frequency bending");
+module_param(dvb_force_auto_inversion, int, 0444);
+MODULE_PARM_DESC(dvb_force_auto_inversion, "0: normal (default), 1: INVERSION_AUTO forced always");
+module_param(dvb_override_tune_delay, int, 0444);
+MODULE_PARM_DESC(dvb_override_tune_delay, "0: normal (default), >0 => delay in milliseconds to wait for lock after a tune attempt");
+
+#define dprintk if (dvb_frontend_debug) printk
 
 #define FESTATE_IDLE 1
 #define FESTATE_RETUNE 2
@@ -66,17 +87,6 @@
  * FESTATE_LOSTLOCK. When the lock has been lost, and we're searching it again.
  */
 
-
-static int dvb_frontend_debug = 0;
-static int dvb_shutdown_timeout = 5;
-static int dvb_override_frequency_bending = 0;
-static int dvb_force_auto_inversion = 0;
-static int dvb_override_tune_delay = 0;
-
-static int do_frequency_bending = 0;
-
-#define dprintk if (dvb_frontend_debug) printk
-
 #define MAX_EVENT 8
 
 struct dvb_fe_events {
@@ -95,6 +105,7 @@
 	struct dvb_device *dvbdev;
 	struct dvb_frontend_parameters parameters;
 	struct dvb_fe_events events;
+	struct module *module;
 	struct semaphore sem;
 	struct list_head list_head;
 	wait_queue_head_t wait_queue;
@@ -174,7 +185,7 @@
 {
 	struct list_head *entry;
 	int stepsize = this_fe->info->frequency_stepsize;
-	int this_fe_adap_num = this_fe->frontend.i2c->adapter->num;
+	int this_fe_adap_num = this_fe->frontend.dvb_adapter->num;
 	int frequency;
 
 	if (!stepsize || recursive > 10) {
@@ -198,7 +209,7 @@
 
 		fe = list_entry (entry, struct dvb_frontend_data, list_head);
 
-		if (fe->frontend.i2c->adapter->num != this_fe_adap_num)
+		if (fe->frontend.dvb_adapter->num != this_fe_adap_num)
 			continue;
 
 		f = fe->parameters.frequency;
@@ -233,13 +244,10 @@
 	dprintk ("%s\n", __FUNCTION__);
 
 	if (((s ^ fe->status) & FE_HAS_LOCK) && (s & FE_HAS_LOCK))
-		dvb_delay (fe->info->notifier_delay);
+		msleep (fe->info->notifier_delay);
 
 	fe->status = s;
 
-	if (!(s & FE_HAS_LOCK) && (fe->info->caps & FE_CAN_MUTE_TS))
-		return;
-
 	/**
 	 *   now tell the Demux about the TS status changes...
 	 */
@@ -333,8 +341,8 @@
 {
 	struct dvb_frontend *frontend = &fe->frontend;
 
-	dprintk ("DVB: initialising frontend %i:%i (%s)...\n",
-		 frontend->i2c->adapter->num, frontend->i2c->id,
+	dprintk ("DVB: initialising frontend %i (%s)...\n",
+		 frontend->dvb_adapter->num,
 		 fe->info->name);
 
 	dvb_frontend_internal_ioctl (frontend, FE_INIT, NULL);
@@ -371,25 +379,26 @@
 	int original_inversion = fe->parameters.inversion;
 	u32 original_frequency = fe->parameters.frequency;
 
-	// are we using autoinversion?
-	autoinversion = ((!(fe->info->caps & FE_CAN_INVERSION_AUTO)) && (fe->parameters.inversion == INVERSION_AUTO));
+	/* are we using autoinversion? */
+	autoinversion = ((!(fe->info->caps & FE_CAN_INVERSION_AUTO)) &&
+			 (fe->parameters.inversion == INVERSION_AUTO));
 
-	// setup parameters correctly
+	/* setup parameters correctly */
 	while(!ready) {
-		// calculate the lnb_drift
+		/* calculate the lnb_drift */
 		fe->lnb_drift = fe->auto_step * fe->step_size;
 
-		// wrap the auto_step if we've exceeded the maximum drift
+		/* wrap the auto_step if we've exceeded the maximum drift */
 		if (fe->lnb_drift > fe->max_drift) {
 			fe->auto_step = 0;
 			fe->auto_sub_step = 0;
 			fe->lnb_drift = 0;
 		}
 
-		// perform inversion and +/- zigzag
+		/* perform inversion and +/- zigzag */
 		switch(fe->auto_sub_step) {
 		case 0:
-			// try with the current inversion and current drift setting
+			/* try with the current inversion and current drift setting */
 			ready = 1;
 			break;
 
@@ -418,35 +427,36 @@
 		    
 		default:
 			fe->auto_step++;
-			fe->auto_sub_step = -1; // it'll be incremented to 0 in a moment
+			fe->auto_sub_step = -1; /* it'll be incremented to 0 in a moment */
 			break;
 		}
 	    
 		if (!ready) fe->auto_sub_step++;
 	}
 
-	// if this attempt would hit where we started, indicate a complete iteration has occurred
-	if ((fe->auto_step == fe->started_auto_step) && (fe->auto_sub_step == 0) && check_wrapped) {
+	/* if this attempt would hit where we started, indicate a complete
+	 * iteration has occurred */
+	if ((fe->auto_step == fe->started_auto_step) &&
+	    (fe->auto_sub_step == 0) && check_wrapped) {
 		return 1;
 		}
 
-	// perform frequency bending if necessary
+	/* perform frequency bending if necessary */
 	if ((dvb_override_frequency_bending != 1) && do_frequency_bending)
 		dvb_bend_frequency(fe, 0);
 
-	// instrumentation
-	dprintk("%s: drift:%i bending:%i inversion:%i auto_step:%i auto_sub_step:%i started_auto_step:%i\n", 
-		__FUNCTION__, fe->lnb_drift, fe->bending, fe->inversion, fe->auto_step, fe->auto_sub_step,
-		fe->started_auto_step);
+	dprintk("%s: drift:%i bending:%i inversion:%i auto_step:%i "
+		"auto_sub_step:%i started_auto_step:%i\n",
+		__FUNCTION__, fe->lnb_drift, fe->bending, fe->inversion,
+		fe->auto_step, fe->auto_sub_step, fe->started_auto_step);
     
-	// set the frontend itself
+	/* set the frontend itself */
 	fe->parameters.frequency += fe->lnb_drift + fe->bending;
 	if (autoinversion) fe->parameters.inversion = fe->inversion;
 	dvb_frontend_internal_ioctl (&fe->frontend, FE_SET_FRONTEND, &fe->parameters);
 	fe->parameters.frequency = original_frequency;
 	fe->parameters.inversion = original_inversion;
 
-	// normal return
 	fe->auto_sub_step++;
 	return 0;
 }
@@ -490,10 +500,13 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	snprintf (name, sizeof(name), "kdvb-fe-%i:%i",
-		  fe->frontend.i2c->adapter->num, fe->frontend.i2c->id);
+	snprintf (name, sizeof(name), "kdvb-fe-%i",
+		  fe->frontend.dvb_adapter->num);
 
-	dvb_kernel_thread_setup (name);
+        lock_kernel ();
+        daemonize (name);
+        sigfillset (&current->blocked);
+        unlock_kernel ();
 
 	dvb_call_frontend_notifiers (fe, 0);
 	dvb_frontend_init (fe);
@@ -511,65 +524,70 @@
 		if (down_interruptible (&fe->sem))
 			break;
 
-		// if we've got no parameters, just keep idling
+		/* if we've got no parameters, just keep idling */
 		if (fe->state & FESTATE_IDLE) {
 			delay = 3*HZ;
 			quality = 0;
 			continue;
 		}
 
-		// get the frontend status
+		/* get the frontend status */
+		if (fe->state & FESTATE_RETUNE) {
+			s = 0;
+		} else {
 		dvb_frontend_internal_ioctl (&fe->frontend, FE_READ_STATUS, &s);
-		if (s != fe->status)
+			if (s != fe->status) {
 			dvb_frontend_add_event (fe, s);
-
-		// if we're not tuned, and we have a lock, move to the TUNED state
+			}
+		}
+		/* if we're not tuned, and we have a lock, move to the TUNED state */
 		if ((fe->state & FESTATE_WAITFORLOCK) && (s & FE_HAS_LOCK)) {
 			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
 			fe->state = FESTATE_TUNED;
 
-			// if we're tuned, then we have determined the correct inversion
-			if ((!(fe->info->caps & FE_CAN_INVERSION_AUTO)) && (fe->parameters.inversion == INVERSION_AUTO)) {
+			/* if we're tuned, then we have determined the correct inversion */
+			if ((!(fe->info->caps & FE_CAN_INVERSION_AUTO)) &&
+			    (fe->parameters.inversion == INVERSION_AUTO)) {
 				fe->parameters.inversion = fe->inversion;
 			}
 			continue;
 		}
 
-		// if we are tuned already, check we're still locked
+		/* if we are tuned already, check we're still locked */
 		if (fe->state & FESTATE_TUNED) {
 			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
 
-			// we're tuned, and the lock is still good...
-		if (s & FE_HAS_LOCK) {
+			/* we're tuned, and the lock is still good... */
+			if (s & FE_HAS_LOCK)
 				continue;
-		} else {
-				// if we _WERE_ tuned, but now don't have a lock, need to zigzag
+			else {
+				/* if we _WERE_ tuned, but now don't have a lock,
+				 * need to zigzag */
 				fe->state = FESTATE_ZIGZAG_FAST;
 				fe->started_auto_step = fe->auto_step;
 				check_wrapped = 0;
-				// fallthrough
 			}
 		}
 
-		// don't actually do anything if we're in the LOSTLOCK state, the frontend is set to
-		// FE_CAN_RECOVER, and the max_drift is 0
+		/* don't actually do anything if we're in the LOSTLOCK state,
+		 * the frontend is set to FE_CAN_RECOVER, and the max_drift is 0 */
 		if ((fe->state & FESTATE_LOSTLOCK) && 
 		    (fe->info->caps & FE_CAN_RECOVER) && (fe->max_drift == 0)) {
 			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
 						continue;
 				}
 	    
-		// don't do anything if we're in the DISEQC state, since this might be someone
-		// with a motorized dish controlled by DISEQC. If its actually a re-tune, there will
-		// be a SET_FRONTEND soon enough.
+		/* don't do anything if we're in the DISEQC state, since this
+		 * might be someone with a motorized dish controlled by DISEQC.
+		 * If its actually a re-tune, there will be a SET_FRONTEND soon enough.	*/
 		if (fe->state & FESTATE_DISEQC) {
 			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
 			continue;
 				}
 
-		// if we're in the RETUNE state, set everything up for a brand new scan,
-		// keeping the current inversion setting, as the next tune is _very_ likely
-		// to require the same
+		/* if we're in the RETUNE state, set everything up for a brand
+		 * new scan, keeping the current inversion setting, as the next
+		 * tune is _very_ likely to require the same */
 		if (fe->state & FESTATE_RETUNE) {
 			fe->lnb_drift = 0;
 			fe->auto_step = 0;
@@ -578,35 +596,36 @@
 			check_wrapped = 0;
 		}
 
-		// fast zigzag.
+		/* fast zigzag. */
 		if ((fe->state & FESTATE_SEARCHING_FAST) || (fe->state & FESTATE_RETUNE)) {
 			delay = fe->min_delay;
 
-			// peform a tune
+			/* peform a tune */
 			if (dvb_frontend_autotune(fe, check_wrapped)) {
-				// OK, if we've run out of trials at the fast speed. Drop back to
-				// slow for the _next_ attempt
+				/* OK, if we've run out of trials at the fast speed.
+				 * Drop back to slow for the _next_ attempt */
 				fe->state = FESTATE_SEARCHING_SLOW;
 				fe->started_auto_step = fe->auto_step;
 				continue;
 			}
 			check_wrapped = 1;
 
-			// if we've just retuned, enter the ZIGZAG_FAST state. This ensures
-			// we cannot return from an FE_SET_FRONTEND ioctl before the first frontend
-			// tune occurs
+			/* if we've just retuned, enter the ZIGZAG_FAST state.
+			 * This ensures we cannot return from an
+			 * FE_SET_FRONTEND ioctl before the first frontend tune
+			 * occurs */
 			if (fe->state & FESTATE_RETUNE) {
 				fe->state = FESTATE_TUNING_FAST;
 				wake_up_interruptible(&fe->wait_queue);
 			}
 		}
 
-		// slow zigzag
+		/* slow zigzag */
 		if (fe->state & FESTATE_SEARCHING_SLOW) {
 			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
 		    
-			// Note: don't bother checking for wrapping; we stay in this state 
-			// until we get a lock
+			/* Note: don't bother checking for wrapping; we stay in this
+			 * state until we get a lock */
 			dvb_frontend_autotune(fe, 0);
 		}
 	};
@@ -614,8 +633,6 @@
 	if (dvb_shutdown_timeout)
 		dvb_frontend_internal_ioctl (&fe->frontend, FE_SLEEP, NULL); 
 
-	up (&fe->sem);
-
 	fe->thread_pid = 0;
 	mb();
 
@@ -711,6 +729,11 @@
 	if (!fe || !fe->frontend.ioctl || fe->exit)
 		return -ENODEV;
 
+	if ((file->f_flags & O_ACCMODE) == O_RDONLY &&
+	    (_IOC_DIR(cmd) != _IOC_READ || cmd == FE_GET_EVENT ||
+	     cmd == FE_DISEQC_RECV_SLAVE_REPLY))
+		return -EPERM;
+
 	if (down_interruptible (&fe->sem))
 		return -ERESTARTSYS;
 
@@ -718,6 +741,7 @@
 	case FE_DISEQC_SEND_MASTER_CMD:
 	case FE_DISEQC_SEND_BURST:
 	case FE_SET_TONE:
+	case FE_SET_VOLTAGE:
 		if (fe->status)
 			dvb_call_frontend_notifiers (fe, 0);
 		dvb_frontend_internal_ioctl (&fe->frontend, cmd, parg);
@@ -734,43 +758,48 @@
 		memcpy(&fetunesettings.parameters, parg,
 		       sizeof (struct dvb_frontend_parameters));
 		    
-		// force auto frequency inversion if requested
+		/* force auto frequency inversion if requested */
 		if (dvb_force_auto_inversion) {
 			fe->parameters.inversion = INVERSION_AUTO;
 			fetunesettings.parameters.inversion = INVERSION_AUTO;
 		}
 
-		// get frontend-specific tuning settings
-		if (dvb_frontend_internal_ioctl(&fe->frontend, FE_GET_TUNE_SETTINGS, &fetunesettings) == 0) {
+		/* get frontend-specific tuning settings */
+		if (dvb_frontend_internal_ioctl(&fe->frontend, FE_GET_TUNE_SETTINGS,
+						&fetunesettings) == 0) {
 			fe->min_delay = (fetunesettings.min_delay_ms * HZ) / 1000;
 			fe->max_drift = fetunesettings.max_drift;
 			fe->step_size = fetunesettings.step_size;
 		} else {
-			// default values
+			/* default values */
 			switch(fe->info->type) {
 			case FE_QPSK:
-				fe->min_delay = HZ/20; // default mindelay of 50ms
+				fe->min_delay = HZ/20;
 				fe->step_size = fe->parameters.u.qpsk.symbol_rate / 16000;
 				fe->max_drift = fe->parameters.u.qpsk.symbol_rate / 2000;
 		break;
 			    
 			case FE_QAM:
-				fe->min_delay = HZ/20; // default mindelay of 50ms
-				fe->step_size = 0;
-				fe->max_drift = 0; // don't want any zigzagging under DVB-C frontends
+				fe->min_delay = HZ/20;
+				fe->step_size = 0; /* no zigzag */
+				fe->max_drift = 0;
 				break;
 			    
 			case FE_OFDM:
-				fe->min_delay = HZ/20; // default mindelay of 50ms
+				fe->min_delay = HZ/20;
 				fe->step_size = fe->info->frequency_stepsize * 2;
 				fe->max_drift = (fe->info->frequency_stepsize * 2) + 1;
 				break;
+			case FE_ATSC:
+				printk("dvb-core: FE_ATSC not handled yet.\n");
+				break;
 			}
 		}
 		if (dvb_override_tune_delay > 0) {
 		       fe->min_delay = (dvb_override_tune_delay * HZ) / 1000;
 		}
 
+		dvb_frontend_wakeup(fe);
 		dvb_frontend_add_event (fe, 0);	    
 		break;
 
@@ -789,20 +819,13 @@
 	if (err < 0)
 		return err;
 
-	// Force the CAN_INVERSION_AUTO bit on. If the frontend doesn't do it, it is done for it.
+	/* Force the CAN_INVERSION_AUTO bit on. If the frontend doesn't
+	 * do it, it is done for it. */
 	if ((cmd == FE_GET_INFO) && (err == 0)) {
 		struct dvb_frontend_info* tmp = (struct dvb_frontend_info*) parg;
 		tmp->caps |= FE_CAN_INVERSION_AUTO;
 	}
 
-	// if the frontend has just been set, wait until the first tune has finished.
-	// This ensures the app doesn't start reading data too quickly, perhaps from the
-	// previous lock, which is REALLY CONFUSING TO DEBUG!
-	if ((cmd == FE_SET_FRONTEND) && (err == 0)) {
-		dvb_frontend_wakeup(fe);
-		err = wait_event_interruptible(fe->wait_queue, fe->state & ~FESTATE_RETUNE);
-	}
-
 	return err;
 }
 
@@ -843,6 +866,11 @@
 		fe->events.eventr = fe->events.eventw = 0;
 	}
 	
+	if (!ret && fe->module) {
+		if (!try_module_get(fe->module))
+			return -EINVAL;
+	}
+
 	return ret;
 }
 
@@ -851,13 +879,19 @@
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend_data *fe = dvbdev->priv;
+	int ret = 0;
 
 	dprintk ("%s\n", __FUNCTION__);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY)
 		fe->release_jiffies = jiffies;
 
-	return dvb_generic_release (inode, file);
+	ret = dvb_generic_release (inode, file);
+
+	if (!ret && fe->module)
+		module_put(fe->module);
+
+	return ret;
 }
 
 
@@ -897,7 +931,7 @@
 
 		fe = list_entry (entry, struct dvb_frontend_data, list_head);
 
-		if (fe->frontend.i2c->adapter == adapter &&
+		if (fe->frontend.dvb_adapter == adapter &&
 		    fe->frontend.before_ioctl == NULL &&
 		    fe->frontend.after_ioctl == NULL)
 		{
@@ -931,7 +965,7 @@
 
 		fe = list_entry (entry, struct dvb_frontend_data, list_head);
 
-		if (fe->frontend.i2c->adapter == adapter &&
+		if (fe->frontend.dvb_adapter == adapter &&
 		    fe->frontend.before_ioctl == before_ioctl &&
 		    fe->frontend.after_ioctl == after_ioctl)
 		{
@@ -992,7 +1026,7 @@
 
 		fe = list_entry (entry, struct dvb_frontend_data, list_head);
 
-		if (fe->frontend.i2c->adapter == adapter &&
+		if (fe->frontend.dvb_adapter == adapter &&
 		    fe->frontend.notifier_callback == NULL)
 		{
 			fe->frontend.notifier_callback = callback;
@@ -1021,7 +1055,7 @@
 
 		fe = list_entry (entry, struct dvb_frontend_data, list_head);
 
-		if (fe->frontend.i2c->adapter == adapter &&
+		if (fe->frontend.dvb_adapter == adapter &&
 		    fe->frontend.notifier_callback == callback)
 		{
 			fe->frontend.notifier_callback = NULL;
@@ -1061,9 +1093,10 @@
 int
 dvb_register_frontend (int (*ioctl) (struct dvb_frontend *frontend,
 				     unsigned int cmd, void *arg),
-		       struct dvb_i2c_bus *i2c,
+		       struct dvb_adapter *dvb_adapter,
 		       void *data,
-		       struct dvb_frontend_info *info)
+		       struct dvb_frontend_info *info,
+		       struct module *module)
 {
 	struct list_head *entry;
 	struct dvb_frontend_data *fe;
@@ -1093,9 +1126,10 @@
 	init_MUTEX (&fe->events.sem);
 	fe->events.eventw = fe->events.eventr = 0;
 	fe->events.overflow = 0;
+	fe->module = module;
 
 	fe->frontend.ioctl = ioctl;
-	fe->frontend.i2c = i2c;
+	fe->frontend.dvb_adapter = dvb_adapter;
 	fe->frontend.data = data;
 	fe->info = info;
 	fe->inversion = INVERSION_OFF;
@@ -1107,7 +1141,7 @@
 				    struct dvb_frontend_ioctl_data,
 				    list_head);
 
-		if (ioctl->adapter == i2c->adapter) {
+		if (ioctl->adapter == dvb_adapter) {
 			fe->frontend.before_ioctl = ioctl->before_ioctl;
 			fe->frontend.after_ioctl = ioctl->after_ioctl;
 			fe->frontend.before_after_data = ioctl->before_after_data;
@@ -1122,7 +1156,7 @@
 				       struct dvb_frontend_notifier_data,
 				       list_head);
 
-		if (notifier->adapter == i2c->adapter) {
+		if (notifier->adapter == dvb_adapter) {
 			fe->frontend.notifier_callback = notifier->callback;
 			fe->frontend.notifier_data = notifier->data;
 			break;
@@ -1131,11 +1165,11 @@
 
 	list_add_tail (&fe->list_head, &frontend_list);
 
-	printk ("DVB: registering frontend %i:%i (%s)...\n",
-		fe->frontend.i2c->adapter->num, fe->frontend.i2c->id,
+	printk ("DVB: registering frontend %i (%s)...\n",
+		fe->frontend.dvb_adapter->num,
 		fe->info->name);
 
-	dvb_register_device (i2c->adapter, &fe->dvbdev, &dvbdev_template,
+	dvb_register_device (dvb_adapter, &fe->dvbdev, &dvbdev_template,
 			     fe, DVB_DEVICE_FRONTEND);
 
 	if ((info->caps & FE_NEEDS_BENDING) || (dvb_override_frequency_bending == 2))
@@ -1146,10 +1179,9 @@
 	return 0;
 }
 
-
-int dvb_unregister_frontend (int (*ioctl) (struct dvb_frontend *frontend,
+int dvb_unregister_frontend_new (int (*ioctl) (struct dvb_frontend *frontend,
 					   unsigned int cmd, void *arg),
-			     struct dvb_i2c_bus *i2c)
+			     struct dvb_adapter *dvb_adapter)
 {
         struct list_head *entry, *n;
 
@@ -1162,7 +1194,7 @@
 
 		fe = list_entry (entry, struct dvb_frontend_data, list_head);
 
-		if (fe->frontend.ioctl == ioctl && fe->frontend.i2c == i2c) {
+		if (fe->frontend.ioctl == ioctl && fe->frontend.dvb_adapter == dvb_adapter) {
 			dvb_unregister_device (fe->dvbdev);
 			list_del (entry);
 			up (&frontend_mutex);
@@ -1176,14 +1208,3 @@
 	return -EINVAL;
 }
 
-MODULE_PARM(dvb_frontend_debug,"i");
-MODULE_PARM(dvb_shutdown_timeout,"i");
-MODULE_PARM(dvb_override_frequency_bending,"i");
-MODULE_PARM(dvb_force_auto_inversion,"i");
-MODULE_PARM(dvb_override_tune_delay,"i");
-
-MODULE_PARM_DESC(dvb_frontend_debug, "enable verbose debug messages");
-MODULE_PARM_DESC(dvb_shutdown_timeout, "wait <shutdown_timeout> seconds after close() before suspending hardware");
-MODULE_PARM_DESC(dvb_override_frequency_bending, "0: normal (default), 1: never use frequency bending, 2: always use frequency bending");
-MODULE_PARM_DESC(dvb_force_auto_inversion, "0: normal (default), 1: INVERSION_AUTO forced always");
-MODULE_PARM_DESC(dvb_override_tune_delay, "0: normal (default), >0 => delay in milliseconds to wait for lock after a tune attempt");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_frontend.h linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_frontend.h
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_frontend.h	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_frontend.h	2004-08-18 19:52:17.000000000 +0200
@@ -31,14 +34,29 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/delay.h>
 
 #include <linux/dvb/frontend.h>
 
-#include "dvb_i2c.h"
 #include "dvbdev.h"
 
-
-
+/* FIXME: Move to i2c-id.h */
+#define I2C_DRIVERID_DVBFE_ALPS_TDLB7	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_ALPS_TDMB7	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_AT76C651	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_CX24110	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_DST		I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_DUMMY	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_L64781	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_MT312	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_MT352	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_NXT6000	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_SP887X	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_STV0299	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_TDA1004X	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_TDA8083	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_VES1820	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_VES1X93	I2C_DRIVERID_EXP2
 
 /**
  *   when before_ioctl is registered and returns value 0, ioctl and after_ioctl
@@ -50,7 +68,7 @@
 	int (*ioctl) (struct dvb_frontend *frontend, unsigned int cmd, void *arg);
 	int (*after_ioctl) (struct dvb_frontend *frontend, unsigned int cmd, void *arg);
 	void (*notifier_callback) (fe_status_t s, void *data);
-	struct dvb_i2c_bus *i2c;
+	struct dvb_adapter *dvb_adapter;
 	void *before_after_data;   /*  can be used by hardware module... */
 	void *notifier_data;       /*  can be used by hardware module... */
 	void *data;                /*  can be used by hardware module... */
@@ -75,19 +93,21 @@
 #define FE_SLEEP              _IO('v', 80)
 #define FE_INIT               _IO('v', 81)
 #define FE_GET_TUNE_SETTINGS  _IOWR('v', 83, struct dvb_frontend_tune_settings)
-
+#define FE_REGISTER	      _IO  ('v', 84)
+#define FE_UNREGISTER	      _IO  ('v', 85)
 
 extern int
 dvb_register_frontend (int (*ioctl) (struct dvb_frontend *frontend,
 				     unsigned int cmd, void *arg),
-		       struct dvb_i2c_bus *i2c,
+		       struct dvb_adapter *dvb_adapter,
 		       void *data,
-		       struct dvb_frontend_info *info);
+		       struct dvb_frontend_info *info,
+		       struct module *module);
 
 extern int
-dvb_unregister_frontend (int (*ioctl) (struct dvb_frontend *frontend,
+dvb_unregister_frontend_new (int (*ioctl) (struct dvb_frontend *frontend,
 				       unsigned int cmd, void *arg),
-			 struct dvb_i2c_bus *i2c);
+			 struct dvb_adapter *dvb_adapter);
 
 
 /**
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_ksyms.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ksyms.c
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/dvb_ksyms.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ksyms.c	2004-08-18 19:52:17.000000000 +0200
@@ -24,17 +24,12 @@
 EXPORT_SYMBOL(dvbdmx_disconnect_frontend);
 
 EXPORT_SYMBOL(dvb_register_frontend);
-EXPORT_SYMBOL(dvb_unregister_frontend);
+EXPORT_SYMBOL(dvb_unregister_frontend_new);
 EXPORT_SYMBOL(dvb_add_frontend_ioctls);
 EXPORT_SYMBOL(dvb_remove_frontend_ioctls);
 EXPORT_SYMBOL(dvb_add_frontend_notifier);
 EXPORT_SYMBOL(dvb_remove_frontend_notifier);
 
-EXPORT_SYMBOL(dvb_register_i2c_bus);
-EXPORT_SYMBOL(dvb_unregister_i2c_bus);
-EXPORT_SYMBOL(dvb_register_i2c_device);
-EXPORT_SYMBOL(dvb_unregister_i2c_device);
-
 EXPORT_SYMBOL(dvb_net_init);
 EXPORT_SYMBOL(dvb_net_release);
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/Makefile linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/Makefile
--- xx-linux-2.6.8.1/drivers/media/dvb/dvb-core/Makefile	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/Makefile	2004-08-18 19:44:05.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 dvb-core-objs = dvbdev.o dmxdev.o dvb_demux.o dvb_filter.o \
-	        dvb_ca_en50221.o dvb_functions.o dvb_frontend.o \
-		dvb_i2c.o dvb_net.o dvb_ksyms.o dvb_ringbuffer.o
+	        dvb_ca_en50221.o dvb_frontend.o \
+		dvb_net.o dvb_ksyms.o dvb_ringbuffer.o
 
 obj-$(CONFIG_DVB_CORE) += dvb-core.o
diff -uraN a/drivers/media/dvb/dvb-core/dvb_functions.c b/drivers/media/dvb/dvb-core/dvb_functions.c
--- a/drivers/media/dvb/dvb-core/dvb_functions.c	2004-08-24 16:34:45.000000000 +0200
+++ b/drivers/media/dvb/dvb-core/dvb_functions.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,89 +0,0 @@
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/string.h>
-#include <linux/module.h>
-#include <linux/ioctl.h>
-#include <linux/slab.h>
-#include <linux/smp_lock.h>
-#include <asm/uaccess.h>
-
-void dvb_kernel_thread_setup (const char *thread_name)
-{
-        lock_kernel ();
-
-        daemonize (thread_name);
-
-        sigfillset (&current->blocked);
-
-        unlock_kernel ();
-}
-
-/* if the miracle happens and "generic_usercopy()" is included into
-   the kernel, then this can vanish. please don't make the mistake and
-   define this as video_usercopy(). this will introduce a dependecy
-   to the v4l "videodev.o" module, which is unnecessary for some
-   cards (ie. the budget dvb-cards don't need the v4l module...) */
-int dvb_usercopy(struct inode *inode, struct file *file,
-	             unsigned int cmd, unsigned long arg,
-		     int (*func)(struct inode *inode, struct file *file,
-		     unsigned int cmd, void *arg))
-{
-        char    sbuf[128];
-        void    *mbuf = NULL;
-        void    *parg = NULL;
-        int     err  = -EINVAL;
-
-        /*  Copy arguments into temp kernel buffer  */
-        switch (_IOC_DIR(cmd)) {
-        case _IOC_NONE:
-		/*
-		 * For this command, the pointer is actually an integer
-		 * argument.
-		 */
-                parg = (void *) arg;
-                break;
-        case _IOC_READ: /* some v4l ioctls are marked wrong ... */
-        case _IOC_WRITE:
-        case (_IOC_WRITE | _IOC_READ):
-                if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
-                        parg = sbuf;
-                } else {
-                        /* too big to allocate from stack */
-                        mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
-                        if (NULL == mbuf)
-                                return -ENOMEM;
-                        parg = mbuf;
-                }
-
-                err = -EFAULT;
-                if (copy_from_user(parg, (void __user *)arg, _IOC_SIZE(cmd)))
-                        goto out;
-                break;
-        }
-
-        /* call driver */
-        if ((err = func(inode, file, cmd, parg)) == -ENOIOCTLCMD)
-                err = -EINVAL;
-
-        if (err < 0)
-                goto out;
-
-        /*  Copy results into user buffer  */
-        switch (_IOC_DIR(cmd))
-        {
-        case _IOC_READ:
-        case (_IOC_WRITE | _IOC_READ):
-                if (copy_to_user((void __user *)arg, parg, _IOC_SIZE(cmd)))
-                        err = -EFAULT;
-                break;
-        }
-
-out:
-        if (mbuf)
-                kfree(mbuf);
-
-        return err;
-}
-
-EXPORT_SYMBOL(dvb_usercopy);
-EXPORT_SYMBOL(dvb_kernel_thread_setup);
diff -uraN a/drivers/media/dvb/dvb-core/dvb_functions.h b/drivers/media/dvb/dvb-core/dvb_functions.h
--- a/drivers/media/dvb/dvb-core/dvb_functions.h	2004-08-24 16:34:45.000000000 +0200
+++ b/drivers/media/dvb/dvb-core/dvb_functions.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,50 +0,0 @@
-/* 
- * dvb_functions.h: isolate some Linux specific stuff from the dvb-core
- *                  that can't be expressed as a one-liner
- *                  in order to make porting to other environments easier
- *
- * Copyright (C) 2003 Convergence GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Lesser Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
- */
-
-#ifndef __DVB_FUNCTIONS_H__
-#define __DVB_FUNCTIONS_H__
-
-/**
- *  a sleeping delay function, waits i ms
- *
- */
-static inline
-void dvb_delay(int i)
-{
-	current->state=TASK_INTERRUPTIBLE;
-	schedule_timeout((HZ*i)/1000);
-}
-
-/* we don't mess with video_usercopy() any more,
-we simply define out own dvb_usercopy(), which will hopefull become
-generic_usercopy()  someday... */
-
-extern int dvb_usercopy(struct inode *inode, struct file *file,
-	                    unsigned int cmd, unsigned long arg,
-			    int (*func)(struct inode *inode, struct file *file,
-			    unsigned int cmd, void *arg));
-
-extern void dvb_kernel_thread_setup (const char *thread_name);
-
-#endif
-
diff -uraN a/drivers/media/dvb/dvb-core/dvb_i2c.c b/drivers/media/dvb/dvb-core/dvb_i2c.c
--- a/drivers/media/dvb/dvb-core/dvb_i2c.c	2004-08-24 16:34:51.000000000 +0200
+++ b/drivers/media/dvb/dvb-core/dvb_i2c.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,290 +0,0 @@
-/*
- * dvb_i2c.h: simplified i2c interface for DVB adapters to get rid of i2c-core.c
- *
- * Copyright (C) 2002 Holger Waechtler for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
- */
-
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/list.h>
-#include <linux/module.h>
-#include <asm/semaphore.h>
-
-#include "dvb_i2c.h"
-#include "dvb_functions.h"
-
-
-struct dvb_i2c_device {
-	struct list_head list_head;
-	struct module *owner;
-	int (*attach) (struct dvb_i2c_bus *i2c, void **data);
-	void (*detach) (struct dvb_i2c_bus *i2c, void *data);
-	void *data;
-};
-
-LIST_HEAD(dvb_i2c_buslist);
-LIST_HEAD(dvb_i2c_devicelist);
-
-DECLARE_MUTEX(dvb_i2c_mutex);
-
-static int register_i2c_client (struct dvb_i2c_bus *i2c, struct dvb_i2c_device *dev)
-{
-	struct dvb_i2c_device *client;
-
-	if (!(client = kmalloc (sizeof (struct dvb_i2c_device), GFP_KERNEL)))
-		return -ENOMEM;
-
-	client->detach = dev->detach;
-	client->owner = dev->owner;
-	client->data = dev->data;
-
-	INIT_LIST_HEAD(&client->list_head);
-
-	list_add_tail (&client->list_head, &i2c->client_list);
-
-	return 0;
-}
-
-
-static void try_attach_device (struct dvb_i2c_bus *i2c, struct dvb_i2c_device *dev)
-{
-	if (dev->owner) {
-		if (!try_module_get(dev->owner))
-			return;
-	}
-
-	if (dev->attach (i2c, &dev->data) == 0) {
-		register_i2c_client (i2c, dev);
-	} else {
-		if (dev->owner)
-			module_put (dev->owner);
-	}
-}
-
-
-static void detach_device (struct dvb_i2c_bus *i2c, struct dvb_i2c_device *dev)
-{
-	dev->detach (i2c, dev->data);
-
-	if (dev->owner)
-		module_put (dev->owner);
-}
-
-
-static void unregister_i2c_client_from_bus (struct dvb_i2c_device *dev,
-				     struct dvb_i2c_bus *i2c)
-{
-	struct list_head *entry, *n;
-
-	list_for_each_safe (entry, n, &i2c->client_list) {
-                struct dvb_i2c_device *client;
-
-		client = list_entry (entry, struct dvb_i2c_device, list_head);
-
-		if (client->detach == dev->detach) {
-			list_del (entry);
-			detach_device (i2c, dev);
-		}
-	}
-}
-
-
-static void unregister_i2c_client_from_all_busses (struct dvb_i2c_device *dev)
-{
-	struct list_head *entry, *n;
-
-	list_for_each_safe (entry, n, &dvb_i2c_buslist) {
-                struct dvb_i2c_bus *i2c;
-
-		i2c = list_entry (entry, struct dvb_i2c_bus, list_head);
-
-		unregister_i2c_client_from_bus (dev, i2c);
-	}
-}
-
-
-static void unregister_all_clients_from_bus (struct dvb_i2c_bus *i2c)
-{
-	struct list_head *entry, *n;
-
-	list_for_each_safe (entry, n, &(i2c->client_list)) {
-		struct dvb_i2c_device *dev;
-
-		dev = list_entry (entry, struct dvb_i2c_device, list_head);
-
-		unregister_i2c_client_from_bus (dev, i2c);
-	}
-}
-
-
-static void probe_device_on_all_busses (struct dvb_i2c_device *dev)
-{
-	struct list_head *entry;
-
-	list_for_each (entry, &dvb_i2c_buslist) {
-                struct dvb_i2c_bus *i2c;
-
-		i2c = list_entry (entry, struct dvb_i2c_bus, list_head);
-
-		try_attach_device (i2c, dev);
-	}
-}
-
-
-static void probe_devices_on_bus (struct dvb_i2c_bus *i2c)
-{
-	struct list_head *entry;
-
-	list_for_each (entry, &dvb_i2c_devicelist) {
-		struct dvb_i2c_device *dev;
-
-		dev = list_entry (entry, struct dvb_i2c_device, list_head);
-
-		try_attach_device (i2c, dev);
-	}
-}
-
-
-static struct dvb_i2c_bus* dvb_find_i2c_bus (int (*xfer) (struct dvb_i2c_bus *i2c,
-		                                   const struct i2c_msg msgs[],
-						   int num),
-				      struct dvb_adapter *adapter,
-				      int id)
-{
-	struct list_head *entry;
-
-	list_for_each (entry, &dvb_i2c_buslist) {
-		struct dvb_i2c_bus *i2c;
-
-		i2c = list_entry (entry, struct dvb_i2c_bus, list_head);
-
-		if (i2c->xfer == xfer && i2c->adapter == adapter && i2c->id == id)
-			return i2c;
-	}
-
-	return NULL;
-}
-
-
-struct dvb_i2c_bus*
-dvb_register_i2c_bus (int (*xfer) (struct dvb_i2c_bus *i2c,
-				   const struct i2c_msg *msgs, int num),
-		      void *data, struct dvb_adapter *adapter, int id)
-{
-	struct dvb_i2c_bus *i2c;
-
-	if (down_interruptible (&dvb_i2c_mutex))
-		return NULL;
-
-	if (!(i2c = kmalloc (sizeof (struct dvb_i2c_bus), GFP_KERNEL))) {
-		up (&dvb_i2c_mutex);
-		return NULL;
-	}
-
-	INIT_LIST_HEAD(&i2c->list_head);
-	INIT_LIST_HEAD(&i2c->client_list);
-
-	i2c->xfer = xfer;
-	i2c->data = data;
-	i2c->adapter = adapter;
-	i2c->id = id;
-
-	probe_devices_on_bus (i2c);
-
-	list_add_tail (&i2c->list_head, &dvb_i2c_buslist);
-
-	up (&dvb_i2c_mutex);
-
-	return i2c;
-}
-
-
-void dvb_unregister_i2c_bus (int (*xfer) (struct dvb_i2c_bus *i2c,
-					  const struct i2c_msg msgs[], int num),
-			     struct dvb_adapter *adapter, int id)
-{
-	struct dvb_i2c_bus *i2c;
-
-	down (&dvb_i2c_mutex);
-
-	if ((i2c = dvb_find_i2c_bus (xfer, adapter, id))) {
-		unregister_all_clients_from_bus (i2c);
-		list_del (&i2c->list_head);
-		kfree (i2c);
-	}
-
-	up (&dvb_i2c_mutex);
-}
-
-
-int dvb_register_i2c_device (struct module *owner,
-			     int (*attach) (struct dvb_i2c_bus *i2c, void **data),
-			     void (*detach) (struct dvb_i2c_bus *i2c, void *data))
-{
-	struct dvb_i2c_device *entry;
-
-	if (down_interruptible (&dvb_i2c_mutex))
-		return -ERESTARTSYS;
-
-	if (!(entry = kmalloc (sizeof (struct dvb_i2c_device), GFP_KERNEL))) {
-		up(&dvb_i2c_mutex);
-		return -ENOMEM;
-	}
-
-	entry->owner = owner;
-	entry->attach = attach;
-	entry->detach = detach;
-
-	INIT_LIST_HEAD(&entry->list_head);
-
-	probe_device_on_all_busses (entry);
-
-	list_add_tail (&entry->list_head, &dvb_i2c_devicelist);
-
-	up (&dvb_i2c_mutex);
-
-	return 0;
-}
-
-
-int dvb_unregister_i2c_device (int (*attach) (struct dvb_i2c_bus *i2c, void **data))
-{
-	struct list_head *entry, *n;
-
-	down (&dvb_i2c_mutex);
-
-	list_for_each_safe (entry, n, &dvb_i2c_devicelist) {
-		struct dvb_i2c_device *dev;
-
-		dev = list_entry (entry, struct dvb_i2c_device, list_head);
-
-		if (dev->attach == attach) {
-			list_del (entry);
-			unregister_i2c_client_from_all_busses (dev);
-			kfree (entry);
-			up (&dvb_i2c_mutex);
-			return 0;
-                }
-        }
-
-	up (&dvb_i2c_mutex);
-
-        return -EINVAL;
-}
-
-
diff -uraN a/drivers/media/dvb/dvb-core/dvb_i2c.h b/drivers/media/dvb/dvb-core/dvb_i2c.h
--- a/drivers/media/dvb/dvb-core/dvb_i2c.h	2004-08-24 16:34:51.000000000 +0200
+++ b/drivers/media/dvb/dvb-core/dvb_i2c.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,63 +0,0 @@
-/*
- * dvb_i2c.h: i2c interface to get rid of i2c-core.c
- *
- * Copyright (C) 2002 Holger Waechtler for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#ifndef _DVB_I2C_H_
-#define _DVB_I2C_H_
-
-#include <linux/list.h>
-#include <linux/i2c.h>
-
-#include "dvbdev.h"
-
-
-struct dvb_i2c_bus {
-	struct list_head list_head;
-	int (*xfer) (struct dvb_i2c_bus *i2c, 
-		     const struct i2c_msg msgs[],
-		     int num);
-	void *data;
-	struct dvb_adapter *adapter;
-	int id;
-	struct list_head client_list;
-};
-
-
-extern struct dvb_i2c_bus*
-dvb_register_i2c_bus (int (*xfer) (struct dvb_i2c_bus *i2c,
-				   const struct i2c_msg *msgs, int num),
-		      void *data,
-		      struct dvb_adapter *adapter,
-		      int id);
-
-extern
-void dvb_unregister_i2c_bus (int (*xfer) (struct dvb_i2c_bus *i2c,
-					  const struct i2c_msg msgs[], int num),
-			     struct dvb_adapter *adapter,
-			     int id);
-
-
-extern int dvb_register_i2c_device (struct module *owner,
-				    int (*attach) (struct dvb_i2c_bus *i2c, void **data),
-				    void (*detach) (struct dvb_i2c_bus *i2c, void *data));
-
-extern int dvb_unregister_i2c_device (int (*attach) (struct dvb_i2c_bus *i2c, void **data));
-
-#endif
-
diff -uraNwB xx-linux-2.6.8.1/include/linux/dvb/frontend.h linux-2.6.8.1-patched/include/linux/dvb/frontend.h
--- xx-linux-2.6.8.1/include/linux/dvb/frontend.h	2004-07-19 19:39:37.000000000 +0200
+++ linux-2.6.8.1-patched/include/linux/dvb/frontend.h	2004-08-05 20:28:20.000000000 +0200
@@ -32,7 +32,8 @@
 typedef enum fe_type {
         FE_QPSK,
         FE_QAM,
-        FE_OFDM
+	FE_OFDM,
+	FE_ATSC
 } fe_type_t;
 
 
@@ -59,6 +60,8 @@
 	FE_CAN_BANDWIDTH_AUTO         = 0x40000,
 	FE_CAN_GUARD_INTERVAL_AUTO    = 0x80000,
 	FE_CAN_HIERARCHY_AUTO         = 0x100000,
+	FE_CAN_8VSB			= 0x200000,
+	FE_CAN_16VSB			= 0x400000,
 	FE_NEEDS_BENDING              = 0x20000000, // frontend requires frequency bending
 	FE_CAN_RECOVER                = 0x40000000, // frontend can recover from a cable unplug automatically
 	FE_CAN_MUTE_TS                = 0x80000000  // frontend can stop spurious TS data output
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-09-17 12:26:16.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-09-01 12:19:01.000000000 +0200
@@ -35,8 +35,7 @@
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
-#include <asm/rwsem.h>
-#include <asm/atomic.h>
+#include <linux/rwsem.h>
 
 #include "dvb_ca_en50221.h"
 #include "dvb_ringbuffer.h"
@@ -44,7 +43,7 @@
 static int dvb_ca_en50221_debug;
 
 module_param_named(cam_debug, dvb_ca_en50221_debug, int, 0644);
-MODULE_PARM_DESC(dvb_ca_en50221_debug, "enable verbose debug messages");
+MODULE_PARM_DESC(cam_debug, "enable verbose debug messages");
 
 #define dprintk if (dvb_ca_en50221_debug) printk
 
@@ -307,10 +306,6 @@
         /* we'll be determining these during this function */
         ca->slot_info[slot].da_irq_supported = 0;
 
-        /* reset the link interface. Note CAM IRQs are disabled */
-        if ((ret = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND, CMDREG_RS)) != 0) return ret;
-        if ((ret = dvb_ca_en50221_wait_if_status(ca, slot, STATUSREG_FR, HZ/10)) != 0) return ret;
-
         /* set the host link buffer size temporarily. it will be overwritten with the
          * real negotiated size later. */
         ca->slot_info[slot].link_buf_size = 2;
@@ -460,8 +455,8 @@
 
         /* is it a version we support? */
         if (strncmp(dvb_str + 8, "1.00", 4)) {
-                printk("dvb_ca: Unsupported DVB CAM module version %c%c%c%c\n",
-                        dvb_str[8], dvb_str[9], dvb_str[10], dvb_str[11]);
+                printk("dvb_ca adapter %d: Unsupported DVB CAM module version %c%c%c%c\n",
+		       ca->dvbdev->adapter->num, dvb_str[8], dvb_str[9], dvb_str[10], dvb_str[11]);
                 return -EINVAL;
         }
 
@@ -589,20 +584,20 @@
         /* check it will fit */
         if (ebuf == NULL) {
                 if (bytes_read > ca->slot_info[slot].link_buf_size) {
-                        printk("dvb_ca: CAM tried to send a buffer larger than the link buffer size!\n");
+                        printk("dvb_ca adapter %d: CAM tried to send a buffer larger than the link buffer size!\n", ca->dvbdev->adapter->num);
                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_LINKINIT;
                         status = -EIO;
                         goto exit;
                 }
                 if (bytes_read < 2) {
-                        printk("dvb_ca: CAM sent a buffer that was less than 2 bytes!\n");
+                        printk("dvb_ca adapter %d: CAM sent a buffer that was less than 2 bytes!\n", ca->dvbdev->adapter->num);
                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_LINKINIT;
                         status = -EIO;
                         goto exit;
                 }
         } else {
                 if (bytes_read > ecount) {
-                        printk("dvb_ca: CAM tried to send a buffer larger than the ecount size!\n");
+                        printk("dvb_ca adapter %d: CAM tried to send a buffer larger than the ecount size!\n", ca->dvbdev->adapter->num);
                         status = -EIO;
                         goto exit;
                 }
@@ -984,7 +978,7 @@
 
                         case DVB_CA_SLOTSTATE_WAITREADY:
                                 if (time_after(jiffies, ca->slot_info[slot].timeout)) {
-                                        printk("dvb_ca: PC card did not respond :(\n");
+                                        printk("dvb_ca adaptor %d: PC card did not respond :(\n", ca->dvbdev->adapter->num);
                                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_INVALID;
 				        dvb_ca_en50221_thread_update_delay(ca);
                                         break;
@@ -993,20 +987,20 @@
                                 break;
 
                         case DVB_CA_SLOTSTATE_VALIDATE:
-                                if (ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND, CMDREG_RS) != 0) {
-                                        printk("dvb_ca: Unable to reset CAM IF\n");
+                                if (dvb_ca_en50221_parse_attributes(ca, slot) != 0) {
+                                        printk("dvb_ca adapter %d: Invalid PC card inserted :(\n", ca->dvbdev->adapter->num);
                                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_INVALID;
                                         dvb_ca_en50221_thread_update_delay(ca);
                                         break;
                                 }
-                                if (dvb_ca_en50221_parse_attributes(ca, slot) != 0) {
-                                        printk("dvb_ca: Invalid PC card inserted :(\n");
+                                if (dvb_ca_en50221_set_configoption(ca, slot) != 0) {
+                                        printk("dvb_ca adapter %d: Unable to initialise CAM :(\n", ca->dvbdev->adapter->num);
                                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_INVALID;
 				        dvb_ca_en50221_thread_update_delay(ca);
                                         break;
                                 }
-                                if (dvb_ca_en50221_set_configoption(ca, slot) != 0) {
-                                        printk("dvb_ca: Unable to initialise CAM :(\n");
+                                if (ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND, CMDREG_RS) != 0) {
+                                        printk("dvb_ca adapter %d: Unable to reset CAM IF\n", ca->dvbdev->adapter->num);
                                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_INVALID;
 				        dvb_ca_en50221_thread_update_delay(ca);
                                         break;
@@ -1021,7 +1014,7 @@
 
                         case DVB_CA_SLOTSTATE_WAITFR:
                                 if (time_after(jiffies, ca->slot_info[slot].timeout)) {
-                                        printk("dvb_ca: DVB CAM did not respond :(\n");
+                                        printk("dvb_ca adapter %d: DVB CAM did not respond :(\n", ca->dvbdev->adapter->num);
                                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_INVALID;
 				        dvb_ca_en50221_thread_update_delay(ca);
                                         break;
@@ -1036,7 +1029,7 @@
 
                         case DVB_CA_SLOTSTATE_LINKINIT:
                                 if (dvb_ca_en50221_link_init(ca, slot) != 0) {
-                                        printk("dvb_ca: DVB CAM link initialisation failed :(\n");
+                                        printk("dvb_ca adapter %d: DVB CAM link initialisation failed :(\n", ca->dvbdev->adapter->num);
                                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_INVALID;
 			                dvb_ca_en50221_thread_update_delay(ca);
                                         break;
@@ -1044,7 +1037,7 @@
 
                                 rxbuf = vmalloc(RX_BUFFER_SIZE);
                                 if (rxbuf == NULL) {
-                                        printk("dvb_ca: Unable to allocate CAM rx buffer :(\n");
+                                        printk("dvb_ca adapter %d: Unable to allocate CAM rx buffer :(\n", ca->dvbdev->adapter->num);
                                         ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_INVALID;
 				        dvb_ca_en50221_thread_update_delay(ca);
                                         break;
@@ -1054,7 +1047,7 @@
                                 ca->pub->slot_ts_enable(ca->pub, slot);
                                 ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_RUNNING;
                                 dvb_ca_en50221_thread_update_delay(ca);
-                                printk("dvb_ca: DVB CAM detected and initialised successfully\n");
+                                printk("dvb_ca adapter %d: DVB CAM detected and initialised successfully\n", ca->dvbdev->adapter->num);
                                 break;
 
                         case DVB_CA_SLOTSTATE_RUNNING:
@@ -1351,7 +1344,7 @@
         pktlen = 2;
         do {
                 if (idx == -1) {
-                        printk("dvb_ca: BUG: read packet ended before last_fragment encountered\n");
+                        printk("dvb_ca adapter %d: BUG: read packet ended before last_fragment encountered\n", ca->dvbdev->adapter->num);
                         status = -EIO;
                         goto exit;
                 }
@@ -1617,7 +1612,7 @@
         /* shutdown the thread if there was one */
         if (ca->thread_pid) {
                 if (kill_proc(ca->thread_pid, 0, 1) == -ESRCH) {
-                        printk("dvb_ca_release: thread PID %d already died\n", ca->thread_pid);
+                        printk("dvb_ca_release adapter %d: thread PID %d already died\n", ca->dvbdev->adapter->num, ca->thread_pid);
                 } else {
                         ca->exit = 1;
                         mb();
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_demux.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_demux.c	2004-09-17 12:26:16.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_demux.c	2004-09-15 10:26:44.000000000 +0200
@@ -569,7 +570,7 @@
 
 static void dvb_demux_feed_add(struct dvb_demux_feed *feed)
 {
-	spin_lock(&feed->demux->lock);
+	spin_lock_irq(&feed->demux->lock);
 	if (dvb_demux_feed_find(feed)) {
 		printk(KERN_ERR "%s: feed already in list (type=%x state=%x pid=%x)\n",
 				__FUNCTION__, feed->type, feed->state, feed->pid);
@@ -578,12 +579,12 @@
 
 	list_add(&feed->list_head, &feed->demux->feed_list);
 out:
-	spin_unlock(&feed->demux->lock);
+	spin_unlock_irq(&feed->demux->lock);
 }
 
 static void dvb_demux_feed_del(struct dvb_demux_feed *feed)
 {
-	spin_lock(&feed->demux->lock);
+	spin_lock_irq(&feed->demux->lock);
 	if (!(dvb_demux_feed_find(feed))) {
 		printk(KERN_ERR "%s: feed not in list (type=%x state=%x pid=%x)\n",
 				__FUNCTION__, feed->type, feed->state, feed->pid);
@@ -592,7 +593,7 @@
 
 	list_del(&feed->list_head);
 out:
-	spin_unlock(&feed->demux->lock);
+	spin_unlock_irq(&feed->demux->lock);
 }
 
 static int dmx_ts_feed_set (struct dmx_ts_feed* ts_feed, u16 pid, int ts_type, 
diff -uraN a/drivers/media/dvb/dvb-core/dvb_net.c b/drivers/media/dvb/dvb-core/dvb_net.c
--- a/drivers/media/dvb/dvb-core/dvb_net.c	2004-09-17 14:31:22.000000000 +0200
+++ b/drivers/media/dvb/dvb-core/dvb_net.c	2004-09-17 14:31:34.000000000 +0200
@@ -40,8 +40,6 @@
 
 #include "dvb_demux.h"
 #include "dvb_net.h"
-#include "dvb_functions.h"
-
 
 static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
 {

--------------050708090004060102070404--
