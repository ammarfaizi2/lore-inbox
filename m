Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266550AbUGKK06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUGKK06 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUGKK06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:26:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22472 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266550AbUGKK0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:26:43 -0400
Date: Sun, 11 Jul 2004 12:26:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: paul@linuxaudiosystems.com, thomas@undata.org
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA rme9652/hdsp: remove inlines
Message-ID: <20040711102637.GA4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile sound/pci/rme9652/hdsp.c with gcc 3.4 and
  # define inline         __inline__ __attribute__((always_inline))
results in compile errors starting with the following:

<--  snip  -->

...
  CC      sound/pci/rme9652/hdsp.o
sound/pci/rme9652/hdsp.c: In function 
`snd_hdsp_load_firmware_from_cache':
sound/pci/rme9652/hdsp.c:621: sorry, unimplemented: inlining failed in 
call to 'hdsp_fifo_wait': function body not available
sound/pci/rme9652/hdsp.c:687: sorry, unimplemented: called from here
sound/pci/rme9652/hdsp.c:621: sorry, unimplemented: inlining failed in 
call to 'hdsp_fifo_wait': function body not available
sound/pci/rme9652/hdsp.c:696: sorry, unimplemented: called from here
sound/pci/rme9652/hdsp.c:621: sorry, unimplemented: inlining failed in 
call to 'hdsp_fifo_wait': function body not available
sound/pci/rme9652/hdsp.c:709: sorry, unimplemented: called from here
make[3]: *** [sound/pci/rme9652/hdsp.o] Error 1

<--  snip  -->


The patch below removes all inlines from hdsp.c. As a side effect, it
showed that snd_hdsp_9652_disable_mixer() is completely unused, and it's
therefore also removed in the patch.


An alternative approach to removing the inlines would be to keep all
inlines that are _really_ required and reorder the functions in the file
accordingly.


diffstat output:
 sound/pci/rme9652/hdsp.c |   70 +++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 38 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full-gcc3.4/sound/pci/rme9652/hdsp.c.old	2004-07-11 12:08:49.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/sound/pci/rme9652/hdsp.c	2004-07-11 12:15:19.000000000 +0200
@@ -615,15 +615,15 @@
 /* prototypes */
 static int __devinit snd_hdsp_create_alsa_devices(snd_card_t *card, hdsp_t *hdsp);
 static int __devinit snd_hdsp_create_pcm(snd_card_t *card, hdsp_t *hdsp);
-static inline int snd_hdsp_enable_io (hdsp_t *hdsp);
-static inline void snd_hdsp_initialize_midi_flush (hdsp_t *hdsp);
-static inline void snd_hdsp_initialize_channels (hdsp_t *hdsp);
-static inline int hdsp_fifo_wait(hdsp_t *hdsp, int count, int timeout);
+static int snd_hdsp_enable_io (hdsp_t *hdsp);
+static void snd_hdsp_initialize_midi_flush (hdsp_t *hdsp);
+static void snd_hdsp_initialize_channels (hdsp_t *hdsp);
+static int hdsp_fifo_wait(hdsp_t *hdsp, int count, int timeout);
 static int hdsp_autosync_ref(hdsp_t *hdsp);
 static int snd_hdsp_set_defaults(hdsp_t *hdsp);
-static inline void snd_hdsp_9652_enable_mixer (hdsp_t *hdsp);
+static void snd_hdsp_9652_enable_mixer (hdsp_t *hdsp);
 
-static inline int hdsp_playback_to_output_key (hdsp_t *hdsp, int in, int out)
+static int hdsp_playback_to_output_key (hdsp_t *hdsp, int in, int out)
 {
 	switch (hdsp->firmware_rev) {
 	case 0xa:
@@ -636,7 +636,7 @@
 	}
 }
 
-static inline int hdsp_input_to_output_key (hdsp_t *hdsp, int in, int out)
+static int hdsp_input_to_output_key (hdsp_t *hdsp, int in, int out)
 {
 	switch (hdsp->firmware_rev) {
 	case 0xa:
@@ -649,17 +649,17 @@
 	}
 }
 
-static inline void hdsp_write(hdsp_t *hdsp, int reg, int val)
+static void hdsp_write(hdsp_t *hdsp, int reg, int val)
 {
 	writel(val, hdsp->iobase + reg);
 }
 
-static inline unsigned int hdsp_read(hdsp_t *hdsp, int reg)
+static unsigned int hdsp_read(hdsp_t *hdsp, int reg)
 {
 	return readl (hdsp->iobase + reg);
 }
 
-static inline int hdsp_check_for_iobox (hdsp_t *hdsp)
+static int hdsp_check_for_iobox (hdsp_t *hdsp)
 {
 
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return 0;
@@ -732,7 +732,7 @@
 	return 0;
 }
 
-static inline int hdsp_get_iobox_version (hdsp_t *hdsp)
+static int hdsp_get_iobox_version (hdsp_t *hdsp)
 {
 	int err;
 	
@@ -775,7 +775,7 @@
 }
 
 
-static inline int hdsp_check_for_firmware (hdsp_t *hdsp)
+static int hdsp_check_for_firmware (hdsp_t *hdsp)
 {
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return 0;
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
@@ -787,7 +787,7 @@
 }
 
 
-static inline int hdsp_fifo_wait(hdsp_t *hdsp, int count, int timeout)
+static int hdsp_fifo_wait(hdsp_t *hdsp, int count, int timeout)
 {    
 	int i;
 
@@ -812,7 +812,7 @@
 	return -1;
 }
 
-static inline int hdsp_read_gain (hdsp_t *hdsp, unsigned int addr)
+static int hdsp_read_gain (hdsp_t *hdsp, unsigned int addr)
 {
 	if (addr >= HDSP_MATRIX_MIXER_SIZE) {
 		return 0;
@@ -820,7 +820,7 @@
 	return hdsp->mixer_matrix[addr];
 }
 
-static inline int hdsp_write_gain(hdsp_t *hdsp, unsigned int addr, unsigned short data)
+static int hdsp_write_gain(hdsp_t *hdsp, unsigned int addr, unsigned short data)
 {
 	unsigned int ad;
 
@@ -883,7 +883,7 @@
 	return 0;
 }
 
-static inline int snd_hdsp_use_is_exclusive(hdsp_t *hdsp)
+static int snd_hdsp_use_is_exclusive(hdsp_t *hdsp)
 {
 	unsigned long flags;
 	int ret = 1;
@@ -897,7 +897,7 @@
 	return ret;
 }
 
-static inline int hdsp_external_sample_rate (hdsp_t *hdsp)
+static int hdsp_external_sample_rate (hdsp_t *hdsp)
 {
 	unsigned int status2 = hdsp_read(hdsp, HDSP_status2Register);
 	unsigned int rate_bits = status2 & HDSP_systemFrequencyMask;
@@ -914,7 +914,7 @@
 	}
 }
 
-static inline int hdsp_spdif_sample_rate(hdsp_t *hdsp)
+static int hdsp_spdif_sample_rate(hdsp_t *hdsp)
 {
 	unsigned int status = hdsp_read(hdsp, HDSP_statusRegister);
 	unsigned int rate_bits = (status & HDSP_spdifFrequencyMask);
@@ -946,7 +946,7 @@
 	return 0;
 }
 
-static inline void hdsp_compute_period_size(hdsp_t *hdsp)
+static void hdsp_compute_period_size(hdsp_t *hdsp)
 {
 	hdsp->period_bytes = 1 << ((hdsp_decode_latency(hdsp->control_register) + 8));
 }
@@ -968,24 +968,24 @@
 	return position;
 }
 
-static inline void hdsp_reset_hw_pointer(hdsp_t *hdsp)
+static void hdsp_reset_hw_pointer(hdsp_t *hdsp)
 {
 	hdsp_write (hdsp, HDSP_resetPointer, 0);
 }
 
-static inline void hdsp_start_audio(hdsp_t *s)
+static void hdsp_start_audio(hdsp_t *s)
 {
 	s->control_register |= (HDSP_AudioInterruptEnable | HDSP_Start);
 	hdsp_write(s, HDSP_controlRegister, s->control_register);
 }
 
-static inline void hdsp_stop_audio(hdsp_t *s)
+static void hdsp_stop_audio(hdsp_t *s)
 {
 	s->control_register &= ~(HDSP_Start | HDSP_AudioInterruptEnable);
 	hdsp_write(s, HDSP_controlRegister, s->control_register);
 }
 
-static inline void hdsp_silence_playback(hdsp_t *hdsp)
+static void hdsp_silence_playback(hdsp_t *hdsp)
 {
 	memset(hdsp->playback_buffer, 0, HDSP_DMA_AREA_BYTES);
 }
@@ -1230,7 +1230,7 @@
    MIDI
   ----------------------------------------------------------------------------*/
 
-static inline unsigned char snd_hdsp_midi_read_byte (hdsp_t *hdsp, int id)
+static unsigned char snd_hdsp_midi_read_byte (hdsp_t *hdsp, int id)
 {
 	/* the hardware already does the relevant bit-mask with 0xff */
 	if (id) {
@@ -1240,7 +1240,7 @@
 	}
 }
 
-static inline void snd_hdsp_midi_write_byte (hdsp_t *hdsp, int id, int val)
+static void snd_hdsp_midi_write_byte (hdsp_t *hdsp, int id, int val)
 {
 	/* the hardware already does the relevant bit-mask with 0xff */
 	if (id) {
@@ -1250,7 +1250,7 @@
 	}
 }
 
-static inline int snd_hdsp_midi_input_available (hdsp_t *hdsp, int id)
+static int snd_hdsp_midi_input_available (hdsp_t *hdsp, int id)
 {
 	if (id) {
 		return (hdsp_read(hdsp, HDSP_midiStatusIn1) & 0xff);
@@ -1259,7 +1259,7 @@
 	}
 }
 
-static inline int snd_hdsp_midi_output_possible (hdsp_t *hdsp, int id)
+static int snd_hdsp_midi_output_possible (hdsp_t *hdsp, int id)
 {
 	int fifo_bytes_used;
 
@@ -1276,7 +1276,7 @@
 	}
 }
 
-static inline void snd_hdsp_flush_midi_input (hdsp_t *hdsp, int id)
+static void snd_hdsp_flush_midi_input (hdsp_t *hdsp, int id)
 {
 	while (snd_hdsp_midi_input_available (hdsp, id)) {
 		snd_hdsp_midi_read_byte (hdsp, id);
@@ -4824,19 +4824,13 @@
 	return 0;
 }
 
-static inline void snd_hdsp_9652_enable_mixer (hdsp_t *hdsp)
+static void snd_hdsp_9652_enable_mixer (hdsp_t *hdsp)
 {
         hdsp->control2_register |= HDSP_9652_ENABLE_MIXER;
 	hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
 }
 
-static inline void snd_hdsp_9652_disable_mixer (hdsp_t *hdsp)
-{
-        hdsp->control2_register &= ~HDSP_9652_ENABLE_MIXER;
-	hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
-}
-
-static inline int snd_hdsp_enable_io (hdsp_t *hdsp)
+static int snd_hdsp_enable_io (hdsp_t *hdsp)
 {
 	int i;
 	
@@ -4852,7 +4846,7 @@
 	return 0;
 }
 
-static inline void snd_hdsp_initialize_channels(hdsp_t *hdsp)
+static void snd_hdsp_initialize_channels(hdsp_t *hdsp)
 {
 	int status, aebi_channels, aebo_channels;
 	
@@ -4895,7 +4889,7 @@
 	}
 }
 
-static inline void snd_hdsp_initialize_midi_flush (hdsp_t *hdsp)
+static void snd_hdsp_initialize_midi_flush (hdsp_t *hdsp)
 {
 	snd_hdsp_flush_midi_input (hdsp, 0);
 	snd_hdsp_flush_midi_input (hdsp, 1);
