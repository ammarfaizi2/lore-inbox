Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVAVRzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVAVRzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 12:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVAVRzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 12:55:42 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:13522 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262601AbVAVRdM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:33:12 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <1106415266247@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 22 Jan 2005 18:34:31 +0100
Message-Id: <11064152711787@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.231.47.99
Subject: [PATCH 6/9] refactoring
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] dib3000: driver refactoring, makes it easier to support device clones

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000-common.c linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000-common.c
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000-common.c	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000-common.c	2005-01-20 19:56:37.000000000 +0100
@@ -2,7 +2,7 @@
 
 #ifdef CONFIG_DVB_DIBCOM_DEBUG
 static int debug;
-module_param(debug, int, 0x644);
+module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "set debugging level (1=info,2=i2c,4=srch (|-able)).");
 #endif
 #define deb_info(args...) dprintk(0x01,args)
@@ -42,65 +41,6 @@
 	return i2c_transfer(state->i2c,msg, 1) != 1 ? -EREMOTEIO : 0;
 }
 
-int dib3000_init_pid_list(struct dib3000_state *state, int num)
-{
-	int i;
-	if (state != NULL) {
-		state->pid_list = kmalloc(sizeof(struct dib3000_pid) * num,GFP_KERNEL);
-		if (state->pid_list == NULL)
-			return -ENOMEM;
-
-		deb_info("initializing %d pids for the pid_list.\n",num);
-		spin_lock_init(&state->pid_list_lock);
-		memset(state->pid_list,0,num*(sizeof(struct dib3000_pid)));
-		for (i=0; i < num; i++) {
-			state->pid_list[i].pid = 0;
-			state->pid_list[i].active = 0;
-		}
-		state->feedcount = 0;
-	} else
-		return -EINVAL;
-
-	return 0;
-}
-
-void dib3000_dealloc_pid_list(struct dib3000_state *state)
-{
-	if (state != NULL && state->pid_list != NULL)
-		kfree(state->pid_list);
-}
-
-/* fetch a pid from pid_list */
-int dib3000_get_pid_index(struct dib3000_pid pid_list[], int num_pids, int pid,
-		spinlock_t *pid_list_lock,int onoff)
-{
-	int i,ret = -1;
-	unsigned long flags;
-
-	spin_lock_irqsave(pid_list_lock,flags);
-	for (i=0; i < num_pids; i++)
-		if (onoff) {
-			if (!pid_list[i].active) {
-				pid_list[i].pid = pid;
-				pid_list[i].active = 1;
-				ret = i;
-				break;
-			}
-		} else {
-			if (pid_list[i].active && pid_list[i].pid == pid) {
-				pid_list[i].pid = 0;
-				pid_list[i].active = 0;
-				ret = i;
-				break;
-			}
-		}
-
-	deb_info("setting pid: %5d %04x at index %d '%s'\n",pid,pid,ret,onoff ? "on" : "off");
-
-	spin_unlock_irqrestore(pid_list_lock,flags);
-	return ret;
-}
-
 int dib3000_search_status(u16 irq,u16 lock)
 {
 	if (irq & 0x02) {
@@ -139,7 +79,4 @@
 
 EXPORT_SYMBOL(dib3000_read_reg);
 EXPORT_SYMBOL(dib3000_write_reg);
-EXPORT_SYMBOL(dib3000_init_pid_list);
-EXPORT_SYMBOL(dib3000_dealloc_pid_list);
-EXPORT_SYMBOL(dib3000_get_pid_index);
 EXPORT_SYMBOL(dib3000_search_status);
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000-common.h linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000-common.h
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000-common.h	2005-01-20 19:55:47.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000-common.h	2005-01-20 19:56:37.000000000 +0100
@@ -4,7 +4,7 @@
  *
  * DiBcom (http://www.dibcom.fr/)
  *
- * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
  * based on GPL code from DibCom, which has
  *
@@ -29,19 +28,10 @@
 #include "dvb_frontend.h"
 #include "dib3000.h"
 
-/* info and err, taken from usb.h, if there is anything available like by default,
- * please change !
- */
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , __FILE__ , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , __FILE__ , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , __FILE__ , ## arg)
-
-/* a PID for the pid_filter list, when in use */
-struct dib3000_pid
-{
-	u16 pid;
-	int active;
-};
+/* info and err, taken from usb.h, if there is anything available like by default. */
+#define err(format, arg...) printk(KERN_ERR "dib3000mX: " format "\n" , ## arg)
+#define info(format, arg...) printk(KERN_INFO "dib3000mX: " format "\n" , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "dib3000mX: " format "\n" , ## arg)
 
 /* frontend state */
 struct dib3000_state {
@@ -52,25 +42,18 @@
 /* configuration settings */
 	struct dib3000_config config;
 
-	spinlock_t pid_list_lock;
-	struct dib3000_pid *pid_list;
-
-	int feedcount;
-
 	struct dvb_frontend frontend;
 	int timing_offset;
 	int timing_offset_comp_done;
+
+	fe_bandwidth_t last_tuned_bw;
+	u32 last_tuned_freq;
 };
 
 /* commonly used methods by the dib3000mb/mc/p frontend */
 extern int dib3000_read_reg(struct dib3000_state *state, u16 reg);
 extern int dib3000_write_reg(struct dib3000_state *state, u16 reg, u16 val);
 
-extern int dib3000_init_pid_list(struct dib3000_state *state, int num);
-extern void dib3000_dealloc_pid_list(struct dib3000_state *state);
-extern int dib3000_get_pid_index(struct dib3000_pid pid_list[], int num_pids,
-	int pid, spinlock_t *pid_list_lock,int onoff);
-
 extern int dib3000_search_status(u16 irq,u16 lock);
 
 /* handy shortcuts */
@@ -81,7 +64,7 @@
 
 #define wr_foreach(a,v) { int i; \
 	if (sizeof(a) != sizeof(v)) \
-		err("sizeof: %zd %zd is different",sizeof(a),sizeof(v));\
+		err("sizeof: %d %d is different",sizeof(a),sizeof(v));\
 	for (i=0; i < sizeof(a)/sizeof(u16); i++) \
 		wr(a[i],v[i]); \
 	}
@@ -136,8 +119,8 @@
 #define DIB3000_DDS_INVERSION_OFF		(     0)
 #define DIB3000_DDS_INVERSION_ON		(     1)
 
-#define DIB3000_TUNER_WRITE_ENABLE(a)	(0xffff & (a << 7))
-#define DIB3000_TUNER_WRITE_DISABLE(a)	(0xffff & ((a << 7) | (1 << 7)))
+#define DIB3000_TUNER_WRITE_ENABLE(a)	(0xffff & (a << 8))
+#define DIB3000_TUNER_WRITE_DISABLE(a)	(0xffff & ((a << 8) | (1 << 7)))
 
 /* for auto search */
 extern u16 dib3000_seq[2][2][2];
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000.h linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000.h
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000.h	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000.h	2005-01-20 19:56:37.000000000 +0100
@@ -2,7 +2,7 @@
  * public header file of the frontend drivers for mobile DVB-T demodulators
  * DiBcom 3000-MB and DiBcom 3000-MC/P (http://www.dibcom.fr/)
  *
- * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
  * based on GPL code from DibCom, which has
  *
@@ -31,25 +31,24 @@
 	/* the demodulator's i2c address */
 	u8 demod_address;
 
-	/* The i2c address of the PLL */
-	u8 pll_addr;
-
-	/* PLL maintenance */
-	int (*pll_init)(struct dvb_frontend *fe);
-	int (*pll_set)(struct dvb_frontend *fe, struct dvb_frontend_parameters* params);
+	/* PLL maintenance and the i2c address of the PLL */
+	u8 (*pll_addr)(struct dvb_frontend *fe);
+	int (*pll_init)(struct dvb_frontend *fe, u8 pll_buf[5]);
+	int (*pll_set)(struct dvb_frontend *fe, struct dvb_frontend_parameters* params, u8 pll_buf[5]);
 };
 
-struct dib3000_xfer_ops
+struct dib_fe_xfer_ops
 {
 	/* pid and transfer handling is done in the demodulator */
 	int (*pid_parse)(struct dvb_frontend *fe, int onoff);
 	int (*fifo_ctrl)(struct dvb_frontend *fe, int onoff);
-	int (*pid_ctrl)(struct dvb_frontend *fe, int pid, int onoff);
+	int (*pid_ctrl)(struct dvb_frontend *fe, int index, int pid, int onoff);
+	int (*tuner_pass_ctrl)(struct dvb_frontend *fe, int onoff, u8 pll_ctrl);
 };
 
 extern struct dvb_frontend* dib3000mb_attach(const struct dib3000_config* config,
-					     struct i2c_adapter* i2c, struct dib3000_xfer_ops *xfer_ops);
+					     struct i2c_adapter* i2c, struct dib_fe_xfer_ops *xfer_ops);
 
 extern struct dvb_frontend* dib3000mc_attach(const struct dib3000_config* config,
-					     struct i2c_adapter* i2c, struct dib3000_xfer_ops *xfer_ops);
+					     struct i2c_adapter* i2c, struct dib_fe_xfer_ops *xfer_ops);
 #endif // DIB3000_H
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000mb.c linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000mb.c
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000mb.c	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000mb.c	2005-01-20 19:56:37.000000000 +0100
@@ -2,7 +2,7 @@
  * Frontend driver for mobile DVB-T demodulator DiBcom 3000-MB
  * DiBcom (http://www.dibcom.fr/)
  *
- * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
  * based on GPL code from DibCom, which has
  *
@@ -29,7 +28,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-#include "dvb_frontend.h"
 #include "dib3000-common.h"
 #include "dib3000mb_priv.h"
 #include "dib3000.h"
@@ -41,7 +39,7 @@
 
 #ifdef CONFIG_DVB_DIBCOM_DEBUG
 static int debug;
-module_param(debug, int, 0x644);
+module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=setfe,8=getfe (|-able)).");
 #endif
 #define deb_info(args...) dprintk(0x01,args)
