Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbUKVAEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbUKVAEV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUKVADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 19:03:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59911 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261868AbUKUX65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:58:57 -0500
Date: Mon, 22 Nov 2004 00:58:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA PCI drivers: misc cleanups
Message-ID: <20041121235855.GI13254@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups under sound/pci/ :
- make some needlessly global code static
- remove the following unused EXPORT_SYMBOL's:
  - trident/trident_main.c: snd_trident_clear_voices
  - trident/trident_main.c: snd_trident_synth_bzero
- remove the following unused global functions:
  - azt3328.c: snd_azf3328_mixer_read
  - cs46xx/dsp_spos_scb_lib.c: cs46xx_dsp_create_filter_scb
  - cs46xx/dsp_spos_scb_lib.c: cs46xx_dsp_create_output_snoop_scb
  - emu10k1/io.c: snd_emu10k1_voice_set_loop_stop
  - emu10k1/io.c: snd_emu10k1_sum_vol_attn
  - trident/trident_main.c: snd_trident_detach_synthesizer
  - trident/trident_memory.c: snd_trident_synth_bzero

Please review these changes.


diffstat output:
 include/sound/emu10k1.h             |    3 
 include/sound/trident.h             |    4 -
 include/sound/ymfpci.h              |    3 
 sound/pci/ac97/ac97_codec.c         |    8 +-
 sound/pci/ac97/ac97_local.h         |    3 
 sound/pci/azt3328.c                 |   29 +-------
 sound/pci/cs46xx/cs46xx_lib.c       |   34 ++++++---
 sound/pci/cs46xx/cs46xx_lib.h       |   40 -----------
 sound/pci/cs46xx/dsp_spos.c         |    8 +-
 sound/pci/cs46xx/dsp_spos_scb_lib.c |   98 +---------------------------
 sound/pci/cs46xx/imgs/cwcdma.h      |    8 +-
 sound/pci/emu10k1/emu10k1_synth.c   |    4 -
 sound/pci/emu10k1/emufx.c           |    2 
 sound/pci/emu10k1/io.c              |   45 ------------
 sound/pci/korg1212/korg1212.c       |    3 
 sound/pci/rme9652/hdsp.c            |    8 +-
 sound/pci/rme9652/rme9652.c         |    2 
 sound/pci/sonicvibes.c              |    4 -
 sound/pci/trident/trident_main.c    |   38 ++++------
 sound/pci/trident/trident_memory.c  |   23 ------
 sound/pci/trident/trident_synth.c   |    2 
 sound/pci/ymfpci/ymfpci_main.c      |    4 -
 22 files changed, 75 insertions(+), 298 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/sound/pci/ac97/ac97_local.h.old	2004-11-22 00:00:07.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/ac97/ac97_local.h	2004-11-22 00:00:27.000000000 +0100
@@ -45,9 +45,6 @@
 int snd_ac97_page_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
 int snd_ac97_page_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
 int snd_ac97_try_bit(ac97_t * ac97, int reg, int bit);
-int snd_ac97_remove_ctl(ac97_t *ac97, const char *name, const char *suffix);
-int snd_ac97_rename_ctl(ac97_t *ac97, const char *src, const char *dst, const char *suffix);
-int snd_ac97_swap_ctl(ac97_t *ac97, const char *s1, const char *s2, const char *suffix);
 void snd_ac97_rename_vol_ctl(ac97_t *ac97, const char *src, const char *dst);
 
 /* ac97_proc.c */
--- linux-2.6.10-rc2-mm2-full/sound/pci/ac97/ac97_codec.c.old	2004-11-22 00:00:35.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/ac97/ac97_codec.c	2004-11-22 00:01:23.000000000 +0100
@@ -633,7 +633,7 @@
 				    (val1 << shift_left) | (val2 << shift_right));
 }
 
-int snd_ac97_getput_page(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol,
+static int snd_ac97_getput_page(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol,
 			 int (*func)(snd_kcontrol_t *, snd_ctl_elem_value_t *))
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
@@ -2339,7 +2339,7 @@
 		strcpy(dst, src);
 }	
 
-int snd_ac97_remove_ctl(ac97_t *ac97, const char *name, const char *suffix)
+static int snd_ac97_remove_ctl(ac97_t *ac97, const char *name, const char *suffix)
 {
 	snd_ctl_elem_id_t id;
 	memset(&id, 0, sizeof(id));
@@ -2357,7 +2357,7 @@
 	return snd_ctl_find_id(ac97->bus->card, &sid);
 }
 
