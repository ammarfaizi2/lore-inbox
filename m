Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263981AbTEFQik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTEFQWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:22:38 -0400
Received: from mail.convergence.de ([212.84.236.4]:6857 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263931AbTEFQN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:13:59 -0400
Message-ID: <3EB7DE40.2040403@convergence.de>
Date: Tue, 06 May 2003 18:09:36 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][4-11] update the av7110 driver
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060304000809090002070409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060304000809090002070409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch updates the av7110 (full-featured DVB-S/C/T cards) and the 
budget (Transport-Stream (TS) only cards) driver.

Fixed problems for both:
- replaced ddelay() wait function with generic dvb_delay() implementation

Fixed stuff for av7110:
- new DATA_MPEG_VIDEO_EVENT for direct mpeg2 video playback
- added support for DVB-C cards with MSP3400 mixer and analog tuner
- fixed up the av7110_ir handler and especially the write_proc() 
function; this fixed the bug the Stanford Checker has found

Please review and apply.

Thanks
Michael Hunold.






--------------060304000809090002070409
Content-Type: text/plain;
 name="04-dvb-drivers-update.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="04-dvb-drivers-update.diff"

diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/av7110.c linux-2.5.69.patch/drivers/media/dvb/ttpci/av7110.c
--- linux-2.5.69/drivers/media/dvb/ttpci/av7110.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/av7110.c	2003-05-06 16:45:30.000000000 +0200
@@ -75,6 +75,8 @@
 
 #include "dvb_i2c.h"
 #include "dvb_frontend.h"
+#include "dvb_functions.h"
+
 
 #if 1 
 	#define DEBUG_VARIABLE av7110_debug
@@ -94,6 +96,7 @@
 static inline u8 i2c_readreg(av7110_t *av7110, u8 id, u8 reg);
 static int  outcom(av7110_t *av7110, int type, int com, int num, ...);
 static void SetMode(av7110_t *av7110, int mode);
+static void dvb_video_add_event (av7110_t *av7110, struct video_event *event);
 
 void pes_to_ts(u8 const *buf, long int length, u16 pid, p2t_t *p);
 void p_to_t(u8 const *buf, long int length, u16 pid, u8 *counter, struct dvb_demux_feed *feed);
@@ -107,20 +110,7 @@
 
 int av7110_num = 0;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-        #define KBUILD_MODNAME av7110
-#endif
-
-/****************************************************************************
- * General helper functions
- ****************************************************************************/
-
-static inline void ddelay(int i) 
-{
-        current->state=TASK_INTERRUPTIBLE;
-        schedule_timeout((HZ*i)/100);
-}
-
+#define FW_CI_LL_SUPPORT(arm_app) (((arm_app) >> 16) & 0x8000)
 
 /****************************************************************************
  * DEBI functions
@@ -326,8 +316,10 @@
                 printk("OOPS, no current->files\n");
                 reset_arm(av7110);
         }
-        ddelay(10); 
+
+        dvb_delay(100); 
         restart_feeds(av7110);
+        outcom(av7110, COMTYPE_PIDFILTER, SetIR, 1, av7110->ir_config);
 }
 
 static void 
@@ -347,20 +339,8 @@
 
 	DEB_EE(("av7110: %p\n",av7110));
 	
-	lock_kernel();
-#if 0
-        daemonize();
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-        reparent_to_init ();
-#endif
-#else
-        exit_mm(current);
-        current->session=current->pgrp=1;
-#endif
-	sigfillset(&current->blocked);
-	strcpy(current->comm, "arm_mon");
+	dvb_kernel_thread_setup ("arm_mon");
 	av7110->arm_thread = current;
-	unlock_kernel();
 
 	while (!av7110->arm_rmmod && !signal_pending(current)) {
                 interruptible_sleep_on_timeout(&av7110->arm_wait, 5*HZ);
@@ -559,8 +539,10 @@
 	else
 		last = av7110;
 
-	if (av7110)
+	if (av7110) {
 		outcom(av7110, COMTYPE_PIDFILTER, SetIR, 1, ir_config);
+		av7110->ir_config = ir_config;
+	}
 }
 
 static void (*irc_handler)(u32);
@@ -731,8 +713,10 @@
 
         if (type==-1) {
                 printk("DEBI irq oops @ %ld, psr:0x%08x, ssr:0x%08x\n",jiffies,saa7146_read(av7110->dev,PSR),saa7146_read(av7110->dev,SSR));
+		spin_lock(&av7110->debilock);
                 ARM_ClearMailBox(av7110);
                 ARM_ClearIrq(av7110);
+		spin_unlock(&av7110->debilock);
                 return;
         }
         av7110->debitype=-1;
@@ -926,6 +910,47 @@
         case DATA_PES_PLAY:
                 break;
 
+	case DATA_MPEG_VIDEO_EVENT:
+	{
+		u32 h_ar;
+		struct video_event event;
+
+                av7110->video_size.w = irdebi(av7110, DEBINOSWAP, STATUS_MPEG_WIDTH, 0, 2);
+                h_ar = irdebi(av7110, DEBINOSWAP, STATUS_MPEG_HEIGHT_AR, 0, 2);
+
+                iwdebi(av7110, DEBINOSWAP, IRQ_STATE_EXT, 0, 2);
+                iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
+
+		av7110->video_size.h = h_ar & 0xfff;
+		DEB_D(("GPIO0 irq: DATA_MPEG_VIDEO_EVENT: w/h/ar = %u/%u/%u\n",
+				av7110->video_size.w,
+				av7110->video_size.h,
+				av7110->video_size.aspect_ratio));
+
+		event.type = VIDEO_EVENT_SIZE_CHANGED;
+		event.u.size.w = av7110->video_size.w;
+		event.u.size.h = av7110->video_size.h;
+		switch ((h_ar >> 12) & 0xf)
+		{
+		case 3:
+			av7110->video_size.aspect_ratio = VIDEO_FORMAT_16_9;
+			event.u.size.aspect_ratio = VIDEO_FORMAT_16_9;
+			av7110->videostate.video_format = VIDEO_FORMAT_16_9;
+			break;
+		case 4:
+			av7110->video_size.aspect_ratio = VIDEO_FORMAT_221_1;
+			event.u.size.aspect_ratio = VIDEO_FORMAT_221_1;
+			av7110->videostate.video_format = VIDEO_FORMAT_221_1;
+			break;
+		default:
+			av7110->video_size.aspect_ratio = VIDEO_FORMAT_4_3;
+			event.u.size.aspect_ratio = VIDEO_FORMAT_4_3;
+			av7110->videostate.video_format = VIDEO_FORMAT_4_3;
+		}
+		dvb_video_add_event(av7110, &event);
+		break;
+	}
+
         case DATA_CI_PUT:
         {
                 int avail;
@@ -1095,7 +1120,7 @@
         start = jiffies;
         while ( rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 ) )
         {
-                ddelay(1);
+                dvb_delay(1);
                 if ((jiffies - start) > ARM_WAIT_FREE) {
 			printk(KERN_ERR "%s: timeout waiting for COMMAND idle\n", __FUNCTION__);
                         return -1;
@@ -1106,7 +1131,7 @@
         start = jiffies;
         while ( rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 ) )
         {
-                ddelay(1);
+                dvb_delay(1);
                 if ((jiffies - start) > ARM_WAIT_SHAKE) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
                         return -1;
@@ -1117,7 +1142,7 @@
         start = jiffies;
         while ( rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2) & OSDQFull )
         {
-                ddelay(1);
+                dvb_delay(1);
                 if ((jiffies - start) > ARM_WAIT_OSD) {
 			printk(KERN_ERR "%s: timeout waiting for !OSDQFull\n", __FUNCTION__);
 			return -1;
@@ -1137,7 +1162,7 @@
         start = jiffies;
         while ( rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 ) )
         {
-                ddelay(1);
+                dvb_delay(1);
                 if ((jiffies - start) > ARM_WAIT_FREE) {
                         printk(KERN_ERR "%s: timeout waiting for COMMAND to complete\n", __FUNCTION__);
                         return -1;
@@ -1257,7 +1282,7 @@
         while ( rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2) )
         {
 #ifdef _NOHANDSHAKE
-                ddelay(1);
+                dvb_delay(1);
 #endif
                 if ((jiffies - start) > ARM_WAIT_FREE) {
 			printk("%s: timeout waiting for COMMAND to complete\n", __FUNCTION__);
@@ -1269,7 +1294,7 @@
 #ifndef _NOHANDSHAKE
         start = jiffies;
         while ( rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 ) ) {
-                ddelay(1);
+                dvb_delay(1);
                 if ((jiffies - start) > ARM_WAIT_SHAKE) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
                         up(&av7110->dcomlock);
@@ -1315,6 +1340,19 @@
  * Firmware commands 
  ****************************************************************************/
 