@@ -49,6 +47,8 @@
 #define deb_setf(args...) dprintk(0x04,args)
 #define deb_getf(args...) dprintk(0x08,args)
 
+static int dib3000mb_tuner_pass_ctrl(struct dvb_frontend *fe, int onoff, u8 pll_addr);
+
 static int dib3000mb_get_frontend(struct dvb_frontend* fe,
 				  struct dvb_frontend_parameters *fep);
 
@@ -61,11 +61,9 @@
 	int search_state,seq;
 
 	if (tuner) {
-		wr(DIB3000MB_REG_TUNER,
-				DIB3000_TUNER_WRITE_ENABLE(state->config.pll_addr));
-		state->config.pll_set(fe, fep);
-		wr(DIB3000MB_REG_TUNER,
-				DIB3000_TUNER_WRITE_DISABLE(state->config.pll_addr));
+		dib3000mb_tuner_pass_ctrl(fe,1,state->config.pll_addr(fe));
+		state->config.pll_set(fe, fep, NULL);
+		dib3000mb_tuner_pass_ctrl(fe,0,state->config.pll_addr(fe));
 
 		deb_setf("bandwidth: ");
 		switch (ofdm->bandwidth) {
@@ -390,11 +388,9 @@
 	wr(DIB3000MB_REG_DATA_IN_DIVERSITY,DIB3000MB_DATA_DIVERSITY_IN_OFF);
 
 	if (state->config.pll_init) {
-		wr(DIB3000MB_REG_TUNER,
-			DIB3000_TUNER_WRITE_ENABLE(state->config.pll_addr));
-		state->config.pll_init(fe);
-		wr(DIB3000MB_REG_TUNER,
-			DIB3000_TUNER_WRITE_DISABLE(state->config.pll_addr));
+		dib3000mb_tuner_pass_ctrl(fe,1,state->config.pll_addr(fe));
+		state->config.pll_init(fe,NULL);
+		dib3000mb_tuner_pass_ctrl(fe,0,state->config.pll_addr(fe));
 	}
 
 	return 0;
@@ -414,6 +410,7 @@
 		return 0;
 
 	dds_val = ((rd(DIB3000MB_REG_DDS_VALUE_MSB) & 0xff) << 16) + rd(DIB3000MB_REG_DDS_VALUE_LSB);
+	deb_getf("DDS_VAL: %x %x %x",dds_val, rd(DIB3000MB_REG_DDS_VALUE_MSB), rd(DIB3000MB_REG_DDS_VALUE_LSB));
 	if (dds_val < threshold)
 		inv_test1 = 0;
 	else if (dds_val == threshold)
@@ -422,6 +419,7 @@
 		inv_test1 = 2;
 
 	dds_val = ((rd(DIB3000MB_REG_DDS_FREQ_MSB) & 0xff) << 16) + rd(DIB3000MB_REG_DDS_FREQ_LSB);
+	deb_getf("DDS_FREQ: %x %x %x",dds_val, rd(DIB3000MB_REG_DDS_FREQ_MSB), rd(DIB3000MB_REG_DDS_FREQ_LSB));
 	if (dds_val < threshold)
 		inv_test2 = 0;
 	else if (dds_val == threshold)
@@ -714,18 +712,11 @@
 }
 
 /* pid filter and transfer stuff */
-static int dib3000mb_pid_control(struct dvb_frontend *fe,int pid,int onoff)
+static int dib3000mb_pid_control(struct dvb_frontend *fe,int index, int pid,int onoff)
 {
 	struct dib3000_state *state = fe->demodulator_priv;
-	int index = dib3000_get_pid_index(state->pid_list, DIB3000MB_NUM_PIDS, pid, &state->pid_list_lock,onoff);
 	pid = (onoff ? pid | DIB3000_ACTIVATE_PID_FILTERING : 0);
-
-	if (index >= 0) {
 		wr(index+DIB3000MB_REG_FIRST_PID,pid);
-	} else {
-		err("no more pids for filtering.");
-		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -749,10 +740,21 @@
 	return 0;
 	}
 
+static int dib3000mb_tuner_pass_ctrl(struct dvb_frontend *fe, int onoff, u8 pll_addr)
+{
+	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
+	if (onoff) {
+		wr(DIB3000MB_REG_TUNER, DIB3000_TUNER_WRITE_ENABLE(pll_addr));
+	} else {
+		wr(DIB3000MB_REG_TUNER, DIB3000_TUNER_WRITE_DISABLE(pll_addr));
+	}
+	return 0;
+}
+
 static struct dvb_frontend_ops dib3000mb_ops;
 
 struct dvb_frontend* dib3000mb_attach(const struct dib3000_config* config,
-				      struct i2c_adapter* i2c, struct dib3000_xfer_ops *xfer_ops)
+				      struct i2c_adapter* i2c, struct dib_fe_xfer_ops *xfer_ops)
 {
 	struct dib3000_state* state = NULL;
 
@@ -773,9 +775,6 @@
 	if (rd(DIB3000_REG_DEVICE_ID) != DIB3000MB_DEVICE_ID)
 		goto error;
 
-	if (dib3000_init_pid_list(state,DIB3000MB_NUM_PIDS))
-		goto error;
-
 	/* create dvb_frontend */
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
@@ -784,6 +783,7 @@
 	xfer_ops->pid_parse = dib3000mb_pid_parse;
 	xfer_ops->fifo_ctrl = dib3000mb_fifo_control;
 	xfer_ops->pid_ctrl = dib3000mb_pid_control;
+	xfer_ops->tuner_pass_ctrl = dib3000mb_tuner_pass_ctrl;
 
 	return &state->frontend;
 
@@ -807,6 +807,7 @@
 				FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
 				FE_CAN_TRANSMISSION_MODE_AUTO |
 				FE_CAN_GUARD_INTERVAL_AUTO |
+				FE_CAN_RECOVER |
 				FE_CAN_HIERARCHY_AUTO,
 	},
 
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000mc.c linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000mc.c
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000mc.c	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000mc.c	2005-01-20 19:56:38.000000000 +0100
@@ -2,9 +2,9 @@
  * Frontend driver for mobile DVB-T demodulator DiBcom 3000-MC/P
  * DiBcom (http://www.dibcom.fr/)
  *
- * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
- * based on GPL code from DibCom, which has
+ * based on GPL code from DiBCom, which has
  *
  * Copyright (C) 2004 Amaury Demol for DiBcom (ademol@dibcom.fr)
  *
@@ -28,7 +28,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-#include "dvb_frontend.h"
 #include "dib3000-common.h"
 #include "dib3000mc_priv.h"
 #include "dib3000.h"
@@ -40,14 +39,16 @@
 
 #ifdef CONFIG_DVB_DIBCOM_DEBUG
 static int debug;
-module_param(debug, int, 0x644);
-MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=setfe,8=getfe (|-able)).");
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=setfe,8=getfe,16=stat (|-able)).");
 #endif
 #define deb_info(args...) dprintk(0x01,args)
 #define deb_xfer(args...) dprintk(0x02,args)
 #define deb_setf(args...) dprintk(0x04,args)
 #define deb_getf(args...) dprintk(0x08,args)
