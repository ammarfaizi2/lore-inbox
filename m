Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261727AbSI2S3G>; Sun, 29 Sep 2002 14:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261729AbSI2S3F>; Sun, 29 Sep 2002 14:29:05 -0400
Received: from gate.perex.cz ([194.212.165.105]:8720 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261727AbSI2S2d>;
	Sun, 29 Sep 2002 14:28:33 -0400
Date: Sun, 29 Sep 2002 20:33:24 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [4/10] - 2002/07/14
Message-ID: <Pine.LNX.4.33.0209292032350.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.605.2.15, 2002-09-25 16:23:23+02:00, perex@pnote.perex-int.cz
  ALSA update 2002/07/14:
    - seq_virmidi - exported snd_virmidi_receive() for processing the incoming events from the event handler of a remote virmidi port.
    - pcm_lib.c - fixed wrong spinlock
    - AC'97 code
      - added VIA codecs, fixed order
      - added S/PDIF support for Conexant CX20468
    - ALI5451 - fixed wrong spinlock
    - ES1968 - fixed wrong mutex
    - ICE1712 - fixed SMP dead-lock
    - HDSP driver update
    - RME9652 - fixed wrong spinlock


 include/sound/info.h                     |    4 -
 include/sound/seq_virmidi.h              |    8 +-
 include/sound/version.h                  |    2 
 sound/core/pcm_lib.c                     |    2 
 sound/core/seq/seq_virmidi.c             |   34 ++++++++---
 sound/pci/ac97/ac97_codec.c              |   13 ++--
 sound/pci/ali5451/ali5451.c              |    4 +
 sound/pci/es1968.c                       |    4 +
 sound/pci/ice1712.c                      |   10 ++-
 sound/pci/rme9652/digiface_firmware.dat  |    2 
 sound/pci/rme9652/hdsp.c                 |   91 ++++++++++++++++++++-----------
 sound/pci/rme9652/multiface_firmware.dat |    2 
 sound/pci/rme9652/rme9652.c              |    1 
 13 files changed, 117 insertions(+), 60 deletions(-)


diff -Nru a/include/sound/info.h b/include/sound/info.h
--- a/include/sound/info.h	Sun Sep 29 20:20:47 2002
+++ b/include/sound/info.h	Sun Sep 29 20:20:47 2002
@@ -151,8 +151,8 @@
 
 static inline int snd_info_get_line(snd_info_buffer_t * buffer, char *line, int len) { return 0; }
 static inline char *snd_info_get_str(char *dest, char *src, int len) { return NULL; }
-static inline snd_info_entry_t *snd_info_create_module_entry(struct module * module, const char *name, snd_info_entry_t *parent) { return NULL; }
-static inline snd_info_entry_t *snd_info_create_card_entry(snd_card_t * card, const char *name, snd_info_entry_t *parent) { return NULL; }
+static inline snd_info_entry_t *snd_info_create_module_entry(struct module * module, const char *name, snd_info_entry_t * parent) { return NULL; }
+static inline snd_info_entry_t *snd_info_create_card_entry(snd_card_t * card, const char *name, snd_info_entry_t * parent) { return NULL; }
 static inline void snd_info_free_entry(snd_info_entry_t * entry) { ; }
 static inline snd_info_entry_t *snd_info_create_device(const char *name,
 						       unsigned int number,
diff -Nru a/include/sound/seq_virmidi.h b/include/sound/seq_virmidi.h
--- a/include/sound/seq_virmidi.h	Sun Sep 29 20:20:47 2002
+++ b/include/sound/seq_virmidi.h	Sun Sep 29 20:20:47 2002
@@ -45,7 +45,7 @@
 	snd_rawmidi_substream_t *substream;
 } snd_virmidi_t;
 
-#define SNDRV_VIRMIDI_SUBSCRIBE	(1<<0)
+#define SNDRV_VIRMIDI_SUBSCRIBE		(1<<0)
 #define SNDRV_VIRMIDI_USE		(1<<1)
 
 /*
@@ -69,14 +69,16 @@
  * ATTACH = input/output events from midi device are routed to the
  *          attached sequencer port.  sequencer port is not created
  *          by virmidi itself.
+ *          the input to rawmidi must be processed by passing the
+ *          incoming events via snd_virmidi_receive()
  * DISPATCH = input/output events are routed to subscribers.
  *            sequencer port is created in virmidi.
  */
 #define SNDRV_VIRMIDI_SEQ_NONE		0
-#define SNDRV_VIRMIDI_SEQ_ATTACH		1
+#define SNDRV_VIRMIDI_SEQ_ATTACH	1
 #define SNDRV_VIRMIDI_SEQ_DISPATCH	2
 
 int snd_virmidi_new(snd_card_t *card, int device, snd_rawmidi_t **rrmidi);
+int snd_virmidi_receive(snd_rawmidi_t *rmidi, snd_seq_event_t *ev);
 
 #endif /* __SOUND_SEQ_VIRMIDI */
-
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Sun Sep 29 20:20:47 2002
+++ b/include/sound/version.h	Sun Sep 29 20:20:47 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Wed Jul 03 16:51:35 2002 UTC)"
+#define CONFIG_SND_DATE " (Sun Jul 14 21:30:57 2002 UTC)"
diff -Nru a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
--- a/sound/core/pcm_lib.c	Sun Sep 29 20:20:47 2002
+++ b/sound/core/pcm_lib.c	Sun Sep 29 20:20:47 2002
@@ -1899,7 +1899,7 @@
 			frames = cont;
 		if (frames == 0 && runtime->status->state == SNDRV_PCM_STATE_PAUSED) {
 			err = -EPIPE;
-			goto _end;
+			goto _end_unlock;
 		}
 		snd_assert(frames != 0,
 			   spin_unlock_irq(&runtime->lock);
diff -Nru a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
--- a/sound/core/seq/seq_virmidi.c	Sun Sep 29 20:20:47 2002
+++ b/sound/core/seq/seq_virmidi.c	Sun Sep 29 20:20:47 2002
@@ -89,11 +89,6 @@
 	unsigned char msg[4];
 	int len;
 
-	snd_assert(rdev != NULL, return -EINVAL);
-
-	if (!(rdev->flags & SNDRV_VIRMIDI_USE))
-		return 0; /* ignored */
-
 	read_lock(&rdev->filelist_lock);
 	list_for_each(list, &rdev->filelist) {
 		vmidi = list_entry(list, snd_virmidi_t, list);
@@ -115,14 +110,32 @@
 }
 
 /*
- * event_input callback from sequencer
+ * receive an event from the remote virmidi port
+ *
+ * for rawmidi inputs, you can call this function from the event
+ * handler of a remote port which is attached to the virmidi via
+ * SNDRV_VIRMIDI_SEQ_ATTACH.
+ */
+/* exported */
+int snd_virmidi_receive(snd_rawmidi_t *rmidi, snd_seq_event_t *ev)
+{
+	snd_virmidi_dev_t *rdev;
+
+	rdev = snd_magic_cast(snd_virmidi_dev_t, rmidi->private_data, return -EINVAL);
+	return snd_virmidi_dev_receive_event(rdev, ev);
+}
+
+/*
+ * event handler of virmidi port
  */
-int snd_virmidi_receive(snd_seq_event_t *ev, int direct,
-			void *private_data, int atomic, int hop)
+static int snd_virmidi_event_input(snd_seq_event_t *ev, int direct,
+				   void *private_data, int atomic, int hop)
 {
 	snd_virmidi_dev_t *rdev;
 
 	rdev = snd_magic_cast(snd_virmidi_dev_t, private_data, return -EINVAL);
+	if (!(rdev->flags & SNDRV_VIRMIDI_USE))
+		return 0; /* ignored */
 	return snd_virmidi_dev_receive_event(rdev, ev);
 }
 
@@ -387,7 +400,7 @@
 	pcallbacks.unsubscribe = snd_virmidi_unsubscribe;
 	pcallbacks.use = snd_virmidi_use;
 	pcallbacks.unuse = snd_virmidi_unuse;
-	pcallbacks.event_input = snd_virmidi_receive;
+	pcallbacks.event_input = snd_virmidi_event_input;
 	pinfo.kernel = &pcallbacks;
 	err = snd_seq_kernel_client_ctl(client, SNDRV_SEQ_IOCTL_CREATE_PORT, &pinfo);
 	if (err < 0) {
@@ -470,7 +483,9 @@
 
 /*
  * create a new device
+ *
  */
+/* exported */
 int snd_virmidi_new(snd_card_t *card, int device, snd_rawmidi_t **rrmidi)
 {
 	snd_rawmidi_t *rmidi;
@@ -525,3 +540,4 @@
 module_exit(alsa_virmidi_exit)
 
 EXPORT_SYMBOL(snd_virmidi_new);
+EXPORT_SYMBOL(snd_virmidi_receive);
diff -Nru a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c	Sun Sep 29 20:20:47 2002
+++ b/sound/pci/ac97/ac97_codec.c	Sun Sep 29 20:20:47 2002
@@ -79,17 +79,19 @@
 { 0x414c4300, 0xffffff00, "Realtek",		NULL },
 { 0x414c4700, 0xffffff00, "Avance Logic",	NULL },
 { 0x43525900, 0xffffff00, "Cirrus Logic",	NULL },
+{ 0x43585400, 0xffffff00, "Conexant",           NULL },
+{ 0x45838300, 0xffffff00, "ESS Technology",	NULL },
 { 0x48525300, 0xffffff00, "Intersil",		NULL },
 { 0x49434500, 0xffffff00, "ICEnsemble",		NULL },
 { 0x4e534300, 0xffffff00, "National Semiconductor", NULL },
 { 0x53494c00, 0xffffff00, "Silicon Laboratory",	NULL },
 { 0x54524100, 0xffffff00, "TriTech",		NULL },
 { 0x54584e00, 0xffffff00, "Texas Instruments",	NULL },
+{ 0x56494100, 0xffffff00, "VIA Technologies",   NULL },
 { 0x57454300, 0xffffff00, "Winbond",		NULL },
 { 0x574d4c00, 0xffffff00, "Wolfson",		NULL },
 { 0x594d4800, 0xffffff00, "Yamaha",		NULL },
 { 0x83847600, 0xffffff00, "SigmaTel",		NULL },
-{ 0x45838300, 0xffffff00, "ESS Technology",	NULL },
 { 0,	      0, 	  NULL,			NULL }
 };
 
@@ -115,12 +117,14 @@
 { 0x414c4750, 0xfffffff0, "ALC250",		NULL },
 { 0x43525900, 0xfffffff8, "CS4297",		NULL },
 { 0x43525910, 0xfffffff8, "CS4297A",		patch_cirrus_spdif },
-{ 0x42525920, 0xfffffff8, "CS4294/4298",	NULL },
-{ 0x42525928, 0xfffffff8, "CS4294",		NULL },
+{ 0x43525920, 0xfffffff8, "CS4294/4298",	NULL },
+{ 0x43525928, 0xfffffff8, "CS4294",		NULL },
 { 0x43525930, 0xfffffff8, "CS4299",		patch_cirrus_cs4299 },
 { 0x43525948, 0xfffffff8, "CS4201",		NULL },
 { 0x43525958, 0xfffffff8, "CS4205",		patch_cirrus_spdif },
 { 0x43525960, 0xfffffff8, "CS4291",		NULL },
+{ 0x43585429, 0xffffffff, "Cx20468",		patch_conexant },
+{ 0x45838308, 0xffffffff, "ESS1988",		NULL },
 { 0x48525300, 0xffffff00, "HMP9701",		NULL },
 { 0x49434501, 0xffffffff, "ICE1230",		NULL },
 { 0x49434511, 0xffffffff, "ICE1232",		NULL }, // alias VIA VT1611A?
@@ -131,6 +135,7 @@
 { 0x54524108, 0xffffffff, "TR28028",		patch_tritech_tr28028 }, // added by xin jin [07/09/99]
 { 0x54524123, 0xffffffff, "TR28602",		NULL }, // only guess --jk [TR28023 = eMicro EM28023 (new CT1297)]
 { 0x54584e20, 0xffffffff, "TLC320AD9xC",	NULL },
+{ 0x56494161, 0xffffffff, "VIA1612A",		NULL }, // modified ICE1232 with S/PDIF
 { 0x57454301, 0xffffffff, "W83971D",		NULL },
 { 0x574d4c00, 0xffffffff, "WM9701A",		patch_wolfson00 },
 { 0x574d4c03, 0xffffffff, "WM9703/9707",	patch_wolfson03 },
@@ -143,8 +148,6 @@
 { 0x83847609, 0xffffffff, "STAC9721/23",	patch_sigmatel_stac9721 },
 { 0x83847644, 0xffffffff, "STAC9744",		patch_sigmatel_stac9744 },
 { 0x83847656, 0xffffffff, "STAC9756/57",	patch_sigmatel_stac9756 },
-{ 0x45838308, 0xffffffff, "ESS1988",		NULL },
-{ 0x43585429, 0xffffffff, "Cx20468",		patch_conexant },
 { 0, 	      0,	  NULL,			NULL }
 };
 
diff -Nru a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c	Sun Sep 29 20:20:47 2002
+++ b/sound/pci/ali5451/ali5451.c	Sun Sep 29 20:20:47 2002
@@ -1440,8 +1440,10 @@
 
 		unsigned int rate;
 		
-		if (codec->revision != ALI_5451_V02)
+		if (codec->revision != ALI_5451_V02) {
+			spin_unlock_irqrestore(&codec->reg_lock, flags);			
 			return -1;
+		}
 		rate = snd_ali_get_spdif_in_rate(codec);
 		if (rate == 0) {
 			snd_printk("ali_capture_preapre: spdif rate detect err!\n");
diff -Nru a/sound/pci/es1968.c b/sound/pci/es1968.c
--- a/sound/pci/es1968.c	Sun Sep 29 20:20:47 2002
+++ b/sound/pci/es1968.c	Sun Sep 29 20:20:47 2002
@@ -1446,8 +1446,10 @@
 __found:
 	if (buf->size > size) {
 		esm_memory_t *chunk = kmalloc(sizeof(*chunk), GFP_KERNEL);
-		if (chunk == NULL)
+		if (chunk == NULL) {
+			up(&chip->memory_mutex);
 			return NULL;
+		}
 		chunk->size = buf->size - size;
 		chunk->buf = buf->buf + size;
 		chunk->addr = buf->addr + size;
diff -Nru a/sound/pci/ice1712.c b/sound/pci/ice1712.c
--- a/sound/pci/ice1712.c	Sun Sep 29 20:20:47 2002
+++ b/sound/pci/ice1712.c	Sun Sep 29 20:20:47 2002
@@ -1142,6 +1142,8 @@
 {
 	unsigned char reg[2] = { 0x80 | 4, 0 };   /* CS8427 auto increment | register number 4 + data */
 	unsigned char val, nval;
+	int res = 0;
+	
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_sendbytes(ice->cs8427, reg, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
@@ -1159,13 +1161,13 @@
 	if (val != nval) {
 		reg[1] = nval;
 		if (snd_i2c_sendbytes(ice->cs8427, reg, 2) != 2) {
-			snd_i2c_unlock(ice->i2c);
-			return -EREMOTE;
+			res = -EREMOTE;
+		} else {
+			res++;
 		}
-		return 1;
 	}
 	snd_i2c_unlock(ice->i2c);
-	return 0;
+	return res;
 }
 
 /*
diff -Nru a/sound/pci/rme9652/digiface_firmware.dat b/sound/pci/rme9652/digiface_firmware.dat
--- a/sound/pci/rme9652/digiface_firmware.dat	Sun Sep 29 20:20:47 2002
+++ b/sound/pci/rme9652/digiface_firmware.dat	Sun Sep 29 20:20:47 2002
@@ -1,5 +1,5 @@
 /* stored in little-endian */
-static u32 digiface_firmware[97652] __devinitdata = {
+static u32 digiface_firmware[24413] __devinitdata = {
 0xffffffff, 0x66aa9955, 0x8001000c, 0xe0000000, 0x8006800c, 0xb0000000,
 0x8004800c, 0xb4fc0100, 0x8003000c, 0x00000000, 0x8001000c, 0x90000000,
 0x8004000c, 0x00000000, 0x8001000c, 0x80000000, 0x0002000c, 0x581a000a,
diff -Nru a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
--- a/sound/pci/rme9652/hdsp.c	Sun Sep 29 20:20:47 2002
+++ b/sound/pci/rme9652/hdsp.c	Sun Sep 29 20:20:47 2002
@@ -42,6 +42,8 @@
 static char *snd_id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int snd_enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
 static int snd_precise_ptr[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0 }; /* Enable precise pointer */
+static int snd_line_outs_monitor[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0}; /* Send all inputs/playback to line outs */
+static int snd_force_firmware[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0}; /* Force firmware reload */
 
 MODULE_PARM(snd_index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_index, "Index value for RME Hammerfall DSP interface.");
@@ -55,8 +57,14 @@
 MODULE_PARM(snd_precise_ptr, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_precise_ptr, "Enable precise pointer (doesn't work reliably).");
 MODULE_PARM_SYNTAX(snd_precise_ptr, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
+MODULE_PARM(snd_line_outs_monitor,"1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_line_outs_monitor, "Send all input and playback streams to line outs by default.");
+MODULE_PARM_SYNTAX(snd_line_outs_monitor, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
+MODULE_PARM(snd_force_firmware,"1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_force_firmware, "Force a reload of the I/O box firmware");
+MODULE_PARM_SYNTAX(snd_force_firmware, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
 MODULE_AUTHOR("Paul Davis <pbd@op.net>");
-MODULE_DESCRIPTION("RME Hammerfall DDSP");
+MODULE_DESCRIPTION("RME Hammerfall DSP");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
 MODULE_DEVICES("{{RME,Hammerfall-DSP},");
@@ -2190,6 +2198,25 @@
 	for (i = 0; i < 2048; i++)
 		hdsp_write_gain (hdsp, i, MINUS_INFINITY_GAIN);
 
+	if (snd_line_outs_monitor[hdsp->dev]) {
+		
+		snd_printk ("sending all inputs and playback streams to line outs.\n");
+
+		/* route all inputs to the line outs for easy monitoring. send
+		   odd numbered channels to right, even to left.
+		*/
+		
+		for (i = 0; i < HDSP_MAX_CHANNELS; i++) {
+			if (i & 1) { 
+				hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY (i, 26), UNITY_GAIN);
+				hdsp_write_gain (hdsp, PLAYBACK_TO_OUTPUT_KEY (i, 26), UNITY_GAIN);
+			} else {
+				hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY (i, 27), UNITY_GAIN);
+				hdsp_write_gain (hdsp, PLAYBACK_TO_OUTPUT_KEY (i, 27), UNITY_GAIN);
+			}
+		}
+	}
+
 	hdsp->passthru = 0;
 
 	/* set a default rate so that the channel map is set up.
@@ -2812,7 +2839,6 @@
 static int __devinit snd_hdsp_initialize_firmware (hdsp_t *hdsp)
 {
 	int i;
-	int status_reg;
 	u32 *firmware_ptr;
 
 	if (hdsp_check_for_iobox (hdsp)) {
@@ -2830,52 +2856,33 @@
 		hdsp_write (hdsp, HDSP_outputEnable + (4 * i), 1);
 	}
 
-	status_reg = hdsp_read (hdsp, HDSP_statusRegister);
+	if (snd_force_firmware[hdsp->dev] || (hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 
-	if ((status_reg & HDSP_DllError) == 0) {
-
-		/* i/o box is connected, firmware already loaded */
-
-		if (hdsp_read (hdsp, HDSP_status2Register) & HDSP_version1) {
-			hdsp->type = Multiface;
-			hdsp->card_name = "RME Hammerfall DSP (Multiface)";
-			hdsp->ss_channels = MULTIFACE_SS_CHANNELS;
-			hdsp->ds_channels = MULTIFACE_DS_CHANNELS;
-		} else {
-			hdsp->type = Digiface;
-			hdsp->card_name = "RME Hammerfall DSP (Digiface)";
-			hdsp->ss_channels = DIGIFACE_SS_CHANNELS;
-			hdsp->ds_channels = DIGIFACE_DS_CHANNELS;
-		}
-
-	} else {
+		snd_printk ("loading firmware\n");
 
-		/* firmware not loaded, but i/o box is connected */
-		
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
-		hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT);
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
+			snd_printk ("timeout waiting for firmware setup\n");
+			return -EIO;
+		}
 
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 
-		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
-			printk ("looks like a multiface\n");
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT)) {
 			hdsp->type = Multiface;
-			hdsp->card_name = "RME Hammerfall DSP (Multiface)";
 			hdsp_write (hdsp, HDSP_jtagReg, HDSP_VERSION_BIT);
 			hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
 			hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT);
 		} else {
-			printk ("looks like a digiface\n");
 			hdsp->type = Digiface;
-			hdsp->card_name = "RME Hammerfall DSP (Digiface)";
 		} 
 
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 		
-		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT) < 0) {
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("timeout waiting for download preparation\n");
 			return -EIO;
 		}
@@ -2883,9 +2890,9 @@
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
 		
 		if (hdsp->type == Digiface) {
-			firmware_ptr = digiface_firmware;
+			firmware_ptr = (u32 *) digiface_firmware;
 		} else {
-			firmware_ptr = multiface_firmware;
+			firmware_ptr = (u32 *) multiface_firmware;
 		}
 		
 		for (i = 0; i < 24413; ++i) {
@@ -2901,8 +2908,30 @@
 			return -EIO;
 		}
 
+	} else {
+
+		/* firmware already loaded, but we need to know what type
+		   of I/O box is connected.
+		*/
+
+		if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1) {
+			hdsp->type = Multiface;
+		} else {
+			hdsp->type = Digiface;
+		}
 	}
 