+static inline int
+msp_writereg(av7110_t *av7110, u8 dev, u16 reg, u16 val)
+{
+        u8 msg[5]={ dev, reg>>8, reg&0xff, val>>8 , val&0xff }; 
+        struct dvb_i2c_bus *i2c = av7110->i2c_bus;
+        struct i2c_msg msgs;
+
+        msgs.flags=0;
+        msgs.addr=0x40;
+        msgs.len=5;
+        msgs.buf=msg;
+        return i2c->xfer(i2c, &msgs, 1);
+}
 
 inline static int 
 SendDAC(av7110_t *av7110, u8 addr, u8 data)
@@ -1327,7 +1365,7 @@
 static int
 SetVolume(av7110_t *av7110, int volleft, int volright)
 {
-        int err;
+        int err, vol, val, balance = 0;
         
  	DEB_EE(("av7110: %p\n",av7110));
 
@@ -1349,6 +1387,17 @@
                 i2c_writereg(av7110, 0x20, 0x03, volleft);
                 i2c_writereg(av7110, 0x20, 0x04, volright);
                 return 0;
+
+        case DVB_ADAC_MSP:
+                vol  = (volleft > volright) ? volleft : volright;
+		val     = (vol * 0x73 / 255) << 8;
+		if (vol > 0) {
+		       balance = ((volright-volleft) * 127) / vol;
+		}
+		msp_writereg(av7110, 0x12, 0x0001, balance << 8);
+		msp_writereg(av7110, 0x12, 0x0000, val); /* loudspeaker */
+		msp_writereg(av7110, 0x12, 0x0006, val); /* headphonesr */
+		return 0;
         }
         return 0;
 }
@@ -1404,7 +1453,7 @@
 		return -ERESTARTSYS;
         start = jiffies;
         while ( rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2 ) ) {
-                ddelay(1); 
+                dvb_delay(1); 
                 if ((jiffies - start) > ARM_WAIT_OSD) {
                         printk(KERN_ERR "%s: timeout waiting for BUFF1_BASE == 0\n", __FUNCTION__);
                         up(&av7110->dcomlock);
@@ -1427,7 +1476,7 @@
 
         start = jiffies;
         while ( rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2 ) ) {
-                ddelay(1);
+                dvb_delay(1);
                 if ((jiffies - start) > ARM_WAIT_OSD) {
                         printk(KERN_ERR "%s: timeout waiting for BUFF1_BASE == 0\n", __FUNCTION__);
                         up(&av7110->dcomlock);
@@ -1437,7 +1486,7 @@
 #ifndef _NOHANDSHAKE
         start = jiffies;
         while ( rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 ) ) {
-                ddelay(1);
+                dvb_delay(1);
                 if ((jiffies - start) > ARM_WAIT_SHAKE) {
                         printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
                         up(&av7110->dcomlock);
@@ -1533,7 +1582,7 @@
                                 break;
                         schedule();
                 }
-                current->state=TASK_RUNNING;
+                set_current_state(TASK_RUNNING);
                 remove_wait_queue(&av7110->bmpq, &wait);
         }
         if (av7110->bmp_state==BMP_LOADING)
@@ -1591,7 +1640,7 @@
                                 break;
                         schedule();
                 }
-                current->state=TASK_RUNNING;
+                set_current_state(TASK_RUNNING);
                 remove_wait_queue(&av7110->bmpq, &wait);
         }
         if (av7110->bmp_state==BMP_LOADED)
@@ -1837,7 +1886,7 @@
                 av7110->arm_rtsl, av7110->arm_vid, av7110->arm_app);
 
 	/* print firmware capabilities */
-	if ((av7110->arm_app >> 16) & 0x8000)
+	if (FW_CI_LL_SUPPORT(av7110->arm_app))
 		printk ("DVB: AV711%d(%d) - firmware supports CI link layer interface\n",
 				av7110->avtype, av7110->dvb_adapter->num);
 	else
