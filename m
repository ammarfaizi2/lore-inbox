Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVIDXb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVIDXb4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVIDXbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:20 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:61057 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932153AbVIDXbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:15 -0400
Message-Id: <20050904232336.080662000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:50 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Oliver Endriss <o.endriss@gmx.de>
Content-Disposition: inline; filename=dvb-ttpci-av7110-remote-control.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 51/54] ttpci: av7110: RC5+ remote control support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Endriss <o.endriss@gmx.de>

Improved remote control support for av7110-based cards:
o extended rc5 protocol, firmware >= 0x2620 required
o key-up timer slightly adjusted
o completely moved remote control code to av7110_ir.c
o support for multiple ir receivers
o for now, all av7110 cards share the same ir configuration and event device

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110.c    |   70 +-----------------
 drivers/media/dvb/ttpci/av7110.h    |   11 +-
 drivers/media/dvb/ttpci/av7110_ir.c |  140 ++++++++++++++++++++++++------------
 3 files changed, 110 insertions(+), 111 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110.c	2005-09-04 22:30:55.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110.c	2005-09-04 22:31:00.000000000 +0200
@@ -177,9 +177,6 @@ static void init_av7110_av(struct av7110
 	ret = av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
 	if (ret < 0)
 		printk("dvb-ttpci:cannot set volume :%d\n",ret);
-	ret = av7110_setup_irc_config(av7110, 0);
-	if (ret < 0)
-		printk("dvb-ttpci:cannot setup irc config :%d\n",ret);
 }
 
 static void recover_arm(struct av7110 *av7110)
@@ -265,60 +262,6 @@ static int arm_thread(void *data)
 }
 
 
-/**
- *  Hack! we save the last av7110 ptr. This should be ok, since
- *  you rarely will use more then one IR control.
- *
- *  If we want to support multiple controls we would have to do much more...
- */
-int av7110_setup_irc_config(struct av7110 *av7110, u32 ir_config)
-{
-	int ret = 0;
-	static struct av7110 *last;
-
-	dprintk(4, "%p\n", av7110);
-
-	if (!av7110)
-		av7110 = last;
-	else
-		last = av7110;
-
-	if (av7110) {
-		ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, ir_config);
-		av7110->ir_config = ir_config;
-	}
-	return ret;
-}
-
-static void (*irc_handler)(u32);
-
-void av7110_register_irc_handler(void (*func)(u32))
-{
-	dprintk(4, "registering %p\n", func);
-	irc_handler = func;
-}
-
-void av7110_unregister_irc_handler(void (*func)(u32))
-{
-	dprintk(4, "unregistering %p\n", func);
-	irc_handler = NULL;
-}
-
-static void run_handlers(unsigned long ircom)
-{
-	if (irc_handler != NULL)
-		(*irc_handler)((u32) ircom);
-}
-
-static DECLARE_TASKLET(irtask, run_handlers, 0);
-
-static void IR_handle(struct av7110 *av7110, u32 ircom)
-{
-	dprintk(4, "ircommand = %08x\n", ircom);
-	irtask.data = (unsigned long) ircom;
-	tasklet_schedule(&irtask);
-}
-
 /****************************************************************************
  * IRQ handling
  ****************************************************************************/
@@ -711,8 +654,9 @@ static void gpioirq(unsigned long data)
 		return;
 
 	case DATA_IRCOMMAND:
-		IR_handle(av7110,
-			  swahw32(irdebi(av7110, DEBINOSWAP, Reserved, 0, 4)));
+		if (av7110->ir_handler)
+			av7110->ir_handler(av7110,
+				swahw32(irdebi(av7110, DEBINOSWAP, Reserved, 0, 4)));
 		iwdebi(av7110, DEBINOSWAP, RX_BUFF, 0, 2);
 		break;
 
