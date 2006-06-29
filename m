Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWF2TUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWF2TUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWF2TUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:20:48 -0400
Received: from [141.84.69.5] ([141.84.69.5]:25360 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932270AbWF2TUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:20:31 -0400
Date: Thu, 29 Jun 2006 21:19:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mike Isely <isely@pobox.com>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/pvrusb2/: possible cleanups
Message-ID: <20060629191949.GO19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 unused global functions

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

BTW: There are still tons of sparse warnings.

 drivers/media/video/pvrusb2/pvrusb2-debugifc.c     |    4 
 drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h |   17 --
 drivers/media/video/pvrusb2/pvrusb2-hdw.c          |   84 ++++++++-----
 drivers/media/video/pvrusb2/pvrusb2-hdw.h          |   32 ----
 drivers/media/video/pvrusb2/pvrusb2-i2c-core.c     |   22 ++-
 drivers/media/video/pvrusb2/pvrusb2-i2c-core.h     |    3 
 drivers/media/video/pvrusb2/pvrusb2-io.c           |   16 ++
 drivers/media/video/pvrusb2/pvrusb2-io.h           |   13 --
 drivers/media/video/pvrusb2/pvrusb2-ioread.c       |    6 
 drivers/media/video/pvrusb2/pvrusb2-ioread.h       |    1 
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c         |   16 +-
 11 files changed, 94 insertions(+), 120 deletions(-)

--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-debugifc.c.old	2006-06-29 14:10:28.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-debugifc.c	2006-06-29 14:10:40.000000000 +0200
@@ -337,8 +337,8 @@
 }
 
 
-int pvr2_debugifc_do1cmd(struct pvr2_hdw *hdw,const char *buf,
-			 unsigned int count)
+static int pvr2_debugifc_do1cmd(struct pvr2_hdw *hdw,const char *buf,
+				unsigned int count)
 {
 	const char *wptr;
 	unsigned int wlen;
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-hdw.h.old	2006-06-29 14:11:04.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-hdw.h	2006-06-29 14:31:19.000000000 +0200
@@ -91,7 +91,6 @@
 void pvr2_hdw_poll(struct pvr2_hdw *);
 
 /* Trigger a poll to take place later at a convenient time */
-void pvr2_hdw_poll_trigger(struct pvr2_hdw *);
 void pvr2_hdw_poll_trigger_unlocked(struct pvr2_hdw *);
 
 /* Register a callback used to trigger a future poll */
@@ -99,9 +98,6 @@
 				 void (*func)(void *),
 				 void *data);
 
-/* Get pointer to structure given unit number */
-struct pvr2_hdw *pvr2_hdw_find(int unit_number);
-
 /* Destroy hardware interaction structure */
 void pvr2_hdw_destroy(struct pvr2_hdw *);
 
@@ -180,12 +176,6 @@
 void pvr2_hdw_subsys_bit_chg(struct pvr2_hdw *hdw,
 			     unsigned long msk,unsigned long val);
 
-/* Shortcut for pvr2_hdw_subsys_bit_chg(hdw,msk,msk) */
-void pvr2_hdw_subsys_bit_set(struct pvr2_hdw *hdw,unsigned long msk);
-
-/* Shortcut for pvr2_hdw_subsys_bit_chg(hdw,msk,0) */
-void pvr2_hdw_subsys_bit_clr(struct pvr2_hdw *hdw,unsigned long msk);
-
 /* Retrieve mask indicating which pieces of hardware are currently enabled
    / configured. */
 unsigned long pvr2_hdw_subsys_get(struct pvr2_hdw *);
@@ -225,34 +215,18 @@
 /* The following entry points are all lower level things you normally don't
    want to worry about. */
 
-/* Attempt to recover from a USB foul-up (in practice I find that if you
-   have to do this, then it's already too late). */
-void pvr2_reset_ctl_endpoints(struct pvr2_hdw *hdw);
-
 /* Issue a command and get a response from the device.  LOTS of higher
    level stuff is built on this. */
 int pvr2_send_request(struct pvr2_hdw *,
 		      void *write_ptr,unsigned int write_len,
 		      void *read_ptr,unsigned int read_len);
 