@@ -1986,7 +2035,7 @@
         
         wait_for_debi_done(av7110);
         saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
-        current->state=TASK_INTERRUPTIBLE;
+        set_current_state(TASK_INTERRUPTIBLE);
         schedule_timeout(HZ);
         
         DEB_D(("bootarm: load dram code\n"));
@@ -2025,8 +2074,13 @@
  	DEB_EE(("av7110: %p\n",av7110));
 
 	if (vpid == 0x1fff || apid == 0x1fff ||
-	    ttpid == 0x1fff || subpid == 0x1fff || pcrpid == 0x1fff)
+	    ttpid == 0x1fff || subpid == 0x1fff || pcrpid == 0x1fff) {
 		vpid = apid = ttpid = subpid = pcrpid = 0;
+		av7110->pids[DMX_PES_VIDEO] = 0;
+		av7110->pids[DMX_PES_AUDIO] = 0;
+		av7110->pids[DMX_PES_TELETEXT] = 0;
+		av7110->pids[DMX_PES_PCR] = 0;
+	}
 
         return outcom(av7110, COMTYPE_PIDFILTER, MultiPID, 5, 
                       pcrpid, vpid, apid, ttpid, subpid);
@@ -2048,8 +2102,10 @@
 
         av7110->pids[DMX_PES_SUBTITLE]=0;
 
-        if (av7110->fe_synced) 
+        if (av7110->fe_synced) {
+                pcrpid = av7110->pids[DMX_PES_PCR];
                 SetPIDs(av7110, vpid, apid, ttpid, subpid, pcrpid);
+        }
 
         up(&av7110->pid_mutex);
 }
@@ -2158,20 +2214,6 @@
         return i2c->xfer (i2c, &msgs, 1);
 }
 
-static inline int
-msp_writereg(av7110_t *av7110, u8 dev, u16 reg, u16 val)
-{
-        u8 msg[5]={ dev, reg>>8, reg&0xff, val>>8 , val&0xff }; 
-        struct dvb_i2c_bus *i2c = av7110->i2c_bus;
-        struct i2c_msg msgs;
-
-        msgs.flags=0;
-        msgs.addr=0x40;
-        msgs.len=5;
-        msgs.buf=msg;
-        return i2c->xfer(i2c, &msgs, 1);
-}
-
 static inline u8
 i2c_readreg(av7110_t *av7110, u8 id, u8 reg)
 {
@@ -2809,7 +2851,7 @@
                 StartHWFilter(dvbdmxfeed->filter); 
                 return;
         }
-        if (dvbdmxfeed->pes_type<=2)
+        if (dvbdmxfeed->pes_type<=2 || dvbdmxfeed->pes_type==4)
                 ChangePIDs(av7110, npids[1], npids[0], npids[2], npids[3], npids[4]);
 
         if (dvbdmxfeed->pes_type<2 && npids[0])
@@ -2990,6 +3032,46 @@
                 AV_StartPlay(av7110, mode);
 }
 
+static int dvb_get_stc(dmx_demux_t *demux, unsigned int num,
+		uint64_t *stc, unsigned int *base)
+{
+	int ret;
+        u16 fwstc[4];
+        u16 tag = ((COMTYPE_REQUEST << 8) + ReqSTC);
+	struct dvb_demux *dvbdemux;
+	av7110_t *av7110;
+
+	/* pointer casting paranoia... */
+	if (!demux)
+		BUG();
+	dvbdemux = (struct dvb_demux *) demux->priv;
+	if (!dvbdemux)
+		BUG();
+	av7110 = (av7110_t *) dvbdemux->priv;
+
+	DEB_EE(("av7110: %p\n",av7110));
+
+	if (num != 0)
+		return -EINVAL;
+
+        ret = CommandRequest(av7110, &tag, 0, fwstc, 4);
+	if (ret) {
+		printk(KERN_ERR "%s: CommandRequest error\n", __FUNCTION__);
+		return -EIO;
+	}
+	DEB_EE(("av7110: fwstc = %04hx %04hx %04hx %04hx\n",
+			fwstc[0], fwstc[1], fwstc[2], fwstc[3]));
+
+	*stc =  (((uint64_t)fwstc[2] & 1) << 32) |
+		(((uint64_t)fwstc[1])     << 16) | ((uint64_t)fwstc[0]);
+	*base = 1;
+
+	DEB_EE(("av7110: stc = %llu\n", *stc));
+
+	return 0;
+}
+
+
 /******************************************************************************
  * SEC device file operations
  ******************************************************************************/
@@ -3018,8 +3100,7 @@
 	case FE_DISEQC_SEND_MASTER_CMD:
 	{
 		struct dvb_diseqc_master_cmd *cmd = arg;
-
-		SendDiSEqCMsg (av7110, cmd->msg_len, cmd->msg, 0);
+		SendDiSEqCMsg (av7110, cmd->msg_len, cmd->msg, -1);
 		break;
 	}
 
@@ -3196,7 +3277,7 @@
                 
                 cap.slot_num=2;
 #ifdef NEW_CI
-                cap.slot_type=CA_CI_LINK|CA_DESCR;
+                cap.slot_type=(FW_CI_LL_SUPPORT(av7110->arm_app) ? CA_CI_LINK : CA_CI) | CA_DESCR;
 #else
                 cap.slot_type=CA_CI|CA_DESCR;
 #endif
@@ -3214,7 +3295,7 @@
                         return -EINVAL;
                 av7110->ci_slot[info->num].num = info->num;
 #ifdef NEW_CI
-                av7110->ci_slot[info->num].type = CA_CI_LINK;
+                av7110->ci_slot[info->num].type = FW_CI_LL_SUPPORT(av7110->arm_app) ? CA_CI_LINK : CA_CI;
 #else
                 av7110->ci_slot[info->num].type = CA_CI;
 #endif
