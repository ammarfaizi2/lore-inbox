Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261735AbSI2Ssz>; Sun, 29 Sep 2002 14:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSI2Ssz>; Sun, 29 Sep 2002 14:48:55 -0400
Received: from gate.perex.cz ([194.212.165.105]:13328 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261735AbSI2Srr>;
	Sun, 29 Sep 2002 14:47:47 -0400
Date: Sun, 29 Sep 2002 20:52:25 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [7/10] - 2002/07/24
Message-ID: <Pine.LNX.4.33.0209292051260.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.605.2.18, 2002-09-26 11:08:55+02:00, perex@pnote.perex-int.cz
  ALSA update 2002/07/24 :
    - renamed snd-dt0197h to snd-dt019x
    - added support for DT0196, DT0197h and ALS007 to snd-dt019x
    - searial-u16550 - added support for generic adapter type
    - pcm.c
      - fixed the initialization of runtime->status
      - removed unnecessary check of n_register callback
    - timer.c
      - fixed kmod behaviour
    - Opti92x/93x fixes by Michael Corlett
    - fixed compilation of YMFPCI driver (PPC)


 b/Documentation/sound/alsa/serial-u16550.txt |    7 
 b/include/sound/sb.h                         |   19 +
 b/include/sound/version.h                    |    2 
 b/sound/core/Makefile                        |    2 
 b/sound/core/pcm.c                           |   11 
 b/sound/core/seq/Makefile                    |    2 
 b/sound/core/seq/instr/Makefile              |    2 
 b/sound/core/seq/seq.c                       |    2 
 b/sound/core/timer.c                         |   16 -
 b/sound/drivers/mpu401/Makefile              |    2 
 b/sound/drivers/opl3/Makefile                |    4 
 b/sound/drivers/serial-u16550.c              |  114 ++++++-
 b/sound/isa/Config.help                      |    6 
 b/sound/isa/Config.in                        |    2 
 b/sound/isa/Makefile                         |    4 
 b/sound/isa/dt019x.c                         |  407 +++++++++++++++++++++++++++
 b/sound/isa/opti9xx/opti92x-ad1848.c         |   51 +--
 b/sound/isa/sb/Makefile                      |    2 
 b/sound/isa/sb/sb16.c                        |    2 
 b/sound/isa/sb/sb_common.c                   |    3 
 b/sound/isa/sb/sb_mixer.c                    |  136 +++++++++
 b/sound/pci/via686.c                         |   10 
 b/sound/pci/ymfpci/ymfpci_main.c             |    1 
 sound/isa/dt0197h.c                          |  391 -------------------------
 24 files changed, 733 insertions(+), 465 deletions(-)


diff -Nru a/Documentation/sound/alsa/serial-u16550.txt b/Documentation/sound/alsa/serial-u16550.txt
--- a/Documentation/sound/alsa/serial-u16550.txt	Sun Sep 29 20:22:50 2002
+++ b/Documentation/sound/alsa/serial-u16550.txt	Sun Sep 29 20:22:50 2002
@@ -8,6 +8,7 @@
   1 - Midiator MS-124T support (1)
   2 - Midiator MS-124W S/A mode (2)
   3 - MS-124W M/B mode support (3)
+  4 - Generic device with multiple input support (4)
 
 For the Midiator MS-124W, you must set the physical M-S and A-B
 switches on the Midiator to match the driver mode you select.
@@ -82,3 +83,9 @@
 I do have documentation (tim.mann@compaq.com) that partially covers these models,
 but no units to experiment with.  The MS-124W support is tested with a real unit.
 The MS-124T support is untested, but should work.
+
+The Generic driver supports multiple input and output substreams over a single
+serial port.  Similar to Roland Soundcanvas mode, F5 NN is used to select the
+appropriate input or output stream (depending on the data direction).
+Additionally, the CTS signal is used to regulate the data flow.  The number of
+inputs is specified by the snd_ins parameter.
diff -Nru a/include/sound/sb.h b/include/sound/sb.h
--- a/include/sound/sb.h	Sun Sep 29 20:22:50 2002
+++ b/include/sound/sb.h	Sun Sep 29 20:22:50 2002
@@ -36,6 +36,7 @@
 	SB_HW_16CSP,		/* SB16 with CSP chip */
 	SB_HW_ALS100,		/* Avance Logic ALS100 chip */
 	SB_HW_ALS4000,		/* Avance Logic ALS4000 chip */
+	SB_HW_DT019X,		/* Diamond Tech. DT-019X / Avance Logic ALS-007 */
 };
 
 #define SB_OPEN_PCM		0x01
@@ -214,6 +215,24 @@
 #define SB_DSP4_MPUSETUP	0x84
 
 #define SB_DSP4_3DSE		0x90
+
+/* Registers for DT-019x / ALS-007 mixer */
+#define SB_DT019X_MASTER_DEV	0x62
+#define SB_DT019X_PCM_DEV	0x64
+#define SB_DT019X_SYNTH_DEV	0x66
+#define SB_DT019X_CD_DEV	0x68
+#define SB_DT019X_MIC_DEV	0x6a
+#define SB_DT019X_SPKR_DEV	0x6a
+#define SB_DT019X_LINE_DEV	0x6e
+#define SB_DT019X_OUTPUT_SW1	0x3c
+#define SB_DT019X_OUTPUT_SW2	0x4c
+#define SB_DT019X_CAPTURE_SW	0x6c
+
+#define SB_DT019X_CAP_CD	0x02
+#define SB_DT019X_CAP_MIC	0x04
+#define SB_DT019X_CAP_LINE	0x06
+#define SB_DT019X_CAP_SYNTH	0x07
+#define SB_DT019X_CAP_MAIN	0x07
 
 /* IRQ setting bitmap */
 #define SB_IRQSETUP_IRQ9	0x01
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Sun Sep 29 20:22:50 2002
+++ b/include/sound/version.h	Sun Sep 29 20:22:50 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Sat Jul 20 07:16:41 2002 UTC)"
+#define CONFIG_SND_DATE " (Wed Jul 24 10:42:45 2002 UTC)"
diff -Nru a/sound/core/Makefile b/sound/core/Makefile
--- a/sound/core/Makefile	Sun Sep 29 20:22:50 2002
+++ b/sound/core/Makefile	Sun Sep 29 20:22:50 2002
@@ -41,7 +41,7 @@
 obj-$(CONFIG_SND_ALS100) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_AZT2320) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_CMI8330) += snd-pcm.o snd-timer.o snd.o
-obj-$(CONFIG_SND_DT0197H) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_DT019X) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_ES18XX) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_SGALAXY) += snd-pcm.o snd-timer.o snd.o
diff -Nru a/sound/core/pcm.c b/sound/core/pcm.c
--- a/sound/core/pcm.c	Sun Sep 29 20:22:50 2002
+++ b/sound/core/pcm.c	Sun Sep 29 20:22:50 2002
@@ -753,16 +753,15 @@
 		kfree(runtime);
 		return -ENOMEM;
 	}
+	memset((void*)runtime->status, 0, size);
 
 	size = PAGE_ALIGN(sizeof(snd_pcm_mmap_control_t));
 	runtime->control = snd_malloc_pages(size, GFP_KERNEL);
 	if (runtime->control == NULL) {
-		kfree((void *)runtime->status);
+		snd_free_pages((void*)runtime->status, PAGE_ALIGN(sizeof(snd_pcm_mmap_status_t)));
 		kfree(runtime);
 		return -ENOMEM;
 	}
-
-	memset((void*)runtime->status, 0, size);
 	memset((void*)runtime->control, 0, size);
 
 	init_waitqueue_head(&runtime->sleep);
@@ -840,8 +839,7 @@
 	list_for_each(list, &snd_pcm_notify_list) {
 		snd_pcm_notify_t *notify;
 		notify = list_entry(list, snd_pcm_notify_t, list);
-		if (notify->n_register)
-			notify->n_register(-1 /* idx + SNDRV_MINOR_PCM */, pcm);
+		notify->n_register(-1 /* idx + SNDRV_MINOR_PCM */, pcm);
 	}
 	snd_pcm_lock(1);
 	return 0;
@@ -878,8 +876,7 @@
 	list_for_each(list, &snd_pcm_notify_list) {
 		snd_pcm_notify_t *notify;
 		notify = list_entry(list, snd_pcm_notify_t, list);
-		if (notify->n_unregister)
-			notify->n_unregister(-1 /* SNDRV_MINOR_PCM + idx */, pcm);
+		notify->n_unregister(-1 /* SNDRV_MINOR_PCM + idx */, pcm);
 	}
 	snd_pcm_devices[idx] = NULL;
 	snd_pcm_lock(1);
diff -Nru a/sound/core/seq/Makefile b/sound/core/seq/Makefile
--- a/sound/core/seq/Makefile	Sun Sep 29 20:22:50 2002
+++ b/sound/core/seq/Makefile	Sun Sep 29 20:22:50 2002
@@ -35,7 +35,7 @@
 obj-$(CONFIG_SND_MPU401) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_ALS100) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
 obj-$(CONFIG_SND_AZT2320) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
-obj-$(CONFIG_SND_DT0197H) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
+obj-$(CONFIG_SND_DT019X) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
 obj-$(CONFIG_SND_ES18XX) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
 obj-$(CONFIG_SND_AD1816A) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
diff -Nru a/sound/core/seq/instr/Makefile b/sound/core/seq/instr/Makefile
--- a/sound/core/seq/instr/Makefile	Sun Sep 29 20:22:50 2002
+++ b/sound/core/seq/instr/Makefile	Sun Sep 29 20:22:50 2002
@@ -13,7 +13,7 @@
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ALS100) += snd-ainstr-fm.o
 obj-$(CONFIG_SND_AZT2320) += snd-ainstr-fm.o
-obj-$(CONFIG_SND_DT0197H) += snd-ainstr-fm.o
+obj-$(CONFIG_SND_DT019X) += snd-ainstr-fm.o
 obj-$(CONFIG_SND_ES18XX) += snd-ainstr-fm.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-ainstr-fm.o
 obj-$(CONFIG_SND_AD1816A) += snd-ainstr-fm.o
diff -Nru a/sound/core/seq/seq.c b/sound/core/seq/seq.c
--- a/sound/core/seq/seq.c	Sun Sep 29 20:22:50 2002
+++ b/sound/core/seq/seq.c	Sun Sep 29 20:22:50 2002
@@ -48,7 +48,7 @@
 MODULE_CLASSES("{sound}");
 MODULE_SUPPORTED_DEVICE("sound");
 
-MODULE_PARM(snd_seq_client_load, "i");
+MODULE_PARM(snd_seq_client_load, "1-64i");
 MODULE_PARM_DESC(snd_seq_client_load, "The numbers of global (system) clients to load through kmod.");
 MODULE_PARM(snd_seq_default_timer_class, "i");
 MODULE_PARM_DESC(snd_seq_default_timer_class, "The default timer class.");
