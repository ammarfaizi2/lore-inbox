Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbUKGMLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUKGMLr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 07:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbUKGMLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 07:11:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39177 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261600AbUKGMLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 07:11:22 -0500
Date: Sun, 7 Nov 2004 13:10:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] some DVB cleanups
Message-ID: <20041107121047.GE14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does some cleanuos under drivers/media/dvb/ .
Most of them are:
- make needlessly global code static
- remove unused code

Most interesting might the the changes to bt878.c:
Why did you export the init/exit functions of this module?

Please review and comment on this patch.


diffstat output:
 drivers/media/dvb/b2c2/skystar2.c                      |    6 +-
 drivers/media/dvb/bt8xx/bt878.c                        |   17 ------
 drivers/media/dvb/dvb-core/dmxdev.c                    |   10 ----
 drivers/media/dvb/dvb-core/dvb_filter.c                |   11 ++--
 drivers/media/dvb/frontends/dst.c                      |    8 +--
 drivers/media/dvb/frontends/grundig_29504-401.c        |    2 
 drivers/media/dvb/ttpci/av7110.c                       |   25 +---------
 drivers/media/dvb/ttpci/av7110_av.c                    |    4 -
 drivers/media/dvb/ttpci/av7110_ca.c                    |   10 ++--
 drivers/media/dvb/ttpci/av7110_v4l.c                   |    6 +-
 drivers/media/dvb/ttpci/budget-patch.c                 |    2 
 drivers/media/dvb/ttpci/budget.c                       |    2 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c      |    4 -
 drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h |    2 
 14 files changed, 37 insertions(+), 72 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/b2c2/skystar2.c.old	2004-11-07 12:40:13.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/b2c2/skystar2.c	2004-11-07 12:40:43.000000000 +0100
@@ -785,7 +785,7 @@
 	return flex_i2c_read(adapter, 0x20000000, 0x50, addr, buf, len);
 }
 
-u8 calc_lrc(u8 *buf, int len)
+static u8 calc_lrc(u8 *buf, int len)
 {
 	int i;
 	u8 sum;
@@ -2135,7 +2135,7 @@
 }
 
 