+#define deb_stat(args...) dprintk(0x10,args)
 
+static int dib3000mc_tuner_pass_ctrl(struct dvb_frontend *fe, int onoff, u8 pll_addr);
 
 static int dib3000mc_set_impulse_noise(struct dib3000_state * state, int mode,
 	fe_transmit_mode_t transmission_mode, fe_bandwidth_t bandwidth)
@@ -185,46 +186,33 @@
 	return 0;
 }
 
-static int dib3000mc_get_frontend(struct dvb_frontend* fe,
-				  struct dvb_frontend_parameters *fep);
+static int dib3000mc_set_adp_cfg(struct dib3000_state *state, fe_modulation_t con)
+{
+	switch (con) {
+		case QAM_64: 
+			wr_foreach(dib3000mc_reg_adp_cfg,dib3000mc_adp_cfg[2]);
+			break;
+		case QAM_16: 
+			wr_foreach(dib3000mc_reg_adp_cfg,dib3000mc_adp_cfg[1]);
+			break;
+		case QPSK: 
+			wr_foreach(dib3000mc_reg_adp_cfg,dib3000mc_adp_cfg[0]);
+			break;
+		case QAM_AUTO:
+			break;
+		default:
+			warn("unkown constellation.");
+			break;
+	}
+	return 0;
+}
 