@@ -3285,6 +3366,74 @@
 
 
 /******************************************************************************
+ * Video MPEG decoder events
+ ******************************************************************************/
+static
+void dvb_video_add_event (av7110_t *av7110, struct video_event *event)
+{
+	struct dvb_video_events *events = &av7110->video_events;
+	int wp;
+
+	DEB_D(("\n"));
+
+	spin_lock_bh(&events->lock);
+
+	wp = (events->eventw + 1) % MAX_VIDEO_EVENT;
+
+	if (wp == events->eventr) {
+		events->overflow = 1;
+		events->eventr = (events->eventr + 1) % MAX_VIDEO_EVENT;
+	}
+
+	//FIXME: timestamp?
+	memcpy(&events->events[events->eventw], event, sizeof(struct video_event));
+
+	events->eventw = wp;
+
+	spin_unlock_bh(&events->lock);
+
+	wake_up_interruptible (&events->wait_queue);
+}
+
+
+static
+int dvb_video_get_event (av7110_t *av7110, struct video_event *event, int flags)
+{
+	struct dvb_video_events *events = &av7110->video_events;
+
+	DEB_D(("\n"));
+
+	if (events->overflow) {
+                events->overflow = 0;
+                return -EOVERFLOW;
+        }
+
+        if (events->eventw == events->eventr) {
+		int ret;
+
+                if (flags & O_NONBLOCK)
+                        return -EWOULDBLOCK;
+
+                ret = wait_event_interruptible (events->wait_queue,
+                                                events->eventw != events->eventr);
+                if (ret < 0)
+                        return ret;
+        }
+
+	spin_lock_bh(&events->lock);
+
+	memcpy (event, &events->events[events->eventr],
+		sizeof(struct video_event));
+
+        events->eventr = (events->eventr + 1) % MAX_VIDEO_EVENT;
+
+	spin_unlock_bh(&events->lock);
+
+        return 0;
+}
+
+
+/******************************************************************************
  * DVB device file operations
  ******************************************************************************/
 
@@ -3298,12 +3447,16 @@
 	DEB_EE(("av7110: %p\n",av7110));
 
 	poll_wait(file, &av7110->avout.queue, wait);
+	poll_wait(file, &av7110->video_events.wait_queue, wait);
+
+	if (av7110->video_events.eventw != av7110->video_events.eventr)
+		mask = POLLPRI;
 
 	if (av7110->playing) {
                 if (FREE_COND)
                         mask |= (POLLOUT | POLLWRNORM);
         } else /* if not playing: may play if asked for */
-                mask = (POLLOUT | POLLWRNORM);
+                mask |= (POLLOUT | POLLWRNORM);
 
         return mask;
 }
@@ -3441,8 +3594,12 @@
                 break;
                 
         case VIDEO_GET_EVENT:
-                //FIXME: write firmware support for this
-                ret=-EOPNOTSUPP;
+                ret=dvb_video_get_event(av7110, parg, file->f_flags);
+		break;
+
+	case VIDEO_GET_SIZE:
+                memcpy(parg, &av7110->video_size, sizeof(video_size_t));
+		break;
                 
         case VIDEO_SET_DISPLAY_FORMAT:
         {
@@ -3488,6 +3645,7 @@
         { 
                 struct video_still_picture *pic=
                         (struct video_still_picture *) parg;
+                av7110->videostate.stream_source = VIDEO_SOURCE_MEMORY;
                 dvb_ringbuffer_flush_spinlock_wakeup(&av7110->avout);
                 play_iframe(av7110, pic->iFrame, pic->size, 
                             file->f_flags&O_NONBLOCK);
@@ -3692,6 +3850,11 @@
         av7110->video_blank=1;
         av7110->audiostate.AV_sync_state=1;
         av7110->videostate.stream_source=VIDEO_SOURCE_DEMUX;
+
+	if ((file->f_flags & O_ACCMODE) != O_RDONLY)
+		/*  empty event queue */
+		av7110->video_events.eventr = av7110->video_events.eventw = 0;
+
         return 0;
 }
 
@@ -3823,7 +3986,6 @@
 int av7110_register(av7110_t *av7110)
 {
         int ret, i;
-        dmx_frontend_t *dvbfront=&av7110->hw_frontend;
         struct dvb_demux *dvbdemux=&av7110->demux;
 
 	DEB_EE(("av7110: %p\n",av7110));
@@ -3856,8 +4018,6 @@
 	av7110->videostate.display_format=VIDEO_CENTER_CUT_OUT;
         av7110->display_ar=VIDEO_FORMAT_4_3;
 
-        memcpy(av7110->demux_id, "demux0_0", 9);
-        av7110->demux_id[5] = av7110->dvb_adapter->num + '0';
         dvbdemux->priv = (void *) av7110;
 
 	for (i=0; i<32; i++)
@@ -3868,18 +4028,11 @@
 	dvbdemux->start_feed = av7110_start_feed;
 	dvbdemux->stop_feed = av7110_stop_feed;
 	dvbdemux->write_to_decoder = av7110_write_to_decoder;
-	dvbdemux->dmx.vendor = "TI";
-	dvbdemux->dmx.model = "AV7110";
-	dvbdemux->dmx.id = av7110->demux_id;
 	dvbdemux->dmx.capabilities = (DMX_TS_FILTERING | DMX_SECTION_FILTERING |
 				      DMX_MEMORY_BASED_FILTERING);
 
 	dvb_dmx_init(&av7110->demux);
-
-	dvbfront->id = "hw_frontend";
-	dvbfront->vendor = "VLSI";
-	dvbfront->model = "DVB Frontend";
-	dvbfront->source = DMX_FRONTEND_0;
+	av7110->demux.dmx.get_stc = dvb_get_stc;
 
 	av7110->dmxdev.filternum = 32;
 	av7110->dmxdev.demux = &dvbdemux->dmx;
@@ -3887,14 +4040,13 @@
         
 	dvb_dmxdev_init(&av7110->dmxdev, av7110->dvb_adapter);
 
-        ret = dvbdemux->dmx.add_frontend(&dvbdemux->dmx, 
-					 &av7110->hw_frontend);
+        av7110->hw_frontend.source = DMX_FRONTEND_0;
+
+        ret = dvbdemux->dmx.add_frontend(&dvbdemux->dmx, &av7110->hw_frontend);
+
         if (ret < 0)
                 return ret;
         
-        av7110->mem_frontend.id = "mem_frontend";
-        av7110->mem_frontend.vendor = "memory";
-        av7110->mem_frontend.model = "sw";
         av7110->mem_frontend.source = DMX_MEMORY_FE;
 
 	ret = dvbdemux->dmx.add_frontend(&dvbdemux->dmx, &av7110->mem_frontend);
@@ -3907,6 +4059,12 @@
         if (ret < 0)
                 return ret;
 
+	init_waitqueue_head(&av7110->video_events.wait_queue);
+	spin_lock_init(&av7110->video_events.lock);
+	av7110->video_events.eventw = av7110->video_events.eventr = 0;
+	av7110->video_events.overflow = 0;
+	memset(&av7110->video_size, 0, sizeof (video_size_t));
+
 	dvb_register_device(av7110->dvb_adapter, &av7110->video_dev,
 			    &dvbdev_video, av7110, DVB_DEVICE_VIDEO);
           
@@ -4132,18 +4290,19 @@
 		i2c_writereg(av7110, 0x20, 0x02, 0x49);
 		i2c_writereg(av7110, 0x20, 0x03, 0x00);
 		i2c_writereg(av7110, 0x20, 0x04, 0x00);
-	}
-                
 	
 	/**
-	 * some special handling for the Siemens DVB-C card...
+	 * some special handling for the Siemens DVB-C cards...
 	 */
-	if (dev->pci->subsystem_vendor == 0x110a) {
+	} else if ((dev->pci->subsystem_vendor == 0x110a) ||
+	    ((dev->pci->subsystem_vendor == 0x13c2) &&
+	     (dev->pci->subsystem_device == 0x1004))) {
 		if (i2c_writereg(av7110, 0x80, 0x0, 0x80)==1) {
 			i2c_writereg(av7110, 0x80, 0x0, 0);
 			printk ("av7110: DVB-C analog module detected, "
 				"initializing MSP3400\n");
-			ddelay(10);
+                        av7110->adac_type = DVB_ADAC_MSP;
+			dvb_delay(100);
 			msp_writereg(av7110, 0x12, 0x0013, 0x0c00);
 			msp_writereg(av7110, 0x12, 0x0000, 0x7f00); // loudspeaker + headphone
 			msp_writereg(av7110, 0x12, 0x0008, 0x0220); // loudspeaker source
@@ -4151,17 +4310,18 @@
 			msp_writereg(av7110, 0x12, 0x000a, 0x0220); // SCART 1 source
 			msp_writereg(av7110, 0x12, 0x0007, 0x7f00); // SCART 1 volume
 			msp_writereg(av7110, 0x12, 0x000d, 0x4800); // prescale SCART
-		}
-
+		} else
+		        av7110->adac_type = DVB_ADAC_NONE;
 
 		// switch DVB SCART on
 		outcom(av7110, COMTYPE_AUDIODAC, MainSwitch, 1, 0);
 		outcom(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, 1);
 		//saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // RGB on, SCART pin 16
 		//saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO); // SCARTpin 8
-		av7110->adac_type = DVB_ADAC_NONE;
 	}
 	