@@ -2783,7 +2727,7 @@ static int av7110_attach(struct saa7146_
 		goto err_av7110_exit_v4l_12;
 
 #if defined(CONFIG_INPUT_EVDEV) || defined(CONFIG_INPUT_EVDEV_MODULE)
-	av7110_ir_init();
+	av7110_ir_init(av7110);
 #endif
 	printk(KERN_INFO "dvb-ttpci: found av7110-%d.\n", av7110_num);
 	av7110_num++;
@@ -2825,6 +2769,9 @@ static int av7110_detach(struct saa7146_
 	struct av7110 *av7110 = saa->ext_priv;
 	dprintk(4, "%p\n", av7110);
 
+#if defined(CONFIG_INPUT_EVDEV) || defined(CONFIG_INPUT_EVDEV_MODULE)
+	av7110_ir_exit(av7110);
+#endif
 	if (budgetpatch) {
 		/* Disable RPS1 */
 		saa7146_write(saa, MC1, MASK_29);
@@ -2980,9 +2927,6 @@ static int __init av7110_init(void)
 
 static void __exit av7110_exit(void)
 {
-#if defined(CONFIG_INPUT_EVDEV) || defined(CONFIG_INPUT_EVDEV_MODULE)
-	av7110_ir_exit();
-#endif
 	saa7146_unregister_extension(&av7110_extension);
 }
 
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110.h	2005-09-04 22:03:40.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110.h	2005-09-04 22:31:00.000000000 +0200
@@ -228,7 +228,10 @@ struct av7110 {
 	struct dvb_video_events  video_events;
 	video_size_t		 video_size;
 
-	u32		    ir_config;
+	u32			ir_config;
+	u32			ir_command;
+	void			(*ir_handler)(struct av7110 *av7110, u32 ircom); 
+	struct tasklet_struct	ir_tasklet;
 
 	/* firmware stuff */
 	unsigned char *bin_fw;
@@ -257,12 +260,10 @@ struct av7110 {
 extern int ChangePIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
 		       u16 subpid, u16 pcrpid);
 
-extern void av7110_register_irc_handler(void (*func)(u32));
-extern void av7110_unregister_irc_handler(void (*func)(u32));
 extern int av7110_setup_irc_config (struct av7110 *av7110, u32 ir_config);
 
-extern int av7110_ir_init (void);
-extern void av7110_ir_exit (void);
+extern int av7110_ir_init(struct av7110 *av7110);
+extern void av7110_ir_exit(struct av7110 *av7110);
 
 /* msp3400 i2c subaddresses */
 #define MSP_WR_DEM 0x10
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110_ir.c	2005-09-04 22:03:40.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110_ir.c	2005-09-04 22:31:00.000000000 +0200
@@ -7,16 +7,16 @@
 #include <asm/bitops.h>
 
 #include "av7110.h"
+#include "av7110_hw.h"
 
-#define UP_TIMEOUT (HZ/4)
+#define UP_TIMEOUT (HZ*7/25)
 
 /* enable ir debugging by or'ing debug with 16 */
 
-static int ir_initialized;
+static int av_cnt;
+static struct av7110 *av_list[4];
 static struct input_dev input_dev;
 
-static u32 ir_config;
-
 static u16 key_map [256] = {
 	KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7,
 	KEY_8, KEY_9, KEY_BACK, 0, KEY_POWER, KEY_MUTE, 0, KEY_INFO,
@@ -53,8 +53,11 @@ static void av7110_emit_keyup(unsigned l
 static struct timer_list keyup_timer = { .function = av7110_emit_keyup };
 
 
-static void av7110_emit_key(u32 ircom)
+static void av7110_emit_key(unsigned long parm)
 {
+	struct av7110 *av7110 = (struct av7110 *) parm;
+	u32 ir_config = av7110->ir_config;
+	u32 ircom = av7110->ir_command;
 	u8 data;
 	u8 addr;
 	static u16 old_toggle = 0;
@@ -62,19 +65,33 @@ static void av7110_emit_key(u32 ircom)
 	u16 keycode;
 
 	/* extract device address and data */
-	if (ir_config & 0x0001) {
-		/* TODO RCMM: ? bits device address, 8 bits data */
+	switch (ir_config & 0x0003) {
+	case 0:	/* RC5: 5 bits device address, 6 bits data */
+		data = ircom & 0x3f;
+		addr = (ircom >> 6) & 0x1f;
+		break;
+
+	case 1:	/* RCMM: 8(?) bits device address, 8(?) bits data */
 		data = ircom & 0xff;
 		addr = (ircom >> 8) & 0xff;
-	} else {
-		/* RC5: 5 bits device address, 6 bits data */
+		break;
+
+	case 2:	/* extended RC5: 5 bits device address, 7 bits data */
 		data = ircom & 0x3f;
 		addr = (ircom >> 6) & 0x1f;
+		/* invert 7th data bit for backward compatibility with RC5 keymaps */
+		if (!(ircom & 0x1000))
+			data |= 0x40;
+		break;
+
+	default:
+		printk("invalid ir_config %x\n", ir_config);
+		return;
 	}
 
 	keycode = key_map[data];
 
-	dprintk(16, "#########%08x######### addr %i data 0x%02x (keycode %i)\n",
+	dprintk(16, "code %08x -> addr %i data 0x%02x -> keycode %i\n",
 		ircom, addr, data, keycode);
 
 	/* check device address (if selected) */
@@ -87,10 +104,10 @@ static void av7110_emit_key(u32 ircom)
 		return;
 	}
 
-	if (ir_config & 0x0001)
+	if ((ir_config & 0x0003) == 1)
 		new_toggle = 0; /* RCMM */
 	else
-		new_toggle = (ircom & 0x800); /* RC5 */
+		new_toggle = (ircom & 0x800); /* RC5, extended RC5 */
 
 	if (timer_pending(&keyup_timer)) {
 		del_timer(&keyup_timer);
@@ -137,6 +154,8 @@ static int av7110_ir_write_proc(struct f
 {
 	char *page;
 	int size = 4 + 256 * sizeof(u16);
+	u32 ir_config;
+	int i;
 
 	if (count < size)
 		return -EINVAL;
@@ -153,60 +172,95 @@ static int av7110_ir_write_proc(struct f
 	memcpy(&ir_config, page, 4);
 	memcpy(&key_map, page + 4, 256 * sizeof(u16));
 	vfree(page);
-	av7110_setup_irc_config(NULL, ir_config);
+	if (FW_VERSION(av_list[0]->arm_app) >= 0x2620 && !(ir_config & 0x0001))
+		ir_config |= 0x0002; /* enable extended RC5 */
+	for (i = 0; i < av_cnt; i++)
+		av7110_setup_irc_config(av_list[i], ir_config);
 	input_register_keys();
 	return count;
 }
 
 
-int __init av7110_ir_init(void)
+int av7110_setup_irc_config(struct av7110 *av7110, u32 ir_config)
 {
-	static struct proc_dir_entry *e;
+	int ret = 0;
 
-	if (ir_initialized)
-		return 0;
+	dprintk(4, "%p\n", av7110);
+	if (av7110) {
+		ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, ir_config);
+		av7110->ir_config = ir_config;
+	}
+	return ret;
+}
 
-	init_timer(&keyup_timer);
-	keyup_timer.data = 0;
 
-	input_dev.name = "DVB on-card IR receiver";
+static void ir_handler(struct av7110 *av7110, u32 ircom)
+{
+	dprintk(4, "ircommand = %08x\n", ircom);
+	av7110->ir_command = ircom;
+	tasklet_schedule(&av7110->ir_tasklet);
+}
 
-	/**
-	 *  enable keys
-	 */
-	set_bit(EV_KEY, input_dev.evbit);
-	set_bit(EV_REP, input_dev.evbit);
 
-	input_register_keys();
+int __init av7110_ir_init(struct av7110 *av7110)
+{
+	static struct proc_dir_entry *e;
 
-	input_register_device(&input_dev);
-	input_dev.timer.function = input_repeat_key;
+	if (av_cnt >= sizeof av_list/sizeof av_list[0])
+		return -ENOSPC;
 
-	av7110_setup_irc_config(NULL, 0x0001);
-	av7110_register_irc_handler(av7110_emit_key);
+	av7110_setup_irc_config(av7110, 0x0001);
+	av_list[av_cnt++] = av7110;
 
-	e = create_proc_entry("av7110_ir", S_IFREG | S_IRUGO | S_IWUSR, NULL);
-	if (e) {
-		e->write_proc = av7110_ir_write_proc;
-		e->size = 4 + 256 * sizeof(u16);
+	if (av_cnt == 1) {
+		init_timer(&keyup_timer);
+		keyup_timer.data = 0;
+
+		input_dev.name = "DVB on-card IR receiver";
+		set_bit(EV_KEY, input_dev.evbit);
+		set_bit(EV_REP, input_dev.evbit);
+		input_register_keys();
+		input_register_device(&input_dev);
+		input_dev.timer.function = input_repeat_key;
+
+		e = create_proc_entry("av7110_ir", S_IFREG | S_IRUGO | S_IWUSR, NULL);
+		if (e) {
+			e->write_proc = av7110_ir_write_proc;
+			e->size = 4 + 256 * sizeof(u16);
+		}
 	}
 
-	ir_initialized = 1;
+	tasklet_init(&av7110->ir_tasklet, av7110_emit_key, (unsigned long) av7110);
+	av7110->ir_handler = ir_handler;
+
 	return 0;
 }
 
 
-void __exit av7110_ir_exit(void)
+void __exit av7110_ir_exit(struct av7110 *av7110)
 {
-	if (ir_initialized == 0)
+	int i;
+
+	if (av_cnt == 0)
 		return;
-	del_timer_sync(&keyup_timer);
-	remove_proc_entry("av7110_ir", NULL);
-	av7110_unregister_irc_handler(av7110_emit_key);
-	input_unregister_device(&input_dev);
-	ir_initialized = 0;
+
+	av7110->ir_handler = NULL;
+	tasklet_kill(&av7110->ir_tasklet);
+	for (i = 0; i < av_cnt; i++)
+		if (av_list[i] == av7110) {
+			av_list[i] = av_list[av_cnt-1];
+			av_list[av_cnt-1] = NULL;
+			break;
+		}
+
+	if (av_cnt == 1) {
+		del_timer_sync(&keyup_timer);
+		remove_proc_entry("av7110_ir", NULL);
+		input_unregister_device(&input_dev);
+	}
+
+	av_cnt--;
 }
 
 //MODULE_AUTHOR("Holger Waechtler <holger@convergence.de>");
 //MODULE_LICENSE("GPL");
-

--