+	if (hdsp->type == Digiface) {
+		snd_printk ("I/O Box is a Digiface\n");
+		hdsp->card_name = "RME Hammerfall DSP (Digiface)";
+		hdsp->ss_channels = DIGIFACE_SS_CHANNELS;
+		hdsp->ds_channels = DIGIFACE_DS_CHANNELS;
+	} else {
+		snd_printk ("I/O Box is a Multiface\n");
+		hdsp->card_name = "RME Hammerfall DSP (Multiface)";
+		hdsp->ss_channels = MULTIFACE_SS_CHANNELS;
+		hdsp->ds_channels = MULTIFACE_DS_CHANNELS;
+	}
 	
 	snd_hdsp_flush_midi_input (hdsp, 0);
 	snd_hdsp_flush_midi_input (hdsp, 1);
diff -Nru a/sound/pci/rme9652/multiface_firmware.dat b/sound/pci/rme9652/multiface_firmware.dat
--- a/sound/pci/rme9652/multiface_firmware.dat	Sun Sep 29 20:20:47 2002
+++ b/sound/pci/rme9652/multiface_firmware.dat	Sun Sep 29 20:20:47 2002
@@ -1,5 +1,5 @@
 /* stored in little-endian */
-static u32 multiface_firmware[97652] __devinitdata = {
+static u32 multiface_firmware[24413] __devinitdata = {
 0xffffffff, 0x66aa9955, 0x8001000c, 0xe0000000, 0x8006800c, 0xb0000000,
 0x8004800c, 0xb4fc0100, 0x8003000c, 0x00000000, 0x8001000c, 0x90000000,
 0x8004000c, 0x00000000, 0x8001000c, 0x80000000, 0x0002000c, 0x581a000a,
diff -Nru a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
--- a/sound/pci/rme9652/rme9652.c	Sun Sep 29 20:20:47 2002
+++ b/sound/pci/rme9652/rme9652.c	Sun Sep 29 20:20:47 2002
@@ -523,6 +523,7 @@
 		rate = RME9652_DS | RME9652_freq;
 		break;
 	default:
+		spin_unlock_irq(&rme9652->lock);
 		return -EINVAL;
 	}
 

===================================================================


This BitKeeper patch contains the following changesets:
1.605.2.15
## Wrapped with gzip_uu ##


begin 664 bkpatch2374
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
6U+F+IN-7G/<9,[E;_']TVH^'GT0`````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