+	SetVolume(av7110, 0xff, 0xff);
+
 	av7110_setup_irc_config (av7110, 0);
 	av7110_register(av7110);
 	
@@ -4197,7 +4357,7 @@
 	wake_up_interruptible(&av7110->arm_wait);
 
 	while (av7110->arm_thread)
-		ddelay(1);
+		dvb_delay(1);
 
 	dvb_unregister(av7110);
 	
@@ -4288,6 +4448,8 @@
 	}
 };
 
+MODULE_DEVICE_TABLE(pci, pci_tbl);
+
 static int std_callback(struct saa7146_dev* dev, struct saa7146_standard *std)
 {
 	av7110_t *av7110 = (av7110_t*)dev->ext_priv;
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/av7110.h linux-2.5.69.patch/drivers/media/dvb/ttpci/av7110.h
--- linux-2.5.69/drivers/media/dvb/ttpci/av7110.h	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/av7110.h	2003-04-24 09:38:18.000000000 +0200
@@ -127,9 +127,9 @@
 #define	SECTION_CYCLE		0x02
 #define	SECTION_CONTINUOS	0x04
 #define	SECTION_MODE		0x06
-#define SECTION_IPMPE		0x0C	// bis zu 4k gro_
-#define SECTION_HIGH_SPEED	0x1C	// vergrv_erter Puffer f|r High Speed Filter
-#define DATA_PIPING_FLAG	0x20	// f|r Data Piping Filter
+#define SECTION_IPMPE		0x0C	// bis zu 4k groß
+#define SECTION_HIGH_SPEED	0x1C	// vergrößerter Puffer für High Speed Filter
+#define DATA_PIPING_FLAG	0x20	// für Data Piping Filter
 
 #define	PBUFSIZE_NONE 0x0000
 #define	PBUFSIZE_1P   0x0100
@@ -203,7 +203,9 @@
 	CrashCounter,
 	ReqVersion,
 	ReqVCXO,
-	ReqRegister
+	ReqRegister,
+	ReqSecFilterError,
+	ReqSTC
 } REQCOM;
 
 typedef enum  {
@@ -275,6 +277,7 @@
 #define DATA_STREAMING           0x0a
 #define DATA_CI_GET              0x0b
 #define DATA_CI_PUT              0x0c
+#define DATA_MPEG_VIDEO_EVENT    0x0d
 
 #define DATA_PES_RECORD          0x10
 #define DATA_PES_PLAY            0x11
@@ -444,6 +447,19 @@
         struct dvb_demux_feed *feed;
 } p2t_t;
 
+/* video MPEG decoder events: */
+/* (code copied from dvb_frontend.c, should maybe be factored out...) */
+#define MAX_VIDEO_EVENT 8
+struct dvb_video_events {
+	struct video_event        events[MAX_VIDEO_EVENT];
+	int                       eventw;
+	int                       eventr;
+	int                       overflow;
+	wait_queue_head_t         wait_queue;
+	spinlock_t                lock;
+};
+
+
 /* place to store all the necessary device information */
 typedef struct av7110_s {
 
@@ -464,6 +480,7 @@
         int adac_type;         /* audio DAC type */
 #define DVB_ADAC_TI       0
 #define DVB_ADAC_CRYSTAL  1
+#define DVB_ADAC_MSP      2
 #define DVB_ADAC_NONE    -1
 
 
@@ -524,7 +541,6 @@
         int                     vidmode;
         dmxdev_t                dmxdev;
         struct dvb_demux             demux;
-        char                    demux_id[16];
 
         dmx_frontend_t          hw_frontend;
         dmx_frontend_t          mem_frontend;
@@ -583,7 +599,12 @@
         struct dvb_device        *ca_dev;
         struct dvb_device        *osd_dev;
 
+	struct dvb_video_events  video_events;
+	video_size_t             video_size;
+
         int                 dsp_dev;
+
+        u32                 ir_config;
 } av7110_t;
 
 
