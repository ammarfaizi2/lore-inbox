Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSJ1Rrv>; Mon, 28 Oct 2002 12:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSJ1RrT>; Mon, 28 Oct 2002 12:47:19 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:2320 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261423AbSJ1RYG>; Mon, 28 Oct 2002 12:24:06 -0500
Date: Tue, 29 Oct 2002 02:30:22 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 22/23] add support for PC-9800 architecture (sound oss #2)
Message-ID: <20021029023022.A2349@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 22/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

Summary:
 New driver for one of PC9800 sound card.
 This source file is sharing with FreeBSD, so size is big.

diffstat:
 sound/oss/pc9801_86_pcm.c | 2580 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 2580 insertions(+)

patch:
diff -urN linux/sound/oss/pc9801_86_pcm.c linux98/sound/oss/pc9801_86_pcm.c
--- linux/sound/oss/pc9801_86_pcm.c	Thu Jan  1 09:00:00 1970
+++ linux98/sound/oss/pc9801_86_pcm.c	Sun Aug 19 14:13:08 2001
@@ -0,0 +1,2580 @@
+/*
+ * PC-9801-86 PCM driver for FreeBSD(98) and Linux/98.
+ *
+ * Copyright (c) 1995  NAGAO Tadaaki (ABTK)
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR AND CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ * $Id: pcm86.c,v 1.9 2000/02/08 06:39:23 susho Exp $
+ */
+
+/*
+ * !! NOTE !! :
+ *   This file DOES NOT belong to the VoxWare distribution though it works
+ *   as part of the VoxWare drivers.  It is FreeBSD(98) original.
+ *   -- Nagao (nagao@cs.titech.ac.jp)
+ */
+
+/*
+ * CHANGES:
+ *
+ *   Masahiro Sakai  : ported to Linux/98.
+ *
+ */
+
+#ifndef __linux__
+#include <i386/isa/sound/sound_config.h>
+#else /* __linux__ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include "sound_config.h"
+/* #include "soundmodule.h" */
+#define printf(args...) printk(## args)
+#define outb(port, data) outb(data, port)
+#define DMA_DISABLE 0
+#endif /* __linux__ */
+
+#if defined(__linux__) || defined(CONFIGURE_SOUNDCARD) 
+
+#if !defined(EXCLUDE_NSS) && !defined(EXCLUDE_AUDIO)
+
+/*
+ * Constants
+ */
+
+#define YES		1
+#define NO		0
+
+#define IMODE_NONE	0
+#define IMODE_INPUT	1
+#define IMODE_OUTPUT	2
+
+/* PC-9801-86 specific constants */
+#define	PCM86_IOBASE	0xa460	/* PCM I/O ports */
+#define PCM86_FIFOSIZE	32768	/* There is a 32kB FIFO buffer on 86-board */
+
+/* XXX -- These values should be chosen appropriately. */
+#define PCM86_INTRSIZE_OUT	1024
+#define PCM86_INTRSIZE_IN	(PCM86_FIFOSIZE / 2 - 128)
+#define DEFAULT_VOLUME		15	/* 0(min) - 15(max) */
+
+
+/*
+ * Switches for debugging and experiments
+ */
+/*
+#define NSS_DEBUG
+*/
+#ifdef NSS_DEBUG
+# ifdef DEB
+#  undef DEB
+# endif
+# define DEB(x) x
+#endif
+
+
+/*
+ * Private variables and types
+ */
+
+typedef unsigned char pcm_data;
+
+enum board_type {
+    NO_SUPPORTED_BOARD = 0,
+    PC980186_FAMILY = 1,
+    PC980173_FAMILY = 2
+};
+
+static char *board_name[] = {
+    /* Each must be of the length less than 32 bytes. */
+    "No supported board",
+    "PC-9801-86 soundboard",
+    "PC-9801-73 soundboard"
+};
+
+/* Current status of the driver */
+static struct {
+    int			iobase;
+    int			irq;
+    enum board_type	board_type;
+    int			opened;
+    int			format;
+    int			bytes;
+    int			chipspeedno;
+    int			chipspeed;
+    int			speed;
+    int			stereo;
+    int			volume;
+    int			intr_busy;
+    int			intr_size;
+    int			intr_mode;
+    int			intr_last;
+    int			intr_trailer;
+    pcm_data *		pdma_buf;
+    int			pdma_count;
+    int			pdma_chunkcount;
+    int			acc;
+    int			last_l;
+    int			last_r;
+#ifndef __linux__
+    sound_os_info       *osp;
+#else
+    int			*osp;
+#endif
+
+} pcm_s;
+
+static struct {
+    pcm_data		buff[4];
+    int			size;
+} tmpbuf;
+
+static int my_dev = 0;
+static char nss_initialized = NO;
+
+/* 86-board supports only the following rates. */
+static int rates_tbl[8] = {
+#ifndef WAVEMASTER_FREQ
+    44100, 33075, 22050, 16538, 11025, 8269, 5513, 4134
+#else
+    /*
+     * It is said that Q-Vision's WaveMaster of some earlier lot(s?) has
+     * sampling rates incompatible with PC-9801-86.
+     * But I'm not sure whether the following rates are correct, especially
+     * 4000Hz.
+     */
+    44100, 33075, 22050, 16000, 11025, 8000, 5510, 4000
+#endif
+};
+
+/* u-law to linear translation table */
+static pcm_data ulaw2linear[256] = {
+    130, 134, 138, 142, 146, 150, 154, 158, 
+    162, 166, 170, 174, 178, 182, 186, 190, 
+    193, 195, 197, 199, 201, 203, 205, 207, 
+    209, 211, 213, 215, 217, 219, 221, 223, 
+    225, 226, 227, 228, 229, 230, 231, 232, 
+    233, 234, 235, 236, 237, 238, 239, 240, 
+    240, 241, 241, 242, 242, 243, 243, 244, 
+    244, 245, 245, 246, 246, 247, 247, 248, 
+    248, 248, 249, 249, 249, 249, 250, 250, 
+    250, 250, 251, 251, 251, 251, 252, 252, 
+    252, 252, 252, 252, 253, 253, 253, 253, 
+    253, 253, 253, 253, 254, 254, 254, 254, 
+    254, 254, 254, 254, 254, 254, 254, 254, 
+    255, 255, 255, 255, 255, 255, 255, 255, 
+    255, 255, 255, 255, 255, 255, 255, 255, 
+    255, 255, 255, 255, 255, 255, 255, 255, 
+    125, 121, 117, 113, 109, 105, 101,  97, 
+     93,  89,  85,  81,  77,  73,  69,  65, 
+     62,  60,  58,  56,  54,  52,  50,  48, 
+     46,  44,  42,  40,  38,  36,  34,  32, 
+     30,  29,  28,  27,  26,  25,  24,  23, 
+     22,  21,  20,  19,  18,  17,  16,  15, 
+     15,  14,  14,  13,  13,  12,  12,  11, 
+     11,  10,  10,   9,   9,   8,   8,   7, 
+      7,   7,   6,   6,   6,   6,   5,   5, 
+      5,   5,   4,   4,   4,   4,   3,   3, 
+      3,   3,   3,   3,   2,   2,   2,   2, 
+      2,   2,   2,   2,   1,   1,   1,   1, 
+      1,   1,   1,   1,   1,   1,   1,   1, 
+      0,   0,   0,   0,   0,   0,   0,   0, 
+      0,   0,   0,   0,   0,   0,   0,   0, 
+      0,   0,   0,   0,   0,   0,   0,   0
+};
+
+/* linear to u-law translation table */
+static pcm_data linear2ulaw[256] = {
+    255, 231, 219, 211, 205, 201, 197, 193, 
+    190, 188, 186, 184, 182, 180, 178, 176, 
+    175, 174, 173, 172, 171, 170, 169, 168, 
+    167, 166, 165, 164, 163, 162, 161, 160, 
+    159, 159, 158, 158, 157, 157, 156, 156, 
+    155, 155, 154, 154, 153, 153, 152, 152, 
+    151, 151, 150, 150, 149, 149, 148, 148, 
+    147, 147, 146, 146, 145, 145, 144, 144, 
+    143, 143, 143, 143, 142, 142, 142, 142, 
+    141, 141, 141, 141, 140, 140, 140, 140, 
+    139, 139, 139, 139, 138, 138, 138, 138, 
+    137, 137, 137, 137, 136, 136, 136, 136, 
+    135, 135, 135, 135, 134, 134, 134, 134, 
+    133, 133, 133, 133, 132, 132, 132, 132, 
+    131, 131, 131, 131, 130, 130, 130, 130, 
+    129, 129, 129, 129, 128, 128, 128, 128, 
+      0,   0,   0,   0,   0,   1,   1,   1, 
+      1,   2,   2,   2,   2,   3,   3,   3, 
+      3,   4,   4,   4,   4,   5,   5,   5, 
+      5,   6,   6,   6,   6,   7,   7,   7, 
+      7,   8,   8,   8,   8,   9,   9,   9, 
+      9,  10,  10,  10,  10,  11,  11,  11, 
+     11,  12,  12,  12,  12,  13,  13,  13, 
+     13,  14,  14,  14,  14,  15,  15,  15, 
+     15,  16,  16,  17,  17,  18,  18,  19, 
+     19,  20,  20,  21,  21,  22,  22,  23, 
+     23,  24,  24,  25,  25,  26,  26,  27, 
+     27,  28,  28,  29,  29,  30,  30,  31, 
+     31,  32,  33,  34,  35,  36,  37,  38, 
+     39,  40,  41,  42,  43,  44,  45,  46, 
+     47,  48,  50,  52,  54,  56,  58,  60, 
+     62,  65,  69,  73,  77,  83,  91, 103
+};
+
+
+/*
+ * Prototypes
+ */
+
+static int nss_detect(struct address_info *);
+
+static int nss_open(int, int);
+static void nss_close(int);
+#ifndef __linux__
+static void nss_output_block(int, unsigned long, int, int, int);
+static void nss_start_input(int, unsigned long, int, int, int);
+static int nss_ioctl(int, u_int, ioctl_arg, int);
+#else /* __linux__ */
+static void nss_output_block(int, unsigned long, int, int);
+static void nss_start_input(int, unsigned long, int, int);
+static int nss_ioctl(int, u_int, caddr_t);
+/*static void nss_trigger(int dev, int bits);*/
+#endif /* __linux__ */
+static int nss_prepare_for_input(int, int, int);
+static int nss_prepare_for_output(int, int, int);
+#ifndef __linux__
+static void nss_reset(int);
+#endif
+static void nss_halt_xfer(int);
+#ifndef __linux__
+void nssintr(int);
+#else
+void nssintr(int, void*, struct pt_regs*);
+#endif
+
+static void dsp73_send_command(unsigned char);
+static void dsp73_send_data(unsigned char);
+static void dsp73_init(void);
+static int set_format(int);
+#ifndef __linux__
+static int set_speed(int);
+#else
+static int set_speed(int, int);
+#endif
+static int set_stereo(int);
+static void set_volume(int);
+#ifdef __linux__
+static unsigned int set_bits(int, unsigned int);
+static short set_channels(int, short);
+#endif
+static void fifo_start(int);
+static void fifo_stop(void);
+static void fifo_reset(void);
+static void fifo_output_block(void);
+static int fifo_send(pcm_data *, int);
+static void fifo_sendtrailer(int);
+static void fifo_send_stereo(pcm_data *, int);
+static void fifo_send_monoral(pcm_data *, int);
+static void fifo_send_stereo_ulaw(pcm_data *, int);
+static void fifo_send_stereo_8(pcm_data *, int, int);
+static void fifo_send_stereo_16le(pcm_data *, int, int);
+static void fifo_send_stereo_16be(pcm_data *, int, int);
+static void fifo_send_mono_ulaw(pcm_data *, int);
+static void fifo_send_mono_8(pcm_data *, int, int);
+static void fifo_send_mono_16le(pcm_data *, int, int);
+static void fifo_send_mono_16be(pcm_data *, int, int);
+static void fifo_input_block(void);
+static void fifo_recv(pcm_data *, int);
+static void fifo_recv_stereo(pcm_data *, int);
+static void fifo_recv_monoral(pcm_data *, int);
+static void fifo_recv_stereo_ulaw(pcm_data *, int);
+static void fifo_recv_stereo_8(pcm_data *, int, int);
+static void fifo_recv_stereo_16le(pcm_data *, int, int);
+static void fifo_recv_stereo_16be(pcm_data *, int, int);
+static void fifo_recv_mono_ulaw(pcm_data *, int);
+static void fifo_recv_mono_8(pcm_data *, int, int);
+static void fifo_recv_mono_16le(pcm_data *, int, int);
+static void fifo_recv_mono_16be(pcm_data *, int, int);
+static void nss_stop(void);
+static void nss_init(void);
+
+
+/*
+ * Identity
+ */
+
+#define NSS_AUDIO_NAME "PC-9801-86 SoundBoard"
+#ifndef __linux__ 
+#define NSS_AUDIO_FLAGS DMA_DISABLE
+#else
+#define NSS_AUDIO_FLAGS NOTHING_SPECIAL
+#endif
+#define NSS_AUDIO_FORMAT_MASK ( AFMT_MU_LAW |\
+				AFMT_U8 | AFMT_S16_LE | AFMT_S16_BE | \
+				AFMT_S8 | AFMT_U16_LE | AFMT_U16_BE )
+#ifndef __linux__
+static struct audio_operations nss_operations =
+{
+    NSS_AUDIO_NAME, /* filled in properly by auto configuration */
+    NSS_AUDIO_FLAGS,
+    NSS_AUDIO_FORMAT_MASK,
+    NULL,
+    nss_open,
+    nss_close,
+    nss_output_block,
+    nss_start_input,
+    nss_ioctl,
+    nss_prepare_for_input,
+    nss_prepare_for_output,
+    nss_reset,
+    nss_halt_xfer,
+    NULL,
+    NULL
+};
+#else
+static struct {
+    char *name;
+} nss_operations = {
+    NSS_AUDIO_NAME /* filled in properly by auto configuration */
+};
+static struct audio_driver nss_audio_driver =
+{
+	owner:		THIS_MODULE,
+	open:		nss_open,
+	close:		nss_close,
+	output_block:	nss_output_block,
+	start_input:	nss_start_input,
+	ioctl:		nss_ioctl,
+	prepare_for_input:	nss_prepare_for_input,
+	prepare_for_output:	nss_prepare_for_output,
+	halt_io:	nss_halt_xfer,
+	halt_input:	nss_halt_xfer,
+	halt_output:	nss_halt_xfer,
+	set_speed:	set_speed,
+	set_bits:	set_bits,
+	set_channels:	set_channels
+};
+
+static int pc9801_86_get_user_vol(caddr_t arg)
+{
+	int vol;
+
+	__get_user(vol, (int *)arg);
+	if (*((unsigned char *)(&vol)) > 100)
+		*((unsigned char *)(&vol)) = 100;
+	if (*((unsigned char *)(&vol) + 1) > 100)
+		*((unsigned char *)(&vol) + 1) = 100;
+	return vol;
+}
+
+static void pc9801_86_setvol(int id, int vol)
+{
+	outb(pcm_s.iobase + 6, id - (vol & 0xff) * 15 / 100);
+	outb(0x5f,0);
+	outb(0x5f,0);
+	outb(0x5f,0);
+	outb(0x5f,0);
+}
+
+static int nss_mixer_ioctl(int dev, unsigned int cmd, caddr_t arg)
+{
+	static int line_vol = 50;
+	static int synth_vol = 50;
+	static int pcm_vol = 50;
+
+	switch (cmd) {
+	case SOUND_MIXER_WRITE_LINE:
+		line_vol = pc9801_86_get_user_vol(arg);
+		pc9801_86_setvol(0x4f, line_vol);
+		/* 0x4f = 0100 1111 : LINE direct out level */
+		pc9801_86_setvol(0x6f, line_vol);
+		/* 0x6f = 0110 1111 : LINE indirect out level */
+		return 0;
+	case SOUND_MIXER_WRITE_SYNTH:
+		synth_vol = pc9801_86_get_user_vol(arg);
+		pc9801_86_setvol(0x0f, synth_vol);
+		/* 0x0f = 0000 1111 : FM direct out level */
+		pc9801_86_setvol(0x2f, synth_vol);
+		/* 0x2f = 0010 1111 : FM indirect out level */
+		return 0;
+	case SOUND_MIXER_WRITE_PCM:
+		pcm_vol = pc9801_86_get_user_vol(arg);
+		pc9801_86_setvol(0xaf, pcm_vol);
+		/* 0xaf = 1010 1111 : PCM direct out level */
+		return 0;
+	case SOUND_MIXER_WRITE_RECSRC:
+	case SOUND_MIXER_READ_RECMASK:
+	case SOUND_MIXER_READ_RECSRC:
+		__put_user(SOUND_MASK_LINE | SOUND_MASK_SYNTH, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_DEVMASK:
+		__put_user(SOUND_MASK_LINE | SOUND_MASK_SYNTH | SOUND_MASK_PCM, 
+			    (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_STEREODEVS:
+	case SOUND_MIXER_READ_CAPS:
+		__put_user(0, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_LINE:
+		__put_user(line_vol, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_SYNTH:
+		__put_user(synth_vol, (int *)arg);
+		return 0;
+	case SOUND_MIXER_READ_PCM:
+		__put_user(pcm_vol, (int *)arg);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static struct mixer_operations nss_mixer_operations =
+{
+	owner:	THIS_MODULE,
+	id:	"PC-9801-86",
+	name:	"NEC PC-9801-86 Sound Card",
+	ioctl:	nss_mixer_ioctl
+};
+#endif
+
+
+/*
+ * Codes for internal use
+ */
+
+static void
+dsp73_send_command(unsigned char command)
+{
+    /* wait for RDY */
+    while ((inb(pcm_s.iobase + 2) & 0x48) != 8);
+
+    /* command mode */
+    outb(pcm_s.iobase + 2, (inb(pcm_s.iobase + 2) & 0x20) | 3);
+
+    /* wait for RDY */
+    while ((inb(pcm_s.iobase + 2) & 0x48) != 8);
+
+    /* send command */
+    outb(pcm_s.iobase + 4, command);
+}
+
+
+static void
+dsp73_send_data(unsigned char data)
+{
+    /* wait for RDY */
+    while ((inb(pcm_s.iobase + 2) & 0x48) != 8);
+
+    /* data mode */
+    outb(pcm_s.iobase + 2, (inb(pcm_s.iobase + 2) & 0x20) | 0x83);
+
+    /* wait for RDY */
+    while ((inb(pcm_s.iobase + 2) & 0x48) != 8);
+
+    /* send command */
+    outb(pcm_s.iobase + 4, data);
+}
+
+
+static void
+dsp73_init(void)
+{
+    const unsigned char dspinst[15] = {
+	0x00, 0x00, 0x27,
+	0x3f, 0xe0, 0x01,
+	0x00, 0x00, 0x27,
+	0x36, 0x5a, 0x0d,
+	0x3e, 0x60, 0x04
+    };
+    unsigned char t;
+    int i;
+
+    /* reset DSP */
+    t = inb(pcm_s.iobase + 2);
+    outb(pcm_s.iobase + 2, (t & 0x80) | 0x23);
+
+    /* mute on */
+    dsp73_send_command(0x04);
+    dsp73_send_data(0x6f);
+    dsp73_send_data(0x3c);
+
+    /* write DSP instructions */
+    dsp73_send_command(0x01);
+    dsp73_send_data(0x00);
+    for (i = 0; i < 16; i++)
+	dsp73_send_data(dspinst[i]);
+
+    /* mute off */
+    dsp73_send_command(0x04);
+    dsp73_send_data(0x6f);
+    dsp73_send_data(0x30);
+
+    /* wait for RDY */
+    while ((inb(pcm_s.iobase + 2) & 0x48) != 8);
+
+    outb(pcm_s.iobase + 2, 3);
+}
+
+
+static int
+set_format(int format)
+{
+    switch (format) {
+    case AFMT_MU_LAW:
+    case AFMT_S8:
+    case AFMT_U8:
+	pcm_s.format = format;
+	pcm_s.bytes = 1;	/* 8bit */
+	break;
+    case AFMT_S16_LE:
+    case AFMT_U16_LE:
+    case AFMT_S16_BE:
+    case AFMT_U16_BE:
+	pcm_s.format = format;
+	pcm_s.bytes = 2;	/* 16bit */
+	break;
+    case AFMT_QUERY:
+	break;
+    default:
+	return -1;
+    }
+
+    return pcm_s.format;
+}
+
+
+static int
+#ifndef __linux__
+set_speed(int speed)
+#else
+set_speed(int dev, int speed)
+#endif
+{
+    int i;
+
+    if (speed == 0) return pcm_s.speed;
+    if (speed < 4000)	/* Minimum 4000Hz */
+	speed = 4000;
+    if (speed > 44100)	/* Maximum 44100Hz */
+	speed = 44100;
+    for (i = 7; i >= 0; i--) {
+	if (speed <= rates_tbl[i]) {
+	    pcm_s.chipspeedno = i;
+	    pcm_s.chipspeed = rates_tbl[i];
+	    break;
+	}
+    }
+    pcm_s.speed = speed;
+    return speed;
+}
+
+
+#ifdef __linux__
+
+static unsigned int
+set_bits(int dev, unsigned int arg)
+{
+	return set_format(arg);
+}
+
+
+static short
+set_channels(int dev, short arg)
+{
+	if (arg != 1 && arg != 2) {
+		if (pcm_s.stereo)
+			return 2;
+		else
+			return 1;
+	}
+	set_stereo(arg == 2);
+	return arg;
+}
+
+#endif
+
+
+static int
+set_stereo(int stereo)
+{
+    pcm_s.stereo = stereo ? YES : NO;
+
+    return pcm_s.stereo;
+}
+
+
+static void
+set_volume(int volume)
+{
+    if (volume < 0)
+	volume = 0;
+    if (volume > 15)
+	volume = 15;
+    pcm_s.volume = volume;
+
+    outb(pcm_s.iobase + 6, 0xaf - volume);	/* D/A -> LINE OUT */
+    /* 0xaf = 1010 1111 */
+    outb(0x5f,0);
+    outb(0x5f,0);
+    outb(0x5f,0);
+    outb(0x5f,0);
+    outb(pcm_s.iobase + 6, 0x20);		/* FM -> A/D */
+    /* 0x20 = 0010 0000 */
+    outb(0x5f,0);
+    outb(0x5f,0);
+    outb(0x5f,0);
+    outb(0x5f,0);
+    outb(pcm_s.iobase + 6, 0x60);		/* LINE IN -> A/D */
+    /* 0x60 = 0110 0000 */
+    outb(0x5f,0);
+    outb(0x5f,0);
+    outb(0x5f,0);
+    outb(0x5f,0);
+}
+
+
+static void
+fifo_start(int mode)
+{
+    unsigned char tmp;
+
+    /* Set frame length & panpot(LR). */
+    tmp = inb(pcm_s.iobase + 10) & 0x88;
+    outb(pcm_s.iobase + 10, tmp | ((pcm_s.bytes == 1) ? 0x72 : 0x32));
+
+    tmp = pcm_s.chipspeedno;
+    if (mode == IMODE_INPUT)
+	tmp |= 0x40;
+
+    /* Reset intr. flag. */
+    outb(pcm_s.iobase + 8, tmp);
+    outb(pcm_s.iobase + 8, tmp | 0x10);
+
+    /* Enable FIFO intr. */
+    outb(pcm_s.iobase + 8, tmp | 0x30);
+
+    /* Set intr. interval. */
+    outb(pcm_s.iobase + 10, pcm_s.intr_size / 128 - 1);
+
+    /* Start intr. */
+    outb(pcm_s.iobase + 8, tmp | 0xb0);
+}
+
+
+static void
+fifo_stop(void)
+{
+    unsigned char tmp;
+
+    /* Reset intr. flag, and disable FIFO intr. */
+    tmp = inb(pcm_s.iobase + 8) & 0x0f;
+    outb(pcm_s.iobase + 8, tmp);
+}
+
+
+static void
+fifo_reset(void)
+{
+    unsigned char tmp;
+
+    /* Reset FIFO. */
+    tmp = inb(pcm_s.iobase + 8) & 0x77;
+    outb(pcm_s.iobase + 8, tmp | 0x8);
+    outb(pcm_s.iobase + 8, tmp);
+}
+
+
+static void
+fifo_output_block(void)
+{
+    int chunksize, count;
+    if (pcm_s.pdma_chunkcount) {
+	/* Update chunksize and then send the next chunk to FIFO. */
+	chunksize = pcm_s.pdma_count / pcm_s.pdma_chunkcount--;
+	count = fifo_send(pcm_s.pdma_buf, chunksize);
+    } else {
+	/* ??? something wrong... */
+	printf("nss0: chunkcount overrun\n");
+	chunksize = count = 0;
+    }
+    if (((audio_devs[my_dev]->dmap_out->qlen < 2) && (pcm_s.pdma_chunkcount == 0))
+	|| (count < pcm_s.intr_size)) {
+	/* The sent chunk seems to be the last one. */
+	fifo_sendtrailer(pcm_s.intr_size);
+	pcm_s.intr_last = YES;
+    }
+
+    pcm_s.pdma_buf += chunksize;
+    pcm_s.pdma_count -= chunksize;
+}
+
+
+static int
+fifo_send(pcm_data *buf, int count)
+{
+    int i, length, r, cnt, rslt;
+    pcm_data *p;
+
+    /* Calculate the length of PCM frames. */
+    cnt = count + tmpbuf.size;
+    length = pcm_s.bytes << pcm_s.stereo;
+    r = cnt % length;
+    cnt -= r;
+
+    if (cnt > 0) {
+	if (pcm_s.stereo)
+	    fifo_send_stereo(buf, cnt);
+	else
+	    fifo_send_monoral(buf, cnt);
+	/* Carry over extra data which doesn't seem to be a full PCM frame. */
+	p = (pcm_data *)buf + count - r;
+	for (i = 0; i < r; i++)
+	    tmpbuf.buff[i] = *p++;
+    } else {
+	/* Carry over extra data which doesn't seem to be a full PCM frame. */
+	p = (pcm_data *)buf;
+	for (i = tmpbuf.size; i < r; i++)
+	    tmpbuf.buff[i] = *p++;
+    }
+    tmpbuf.size = r;
+
+    rslt = ((cnt / length) * pcm_s.chipspeed / pcm_s.speed) * pcm_s.bytes * 2;
+#ifdef NSS_DEBUG
+    printf("fifo_send(): %d bytes sent\n", rslt);
+#endif
+    return rslt;
+}
+
+
+static void
+fifo_sendtrailer(int count)
+{
+    /* Send trailing zeros to the FIFO buffer. */
+    int i;
+
+    for (i = 0; i < count; i++)
+	outb(pcm_s.iobase + 12, 0);
+    pcm_s.intr_trailer = YES;
+
+#ifdef NSS_DEBUG
+    printf("fifo_sendtrailer(): %d bytes sent\n", count);
+#endif
+}
+
+
+static void
+fifo_send_stereo(pcm_data *buf, int count)
+{
+    /* Convert format and sampling speed. */
+    switch (pcm_s.format) {
+    case AFMT_MU_LAW:
+	fifo_send_stereo_ulaw(buf, count);
+	break;
+    case AFMT_S8:
+	fifo_send_stereo_8(buf, count, NO);
+	break;
+    case AFMT_U8:
+	fifo_send_stereo_8(buf, count, YES);
+	break;
+    case AFMT_S16_LE:
+	fifo_send_stereo_16le(buf, count, NO);
+	break;
+    case AFMT_U16_LE:
+	fifo_send_stereo_16le(buf, count, YES);
+	break;
+    case AFMT_S16_BE:
+	fifo_send_stereo_16be(buf, count, NO);
+	break;
+    case AFMT_U16_BE:
+	fifo_send_stereo_16be(buf, count, YES);
+	break;
+    }
+}
+
+
+static void
+fifo_send_monoral(pcm_data *buf, int count)
+{
+    /* Convert format and sampling speed. */
+    switch (pcm_s.format) {
+    case AFMT_MU_LAW:
+	fifo_send_mono_ulaw(buf, count);
+	break;
+    case AFMT_S8:
+	fifo_send_mono_8(buf, count, NO);
+	break;
+    case AFMT_U8:
+	fifo_send_mono_8(buf, count, YES);
+	break;
+    case AFMT_S16_LE:
+	fifo_send_mono_16le(buf, count, NO);
+	break;
+    case AFMT_U16_LE:
+	fifo_send_mono_16le(buf, count, YES);
+	break;
+    case AFMT_S16_BE:
+	fifo_send_mono_16be(buf, count, NO);
+	break;
+    case AFMT_U16_BE:
+	fifo_send_mono_16be(buf, count, YES);
+	break;
+    }
+}
+
+
+static void
+fifo_send_stereo_ulaw(pcm_data *buf, int count)
+{
+    int i;
+    signed char dl, dl0, dl1, dr, dr0, dr1;
+    pcm_data t[2];
+    if (tmpbuf.size > 0)
+	t[0] = ulaw2linear[tmpbuf.buff[0]];
+    else
+	t[0] = ulaw2linear[*buf++];
+    t[1] = ulaw2linear[*buf++];
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	outb(pcm_s.iobase + 12, t[0]);
+	outb(pcm_s.iobase + 12, t[1]);
+	count -= 2;
+	for (i = 0; i < count; i++)
+	    outb(pcm_s.iobase + 12, ulaw2linear[*buf++]);
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	dl0 = pcm_s.last_l;
+	dr0 = pcm_s.last_r;
+	dl1 = t[0];
+	dr1 = t[1];
+	i = 0;
+	count /= 2;
+	while (i < count) {
+	    while (pcm_s.acc >= pcm_s.chipspeed) {
+		pcm_s.acc -= pcm_s.chipspeed;
+		i++;
+		dl0 = dl1;
+		dr0 = dr1;
+		if (i < count) {
+		    dl1 = ulaw2linear[*buf++];
+		    dr1 = ulaw2linear[*buf++];
+		} else
+		    dl1 = dr1 = 0;
+	    }
+	    dl = ((dl0 * (pcm_s.chipspeed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    dr = ((dr0 * (pcm_s.chipspeed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    outb(pcm_s.iobase + 12, dl);
+	    outb(pcm_s.iobase + 12, dr);
+	    pcm_s.acc += pcm_s.speed;
+	}
+
+	pcm_s.last_l = dl0;
+	pcm_s.last_r = dr0;
+    }
+}
+
+
+static void
+fifo_send_stereo_8(pcm_data *buf, int count, int uflag)
+{
+    int i;
+    signed char dl, dl0, dl1, dr, dr0, dr1, zlev;
+    pcm_data t[2];
+
+    zlev = uflag ? -128 : 0;
+
+    if (tmpbuf.size > 0)
+	t[0] = tmpbuf.buff[0] + zlev;
+    else
+	t[0] = *buf++ + zlev;
+    t[1] = *buf++ + zlev;
+
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	outb(pcm_s.iobase + 12, t[0]);
+	outb(pcm_s.iobase + 12, t[1]);
+	count -= 2;
+	for (i = 0; i < count; i++)
+	    outb(pcm_s.iobase + 12, *buf++ + zlev);
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	dl0 = pcm_s.last_l;
+	dr0 = pcm_s.last_r;
+	dl1 = t[0];
+	dr1 = t[1];
+	i = 0;
+	count /= 2;
+	while (i < count) {
+	    while (pcm_s.acc >= pcm_s.chipspeed) {
+		pcm_s.acc -= pcm_s.chipspeed;
+		i++;
+		dl0 = dl1;
+		dr0 = dr1;
+		if (i < count) {
+		    dl1 = *buf++ + zlev;
+		    dr1 = *buf++ + zlev;
+		} else
+		    dl1 = dr1 = 0;
+	    }
+	    dl = ((dl0 * (pcm_s.chipspeed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    dr = ((dr0 * (pcm_s.chipspeed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    outb(pcm_s.iobase + 12, dl);
+	    outb(pcm_s.iobase + 12, dr);
+	    pcm_s.acc += pcm_s.speed;
+	}
+
+	pcm_s.last_l = dl0;
+	pcm_s.last_r = dr0;
+    }
+}
+
+
+static void
+fifo_send_stereo_16le(pcm_data *buf, int count, int uflag)
+{
+    int i;
+    short dl, dl0, dl1, dr, dr0, dr1, zlev;
+    pcm_data t[4];
+
+    zlev = uflag ? -128 : 0;
+
+    for (i = 0; i < 4; i++)
+	t[i] = (tmpbuf.size > i) ? tmpbuf.buff[i] : *buf++;
+
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	outb(pcm_s.iobase + 12, t[1] + zlev);
+	outb(pcm_s.iobase + 12, t[0]);
+	outb(pcm_s.iobase + 12, t[3] + zlev);
+	outb(pcm_s.iobase + 12, t[2]);
+	count = count / 2 - 2;
+	for (i = 0; i < count; i++) {
+	    outb(pcm_s.iobase + 12, *(buf + 1) + zlev);
+	    outb(pcm_s.iobase + 12, *buf);
+	    buf += 2;
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	dl0 = pcm_s.last_l;
+	dr0 = pcm_s.last_r;
+	dl1 = t[0] + ((t[1] + zlev) << 8);
+	dr1 = t[2] + ((t[3] + zlev) << 8);
+	i = 0;
+	count /= 4;
+	while (i < count) {
+	    while (pcm_s.acc >= pcm_s.chipspeed) {
+		pcm_s.acc -= pcm_s.chipspeed;
+		i++;
+		dl0 = dl1;
+		dr0 = dr1;
+		if (i < count) {
+		    dl1 = *buf + ((*(buf + 1) + zlev) << 8);
+		    buf += 2;
+		    dr1 = *buf + ((*(buf + 1) + zlev) << 8);
+		    buf += 2;
+		} else
+		    dl1 = dr1 = 0;
+	    }
+	    dl = ((dl0 * (pcm_s.chipspeed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    dr = ((dr0 * (pcm_s.chipspeed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    outb(pcm_s.iobase + 12, (dl >> 8) & 0xff);
+	    outb(pcm_s.iobase + 12, dl & 0xff);
+	    outb(pcm_s.iobase + 12, (dr >> 8) & 0xff);
+	    outb(pcm_s.iobase + 12, dr & 0xff);
+	    pcm_s.acc += pcm_s.speed;
+	}
+
+	pcm_s.last_l = dl0;
+	pcm_s.last_r = dr0;
+    }
+}
+
+
+static void
+fifo_send_stereo_16be(pcm_data *buf, int count, int uflag)
+{
+    int i;
+    short dl, dl0, dl1, dr, dr0, dr1, zlev;
+    pcm_data t[4];
+
+    zlev = uflag ? -128 : 0;
+
+    for (i = 0; i < 4; i++)
+	t[i] = (tmpbuf.size > i) ? tmpbuf.buff[i] : *buf++;
+
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	outb(pcm_s.iobase + 12, t[0] + zlev);
+	outb(pcm_s.iobase + 12, t[1]);
+	outb(pcm_s.iobase + 12, t[2] + zlev);
+	outb(pcm_s.iobase + 12, t[3]);
+	count = count / 2 - 2;
+	for (i = 0; i < count; i++) {
+	    outb(pcm_s.iobase + 12, *buf + zlev);
+	    outb(pcm_s.iobase + 12, *(buf + 1));
+	    buf += 2;
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	dl0 = pcm_s.last_l;
+	dr0 = pcm_s.last_r;
+	dl1 = ((t[0] + zlev) << 8) + t[1];
+	dr1 = ((t[2] + zlev) << 8) + t[3];
+	i = 0;
+	count /= 4;
+	while (i < count) {
+	    while (pcm_s.acc >= pcm_s.chipspeed) {
+		pcm_s.acc -= pcm_s.chipspeed;
+		i++;
+		dl0 = dl1;
+		dr0 = dr1;
+		if (i < count) {
+		    dl1 = ((*buf + zlev) << 8) + *(buf + 1);
+		    buf += 2;
+		    dr1 = ((*buf + zlev) << 8) + *(buf + 1);
+		    buf += 2;
+		} else
+		    dl1 = dr1 = 0;
+	    }
+	    dl = ((dl0 * (pcm_s.chipspeed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    dr = ((dr0 * (pcm_s.chipspeed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    outb(pcm_s.iobase + 12, (dl >> 8) & 0xff);
+	    outb(pcm_s.iobase + 12, dl & 0xff);
+	    outb(pcm_s.iobase + 12, (dr >> 8) & 0xff);
+	    outb(pcm_s.iobase + 12, dr & 0xff);
+	    pcm_s.acc += pcm_s.speed;
+	}
+
+	pcm_s.last_l = dl0;
+	pcm_s.last_r = dr0;
+    }
+}
+
+
+static void
+fifo_send_mono_ulaw
+(pcm_data *buf, int count)
+{
+    int i;
+    signed char d, d0, d1;
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < count; i++) {
+	    d = ulaw2linear[*buf++];
+	    outb(pcm_s.iobase + 12, d);
+	    outb(pcm_s.iobase + 12, d);
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	d0 = pcm_s.last_l;
+	d1 = ulaw2linear[*buf++];
+	i = 0;
+	while (i < count) {
+	    while (pcm_s.acc >= pcm_s.chipspeed) {
+		pcm_s.acc -= pcm_s.chipspeed;
+		i++;
+		d0 = d1;
+		d1 = (i < count) ? ulaw2linear[*buf++] : 0;
+	    }
+	    d = ((d0 * (pcm_s.chipspeed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    outb(pcm_s.iobase + 12, d);
+	    outb(pcm_s.iobase + 12, d);
+	    pcm_s.acc += pcm_s.speed;
+	}
+
+	pcm_s.last_l = d0;
+    }
+}
+
+
+static void
+fifo_send_mono_8(pcm_data *buf, int count, int uflag)
+{
+    int i;
+    signed char d, d0, d1, zlev;
+
+    zlev = uflag ? -128 : 0;
+
+    if (pcm_s.speed == pcm_s.chipspeed)
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < count; i++) {
+	    d = *buf++ + zlev;
+	    outb(pcm_s.iobase + 12, d);
+	    outb(pcm_s.iobase + 12, d);
+	}
+    else {
+	/* Speed conversion with linear interpolation method. */
+	d0 = pcm_s.last_l;
+	d1 = *buf++ + zlev;
+	i = 0;
+	while (i < count) {
+	    while (pcm_s.acc >= pcm_s.chipspeed) {
+		pcm_s.acc -= pcm_s.chipspeed;
+		i++;
+		d0 = d1;
+		d1 = (i < count) ? *buf++ + zlev : 0;
+	    }
+	    d = ((d0 * (pcm_s.chipspeed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    outb(pcm_s.iobase + 12, d);
+	    outb(pcm_s.iobase + 12, d);
+	    pcm_s.acc += pcm_s.speed;
+	}
+
+	pcm_s.last_l = d0;
+    }
+}
+
+
+static void
+fifo_send_mono_16le(pcm_data *buf, int count, int uflag)
+{
+    int i;
+    short d, d0, d1, zlev;
+    pcm_data t[2];
+
+    zlev = uflag ? -128 : 0;
+
+    for (i = 0; i < 2; i++)
+	t[i] = (tmpbuf.size > i) ? tmpbuf.buff[i] : *buf++;
+
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	outb(pcm_s.iobase + 12, t[1] + zlev);
+	outb(pcm_s.iobase + 12, t[0]);
+	outb(pcm_s.iobase + 12, t[1] + zlev);
+	outb(pcm_s.iobase + 12, t[0]);
+	count = count / 2 - 1;
+	for (i = 0; i < count; i++) {
+	    outb(pcm_s.iobase + 12, *(buf + 1) + zlev);
+	    outb(pcm_s.iobase + 12, *buf);
+	    outb(pcm_s.iobase + 12, *(buf + 1) + zlev);
+	    outb(pcm_s.iobase + 12, *buf);
+	    buf += 2;
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	d0 = pcm_s.last_l;
+	d1 = t[0] + ((t[1] + zlev) << 8);
+	i = 0;
+	count /= 2;
+	while (i < count) {
+	    while (pcm_s.acc >= pcm_s.chipspeed) {
+		pcm_s.acc -= pcm_s.chipspeed;
+		i++;
+		d0 = d1;
+		if (i < count) {
+		    d1 = *buf + ((*(buf + 1) + zlev) << 8);
+		    buf += 2;
+		} else
+		    d1 = 0;
+	    }
+	    d = ((d0 * (pcm_s.chipspeed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+	    outb(pcm_s.iobase + 12, (d >> 8) & 0xff);
+	    outb(pcm_s.iobase + 12, d & 0xff);
+	    outb(pcm_s.iobase + 12, (d >> 8) & 0xff);
+	    outb(pcm_s.iobase + 12, d & 0xff);
+	    pcm_s.acc += pcm_s.speed;
+	}
+
+	pcm_s.last_l = d0;
+    }
+}
+
+
+static void
+fifo_send_mono_16be(pcm_data *buf, int count, int uflag)
+{
+    int i;
+    short d, d0, d1, zlev;
+    pcm_data t[2];
+
+    zlev = uflag ? -128 : 0;
+
+    for (i = 0; i < 2; i++)
+	t[i] = (tmpbuf.size > i) ? tmpbuf.buff[i] : *buf++;
+
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	outb(pcm_s.iobase + 12, t[0] + zlev);
+	outb(pcm_s.iobase + 12, t[1]);
+	outb(pcm_s.iobase + 12, t[0] + zlev);
+	outb(pcm_s.iobase + 12, t[1]);
+	count = count / 2 - 1;
+	for (i = 0; i < count; i++) {
+	    outb(pcm_s.iobase + 12, *buf + zlev);
+	    outb(pcm_s.iobase + 12, *(buf + 1));
+	    outb(pcm_s.iobase + 12, *buf + zlev);
+	    outb(pcm_s.iobase + 12, *(buf + 1));
+	    buf += 2;
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	d0 = pcm_s.last_l;
+	d1 = ((t[0] + zlev) << 8) + t[1];
+	i = 0;
+	count /= 2;
+	while (i < count) {
+	    while (pcm_s.acc >= pcm_s.chipspeed) {
+		pcm_s.acc -= pcm_s.chipspeed;
+		i++;
+		d0 = d1;
+		if (i < count) {
+		    d1 = ((*buf + zlev) << 8) + *(buf + 1);
+		    buf += 2;
+		} else
+		    d1 = 0;
+	    }
+	    d = ((d0 * (pcm_s.chipspeed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.chipspeed;
+/*	    outb(pcm_s.iobase + 12, d & 0xff);
+	    outb(pcm_s.iobase + 12, (d >> 8) & 0xff);
+	    outb(pcm_s.iobase + 12, d & 0xff);
+	    outb(pcm_s.iobase + 12, (d >> 8) & 0xff); */
+	    outb(pcm_s.iobase + 12, (d >> 8) & 0xff);
+	    outb(pcm_s.iobase + 12, d & 0xff);
+	    outb(pcm_s.iobase + 12, (d >> 8) & 0xff);
+	    outb(pcm_s.iobase + 12, d & 0xff);
+	    pcm_s.acc += pcm_s.speed;
+	}
+
+	pcm_s.last_l = d0;
+    }
+}
+
+
+static void
+fifo_input_block(void)
+{
+    int chunksize;
+
+    if (pcm_s.pdma_chunkcount) {
+	/* Update chunksize and then receive the next chunk from FIFO. */
+	chunksize = pcm_s.pdma_count / pcm_s.pdma_chunkcount--;
+	fifo_recv(pcm_s.pdma_buf, chunksize);
+	pcm_s.pdma_buf += chunksize;
+	pcm_s.pdma_count -= chunksize;
+    } else
+	/* ??? something wrong... */
+	printf("nss0: chunkcount overrun\n");
+}
+
+
+static void
+fifo_recv(pcm_data *buf, int count)
+{
+    int i;
+
+    if (count > tmpbuf.size) {
+	for (i = 0; i < tmpbuf.size; i++)
+	    *buf++ = tmpbuf.buff[i];
+	count -= tmpbuf.size;
+	tmpbuf.size = 0;
+	if (pcm_s.stereo)
+	    fifo_recv_stereo(buf, count);
+	else
+	    fifo_recv_monoral(buf, count);
+    } else {
+	for (i = 0; i < count; i++)
+	    *buf++ = tmpbuf.buff[i];
+	for (i = 0; i < tmpbuf.size - count; i++)
+	    tmpbuf.buff[i] = tmpbuf.buff[i + count];
+	tmpbuf.size -= count;
+    }
+
+#ifdef NSS_DEBUG
+    printf("fifo_recv(): %d bytes received\n",
+	   ((count / (pcm_s.bytes << pcm_s.stereo)) * pcm_s.chipspeed
+	    / pcm_s.speed) * pcm_s.bytes * 2);
+#endif
+}
+
+
+static void
+fifo_recv_stereo(pcm_data *buf, int count)
+{
+    /* Convert format and sampling speed. */
+    switch (pcm_s.format) {
+    case AFMT_MU_LAW:
+	fifo_recv_stereo_ulaw(buf, count);
+	break;
+    case AFMT_S8:
+	fifo_recv_stereo_8(buf, count, NO);
+	break;
+    case AFMT_U8:
+	fifo_recv_stereo_8(buf, count, YES);
+	break;
+    case AFMT_S16_LE:
+	fifo_recv_stereo_16le(buf, count, NO);
+	break;
+    case AFMT_U16_LE:
+	fifo_recv_stereo_16le(buf, count, YES);
+	break;
+    case AFMT_S16_BE:
+	fifo_recv_stereo_16be(buf, count, NO);
+	break;
+    case AFMT_U16_BE:
+	fifo_recv_stereo_16be(buf, count, YES);
+	break;
+    }
+}
+
+
+static void
+fifo_recv_monoral(pcm_data *buf, int count)
+{
+    /* Convert format and sampling speed. */
+    switch (pcm_s.format) {
+    case AFMT_MU_LAW:
+	fifo_recv_mono_ulaw(buf, count);
+	break;
+    case AFMT_S8:
+	fifo_recv_mono_8(buf, count, NO);
+	break;
+    case AFMT_U8:
+	fifo_recv_mono_8(buf, count, YES);
+	break;
+    case AFMT_S16_LE:
+	fifo_recv_mono_16le(buf, count, NO);
+	break;
+    case AFMT_U16_LE:
+	fifo_recv_mono_16le(buf, count, YES);
+	break;
+    case AFMT_S16_BE:
+	fifo_recv_mono_16be(buf, count, NO);
+	break;
+    case AFMT_U16_BE:
+	fifo_recv_mono_16be(buf, count, YES);
+	break;
+    }
+}
+
+
+static void
+fifo_recv_stereo_ulaw(pcm_data *buf, int count)
+{
+    int i, cnt;
+    signed char dl, dl0, dl1, dr, dr0, dr1;
+
+    cnt = count / 2;
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < cnt; i++) {
+	    *buf++ = linear2ulaw[inb(pcm_s.iobase + 12)];
+	    *buf++ = linear2ulaw[inb(pcm_s.iobase + 12)];
+	}
+	if (count % 2) {
+	    *buf++ = linear2ulaw[inb(pcm_s.iobase + 12)];
+	    tmpbuf.buff[0] = linear2ulaw[inb(pcm_s.iobase + 12)];
+	    tmpbuf.size = 1;
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	dl0 = pcm_s.last_l;
+	dr0 = pcm_s.last_r;
+	dl1 = inb(pcm_s.iobase + 12);
+	dr1 = inb(pcm_s.iobase + 12);
+	for (i = 0; i < cnt; i++) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		dl0 = dl1;
+		dr0 = dr1;
+		dl1 = inb(pcm_s.iobase + 12);
+		dr1 = inb(pcm_s.iobase + 12);
+	    }
+	    dl = ((dl0 * (pcm_s.speed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    dr = ((dr0 * (pcm_s.speed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = linear2ulaw[dl & 0xff];
+	    *buf++ = linear2ulaw[dr & 0xff];
+	    pcm_s.acc += pcm_s.chipspeed;
+	}
+	if (count % 2) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		dl0 = dl1;
+		dr0 = dr1;
+		dl1 = inb(pcm_s.iobase + 12);
+		dr1 = inb(pcm_s.iobase + 12);
+	    }
+	    dl = ((dl0 * (pcm_s.speed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    dr = ((dr0 * (pcm_s.speed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = linear2ulaw[dl & 0xff];
+	    tmpbuf.buff[0] = linear2ulaw[dr & 0xff];
+	    tmpbuf.size = 1;
+	}
+
+	pcm_s.last_l = dl0;
+	pcm_s.last_r = dr0;
+    }
+}
+
+
+static void
+fifo_recv_stereo_8(pcm_data *buf, int count, int uflag)
+{
+    int i, cnt;
+    signed char dl, dl0, dl1, dr, dr0, dr1, zlev;
+
+    zlev = uflag ? -128 : 0;
+
+    cnt = count / 2;
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < cnt; i++) {
+	    *buf++ = inb(pcm_s.iobase + 12) + zlev;
+	    *buf++ = inb(pcm_s.iobase + 12) + zlev;
+	}
+	if (count % 2) {
+	    *buf++ = inb(pcm_s.iobase + 12) + zlev;
+	    tmpbuf.buff[0] = inb(pcm_s.iobase + 12) + zlev;
+	    tmpbuf.size = 1;
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	dl0 = pcm_s.last_l;
+	dr0 = pcm_s.last_r;
+	dl1 = inb(pcm_s.iobase + 12);
+	dr1 = inb(pcm_s.iobase + 12);
+	for (i = 0; i < cnt; i++) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		dl0 = dl1;
+		dr0 = dr1;
+		dl1 = inb(pcm_s.iobase + 12);
+		dr1 = inb(pcm_s.iobase + 12);
+	    }
+	    dl = ((dl0 * (pcm_s.speed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    dr = ((dr0 * (pcm_s.speed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = dl + zlev;
+	    *buf++ = dr + zlev;
+	    pcm_s.acc += pcm_s.chipspeed;
+	}
+	if (count % 2) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		dl0 = dl1;
+		dr0 = dr1;
+		dl1 = inb(pcm_s.iobase + 12);
+		dr1 = inb(pcm_s.iobase + 12);
+	    }
+	    dl = ((dl0 * (pcm_s.speed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    dr = ((dr0 * (pcm_s.speed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = dl + zlev;
+	    tmpbuf.buff[0] = dr + zlev;
+	    tmpbuf.size = 1;
+	}
+
+	pcm_s.last_l = dl0;
+	pcm_s.last_r = dr0;
+    }
+}
+
+
+static void
+fifo_recv_stereo_16le(pcm_data *buf, int count, int uflag)
+{
+    int i, cnt;
+    short dl, dl0, dl1, dr, dr0, dr1, zlev;
+    pcm_data t[4];
+
+    zlev = uflag ? -128 : 0;
+
+    cnt = count / 4;
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < cnt; i++) {
+	    *(buf + 1) = inb(pcm_s.iobase + 12) + zlev;
+	    *buf = inb(pcm_s.iobase + 12);
+	    *(buf + 3) = inb(pcm_s.iobase + 12) + zlev;
+	    *(buf + 2) = inb(pcm_s.iobase + 12);
+	    buf += 4;
+	}
+	if (count % 4) {
+	    t[1] = inb(pcm_s.iobase + 12) + zlev;
+	    t[0] = inb(pcm_s.iobase + 12);
+	    t[3] = inb(pcm_s.iobase + 12) + zlev;
+	    t[2] = inb(pcm_s.iobase + 12);
+	    tmpbuf.size = 0;
+	    for (i = 0; i < count % 4; i++)
+		*buf++ = t[i];
+	    for (i = count % 4; i < 4; i++)
+		tmpbuf.buff[tmpbuf.size++] = t[i];
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	dl0 = pcm_s.last_l;
+	dr0 = pcm_s.last_r;
+	dl1 = inb(pcm_s.iobase + 12) << 8;
+	dl1 |= inb(pcm_s.iobase + 12);
+	dr1 = inb(pcm_s.iobase + 12) << 8;
+	dr1 |= inb(pcm_s.iobase + 12);
+	for (i = 0; i < cnt; i++) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		dl0 = dl1;
+		dr0 = dr1;
+		dl1 = inb(pcm_s.iobase + 12) << 8;
+		dl1 |= inb(pcm_s.iobase + 12);
+		dr1 = inb(pcm_s.iobase + 12) << 8;
+		dr1 |= inb(pcm_s.iobase + 12);
+	    }
+	    dl = ((dl0 * (pcm_s.speed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    dr = ((dr0 * (pcm_s.speed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = dl & 0xff;
+	    *buf++ = ((dl >> 8) & 0xff) + zlev;
+	    *buf++ = dr & 0xff;
+	    *buf++ = ((dr >> 8) & 0xff) + zlev;
+	    pcm_s.acc += pcm_s.chipspeed;
+	}
+	if (count % 4) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		dl0 = dl1;
+		dr0 = dr1;
+		dl1 = inb(pcm_s.iobase + 12) << 8;
+		dl1 |= inb(pcm_s.iobase + 12);
+		dr1 = inb(pcm_s.iobase + 12) << 8;
+		dr1 |= inb(pcm_s.iobase + 12);
+	    }
+	    dl = ((dl0 * (pcm_s.speed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    dr = ((dr0 * (pcm_s.speed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    t[0] = dl & 0xff;
+	    t[1] = ((dl >> 8) & 0xff) + zlev;
+	    t[2] = dr & 0xff;
+	    t[3] = ((dr >> 8) & 0xff) + zlev;
+	    tmpbuf.size = 0;
+	    for (i = 0; i < count % 4; i++)
+		*buf++ = t[i];
+	    for (i = count % 4; i < 4; i++)
+		tmpbuf.buff[tmpbuf.size++] = t[i];
+	}
+
+	pcm_s.last_l = dl0;
+	pcm_s.last_r = dr0;
+    }
+}
+
+
+static void
+fifo_recv_stereo_16be(pcm_data *buf, int count, int uflag)
+{
+    int i, cnt;
+    short dl, dl0, dl1, dr, dr0, dr1, zlev;
+    pcm_data t[4];
+
+    zlev = uflag ? -128 : 0;
+
+    cnt = count / 4;
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < cnt; i++) {
+	    *buf++ = inb(pcm_s.iobase + 12) + zlev;
+	    *buf++ = inb(pcm_s.iobase + 12);
+	    *buf++ = inb(pcm_s.iobase + 12) + zlev;
+	    *buf++ = inb(pcm_s.iobase + 12);
+	}
+	if (count % 4) {
+	    t[0] = inb(pcm_s.iobase + 12) + zlev;
+	    t[1] = inb(pcm_s.iobase + 12);
+	    t[2] = inb(pcm_s.iobase + 12) + zlev;
+	    t[3] = inb(pcm_s.iobase + 12);
+	    tmpbuf.size = 0;
+	    for (i = 0; i < count % 4; i++)
+		*buf++ = t[i];
+	    for (i = count % 4; i < 4; i++)
+		tmpbuf.buff[tmpbuf.size++] = t[i];
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	dl0 = pcm_s.last_l;
+	dr0 = pcm_s.last_r;
+	dl1 = inb(pcm_s.iobase + 12) << 8;
+	dl1 |= inb(pcm_s.iobase + 12);
+	dr1 = inb(pcm_s.iobase + 12) << 8;
+	dr1 |= inb(pcm_s.iobase + 12);
+	for (i = 0; i < cnt; i++) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		dl0 = dl1;
+		dr0 = dr1;
+		dl1 = inb(pcm_s.iobase + 12) << 8;
+		dl1 |= inb(pcm_s.iobase + 12);
+		dr1 = inb(pcm_s.iobase + 12) << 8;
+		dr1 |= inb(pcm_s.iobase + 12);
+	    }
+	    dl = ((dl0 * (pcm_s.speed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    dr = ((dr0 * (pcm_s.speed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = ((dl >> 8) & 0xff) + zlev;
+	    *buf++ = dl & 0xff;
+	    *buf++ = ((dr >> 8) & 0xff) + zlev;
+	    *buf++ = dr & 0xff;
+	    pcm_s.acc += pcm_s.chipspeed;
+	}
+	if (count % 4) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		dl0 = dl1;
+		dr0 = dr1;
+		dl1 = inb(pcm_s.iobase + 12) << 8;
+		dl1 |= inb(pcm_s.iobase + 12);
+		dr1 = inb(pcm_s.iobase + 12) << 8;
+		dr1 |= inb(pcm_s.iobase + 12);
+	    }
+	    dl = ((dl0 * (pcm_s.speed - pcm_s.acc)) + (dl1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    dr = ((dr0 * (pcm_s.speed - pcm_s.acc)) + (dr1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    t[0] = ((dl >> 8) & 0xff) + zlev;
+	    t[1] = dl & 0xff;
+	    t[2] = ((dr >> 8) & 0xff) + zlev;
+	    t[3] = dr & 0xff;
+	    tmpbuf.size = 0;
+	    for (i = 0; i < count % 4; i++)
+		*buf++ = t[i];
+	    for (i = count % 4; i < 4; i++)
+		tmpbuf.buff[tmpbuf.size++] = t[i];
+	}
+
+	pcm_s.last_l = dl0;
+	pcm_s.last_r = dr0;
+    }
+}
+
+
+static void
+fifo_recv_mono_ulaw(pcm_data *buf, int count)
+{
+    int i;
+    signed char d, d0, d1;
+
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < count; i++) {
+	    d = ((signed char)inb(pcm_s.iobase + 12)
+		 + (signed char)inb(pcm_s.iobase + 12)) >> 1;
+	    *buf++ = linear2ulaw[d & 0xff];
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	d0 = pcm_s.last_l;
+	d1 = ((signed char)inb(pcm_s.iobase + 12)
+	      + (signed char)inb(pcm_s.iobase + 12)) >> 1;
+	for (i = 0; i < count; i++) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		d0 = d1;
+		d1 = ((signed char)inb(pcm_s.iobase + 12)
+		      + (signed char)inb(pcm_s.iobase + 12)) >> 1;
+	    }
+	    d = ((d0 * (pcm_s.speed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = linear2ulaw[d & 0xff];
+	    pcm_s.acc += pcm_s.chipspeed;
+	}
+
+	pcm_s.last_l = d0;
+    }
+}
+
+
+static void
+fifo_recv_mono_8(pcm_data *buf, int count, int uflag)
+{
+    int i;
+    signed char d, d0, d1, zlev;
+
+    zlev = uflag ? -128 : 0;
+
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < count; i++) {
+	    d = ((signed char)inb(pcm_s.iobase + 12)
+		 + (signed char)inb(pcm_s.iobase + 12)) >> 1;
+	    *buf++ = d + zlev;
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	d0 = pcm_s.last_l;
+	d1 = ((signed char)inb(pcm_s.iobase + 12)
+	      + (signed char)inb(pcm_s.iobase + 12)) >> 1;
+	for (i = 0; i < count; i++) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		d0 = d1;
+		d1 = ((signed char)inb(pcm_s.iobase + 12)
+		      + (signed char)inb(pcm_s.iobase + 12)) >> 1;
+	    }
+	    d = ((d0 * (pcm_s.speed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = d + zlev;
+	    pcm_s.acc += pcm_s.chipspeed;
+	}
+
+	pcm_s.last_l = d0;
+    }
+}
+
+
+static void
+fifo_recv_mono_16le(pcm_data *buf, int count, int uflag)
+{
+    int i, cnt;
+    short d, d0, d1, el, er, zlev;
+
+    zlev = uflag ? -128 : 0;
+
+    cnt = count / 2;
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < cnt; i++) {
+	    el = inb(pcm_s.iobase + 12) << 8;
+	    el |= inb(pcm_s.iobase + 12);
+	    er = inb(pcm_s.iobase + 12) << 8;
+	    er |= inb(pcm_s.iobase + 12);
+	    d = (el + er) >> 1;
+	    *buf++ = d & 0xff;
+	    *buf++ = ((d >> 8) & 0xff) + zlev;
+	}
+	if (count % 2) {
+	    el = inb(pcm_s.iobase + 12) << 8;
+	    el |= inb(pcm_s.iobase + 12);
+	    er = inb(pcm_s.iobase + 12) << 8;
+	    er |= inb(pcm_s.iobase + 12);
+	    d = (el + er) >> 1;
+	    *buf++ = d & 0xff;
+	    tmpbuf.buff[0] = ((d >> 8) & 0xff) + zlev;
+	    tmpbuf.size = 1;
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	d0 = pcm_s.last_l;
+	el = inb(pcm_s.iobase + 12) << 8;
+	el |= inb(pcm_s.iobase + 12);
+	er = inb(pcm_s.iobase + 12) << 8;
+	er |= inb(pcm_s.iobase + 12);
+	d1 = (el + er) >> 1;
+	for (i = 0; i < cnt; i++) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		d0 = d1;
+		el = inb(pcm_s.iobase + 12) << 8;
+		el |= inb(pcm_s.iobase + 12);
+		er = inb(pcm_s.iobase + 12) << 8;
+		er |= inb(pcm_s.iobase + 12);
+		d1 = (el + er) >> 1;
+	    }
+	    d = ((d0 * (pcm_s.speed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = d & 0xff;
+	    *buf++ = ((d >> 8) & 0xff) + zlev;
+	    pcm_s.acc += pcm_s.chipspeed;
+	}
+	if (count % 2) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		d0 = d1;
+		el = inb(pcm_s.iobase + 12) << 8;
+		el |= inb(pcm_s.iobase + 12);
+		er = inb(pcm_s.iobase + 12) << 8;
+		er |= inb(pcm_s.iobase + 12);
+		d1 = (el + er) >> 1;
+	    }
+	    d = ((d0 * (pcm_s.speed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = d & 0xff;
+	    tmpbuf.buff[0] = ((d >> 8) & 0xff) + zlev;
+	    tmpbuf.size = 1;
+	}
+
+	pcm_s.last_l = d0;
+    }
+}
+
+
+static void
+fifo_recv_mono_16be(pcm_data *buf, int count, int uflag)
+{
+    int i, cnt;
+    short d, d0, d1, el, er, zlev;
+
+    zlev = uflag ? -128 : 0;
+
+    cnt = count / 2;
+    if (pcm_s.speed == pcm_s.chipspeed) {
+	/* No reason to convert the pcm speed. */
+	for (i = 0; i < cnt; i++) {
+	    el = inb(pcm_s.iobase + 12) << 8;
+	    el |= inb(pcm_s.iobase + 12);
+	    er = inb(pcm_s.iobase + 12) << 8;
+	    er |= inb(pcm_s.iobase + 12);
+	    d = (el + er) >> 1;
+	    *buf++ = ((d >> 8) & 0xff) + zlev;
+	    *buf++ = d & 0xff;
+	}
+	if (count % 2) {
+	    el = inb(pcm_s.iobase + 12) << 8;
+	    el |= inb(pcm_s.iobase + 12);
+	    er = inb(pcm_s.iobase + 12) << 8;
+	    er |= inb(pcm_s.iobase + 12);
+	    d = (el + er) >> 1;
+	    *buf++ = ((d >> 8) & 0xff) + zlev;
+	    tmpbuf.buff[0] = d & 0xff;
+	    tmpbuf.size = 1;
+	}
+    } else {
+	/* Speed conversion with linear interpolation method. */
+	d0 = pcm_s.last_l;
+	el = inb(pcm_s.iobase + 12) << 8;
+	el |= inb(pcm_s.iobase + 12);
+	er = inb(pcm_s.iobase + 12) << 8;
+	er |= inb(pcm_s.iobase + 12);
+	d1 = (el + er) >> 1;
+	for (i = 0; i < cnt; i++) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		d0 = d1;
+		el = inb(pcm_s.iobase + 12) << 8;
+		el |= inb(pcm_s.iobase + 12);
+		er = inb(pcm_s.iobase + 12) << 8;
+		er |= inb(pcm_s.iobase + 12);
+		d1 = (el + er) >> 1;
+	    }
+	    d = ((d0 * (pcm_s.speed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = ((d >> 8) & 0xff) + zlev;
+	    *buf++ = d & 0xff;
+	    pcm_s.acc += pcm_s.chipspeed;
+	}
+	if (count % 2) {
+	    while (pcm_s.acc >= pcm_s.speed) {
+		pcm_s.acc -= pcm_s.speed;
+		d0 = d1;
+		el = inb(pcm_s.iobase + 12) << 8;
+		el |= inb(pcm_s.iobase + 12);
+		er = inb(pcm_s.iobase + 12) << 8;
+		er |= inb(pcm_s.iobase + 12);
+		d1 = (el + er) >> 1;
+	    }
+	    d = ((d0 * (pcm_s.speed - pcm_s.acc)) + (d1 * pcm_s.acc))
+		/ pcm_s.speed;
+	    *buf++ = ((d >> 8) & 0xff) + zlev;
+	    tmpbuf.buff[0] = d & 0xff;
+	    tmpbuf.size = 1;
+	}
+
+	pcm_s.last_l = d0;
+    }
+}
+
+
+static void
+nss_stop(void)
+{
+    fifo_stop();		/* stop FIFO */
+    fifo_reset();		/* reset FIFO buffer */
+    /* Reset driver's status. */
+    pcm_s.intr_busy = NO;
+    pcm_s.intr_last = NO;
+    pcm_s.intr_trailer = NO;
+    pcm_s.acc = 0;
+    pcm_s.last_l = 0;
+    pcm_s.last_r = 0;
+
+    DEB(printf("nss_stop\n"));
+}
+
+
+static void
+nss_init(void)
+{
+    /* Initialize registers on the board. */
+    nss_stop();
+    if (pcm_s.board_type == PC980173_FAMILY)
+	dsp73_init();
+
+    /* Set default volume. */
+    set_volume(DEFAULT_VOLUME);
+
+    /* Initialize driver's status. */
+    pcm_s.opened = NO;
+    nss_initialized = YES;
+}
+
+
+/*
+ * Codes for global use
+ */
+
+int
+probe_nss(struct address_info *hw_config)
+{
+	return nss_detect(hw_config);
+}
+
+void
+attach_nss(struct address_info *hw_config, struct module *owner)
+{
+    if (pcm_s.board_type == NO_SUPPORTED_BOARD)
+	return ;
+
+#ifdef __linux__
+    request_region(hw_config->io_base, 12, "PC-9801-86 PCM");
+#endif
+
+    /* Initialize the board. */
+    nss_init();
+
+    conf_printf(nss_operations.name, hw_config);
+
+    if (num_audiodevs < MAX_AUDIO_DEV) {
+#ifndef __linux__
+	my_dev = num_audiodevs++;
+	audio_devs[my_dev] = &nss_operations;
+	/*	audio_devs[my_dev]->buffcount = DSP_BUFFCOUNT; */
+	audio_devs[my_dev]->buffsize = DSP_BUFFSIZE;
+#else /* __linux__ */
+	my_dev = sound_install_audiodrv(AUDIO_DRIVER_VERSION,
+					nss_operations.name,
+					&nss_audio_driver,
+					sizeof(struct audio_driver),
+					NSS_AUDIO_FLAGS,
+					NSS_AUDIO_FORMAT_MASK,
+					NULL,
+					hw_config->dma,
+					hw_config->dma2);
+	if (my_dev < 0)
+		return;
+	audio_devs[my_dev]->mixer_dev = -1;
+	audio_devs[my_dev]->min_fragment = 15; /* not too small value */
+	if (owner)
+		audio_devs[my_dev]->d->owner = owner;
+#endif /* __linux__ */
+#ifdef NSS_DEBUG
+	printf("\nbuffsize = %d", DSP_BUFFSIZE);
+#endif
+    } else
+	printf("nss0: Too many PCM devices available");
+
+#ifdef __linux__
+    {
+	int e;
+
+	if ((e = sound_install_mixer(MIXER_DRIVER_VERSION,
+				     nss_operations.name,
+				     &nss_mixer_operations,
+				     sizeof(struct mixer_operations),
+				     NULL)) >= 0)
+	{
+		audio_devs[my_dev]->mixer_dev = e;
+		if (owner)
+			mixer_devs[e]->owner = owner;
+	}
+    }
+#endif
+
+    return ;
+}
+
+
+static int
+nss_detect(struct address_info *hw_config)
+{
+    int opna_iobase = 0x188, irq = 12, i;
+    unsigned char tmp;
+
+#ifdef __linux__
+    if (check_region(hw_config->io_base, 12)) {
+        printk(KERN_ERR "nss0: Port %x not free.\n", hw_config->io_base);
+	return NO;
+    }
+#endif
+
+    if (hw_config->io_base == -1) {
+	printf("nss0: iobase not specified. Assume default port(0x%x)\n",
+	       PCM86_IOBASE);
+	hw_config->io_base = PCM86_IOBASE;
+    }
+    pcm_s.iobase = hw_config->io_base;
+
+    /* auto configuration */
+    tmp = (inb(pcm_s.iobase) & 0xf0) >> 4;
+    if (tmp == 0x07) {
+      /* 
+       * Remap MATE-X PCM Sound ID register (0xA460 -> 0xB460)
+       * to avoid corrision with 86 Sound System.
+       */
+      /*
+      printf("nss0: Found MATE-X PCM Sound ID\n");
+      printf("nss0: Remaped 0xa460 to 0xb460\n");
+       */
+      outb(0xc24, 0xe1);
+      outb(0xc2b, 0x60);
+      outb(0xc2d, 0xb4);
+    }
+
+    tmp = inb(pcm_s.iobase) & 0xfc;
+    switch ((tmp & 0xf0) >> 4) {
+    case 2:
+	opna_iobase = 0x188;
+	pcm_s.board_type = PC980173_FAMILY;
+	break;
+    case 3:
+	opna_iobase = 0x288;
+	pcm_s.board_type = PC980173_FAMILY;
+	break;
+    case 4:
+	opna_iobase = 0x188;
+	pcm_s.board_type = PC980186_FAMILY;
+	break;
+    case 5:
+	opna_iobase = 0x288;
+	pcm_s.board_type = PC980186_FAMILY;
+	break;
+    default:
+	pcm_s.board_type = NO_SUPPORTED_BOARD;
+#ifdef __linux__
+	DEB(printk(KERN_INFO "nss0: NO_SUPPORTED_BOARD\n"));
+#endif
+	return NO;
+    }
+
+    /* Enable OPNA(YM2608) facilities. */
+    outb(pcm_s.iobase, tmp | 0x01);
+
+    /* Wait for OPNA to be ready. */
+    i = 100000;		/* Some large value */
+    while((inb(opna_iobase) & 0x80) && (i-- > 0));
+
+    /* Make IOA/IOB port ready (IOA:input, IOB:output) */
+    outb(opna_iobase, 0x07);
+    outb(0x5f, 0);	/* Because OPNA ports are comparatively slow(?), */
+    outb(0x5f, 0);	/* we'd better wait a moment. */
+    outb(0x5f, 0);
+    outb(0x5f, 0);
+    tmp = inb(opna_iobase + 2) & 0x3f;
+    outb(opna_iobase + 2, tmp | 0x80);
+
+    /* Wait for OPNA to be ready. */
+    i = 100000;		/* Some large value */
+    while((inb(opna_iobase) & 0x80) && (i-- > 0));
+
+    /* Get irq number from IOA port. */
+    outb(opna_iobase, 0x0e);
+    outb(0x5f, 0);
+    outb(0x5f, 0);
+    outb(0x5f, 0);
+    outb(0x5f, 0);
+    tmp = inb(opna_iobase + 2) & 0xc0;
+    switch (tmp >> 6) {
+    case 0:	/* INT0 (IRQ3)*/
+	irq = 3;
+	break;
+    case 1:	/* INT6 (IRQ13)*/
+	irq = 13;
+	break;
+    case 2:	/* INT4 (IRQ10)*/
+	irq = 10;
+	break;
+    case 3:	/* INT5 (IRQ12)*/
+	irq = 12;
+	break;
+    default:	/* error */
+#ifdef __linux__
+       	DEB(printk(KERN_INFO "nss0: Can't get valid IRQ number\n"));
+#endif
+	return NO;
+    }
+
+    /* Wait for OPNA to be ready. */
+    i = 100000;		/* Some large value */
+    while((inb(opna_iobase) & 0x80) && (i-- > 0));
+
+    /* Reset OPNA timer register. */
+    outb(opna_iobase, 0x27);
+    outb(0x5f, 0);
+    outb(0x5f, 0);
+    outb(0x5f, 0);
+    outb(0x5f, 0);
+    outb(opna_iobase + 2, 0x30);
+
+    /* Ok.  Detection finished. */
+
+#ifndef __linux__
+    snprintf(nss_operations.name, sizeof(nss_operations.name),
+	"%s", board_name[pcm_s.board_type]);
+#else
+    sprintf(nss_operations.name, "%s", board_name[pcm_s.board_type]);
+#endif
+    nss_initialized = NO;
+    pcm_s.irq = irq;
+
+    if ((hw_config->irq > 0) && (hw_config->irq != irq))
+	printf("nss0: change irq %d -> %d\n", hw_config->irq, irq);
+    hw_config->irq = irq;
+#ifdef __linux__
+	hw_config->dma = hw_config->dma2 = -1;
+	printf("nss0: unset dma channel(-1)\n");
+#endif
+
+    pcm_s.osp = hw_config->osp;
+
+    return YES;
+}
+
+
+static int
+nss_open(int dev, int mode)
+{
+    int err;
+
+    if (!nss_initialized)
+	return -(ENXIO);
+
+    if (pcm_s.intr_busy || pcm_s.opened)
+	return -(EBUSY);
+
+#ifndef __linux__
+    if ((err = snd_set_irq_handler(pcm_s.irq, nssintr, pcm_s.osp)) < 0)
+	return err;
+#else
+    if ((err = request_irq(pcm_s.irq, nssintr, 0, nss_operations.name,
+			   (void *)my_dev)) < 0)
+	return err;
+#endif
+
+    nss_stop();
+    tmpbuf.size = 0;
+    pcm_s.intr_mode = IMODE_NONE;
+    pcm_s.opened = YES;
+
+    return 0;
+}
+
+
+static void
+nss_close(int dev)
+{
+#ifndef __linux__
+  /* snd_release_irq(pcm_s.irq); */
+#else
+    free_irq(pcm_s.irq, (void *)my_dev);
+#endif
+
+    pcm_s.opened = NO;
+}
+
+
+#ifndef __linux__
+static void
+nss_output_block(int dev, unsigned long buf, int count, int intrflag, int dma_restart)
+#else
+static void
+nss_output_block(int dev, unsigned long buf, int count, int intrflag)
+#endif /* __linux__ */
+{
+#if 0
+    unsigned long flags, cnt;
+#endif
+    int maxchunksize;
+
+#ifdef NSS_DEBUG
+    printf("nss_output_block():");
+    if (audio_devs[dev]->dmap_out->flags & DMA_BUSY)
+	printf(" DMA_BUSY");
+    if (audio_devs[dev]->dmap_out->flags & DMA_RESTART)
+	printf(" DMA_RESTART");
+    if (audio_devs[dev]->dmap_out->flags & DMA_ACTIVE)
+	printf(" DMA_ACTIVE");
+    if (audio_devs[dev]->dmap_out->flags & DMA_STARTED)
+	printf(" DMA_STARTED");
+    if (audio_devs[dev]->dmap_out->flags & DMA_ALLOC_DONE)
+	printf(" DMA_ALLOC_DONE");
+    printf("\n");
+#endif
+
+#if 0
+    DISABLE_INTR(flags);
+#endif
+
+#ifdef NSS_DEBUG
+    printf("nss_output_block(): count = %d, intrsize= %d\n",
+	   count, pcm_s.intr_size);
+#endif
+#ifdef __linux__
+    pcm_s.pdma_buf = bus_to_virt(buf);
+#endif
+    pcm_s.pdma_count = count;
+    pcm_s.pdma_chunkcount = 1;
+    maxchunksize = (((PCM86_FIFOSIZE - pcm_s.intr_size * 2)
+		     / (pcm_s.bytes * 2)) * pcm_s.speed
+		    / pcm_s.chipspeed) * (pcm_s.bytes << pcm_s.stereo);
+    if (count > maxchunksize)
+	pcm_s.pdma_chunkcount = 2 * count / maxchunksize;
+    /*
+     * Let chunksize = (float)count / (float)pcm_s.pdma_chunkcount.
+     * Data of size chunksize is sent to the FIFO buffer on the 86-board
+     * on every occuring of interrupt.
+     * By assuming that pcm_s.intr_size < PCM86_FIFOSIZE / 2, we can conclude
+     * that the FIFO buffer never overflows from the following lemma.
+     *
+     * Lemma:
+     *	     maxchunksize / 2 <= chunksize <= maxchunksize.
+     *   (Though pcm_s.pdma_chunkcount is obtained through the flooring
+     *    function, this inequality holds.)
+     * Proof) Omitted.
+     */
+    fifo_output_block();
+    pcm_s.intr_last = NO;
+    pcm_s.intr_mode = IMODE_OUTPUT;
+    if (!pcm_s.intr_busy)
+	fifo_start(IMODE_OUTPUT);
+    pcm_s.intr_busy = YES;
+
+#if 0
+    RESTORE_INTR(flags);
+#endif
+}
+
+
+#ifndef __linux__
+static void
+nss_start_input(int dev, unsigned long buf, int count, int intrflag, int dma_restart)
+#else
+static void
+nss_start_input(int dev, unsigned long buf, int count, int intrflag)
+#endif
+{
+#if 0
+    unsigned long flags, cnt;
+#endif
+    int maxchunksize;
+
+#ifdef NSS_DEBUG
+    printf("nss_start_input():");
+    if (audio_devs[dev]->dmap_in->flags & DMA_BUSY)
+	printf(" DMA_BUSY");
+    if (audio_devs[dev]->dmap_in->flags & DMA_RESTART)
+	printf(" DMA_RESTART");
+    if (audio_devs[dev]->dmap_in->flags & DMA_ACTIVE)
+	printf(" DMA_ACTIVE");
+    if (audio_devs[dev]->dmap_in->flags & DMA_STARTED)
+	printf(" DMA_STARTED");
+    if (audio_devs[dev]->dmap_in->flags & DMA_ALLOC_DONE)
+	printf(" DMA_ALLOC_DONE");
+    printf("\n");
+#endif
+
+#if 0
+    DISABLE_INTR(flags);
+#endif
+
+    pcm_s.intr_size = PCM86_INTRSIZE_IN;
+
+#ifdef NSS_DEBUG
+    printf("nss_start_input(): count = %d, intrsize= %d\n",
+	   count, pcm_s.intr_size);
+#endif
+#ifdef __linux__
+    pcm_s.pdma_buf = bus_to_virt(buf);
+#endif
+    pcm_s.pdma_count = count;
+    pcm_s.pdma_chunkcount = 1;
+    maxchunksize = ((pcm_s.intr_size / (pcm_s.bytes * 2)) * pcm_s.speed
+		    / pcm_s.chipspeed) * (pcm_s.bytes << pcm_s.stereo);
+    if (count > maxchunksize)
+	pcm_s.pdma_chunkcount = 2 * count / maxchunksize;
+
+    pcm_s.intr_mode = IMODE_INPUT;
+    if (!pcm_s.intr_busy)
+	fifo_start(IMODE_INPUT);
+    pcm_s.intr_busy = YES;
+
+#if 0
+    RESTORE_INTR(flags);
+#endif
+}
+
+
+#ifndef __linux__
+static int
+nss_ioctl(int dev, u_int cmd, ioctl_arg arg, int local)
+{
+#else
+static int
+nss_ioctl(int dev, u_int cmd, caddr_t arg)
+{
+    int local = 0;
+#endif
+    switch (cmd) {
+    case SOUND_PCM_WRITE_RATE:
+#ifndef __linux__
+	if (local)
+	    return set_speed((int) arg);
+	return *(int *) arg = set_speed((*(int *) arg));
+#else
+	if (local)
+	    return set_speed(dev, (int) arg);
+	return *(int *) arg = set_speed(dev, (*(int *) arg));
+#endif
+
+    case SOUND_PCM_READ_RATE:
+	if (local)
+	    return pcm_s.speed;
+	return *(int *) arg = pcm_s.speed;
+
+    case SNDCTL_DSP_STEREO:
+	if (local)
+	    return set_stereo((int) arg);
+	return *(int *) arg = set_stereo((*(int *) arg));
+
+    case SOUND_PCM_WRITE_CHANNELS:
+	if (local)
+	    return set_stereo((int) arg - 1) + 1;
+	return *(int *) arg = set_stereo((*(int *) arg) - 1) + 1;
+
+    case SOUND_PCM_READ_CHANNELS:
+	if (local)
+	    return pcm_s.stereo + 1;
+	return *(int *) arg = pcm_s.stereo + 1;
+
+    case SNDCTL_DSP_SETFMT:
+	if (local)
+	    return set_format((int) arg);
+	return *(int *) arg = set_format((*(int *) arg));
+
+    case SOUND_PCM_READ_BITS:
+	if (local)
+	    return pcm_s.bytes * 8;
+	return *(int *) arg = pcm_s.bytes * 8;
+    }
+
+    /* Invalid ioctl request */
+    return -(EINVAL);
+}
+
+/*
+static void
+nss_trigger(int dev, int bits)
+{
+}
+*/
+
+static int
+nss_prepare_for_input(int dev, int bufsize, int nbufs)
+{
+    pcm_s.intr_size = PCM86_INTRSIZE_IN;
+    pcm_s.intr_mode = IMODE_NONE;
+    pcm_s.acc = 0;
+    pcm_s.last_l = 0;
+    pcm_s.last_r = 0;
+#ifdef __linux__
+    audio_devs[dev]->dmap_in->flags |= DMA_NODMA;
+#endif
+    DEB(printf("nss_prepare_for_input\n"));
+
+    return 0;
+}
+
+
+static int
+nss_prepare_for_output(int dev, int bufsize, int nbufs)
+{
+    pcm_s.intr_size = PCM86_INTRSIZE_OUT;
+    pcm_s.intr_mode = IMODE_NONE;
+    pcm_s.acc = 0;
+    pcm_s.last_l = 0;
+    pcm_s.last_r = 0;
+#ifdef __linux__ 
+    audio_devs[dev]->dmap_out->flags |= DMA_NODMA;
+#endif
+    DEB(printf("nss_prepare_for_output\n"));
+
+    return 0;
+}
+
+#ifndef __linux__
+static void
+nss_reset(int dev)
+{
+    nss_stop();
+}
+#endif
+
+
+static void
+nss_halt_xfer(int dev)
+{
+    nss_stop();
+
+    DEB(printf("nss_halt_xfer\n"));
+}
+
+
+void
+#ifndef __linux__
+nssintr(int unit)
+#else
+nssintr(int irq, void *dev_id, struct pt_regs *dummy)
+#endif
+{
+    unsigned char tmp;
+
+    if ((inb(pcm_s.iobase + 8) & 0x10) == 0)
+	return;		/* not FIFO intr. */
+    switch(pcm_s.intr_mode) {
+    case IMODE_OUTPUT:
+	if (pcm_s.intr_trailer) {
+	    DEB(printf("nssintr(): fifo_reset\n"));
+	    fifo_reset();
+	    pcm_s.intr_trailer = NO;
+	    pcm_s.intr_busy = NO;
+	}
+	if (pcm_s.pdma_count > 0) {
+	    fifo_output_block();
+	}
+	else {
+	    DMAbuf_outputintr(my_dev, 1);
+	}
+	/* Reset intr. flag. */
+	tmp = inb(pcm_s.iobase + 8);
+	outb(pcm_s.iobase + 8, tmp & ~0x10);
+	outb(pcm_s.iobase + 8, tmp | 0x10);
+	break;
+
+    case IMODE_INPUT:
+	fifo_input_block();
+	if (pcm_s.pdma_count == 0)
+	    DMAbuf_inputintr(my_dev);
+	/* Reset intr. flag. */
+	tmp = inb(pcm_s.iobase + 8);
+	outb(pcm_s.iobase + 8, tmp & ~0x10);
+	outb(pcm_s.iobase + 8, tmp | 0x10);
+	break;
+
+    default:
+	nss_stop();
+	printf("nss0: unexpected interrupt\n");
+    }
+}
+
+
+#ifdef __linux__
+
+void
+unload_nss(struct address_info *hw_config)
+{
+	sound_unload_mixerdev(audio_devs[my_dev]->mixer_dev);
+	sound_unload_audiodev(my_dev);
+	release_region(hw_config->io_base, 12);
+	if (hw_config->dma > 0)
+		sound_free_dma(hw_config->dma);
+	if (hw_config->dma2 > 0 && hw_config->dma != hw_config->dma2)
+		sound_free_dma(hw_config->dma2);
+}
+
+static int __initdata io = PCM86_IOBASE;
+static int __initdata dma = -1;
+static int __initdata dma2 = -1;
+
+static struct address_info _hw_config;
+
+static int loaded = 0;
+
+MODULE_DESCRIPTION("PC-9801-86 PCM sound module");
+/* MODULE_AUTHOR("NAGAO Tadaaki"); */
+
+MODULE_PARM(io, "i");
+MODULE_PARM(dma, "i");
+MODULE_PARM(dma2, "i");
+
+static int __init init_pc9801_86(void)
+{
+	printk(KERN_INFO "PC-9801-86 PCM driver Copyright (c) 1995  NAGAO Tadaaki (ABTK)\n");
+
+	_hw_config.io_base = io;
+	_hw_config.dma = dma;
+	_hw_config.dma2 = dma2;
+
+	if (!probe_nss(&_hw_config))
+		return -ENODEV;
+
+	attach_nss(&_hw_config, THIS_MODULE);
+	loaded++;
+	return 0;
+}
+
+static void __exit cleanup_pc9801_86(void)
+{
+	if (loaded) {
+		unload_nss(&_hw_config);
+	}
+}
+
+module_init(init_pc9801_86);
+module_exit(cleanup_pc9801_86);
+
+#ifndef MODULE
+static int __init setup_pc9801_86(char *str)
+{
+        /* io, irq, dma, dma2 */
+	int ints[4];
+	
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+	
+	io	= ints[1];
+	dma	= ints[2];
+	dma2	= ints[3];
+
+	return 1;
+}
+
+__setup("pc9801_86=", setup_pc9801_86);	
+#endif
+#endif /* __linux__ */
+
+
+#endif	/* EXCLUDE_NSS, EXCLUDE_AUDIO */
+
+#endif	/* __linux__ || CONFIGURE_SOUNDCARD */