diff -Nru a/sound/core/timer.c b/sound/core/timer.c
--- a/sound/core/timer.c	Sun Sep 29 20:22:50 2002
+++ b/sound/core/timer.c	Sun Sep 29 20:22:50 2002
@@ -35,13 +35,19 @@
 #include <linux/kerneld.h>
 #endif
 
-int snd_timer_limit = 1;
+#if !defined(CONFIG_SND_RTCTIMER) && !defined(CONFIG_SND_RTCTIMER_MODULE)
+#define DEFAULT_TIMER_LIMIT 1
+#else
+#define DEFAULT_TIMER_LIMIT 2
+#endif
+
+int snd_timer_limit = DEFAULT_TIMER_LIMIT;
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ALSA timer interface");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
 MODULE_PARM(snd_timer_limit, "i");
-MODULE_PARM_DESC(snd_timer_limit, "Maximum global timers in system. (1 by default)");
+MODULE_PARM_DESC(snd_timer_limit, "Maximum global timers in system.");
 
 typedef struct {
 	snd_timer_instance_t *timeri;
@@ -146,10 +152,14 @@
 	
 	switch (tid->dev_class) {
 	case SNDRV_TIMER_CLASS_GLOBAL:
+		if (tid->device >= snd_timer_limit)
+			return;
 		sprintf(str, "snd-timer-%i", tid->device);
 		break;
 	case SNDRV_TIMER_CLASS_CARD:
 	case SNDRV_TIMER_CLASS_PCM:
+		if (tid->card >= snd_ecards_limit)
+			return;
 		sprintf(str, "snd-card-%i", tid->card);
 		break;
 	default:
@@ -876,7 +886,7 @@
 		}
 		snd_iprintf(buffer, "%s :", timer->name);
 		if (timer->hw.resolution)
-			snd_iprintf(buffer, " %lu.%luus (%lu ticks)", timer->hw.resolution / 1000, timer->hw.resolution % 1000, timer->hw.ticks);
+			snd_iprintf(buffer, " %lu.%03luus (%lu ticks)", timer->hw.resolution / 1000, timer->hw.resolution % 1000, timer->hw.ticks);
 		if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 			snd_iprintf(buffer, " SLAVE");
 		snd_iprintf(buffer, "\n");
diff -Nru a/sound/drivers/mpu401/Makefile b/sound/drivers/mpu401/Makefile
--- a/sound/drivers/mpu401/Makefile	Sun Sep 29 20:22:50 2002
+++ b/sound/drivers/mpu401/Makefile	Sun Sep 29 20:22:50 2002
@@ -12,7 +12,7 @@
 obj-$(CONFIG_SND_MPU401) += snd-mpu401.o snd-mpu401-uart.o
 obj-$(CONFIG_SND_ALS100) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_AZT2320) += snd-mpu401-uart.o
-obj-$(CONFIG_SND_DT0197H) += snd-mpu401-uart.o
+obj-$(CONFIG_SND_DT019X) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_ES18XX) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_AD1816A) += snd-mpu401-uart.o
diff -Nru a/sound/drivers/opl3/Makefile b/sound/drivers/opl3/Makefile
--- a/sound/drivers/opl3/Makefile	Sun Sep 29 20:22:50 2002
+++ b/sound/drivers/opl3/Makefile	Sun Sep 29 20:22:50 2002
@@ -16,7 +16,7 @@
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ALS100) += snd-opl3-lib.o
 obj-$(CONFIG_SND_AZT2320) += snd-opl3-lib.o
-obj-$(CONFIG_SND_DT0197H) += snd-opl3-lib.o
+obj-$(CONFIG_SND_DT019X) += snd-opl3-lib.o
 obj-$(CONFIG_SND_ES18XX) += snd-opl3-lib.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-opl3-lib.o
 obj-$(CONFIG_SND_AD1816A) += snd-opl3-lib.o
@@ -41,7 +41,7 @@
 ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
   obj-$(CONFIG_SND_ALS100) += snd-opl3-synth.o
   obj-$(CONFIG_SND_AZT2320) += snd-opl3-synth.o
-  obj-$(CONFIG_SND_DT0197H) += snd-opl3-synth.o
+  obj-$(CONFIG_SND_DT019X) += snd-opl3-synth.o
   obj-$(CONFIG_SND_ES18XX) += snd-opl3-synth.o
   obj-$(CONFIG_SND_OPL3SA2) += snd-opl3-synth.o
   obj-$(CONFIG_SND_AD1816A) += snd-opl3-synth.o
diff -Nru a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
--- a/sound/drivers/serial-u16550.c	Sun Sep 29 20:22:50 2002
+++ b/sound/drivers/serial-u16550.c	Sun Sep 29 20:22:50 2002
@@ -51,12 +51,14 @@
 #define SNDRV_SERIAL_MS124T 1      /* Midiator MS-124T */
 #define SNDRV_SERIAL_MS124W_SA 2   /* Midiator MS-124W in S/A mode */
 #define SNDRV_SERIAL_MS124W_MB 3   /* Midiator MS-124W in M/B mode */
-#define SNDRV_SERIAL_MAX_ADAPTOR SNDRV_SERIAL_MS124W_MB
+#define SNDRV_SERIAL_GENERIC 4     /* Generic Interface */
+#define SNDRV_SERIAL_MAX_ADAPTOR SNDRV_SERIAL_GENERIC
 static char *adaptor_names[] = {
 	"Soundcanvas",
         "MS-124T",
 	"MS-124W S/A",
-	"MS-124W M/B"
+	"MS-124W M/B",
+	"Generic"
 };
 
 static int snd_index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
@@ -67,6 +69,7 @@
 static int snd_speed[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 38400}; /* 9600,19200,38400,57600,115200 */
 static int snd_base[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 115200}; /* baud base */
 static int snd_outs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};	 /* 1 to 16 */