-static int dib3000mc_set_frontend(struct dvb_frontend* fe,
-				  struct dvb_frontend_parameters *fep, int tuner)
+static int dib3000mc_set_general_cfg(struct dib3000_state *state, struct dvb_frontend_parameters *fep, int *auto_val)
 {
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
 	fe_code_rate_t fe_cr = FEC_NONE;
-	int search_state, seq;
-	u16 val;
 	u8 fft=0, guard=0, qam=0, alpha=0, sel_hp=0, cr=0, hrch=0;
-
-	if (tuner) {
-		wr(DIB3000MC_REG_TUNER,
-				DIB3000_TUNER_WRITE_ENABLE(state->config.pll_addr));
-		state->config.pll_set(fe, fep);
-		wr(DIB3000MC_REG_TUNER,
-				DIB3000_TUNER_WRITE_DISABLE(state->config.pll_addr));
-	}
-
-	dib3000mc_set_timing(state,0,ofdm->transmission_mode,ofdm->bandwidth);
-	dib3000mc_init_auto_scan(state, ofdm->bandwidth, 0);
-
-	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_AGC);
-	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_OFF);
-
-/* Default cfg isi offset adp */
-	wr_foreach(dib3000mc_reg_offset,dib3000mc_offset[0]);
-
-	wr(DIB3000MC_REG_ISI,DIB3000MC_ISI_DEFAULT | DIB3000MC_ISI_INHIBIT);
-	wr_foreach(dib3000mc_reg_adp_cfg,dib3000mc_adp_cfg[1]);
-	wr(DIB3000MC_REG_UNK_133,DIB3000MC_UNK_133);
-
-	wr_foreach(dib3000mc_reg_bandwidth_general,dib3000mc_bandwidth_general);
-	if (ofdm->bandwidth == BANDWIDTH_8_MHZ) {
-		wr_foreach(dib3000mc_reg_bw,dib3000mc_bw[3]);
-	} else {
-		wr_foreach(dib3000mc_reg_bw,dib3000mc_bw[0]);
-	}
+	int seq;
 
 	switch (ofdm->transmission_mode) {
 		case TRANSMISSION_MODE_2K: fft = DIB3000_TRANSMISSION_MODE_2K; break;
@@ -282,8 +270,7 @@
 		case INVERSION_OFF:
 			wr(DIB3000MC_REG_SET_DDS_FREQ_MSB,DIB3000MC_DDS_FREQ_MSB_INV_OFF);
 			break;
-		case INVERSION_AUTO:
-			break;
+		case INVERSION_AUTO: /* fall through */
 		case INVERSION_ON:
 			wr(DIB3000MC_REG_SET_DDS_FREQ_MSB,DIB3000MC_DDS_FREQ_MSB_INV_ON);
 			break;
@@ -298,168 +285,12 @@
 
 	deb_setf("seq? %d\n", seq);
 	wr(DIB3000MC_REG_SEQ_TPS,DIB3000MC_SEQ_TPS(seq,1));
-
-	dib3000mc_set_impulse_noise(state,0,ofdm->constellation,ofdm->bandwidth);
-
-	val = rd(DIB3000MC_REG_DEMOD_PARM);
-	wr(DIB3000MC_REG_DEMOD_PARM,val|DIB3000MC_DEMOD_RST_DEMOD_ON);
-	wr(DIB3000MC_REG_DEMOD_PARM,val);
-
-	msleep(70);
-
-	wr_foreach(dib3000mc_reg_agc_bandwidth, dib3000mc_agc_bandwidth);
-
-	/* something has to be auto searched */
-	if (ofdm->constellation == QAM_AUTO ||
+	*auto_val = ofdm->constellation == QAM_AUTO ||
 		ofdm->hierarchy_information == HIERARCHY_AUTO ||
 		ofdm->guard_interval == GUARD_INTERVAL_AUTO ||
 		ofdm->transmission_mode == TRANSMISSION_MODE_AUTO ||
 		fe_cr == FEC_AUTO ||
-		fep->inversion == INVERSION_AUTO
-		) {
-		int as_count=0;
-
-		deb_setf("autosearch enabled.\n");
-
-		val = rd(DIB3000MC_REG_DEMOD_PARM);
-		wr(DIB3000MC_REG_DEMOD_PARM,val | DIB3000MC_DEMOD_RST_AUTO_SRCH_ON);
-		wr(DIB3000MC_REG_DEMOD_PARM,val);
-
-		while ((search_state = dib3000_search_status(
-					rd(DIB3000MC_REG_AS_IRQ),1)) < 0 && as_count++ < 100)
-			msleep(10);
-
-		deb_info("search_state after autosearch %d after %d checks\n",search_state,as_count);
-
-		if (search_state == 1) {
-			struct dvb_frontend_parameters feps;
-			feps.u.ofdm.bandwidth = ofdm->bandwidth; /* bw is not auto searched */;
-			if (dib3000mc_get_frontend(fe, &feps) == 0) {
-				deb_setf("reading tuning data from frontend succeeded.\n");
-				return dib3000mc_set_frontend(fe, &feps, 0);
-			}
-		}
-	} else {
-		wr(DIB3000MC_REG_ISI,DIB3000MC_ISI_DEFAULT|DIB3000MC_ISI_ACTIVATE);
-		wr_foreach(dib3000mc_reg_adp_cfg,dib3000mc_adp_cfg[qam]);
-		/* set_offset_cfg */
-		wr_foreach(dib3000mc_reg_offset,
-				dib3000mc_offset[(ofdm->transmission_mode == TRANSMISSION_MODE_8K)+1]);
-
-//		dib3000mc_set_timing(1,ofdm->transmission_mode,ofdm->bandwidth);
-
-//		wr(DIB3000MC_REG_LOCK_MASK,DIB3000MC_ACTIVATE_LOCK_MASK); /* activates some locks if needed */
-
-/*		set_or(DIB3000MC_REG_DEMOD_PARM,DIB3000MC_DEMOD_RST_AUTO_SRCH_ON);
-		set_or(DIB3000MC_REG_DEMOD_PARM,DIB3000MC_DEMOD_RST_AUTO_SRCH_OFF);
-		wr(DIB3000MC_REG_RESTART_VIT,DIB3000MC_RESTART_VIT_ON);
-		wr(DIB3000MC_REG_RESTART_VIT,DIB3000MC_RESTART_VIT_OFF);*/
-	}
-
-	return 0;
-}
-
-
-static int dib3000mc_fe_init(struct dvb_frontend* fe, int mobile_mode)
-{
-	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
-
-	state->timing_offset = 0;
-	state->timing_offset_comp_done = 0;
-
-	wr(DIB3000MC_REG_ELEC_OUT,DIB3000MC_ELEC_OUT_DIV_OUT_ON);
-	wr(DIB3000MC_REG_OUTMODE,DIB3000MC_OM_PAR_CONT_CLK);
-	wr(DIB3000MC_REG_RST_I2C_ADDR,
-		DIB3000MC_DEMOD_ADDR(state->config.demod_address) |
-		DIB3000MC_DEMOD_ADDR_ON);
-
-	wr(DIB3000MC_REG_RST_I2C_ADDR,
-		DIB3000MC_DEMOD_ADDR(state->config.demod_address));
-
-	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_CONFIG);
-	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_OFF);
-
-	wr(DIB3000MC_REG_CLK_CFG_1,DIB3000MC_CLK_CFG_1_POWER_UP);
-	wr(DIB3000MC_REG_CLK_CFG_2,DIB3000MC_CLK_CFG_2_PUP_MOBILE);
-	wr(DIB3000MC_REG_CLK_CFG_3,DIB3000MC_CLK_CFG_3_POWER_UP);
-	wr(DIB3000MC_REG_CLK_CFG_7,DIB3000MC_CLK_CFG_7_INIT);
-
-	wr(DIB3000MC_REG_RST_UNC,DIB3000MC_RST_UNC_OFF);
-	wr(DIB3000MC_REG_UNK_19,DIB3000MC_UNK_19);
-
-	wr(33,5);
-	wr(36,81);
-	wr(DIB3000MC_REG_UNK_88,DIB3000MC_UNK_88);
-
-	wr(DIB3000MC_REG_UNK_99,DIB3000MC_UNK_99);
-	wr(DIB3000MC_REG_UNK_111,DIB3000MC_UNK_111_PH_N_MODE_0); /* phase noise algo off */
-
-	/* mobile mode - portable reception */
-	wr_foreach(dib3000mc_reg_mobile_mode,dib3000mc_mobile_mode[1]);
-
-/* TUNER_PANASONIC_ENV57H12D5: */
-	wr_foreach(dib3000mc_reg_agc_bandwidth,dib3000mc_agc_bandwidth);
-	wr_foreach(dib3000mc_reg_agc_bandwidth_general,dib3000mc_agc_bandwidth_general);
-	wr_foreach(dib3000mc_reg_agc,dib3000mc_agc_tuner[1]);
-
-	wr(DIB3000MC_REG_UNK_110,DIB3000MC_UNK_110);
-	wr(26,0x6680);
-	wr(DIB3000MC_REG_UNK_1,DIB3000MC_UNK_1);
-	wr(DIB3000MC_REG_UNK_2,DIB3000MC_UNK_2);
-	wr(DIB3000MC_REG_UNK_3,DIB3000MC_UNK_3);
-	wr(DIB3000MC_REG_SEQ_TPS,DIB3000MC_SEQ_TPS_DEFAULT);
-
-	wr_foreach(dib3000mc_reg_bandwidth_general,dib3000mc_bandwidth_general);
-	wr_foreach(dib3000mc_reg_bandwidth,dib3000mc_bandwidth_8mhz);
-
-	wr(DIB3000MC_REG_UNK_4,DIB3000MC_UNK_4);
-
-	wr(DIB3000MC_REG_SET_DDS_FREQ_MSB,DIB3000MC_DDS_FREQ_MSB_INV_OFF);
-	wr(DIB3000MC_REG_SET_DDS_FREQ_LSB,DIB3000MC_DDS_FREQ_LSB);
-
-	dib3000mc_set_timing(state,0,TRANSMISSION_MODE_2K,BANDWIDTH_8_MHZ);
-//	wr_foreach(dib3000mc_reg_timing_freq,dib3000mc_timing_freq[3]);
-
-	wr(DIB3000MC_REG_UNK_120,DIB3000MC_UNK_120);
-	wr(DIB3000MC_REG_UNK_134,DIB3000MC_UNK_134);
-	wr(DIB3000MC_REG_FEC_CFG,DIB3000MC_FEC_CFG);
-
-	dib3000mc_set_impulse_noise(state,0,TRANSMISSION_MODE_8K,BANDWIDTH_8_MHZ);
-
-/* output mode control, just the MPEG2_SLAVE */
-	set_or(DIB3000MC_REG_OUTMODE,DIB3000MC_OM_SLAVE);
-	wr(DIB3000MC_REG_SMO_MODE,DIB3000MC_SMO_MODE_SLAVE);
-	wr(DIB3000MC_REG_FIFO_THRESHOLD,DIB3000MC_FIFO_THRESHOLD_SLAVE);
-	wr(DIB3000MC_REG_ELEC_OUT,DIB3000MC_ELEC_OUT_SLAVE);
-
-/* MPEG2_PARALLEL_CONTINUOUS_CLOCK
-	wr(DIB3000MC_REG_OUTMODE,
-		DIB3000MC_SET_OUTMODE(DIB3000MC_OM_PAR_CONT_CLK,
-			rd(DIB3000MC_REG_OUTMODE)));
-
-	wr(DIB3000MC_REG_SMO_MODE,
-			DIB3000MC_SMO_MODE_DEFAULT |
-			DIB3000MC_SMO_MODE_188);
-
-	wr(DIB3000MC_REG_FIFO_THRESHOLD,DIB3000MC_FIFO_THRESHOLD_DEFAULT);
-	wr(DIB3000MC_REG_ELEC_OUT,DIB3000MC_ELEC_OUT_DIV_OUT_ON);
-*/
-/* diversity */
-	wr(DIB3000MC_REG_DIVERSITY1,DIB3000MC_DIVERSITY1_DEFAULT);
-	wr(DIB3000MC_REG_DIVERSITY2,DIB3000MC_DIVERSITY2_DEFAULT);
-
-	wr(DIB3000MC_REG_DIVERSITY3,DIB3000MC_DIVERSITY3_IN_OFF);
-
-	set_or(DIB3000MC_REG_CLK_CFG_7,DIB3000MC_CLK_CFG_7_DIV_IN_OFF);
-
-
-/*	if (state->config->pll_init) {
-		wr(DIB3000MC_REG_TUNER,
-			DIB3000_TUNER_WRITE_ENABLE(state->config->pll_addr));
-		state->config->pll_init(fe);
-		wr(DIB3000MC_REG_TUNER,
-			DIB3000_TUNER_WRITE_DISABLE(state->config->pll_addr));
-	}*/
+			fep->inversion == INVERSION_AUTO;
 	return 0;
 }
 