-/* Issue a command and get a response from the device.  This extended
-   version includes a probe flag (which if set means that device errors
-   should not be logged or treated as fatal) and a timeout in jiffies.
-   This can be used to non-lethally probe the health of endpoint 1. */
-int pvr2_send_request_ex(struct pvr2_hdw *,unsigned int timeout,int probe_fl,
-			 void *write_ptr,unsigned int write_len,
-			 void *read_ptr,unsigned int read_len);
-
 /* Slightly higher level device communication functions. */
 int pvr2_write_register(struct pvr2_hdw *, u16, u32);
-int pvr2_read_register(struct pvr2_hdw *, u16, u32 *);
-int pvr2_write_u16(struct pvr2_hdw *, u16, int);
-int pvr2_write_u8(struct pvr2_hdw *, u8, int);
 
 /* Call if for any reason we can't talk to the hardware anymore - this will
    cause the driver to stop flailing on the device. */
 void pvr2_hdw_render_useless(struct pvr2_hdw *);
-void pvr2_hdw_render_useless_unlocked(struct pvr2_hdw *);
 
 /* Set / clear 8051's reset bit */
 void pvr2_hdw_cpureset_assert(struct pvr2_hdw *,int);
@@ -271,12 +245,6 @@
 /* Order decoder to reset */
 int pvr2_hdw_cmd_decoder_reset(struct pvr2_hdw *);
 
-/* Stop / start video stream transport */
-int pvr2_hdw_cmd_usbstream(struct pvr2_hdw *hdw,int runFl);
-
-/* Find I2C address of eeprom */
-int pvr2_hdw_get_eeprom_addr(struct pvr2_hdw *);
-
 /* Direct manipulation of GPIO bits */
 int pvr2_hdw_gpio_get_dir(struct pvr2_hdw *hdw,u32 *);
 int pvr2_hdw_gpio_get_out(struct pvr2_hdw *hdw,u32 *);
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h.old	2006-06-29 14:12:23.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h	2006-06-29 14:31:49.000000000 +0200
@@ -354,23 +354,6 @@
 	unsigned int control_cnt;
 };
 