-int soft_diseqc(struct adapter *adapter, unsigned int cmd, void *arg)
+static int soft_diseqc(struct adapter *adapter, unsigned int cmd, void *arg)
 {
 	switch (cmd) {
 	case FE_SET_TONE:
@@ -2257,7 +2257,7 @@
 	return 0;
 }
 
-u32 flexcop_i2c_func(struct i2c_adapter *adapter)
+static u32 flexcop_i2c_func(struct i2c_adapter *adapter)
 {
 	printk("flexcop_i2c_func\n");
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/bt8xx/bt878.c.old	2004-11-07 12:41:12.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/bt8xx/bt878.c	2004-11-07 12:42:47.000000000 +0100
@@ -559,22 +559,11 @@
 
 static int bt878_pci_driver_registered = 0;
 
-/* This will be used later by dvb-bt8xx to only use the audio
- * dma of certain cards */
-int bt878_find_audio_dma(void)
-{
-	// pci_register_driver(&bt878_pci_driver);
-	bt878_pci_driver_registered = 1;
-	return 0;
-}
-
-EXPORT_SYMBOL(bt878_find_audio_dma);
-
 /*******************************/
 /* Module management functions */
 /*******************************/
 
-int bt878_init_module(void)
+static int bt878_init_module(void)
 {
 	bt878_num = 0;
 	bt878_pci_driver_registered = 0;
@@ -592,7 +581,7 @@
 	return pci_module_init(&bt878_pci_driver);
 }
 
-void bt878_cleanup_module(void)
+static void bt878_cleanup_module(void)
 {
 	if (bt878_pci_driver_registered) {
 		bt878_pci_driver_registered = 0;
@@ -601,8 +590,6 @@
 	return;
 }
 
-EXPORT_SYMBOL(bt878_init_module);
-EXPORT_SYMBOL(bt878_cleanup_module);
 module_init(bt878_init_module);
 module_exit(bt878_cleanup_module);
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/dvb-core/dmxdev.c.old	2004-11-07 12:43:13.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/dvb-core/dmxdev.c	2004-11-07 12:43:48.000000000 +0100
@@ -42,18 +42,12 @@
 
 #define dprintk	if (debug) printk
 
-inline struct dmxdev_filter *
+static inline struct dmxdev_filter *
 dvb_dmxdev_file_to_filter(struct file *file)
 {
 	return (struct dmxdev_filter *) file->private_data;
 }
 
-inline struct dmxdev_dvr *
-dvb_dmxdev_file_to_dvr(struct dmxdev *dmxdev, struct file *file)
-{
-	return (struct dmxdev_dvr *) file->private_data;
-}
-
 static inline void dvb_dmxdev_buffer_init(struct dmxdev_buffer *buffer) 
 {
 	buffer->data=NULL;
@@ -846,7 +840,7 @@
 }
 
 
-ssize_t 
+static ssize_t 
 dvb_demux_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct dmxdev_filter *dmxdevfilter=dvb_dmxdev_file_to_filter(file);
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/dvb-core/dvb_filter.c.old	2004-11-07 12:46:15.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/dvb-core/dvb_filter.c	2004-11-07 13:01:26.000000000 +0100
@@ -3,19 +3,20 @@
 #include <linux/string.h>
 #include "dvb_filter.h"
 
-unsigned int bitrates[3][16] =
+#if 0
+static unsigned int bitrates[3][16] =
 {{0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,0},
  {0,32,48,56,64,80,96,112,128,160,192,224,256,320,384,0},
  {0,32,40,48,56,64,80,96,112,128,160,192,224,256,320,0}};
+#endif
 
-u32 freq[4] = {441, 480, 320, 0};
+static u32 freq[4] = {480, 441, 320, 0};
 
-unsigned int ac3_bitrates[32] =
+static unsigned int ac3_bitrates[32] =
     {32,40,48,56,64,80,96,112,128,160,192,224,256,320,384,448,512,576,640,
      0,0,0,0,0,0,0,0,0,0,0,0,0};
 
-u32 ac3_freq[4] = {480, 441, 320, 0};
-u32 ac3_frames[3][32] =
+static u32 ac3_frames[3][32] =
     {{64,80,96,112,128,160,192,224,256,320,384,448,512,640,768,896,1024,
       1152,1280,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {69,87,104,121,139,174,208,243,278,348,417,487,557,696,835,975,1114,
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/frontends/dst.c.old	2004-11-07 12:47:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/frontends/dst.c	2004-11-07 12:48:21.000000000 +0100
@@ -32,10 +32,10 @@
 #include "dvb_frontend.h"
 #include "dst-bt878.h"
 
-unsigned int dst_verbose = 0;
+static unsigned int dst_verbose = 0;
 module_param(dst_verbose, bool, 0);
 MODULE_PARM_DESC(dst_verbose, "verbose startup messages, default is 1 (yes)");
-unsigned int dst_debug = 0;
+static unsigned int dst_debug = 0;
 module_param(dst_debug, bool, 0);
 MODULE_PARM_DESC(dst_debug, "debug messages, default is 0 (no)");
 
@@ -470,7 +470,7 @@
 	u32 type_flags;
 } DST_TYPES;
 
-struct dst_types dst_tlist[] = {
+static struct dst_types dst_tlist[] = {
 	{"DST-020", 0, DST_TYPE_IS_SAT, DST_TYPE_HAS_SYMDIV},
 	{"DST-030", 0, DST_TYPE_IS_SAT, DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE},
 	{"DST-03T", 0, DST_TYPE_IS_SAT, DST_TYPE_HAS_SYMDIV | DST_TYPE_HAS_TS204},
@@ -895,7 +895,7 @@
 	}
 }
 
-struct lkup {
+static struct lkup {
 	unsigned int cmd;
 	char *desc;
 } looker[] = {
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/frontends/grundig_29504-401.c.old	2004-11-07 12:48:34.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/frontends/grundig_29504-401.c	2004-11-07 12:48:48.000000000 +0100
@@ -52,7 +52,7 @@
 	struct dvb_adapter *dvb;
 };
 
-struct dvb_frontend_info l64781_info = {
+static struct dvb_frontend_info l64781_info = {
 	.name = "Grundig 29504-401 (LSI L64781 Based)",
 	.type = FE_OFDM,
 /*	.frequency_min = ???,*/
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/av7110.c.old	2004-11-07 12:49:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/av7110.c	2004-11-07 12:50:16.000000000 +0100
@@ -94,7 +94,7 @@
 
 static void restart_feeds(struct av7110 *av7110);
 
-int av7110_num = 0;
+static int av7110_num = 0;
 
 static void init_av7110_av(struct av7110 *av7110)
 {
@@ -259,15 +259,15 @@
         irc_handler = NULL;
 }
 
-void run_handlers(unsigned long ircom) 
+static void run_handlers(unsigned long ircom) 
 {
         if (irc_handler != NULL)
                 (*irc_handler)((u32) ircom);
 }
 
-DECLARE_TASKLET(irtask,run_handlers,0);
+static DECLARE_TASKLET(irtask,run_handlers,0);
 
-void IR_handle(struct av7110 *av7110, u32 ircom)
+static void IR_handle(struct av7110 *av7110, u32 ircom)
 {
 	dprintk(4, "ircommand = %08x\n", ircom);
         irtask.data = (unsigned long) ircom;
@@ -1280,23 +1280,6 @@
 	return i2c_transfer(&av7110->i2c_adap, &msgs, 1);
 }
 
-u8 i2c_readreg(struct av7110 *av7110, u8 id, u8 reg)
-{
-	u8 mm1[] = {0x00};
-	u8 mm2[] = {0x00};
-	struct i2c_msg msgs[2];
-
-	msgs[0].flags = 0;
-	msgs[1].flags = I2C_M_RD;
-	msgs[0].addr = msgs[1].addr = id / 2;
-	mm1[0] = reg;
-	msgs[0].len = 1; msgs[1].len = 1;
-	msgs[0].buf = mm1; msgs[1].buf = mm2;
-	i2c_transfer(&av7110->i2c_adap, msgs, 2);
-
-	return mm2[0];
-}
-
 /****************************************************************************
  * INITIALIZATION
  ****************************************************************************/
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/av7110_av.c.old	2004-11-07 12:50:46.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/av7110_av.c	2004-11-07 12:51:15.000000000 +0100
@@ -674,7 +674,7 @@
 }
 
 
-int write_ts_header2(u16 pid, u8 *counter, int pes_start, u8 *buf, u8 length)
+static int write_ts_header2(u16 pid, u8 *counter, int pes_start, u8 *buf, u8 length)
 {
 	int i;
 	int c = 0;
@@ -936,7 +936,7 @@
 	return dvb_aplay(av7110, buf, count, file->f_flags & O_NONBLOCK, 0);
 }
 
-u8 iframe_header[] = { 0x00, 0x00, 0x01, 0xe0, 0x00, 0x00, 0x80, 0x00, 0x00 };
+static u8 iframe_header[] = { 0x00, 0x00, 0x01, 0xe0, 0x00, 0x00, 0x80, 0x00, 0x00 };
 
 #define MIN_IFRAME 400000
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/av7110_ca.c.old	2004-11-07 12:51:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/av7110_ca.c	2004-11-07 12:52:14.000000000 +0100
@@ -89,20 +89,20 @@
  * CI link layer file ops
  ******************************************************************************/
 
-int ci_ll_init(struct dvb_ringbuffer *cirbuf, struct dvb_ringbuffer *ciwbuf, int size)
+static int ci_ll_init(struct dvb_ringbuffer *cirbuf, struct dvb_ringbuffer *ciwbuf, int size)
 {
 	dvb_ringbuffer_init(cirbuf, vmalloc(size), size);
 	dvb_ringbuffer_init(ciwbuf, vmalloc(size), size);
 	return 0;
 }
 
-void ci_ll_flush(struct dvb_ringbuffer *cirbuf, struct dvb_ringbuffer *ciwbuf)
+static void ci_ll_flush(struct dvb_ringbuffer *cirbuf, struct dvb_ringbuffer *ciwbuf)
 {
 	dvb_ringbuffer_flush_spinlock_wakeup(cirbuf);
 	dvb_ringbuffer_flush_spinlock_wakeup(ciwbuf);
 }
 
-void ci_ll_release(struct dvb_ringbuffer *cirbuf, struct dvb_ringbuffer *ciwbuf)
+static void ci_ll_release(struct dvb_ringbuffer *cirbuf, struct dvb_ringbuffer *ciwbuf)
 {
 	vfree(cirbuf->data);
 	cirbuf->data = NULL;
@@ -110,8 +110,8 @@
 	ciwbuf->data = NULL;
 }
 
-int ci_ll_reset(struct dvb_ringbuffer *cibuf, struct file *file,
-		int slots, ca_slot_info_t *slot)
+static int ci_ll_reset(struct dvb_ringbuffer *cibuf, struct file *file,
+		       int slots, ca_slot_info_t *slot)
 {
 	int i;
 	int len = 0;
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/av7110_v4l.c.old	2004-11-07 12:53:21.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/av7110_v4l.c	2004-11-07 12:59:59.000000000 +0100
@@ -162,7 +162,7 @@
 	.capability = V4L2_AUDCAP_STEREO
 };
 
-int av7110_dvb_c_switch(struct saa7146_fh *fh)
+static int av7110_dvb_c_switch(struct saa7146_fh *fh)
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
@@ -227,7 +227,7 @@
 	return 0;
 }
 
-int av7110_ioctl(struct saa7146_fh *fh, unsigned int cmd, void *arg)
+static int av7110_ioctl(struct saa7146_fh *fh, unsigned int cmd, void *arg)
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct av7110 *av7110 = (struct av7110*) dev->ext_priv;
@@ -424,7 +424,7 @@
  * INITIALIZATION
  ****************************************************************************/
 
-struct saa7146_extension_ioctls ioctls[] = {
+static struct saa7146_extension_ioctls ioctls[] = {
 	{ VIDIOC_ENUMINPUT,	SAA7146_EXCLUSIVE },
 	{ VIDIOC_G_INPUT,	SAA7146_EXCLUSIVE },
 	{ VIDIOC_S_INPUT,	SAA7146_EXCLUSIVE },
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/budget-patch.c.old	2004-11-07 12:54:34.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/budget-patch.c	2004-11-07 12:54:43.000000000 +0100
@@ -122,7 +122,7 @@
 }
 
 
-int budget_patch_diseqc_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
+static int budget_patch_diseqc_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
         struct budget_patch *budget = fe->before_after_data;
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/budget.c.old	2004-11-07 12:54:58.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttpci/budget.c	2004-11-07 12:55:08.000000000 +0100
@@ -106,7 +106,7 @@
 }
 
 
-int budget_diseqc_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
+static int budget_diseqc_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
        struct budget *budget = fe->before_after_data;
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h.old	2004-11-07 12:56:10.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h	2004-11-07 12:56:17.000000000 +0100
@@ -1,7 +1,7 @@
 
 #include <asm/types.h>
 
-u8 dsp_bootcode [] = {
+static u8 dsp_bootcode [] = {
 	0x08, 0xaa, 0x00, 0x18, 0x00, 0x03, 0x08, 0x00, 
 	0x00, 0x10, 0x00, 0x00, 0x01, 0x80, 0x18, 0x5f, 
 	0x00, 0x00, 0x01, 0x80, 0x77, 0x18, 0x2a, 0xeb, 
--- linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c.old	2004-11-07 12:55:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-11-07 12:56:53.000000000 +0100
@@ -560,7 +560,7 @@
 				  const u8 * data, int len);
 #endif
 
-int numpkt = 0, lastj, numts, numstuff, numsec, numinvalid;
+static int numpkt = 0, lastj, numts, numstuff, numsec, numinvalid;
 
 static void ttusb_process_muxpack(struct ttusb *ttusb, const u8 * muxpack,
 			   int len)
@@ -1071,7 +1071,7 @@
 };
 #endif
 
-u32 functionality(struct i2c_adapter *adapter)
+static u32 functionality(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C;
 }