@@ -623,26 +644,15 @@
 #define Reserved	(DPRAM_BASE + 0x1E00)
 #define Reserved_SIZE	0x1C0
 
-#define DEBUG_WINDOW	(DPRAM_BASE + 0x1FC0)
-#define	DBG_LOOP_CNT	(DEBUG_WINDOW + 0x00)
-#define DBG_SEC_CNT	(DEBUG_WINDOW + 0x02)
-#define DBG_AVRP_BUFF	(DEBUG_WINDOW + 0x04)
-#define DBG_AVRP_PEAK	(DEBUG_WINDOW + 0x06)
-#define DBG_MSG_CNT	(DEBUG_WINDOW + 0x08)
-#define DBG_CODE_REG	(DEBUG_WINDOW + 0x0a)
-#define DBG_TTX_Q	(DEBUG_WINDOW + 0x0c)
-#define DBG_AUD_EN	(DEBUG_WINDOW + 0x0e)
-#define DBG_WRONG_COM	(DEBUG_WINDOW + 0x10)
-#define DBG_ARR_OVFL	(DEBUG_WINDOW + 0x12)
-#define DBG_BUFF_OVFL	(DEBUG_WINDOW + 0x14)
-#define DBG_OVFL_CNT	(DEBUG_WINDOW + 0x16)
-#define DBG_SEC_OVFL	(DEBUG_WINDOW + 0x18)
-
 #define STATUS_BASE	(DPRAM_BASE + 0x1FC0)
 #define STATUS_SCR      (STATUS_BASE + 0x00)
 #define STATUS_MODES    (STATUS_BASE + 0x04)
 #define STATUS_LOOPS    (STATUS_BASE + 0x08)
 
+#define STATUS_MPEG_WIDTH     (STATUS_BASE + 0x0C)
+/* ((aspect_ratio & 0xf) << 12) | (height & 0xfff) */
+#define STATUS_MPEG_HEIGHT_AR (STATUS_BASE + 0x0E)
+
 #define RX_TYPE         (DPRAM_BASE + 0x1FE8)
 #define RX_LEN          (DPRAM_BASE + 0x1FEA)
 #define TX_TYPE         (DPRAM_BASE + 0x1FEC)
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/av7110_ipack.c linux-2.5.69.patch/drivers/media/dvb/ttpci/av7110_ipack.c
--- linux-2.5.69/drivers/media/dvb/ttpci/av7110_ipack.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/av7110_ipack.c	2003-03-24 15:37:09.000000000 +0100
@@ -1,6 +1,7 @@
 #include "dvb_filter.h"
 #include "av7110_ipack.h"
 #include <linux/string.h>	/* for memcpy() */
+#include <linux/vmalloc.h>
 
 
 void av7110_ipack_reset(ipack *p)
@@ -34,7 +35,8 @@
 
 void av7110_ipack_free(ipack * p)
 {
-	if (p->buf) vfree(p->buf);
+	if (p->buf)
+		vfree(p->buf);
 }
 
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/av7110_ir.c linux-2.5.69.patch/drivers/media/dvb/ttpci/av7110_ir.c
--- linux-2.5.69/drivers/media/dvb/ttpci/av7110_ir.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/av7110_ir.c	2003-05-06 10:59:59.000000000 +0200
@@ -12,7 +12,7 @@
 #endif
 
 
-#define UP_TIMEOUT (HZ/2)
+#define UP_TIMEOUT (HZ/4)
 
 static int av7110_ir_debug = 0;
 
@@ -21,6 +21,7 @@
 
 static struct input_dev input_dev;
 
+static u32 ir_config;
 
 static
 u16 key_map [256] = {
@@ -64,32 +65,61 @@
 static
 void av7110_emit_key (u32 ircom)
 {
-	int down = ircom & (0x80000000);
-	u16 keycode = key_map[ircom & 0xff];
-
-	dprintk ("#########%08x######### key %02x %s (keycode %i)\n",
-		 ircom, ircom & 0xff, down ? "pressed" : "released", keycode);
+	u8 data;
+	u8 addr;
+	static u16 old_toggle = 0;
+	u16 new_toggle;
+	u16 keycode;
+
+	/* extract device address and data */
+	if (ir_config & 0x0001) {
+		/* TODO RCMM: ? bits device address, 8 bits data */
+		data = ircom & 0xff;
+		addr = (ircom >> 8) & 0xff;
+	} else {
+		/* RC5: 5 bits device address, 6 bits data */
+		data = ircom & 0x3f;
+		addr = (ircom >> 6) & 0x1f;
+	}
+
+	keycode = key_map[data];
+	
+	dprintk ("#########%08x######### addr %i data 0x%02x (keycode %i)\n",
+		 ircom, addr, data, keycode);
+
+	/* check device address (if selected) */
+	if (ir_config & 0x4000)
+		if (addr != ((ir_config >> 16) & 0xff))
+			return;
 
 	if (!keycode) {
 		printk ("%s: unknown key 0x%02x!!\n",
-			__FUNCTION__, ircom & 0xff);
+			__FUNCTION__, data);
 		return;
 	}
 
+	if (ir_config & 0x0001) 
+		new_toggle = 0; /* RCMM */
+	else
+		new_toggle = (ircom & 0x800); /* RC5 */
+
 	if (timer_pending (&keyup_timer)) {
 		del_timer (&keyup_timer);
-		if (keyup_timer.data != keycode)
+		if (keyup_timer.data != keycode || new_toggle != old_toggle) {
 			input_event (&input_dev, EV_KEY, keyup_timer.data, !!0);
-	}
-
-	clear_bit (keycode, input_dev.key);
+			input_event (&input_dev, EV_KEY, keycode, !0);
+		} else
+			input_event (&input_dev, EV_KEY, keycode, 2);
 
+	} else
 	input_event (&input_dev, EV_KEY, keycode, !0);
 
 	keyup_timer.expires = jiffies + UP_TIMEOUT;
 	keyup_timer.data = keycode;
 
 	add_timer (&keyup_timer);
+
+	old_toggle = new_toggle;
 }
 
 static