-int snd_ac97_rename_ctl(ac97_t *ac97, const char *src, const char *dst, const char *suffix)
+static int snd_ac97_rename_ctl(ac97_t *ac97, const char *src, const char *dst, const char *suffix)
 {
 	snd_kcontrol_t *kctl = ctl_find(ac97, src, suffix);
 	if (kctl) {
@@ -2374,7 +2374,7 @@
 	snd_ac97_rename_ctl(ac97, src, dst, "Volume");
 }
 
-int snd_ac97_swap_ctl(ac97_t *ac97, const char *s1, const char *s2, const char *suffix)
+static int snd_ac97_swap_ctl(ac97_t *ac97, const char *s1, const char *s2, const char *suffix)
 {
 	snd_kcontrol_t *kctl1, *kctl2;
 	kctl1 = ctl_find(ac97, s1, suffix);
--- linux-2.6.10-rc2-mm2-full/sound/pci/azt3328.c.old	2004-11-22 00:02:05.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/azt3328.c	2004-11-22 00:03:23.000000000 +0100
@@ -214,17 +214,17 @@
 
 MODULE_DEVICE_TABLE(pci, snd_azf3328_ids);
 
-void snd_azf3328_io2_write(azf3328_t *chip, int reg, unsigned char value)
+static void snd_azf3328_io2_write(azf3328_t *chip, int reg, unsigned char value)
 {
 	outb(value, chip->io2_port + reg);
 }
 
-unsigned char snd_azf3328_io2_read(azf3328_t *chip, int reg)
+static unsigned char snd_azf3328_io2_read(azf3328_t *chip, int reg)
 {
 	return inb(chip->io2_port + reg);
 }
 
-void snd_azf3328_mixer_write(azf3328_t *chip, int reg, unsigned long value, int type)
+static void snd_azf3328_mixer_write(azf3328_t *chip, int reg, unsigned long value, int type)
 {
 	switch(type) {
 	case WORD_VALUE:
@@ -239,26 +239,7 @@
 	}
 }
 
-unsigned long snd_azf3328_mixer_read(azf3328_t *chip, int reg, int type)
-{
-	unsigned long res = 0;
-
-	switch(type) {
-	case WORD_VALUE:
-		res = (unsigned long)inw(chip->mixer_port + reg);
-		break;
-	case DWORD_VALUE:
-		res = (unsigned long)inl(chip->mixer_port + reg);
-		break;
-	case BYTE_VALUE:
-		res = (unsigned long)inb(chip->mixer_port + reg);
-		break;
-	}
-
-	return res;
-}
-
-void snd_azf3328_mixer_set_mute(azf3328_t *chip, int reg, int do_mute)
+static void snd_azf3328_mixer_set_mute(azf3328_t *chip, int reg, int do_mute)
 {
 	unsigned char oldval;
 
@@ -272,7 +253,7 @@
 	outb(oldval, chip->mixer_port + reg + 1);
 }
 
-void snd_azf3328_mixer_write_volume_gradually(azf3328_t *chip, int reg, unsigned char dst_vol_left, unsigned char dst_vol_right, int chan_sel, int delay)
+static void snd_azf3328_mixer_write_volume_gradually(azf3328_t *chip, int reg, unsigned char dst_vol_left, unsigned char dst_vol_right, int chan_sel, int delay)
 {
 	unsigned char curr_vol_left = 0, curr_vol_right = 0;
 	int left_done = 0, right_done = 0;
--- linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/imgs/cwcdma.h.old	2004-11-22 00:09:05.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/imgs/cwcdma.h	2004-11-22 00:09:25.000000000 +0100
@@ -3,7 +3,7 @@
 #ifndef __HEADER_cwcdma_H__
 #define __HEADER_cwcdma_H__
 
-symbol_entry_t cwcdma_symbols[] = {
+static symbol_entry_t cwcdma_symbols[] = {
   { 0x8000, "EXECCHILD",0x03 },
   { 0x8001, "EXECCHILD_98",0x03 },
   { 0x8003, "EXECCHILD_PUSH1IND",0x03 },
@@ -33,7 +33,7 @@
   { 0x0018, "#CODE_END",0x00 },
 }; /* cwcdma symbols */
 
-u32 cwcdma_code[] = {
+static u32 cwcdma_code[] = {
 /* OVERLAYBEGINADDRESS */
 /* 0000 */ 0x00002731,0x00001400,0x0004c108,0x000e5044,
 /* 0002 */ 0x0005f608,0x00000000,0x000007ae,0x000be300,
@@ -51,11 +51,11 @@
 
 /* #CODE_END */
 
-segment_desc_t cwcdma_segments[] = {
+static segment_desc_t cwcdma_segments[] = {
   { SEGTYPE_SP_PROGRAM, 0x00000000, 0x00000030, cwcdma_code },
 };
 
-dsp_module_desc_t cwcdma_module = {
+static dsp_module_desc_t cwcdma_module = {
   "cwcdma",
   {
     27,
--- linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/cs46xx_lib.h.old	2004-11-22 00:13:09.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/cs46xx_lib.h	2004-11-22 00:23:11.000000000 +0100
@@ -53,18 +53,6 @@
 #define BA1_DWORD_SIZE		(13 * 1024 + 512)
 #define BA1_MEMORY_COUNT	3
 
-extern snd_pcm_ops_t snd_cs46xx_playback_ops;
-extern snd_pcm_ops_t snd_cs46xx_playback_indirect_ops;
-extern snd_pcm_ops_t snd_cs46xx_capture_ops;
-extern snd_pcm_ops_t snd_cs46xx_capture_indirect_ops;
-extern snd_pcm_ops_t snd_cs46xx_playback_rear_ops;
-extern snd_pcm_ops_t snd_cs46xx_playback_indirect_rear_ops;
-extern snd_pcm_ops_t snd_cs46xx_playback_iec958_ops;
-extern snd_pcm_ops_t snd_cs46xx_playback_indirect_iec958_ops;
-extern snd_pcm_ops_t snd_cs46xx_playback_clfe_ops;
-extern snd_pcm_ops_t snd_cs46xx_playback_indirect_clfe_ops;
-
-
 /*
  *  common I/O routines
  */
@@ -99,11 +87,9 @@
 void                   cs46xx_dsp_spos_destroy (cs46xx_t * chip);
 int                    cs46xx_dsp_load_module (cs46xx_t * chip,dsp_module_desc_t * module);
 symbol_entry_t *       cs46xx_dsp_lookup_symbol (cs46xx_t * chip,char * symbol_name,int symbol_type);
-symbol_entry_t *       cs46xx_dsp_lookup_symbol_addr (cs46xx_t * chip,u32 address,int symbol_type);
 int                    cs46xx_dsp_proc_init (snd_card_t * card, cs46xx_t *chip);
 int                    cs46xx_dsp_proc_done (cs46xx_t *chip);
 int                    cs46xx_dsp_scb_and_task_init (cs46xx_t *chip);
-int                    cs46xx_dsp_async_init (cs46xx_t *chip,dsp_scb_descriptor_t * fg_entry);
 int                    snd_cs46xx_download (cs46xx_t *chip,u32 *src,unsigned long offset,
                                             unsigned long len);
 int                    snd_cs46xx_clear_BA1(cs46xx_t *chip,unsigned long offset,unsigned long len);
@@ -120,8 +106,6 @@
 dsp_scb_descriptor_t * cs46xx_dsp_create_scb (cs46xx_t *chip,char * name, u32 * scb_data,u32 dest);
 void                   cs46xx_dsp_proc_free_scb_desc (dsp_scb_descriptor_t * scb);
 void                   cs46xx_dsp_proc_register_scb_desc (cs46xx_t *chip,dsp_scb_descriptor_t * scb);
-dsp_task_descriptor_t * cs46xx_dsp_create_task_tree (cs46xx_t *chip,char * name, 
-                                                     u32 * task_data,u32 dest,int size);
 dsp_scb_descriptor_t * cs46xx_dsp_create_timing_master_scb (cs46xx_t *chip);
 dsp_scb_descriptor_t * cs46xx_dsp_create_codec_out_scb(cs46xx_t * chip,char * codec_name,
                                                        u16 channel_disp,u16 fifo_addr,
@@ -136,21 +120,11 @@
                                                       dsp_scb_descriptor_t * parent_scb,
                                                       int scb_child_type);
 void                   cs46xx_dsp_remove_scb (cs46xx_t *chip,dsp_scb_descriptor_t * scb);
-dsp_scb_descriptor_t * cs46xx_dsp_create_generic_scb (cs46xx_t *chip,char * name, 
-                                                      u32 * scb_data,u32 dest,
-                                                      char * task_entry_name,
-                                                      dsp_scb_descriptor_t * parent_scb,
-                                                      int scb_child_type);
 dsp_scb_descriptor_t *  cs46xx_dsp_create_codec_in_scb(cs46xx_t * chip,char * codec_name,
                                                        u16 channel_disp,u16 fifo_addr,
                                                        u16 sample_buffer_addr,
                                                        u32 dest,dsp_scb_descriptor_t * parent_scb,
                                                        int scb_child_type);
-dsp_scb_descriptor_t * cs46xx_dsp_create_pcm_reader_scb(cs46xx_t * chip,char * scb_name,
-                                                        u16 sample_buffer_addr,u32 dest,
-                                                        int virtual_channel,u32 playback_hw_addr,
-                                                        dsp_scb_descriptor_t * parent_scb,
-                                                        int scb_child_type);
 dsp_scb_descriptor_t *  cs46xx_dsp_create_src_task_scb(cs46xx_t * chip,char * scb_name,
 						       int sample_rate,
                                                        u16 src_buffer_addr,
@@ -169,15 +143,6 @@
                                                             u32 dest,
                                                             dsp_scb_descriptor_t * parent_scb,
                                                             int scb_child_type);
-dsp_scb_descriptor_t *  cs46xx_dsp_create_pcm_serial_input_scb(cs46xx_t * chip,char * scb_name,u32 dest,
-                                                               dsp_scb_descriptor_t * input_scb,
-                                                               dsp_scb_descriptor_t * parent_scb,
-                                                               int scb_child_type);
-dsp_scb_descriptor_t * cs46xx_dsp_create_asynch_fg_tx_scb(cs46xx_t * chip,char * scb_name,u32 dest,
-                                                          u16 hfg_scb_address,
-                                                          u16 asynch_buffer_address,
-                                                          dsp_scb_descriptor_t * parent_scb,
-                                                          int scb_child_type);
 dsp_scb_descriptor_t * cs46xx_dsp_create_asynch_fg_rx_scb(cs46xx_t * chip,char * scb_name,u32 dest,
                                                           u16 hfg_scb_address,
                                                           u16 asynch_buffer_address,
@@ -190,11 +155,6 @@
                                                              u16 mix_buffer_addr,u16 writeback_spb,u32 dest,
                                                              dsp_scb_descriptor_t * parent_scb,
                                                              int scb_child_type);
-dsp_scb_descriptor_t *  cs46xx_dsp_create_output_snoop_scb(cs46xx_t * chip,char * scb_name,u32 dest,
-                                                           u16 snoop_buffer_address,
-                                                           dsp_scb_descriptor_t * snoop_scb,
-                                                           dsp_scb_descriptor_t * parent_scb,
-                                                           int scb_child_type);
 dsp_scb_descriptor_t *  cs46xx_dsp_create_magic_snoop_scb(cs46xx_t * chip,char * scb_name,u32 dest,
                                                           u16 snoop_buffer_address,
                                                           dsp_scb_descriptor_t * snoop_scb,
--- linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/cs46xx_lib.c.old	2004-11-22 00:13:14.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/cs46xx_lib.c	2004-11-22 00:40:13.000000000 +0100
@@ -68,6 +68,20 @@
 
 static void amp_voyetra(cs46xx_t *chip, int change);
 
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+static snd_pcm_ops_t snd_cs46xx_playback_rear_ops;
+static snd_pcm_ops_t snd_cs46xx_playback_indirect_rear_ops;
+static snd_pcm_ops_t snd_cs46xx_playback_clfe_ops;
+static snd_pcm_ops_t snd_cs46xx_playback_indirect_clfe_ops;
+static snd_pcm_ops_t snd_cs46xx_playback_iec958_ops;
+static snd_pcm_ops_t snd_cs46xx_playback_indirect_iec958_ops;
+#endif
+
+static snd_pcm_ops_t snd_cs46xx_playback_ops;
+static snd_pcm_ops_t snd_cs46xx_playback_indirect_ops;
+static snd_pcm_ops_t snd_cs46xx_capture_ops;
+static snd_pcm_ops_t snd_cs46xx_capture_indirect_ops;
+
 static unsigned short snd_cs46xx_codec_read(cs46xx_t *chip,
 					    unsigned short reg,
 					    int codec_index)
@@ -1446,7 +1460,7 @@
 }
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-snd_pcm_ops_t snd_cs46xx_playback_rear_ops = {
+static snd_pcm_ops_t snd_cs46xx_playback_rear_ops = {
 	.open =			snd_cs46xx_playback_open_rear,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1457,7 +1471,7 @@
 	.pointer =		snd_cs46xx_playback_direct_pointer,
 };
 
-snd_pcm_ops_t snd_cs46xx_playback_indirect_rear_ops = {
+static snd_pcm_ops_t snd_cs46xx_playback_indirect_rear_ops = {
 	.open =			snd_cs46xx_playback_open_rear,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1469,7 +1483,7 @@
 	.ack =			snd_cs46xx_playback_transfer,
 };
 
-snd_pcm_ops_t snd_cs46xx_playback_clfe_ops = {
+static snd_pcm_ops_t snd_cs46xx_playback_clfe_ops = {
 	.open =			snd_cs46xx_playback_open_clfe,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1480,7 +1494,7 @@
 	.pointer =		snd_cs46xx_playback_direct_pointer,
 };
 
-snd_pcm_ops_t snd_cs46xx_playback_indirect_clfe_ops = {
+static snd_pcm_ops_t snd_cs46xx_playback_indirect_clfe_ops = {
 	.open =			snd_cs46xx_playback_open_clfe,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1492,7 +1506,7 @@
 	.ack =			snd_cs46xx_playback_transfer,
 };
 
-snd_pcm_ops_t snd_cs46xx_playback_iec958_ops = {
+static snd_pcm_ops_t snd_cs46xx_playback_iec958_ops = {
 	.open =			snd_cs46xx_playback_open_iec958,
 	.close =		snd_cs46xx_playback_close_iec958,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1503,7 +1517,7 @@
 	.pointer =		snd_cs46xx_playback_direct_pointer,
 };
 
-snd_pcm_ops_t snd_cs46xx_playback_indirect_iec958_ops = {
+static snd_pcm_ops_t snd_cs46xx_playback_indirect_iec958_ops = {
 	.open =			snd_cs46xx_playback_open_iec958,
 	.close =		snd_cs46xx_playback_close_iec958,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1517,7 +1531,7 @@
 
 #endif
 
-snd_pcm_ops_t snd_cs46xx_playback_ops = {
+static snd_pcm_ops_t snd_cs46xx_playback_ops = {
 	.open =			snd_cs46xx_playback_open,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1528,7 +1542,7 @@
 	.pointer =		snd_cs46xx_playback_direct_pointer,
 };
 
-snd_pcm_ops_t snd_cs46xx_playback_indirect_ops = {
+static snd_pcm_ops_t snd_cs46xx_playback_indirect_ops = {
 	.open =			snd_cs46xx_playback_open,
 	.close =		snd_cs46xx_playback_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1540,7 +1554,7 @@
 	.ack =			snd_cs46xx_playback_transfer,
 };
 
-snd_pcm_ops_t snd_cs46xx_capture_ops = {
+static snd_pcm_ops_t snd_cs46xx_capture_ops = {
 	.open =			snd_cs46xx_capture_open,
 	.close =		snd_cs46xx_capture_close,
 	.ioctl =		snd_pcm_lib_ioctl,
@@ -1551,7 +1565,7 @@
 	.pointer =		snd_cs46xx_capture_direct_pointer,
 };
 
-snd_pcm_ops_t snd_cs46xx_capture_indirect_ops = {
+static snd_pcm_ops_t snd_cs46xx_capture_indirect_ops = {
 	.open =			snd_cs46xx_capture_open,
 	.close =		snd_cs46xx_capture_close,
 	.ioctl =		snd_pcm_lib_ioctl,
--- linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/dsp_spos.c.old	2004-11-22 00:19:03.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/dsp_spos.c	2004-11-22 00:20:09.000000000 +0100
@@ -37,6 +37,8 @@
 #include "cs46xx_lib.h"
 #include "dsp_spos.h"
 
+static int cs46xx_dsp_async_init (cs46xx_t *chip, dsp_scb_descriptor_t * fg_entry);
+
 static wide_opcode_t wide_opcodes[] = { 
 	WIDE_FOR_BEGIN_LOOP,
 	WIDE_FOR_BEGIN_LOOP2,
@@ -439,7 +441,7 @@
 }
 
 
-symbol_entry_t * cs46xx_dsp_lookup_symbol_addr (cs46xx_t * chip, u32 address, int symbol_type)
+static symbol_entry_t * cs46xx_dsp_lookup_symbol_addr (cs46xx_t * chip, u32 address, int symbol_type)
 {
 	int i;
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
@@ -1019,7 +1021,7 @@
 }
 
 
-dsp_task_descriptor_t *  cs46xx_dsp_create_task_tree (cs46xx_t *chip,char * name, u32 * task_data,u32 dest,int size)
+static dsp_task_descriptor_t *  cs46xx_dsp_create_task_tree (cs46xx_t *chip,char * name, u32 * task_data,u32 dest,int size)
 {
 	dsp_task_descriptor_t * desc;
 
@@ -1452,7 +1454,7 @@
 	return -EINVAL;
 }
 
-int cs46xx_dsp_async_init (cs46xx_t *chip, dsp_scb_descriptor_t * fg_entry)
+static int cs46xx_dsp_async_init (cs46xx_t *chip, dsp_scb_descriptor_t * fg_entry)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 	symbol_entry_t * s16_async_codec_input_task;
--- linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/dsp_spos_scb_lib.c.old	2004-11-22 00:21:28.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/cs46xx/dsp_spos_scb_lib.c	2004-11-22 00:23:17.000000000 +0100
@@ -342,7 +342,7 @@
 	return scb;
 }
 
-dsp_scb_descriptor_t * 
+static dsp_scb_descriptor_t * 
 cs46xx_dsp_create_generic_scb (cs46xx_t *chip,char * name, u32 * scb_data,u32 dest,
                                char * task_entry_name,
                                dsp_scb_descriptor_t * parent_scb,
@@ -481,7 +481,7 @@
 }
 
 
-dsp_scb_descriptor_t * 
+static dsp_scb_descriptor_t * 
 cs46xx_dsp_create_pcm_reader_scb(cs46xx_t * chip,char * scb_name,
                                  u16 sample_buffer_addr,u32 dest,
                                  int virtual_channel, u32 playback_hw_addr,
@@ -688,55 +688,6 @@
 }
 
 dsp_scb_descriptor_t * 
-cs46xx_dsp_create_filter_scb(cs46xx_t * chip,char * scb_name,
-			     u16 buffer_addr,u32 dest,
-			     dsp_scb_descriptor_t * parent_scb,
-			     int scb_child_type) {
-	dsp_scb_descriptor_t * scb;
-	
-	filter_scb_t filter_scb = {
-		.a0_right            = 0x41a9,
-		.a0_left             = 0x41a9,
-		.a1_right            = 0xb8e4,
-		.a1_left             = 0xb8e4,
-		.a2_right            = 0x3e55,
-		.a2_left             = 0x3e55,
-		
-		.filter_unused3      = 0x0000,
-		.filter_unused2      = 0x0000,
-
-		.output_buf_ptr      = buffer_addr,
-		.init                = 0x000,
-
-		.prev_sample_output1 = 0x00000000,
-		.prev_sample_output2 = 0x00000000,
-
-		.prev_sample_input1  = 0x00000000,
-		.prev_sample_input2  = 0x00000000,
-
-		.next_scb_ptr        = 0x0000,
-		.sub_list_ptr        = 0x0000,
-
-		.entry_point         = 0x0000,
-		.spb_ptr             = 0x0000,
-
-		.b0_right            = 0x0e38,
-		.b0_left             = 0x0e38,
-		.b1_right            = 0x1c71,
-		.b1_left             = 0x1c71,
-		.b2_right            = 0x0e38,
-		.b2_left             = 0x0e38,
-	};
-
-
-	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&filter_scb,
-					    dest,"FILTERTASK",parent_scb,
-					    scb_child_type);
-
- 	return scb;
-}
-
-dsp_scb_descriptor_t * 
 cs46xx_dsp_create_mix_only_scb(cs46xx_t * chip,char * scb_name,
                                u16 mix_buffer_addr,u32 dest,
                                dsp_scb_descriptor_t * parent_scb,
@@ -874,7 +825,7 @@
 }
 
 
-dsp_scb_descriptor_t * 
+static dsp_scb_descriptor_t * 
 cs46xx_dsp_create_pcm_serial_input_scb(cs46xx_t * chip,char * scb_name,u32 dest,
                                        dsp_scb_descriptor_t * input_scb,
                                        dsp_scb_descriptor_t * parent_scb,
@@ -917,7 +868,7 @@
 }
 
 
-dsp_scb_descriptor_t * 
+static dsp_scb_descriptor_t * 
 cs46xx_dsp_create_asynch_fg_tx_scb(cs46xx_t * chip,char * scb_name,u32 dest,
                                    u16 hfg_scb_address,
                                    u16 asynch_buffer_address,
@@ -1014,47 +965,6 @@
 
 
 dsp_scb_descriptor_t * 
-cs46xx_dsp_create_output_snoop_scb(cs46xx_t * chip,char * scb_name,u32 dest,
-                                   u16 snoop_buffer_address,
-                                   dsp_scb_descriptor_t * snoop_scb,
-                                   dsp_scb_descriptor_t * parent_scb,
-                                   int scb_child_type)
-{
-
-	dsp_scb_descriptor_t * scb;
-  
-	output_snoop_scb_t output_snoop_scb = {
-		{ 0,	/*  not used.  Zero */
-		  0,
-		  0,
-		  0,
-		},
-		{
-			0, /* not used.  Zero */
-			0,
-			0,
-			0,
-			0
-		},
-    
-		0,0,
-		0,0,
-    
-		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_64,
-		snoop_buffer_address << 0x10,  
-		0,0,
-		0,
-		0,snoop_scb->address
-	};
-  
-	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&output_snoop_scb,
-					    dest,"OUTPUTSNOOP",parent_scb,
-					    scb_child_type);
-	return scb;
-}
-
-
-dsp_scb_descriptor_t * 
 cs46xx_dsp_create_spio_write_scb(cs46xx_t * chip,char * scb_name,u32 dest,
                                  dsp_scb_descriptor_t * parent_scb,
                                  int scb_child_type)
--- linux-2.6.10-rc2-mm2-full/sound/pci/emu10k1/emu10k1_synth.c.old	2004-11-22 00:23:50.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/emu10k1/emu10k1_synth.c	2004-11-22 00:24:06.000000000 +0100
@@ -28,7 +28,7 @@
 /*
  * create a new hardware dependent device for Emu10k1
  */
-int snd_emu10k1_synth_new_device(snd_seq_device_t *dev)
+static int snd_emu10k1_synth_new_device(snd_seq_device_t *dev)
 {
 	snd_emux_t *emu;
 	emu10k1_t *hw;
@@ -76,7 +76,7 @@
 	return 0;
 }
 
-int snd_emu10k1_synth_delete_device(snd_seq_device_t *dev)
+static int snd_emu10k1_synth_delete_device(snd_seq_device_t *dev)
 {
 	snd_emux_t *emu;
 	emu10k1_t *hw;
--- linux-2.6.10-rc2-mm2-full/include/sound/emu10k1.h.old	2004-11-22 00:24:23.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/include/sound/emu10k1.h	2004-11-22 00:25:18.000000000 +0100
@@ -1036,21 +1036,18 @@
 /* I/O functions */
 unsigned int snd_emu10k1_ptr_read(emu10k1_t * emu, unsigned int reg, unsigned int chn);
 void snd_emu10k1_ptr_write(emu10k1_t *emu, unsigned int reg, unsigned int chn, unsigned int data);
-void snd_emu10k1_efx_write(emu10k1_t *emu, unsigned int pc, unsigned int data);
 unsigned int snd_emu10k1_efx_read(emu10k1_t *emu, unsigned int pc);
 void snd_emu10k1_intr_enable(emu10k1_t *emu, unsigned int intrenb);
 void snd_emu10k1_intr_disable(emu10k1_t *emu, unsigned int intrenb);
 void snd_emu10k1_voice_intr_enable(emu10k1_t *emu, unsigned int voicenum);
 void snd_emu10k1_voice_intr_disable(emu10k1_t *emu, unsigned int voicenum);
 void snd_emu10k1_voice_intr_ack(emu10k1_t *emu, unsigned int voicenum);
-void snd_emu10k1_voice_set_loop_stop(emu10k1_t *emu, unsigned int voicenum);
 void snd_emu10k1_voice_clear_loop_stop(emu10k1_t *emu, unsigned int voicenum);
 void snd_emu10k1_wait(emu10k1_t *emu, unsigned int wait);
 static inline unsigned int snd_emu10k1_wc(emu10k1_t *emu) { return (inl(emu->port + WC) >> 6) & 0xfffff; }
 unsigned short snd_emu10k1_ac97_read(ac97_t *ac97, unsigned short reg);
 void snd_emu10k1_ac97_write(ac97_t *ac97, unsigned short reg, unsigned short data);
 unsigned int snd_emu10k1_rate_to_pitch(unsigned int rate);
-unsigned char snd_emu10k1_sum_vol_attn(unsigned int value);
 
 /* memory allocation */
 snd_util_memblk_t *snd_emu10k1_alloc_pages(emu10k1_t *emu, snd_pcm_substream_t *substream);
--- linux-2.6.10-rc2-mm2-full/sound/pci/emu10k1/emufx.c.old	2004-11-22 00:24:42.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/emu10k1/emufx.c	2004-11-22 00:24:48.000000000 +0100
@@ -489,7 +489,7 @@
 #define A_OP(icode, ptr, op, r, a, x, y) \
 	snd_emu10k1_audigy_write_op(icode, ptr, op, r, a, x, y)
 
-void snd_emu10k1_efx_write(emu10k1_t *emu, unsigned int pc, unsigned int data)
+static void snd_emu10k1_efx_write(emu10k1_t *emu, unsigned int pc, unsigned int data)
 {
 	pc += emu->audigy ? A_MICROCODEBASE : MICROCODEBASE;
 	snd_emu10k1_ptr_write(emu, pc, 0, data);
--- linux-2.6.10-rc2-mm2-full/sound/pci/emu10k1/io.c.old	2004-11-22 00:25:27.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/emu10k1/io.c	2004-11-22 00:25:44.000000000 +0100
@@ -170,26 +170,6 @@
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
-void snd_emu10k1_voice_set_loop_stop(emu10k1_t *emu, unsigned int voicenum)
-{
-	unsigned long flags;
-	unsigned int sol;
-
-	spin_lock_irqsave(&emu->emu_lock, flags);
-	/* voice interrupt */
-	if (voicenum >= 32) {
-		outl(SOLEH << 16, emu->port + PTR);
-		sol = inl(emu->port + DATA);
-		sol |= 1 << (voicenum - 32);
-	} else {
-		outl(SOLEL << 16, emu->port + PTR);
-		sol = inl(emu->port + DATA);
-		sol |= 1 << voicenum;
-	}
-	outl(sol, emu->port + DATA);
-	spin_unlock_irqrestore(&emu->emu_lock, flags);
-}
-
 void snd_emu10k1_voice_clear_loop_stop(emu10k1_t *emu, unsigned int voicenum)
 {
 	unsigned long flags;
@@ -313,28 +293,3 @@
 	return 0;		/* Should never reach this point */
 }
 
-/*
- *  Returns an attenuation based upon a cumulative volume value
- *  Algorithm calculates 0x200 - 0x10 log2 (input)
- */
- 
-unsigned char snd_emu10k1_sum_vol_attn(unsigned int value)
-{
-	unsigned short count = 16, ans;
-
-	if (value == 0)
-		return 0xFF;
-
-	/* Find first SET bit. This is the integer part of the value */
-	while ((value & 0x10000) == 0) {
-		value <<= 1;
-		count--;
-	}
-
-	/* The REST of the data is the fractional part. */
-	ans = (unsigned short) (0x110 - ((count << 4) + ((value & 0x0FFFFL) >> 12)));
-	if (ans > 0xFF)
-		ans = 0xFF;
-
-	return (unsigned char) ans;
-}
--- linux-2.6.10-rc2-mm2-full/sound/pci/korg1212/korg1212.c.old	2004-11-22 00:25:59.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/korg1212/korg1212.c	2004-11-22 00:26:25.000000000 +0100
@@ -472,7 +472,8 @@
                         "SPDIF-R",
 };
 
-u16 ClockSourceSelector[] = {0x8000,   // selects source as ADAT at 44.1 kHz
+static u16 ClockSourceSelector[] =
+                            {0x8000,   // selects source as ADAT at 44.1 kHz
                              0x0000,   // selects source as ADAT at 48 kHz
                              0x8001,   // selects source as S/PDIF at 44.1 kHz
                              0x0001,   // selects source as S/PDIF at 48 kHz
--- linux-2.6.10-rc2-mm2-full/sound/pci/rme9652/hdsp.c.old	2004-11-22 00:27:05.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/rme9652/hdsp.c	2004-11-22 00:27:47.000000000 +0100
@@ -1443,14 +1443,14 @@
 	return 0;
 }
 
-snd_rawmidi_ops_t snd_hdsp_midi_output =
+static snd_rawmidi_ops_t snd_hdsp_midi_output =
 {
 	.open =		snd_hdsp_midi_output_open,
 	.close =	snd_hdsp_midi_output_close,
 	.trigger =	snd_hdsp_midi_output_trigger,
 };
 
-snd_rawmidi_ops_t snd_hdsp_midi_input =
+static snd_rawmidi_ops_t snd_hdsp_midi_input =
 {
 	.open =		snd_hdsp_midi_input_open,
 	.close =	snd_hdsp_midi_input_close,
@@ -3137,7 +3137,7 @@
 static snd_kcontrol_new_t snd_hdsp_96xx_aeb = HDSP_AEB("Analog Extension Board", 0);
 static snd_kcontrol_new_t snd_hdsp_adat_sync_check = HDSP_ADAT_SYNC_CHECK;
 
-int snd_hdsp_create_controls(snd_card_t *card, hdsp_t *hdsp)
+static int snd_hdsp_create_controls(snd_card_t *card, hdsp_t *hdsp)
 {
 	unsigned int idx;
 	int err;
@@ -3651,7 +3651,7 @@
 	return 0;
 }
 
-void hdsp_midi_tasklet(unsigned long arg)
+static void hdsp_midi_tasklet(unsigned long arg)
 {
 	hdsp_t *hdsp = (hdsp_t *)arg;
 	
--- linux-2.6.10-rc2-mm2-full/sound/pci/rme9652/rme9652.c.old	2004-11-22 00:28:03.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/rme9652/rme9652.c	2004-11-22 00:28:14.000000000 +0100
@@ -1584,7 +1584,7 @@
 static snd_kcontrol_new_t snd_rme9652_adat1_input =
 RME9652_ADAT1_IN("ADAT1 Input Source", 0);
 
-int snd_rme9652_create_controls(snd_card_t *card, rme9652_t *rme9652)
+static int snd_rme9652_create_controls(snd_card_t *card, rme9652_t *rme9652)
 {
 	unsigned int idx;
 	int err;
--- linux-2.6.10-rc2-mm2-full/sound/pci/sonicvibes.c.old	2004-11-22 00:28:32.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/sonicvibes.c	2004-11-22 00:40:23.000000000 +0100
@@ -357,8 +357,8 @@
 	return value;
 }
 
-#ifdef CONFIG_SND_DEBUG
-void snd_sonicvibes_debug(sonicvibes_t * sonic)
+#if 0
+static void snd_sonicvibes_debug(sonicvibes_t * sonic)
 {
 	printk("SV REGS:          INDEX = 0x%02x  ", inb(SV_REG(sonic, INDEX)));
 	printk("                 STATUS = 0x%02x\n", inb(SV_REG(sonic, STATUS)));
--- linux-2.6.10-rc2-mm2-full/include/sound/trident.h.old	2004-11-22 00:30:31.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/include/sound/trident.h	2004-11-22 00:33:45.000000000 +0100
@@ -457,27 +457,23 @@
 		       int pcm_spdif_device,
 		       int max_wavetable_size,
 		       trident_t ** rtrident);
-int snd_trident_free(trident_t *trident);
 void snd_trident_gameport(trident_t *trident);
 
 int snd_trident_pcm(trident_t * trident, int device, snd_pcm_t **rpcm);
 int snd_trident_foldback_pcm(trident_t * trident, int device, snd_pcm_t **rpcm);
 int snd_trident_spdif_pcm(trident_t * trident, int device, snd_pcm_t **rpcm);
 int snd_trident_attach_synthesizer(trident_t * trident);
-int snd_trident_detach_synthesizer(trident_t * trident);
 snd_trident_voice_t *snd_trident_alloc_voice(trident_t * trident, int type, int client, int port);
 void snd_trident_free_voice(trident_t * trident, snd_trident_voice_t *voice);
 void snd_trident_start_voice(trident_t * trident, unsigned int voice);
 void snd_trident_stop_voice(trident_t * trident, unsigned int voice);
 void snd_trident_write_voice_regs(trident_t * trident, snd_trident_voice_t *voice);
-void snd_trident_clear_voices(trident_t * trident, unsigned short v_min, unsigned short v_max);
 
 /* TLB memory allocation */
 snd_util_memblk_t *snd_trident_alloc_pages(trident_t *trident, snd_pcm_substream_t *substream);
 int snd_trident_free_pages(trident_t *trident, snd_util_memblk_t *blk);
 snd_util_memblk_t *snd_trident_synth_alloc(trident_t *trident, unsigned int size);
 int snd_trident_synth_free(trident_t *trident, snd_util_memblk_t *blk);
-int snd_trident_synth_bzero(trident_t *trident, snd_util_memblk_t *blk, int offset, int size);
 int snd_trident_synth_copy_from_user(trident_t *trident, snd_util_memblk_t *blk, int offset, const char __user *data, int size);
 
 #endif /* __SOUND_TRIDENT_H */
--- linux-2.6.10-rc2-mm2-full/sound/pci/trident/trident_main.c.old	2004-11-22 00:29:29.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/trident/trident_main.c	2004-11-22 00:33:53.000000000 +0100
@@ -53,6 +53,9 @@
 #endif
 static int snd_trident_sis_reset(trident_t *trident);
 
+static void snd_trident_clear_voices(trident_t * trident, unsigned short v_min, unsigned short v_max);
+static int snd_trident_free(trident_t *trident);
+
 /*
  *  common I/O routines
  */
@@ -632,7 +635,7 @@
    Returns:     Delta value.
   
   ---------------------------------------------------------------------------*/
-unsigned int snd_trident_convert_rate(unsigned int rate)
+static unsigned int snd_trident_convert_rate(unsigned int rate)
 {
 	unsigned int delta;
 
@@ -692,7 +695,7 @@
    Returns:     Delta value.
   
   ---------------------------------------------------------------------------*/
-unsigned int snd_trident_spurious_threshold(unsigned int rate, unsigned int period_size)
+static unsigned int snd_trident_spurious_threshold(unsigned int rate, unsigned int period_size)
 {
 	unsigned int res = (rate * period_size) / 48000;
 	if (res < 64)
@@ -713,7 +716,7 @@
    Returns:     Control value.
   
   ---------------------------------------------------------------------------*/
-unsigned int snd_trident_control_mode(snd_pcm_substream_t *substream)
+static unsigned int snd_trident_control_mode(snd_pcm_substream_t *substream)
 {
 	unsigned int CTRL;
 	snd_pcm_runtime_t *runtime = substream->runtime;
@@ -770,8 +773,8 @@
   
   ---------------------------------------------------------------------------*/
 
-int snd_trident_allocate_pcm_mem(snd_pcm_substream_t * substream,
-				 snd_pcm_hw_params_t * hw_params)
+static int snd_trident_allocate_pcm_mem(snd_pcm_substream_t * substream,
+					snd_pcm_hw_params_t * hw_params)
 {
 	trident_t *trident = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
@@ -804,8 +807,8 @@
   
   ---------------------------------------------------------------------------*/
 
-int snd_trident_allocate_evoice(snd_pcm_substream_t * substream,
-				snd_pcm_hw_params_t * hw_params)
+static int snd_trident_allocate_evoice(snd_pcm_substream_t * substream,
+				       snd_pcm_hw_params_t * hw_params)
 {
 	trident_t *trident = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
@@ -3654,7 +3657,7 @@
   
   ---------------------------------------------------------------------------*/
 
-int snd_trident_free(trident_t *trident)
+static int snd_trident_free(trident_t *trident)
 {
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 	if (trident->gameport) {
@@ -3802,9 +3805,9 @@
 }
 
 /*---------------------------------------------------------------------------
-   snd_trident_attach_synthesizer, snd_trident_detach_synthesizer
+   snd_trident_attach_synthesizer
   
-   Description: Attach/detach synthesizer hooks
+   Description: Attach synthesizer hooks
                 
    Paramters:   trident  - device specific private data for 4DWave card
 
@@ -3823,17 +3826,6 @@
 	return 0;
 }
 
-int snd_trident_detach_synthesizer(trident_t *trident)
-{
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
-	if (trident->seq_dev) {
-		snd_device_free(trident->card, trident->seq_dev);
-		trident->seq_dev = NULL;
-	}
-#endif
-	return 0;
-}
-
 snd_trident_voice_t *snd_trident_alloc_voice(trident_t * trident, int type, int client, int port)
 {
 	snd_trident_voice_t *pvoice;
@@ -3906,7 +3898,7 @@
 		private_free(voice);
 }
 
-void snd_trident_clear_voices(trident_t * trident, unsigned short v_min, unsigned short v_max)
+static void snd_trident_clear_voices(trident_t * trident, unsigned short v_min, unsigned short v_max)
 {
 	unsigned int i, val, mask[2] = { 0, 0 };
 
@@ -3995,9 +3987,7 @@
 EXPORT_SYMBOL(snd_trident_start_voice);
 EXPORT_SYMBOL(snd_trident_stop_voice);
 EXPORT_SYMBOL(snd_trident_write_voice_regs);
-EXPORT_SYMBOL(snd_trident_clear_voices);
 /* trident_memory.c symbols */
 EXPORT_SYMBOL(snd_trident_synth_alloc);
 EXPORT_SYMBOL(snd_trident_synth_free);
-EXPORT_SYMBOL(snd_trident_synth_bzero);
 EXPORT_SYMBOL(snd_trident_synth_copy_from_user);
--- linux-2.6.10-rc2-mm2-full/sound/pci/trident/trident_memory.c.old	2004-11-22 00:33:59.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/trident/trident_memory.c	2004-11-22 00:34:21.000000000 +0100
@@ -450,29 +450,6 @@
 }
 
 /*
- * bzero(blk + offset, size)
- */
-int snd_trident_synth_bzero(trident_t *trident, snd_util_memblk_t *blk, int offset, int size)
-{
-	int page, nextofs, end_offset, temp, temp1;
-
-	offset += blk->offset;
-	end_offset = offset + size;
-	page = get_aligned_page(offset) + 1;
-	do {
-		nextofs = aligned_page_offset(page);
-		temp = nextofs - offset;
-		temp1 = end_offset - offset;
-		if (temp1 < temp)
-			temp = temp1;
-		memset(offset_ptr(trident, offset), 0, temp);
-		offset = nextofs;
-		page++;
-	} while (offset < end_offset);
-	return 0;
-}
-
-/*
  * copy_from_user(blk + offset, data, size)
  */
 int snd_trident_synth_copy_from_user(trident_t *trident, snd_util_memblk_t *blk, int offset, const char __user *data, int size)
--- linux-2.6.10-rc2-mm2-full/sound/pci/trident/trident_synth.c.old	2004-11-22 00:34:40.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/trident/trident_synth.c	2004-11-22 00:34:48.000000000 +0100
@@ -811,7 +811,7 @@
 	snd_seq_instr_list_free_cond(p->trident->synth.ilist, &ifree, client, 0);
 }
 
-int snd_trident_synth_event_input(snd_seq_event_t * ev, int direct, void *private_data, int atomic, int hop)
+static int snd_trident_synth_event_input(snd_seq_event_t * ev, int direct, void *private_data, int atomic, int hop)
 {
 	snd_trident_port_t *p = (snd_trident_port_t *) private_data;
 
--- linux-2.6.10-rc2-mm2-full/include/sound/ymfpci.h.old	2004-11-22 00:35:18.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/include/sound/ymfpci.h	2004-11-22 00:35:27.000000000 +0100
@@ -389,9 +389,6 @@
 int snd_ymfpci_mixer(ymfpci_t *chip, int rear_switch);
 int snd_ymfpci_timer(ymfpci_t *chip, int device);
 
-int snd_ymfpci_voice_alloc(ymfpci_t *chip, ymfpci_voice_type_t type, int pair, ymfpci_voice_t **rvoice);
-int snd_ymfpci_voice_free(ymfpci_t *chip, ymfpci_voice_t *pvoice);
-
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 #define SUPPORT_JOYSTICK
 #endif
--- linux-2.6.10-rc2-mm2-full/sound/pci/ymfpci/ymfpci_main.c.old	2004-11-22 00:35:36.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pci/ymfpci/ymfpci_main.c	2004-11-22 00:35:51.000000000 +0100
@@ -258,7 +258,7 @@
 	return -ENOMEM;
 }
 
-int snd_ymfpci_voice_alloc(ymfpci_t *chip, ymfpci_voice_type_t type, int pair, ymfpci_voice_t **rvoice)
+static int snd_ymfpci_voice_alloc(ymfpci_t *chip, ymfpci_voice_type_t type, int pair, ymfpci_voice_t **rvoice)
 {
 	unsigned long flags;
 	int result;
@@ -278,7 +278,7 @@
 	return result;		
 }
 
-int snd_ymfpci_voice_free(ymfpci_t *chip, ymfpci_voice_t *pvoice)
+static int snd_ymfpci_voice_free(ymfpci_t *chip, ymfpci_voice_t *pvoice)
 {
 	unsigned long flags;
 	