@@ -476,7 +307,8 @@
 	if (!(rd(DIB3000MC_REG_LOCK_507) & DIB3000MC_LOCK_507))
 		return 0;
 
-	dds_val = ((rd(DIB3000MC_REG_DDS_FREQ_MSB) & 0xff) << 16) + rd(DIB3000MC_REG_DDS_FREQ_LSB);
+	dds_val = (rd(DIB3000MC_REG_DDS_FREQ_MSB) << 16) + rd(DIB3000MC_REG_DDS_FREQ_LSB);
+	deb_getf("DDS_FREQ: %6x\n",dds_val);
 	if (dds_val < threshold)
 		inv_test1 = 0;
 	else if (dds_val == threshold)
@@ -484,7 +316,8 @@
 	else
 		inv_test1 = 2;
 
-	dds_val = ((rd(DIB3000MC_REG_SET_DDS_FREQ_MSB) & 0xff) << 16) + rd(DIB3000MC_REG_SET_DDS_FREQ_LSB);
+	dds_val = (rd(DIB3000MC_REG_SET_DDS_FREQ_MSB) << 16) + rd(DIB3000MC_REG_SET_DDS_FREQ_LSB);
+	deb_getf("DDS_SET_FREQ: %6x\n",dds_val);
 	if (dds_val < threshold)
 		inv_test2 = 0;
 	else if (dds_val == threshold)
@@ -499,6 +332,9 @@
 
 	deb_getf("inversion %d %d, %d\n", inv_test2, inv_test1, fep->inversion);
 
+	fep->frequency = state->last_tuned_freq;
+	fep->u.ofdm.bandwidth= state->last_tuned_bw;
+	
 	tps_val = rd(DIB3000MC_REG_TUNING_PARM);
 
 	switch (DIB3000MC_TP_QAM(tps_val)) {
@@ -614,9 +450,211 @@
 			err("unexpected transmission mode return by TPS (%d)", tps_val);
 			break;
 	}
+	deb_getf("\n");
+
+	return 0;
+}
+
+static int dib3000mc_set_frontend(struct dvb_frontend* fe,
+				  struct dvb_frontend_parameters *fep, int tuner)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
+	int search_state,auto_val;
+	u16 val;
+	
+	if (tuner) { /* initial call from dvb */
+		dib3000mc_tuner_pass_ctrl(fe,1,state->config.pll_addr(fe));
+		state->config.pll_set(fe,fep,NULL);
+		dib3000mc_tuner_pass_ctrl(fe,0,state->config.pll_addr(fe));
+		
+		state->last_tuned_freq = fep->frequency;
+	//	if (!scanboost) {
+			dib3000mc_set_timing(state,0,ofdm->transmission_mode,ofdm->bandwidth);
+			dib3000mc_init_auto_scan(state, ofdm->bandwidth, 0);
+			state->last_tuned_bw = ofdm->bandwidth;
+
+			wr_foreach(dib3000mc_reg_agc_bandwidth,dib3000mc_agc_bandwidth);
+			wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_AGC);
+			wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_OFF);
+			
+			/* Default cfg isi offset adp */
+			wr_foreach(dib3000mc_reg_offset,dib3000mc_offset[0]);
+
+			wr(DIB3000MC_REG_ISI,DIB3000MC_ISI_DEFAULT | DIB3000MC_ISI_INHIBIT);
+			dib3000mc_set_adp_cfg(state,ofdm->constellation);
+			wr(DIB3000MC_REG_UNK_133,DIB3000MC_UNK_133);
+
+			wr_foreach(dib3000mc_reg_bandwidth_general,dib3000mc_bandwidth_general);
+			/* power smoothing */
+			if (ofdm->bandwidth != BANDWIDTH_8_MHZ) {
+				wr_foreach(dib3000mc_reg_bw,dib3000mc_bw[0]);
+			} else {
+				wr_foreach(dib3000mc_reg_bw,dib3000mc_bw[3]);
+			}
+			auto_val = 0;
+			dib3000mc_set_general_cfg(state,fep,&auto_val);
+			dib3000mc_set_impulse_noise(state,0,ofdm->constellation,ofdm->bandwidth);
+		
+			val = rd(DIB3000MC_REG_DEMOD_PARM);
+			wr(DIB3000MC_REG_DEMOD_PARM,val|DIB3000MC_DEMOD_RST_DEMOD_ON);
+			wr(DIB3000MC_REG_DEMOD_PARM,val);
+	//	}
+		msleep(70);
+
+		/* something has to be auto searched */
+		if (auto_val) {
+			int as_count=0;
+
+			deb_setf("autosearch enabled.\n");
+			
+			val = rd(DIB3000MC_REG_DEMOD_PARM);
+			wr(DIB3000MC_REG_DEMOD_PARM,val | DIB3000MC_DEMOD_RST_AUTO_SRCH_ON);
+			wr(DIB3000MC_REG_DEMOD_PARM,val);
+
+			while ((search_state = dib3000_search_status(
+						rd(DIB3000MC_REG_AS_IRQ),1)) < 0 && as_count++ < 100) 
+				msleep(10);
+			
+			deb_info("search_state after autosearch %d after %d checks\n",search_state,as_count);
+			
+			if (search_state == 1) {
+				struct dvb_frontend_parameters feps;
+				if (dib3000mc_get_frontend(fe, &feps) == 0) {
+					deb_setf("reading tuning data from frontend succeeded.\n");
+					return dib3000mc_set_frontend(fe, &feps, 0);
+				}
+			}
+		} else {
+			dib3000mc_set_impulse_noise(state,0,ofdm->transmission_mode,ofdm->bandwidth);
+			wr(DIB3000MC_REG_ISI,DIB3000MC_ISI_DEFAULT|DIB3000MC_ISI_ACTIVATE);
+			dib3000mc_set_adp_cfg(state,ofdm->constellation);
+			
+			/* set_offset_cfg */
+			wr_foreach(dib3000mc_reg_offset,
+					dib3000mc_offset[(ofdm->transmission_mode == TRANSMISSION_MODE_8K)+1]);
+		}
+	} else { /* second call, after autosearch (fka: set_WithKnownParams) */
+//		dib3000mc_set_timing(state,1,ofdm->transmission_mode,ofdm->bandwidth);
+		
+		auto_val = 0;
+		dib3000mc_set_general_cfg(state,fep,&auto_val);
+		if (auto_val)
+			deb_info("auto_val is true, even though an auto search was already performed.\n");
+
+		dib3000mc_set_impulse_noise(state,0,ofdm->constellation,ofdm->bandwidth);
+		
+		val = rd(DIB3000MC_REG_DEMOD_PARM);
+		wr(DIB3000MC_REG_DEMOD_PARM,val | DIB3000MC_DEMOD_RST_AUTO_SRCH_ON);
+		wr(DIB3000MC_REG_DEMOD_PARM,val);
+		
+		msleep(30);
+		
+		wr(DIB3000MC_REG_ISI,DIB3000MC_ISI_DEFAULT|DIB3000MC_ISI_ACTIVATE);
+			dib3000mc_set_adp_cfg(state,ofdm->constellation);
+		wr_foreach(dib3000mc_reg_offset,
+				dib3000mc_offset[(ofdm->transmission_mode == TRANSMISSION_MODE_8K)+1]);
+		
+				
+	}
 	return 0;
 }
 