-int pvr2_hdw_commit_ctl_internal(struct pvr2_hdw *hdw);
-
-unsigned int pvr2_hdw_get_signal_status_internal(struct pvr2_hdw *);
-
-void pvr2_hdw_subsys_bit_chg_no_lock(struct pvr2_hdw *hdw,
-				     unsigned long msk,unsigned long val);
-void pvr2_hdw_subsys_stream_bit_chg_no_lock(struct pvr2_hdw *hdw,
-					    unsigned long msk,
-					    unsigned long val);
-
-void pvr2_hdw_internal_find_stdenum(struct pvr2_hdw *hdw);
-void pvr2_hdw_internal_set_std_avail(struct pvr2_hdw *hdw);
-
-int pvr2_i2c_basic_op(struct pvr2_hdw *,u8 i2c_addr,
-		      u8 *wdata,u16 wlen,
-		      u8 *rdata,u16 rlen);
-
 #endif /* __PVRUSB2_HDW_INTERNAL_H */
 
 /*
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-hdw.c.old	2006-06-29 14:11:18.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-hdw.c	2006-06-29 14:48:27.000000000 +0200
@@ -90,7 +90,7 @@
 };
 
 static struct pvr2_hdw *unit_pointers[PVR_NUM] = {[ 0 ... PVR_NUM-1 ] = 0};
-DECLARE_MUTEX(pvr2_unit_sem);
+static DECLARE_MUTEX(pvr2_unit_sem);
 
 static int ctlchg = 0;
 static int initusbreset = 1;
@@ -263,6 +263,25 @@
 	[PVR2_SUBSYS_B_ENC_RUN] = "enc_run",
 };
 
+static int pvr2_hdw_cmd_usbstream(struct pvr2_hdw *hdw,int runFl);
+static int pvr2_hdw_commit_ctl_internal(struct pvr2_hdw *hdw);
+static int pvr2_hdw_get_eeprom_addr(struct pvr2_hdw *hdw);
+static unsigned int pvr2_hdw_get_signal_status_internal(struct pvr2_hdw *hdw);
+static void pvr2_hdw_internal_find_stdenum(struct pvr2_hdw *hdw);
+static void pvr2_hdw_internal_set_std_avail(struct pvr2_hdw *hdw);
+static void pvr2_hdw_render_useless_unlocked(struct pvr2_hdw *hdw);
+static void pvr2_hdw_subsys_bit_chg_no_lock(struct pvr2_hdw *hdw,
+					    unsigned long msk,
+					    unsigned long val);
+static void pvr2_hdw_subsys_stream_bit_chg_no_lock(struct pvr2_hdw *hdw,
+						   unsigned long msk,
+						   unsigned long val);
+static int pvr2_send_request_ex(struct pvr2_hdw *hdw,
+				unsigned int timeout,int probe_fl,
+				void *write_data,unsigned int write_len,
+				void *read_data,unsigned int read_len);
+static int pvr2_write_u16(struct pvr2_hdw *hdw, u16 data, int res);
+static int pvr2_write_u8(struct pvr2_hdw *hdw, u8 data, int res);
 
 static int ctrl_channelfreq_get(struct pvr2_ctrl *cptr,int *vp)
 {
@@ -835,14 +854,14 @@
 	return hdw->serial_number;
 }
 
-
+#if 0
 struct pvr2_hdw *pvr2_hdw_find(int unit_number)
 {
 	if (unit_number < 0) return 0;
 	if (unit_number >= PVR_NUM) return 0;
 	return unit_pointers[unit_number];
 }
-
+#endif  /*  0  */
 
 int pvr2_hdw_get_unit_number(struct pvr2_hdw *hdw)
 {
@@ -917,7 +936,7 @@
  * is not suitable for an usb transaction.
  *
  */
-int pvr2_upload_firmware1(struct pvr2_hdw *hdw)
+static int pvr2_upload_firmware1(struct pvr2_hdw *hdw)
 {
 	const struct firmware *fw_entry = 0;
 	void  *fw_ptr;
@@ -1166,8 +1185,9 @@
   reconfigure and start over.
 
 */
-void pvr2_hdw_subsys_bit_chg_no_lock(struct pvr2_hdw *hdw,
-				     unsigned long msk,unsigned long val)
+static void pvr2_hdw_subsys_bit_chg_no_lock(struct pvr2_hdw *hdw,
+					    unsigned long msk,
+					    unsigned long val)
 {
 	unsigned long nmsk;
 	unsigned long vmsk;
@@ -1317,6 +1337,7 @@
 	} while (0); LOCK_GIVE(hdw->big_lock);
 }
 
+#if 0
 
 void pvr2_hdw_subsys_bit_set(struct pvr2_hdw *hdw,unsigned long msk)
 {
@@ -1329,6 +1350,7 @@
 	pvr2_hdw_subsys_bit_chg(hdw,msk,0);
 }
 
+#endif  /*  0  */
 
 unsigned long pvr2_hdw_subsys_get(struct pvr2_hdw *hdw)
 {
@@ -1342,9 +1364,9 @@
 }
 
 
-void pvr2_hdw_subsys_stream_bit_chg_no_lock(struct pvr2_hdw *hdw,
-					    unsigned long msk,
-					    unsigned long val)
+static void pvr2_hdw_subsys_stream_bit_chg_no_lock(struct pvr2_hdw *hdw,
+						   unsigned long msk,
+						   unsigned long val)
 {
 	unsigned long val2;
 	msk &= PVR2_SUBSYS_ALL;
@@ -1366,7 +1388,7 @@
 }
 
 
-int pvr2_hdw_set_streaming_no_lock(struct pvr2_hdw *hdw,int enableFl)
+static int pvr2_hdw_set_streaming_no_lock(struct pvr2_hdw *hdw,int enableFl)
 {
 	if ((!enableFl) == !(hdw->flag_streaming_enabled)) return 0;
 	if (enableFl) {
@@ -1400,8 +1422,8 @@
 }
 
 
-int pvr2_hdw_set_stream_type_no_lock(struct pvr2_hdw *hdw,
-				     enum pvr2_config config)
+static int pvr2_hdw_set_stream_type_no_lock(struct pvr2_hdw *hdw,
+					    enum pvr2_config config)
 {
 	unsigned long sm = hdw->subsys_enabled_mask;
 	if (!hdw->flag_ok) return -EIO;
@@ -1928,7 +1950,7 @@
 
 /* Remove _all_ associations between this driver and the underlying USB
    layer. */
-void pvr2_hdw_remove_usb_stuff(struct pvr2_hdw *hdw)
+static void pvr2_hdw_remove_usb_stuff(struct pvr2_hdw *hdw)
 {
 	if (hdw->flag_disconnected) return;
 	pvr2_trace(PVR2_TRACE_INIT,"pvr2_hdw_remove_usb_stuff: hdw=%p",hdw);
@@ -2018,7 +2040,7 @@
 
 // Attempt to autoselect an appropriate value for std_enum_cur given
 // whatever is currently in std_mask_cur
-void pvr2_hdw_internal_find_stdenum(struct pvr2_hdw *hdw)
+static void pvr2_hdw_internal_find_stdenum(struct pvr2_hdw *hdw)
 {
 	unsigned int idx;
 	for (idx = 1; idx < hdw->std_enum_cnt; idx++) {
@@ -2033,7 +2055,7 @@
 
 // Calculate correct set of enumerated standards based on currently known
 // set of available standards bits.
-void pvr2_hdw_internal_set_std_avail(struct pvr2_hdw *hdw)
+static void pvr2_hdw_internal_set_std_avail(struct pvr2_hdw *hdw)
 {
 	struct v4l2_standard *newstd;
 	unsigned int std_cnt;
@@ -2182,7 +2204,7 @@
    state(s) back to their previous value before this function was called.
    Thus we can automatically reconfigure affected pieces of the driver as
    controls are changed. */
-int pvr2_hdw_commit_ctl_internal(struct pvr2_hdw *hdw)
+static int pvr2_hdw_commit_ctl_internal(struct pvr2_hdw *hdw)
 {
 	unsigned long saved_subsys_mask = hdw->subsys_enabled_mask;
 	unsigned long stale_subsys_mask = 0;
@@ -2320,14 +2342,14 @@
 	}
 }
 
-
+#if 0
 void pvr2_hdw_poll_trigger(struct pvr2_hdw *hdw)
 {
 	LOCK_TAKE(hdw->big_lock); do {
 		pvr2_hdw_poll_trigger_unlocked(hdw);
 	} while (0); LOCK_GIVE(hdw->big_lock);
 }
-
+#endif  /*  0  */
 
 /* Return name for this driver instance */
 const char *pvr2_hdw_get_driver_name(struct pvr2_hdw *hdw)
@@ -2337,7 +2359,7 @@
 
 
 /* Return bit mask indicating signal status */
-unsigned int pvr2_hdw_get_signal_status_internal(struct pvr2_hdw *hdw)
+static unsigned int pvr2_hdw_get_signal_status_internal(struct pvr2_hdw *hdw)
 {
 	unsigned int msk = 0;
 	switch (hdw->input_val) {
@@ -2518,7 +2540,7 @@
 	hdw->v4l_minor_number = v;
 }
 
-
+#if 0
 void pvr2_reset_ctl_endpoints(struct pvr2_hdw *hdw)
 {
 	if (!hdw->usb_dev) return;
@@ -2533,7 +2555,7 @@
 		       usb_sndbulkpipe(hdw->usb_dev,
 				       PVR2_CTL_WRITE_ENDPOINT & 0x7f));
 }
-
+#endif  /*  0  */
 
 static void pvr2_ctl_write_complete(struct urb *urb, struct pt_regs *regs)
 {
@@ -2568,10 +2590,10 @@
 }
 
 
-int pvr2_send_request_ex(struct pvr2_hdw *hdw,
-			 unsigned int timeout,int probe_fl,
-			 void *write_data,unsigned int write_len,
-			 void *read_data,unsigned int read_len)
+static int pvr2_send_request_ex(struct pvr2_hdw *hdw,
+				unsigned int timeout,int probe_fl,
+				void *write_data,unsigned int write_len,
+				void *read_data,unsigned int read_len)
 {
 	unsigned int idx;
 	int status = 0;
@@ -2826,7 +2848,7 @@
 }
 
 
-int pvr2_read_register(struct pvr2_hdw *hdw, u16 reg, u32 *data)
+static int pvr2_read_register(struct pvr2_hdw *hdw, u16 reg, u32 *data)
 {
 	int ret = 0;
 
@@ -2850,7 +2872,7 @@
 }
 
 
-int pvr2_write_u16(struct pvr2_hdw *hdw, u16 data, int res)
+static int pvr2_write_u16(struct pvr2_hdw *hdw, u16 data, int res)
 {
 	int ret;
 
@@ -2867,7 +2889,7 @@
 }
 
 
-int pvr2_write_u8(struct pvr2_hdw *hdw, u8 data, int res)
+static int pvr2_write_u8(struct pvr2_hdw *hdw, u8 data, int res)
 {
 	int ret;
 
@@ -2883,7 +2905,7 @@
 }
 
 
-void pvr2_hdw_render_useless_unlocked(struct pvr2_hdw *hdw)
+static void pvr2_hdw_render_useless_unlocked(struct pvr2_hdw *hdw)
 {
 	if (!hdw->flag_ok) return;
 	pvr2_trace(PVR2_TRACE_INIT,"render_useless");
@@ -2996,7 +3018,7 @@
 }
 
 
-int pvr2_hdw_cmd_usbstream(struct pvr2_hdw *hdw,int runFl)
+static int pvr2_hdw_cmd_usbstream(struct pvr2_hdw *hdw,int runFl)
 {
 	int status;
 	LOCK_TAKE(hdw->ctl_lock); do {
@@ -3094,7 +3116,7 @@
 }
 
 
-int pvr2_hdw_get_eeprom_addr(struct pvr2_hdw *hdw)
+static int pvr2_hdw_get_eeprom_addr(struct pvr2_hdw *hdw)
 {
 	int result;
 	LOCK_TAKE(hdw->ctl_lock); do {
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-i2c-core.h.old	2006-06-29 14:32:44.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-i2c-core.h	2006-06-29 14:33:00.000000000 +0200
@@ -75,9 +75,6 @@
 	PVR2_I2C_DETAIL_DEBUG |\
 	PVR2_I2C_DETAIL_HANDLER |\
 	PVR2_I2C_DETAIL_CTLMASK)
-unsigned int pvr2_i2c_client_describe(struct pvr2_i2c_client *,
-				      unsigned int detail_mask,
-				      char *buf,unsigned int maxlen);
 
 void pvr2_i2c_probe(struct pvr2_hdw *,struct pvr2_i2c_client *);
 const struct pvr2_i2c_op *pvr2_i2c_get_op(unsigned int idx);
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-i2c-core.c.old	2006-06-29 14:31:59.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-i2c-core.c	2006-06-29 14:47:52.000000000 +0200
@@ -37,6 +37,10 @@
 module_param(i2c_scan, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(i2c_scan,"scan i2c bus at insmod time");
 
+static unsigned int pvr2_i2c_client_describe(struct pvr2_i2c_client *cp,
+					     unsigned int detail,
+					     char *buf,unsigned int maxlen);
+
 static int pvr2_i2c_write(struct pvr2_hdw *hdw, /* Context */
 			  u8 i2c_addr,      /* I2C address we're talking to */
 			  u8 *data,         /* Data to write */
@@ -165,12 +169,12 @@
 
 /* This is the common low level entry point for doing I2C operations to the
    hardware. */
-int pvr2_i2c_basic_op(struct pvr2_hdw *hdw,
-		      u8 i2c_addr,
-		      u8 *wdata,
-		      u16 wlen,
-		      u8 *rdata,
-		      u16 rlen)
+static int pvr2_i2c_basic_op(struct pvr2_hdw *hdw,
+			     u8 i2c_addr,
+			     u8 *wdata,
+			     u16 wlen,
+			     u8 *rdata,
+			     u16 rlen)
 {
 	if (!rdata) rlen = 0;
 	if (!wdata) wlen = 0;
@@ -705,9 +709,9 @@
 	return (hdw->i2c_pend_types & PVR2_I2C_PEND_ALL) != 0;
 }
 
-unsigned int pvr2_i2c_client_describe(struct pvr2_i2c_client *cp,
-				      unsigned int detail,
-				      char *buf,unsigned int maxlen)
+static unsigned int pvr2_i2c_client_describe(struct pvr2_i2c_client *cp,
+					     unsigned int detail,
+					     char *buf,unsigned int maxlen)
 {
 	unsigned int ccnt,bcnt;
 	int spcfl = 0;
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-io.h.old	2006-06-29 14:34:27.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-io.h	2006-06-29 14:38:04.000000000 +0200
@@ -36,8 +36,6 @@
 struct pvr2_stream;
 struct pvr2_buffer;
 
-const char *pvr2_buffer_state_decode(enum pvr2_buffer_state);
-
 /* Initialize / tear down stream structure */
 struct pvr2_stream *pvr2_stream_create(void);
 void pvr2_stream_destroy(struct pvr2_stream *);
@@ -49,7 +47,6 @@
 			      void *data);
 
 /* Query / set the nominal buffer count */
-int pvr2_stream_get_buffer_count(struct pvr2_stream *);
 int pvr2_stream_set_buffer_count(struct pvr2_stream *,unsigned int);
 
 /* Get a pointer to a buffer that is either idle, ready, or is specified
@@ -59,12 +56,8 @@
 struct pvr2_buffer *pvr2_stream_get_buffer(struct pvr2_stream *sp,int id);
 
 /* Find out how many buffers are idle or ready */
-int pvr2_stream_get_idle_count(struct pvr2_stream *);
 int pvr2_stream_get_ready_count(struct pvr2_stream *);
 
-/* Kill all pending operations */
-void pvr2_stream_flush(struct pvr2_stream *);
-
 /* Kill all pending buffers and throw away any ready buffers as well */
 void pvr2_stream_kill(struct pvr2_stream *);
 
@@ -77,18 +70,12 @@
 /* Retrieve completion code for given ready buffer */
 int pvr2_buffer_get_status(struct pvr2_buffer *);
 
-/* Retrieve state of given buffer */
-enum pvr2_buffer_state pvr2_buffer_get_state(struct pvr2_buffer *);
-
 /* Retrieve ID of given buffer */
 int pvr2_buffer_get_id(struct pvr2_buffer *);
 
 /* Start reading into given buffer (kill it if needed) */
 int pvr2_buffer_queue(struct pvr2_buffer *);
 
-/* Move buffer back to idle pool (kill it if needed) */
-int pvr2_buffer_idle(struct pvr2_buffer *);
-
 #endif /* __PVRUSB2_IO_H */
 
 /*
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-io.c.old	2006-06-29 14:33:52.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-io.c	2006-06-29 14:49:05.000000000 +0200
@@ -93,7 +93,7 @@
 	struct urb *purb;
 };
 
-const char *pvr2_buffer_state_decode(enum pvr2_buffer_state st)
+static const char *pvr2_buffer_state_decode(enum pvr2_buffer_state st)
 {
 	switch (st) {
 	case pvr2_buffer_state_none: return "none";
@@ -104,7 +104,8 @@
 	return "unknown";
 }
 
-void pvr2_buffer_describe(struct pvr2_buffer *bp,const char *msg)
+#ifdef SANITY_CHECK_BUFFERS
+static void pvr2_buffer_describe(struct pvr2_buffer *bp,const char *msg)
 {
 	pvr2_trace(PVR2_TRACE_INFO,
 		   "buffer%s%s %p state=%s id=%d status=%d"
@@ -119,6 +120,7 @@
 		   (bp ? bp->purb : 0),
 		   (bp ? bp->signature : 0));
 }
+#endif  /*  SANITY_CHECK_BUFFERS  */
 
 static void pvr2_buffer_remove(struct pvr2_buffer *bp)
 {
@@ -513,10 +515,12 @@
 }
 
 /* Query / set the nominal buffer count */
+#if 0
 int pvr2_stream_get_buffer_count(struct pvr2_stream *sp)
 {
 	return sp->buffer_target_count;
 }
+#endif  /*  0  */
 
 int pvr2_stream_set_buffer_count(struct pvr2_stream *sp,unsigned int cnt)
 {
@@ -555,6 +559,8 @@
 	return sp->r_count;
 }
 
+#if 0
+
 int pvr2_stream_get_idle_count(struct pvr2_stream *sp)
 {
 	return sp->i_count;
@@ -567,6 +573,8 @@
 	} while(0); mutex_unlock(&sp->mutex);
 }
 
+#endif  /*  0  */
+
 void pvr2_stream_kill(struct pvr2_stream *sp)
 {
 	struct pvr2_buffer *bp;
@@ -620,6 +628,7 @@
 	return ret;
 }
 
+#if 0
 int pvr2_buffer_idle(struct pvr2_buffer *bp)
 {
 	struct pvr2_stream *sp;
@@ -634,6 +643,7 @@
 	} while(0); mutex_unlock(&sp->mutex);
 	return 0;
 }
+#endif  /*  0  */
 
 int pvr2_buffer_set_buffer(struct pvr2_buffer *bp,void *ptr,unsigned int cnt)
 {
@@ -673,10 +683,12 @@
 	return bp->status;
 }
 
+#if 0
 enum pvr2_buffer_state pvr2_buffer_get_state(struct pvr2_buffer *bp)
 {
 	return bp->state;
 }
+#endif  /*  0  */
 
 int pvr2_buffer_get_id(struct pvr2_buffer *bp)
 {
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-ioread.h.old	2006-06-29 14:40:31.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-ioread.h	2006-06-29 14:40:37.000000000 +0200
@@ -33,7 +33,6 @@
 			      const char *sync_key_ptr,
 			      unsigned int sync_key_len);
 int pvr2_ioread_set_enabled(struct pvr2_ioread *,int fl);
-int pvr2_ioread_get_enabled(struct pvr2_ioread *);
 int pvr2_ioread_read(struct pvr2_ioread *,void __user *buf,unsigned int cnt);
 int pvr2_ioread_avail(struct pvr2_ioread *);
 
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-ioread.c.old	2006-06-29 14:38:59.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-ioread.c	2006-06-29 14:40:06.000000000 +0200
@@ -251,12 +251,14 @@
 	return ret;
 }
 
+#if 0
 int pvr2_ioread_get_enabled(struct pvr2_ioread *cp)
 {
 	return cp->enabled != 0;
 }
+#endif  /*  0  */
 
-int pvr2_ioread_get_buffer(struct pvr2_ioread *cp)
+static int pvr2_ioread_get_buffer(struct pvr2_ioread *cp)
 {
 	int stat;
 
@@ -307,7 +309,7 @@
 	return !0;
 }
 
-void pvr2_ioread_filter(struct pvr2_ioread *cp)
+static void pvr2_ioread_filter(struct pvr2_ioread *cp)
 {
 	unsigned int idx;
 	if (!cp->enabled) return;
--- linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-v4l2.c.old	2006-06-29 14:41:39.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/media/video/pvrusb2/pvrusb2-v4l2.c	2006-06-29 14:45:38.000000000 +0200
@@ -81,7 +81,7 @@
 module_param_array(video_nr, int, NULL, 0444);
 MODULE_PARM_DESC(video_nr, "Offset for device's minor");
 
-struct v4l2_capability pvr_capability ={
+static struct v4l2_capability pvr_capability ={
 	.driver         = "pvrusb2",
 	.card           = "Hauppauge WinTV pvr-usb2",
 	.bus_info       = "usb",
@@ -111,7 +111,7 @@
 	}
 };
 
-struct v4l2_fmtdesc pvr_fmtdesc [] = {
+static struct v4l2_fmtdesc pvr_fmtdesc [] = {
 	{
 		.index          = 0,
 		.type           = V4L2_BUF_TYPE_VIDEO_CAPTURE,
@@ -127,7 +127,7 @@
 #define PVR_FORMAT_PIX  0
 #define PVR_FORMAT_VBI  1
 
-struct v4l2_format pvr_format [] = {
+static struct v4l2_format pvr_format [] = {
 	[PVR_FORMAT_PIX] = {
 		.type   = V4L2_BUF_TYPE_VIDEO_CAPTURE,
 		.fmt    = {
@@ -725,7 +725,7 @@
 }
 
 
-void pvr2_v4l2_internal_check(struct pvr2_channel *chp)
+static void pvr2_v4l2_internal_check(struct pvr2_channel *chp)
 {
 	struct pvr2_v4l2 *vp;
 	vp = container_of(chp,struct pvr2_v4l2,channel);
@@ -735,8 +735,8 @@
 }
 
 
-int pvr2_v4l2_ioctl(struct inode *inode, struct file *file,
-		    unsigned int cmd, unsigned long arg)
+static int pvr2_v4l2_ioctl(struct inode *inode, struct file *file,
+			   unsigned int cmd, unsigned long arg)
 {
 
 /* Temporary hack : use ivtv api until a v4l2 one is available. */
@@ -747,7 +747,7 @@
 }
 
 
-int pvr2_v4l2_release(struct inode *inode, struct file *file)
+static int pvr2_v4l2_release(struct inode *inode, struct file *file)
 {
 	struct pvr2_v4l2_fh *fhp = file->private_data;
 	struct pvr2_v4l2 *vp = fhp->vhead;
@@ -794,7 +794,7 @@
 }
 
 
-int pvr2_v4l2_open(struct inode *inode, struct file *file)
+static int pvr2_v4l2_open(struct inode *inode, struct file *file)
 {
 	struct pvr2_v4l2_dev *dip = 0; /* Our own context pointer */
 	struct pvr2_v4l2_fh *fhp;