+static int snd_ins[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};	/* 1 to 16 */
 static int snd_adaptor[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = SNDRV_SERIAL_SOUNDCANVAS};
 
 MODULE_PARM(snd_index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
@@ -92,17 +95,21 @@
 MODULE_PARM_SYNTAX(snd_base, SNDRV_ENABLED ",allows:{57600,115200,230400,460800},dialog:list");
 MODULE_PARM(snd_outs, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_outs, "Number of MIDI outputs.");
+MODULE_PARM(snd_ins, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_ins, "Number of MIDI inputs.");
 
 MODULE_PARM_SYNTAX(snd_outs, SNDRV_ENABLED ",allows:{{1,16}},dialog:list");
+MODULE_PARM_SYNTAX(snd_ins, SNDRV_ENABLED ",allows:{{1,16}},dialog:list");
 MODULE_PARM(snd_adaptor, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_adaptor, "Type of adaptor.");
-MODULE_PARM_SYNTAX(snd_adaptor, SNDRV_ENABLED ",allows:{{0=Soundcanvas,1=MS-124T,2=MS-124W S/A,3=MS-124W M/B}},dialog:list");
+MODULE_PARM_SYNTAX(snd_adaptor, SNDRV_ENABLED ",allows:{{0=Soundcanvas,1=MS-124T,2=MS-124W S/A,3=MS-124W M/B,4=Generic}},dialog:list");
 
 /*#define SNDRV_SERIAL_MS124W_MB_NOCOMBO 1*/  /* Address outs as 0-3 instead of bitmap */
 
 #define SNDRV_SERIAL_MAX_OUTS	16		/* max 64, min 16 */
+#define SNDRV_SERIAL_MAX_INS	16		/* max 64, min 16 */
 
-#define TX_BUFF_SIZE		(1<<9)		/* Must be 2^n */
+#define TX_BUFF_SIZE		(1<<15)		/* Must be 2^n */
 #define TX_BUFF_MASK		(TX_BUFF_SIZE - 1)
 
 #define SERIAL_MODE_NOT_OPENED 		(0)
@@ -115,7 +122,7 @@
 	snd_card_t *card;
 	snd_rawmidi_t *rmidi;
 	snd_rawmidi_substream_t *midi_output[SNDRV_SERIAL_MAX_OUTS];
-	snd_rawmidi_substream_t *midi_input;
+	snd_rawmidi_substream_t *midi_input[SNDRV_SERIAL_MAX_INS];
 
 	int filemode;		//open status of file
 
@@ -141,6 +148,10 @@
 	// type of adaptor
 	int adaptor;
 
+	// inputs
+	int prev_in;
+	unsigned char rstatus;
+
 	// outputs
 	int prev_out;
 	unsigned char prev_status[SNDRV_SERIAL_MAX_OUTS];
@@ -196,26 +207,52 @@
 static void snd_uart16550_io_loop(snd_uart16550_t * uart)
 {
 	unsigned char c, status;
+	int substream;
+
+	/* recall previous stream */
+	substream = uart->prev_in;
 
 	/* Read Loop */
 	while ((status = inb(uart->base + UART_LSR)) & UART_LSR_DR) {
 		/* while receive data ready */
 		c = inb(uart->base + UART_RX);
-		if (uart->filemode & SERIAL_MODE_INPUT_OPEN) {
-			snd_rawmidi_receive(uart->midi_input, &c, 1);
+
+		/* keep track of last status byte */
+		if (c & 0x80) {
+			uart->rstatus = c;
+		}
+
+		/* handle stream switch */
+		if (uart->adaptor == SNDRV_SERIAL_GENERIC) {
+			if (uart->rstatus == 0xf5) {
+				if (c <= SNDRV_SERIAL_MAX_INS && c > 0)
+					substream = c - 1;
+				if (c != 0xf5)
+					uart->rstatus = 0; /* prevent future bytes from being interpreted as streams */
+			}
+			else if ((uart->filemode & SERIAL_MODE_INPUT_OPEN) && (uart->midi_input[substream] != NULL)) {
+				snd_rawmidi_receive(uart->midi_input[substream], &c, 1);
+		}
+		} else if ((uart->filemode & SERIAL_MODE_INPUT_OPEN) && (uart->midi_input[substream] != NULL)) {
+			snd_rawmidi_receive(uart->midi_input[substream], &c, 1);
 		}
+
 		if (status & UART_LSR_OE)
 			snd_printk("%s: Overrun on device at 0x%lx\n",
 			       uart->rmidi->name, uart->base);
 	}
 
+	/* remember the last stream */
+	uart->prev_in = substream;
+
 	/* no need of check SERIAL_MODE_OUTPUT_OPEN because if not,
 	   buffer is never filled. */
 	/* Check write status */
 	if (status & UART_LSR_THRE) {
 		uart->fifo_count = 0;
 	}
-	if (uart->adaptor == SNDRV_SERIAL_MS124W_SA) {
+	if (uart->adaptor == SNDRV_SERIAL_MS124W_SA
+	   || uart->adaptor == SNDRV_SERIAL_GENERIC) {
 		/* Can't use FIFO, must send only when CTS is true */
 		status = inb(uart->base + UART_MSR);
 		if (uart->fifo_count == 0 && (status & UART_MSR_CTS)
@@ -395,6 +432,11 @@
 		byte = UART_IER_RDI	/* Enable Receiver data interrupt */
 		    | UART_IER_MSI	/* Enable Modem status interrupt */
 		    ;
+	} else if (uart->adaptor == SNDRV_SERIAL_GENERIC) {
+		byte = UART_IER_RDI	/* Enable Receiver data interrupt */
+		    | UART_IER_MSI	/* Enable Modem status interrupt */
+		    | UART_IER_THRI	/* Enable Transmitter holding register empty interupt */
+		    ;
 	} else {
 		byte = UART_IER_RDI	/* Enable Receiver data interupt */
 		    | UART_IER_THRI	/* Enable Transmitter holding register empty interupt */
@@ -467,7 +509,7 @@
 	if (uart->filemode == SERIAL_MODE_NOT_OPENED)
 		snd_uart16550_do_open(uart);
 	uart->filemode |= SERIAL_MODE_INPUT_OPEN;
-	uart->midi_input = substream;
+	uart->midi_input[substream->number] = substream;
 	spin_unlock_irqrestore(&uart->open_lock, flags);
 	return 0;
 }
@@ -479,7 +521,7 @@
 
 	spin_lock_irqsave(&uart->open_lock, flags);
 	uart->filemode &= ~SERIAL_MODE_INPUT_OPEN;
-	uart->midi_input = NULL;
+	uart->midi_input[substream->number] = NULL;
 	if (uart->filemode == SERIAL_MODE_NOT_OPENED)
 		snd_uart16550_do_close(uart);
 	spin_unlock_irqrestore(&uart->open_lock, flags);
@@ -543,7 +585,8 @@
 static void snd_uart16550_output_byte(snd_uart16550_t *uart, snd_rawmidi_substream_t * substream, unsigned char midi_byte)
 {
 	if (uart->buff_in_count == 0                            /* Buffer empty? */
-	    && (uart->adaptor != SNDRV_SERIAL_MS124W_SA ||
+	    && ((uart->adaptor != SNDRV_SERIAL_MS124W_SA &&
+	    uart->adaptor != SNDRV_SERIAL_GENERIC) ||
 		(uart->fifo_count == 0                               /* FIFO empty? */
 		 && (inb(uart->base + UART_MSR) & UART_MSR_CTS)))) { /* CTS? */
 
@@ -577,6 +620,7 @@
 	unsigned char midi_byte, addr_byte;
 	snd_uart16550_t *uart = snd_magic_cast(snd_uart16550_t, substream->rmidi->private_data, return);
 	char first;
+	static unsigned long lasttime=0;
 	
 	/* Interupts are disabled during the updating of the tx_buff,
 	 * since it is 'bad' to have two processes updating the same
@@ -612,13 +656,17 @@
 	} else {
 		first = 0;
 		while (1) {
-			/* buffer full? */
-			if (uart->buff_in_count >= TX_BUFF_SIZE)
-				break;
 			if (snd_rawmidi_transmit(substream, &midi_byte, 1) != 1)
 				break;
-			if (first == 0 && uart->adaptor == SNDRV_SERIAL_SOUNDCANVAS &&
-			    uart->prev_out != substream->number) {
+			/* Also send F5 after 3 seconds with no data to handle device disconnect */
+			if (first == 0 && (uart->adaptor == SNDRV_SERIAL_SOUNDCANVAS ||
+				uart->adaptor == SNDRV_SERIAL_GENERIC) &&
+			   (uart->prev_out != substream->number || jiffies-lasttime > 3*HZ)) {
+
+				/* We will need three bytes of data here (worst case). */
+				if (uart->buff_in_count >= TX_BUFF_SIZE - 3)
+					break;
+
 				/* Roland Soundcanvas part selection */
 				/* If this substream of the data is different previous
 				   substream in this uart, send the change part event */
@@ -628,15 +676,21 @@
 				/* data */
 				snd_uart16550_output_byte(uart, substream, uart->prev_out + 1);
 				/* If midi_byte is a data byte, send the previous status byte */
-				if (midi_byte < 0x80)
+				if ((midi_byte < 0x80) && (uart->adaptor == SNDRV_SERIAL_SOUNDCANVAS))
 					snd_uart16550_output_byte(uart, substream, uart->prev_status[uart->prev_out]);
 			}
+
+			/* buffer full? */
+			if (uart->buff_in_count >= TX_BUFF_SIZE)
+				break;
+
 			/* send midi byte */
 			snd_uart16550_output_byte(uart, substream, midi_byte);
 			if (midi_byte >= 0x80 && midi_byte < 0xf0)
 				uart->prev_status[uart->prev_out] = midi_byte;
 			first = 1;
 		}
+		lasttime = jiffies;
 	}
 	spin_unlock_irqrestore(&uart->open_lock, flags);
 }
@@ -728,6 +782,8 @@
 	uart->speed = base / (unsigned int)uart->divisor;
 	uart->speed_base = base;
 	uart->prev_out = -1;
+	uart->prev_in = 0;
+	uart->rstatus = 0;
 	memset(uart->prev_status, 0x80, sizeof(unsigned char) * SNDRV_SERIAL_MAX_OUTS);
 	uart->buffer_timer.function = snd_uart16550_buffer_timer;
 	uart->buffer_timer.data = (unsigned long)uart;
@@ -761,12 +817,12 @@
 	return 0;
 }
 
-static int __init snd_uart16550_rmidi(snd_uart16550_t *uart, int device, int outs, snd_rawmidi_t **rmidi)
+static int __init snd_uart16550_rmidi(snd_uart16550_t *uart, int device, int outs, int ins, snd_rawmidi_t **rmidi)
 {
 	snd_rawmidi_t *rrawmidi;
 	int err;
 
-	if ((err = snd_rawmidi_new(uart->card, "UART Serial MIDI", device, outs, 1, &rrawmidi)) < 0)
+	if ((err = snd_rawmidi_new(uart->card, "UART Serial MIDI", device, outs, ins, &rrawmidi)) < 0)
 		return err;
 	snd_rawmidi_set_ops(rrawmidi, SNDRV_RAWMIDI_STREAM_INPUT, &snd_uart16550_input);
 	snd_rawmidi_set_ops(rrawmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_uart16550_output);
@@ -791,13 +847,18 @@
 
 	switch (snd_adaptor[dev]) {
 	case SNDRV_SERIAL_SOUNDCANVAS:
+		snd_ins[dev] = 1;
 		break;
 	case SNDRV_SERIAL_MS124T:
 	case SNDRV_SERIAL_MS124W_SA:
 		snd_outs[dev] = 1;
+		snd_ins[dev] = 1;
 		break;
 	case SNDRV_SERIAL_MS124W_MB:
 		snd_outs[dev] = 16;
+		snd_ins[dev] = 1;
+		break;
+	case SNDRV_SERIAL_GENERIC:
 		break;
 	default:
 		snd_printk("Adaptor type is out of range 0-%d (%d)\n",
@@ -811,6 +872,12 @@
 		return -ENODEV;
 	}
 
+	if (snd_ins[dev] < 1 || snd_ins[dev] > SNDRV_SERIAL_MAX_INS) {
+		snd_printk("Count of inputs is out of range 1-%d (%d)\n",
+			   SNDRV_SERIAL_MAX_INS, snd_ins[dev]);
+		return -ENODEV;
+	}
+
 	card  = snd_card_new(snd_index[dev], snd_id[dev], THIS_MODULE, 0);
 	if (card == NULL)
 		return -ENOMEM;
@@ -835,18 +902,19 @@
 		return err;
 	}
 
-	if ((err = snd_uart16550_rmidi(uart, 0, snd_outs[dev], &uart->rmidi)) < 0) {
+	if ((err = snd_uart16550_rmidi(uart, 0, snd_outs[dev], snd_ins[dev], &uart->rmidi)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
-	sprintf(card->longname, "%s at 0x%lx, irq %d speed %d div %d outs %d adaptor %s",
+	sprintf(card->longname, "%s at 0x%lx, irq %d speed %d div %d outs %d ins %d adaptor %s",
 		card->shortname,
 		uart->base,
 		uart->irq,
 		uart->speed,
 		(int)uart->divisor,
 		snd_outs[dev],
+		snd_ins[dev],
 		adaptor_names[uart->adaptor]);
 
 	if ((err = snd_card_register(card)) < 0) {
@@ -892,7 +960,8 @@
 #ifndef MODULE
 
 /* format is: snd-serial=snd_enable,snd_index,snd_id,
-			 snd_port,snd_irq,snd_speed,snd_base,snd_outs */
+			 snd_port,snd_irq,snd_speed,snd_base,snd_outs,
+ 			 snd_ins,snd_adaptor */
 
 static int __init alsa_card_serial_setup(char *str)
 {
@@ -908,6 +977,7 @@
 	       get_option(&str,&snd_speed[nr_dev]) == 2 &&
 	       get_option(&str,&snd_base[nr_dev]) == 2 &&
 	       get_option(&str,&snd_outs[nr_dev]) == 2 &&
+	       get_option(&str,&snd_ins[nr_dev]) == 2 &&
 	       get_option(&str,&snd_adaptor[nr_dev]) == 2);
 	nr_dev++;
 	return 1;
diff -Nru a/sound/isa/Config.help b/sound/isa/Config.help
--- a/sound/isa/Config.help	Sun Sep 29 20:22:50 2002
+++ b/sound/isa/Config.help	Sun Sep 29 20:22:50 2002
@@ -88,9 +88,9 @@
 CONFIG_SND_CMI8330
   Say 'Y' or 'M' to include support for C-Media CMI8330 based soundcards.
 
-CONFIG_SND_DT0197H
-  Say 'Y' or 'M' to include support for Diamond Technologies DT-0197H
-  soundcards.
+CONFIG_SND_DT019X
+  Say 'Y' or 'M' to include support for Diamond Technologies DT-019X and
+  Avance Logic ALS-007 soundcards.
 
 CONFIG_SND_OPL3SA2
   Say 'Y' or 'M' to include support for Yamaha OPL3SA2 or OPL3SA3 chips.
diff -Nru a/sound/isa/Config.in b/sound/isa/Config.in
--- a/sound/isa/Config.in	Sun Sep 29 20:22:50 2002
+++ b/sound/isa/Config.in	Sun Sep 29 20:22:50 2002
@@ -29,7 +29,7 @@
 dep_tristate 'Avance Logic ALS100/ALS120' CONFIG_SND_ALS100 $CONFIG_SND $CONFIG_ISAPNP
 dep_tristate 'Aztech Systems AZT2320' CONFIG_SND_AZT2320 $CONFIG_SND $CONFIG_ISAPNP
 dep_tristate 'C-Media CMI8330' CONFIG_SND_CMI8330 $CONFIG_SND
-dep_tristate 'Diamond Technologies DT-0197H' CONFIG_SND_DT0197H $CONFIG_SND $CONFIG_ISAPNP
+dep_tristate 'Diamond Technologies DT-019X, Avance Logic ALS-007' CONFIG_SND_DT019X $CONFIG_SND $CONFIG_ISAPNP
 dep_tristate 'Yamaha OPL3-SA2/SA3' CONFIG_SND_OPL3SA2 $CONFIG_SND
 dep_tristate 'Aztech Sound Galaxy' CONFIG_SND_SGALAXY $CONFIG_SND
 
diff -Nru a/sound/isa/Makefile b/sound/isa/Makefile
--- a/sound/isa/Makefile	Sun Sep 29 20:22:50 2002
+++ b/sound/isa/Makefile	Sun Sep 29 20:22:50 2002
@@ -6,7 +6,7 @@
 snd-als100-objs := als100.o
 snd-azt2320-objs := azt2320.o
 snd-cmi8330-objs := cmi8330.o
-snd-dt0197h-objs := dt0197h.o
+snd-dt019x-objs := dt019x.o
 snd-es18xx-objs := es18xx.o
 snd-opl3sa2-objs := opl3sa2.o
 snd-sgalaxy-objs := sgalaxy.o
@@ -15,7 +15,7 @@
 obj-$(CONFIG_SND_ALS100) += snd-als100.o
 obj-$(CONFIG_SND_AZT2320) += snd-azt2320.o
 obj-$(CONFIG_SND_CMI8330) += snd-cmi8330.o
-obj-$(CONFIG_SND_DT0197H) += snd-dt0197h.o
+obj-$(CONFIG_SND_DT019X) += snd-dt019x.o
 obj-$(CONFIG_SND_ES18XX) += snd-es18xx.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-opl3sa2.o
 obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy.o
diff -Nru a/sound/isa/dt0197h.c b/sound/isa/dt0197h.c
--- a/sound/isa/dt0197h.c	Sun Sep 29 20:22:50 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,391 +0,0 @@
-
-/*
-    card-dt0197h.c - driver for Diamond Technologies DT-0197H based soundcards.
-    Copyright (C) 1999 by Massimo Piccioni <dafastidio@libero.it>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
-*/
-
-#include <sound/driver.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
-#ifndef LINUX_ISAPNP_H
-#include <linux/isapnp.h>
-#define isapnp_card pci_bus
-#define isapnp_dev pci_dev
-#endif
-#include <sound/core.h>
-#define SNDRV_GET_ID
-#include <sound/initval.h>
-#include <sound/mpu401.h>
-#include <sound/opl3.h>
-#include <sound/sb.h>
-
-#define chip_t sb_t
-
-#define PFX "dt0197h: "
-
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
-MODULE_DESCRIPTION("Diamond Technologies DT-0197H");
-MODULE_LICENSE("GPL");
-MODULE_CLASSES("{sound}");
-MODULE_DEVICES("{{Diamond Technologies,DT-0197H}}");
-
-static int snd_index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
-static char *snd_id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-static int snd_enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
-static long snd_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
-static long snd_mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
-static long snd_fm_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
-static int snd_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* PnP setup */
-static int snd_mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* PnP setup */
-static int snd_dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* PnP setup */
-
-MODULE_PARM(snd_index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_index, "Index value for dt0197h based soundcard.");
-MODULE_PARM_SYNTAX(snd_index, SNDRV_INDEX_DESC);
-MODULE_PARM(snd_id, "1-" __MODULE_STRING(SNDRV_CARDS) "s");
-MODULE_PARM_DESC(snd_id, "ID string for dt0197h based soundcard.");
-MODULE_PARM_SYNTAX(snd_id, SNDRV_ID_DESC);
-MODULE_PARM(snd_enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_enable, "Enable dt0197h based soundcard.");
-MODULE_PARM_SYNTAX(snd_enable, SNDRV_ENABLE_DESC);
-MODULE_PARM(snd_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
-MODULE_PARM_DESC(snd_port, "Port # for dt0197h driver.");
-MODULE_PARM_SYNTAX(snd_port, SNDRV_PORT12_DESC);
-MODULE_PARM(snd_mpu_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
-MODULE_PARM_DESC(snd_mpu_port, "MPU-401 port # for dt0197h driver.");
-MODULE_PARM_SYNTAX(snd_mpu_port, SNDRV_PORT12_DESC);
-MODULE_PARM(snd_fm_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
-MODULE_PARM_DESC(snd_fm_port, "FM port # for dt0197h driver.");
-MODULE_PARM_SYNTAX(snd_fm_port, SNDRV_PORT12_DESC);
-MODULE_PARM(snd_irq, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_irq, "IRQ # for dt0197h driver.");
-MODULE_PARM_SYNTAX(snd_irq, SNDRV_IRQ_DESC);
-MODULE_PARM(snd_mpu_irq, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_mpu_irq, "MPU-401 IRQ # for dt0197h driver.");
-MODULE_PARM_SYNTAX(snd_mpu_irq, SNDRV_IRQ_DESC);
-MODULE_PARM(snd_dma8, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_dma8, "8-bit DMA # for dt0197h driver.");
-MODULE_PARM_SYNTAX(snd_dma8, SNDRV_DMA8_DESC);
-
-struct snd_card_dt0197h {
-#ifdef __ISAPNP__
-	struct isapnp_dev *dev;
-	struct isapnp_dev *devmpu;
-	struct isapnp_dev *devopl;
-#endif	/* __ISAPNP__ */
-};
-
-static snd_card_t *snd_dt0197h_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-#ifdef __ISAPNP__
-static struct isapnp_card *snd_dt0197h_isapnp_cards[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-static const struct isapnp_card_id *snd_dt0197h_isapnp_id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
-
-static struct isapnp_card_id snd_dt0197h_pnpids[] __devinitdata = {
-	/* DT197A30 */
-	{
-		ISAPNP_CARD_ID('R','W','B',0x1688),
-		devs: { ISAPNP_DEVICE_ID('@','@','@',0x0001),
-			ISAPNP_DEVICE_ID('@','X','@',0x0001),
-			ISAPNP_DEVICE_ID('@','H','@',0x0001) }
-	},
-	{ ISAPNP_CARD_END, }
-};
-
-ISAPNP_CARD_TABLE(snd_dt0197h_pnpids);
-
-#endif	/* __ISAPNP__ */
-
-#define DRIVER_NAME	"snd-card-dt0197h"
-
-
-#ifdef __ISAPNP__
-static int __init snd_card_dt0197h_isapnp(int dev, struct snd_card_dt0197h *acard)
-{
-	const struct isapnp_card_id *id = snd_dt0197h_isapnp_id[dev];
-	struct isapnp_card *card = snd_dt0197h_isapnp_cards[dev];
-	struct isapnp_dev *pdev;
-
-	acard->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
-	if (acard->dev->active) {
-		acard->dev = NULL;
-		return -EBUSY;
-	}
-	acard->devmpu = isapnp_find_dev(card, id->devs[1].vendor, id->devs[1].function, NULL);
-	if (acard->devmpu->active) {
-		acard->dev = acard->devmpu = NULL;
-		return -EBUSY;
-	}
-	acard->devopl = isapnp_find_dev(card, id->devs[2].vendor, id->devs[2].function, NULL);
-	if (acard->devopl->active) {
-		acard->dev = acard->devmpu = acard->devopl = NULL;
-		return -EBUSY;
-	}
-
-	pdev = acard->dev;
-	if (pdev->prepare(pdev)<0)
-		return -EAGAIN;
-
-	if (snd_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], snd_port[dev], 16);
-	if (snd_dma8[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[0], snd_dma8[dev],
-			1);
-	if (snd_irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], snd_irq[dev], 1);
-
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "AUDIO isapnp configure failure\n");
-		return -EBUSY;
-	}
-
-	snd_port[dev] = pdev->resource[0].start;
-	snd_dma8[dev] = pdev->dma_resource[0].start;
-	snd_irq[dev] = pdev->irq_resource[0].start;
-
-	pdev = acard->devmpu;
-	if (pdev || pdev->prepare(pdev)<0)
-		return 0;
-
-	if (snd_mpu_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], snd_mpu_port[dev],
-			2);
-	if (snd_mpu_irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], snd_mpu_irq[dev],
-			1);
-
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "MPU-401 isapnp configure failure\n");
-		snd_mpu_port[dev] = -1;
-		acard->devmpu = NULL;
-	} else {
-		snd_mpu_port[dev] = pdev->resource[0].start;
-		snd_mpu_irq[dev] = pdev->irq_resource[0].start;
-	}
-
-	pdev = acard->devopl;
-	if (pdev == NULL || pdev->prepare(pdev)<0)
-		return 0;
-
-	if (snd_fm_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], snd_fm_port[dev], 4);
-
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "OPL isapnp configure failure\n");
-		snd_fm_port[dev] = -1;
-		acard->devopl = NULL;
-	} else {
-		snd_fm_port[dev] = pdev->resource[0].start;
-	}
-
-	return 0;
-}
-
-static void snd_card_dt0197h_deactivate(struct snd_card_dt0197h *acard)
-{
-	if (acard->dev) {
-		acard->dev->deactivate(acard->dev);
-		acard->dev = NULL;
-	}
-	if (acard->devmpu) {
-		acard->devmpu->deactivate(acard->devmpu);
-		acard->devmpu = NULL;
-	}
-	if (acard->devopl) {
-		acard->devopl->deactivate(acard->devopl);
-		acard->devopl = NULL;
-	}
-}
-#endif	/* __ISAPNP__ */
-
-static void snd_card_dt0197h_free(snd_card_t *card)
-{
-	struct snd_card_dt0197h *acard = (struct snd_card_dt0197h *)card->private_data;
-
-	if (acard != NULL) {
-#ifdef __ISAPNP__
-		snd_card_dt0197h_deactivate(acard);
-#endif	/* __ISAPNP__ */
-	}
-}
-
-static int __init snd_card_dt0197h_probe(int dev)
-{
-	int error;
-	sb_t *chip;
-	snd_card_t *card;
-	struct snd_card_dt0197h *acard;
-	opl3_t *opl3;
-
-	if ((card = snd_card_new(snd_index[dev], snd_id[dev], THIS_MODULE,
-				 sizeof(struct snd_card_dt0197h))) == NULL)
-		return -ENOMEM;
-	acard = (struct snd_card_dt0197h *)card->private_data;
-	card->private_free = snd_card_dt0197h_free;
-
-#ifdef __ISAPNP__
-	if ((error = snd_card_dt0197h_isapnp(dev, acard))) {
-		snd_card_free(card);
-		return error;
-	}
-#else
-	printk(KERN_ERR PFX "you have to enable PnP support ...\n");
-	snd_card_free(card);
-	return -ENOSYS;
-#endif	/* __ISAPNP__ */
-
-	if ((error = snd_sbdsp_create(card, snd_port[dev],
-				      snd_irq[dev],
-				      snd_sb16dsp_interrupt,
-				      snd_dma8[dev],
-				      -1,
-				      SB_HW_AUTO,
-				      &chip)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-
-	if ((error = snd_sb16dsp_pcm(chip, 0, NULL)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-	if ((error = snd_sbmixer_new(chip)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-
-	if (snd_mpu_port[dev] > 0) {
-		if (snd_mpu401_uart_new(card, 0,
-					MPU401_HW_MPU401,
-					snd_mpu_port[dev], 0,
-					snd_mpu_irq[dev],
-					SA_INTERRUPT,
-					NULL) < 0)
-			printk(KERN_ERR PFX "no MPU-401 device at 0x%lx ?\n",
-				snd_mpu_port[dev]);
-	}
-
-	if (snd_fm_port[dev] > 0) {
-		if (snd_opl3_create(card,
-				    snd_fm_port[dev],
-				    snd_fm_port[dev] + 2,
-				    OPL3_HW_AUTO, 0, &opl3) < 0) {
-			printk(KERN_ERR PFX "no OPL device at 0x%lx-0x%lx ?\n",
-				snd_fm_port[dev], snd_fm_port[dev] + 2);
-		} else {
-			if ((error = snd_opl3_timer_new(opl3, 0, 1)) < 0) {
-				snd_card_free(card);
-				return error;
-			}
-			if ((error = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
-				snd_card_free(card);
-				return error;
-			}
-		}
-	}
-
-	strcpy(card->driver, "DT-0197H");
-	strcpy(card->shortname, "Diamond Tech. DT-0197H");
-	sprintf(card->longname, "%s soundcard, %s at 0x%lx, irq %d, dma %d",
-		card->shortname, chip->name, chip->port,
-		snd_irq[dev], snd_dma8[dev]);
-	if ((error = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-	snd_dt0197h_cards[dev] = card;
-	return 0;
-}
-
-#ifdef __ISAPNP__
-static int __init snd_dt0197h_isapnp_detect(struct isapnp_card *card,
-					    const struct isapnp_card_id *id)
-{
-	static int dev;
-	int res;
-
-	for ( ; dev < SNDRV_CARDS; dev++) {
-		if (!snd_enable[dev])
-			continue;
-		snd_dt0197h_isapnp_cards[dev] = card;
-		snd_dt0197h_isapnp_id[dev] = id;
-		res = snd_card_dt0197h_probe(dev);
-		if (res < 0)
-			return res;
-		dev++;
-		return 0;
-        }
-        return -ENODEV;
-}
-#endif /* __ISAPNP__ */
-
-static int __init alsa_card_dt0197h_init(void)
-{
-	int cards = 0;
-
-#ifdef __ISAPNP__
-	cards += isapnp_probe_cards(snd_dt0197h_pnpids, snd_dt0197h_isapnp_detect);
-#else
-	printk(KERN_ERR PFX "you have to enable ISA PnP support.\n");
-#endif
-#ifdef MODULE
-	if (!cards)
-		printk(KERN_ERR "no DT-0197H based soundcards found\n");
-#endif
-	return cards ? 0 : -ENODEV;
-}
-
-static void __exit alsa_card_dt0197h_exit(void)
-{
-	int dev;
-
-	for (dev = 0; dev < SNDRV_CARDS; dev++)
-		snd_card_free(snd_dt0197h_cards[dev]);
-}
-
-module_init(alsa_card_dt0197h_init)
-module_exit(alsa_card_dt0197h_exit)
-
-#ifndef MODULE
-
-/* format is: snd-dt0197h=snd_enable,snd_index,snd_id,snd_isapnp,
-			  snd_port,snd_mpu_port,snd_fm_port,
-			  snd_irq,snd_mpu_irq,snd_dma8,snd_dma8_size */
-
-static int __init alsa_card_dt0197h_setup(char *str)
-{
-	static unsigned __initdata nr_dev = 0;
-
-	if (nr_dev >= SNDRV_CARDS)
-		return 0;
-	(void)(get_option(&str,&snd_enable[nr_dev]) == 2 &&
-	       get_option(&str,&snd_index[nr_dev]) == 2 &&
-	       get_id(&str,&snd_id[nr_dev]) == 2 &&
-	       get_option(&str,(int *)&snd_port[nr_dev]) == 2 &&
-	       get_option(&str,(int *)&snd_mpu_port[nr_dev]) == 2 &&
-	       get_option(&str,(int *)&snd_fm_port[nr_dev]) == 2 &&
-	       get_option(&str,&snd_irq[nr_dev]) == 2 &&
-	       get_option(&str,&snd_mpu_irq[nr_dev]) == 2 &&
-	       get_option(&str,&snd_dma8[nr_dev]) == 2);
-	nr_dev++;
-	return 1;
-}
-
-__setup("snd-dt0197h=", alsa_card_dt0197h_setup);
-
-#endif /* ifndef MODULE */
diff -Nru a/sound/isa/dt019x.c b/sound/isa/dt019x.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/sound/isa/dt019x.c	Sun Sep 29 20:22:50 2002
@@ -0,0 +1,407 @@
+
+/*
+    dt019x.c - driver for Diamond Technologies DT-0197H based soundcards.
+    Copyright (C) 1999, 2002 by Massimo Piccioni <dafastidio@libero.it>
+
+    Generalised for soundcards based on DT-0196 and ALS-007 chips 
+    by Jonathan Woithe <jwoithe@physics.adelaide.edu.au>: June 2002.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+*/
+
+#include <sound/driver.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#ifndef LINUX_ISAPNP_H
+#include <linux/isapnp.h>
+#define isapnp_card pci_bus
+#define isapnp_dev pci_dev
+#endif
+#include <sound/core.h>
+#define SNDRV_GET_ID
+#include <sound/initval.h>
+#include <sound/mpu401.h>
+#include <sound/opl3.h>
+#include <sound/sb.h>
+
+#define chip_t sb_t
+
+#define PFX "dt019x: "
+
+MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
+MODULE_DESCRIPTION("Diamond Technologies DT-019X / Avance Logic ALS-007");
+MODULE_LICENSE("GPL");
+MODULE_CLASSES("{sound}");
+MODULE_DEVICES("{{Diamond Technologies DT-019X},"
+	       "{Avance Logic ALS-007}}");
+
+static int snd_index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
+static char *snd_id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
+static int snd_enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
+static long snd_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
+static long snd_mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
+static long snd_fm_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
+static int snd_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* PnP setup */
+static int snd_mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* PnP setup */
+static int snd_dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* PnP setup */
+
+MODULE_PARM(snd_index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_index, "Index value for DT-019X based soundcard.");
+MODULE_PARM_SYNTAX(snd_index, SNDRV_INDEX_DESC);
+MODULE_PARM(snd_id, "1-" __MODULE_STRING(SNDRV_CARDS) "s");
+MODULE_PARM_DESC(snd_id, "ID string for DT-019X based soundcard.");
+MODULE_PARM_SYNTAX(snd_id, SNDRV_ID_DESC);
+MODULE_PARM(snd_enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_enable, "Enable DT-019X based soundcard.");
+MODULE_PARM_SYNTAX(snd_enable, SNDRV_ENABLE_DESC);
+MODULE_PARM(snd_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
+MODULE_PARM_DESC(snd_port, "Port # for dt019x driver.");
+MODULE_PARM_SYNTAX(snd_port, SNDRV_PORT12_DESC);
+MODULE_PARM(snd_mpu_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
+MODULE_PARM_DESC(snd_mpu_port, "MPU-401 port # for dt019x driver.");
+MODULE_PARM_SYNTAX(snd_mpu_port, SNDRV_PORT12_DESC);
+MODULE_PARM(snd_fm_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
+MODULE_PARM_DESC(snd_fm_port, "FM port # for dt019x driver.");
+MODULE_PARM_SYNTAX(snd_fm_port, SNDRV_PORT12_DESC);
+MODULE_PARM(snd_irq, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_irq, "IRQ # for dt019x driver.");
+MODULE_PARM_SYNTAX(snd_irq, SNDRV_IRQ_DESC);
+MODULE_PARM(snd_mpu_irq, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_mpu_irq, "MPU-401 IRQ # for dt019x driver.");
+MODULE_PARM_SYNTAX(snd_mpu_irq, SNDRV_IRQ_DESC);
+MODULE_PARM(snd_dma8, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_dma8, "8-bit DMA # for dt019x driver.");
+MODULE_PARM_SYNTAX(snd_dma8, SNDRV_DMA8_DESC);
+
+struct snd_card_dt019x {
+#ifdef __ISAPNP__
+	struct isapnp_dev *dev;
+	struct isapnp_dev *devmpu;
+	struct isapnp_dev *devopl;
+#endif	/* __ISAPNP__ */
+};
+
+static snd_card_t *snd_dt019x_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
+
+#ifdef __ISAPNP__
+static struct isapnp_card *snd_dt019x_isapnp_cards[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
+static const struct isapnp_card_id *snd_dt019x_isapnp_id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PTR;
+
+static struct isapnp_card_id snd_dt019x_pnpids[] __devinitdata = {
+	/* DT197A30 */
+	{
+		ISAPNP_CARD_ID('R','W','B',0x1688),
+		devs: { ISAPNP_DEVICE_ID('@','@','@',0x0001),
+			ISAPNP_DEVICE_ID('@','X','@',0x0001),
+			ISAPNP_DEVICE_ID('@','H','@',0x0001) }
+	},
+	/* DT0196 / ALS-007 */
+	{
+		ISAPNP_CARD_ID('A','L','S',0x0007),
+		devs: { ISAPNP_DEVICE_ID('@','@','@',0x0001),
+			ISAPNP_DEVICE_ID('@','X','@',0x0001),
+			ISAPNP_DEVICE_ID('@','H','@',0x0001) }
+	},
+	{ ISAPNP_CARD_END, }
+};
+
+ISAPNP_CARD_TABLE(snd_dt019x_pnpids);
+
+#endif	/* __ISAPNP__ */
+
+#define DRIVER_NAME	"snd-card-dt019x"
+
+
+#ifdef __ISAPNP__
+static int __init snd_card_dt019x_isapnp(int dev, struct snd_card_dt019x *acard)
+{
+	const struct isapnp_card_id *id = snd_dt019x_isapnp_id[dev];
+	struct isapnp_card *card = snd_dt019x_isapnp_cards[dev];
+	struct isapnp_dev *pdev;
+
+	acard->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
+	if (acard->dev->active) {
+		acard->dev = NULL;
+		return -EBUSY;
+	}
+	acard->devmpu = isapnp_find_dev(card, id->devs[1].vendor, id->devs[1].function, NULL);
+	if (acard->devmpu->active) {
+		acard->dev = acard->devmpu = NULL;
+		return -EBUSY;
+	}
+	acard->devopl = isapnp_find_dev(card, id->devs[2].vendor, id->devs[2].function, NULL);
+	if (acard->devopl->active) {
+		acard->dev = acard->devmpu = acard->devopl = NULL;
+		return -EBUSY;
+	}
+
+	pdev = acard->dev;
+	if (!pdev || pdev->prepare(pdev)<0)
+		return -EAGAIN;
+
+	if (snd_port[dev] != SNDRV_AUTO_PORT)
+		isapnp_resource_change(&pdev->resource[0], snd_port[dev], 16);
+	if (snd_dma8[dev] != SNDRV_AUTO_DMA)
+		isapnp_resource_change(&pdev->dma_resource[0], snd_dma8[dev],
+			1);
+	if (snd_irq[dev] != SNDRV_AUTO_IRQ)
+		isapnp_resource_change(&pdev->irq_resource[0], snd_irq[dev], 1);
+
+	if (pdev->activate(pdev)<0) {
+		printk(KERN_ERR PFX "DT-019X AUDIO isapnp configure failure\n");
+		return -EBUSY;
+	}
+	snd_port[dev] = pdev->resource[0].start;
+	snd_dma8[dev] = pdev->dma_resource[0].start;
+	snd_irq[dev] = pdev->irq_resource[0].start;
+	snd_printdd("dt019x: found audio interface: port=0x%lx, irq=0x%lx, dma=0x%lx\n",
+			snd_port[dev],snd_irq[dev],smd_dma8[dev]);
+
+	pdev = acard->devmpu;
+	if (!pdev || pdev->prepare(pdev)<0) 
+		return 0;
+
+	if (snd_mpu_port[dev] != SNDRV_AUTO_PORT)
+		isapnp_resource_change(&pdev->resource[0], snd_mpu_port[dev],
+			2);
+	if (snd_mpu_irq[dev] != SNDRV_AUTO_IRQ)
+		isapnp_resource_change(&pdev->irq_resource[0], snd_mpu_irq[dev],
+			1);
+
+	if (pdev->activate(pdev)<0) {
+		printk(KERN_ERR PFX "DT-019X MPU-401 isapnp configure failure\n");
+		snd_mpu_port[dev] = -1;
+		acard->devmpu = NULL;
+	} else {
+		snd_mpu_port[dev] = pdev->resource[0].start;
+		snd_mpu_irq[dev] = pdev->irq_resource[0].start;
+		snd_printdd("dt019x: found MPU-401: port=0x%lx, irq=0x%lx\n",
+			 	snd_mpu_port[dev],snd_mpu_irq[dev]);
+	}
+
+	pdev = acard->devopl;
+	if (!pdev || pdev->prepare(pdev)<0)
+		return 0;
+
+	if (snd_fm_port[dev] != SNDRV_AUTO_PORT)
+		isapnp_resource_change(&pdev->resource[0], snd_fm_port[dev], 4);
+
+	if (pdev->activate(pdev)<0) {
+		printk(KERN_ERR PFX "DT-019X OPL3 isapnp configure failure\n");
+		snd_fm_port[dev] = -1;
+		acard->devopl = NULL;
+	} else {
+		snd_fm_port[dev] = pdev->resource[0].start;
+		snd_printdd("dt019x: found OPL3 synth: port=0x%lx\n",snd_fm_port[dev]);
+	}
+
+	return 0;
+}
+
+static void snd_card_dt019x_deactivate(struct snd_card_dt019x *acard)
+{
+	if (acard->dev) {
+		acard->dev->deactivate(acard->dev);
+		acard->dev = NULL;
+	}
+	if (acard->devmpu) {
+		acard->devmpu->deactivate(acard->devmpu);
+		acard->devmpu = NULL;
+	}
+	if (acard->devopl) {
+		acard->devopl->deactivate(acard->devopl);
+		acard->devopl = NULL;
+	}
+}
+#endif	/* __ISAPNP__ */
+
+static void snd_card_dt019x_free(snd_card_t *card)
+{
+	struct snd_card_dt019x *acard = (struct snd_card_dt019x *)card->private_data;
+
+	if (acard != NULL) {
+#ifdef __ISAPNP__
+		snd_card_dt019x_deactivate(acard);
+#endif	/* __ISAPNP__ */
+	}
+}
+
+static int __init snd_card_dt019x_probe(int dev)
+{
+	int error;
+	sb_t *chip;
+	snd_card_t *card;
+	struct snd_card_dt019x *acard;
+	opl3_t *opl3;
+
+	if ((card = snd_card_new(snd_index[dev], snd_id[dev], THIS_MODULE,
+				 sizeof(struct snd_card_dt019x))) == NULL)
+		return -ENOMEM;
+	acard = (struct snd_card_dt019x *)card->private_data;
+	card->private_free = snd_card_dt019x_free;
+
+#ifdef __ISAPNP__
+	if ((error = snd_card_dt019x_isapnp(dev, acard))) {
+		snd_card_free(card);
+		return error;
+	}
+#else
+	printk(KERN_ERR PFX "you have to enable PnP support ...\n");
+	snd_card_free(card);
+	return -ENOSYS;
+#endif	/* __ISAPNP__ */
+
+	if ((error = snd_sbdsp_create(card, snd_port[dev],
+				      snd_irq[dev],
+				      snd_sb16dsp_interrupt,
+				      snd_dma8[dev],
+				      -1,
+				      SB_HW_DT019X,
+				      &chip)) < 0) {
+		snd_card_free(card);
+		return error;
+	}
+
+	if ((error = snd_sb16dsp_pcm(chip, 0, NULL)) < 0) {
+		snd_card_free(card);
+		return error;
+	}
+	if ((error = snd_sbmixer_new(chip)) < 0) {
+		snd_card_free(card);
+		return error;
+	}
+
+	if (snd_mpu_port[dev] > 0) {
+		if (snd_mpu401_uart_new(card, 0,
+/*					MPU401_HW_SB,*/
+					MPU401_HW_MPU401,
+					snd_mpu_port[dev], 0,
+					snd_mpu_irq[dev],
+					SA_INTERRUPT,
+					NULL) < 0)
+			printk(KERN_ERR PFX "no MPU-401 device at 0x%lx ?\n",
+				snd_mpu_port[dev]);
+	}
+
+	if (snd_fm_port[dev] > 0) {
+		if (snd_opl3_create(card,
+				    snd_fm_port[dev],
+				    snd_fm_port[dev] + 2,
+				    OPL3_HW_AUTO, 0, &opl3) < 0) {
+			printk(KERN_ERR PFX "no OPL device at 0x%lx-0x%lx ?\n",
+				snd_fm_port[dev], snd_fm_port[dev] + 2);
+		} else {
+			if ((error = snd_opl3_timer_new(opl3, 0, 1)) < 0) {
+				snd_card_free(card);
+				return error;
+			}
+			if ((error = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
+				snd_card_free(card);
+				return error;
+			}
+		}
+	}
+
+	strcpy(card->driver, "DT-019X");
+	strcpy(card->shortname, "Diamond Tech. DT-019X");
+	sprintf(card->longname, "%s soundcard, %s at 0x%lx, irq %d, dma %d",
+		card->shortname, chip->name, chip->port,
+		snd_irq[dev], snd_dma8[dev]);
+	if ((error = snd_card_register(card)) < 0) {
+		snd_card_free(card);
+		return error;
+	}
+	snd_dt019x_cards[dev] = card;
+	return 0;
+}
+
+#ifdef __ISAPNP__
+static int __init snd_dt019x_isapnp_detect(struct isapnp_card *card,
+					    const struct isapnp_card_id *id)
+{
+	static int dev;
+	int res;
+
+	for ( ; dev < SNDRV_CARDS; dev++) {
+		if (!snd_enable[dev])
+			continue;
+		snd_dt019x_isapnp_cards[dev] = card;
+		snd_dt019x_isapnp_id[dev] = id;
+		res = snd_card_dt019x_probe(dev);
+		if (res < 0)
+			return res;
+		dev++;
+		return 0;
+        }
+        return -ENODEV;
+}
+#endif /* __ISAPNP__ */
+
+static int __init alsa_card_dt019x_init(void)
+{
+	int cards = 0;
+
+#ifdef __ISAPNP__
+	cards += isapnp_probe_cards(snd_dt019x_pnpids, snd_dt019x_isapnp_detect);
+#else
+	printk(KERN_ERR PFX "you have to enable ISA PnP support.\n");
+#endif
+#ifdef MODULE
+	if (!cards)
+		printk(KERN_ERR "no DT-019X / ALS-007 based soundcards found\n");
+#endif
+	return cards ? 0 : -ENODEV;
+}
+
+static void __exit alsa_card_dt019x_exit(void)
+{
+	int dev;
+
+	for (dev = 0; dev < SNDRV_CARDS; dev++)
+		snd_card_free(snd_dt019x_cards[dev]);
+}
+
+module_init(alsa_card_dt019x_init)
+module_exit(alsa_card_dt019x_exit)
+
+#ifndef MODULE
+
+/* format is: snd-dt019x=snd_enable,snd_index,snd_id,snd_isapnp,
+			  snd_port,snd_mpu_port,snd_fm_port,
+			  snd_irq,snd_mpu_irq,snd_dma8,snd_dma8_size */
+
+static int __init alsa_card_dt019x_setup(char *str)
+{
+	static unsigned __initdata nr_dev = 0;
+
+	if (nr_dev >= SNDRV_CARDS)
+		return 0;
+	(void)(get_option(&str,&snd_enable[nr_dev]) == 2 &&
+	       get_option(&str,&snd_index[nr_dev]) == 2 &&
+	       get_id(&str,&snd_id[nr_dev]) == 2 &&
+	       get_option(&str,(int *)&snd_port[nr_dev]) == 2 &&
+	       get_option(&str,(int *)&snd_mpu_port[nr_dev]) == 2 &&
+	       get_option(&str,(int *)&snd_fm_port[nr_dev]) == 2 &&
+	       get_option(&str,&snd_irq[nr_dev]) == 2 &&
+	       get_option(&str,&snd_mpu_irq[nr_dev]) == 2 &&
+	       get_option(&str,&snd_dma8[nr_dev]) == 2);
+	nr_dev++;
+	return 1;
+}
+
+__setup("snd-dt019x=", alsa_card_dt019x_setup);
+
+#endif /* ifndef MODULE */
diff -Nru a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
--- a/sound/isa/opti9xx/opti92x-ad1848.c	Sun Sep 29 20:22:50 2002
+++ b/sound/isa/opti9xx/opti92x-ad1848.c	Sun Sep 29 20:22:50 2002
@@ -326,9 +326,13 @@
 
 static int __init snd_opti9xx_init(opti9xx_t *chip, unsigned short hardware)
 {
+	static int opti9xx_mc_size[] = {7, 7, 10, 10, 2, 2, 2};
+
 	chip->hardware = hardware;
 	strcpy(chip->name, snd_opti9xx_names[hardware]);
 
+	chip->mc_base_size = opti9xx_mc_size[hardware];  
+
 	spin_lock_init(&chip->lock);
 
 	chip->wss_base = -1;
@@ -600,7 +604,7 @@
 #endif	/* CS4231 || OPTi93X */
 
 	spin_lock_irqsave(&chip->lock, flags);
-	outb(irq_bits << 3 | dma_bits, chip->wss_base);
+	snd_opti9xx_write(chip, OPTi9XX_MC_REG(3), (irq_bits << 3 | dma_bits));
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 __skip_resources:
@@ -972,7 +976,7 @@
 			s = s->link_next;
 		} while (s != substream);
 		spin_lock(&chip->lock);
-		if (SNDRV_PCM_TRIGGER_START)
+		if (cmd == SNDRV_PCM_TRIGGER_START)
 			snd_opti93x_out_mask(chip, OPTi93X_IFACE_CONF, what, what);
 		else
 			snd_opti93x_out_mask(chip, OPTi93X_IFACE_CONF, what, 0x00);
@@ -1178,7 +1182,6 @@
 	chip->playback_substream = substream;
 	runtime->hw = snd_opti93x_playback;
 	snd_pcm_limit_isa_dma_size(chip->dma1, &runtime->hw.buffer_bytes_max);
-	snd_pcm_limit_isa_dma_size(chip->dma1, &runtime->hw.period_bytes_max);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
 	return error;
 }
@@ -1194,7 +1197,6 @@
 	runtime->hw = snd_opti93x_capture;
 	snd_pcm_set_sync(substream);
 	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.buffer_bytes_max);
-	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.period_bytes_max);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
 	return error;
 }
@@ -1259,6 +1261,9 @@
 		disable_dma(chip->dma2);
 		free_dma(chip->dma2);
 	}
+	if (chip->irq >= 0) {
+	  free_irq(chip->irq, chip);
+	}
 	snd_magic_kfree(chip);
 	return 0;
 }
@@ -1312,6 +1317,11 @@
 	}
 	codec->dma2 = chip->dma2;
 
+	if (request_irq(chip->irq, snd_opti93x_interrupt, SA_INTERRUPT, DRIVER_NAME" - WSS", codec)) {
+	  snd_opti93x_free(codec);
+	  return -EBUSY;
+	}
+
 	codec->card = card;
 	codec->port = chip->wss_base + 4;
 	codec->irq = chip->irq;
@@ -1328,7 +1338,7 @@
 	snd_opti93x_init(codec);
 
 	/* Register device */
-	if ((error = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((error = snd_device_new(card, SNDRV_DEV_LOWLEVEL, codec, &ops)) < 0) {
 		snd_opti93x_free(codec);
 		return error;
 	}
@@ -1439,8 +1449,8 @@
 	right = (chip->image[OPTi93X_MIXOUT_RIGHT] & ~OPTi93X_MIXOUT_MIXER) | right;
 	change = left != chip->image[OPTi93X_MIXOUT_LEFT] ||
 	         right != chip->image[OPTi93X_MIXOUT_RIGHT];
-	snd_opti93x_out(chip, OPTi93X_MIXOUT_LEFT, left);
-	snd_opti93x_out(chip, OPTi93X_MIXOUT_RIGHT, right);
+	snd_opti93x_out_image(chip, OPTi93X_MIXOUT_LEFT, left);
+	snd_opti93x_out_image(chip, OPTi93X_MIXOUT_RIGHT, right);
 	spin_unlock_irqrestore(&chip->lock, flags);
 	return change;
 }
@@ -1520,7 +1530,7 @@
 
 static int snd_opti93x_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	int mask = (kcontrol->private_value >> 16) & 0xff;
+	int mask = (kcontrol->private_value >> 24) & 0xff;
 
 	uinfo->type = mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
@@ -1576,8 +1586,8 @@
 	val1 = (chip->image[left_reg] & ~(mask << shift_left)) | val1;
 	val2 = (chip->image[right_reg] & ~(mask << shift_right)) | val2;
 	change = val1 != chip->image[left_reg] || val2 != chip->image[right_reg];
-	snd_opti93x_out(chip, left_reg, val1);
-	snd_opti93x_out(chip, right_reg, val1);
+	snd_opti93x_out_image(chip, left_reg, val1);
+	snd_opti93x_out_image(chip, right_reg, val2);
 	spin_unlock_irqrestore(&chip->lock, flags);
 	return change;
 }
@@ -1586,20 +1596,20 @@
 
 static snd_kcontrol_new_t snd_opti93x_controls[] = {
 OPTi93X_DOUBLE("Master Playback Switch", 0, OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 7, 7, 1, 1),
-OPTi93X_DOUBLE("Master Playback Volume", 0, OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 0, 0, 31, 1),
+OPTi93X_DOUBLE("Master Playback Volume", 0, OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 1, 1, 31, 1), 
 OPTi93X_DOUBLE("PCM Playback Switch", 0, OPTi93X_DAC_LEFT, OPTi93X_DAC_RIGHT, 7, 7, 1, 1),
-OPTi93X_DOUBLE("PCM Playback Volume", 0, OPTi93X_DAC_LEFT, OPTi93X_DAC_RIGHT, 0, 0, 31, 0),
+OPTi93X_DOUBLE("PCM Playback Volume", 0, OPTi93X_DAC_LEFT, OPTi93X_DAC_RIGHT, 0, 0, 31, 1),
 OPTi93X_DOUBLE("FM Playback Switch", 0, OPTi931_FM_LEFT_INPUT, OPTi931_FM_RIGHT_INPUT, 7, 7, 1, 1),
-OPTi93X_DOUBLE("FM Playback Volume", 0, OPTi931_FM_LEFT_INPUT, OPTi931_FM_RIGHT_INPUT, 0, 0, 15, 1),
+OPTi93X_DOUBLE("FM Playback Volume", 0, OPTi931_FM_LEFT_INPUT, OPTi931_FM_RIGHT_INPUT, 1, 1, 15, 1),
 OPTi93X_DOUBLE("Line Playback Switch", 0, OPTi93X_LINE_LEFT_INPUT, OPTi93X_LINE_RIGHT_INPUT, 7, 7, 1, 1),
-OPTi93X_DOUBLE("Line Playback Volume", 0, OPTi93X_LINE_LEFT_INPUT, OPTi93X_LINE_RIGHT_INPUT, 0, 0, 15, 1),
+OPTi93X_DOUBLE("Line Playback Volume", 0, OPTi93X_LINE_LEFT_INPUT, OPTi93X_LINE_RIGHT_INPUT, 1, 1, 15, 1), 
 OPTi93X_DOUBLE("Mic Playback Switch", 0, OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 7, 7, 1, 1),
-OPTi93X_DOUBLE("Mic Playback Volume", 0, OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 0, 0, 15, 1),
+OPTi93X_DOUBLE("Mic Playback Volume", 0, OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 1, 1, 15, 1), 
 OPTi93X_DOUBLE("Mic Boost", 0, OPTi93X_MIXOUT_LEFT, OPTi93X_MIXOUT_RIGHT, 5, 5, 1, 1),
 OPTi93X_DOUBLE("CD Playback Switch", 0, OPTi93X_CD_LEFT_INPUT, OPTi93X_CD_RIGHT_INPUT, 7, 7, 1, 1),
-OPTi93X_DOUBLE("CD Playback Volume", 0, OPTi93X_CD_LEFT_INPUT, OPTi93X_CD_RIGHT_INPUT, 0, 0, 15, 1),
+OPTi93X_DOUBLE("CD Playback Volume", 0, OPTi93X_CD_LEFT_INPUT, OPTi93X_CD_RIGHT_INPUT, 1, 1, 15, 1),
 OPTi93X_DOUBLE("Aux Playback Switch", 0, OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 7, 7, 1, 1),
-OPTi93X_DOUBLE("Aux Playback Volume", 0, OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 0, 0, 15, 1),
+OPTi93X_DOUBLE("Aux Playback Volume", 0, OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 1, 1, 15, 1), 
 OPTi93X_DOUBLE("Capture Volume", 0, OPTi93X_MIXOUT_LEFT, OPTi93X_MIXOUT_RIGHT, 0, 0, 15, 0),
 {
 	iface: SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -1647,7 +1657,6 @@
 static int __init snd_card_opti9xx_detect(snd_card_t *card, opti9xx_t *chip)
 {
 	int i, err;
-	static int opti9xx_mc_size[] = {7, 7, 10, 10, 2, 2, 2};
 
 #ifndef OPTi93X
 	for (i = OPTi9XX_HW_82C928; i < OPTi9XX_HW_82C930; i++) {
@@ -1655,7 +1664,7 @@
 
 		if ((err = snd_opti9xx_init(chip, i)) < 0)
 			return err;
-		chip->mc_base_size = opti9xx_mc_size[i];
+
 		if (check_region(chip->mc_base, chip->mc_base_size))
 			continue;
 
@@ -1671,7 +1680,7 @@
 
 		if ((err = snd_opti9xx_init(chip, i)) < 0)
 			return err;
-		chip->mc_base_size = opti9xx_mc_size[i];
+
 		if (check_region(chip->mc_base, chip->mc_base_size))
 			continue;
 
@@ -1903,7 +1912,7 @@
 static int __init snd_card_opti9xx_probe(void)
 {
 	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
-	static long possible_mpu_ports[] = {0x300, 0x310, 0x320, 0x310, -1};
+	static long possible_mpu_ports[] = {0x300, 0x310, 0x320, 0x330, -1};
 #ifdef OPTi93X
 	static int possible_irqs[] = {5, 9, 10, 11, 7, -1};
 #else
diff -Nru a/sound/isa/sb/Makefile b/sound/isa/sb/Makefile
--- a/sound/isa/sb/Makefile	Sun Sep 29 20:22:50 2002
+++ b/sound/isa/sb/Makefile	Sun Sep 29 20:22:50 2002
@@ -18,7 +18,7 @@
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ALS100) += snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_CMI8330) += snd-sb16-dsp.o snd-sb-common.o
-obj-$(CONFIG_SND_DT0197H) += snd-sb16-dsp.o snd-sb-common.o
+obj-$(CONFIG_SND_DT019X) += snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_SB8) += snd-sb8.o snd-sb8-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_SB16) += snd-sb16.o snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_SBAWE) += snd-sbawe.o snd-sb16-dsp.o snd-sb-common.o
diff -Nru a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
--- a/sound/isa/sb/sb16.c	Sun Sep 29 20:22:50 2002
+++ b/sound/isa/sb/sb16.c	Sun Sep 29 20:22:50 2002
@@ -220,6 +220,8 @@
 	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
 	ISAPNP_SBAWE('C','T','L',0x0045,0x0031,0x0021),
 	/* Sound Blaster AWE 32 PnP */
+	ISAPNP_SBAWE('C','T','L',0x0046,0x0031,0x0021),
+	/* Sound Blaster AWE 32 PnP */
 	ISAPNP_SBAWE('C','T','L',0x0047,0x0031,0x0021),
 	/* Sound Blaster AWE 32 PnP */
 	ISAPNP_SBAWE('C','T','L',0x0048,0x0031,0x0021),
diff -Nru a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
--- a/sound/isa/sb/sb_common.c	Sun Sep 29 20:22:50 2002
+++ b/sound/isa/sb/sb_common.c	Sun Sep 29 20:22:50 2002
@@ -166,6 +166,9 @@
 	case SB_HW_ALS4000:
 		str = "16 (ALS-4000)";
 		break;
+	case SB_HW_DT019X:
+		str = "(DT019X/ALS007)";
+		break;
 	default:
 		return -ENODEV;
 	}
diff -Nru a/sound/isa/sb/sb_mixer.c b/sound/isa/sb/sb_mixer.c
--- a/sound/isa/sb/sb_mixer.c	Sun Sep 29 20:22:50 2002
+++ b/sound/isa/sb/sb_mixer.c	Sun Sep 29 20:22:50 2002
@@ -195,6 +195,98 @@
 }
 
 /*
+ * DT-019x / ALS-007 capture/input switch
+ */
+
+static int snd_dt019x_input_sw_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	static char *texts[5] = {
+		"CD", "Mic", "Line", "Synth", "Master"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 5;
+	if (uinfo->value.enumerated.item > 4)
+		uinfo->value.enumerated.item = 4;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_dt019x_input_sw_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	sb_t *sb = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	unsigned char oval;
+	
+	spin_lock_irqsave(&sb->mixer_lock, flags);
+	oval = snd_sbmixer_read(sb, SB_DT019X_CAPTURE_SW);
+	spin_unlock_irqrestore(&sb->mixer_lock, flags);
+	switch (oval & 0x07) {
+	case SB_DT019X_CAP_CD:
+		ucontrol->value.enumerated.item[0] = 0;
+		break;
+	case SB_DT019X_CAP_MIC:
+		ucontrol->value.enumerated.item[0] = 1;
+		break;
+	case SB_DT019X_CAP_LINE:
+		ucontrol->value.enumerated.item[0] = 2;
+		break;
+	case SB_DT019X_CAP_MAIN:
+		ucontrol->value.enumerated.item[0] = 4;
+		break;
+	/* To record the synth on these cards you must record the main.   */
+	/* Thus SB_DT019X_CAP_SYNTH == SB_DT019X_CAP_MAIN and would cause */
+	/* duplicate case labels if left uncommented. */
+	/* case SB_DT019X_CAP_SYNTH:
+	 *	ucontrol->value.enumerated.item[0] = 3;
+	 *	break;
+	 */
+	default:
+		ucontrol->value.enumerated.item[0] = 4;
+		break;
+	}
+	return 0;
+}
+
+static int snd_dt019x_input_sw_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	sb_t *sb = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	int change;
+	unsigned char nval, oval;
+	
+	if (ucontrol->value.enumerated.item[0] > 4)
+		return -EINVAL;
+	switch (ucontrol->value.enumerated.item[0]) {
+	case 0:
+		nval = SB_DT019X_CAP_CD;
+		break;
+	case 1:
+		nval = SB_DT019X_CAP_MIC;
+		break;
+	case 2:
+		nval = SB_DT019X_CAP_LINE;
+		break;
+	case 3:
+		nval = SB_DT019X_CAP_SYNTH;
+		break;
+	case 4:
+		nval = SB_DT019X_CAP_MAIN;
+		break;
+	default:
+		nval = SB_DT019X_CAP_MAIN;
+	}
+	spin_lock_irqsave(&sb->mixer_lock, flags);
+	oval = snd_sbmixer_read(sb, SB_DT019X_CAPTURE_SW);
+	change = nval != oval;
+	if (change)
+		snd_sbmixer_write(sb, SB_DT019X_CAPTURE_SW, nval);
+	spin_unlock_irqrestore(&sb->mixer_lock, flags);
+	return change;
+}
+
+/*
  * SBPRO input multiplexer
  */
 
@@ -422,6 +514,44 @@
 	{ SB_DSP4_SPEAKER_DEV, 0 },
 };
 
+#define DT019X_CONTROLS (sizeof(snd_dt019x_controls)/sizeof(snd_kcontrol_new_t))
+
+static snd_kcontrol_new_t snd_dt019x_controls[] = {
+SB_DOUBLE("Master Playback Volume", SB_DT019X_MASTER_DEV, SB_DT019X_MASTER_DEV, 4,0, 15),
+SB_DOUBLE("PCM Playback Volume", SB_DT019X_PCM_DEV, SB_DT019X_PCM_DEV, 4,0, 15),
+SB_DOUBLE("Synth Playback Volume", SB_DT019X_SYNTH_DEV, SB_DT019X_SYNTH_DEV, 4,0, 15),
+SB_DOUBLE("CD Playback Volume", SB_DT019X_CD_DEV, SB_DT019X_CD_DEV, 4,0, 15),
+SB_SINGLE("Mic Playback Volume", SB_DT019X_MIC_DEV, 4, 7),
+SB_SINGLE("PC Speaker Volume", SB_DT019X_SPKR_DEV, 0,  7),
+SB_DOUBLE("Line Playback Volume", SB_DT019X_LINE_DEV, SB_DT019X_LINE_DEV, 4,0, 15),
+SB_SINGLE("Mic Playback Switch", SB_DT019X_OUTPUT_SW1, 0, 1),
+SB_DOUBLE("CD Playback Switch", SB_DT019X_OUTPUT_SW1, SB_DT019X_OUTPUT_SW1, 2,1, 1),
+SB_DOUBLE("Line Playback Switch", SB_DT019X_OUTPUT_SW1, SB_DT019X_OUTPUT_SW1, 4,3, 1),
+SB_DOUBLE("PCM Playback Switch", SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 2,1, 1),
+SB_DOUBLE("Synth Playback Switch", SB_DT019X_OUTPUT_SW2, SB_DT019X_OUTPUT_SW2, 4,3, 1),
+{
+	iface: SNDRV_CTL_ELEM_IFACE_MIXER,
+	name: "Capture Source",
+	info: snd_dt019x_input_sw_info,
+	get: snd_dt019x_input_sw_get,
+	put: snd_dt019x_input_sw_put,
+},
+};
+
+#define DT019X_INIT_VALUES (sizeof(snd_dt019x_init_values)/sizeof(unsigned char)/2)
+
+static unsigned char snd_dt019x_init_values[][2] = {
+        { SB_DT019X_MASTER_DEV, 0 },
+        { SB_DT019X_PCM_DEV, 0 },
+        { SB_DT019X_SYNTH_DEV, 0 },
+        { SB_DT019X_CD_DEV, 0 },
+        { SB_DT019X_MIC_DEV, 0 },	/* Includes PC-speaker in high nibble */
+        { SB_DT019X_LINE_DEV, 0 },
+        { SB_DT019X_OUTPUT_SW1, 0 },
+        { SB_DT019X_OUTPUT_SW2, 0 },
+        { SB_DT019X_CAPTURE_SW, 0x06 },
+};
+
 static int snd_sbmixer_init(sb_t *chip,
 			    snd_kcontrol_new_t *controls,
 			    int controls_count,
@@ -489,6 +619,12 @@
 					    snd_sb16_init_values, SB16_INIT_VALUES,
 					    "CTL1745")) < 0)
 			return err;
+		break;
+	case SB_HW_DT019X:
+		if ((err = snd_sbmixer_init(chip,
+					    snd_dt019x_controls, DT019X_CONTROLS,
+					    snd_dt019x_init_values, DT019X_INIT_VALUES,
+					    "DT019X")) < 0)
 		break;
 	default:
 		strcpy(card->mixername, "???");
diff -Nru a/sound/pci/via686.c b/sound/pci/via686.c
--- a/sound/pci/via686.c	Sun Sep 29 20:22:50 2002
+++ b/sound/pci/via686.c	Sun Sep 29 20:22:50 2002
@@ -165,12 +165,11 @@
 static int build_via_table(viadev_t *dev, snd_pcm_substream_t *substream,
 			   struct pci_dev *pci)
 {
-	int i, pages, size;
+	int i, size;
 	struct snd_sg_buf *sgbuf = snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, return -EINVAL);
 
 	if (dev->table) {
-		pages = snd_pcm_sgbuf_pages(dev->tbl_entries * 8);
-		snd_free_pci_pages(pci, pages << PAGE_SHIFT, dev->table, dev->table_addr);
+		snd_free_pci_pages(pci, PAGE_ALIGN(dev->tbl_entries * 8), dev->table, dev->table_addr);
 		dev->table = NULL;
 	}
 
@@ -187,8 +186,7 @@
 	/* the start of each lists must be aligned to 8 bytes,
 	 * but the kernel pages are much bigger, so we don't care
 	 */
-	pages = snd_pcm_sgbuf_pages(dev->tbl_entries * 8);
-	dev->table = (u32*)snd_malloc_pci_pages(pci, pages << PAGE_SHIFT, &dev->table_addr);
+	dev->table = (u32*)snd_malloc_pci_pages(pci, PAGE_ALIGN(dev->tbl_entries * 8), &dev->table_addr);
 	if (! dev->table)
 		return -ENOMEM;
 
@@ -214,7 +212,7 @@
 			    struct pci_dev *pci)
 {
 	if (dev->table) {
-		snd_free_pci_pages(pci, snd_pcm_sgbuf_pages(dev->tbl_entries * 8) << PAGE_SHIFT, dev->table, dev->table_addr);
+		snd_free_pci_pages(pci, PAGE_ALIGN(dev->tbl_entries * 8), dev->table, dev->table_addr);
 		dev->table = NULL;
 	}
 }
diff -Nru a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
--- a/sound/pci/ymfpci/ymfpci_main.c	Sun Sep 29 20:22:50 2002
+++ b/sound/pci/ymfpci/ymfpci_main.c	Sun Sep 29 20:22:50 2002
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/info.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.605.2.18
## Wrapped with gzip_uu ##


begin 664 bkpatch2508
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
!````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