+static int dib3000mc_fe_init(struct dvb_frontend* fe, int mobile_mode)
+{
+	deb_info("init start\n");
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+
+	state->timing_offset = 0;
+	state->timing_offset_comp_done = 0;
+	
+	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_CONFIG);
+	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_OFF);
+	wr(DIB3000MC_REG_CLK_CFG_1,DIB3000MC_CLK_CFG_1_POWER_UP);
+	wr(DIB3000MC_REG_CLK_CFG_2,DIB3000MC_CLK_CFG_2_PUP_MOBILE);
+	wr(DIB3000MC_REG_CLK_CFG_3,DIB3000MC_CLK_CFG_3_POWER_UP);
+	wr(DIB3000MC_REG_CLK_CFG_7,DIB3000MC_CLK_CFG_7_INIT);
+	
+	wr(DIB3000MC_REG_RST_UNC,DIB3000MC_RST_UNC_OFF);
+	wr(DIB3000MC_REG_UNK_19,DIB3000MC_UNK_19);
+
+	wr(33,5);
+	wr(36,81);
+	wr(DIB3000MC_REG_UNK_88,DIB3000MC_UNK_88);				  
+	
+	wr(DIB3000MC_REG_UNK_99,DIB3000MC_UNK_99);
+	wr(DIB3000MC_REG_UNK_111,DIB3000MC_UNK_111_PH_N_MODE_0); /* phase noise algo off */
+
+	/* mobile mode - portable reception */
+	wr_foreach(dib3000mc_reg_mobile_mode,dib3000mc_mobile_mode[1]); 
+
+/* TUNER_PANASONIC_ENV57H12D5: */
+	wr_foreach(dib3000mc_reg_agc_bandwidth,dib3000mc_agc_bandwidth);
+	wr_foreach(dib3000mc_reg_agc_bandwidth_general,dib3000mc_agc_bandwidth_general);
+	wr_foreach(dib3000mc_reg_agc,dib3000mc_agc_tuner[1]);
+
+	wr(DIB3000MC_REG_UNK_110,DIB3000MC_UNK_110);
+	wr(26,0x6680);
+	wr(DIB3000MC_REG_UNK_1,DIB3000MC_UNK_1);
+	wr(DIB3000MC_REG_UNK_2,DIB3000MC_UNK_2);
+	wr(DIB3000MC_REG_UNK_3,DIB3000MC_UNK_3);
+	wr(DIB3000MC_REG_SEQ_TPS,DIB3000MC_SEQ_TPS_DEFAULT);
+	
+	wr_foreach(dib3000mc_reg_bandwidth,dib3000mc_bandwidth_8mhz);
+	wr_foreach(dib3000mc_reg_bandwidth_general,dib3000mc_bandwidth_general);
+	
+	wr(DIB3000MC_REG_UNK_4,DIB3000MC_UNK_4);
+
+	wr(DIB3000MC_REG_SET_DDS_FREQ_MSB,DIB3000MC_DDS_FREQ_MSB_INV_OFF);
+	wr(DIB3000MC_REG_SET_DDS_FREQ_LSB,DIB3000MC_DDS_FREQ_LSB);
+
+	dib3000mc_set_timing(state,0,TRANSMISSION_MODE_8K,BANDWIDTH_8_MHZ); 
+//	wr_foreach(dib3000mc_reg_timing_freq,dib3000mc_timing_freq[3]);
+	
+	wr(DIB3000MC_REG_UNK_120,DIB3000MC_UNK_120);
+	wr(DIB3000MC_REG_UNK_134,DIB3000MC_UNK_134);
+	wr(DIB3000MC_REG_FEC_CFG,DIB3000MC_FEC_CFG);
+	
+	wr(DIB3000MC_REG_DIVERSITY3,DIB3000MC_DIVERSITY3_IN_OFF);
+	
+	dib3000mc_set_impulse_noise(state,0,TRANSMISSION_MODE_8K,BANDWIDTH_8_MHZ);
+
+/* output mode control, just the MPEG2_SLAVE */
+//	set_or(DIB3000MC_REG_OUTMODE,DIB3000MC_OM_SLAVE);
+	wr(DIB3000MC_REG_OUTMODE,DIB3000MC_OM_SLAVE);
+	wr(DIB3000MC_REG_SMO_MODE,DIB3000MC_SMO_MODE_SLAVE);
+	wr(DIB3000MC_REG_FIFO_THRESHOLD,DIB3000MC_FIFO_THRESHOLD_SLAVE);
+	wr(DIB3000MC_REG_ELEC_OUT,DIB3000MC_ELEC_OUT_SLAVE);
+
+/* MPEG2_PARALLEL_CONTINUOUS_CLOCK
+	wr(DIB3000MC_REG_OUTMODE,
+		DIB3000MC_SET_OUTMODE(DIB3000MC_OM_PAR_CONT_CLK,
+			rd(DIB3000MC_REG_OUTMODE)));
+
+	wr(DIB3000MC_REG_SMO_MODE,
+			DIB3000MC_SMO_MODE_DEFAULT | 
+			DIB3000MC_SMO_MODE_188);
+
+	wr(DIB3000MC_REG_FIFO_THRESHOLD,DIB3000MC_FIFO_THRESHOLD_DEFAULT);
+	wr(DIB3000MC_REG_ELEC_OUT,DIB3000MC_ELEC_OUT_DIV_OUT_ON);
+*/
+	
+/* diversity */
+	wr(DIB3000MC_REG_DIVERSITY1,DIB3000MC_DIVERSITY1_DEFAULT);
+	wr(DIB3000MC_REG_DIVERSITY2,DIB3000MC_DIVERSITY2_DEFAULT);
+
+	set_and(DIB3000MC_REG_DIVERSITY3,DIB3000MC_DIVERSITY3_IN_OFF);
+
+	set_or(DIB3000MC_REG_CLK_CFG_7,DIB3000MC_CLK_CFG_7_DIV_IN_OFF);
+
+/*	if (state->config->pll_init) {
+		dib3000mc_tuner_pass_ctrl(fe,1,state->config.pll_addr(fe));
+		state->config->pll_init(fe,NULL);
+		dib3000mc_tuner_pass_ctrl(fe,0,state->config.pll_addr(fe));
+	}*/
+	deb_info("init end\n");
+	return 0;
+}
 static int dib3000mc_read_status(struct dvb_frontend* fe, fe_status_t *stat)
 {
 	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
@@ -627,12 +665,12 @@
 		*stat |= FE_HAS_SIGNAL;
 	if (DIB3000MC_CARRIER_LOCK(lock))
 		*stat |= FE_HAS_CARRIER;
-	if (DIB3000MC_TPS_LOCK(lock)) /* VIT_LOCK ? */
+	if (DIB3000MC_TPS_LOCK(lock))
 		*stat |= FE_HAS_VITERBI;
 	if (DIB3000MC_MPEG_SYNC_LOCK(lock))
 		*stat |= (FE_HAS_SYNC | FE_HAS_LOCK);
 
-	deb_info("actual status is %2x\n",*stat);
+	deb_stat("actual status is %2x fifo_level: %x,244: %x, 206: %x, 207: %x, 1040: %x\n",*stat,rd(510),rd(244),rd(206),rd(207),rd(1040));
 
 	return 0;
 }