@@ -108,17 +138,36 @@
 }
 
 
+static void input_repeat_key(unsigned long data)
+{
+       /* dummy routine to disable autorepeat in the input driver */
+}
+
+
 static
 int av7110_ir_write_proc (struct file *file, const char *buffer,
 	                  unsigned long count, void *data)
 {
-	u32 ir_config;
+	char *page;
+	int size = 4 + 256 * sizeof(u16);
 
-	if (count < 4 + 256 * sizeof(u16))
+	if (count < size)
 		return -EINVAL;
 	
-	memcpy (&ir_config, buffer, 4);
-	memcpy (&key_map, buffer + 4, 256 * sizeof(u16));
+	page = (char *)vmalloc(size);
+	if( NULL == page ) {
+		return -ENOMEM;
+	}
+	
+	if (copy_from_user(page, buffer, size)) {
+		vfree(page);
+		return -EFAULT;
+	}
+
+	memcpy (&ir_config, page, 4);
+	memcpy (&key_map, page + 4, 256 * sizeof(u16));
+
+	vfree(page);
 
 	av7110_setup_irc_config (NULL, ir_config);
 
@@ -141,10 +190,12 @@
          *  enable keys
          */
         set_bit (EV_KEY, input_dev.evbit);
+        set_bit (EV_REP, input_dev.evbit);
 
 	input_register_keys ();
 
 	input_register_device(&input_dev);
+	input_dev.timer.function = input_repeat_key;
 
 	av7110_setup_irc_config (NULL, 0x0001);
 	av7110_register_irc_handler (av7110_emit_key);
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/budget-av.c linux-2.5.69.patch/drivers/media/dvb/ttpci/budget-av.c
--- linux-2.5.69/drivers/media/dvb/ttpci/budget-av.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/budget-av.c	2003-04-30 12:03:34.000000000 +0200
@@ -30,13 +30,10 @@
  * the project's page is at http://www.linuxtv.org/dvb/
  */
 
-#include "budget.h"
 #include <media/saa7146_vv.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-        #define KBUILD_MODNAME budget_av
-#endif
-
+#include "budget.h"
+#include "dvb_functions.h"
 
 struct budget_av {
 	struct budget budget;
@@ -48,13 +45,6 @@
  * INITIALIZATION
  ****************************************************************************/
 
-static inline
-void ddelay(int i) 
-{
-        current->state=TASK_INTERRUPTIBLE;
-        schedule_timeout((HZ*i)/100);
-}
-
 
 static
 u8 i2c_readreg (struct dvb_i2c_bus *i2c, u8 id, u8 reg)
@@ -175,7 +165,7 @@
 
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTLO);
 
-	ddelay(20);
+	dvb_delay(200);
 
 	saa7146_unregister_device (&budget_av->vd, dev);
 
@@ -221,7 +211,7 @@
 	//test_knc_ci(av7110);
 
 	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTHI);
-	ddelay(50);
+	dvb_delay(500);
 
 	if ((err = saa7113_init (budget_av))) {
 		budget_av_detach(dev);
@@ -245,9 +235,11 @@
 
 	/* what is this? since we don't support open()/close()
 	   notifications, we simply put this into the release handler... */
-//	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTLO);
-	ddelay(20);
-
+/*
+	saa7146_setgpio(dev, 0, SAA7146_GPIO_OUTLO);
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout (20);
+*/
 	/* fixme: find some sane values here... */
 	saa7146_write(dev, PCI_BT_V1, 0x1c00101f);
 
@@ -348,7 +340,7 @@
 	}
 };
 
-
+MODULE_DEVICE_TABLE(pci, pci_tbl);
 
 static
 struct saa7146_extension budget_extension = {
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/budget-ci.c linux-2.5.69.patch/drivers/media/dvb/ttpci/budget-ci.c
--- linux-2.5.69/drivers/media/dvb/ttpci/budget-ci.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/budget-ci.c	2003-04-22 18:30:31.000000000 +0200
@@ -28,10 +28,6 @@
  */
 
 #include "budget.h"
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-        #define KBUILD_MODNAME budget
-#endif
-
 
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -388,7 +384,7 @@
 	}
 };
 
-
+MODULE_DEVICE_TABLE(pci, pci_tbl);
 
 static
 struct saa7146_extension budget_extension = {
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/budget-core.c linux-2.5.69.patch/drivers/media/dvb/ttpci/budget-core.c
--- linux-2.5.69/drivers/media/dvb/ttpci/budget-core.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/budget-core.c	2003-04-22 18:30:31.000000000 +0200
@@ -1,21 +1,8 @@
 #include "budget.h"
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-        #define KBUILD_MODNAME budget
-#endif
 
 int budget_debug = 0;
 
 /****************************************************************************
- * General helper functions
- ****************************************************************************/
-
-static inline void ddelay(int i) 
-{
-        current->state=TASK_INTERRUPTIBLE;
-        schedule_timeout((HZ*i)/100);
-}
-
-/****************************************************************************
  * TT budget / WinTV Nova
  ****************************************************************************/
 
@@ -142,14 +129,11 @@
 static
 int budget_register(struct budget *budget)
 {
-        int ret;
-        dmx_frontend_t *dvbfront=&budget->hw_frontend;
         struct dvb_demux *dvbdemux=&budget->demux;
+        int ret;
 
 	DEB_EE(("budget: %p\n",budget));
 
-        memcpy(budget->demux_id, "demux0_0", 9);
-        budget->demux_id[5] = budget->dvb_adapter->num + '0';
         dvbdemux->priv = (void *) budget;
 
 	dvbdemux->filternum = 256;
@@ -158,33 +142,24 @@
         dvbdemux->stop_feed = budget_stop_feed;
         dvbdemux->write_to_decoder = NULL;
 
-        dvbdemux->dmx.vendor = "CIM";
-        dvbdemux->dmx.model = "sw";
-        dvbdemux->dmx.id = budget->demux_id;
         dvbdemux->dmx.capabilities = (DMX_TS_FILTERING | DMX_SECTION_FILTERING |
                                       DMX_MEMORY_BASED_FILTERING);
 
         dvb_dmx_init(&budget->demux);
 
-        dvbfront->id = "hw_frontend";
-        dvbfront->vendor = "VLSI";
-        dvbfront->model = "DVB Frontend";
-        dvbfront->source = DMX_FRONTEND_0;
-
         budget->dmxdev.filternum = 256;
         budget->dmxdev.demux = &dvbdemux->dmx;
         budget->dmxdev.capabilities = 0;
 
         dvb_dmxdev_init(&budget->dmxdev, budget->dvb_adapter);
 
-        ret=dvbdemux->dmx.add_frontend (&dvbdemux->dmx, 
-                                        &budget->hw_frontend);
+        budget->hw_frontend.source = DMX_FRONTEND_0;
+
+        ret = dvbdemux->dmx.add_frontend(&dvbdemux->dmx, &budget->hw_frontend);
+
         if (ret < 0)
                 return ret;
         
-        budget->mem_frontend.id = "mem_frontend";
-        budget->mem_frontend.vendor = "memory";
-        budget->mem_frontend.model = "sw";
         budget->mem_frontend.source = DMX_MEMORY_FE;
         ret=dvbdemux->dmx.add_frontend (&dvbdemux->dmx, 
                                         &budget->mem_frontend);
@@ -278,9 +253,9 @@
 
 	saa7146_setgpio(dev, 2, SAA7146_GPIO_OUTHI); /* frontend power on */
 
-        if (budget_register(budget) == 0)
+        if (budget_register(budget) == 0) {
 		return 0;
-
+	}
 err:
 	if (budget->grabbing)
 		vfree(budget->grabbing);
@@ -312,7 +287,6 @@
 	saa7146_pgtable_free (dev->pci, &budget->pt);
 
 	vfree (budget->grabbing);
-	kfree (budget);
 
 	return 0;
 }
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/budget-patch.c linux-2.5.69.patch/drivers/media/dvb/ttpci/budget-patch.c
--- linux-2.5.69/drivers/media/dvb/ttpci/budget-patch.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/budget-patch.c	2003-04-22 18:30:31.000000000 +0200
@@ -31,9 +31,7 @@
  */
 
 #include "budget.h"
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-        #define KBUILD_MODNAME budget_patch
-#endif
+#include "av7110.h"
 
 #define budget_patch budget
 
@@ -49,45 +47,6 @@
         }
 };
 