@@ -659,7 +697,7 @@
 	u16 val = rd(DIB3000MC_REG_SIGNAL_NOISE_LSB);
 	*strength = (((val >> 6) & 0xff) << 8) + (val & 0x3f);
 
-	deb_info("signal: mantisse = %d, exponent = %d\n",(*strength >> 8) & 0xff, *strength & 0xff);
+	deb_stat("signal: mantisse = %d, exponent = %d\n",(*strength >> 8) & 0xff, *strength & 0xff);
 	return 0;
 }
 
@@ -667,9 +705,8 @@
 static int dib3000mc_read_snr(struct dvb_frontend* fe, u16 *snr)
 {
 	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
-
-	u16 val = rd(DIB3000MC_REG_SIGNAL_NOISE_MSB),
-		val2 = rd(DIB3000MC_REG_SIGNAL_NOISE_LSB);
+	u16 val = rd(DIB3000MC_REG_SIGNAL_NOISE_LSB),
+		val2 = rd(DIB3000MC_REG_SIGNAL_NOISE_MSB);
 	u16 sig,noise;
 
 	sig =   (((val >> 6) & 0xff) << 8) + (val & 0x3f);
@@ -679,9 +716,9 @@
 	else
 		*snr = (u16) sig/noise;
 
-	deb_info("signal: mantisse = %d, exponent = %d\n",(sig >> 8) & 0xff, sig & 0xff);
-	deb_info("noise:  mantisse = %d, exponent = %d\n",(noise >> 8) & 0xff, noise & 0xff);
-	deb_info("snr: %d\n",*snr);
+	deb_stat("signal: mantisse = %d, exponent = %d\n",(sig >> 8) & 0xff, sig & 0xff);
+	deb_stat("noise:  mantisse = %d, exponent = %d\n",(noise >> 8) & 0xff, noise & 0xff);
+	deb_stat("snr: %d\n",*snr);
 	return 0;
 }
 