-
-#define COMMAND (DPRAM_BASE + 0x0FC)
-#define DPRAM_BASE 0x4000
-#define DEBINOSWAP 0x000e0000
-
-
-typedef enum  { 
-        AudioDAC,
-        CabADAC,
-        ON22K,
-        OFF22K,
-        MainSwitch,
-        ADSwitch,
-        SendDiSEqC,
-        SetRegister
-} AUDCOM;
-
-
-typedef enum  { 
-        COMTYPE_NOCOM,
-        COMTYPE_PIDFILTER,
-        COMTYPE_MPEGDECODER,
-        COMTYPE_OSD,
-        COMTYPE_BMP,
-        COMTYPE_ENCODER,
-        COMTYPE_AUDIODAC,
-        COMTYPE_REQUEST,
-        COMTYPE_SYSTEM,
-        COMTYPE_REC_PLAY,
-        COMTYPE_COMMON_IF,
-        COMTYPE_PID_FILTER,
-        COMTYPE_PES,
-        COMTYPE_TS,
-        COMTYPE_VIDEO,
-        COMTYPE_AUDIO,
-        COMTYPE_CI_LL,
-} COMTYPE;
-
-
 static
 int wdebi(struct budget_patch *budget, u32 config, int addr, u32 val, int count)
 {
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/budget.c linux-2.5.69.patch/drivers/media/dvb/ttpci/budget.c
--- linux-2.5.69/drivers/media/dvb/ttpci/budget.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/budget.c	2003-04-30 12:03:16.000000000 +0200
@@ -30,18 +30,7 @@
  */
 
 #include "budget.h"
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-        #define KBUILD_MODNAME budget
-#endif
-
-
-
-static inline void ddelay(int i)
-{
-	current->state=TASK_INTERRUPTIBLE;
-	schedule_timeout((HZ*i)/100);
-}
-
+#include "dvb_functions.h"
 
 static
 void Set22K (struct budget *budget, int state)
@@ -110,7 +99,7 @@
 			udelay(12500);
 			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTLO);
 		}
-		ddelay(2);
+		dvb_delay(20);
 	}
 
 	return 0;
@@ -160,15 +149,18 @@
 static
 int budget_attach (struct saa7146_dev* dev, struct saa7146_pci_extension_data *info)
 {
-	struct budget *budget;
+	struct budget *budget = NULL;
 	int err;
 
-	if (!(budget = kmalloc (sizeof(struct budget), GFP_KERNEL)))
+	budget = kmalloc(sizeof(struct budget), GFP_KERNEL);
+	if( NULL == budget ) {
 		return -ENOMEM;
+	}
 
-	DEB_EE(("budget: %p\n",budget));
+	DEB_EE(("dev:%p, info:%p, budget:%p\n",dev,info,budget));
 
 	if ((err = ttpci_budget_init (budget, dev, info))) {
+		printk("==> failed\n");
 		kfree (budget);
 		return err;
 	}
@@ -194,6 +186,7 @@
 	err = ttpci_budget_deinit (budget);
 
 	kfree (budget);
+	dev->ext_priv = NULL;
 
 	return err;
 }
@@ -222,7 +215,7 @@
 	}
 };
 
-
+MODULE_DEVICE_TABLE(pci, pci_tbl);
 
 static
 struct saa7146_extension budget_extension = {
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/ttpci/budget.h linux-2.5.69.patch/drivers/media/dvb/ttpci/budget.h
--- linux-2.5.69/drivers/media/dvb/ttpci/budget.h	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/ttpci/budget.h	2003-04-15 15:25:18.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __BUDGET_DVB__
 #define __BUDGET_DVB__
 
+#include <media/saa7146.h>
+
 #include "dvb_i2c.h"
 #include "dvb_frontend.h"
 #include "dvbdev.h"
@@ -10,8 +12,6 @@
 #include "dvb_filter.h"
 #include "dvb_net.h"
 
-#include <media/saa7146.h>
-
 extern int budget_debug;
 
 struct budget_info {
@@ -39,7 +39,6 @@
 
         dmxdev_t                dmxdev;
         struct dvb_demux	demux;
-        char                    demux_id[16];
 
         dmx_frontend_t          hw_frontend;
         dmx_frontend_t          mem_frontend;

--------------060304000809090002070409--