@@ -698,7 +735,7 @@
 
 static int dib3000mc_fe_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings *tune)
 {
-	tune->min_delay_ms = 800;
+	tune->min_delay_ms = 2000;
 	tune->step_size = 166667;
 	tune->max_drift = 166667 * 2;
 
@@ -718,23 +755,15 @@
 static void dib3000mc_release(struct dvb_frontend* fe)
 {
 	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
-	dib3000_dealloc_pid_list(state);
 	kfree(state);
 }
 
 /* pid filter and transfer stuff */
-static int dib3000mc_pid_control(struct dvb_frontend *fe,int pid,int onoff)
+static int dib3000mc_pid_control(struct dvb_frontend *fe,int index, int pid,int onoff)
 {
 	struct dib3000_state *state = fe->demodulator_priv;
-	int index = dib3000_get_pid_index(state->pid_list, DIB3000MC_NUM_PIDS, pid, &state->pid_list_lock,onoff);
 	pid = (onoff ? pid | DIB3000_ACTIVATE_PID_FILTERING : 0);
-
-	if (index >= 0) {
 		wr(index+DIB3000MC_REG_FIRST_PID,pid);
-	} else {
-		err("no more pids for filtering.");
-		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -742,10 +771,14 @@
 {
 	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
 	u16 tmp = rd(DIB3000MC_REG_SMO_MODE);
-	deb_xfer("%s fifo",onoff ? "enabling" : "disabling");
+	
+	deb_xfer("%s fifo\n",onoff ? "enabling" : "disabling");
+	
 	if (onoff) {
+		deb_xfer("%d %x\n",tmp & DIB3000MC_SMO_MODE_FIFO_UNFLUSH,tmp & DIB3000MC_SMO_MODE_FIFO_UNFLUSH);
 		wr(DIB3000MC_REG_SMO_MODE,tmp & DIB3000MC_SMO_MODE_FIFO_UNFLUSH);
 	} else {
+		deb_xfer("%d %x\n",tmp | DIB3000MC_SMO_MODE_FIFO_FLUSH,tmp | DIB3000MC_SMO_MODE_FIFO_FLUSH);
 		wr(DIB3000MC_REG_SMO_MODE,tmp | DIB3000MC_SMO_MODE_FIFO_FLUSH);
 	}
 	return 0;
@@ -755,19 +788,57 @@
 {
 	struct dib3000_state *state = fe->demodulator_priv;
 	u16 tmp = rd(DIB3000MC_REG_SMO_MODE);
-	deb_xfer("%s pid parsing",onoff ? "enabling" : "disabling");
+	
+	deb_xfer("%s pid parsing\n",onoff ? "enabling" : "disabling");
+	
 	if (onoff) {
+		deb_xfer("%d %x\n",tmp | DIB3000MC_SMO_MODE_PID_PARSE,tmp | DIB3000MC_SMO_MODE_PID_PARSE);
 		wr(DIB3000MC_REG_SMO_MODE,tmp | DIB3000MC_SMO_MODE_PID_PARSE);
 	} else {
+		deb_xfer("%d %x\n",tmp & DIB3000MC_SMO_MODE_NO_PID_PARSE,tmp & DIB3000MC_SMO_MODE_NO_PID_PARSE);
 		wr(DIB3000MC_REG_SMO_MODE,tmp & DIB3000MC_SMO_MODE_NO_PID_PARSE);
 	}
 	return 0;
 }
 
+static int dib3000mc_tuner_pass_ctrl(struct dvb_frontend *fe, int onoff, u8 pll_addr)
+{
+	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
+	if (onoff) {
+		wr(DIB3000MC_REG_TUNER, DIB3000_TUNER_WRITE_ENABLE(pll_addr));
+	} else {
+		wr(DIB3000MC_REG_TUNER, DIB3000_TUNER_WRITE_DISABLE(pll_addr));
+	}
+	return 0;
+}
+
+static int dib3000mc_demod_init(struct dib3000_state *state) 
+{
+	u16 default_addr = 0x0a;
+	/* first init */
+	if (state->config.demod_address != default_addr) {
+		deb_info("initializing the demod the first time. Setting demod addr to 0x%x\n",default_addr);
+		wr(DIB3000MC_REG_ELEC_OUT,DIB3000MC_ELEC_OUT_DIV_OUT_ON);
+		wr(DIB3000MC_REG_OUTMODE,DIB3000MC_OM_PAR_CONT_CLK);
+		
+		wr(DIB3000MC_REG_RST_I2C_ADDR,
+			DIB3000MC_DEMOD_ADDR(default_addr) |
+			DIB3000MC_DEMOD_ADDR_ON);
+	
+		state->config.demod_address = default_addr;
+		
+		wr(DIB3000MC_REG_RST_I2C_ADDR,
+			DIB3000MC_DEMOD_ADDR(default_addr));
+	} else
+		deb_info("demod is already initialized. Demod addr: 0x%x\n",state->config.demod_address);
+	return 0;
+}
+
+
 static struct dvb_frontend_ops dib3000mc_ops;
 
 struct dvb_frontend* dib3000mc_attach(const struct dib3000_config* config,
-				      struct i2c_adapter* i2c, struct dib3000_xfer_ops *xfer_ops)
+				      struct i2c_adapter* i2c, struct dib_fe_xfer_ops *xfer_ops)
 {
 	struct dib3000_state* state = NULL;
 	u16 devid;
@@ -790,19 +861,15 @@
 	if (devid != DIB3000MC_DEVICE_ID && devid != DIB3000P_DEVICE_ID)
 		goto error;
 
-
 	switch (devid) {
 		case DIB3000MC_DEVICE_ID:
-			info("Found a DiBcom 3000-MC.");
+			info("Found a DiBcom 3000-MC, interesting...");
 			break;
 		case DIB3000P_DEVICE_ID:
 			info("Found a DiBcom 3000-P.");
 			break;
 	}
 
-	if (dib3000_init_pid_list(state,DIB3000MC_NUM_PIDS))
-		goto error;
-
 	/* create dvb_frontend */
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
@@ -811,6 +878,9 @@
 	xfer_ops->pid_parse = dib3000mc_pid_parse;
 	xfer_ops->fifo_ctrl = dib3000mc_fifo_control;
 	xfer_ops->pid_ctrl = dib3000mc_pid_control;
+	xfer_ops->tuner_pass_ctrl = dib3000mc_tuner_pass_ctrl;
+
+	dib3000mc_demod_init(state);
 
 	return &state->frontend;
 
@@ -834,6 +904,7 @@
 				FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
 				FE_CAN_TRANSMISSION_MODE_AUTO |
 				FE_CAN_GUARD_INTERVAL_AUTO |
+				FE_CAN_RECOVER |
 				FE_CAN_HIERARCHY_AUTO,
 	},
 
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000mc_priv.h linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000mc_priv.h
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/dib3000mc_priv.h	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/dib3000mc_priv.h	2005-01-20 19:56:38.000000000 +0100
@@ -13,31 +13,6 @@
 #ifndef __DIB3000MC_PRIV_H__
 #define __DIB3000MC_PRIV_H__
 
-/* info and err, taken from usb.h, if there is anything available like by default,
- * please change !
- */
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , __FILE__ , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , __FILE__ , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , __FILE__ , ## arg)
-
-// defines the phase noise algorithm to be used (O:Inhib, 1:CPE on)
-#define DEF_PHASE_NOISE_MODE                0
-
-// define Mobille algorithms
-#define DEF_MOBILE_MODE      Auto_Reception
-
-// defines the tuner type
-#define DEF_TUNER_TYPE   TUNER_PANASONIC_ENV57H13D5
-
-// defines the impule noise algorithm to be used
-#define DEF_IMPULSE_NOISE_MODE      0
-
-// defines the MPEG2 data output format
-#define DEF_MPEG2_OUTPUT_188       0
-
-// defines the MPEG2 data output format
-#define DEF_OUTPUT_MODE       MPEG2_PARALLEL_CONTINUOUS_CLOCK
-
 /*
  * Demodulator parameters
  * reg: 0  1 1  1 11 11 111
@@ -115,7 +90,7 @@
 	{ 0x1c, 0xfba5, 0x60, 0x9c25, 0x1e3, 0x0cb7, 0x1, 0xb0d0 };
 
 static u16 dib3000mc_bandwidth_8mhz[] =
-	{ 0x19, 0x5c30, 0x54, 0x88a0, 0x1a6, 0xab20, 0x1, 0xb0b0 };
+	{ 0x19, 0x5c30, 0x54, 0x88a0, 0x1a6, 0xab20, 0x1, 0xb0d0 };
 
 static u16 dib3000mc_reg_bandwidth_general[] = { 12,13,14,15 };
 static u16 dib3000mc_bandwidth_general[] = { 0x0000, 0x03e8, 0x0000, 0x03f2 };
@@ -173,11 +148,11 @@
 static u16 dib3000mc_reg_imp_noise_ctl[] = { 34,35 };
 
 static u16 dib3000mc_imp_noise_ctl[][2] = {
-	{ 0x1294, 0xfff8 }, /* mode 0 */
-	{ 0x1294, 0xfff8 }, /* mode 1 */
-	{ 0x1294, 0xfff8 }, /* mode 2 */
-	{ 0x1294, 0xfff8 }, /* mode 3 */
-	{ 0x1294, 0xfff8 }, /* mode 4 */
+	{ 0x1294, 0x1ff8 }, /* mode 0 */
+	{ 0x1294, 0x1ff8 }, /* mode 1 */
+	{ 0x1294, 0x1ff8 }, /* mode 2 */
+	{ 0x1294, 0x1ff8 }, /* mode 3 */
+	{ 0x1294, 0x1ff8 }, /* mode 4 */
 };
 
 /* AGC registers */
@@ -314,12 +289,26 @@
 #define DIB3000MC_REG_FEC_CFG			(   195)
 #define DIB3000MC_FEC_CFG				(  0x10)
 
+/*
+ * reg 206, output mode
+ *              1111 1111
+ *              |||| ||||
+ *              |||| |||+- unk
+ *              |||| ||+-- unk
+ *              |||| |+--- unk (on by default)
+ *              |||| +---- fifo_ctrl (1 = inhibit (flushed), 0 = active (unflushed))
+ *              |||+------ pid_parse (1 = enabled, 0 = disabled)
+ *              ||+------- outp_188  (1 = TS packet size 188, 0 = packet size 204)
+ *              |+-------- unk 
+ *              +--------- unk
+ */
+
 #define DIB3000MC_REG_SMO_MODE			(   206)
 #define DIB3000MC_SMO_MODE_DEFAULT		(1 << 2)
 #define DIB3000MC_SMO_MODE_FIFO_FLUSH	(1 << 3)
-#define DIB3000MC_SMO_MODE_FIFO_UNFLUSH	~DIB3000MC_SMO_MODE_FIFO_FLUSH
+#define DIB3000MC_SMO_MODE_FIFO_UNFLUSH	(0xfff7)
 #define DIB3000MC_SMO_MODE_PID_PARSE	(1 << 4)
-#define DIB3000MC_SMO_MODE_NO_PID_PARSE	~DIB3000MC_SMO_MODE_PID_PARSE
+#define DIB3000MC_SMO_MODE_NO_PID_PARSE	(0xffef)
 #define DIB3000MC_SMO_MODE_188			(1 << 5)
 #define DIB3000MC_SMO_MODE_SLAVE		(DIB3000MC_SMO_MODE_DEFAULT | \
 			DIB3000MC_SMO_MODE_188 | DIB3000MC_SMO_MODE_PID_PARSE | (1<<1))
@@ -392,7 +381,7 @@
 
 #define DIB3000MC_REG_RST_I2C_ADDR		(  1024)
 #define DIB3000MC_DEMOD_ADDR_ON			(     1)
-#define DIB3000MC_DEMOD_ADDR(a)			((a << 3) & 0x03F0)
+#define DIB3000MC_DEMOD_ADDR(a)			((a << 4) & 0x03F0)
 
 #define DIB3000MC_REG_RESTART			(  1027)
 #define DIB3000MC_RESTART_OFF			(0x0000)

