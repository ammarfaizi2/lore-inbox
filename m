Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbRGDGCa>; Wed, 4 Jul 2001 02:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266508AbRGDGCO>; Wed, 4 Jul 2001 02:02:14 -0400
Received: from [202.96.209.78] ([202.96.209.78]:36606 "EHLO fep5.online.sh.cn")
	by vger.kernel.org with ESMTP id <S266507AbRGDGCB>;
	Wed, 4 Jul 2001 02:02:01 -0400
X-Lotus-FromDomain: ACER
From: Matt_Wu@acersoftech.com.cn
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <48256A7F.00217B73.00@cnshans1.acersoftech.com.cn>
Date: Wed, 4 Jul 2001 14:12:45 +0800
Subject: [PATCH] update for ALi Audio Driver
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Dear all,

Here is ALi M5451 audio's patch file. In this new release ,version 0.14.8, we've
made such modifications.

1, Set EBUF1 and EBUF2 to still mode to avoid that upon some platforms the audio
will stop after playing for a while.
2, Reset m5451 controller to avoid ac97 access timeout error.
3, Fix bug in power management function ali_restore_regs.
4, Add cache for ac97 access to avoid access to ac97 codec at runtime.


Best regards,

Matt Wu
http://www.ali.com.tw

Information about update:
Updated files:      trident.c trident.h
Location:      drivers/sound
Driver Version:     0.14.8
Kernel Version:     2.4.X

patch file:
--------------------------------------------------------------------
--- drivers/sound/trident.h.orig   Tue Jul  3 13:42:35 2001
+++ drivers/sound/trident.h   Tue Jul  3 13:44:18 2001
@@ -90,7 +90,10 @@
     T4D_STOP_B      = 0xb8, T4D_CSPF_B  = 0xbc,
     T4D_SBBL_SBCL  = 0xc0, T4D_SBCTRL_SBE2R_SBDD    = 0xc4,
     T4D_STIMER     = 0xc8, T4D_LFO_B_I2S_DELTA      = 0xcc,
-    T4D_AINT_B     = 0xd8, T4D_AINTEN_B    = 0xdc
+    T4D_AINT_B     = 0xd8, T4D_AINTEN_B    = 0xdc,
+    ALI_MPUR2 = 0x22,
+    ALI_EBUF1 = 0xf4,
+    ALI_EBUF2 = 0xf8
 };

 enum ali_op_registers {
@@ -137,6 +140,13 @@
     ALI_STOP_ALL_CHANNELS    = 0xffffffff,
     ALI_MULTI_CHANNELS_START_STOP = 0x07800000

+};
+
+enum ali_EMOD_control_bit {
+    ALI_EMOD_DEC   = 0x00000000,
+    ALI_EMOD_INC   = 0x10000000,
+    ALI_EMOD_Delay = 0x20000000,
+    ALI_EMOD_Still = 0x30000000
 };

 enum ali_pcm_in_channel_num {
--- drivers/sound/trident.c.orig   Tue Jul  3 13:41:23 2001
+++ drivers/sound/trident.c   Tue Jul  3 13:44:14 2001
@@ -12,7 +12,6 @@
  *  Hacked up by:
  *  Aaron Holtzman <aholtzma@ess.engr.uvic.ca>
  *  Ollie Lho <ollie@sis.com.tw> SiS 7018 Audio Core Support
- *  Ching-Ling Lee <cling-li@ali.com.tw> ALi 5451 Audio Core Support
  *  Matt Wu <mattwu@acersoftech.com.cn> ALi 5451 Audio Core Support
  *
  *
@@ -31,6 +30,13 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.8
+ *  Apr 30 2001 Matt Wu
+ *  Set EBUF1 and EBUF2 to still mode
+ *  Add dc97/ac97 reset function
+ *  Fix power management: ali_restore_regs
+ *  Mar 09 2001 Matt Wu
+ *  Add cache for ac97 access
  *  v0.14.7
  *  Feb 06 2001 Matt Wu
  *  Fix ac97 initialization
@@ -135,7 +141,7 @@

 #include <linux/pm.h>

-#define DRIVER_VERSION "0.14.6"
+#define DRIVER_VERSION "0.14.8"

 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC   0x5072696E /* "Prin" */
@@ -319,10 +325,12 @@
     struct trident_channel *(*alloc_rec_pcm_channel)(struct trident_card *);
     void (*free_pcm_channel)(struct trident_card *, unsigned int chan);
     void (*address_interrupt)(struct trident_card *);
+

-    /* Add by Matt Wu 01-05-2001 for spdif in */
-    int multi_channel_use_count;
-    int rec_channel_use_count;
+    //Add by Matt Wu 01-05-2001 for spdif in
+    int  multi_channel_use_count;
+    int  rec_channel_use_count;
+    //End add
 };

 /* table to map from CHANNELMASK to channel attribute for SiS 7018 */
@@ -338,10 +346,18 @@
     DSP_BIND_I2S, DSP_BIND_CENTER_LFE, DSP_BIND_SURR, DSP_BIND_SPDIF
 };

-/* Add by Matt Wu 01-05-2001 for spdif in */
+
+//Add by Matt Wu 01-05-2001 for spdif in
 static int ali_close_multi_channels(void);
-static void ali_delay(struct trident_card *card,int interval);
-static void ali_detect_spdif_rate(struct trident_card *card);
+void ali_delay(struct trident_card *card,int interval);
+void ali_detect_spdif_rate(struct trident_card *card);
+//End add
+
+u16 MixerRegs[64][NR_AC97];
+int bRegsReady = 0;
+
+static void ali_ac97_write(struct ac97_codec *codec, u8 reg, u16 val);
+static u16 ali_ac97_read(struct ac97_codec *codec, u8 reg);

 static struct trident_card *devs;

@@ -353,8 +369,8 @@
                    unsigned long arg);
 static loff_t trident_llseek(struct file *file, loff_t offset, int origin);

-static void ali_ac97_set(struct ac97_codec *codec, u8 reg, u16 val);
-static u16 ali_ac97_get(struct ac97_codec *codec, u8 reg);
+static void ali_ac97_set(struct trident_card *card, int secondary, u8 reg, u16
val);
+static u16 ali_ac97_get(struct trident_card *card, int secondary, u8 reg);
 static void ali_set_spdif_out_rate(struct trident_card *card, unsigned int
rate);
 static void ali_enable_special_channel(struct trident_state *stat);
 static struct trident_channel *ali_alloc_rec_pcm_channel(struct trident_card
*card);
@@ -381,6 +397,7 @@
     unsigned mixer_regs[ALI_MIXER_REGS];
 } ali_registers;

+
 #define seek_offset(dma_ptr, buffer, cnt, offset, copy_count)    (dma_ptr) +=
(offset); \
                                   (buffer) += (offset);     \
                                   (cnt) -= (offset);   \
@@ -599,6 +616,9 @@

     /* select hardware channel to write */
     outb(channel, TRID_REG(card, T4D_LFO_GC_CIR));
+#ifdef DEBUG
+    printk("GC_CIR=%xh\n", inb(TRID_REG(card, T4D_LFO_GC_CIR)));
+#endif

     /* Output the channel registers, but don't write register
        three to an ALI chip. */
@@ -607,6 +627,10 @@
               continue;
          outl(data[i], TRID_REG(card, CHANNEL_START + 4*i));
     }
+    if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+         outl(ALI_EMOD_Still, TRID_REG(card, ALI_EBUF1));
+         outl(ALI_EMOD_Still, TRID_REG(card, ALI_EBUF2));
+    }
     return TRUE;
 }

@@ -694,6 +718,9 @@
          rate = 4000;

     dmabuf->rate = rate;
+#ifdef DEBUG
+    printk("ch=%d rate=%xh\n", state->dmabuf.channel->num, rate);
+#endif
     dmabuf->channel->delta = compute_rate_play(rate);

     trident_write_voice_regs(state);
@@ -732,7 +759,7 @@
     struct dmabuf *dmabuf = &state->dmabuf;
     struct trident_channel *channel = dmabuf->channel;

-    channel->lba = dmabuf->dma_handle;
+    channel->lba = virt_to_bus(dmabuf->rawbuf);
     channel->delta = compute_rate_play(dmabuf->rate);

     channel->eso = dmabuf->dmasize >> sample_shift[dmabuf->fmt];
@@ -808,20 +835,20 @@
          return;
     }

-    channel->lba = dmabuf->dma_handle;
+    channel->lba = virt_to_bus(dmabuf->rawbuf);
     channel->delta = compute_rate_rec(dmabuf->rate);
     if ((card->pci_id == PCI_DEVICE_ID_ALI_5451) && (channel->num ==
ALI_SPDIF_IN_CHANNEL)) {
          rate = ali_get_spdif_in_rate(card);
          if (rate == 0)
          {
-              printk(KERN_WARNING "trident: ALi 5451 S/PDIF input setup
error!\n");
+              printk("Err: spdif-in setup error!\n");
               rate = 48000;
          }
          bval = inb(TRID_REG(card,ALI_SPDIF_CTRL));
          if (bval & 0x10)
          {
               outb(bval,TRID_REG(card,ALI_SPDIF_CTRL));
-              printk(KERN_WARNING "trident: cleared ALi 5451 S/PDIF parity
error flag.\n");
+              printk("clear SPDIF parity error flag.\n");
          }

          if (rate != 48000)
@@ -950,6 +977,7 @@
     trident_disable_voice_irq(card, chan_num);
 }

+
 static void stop_dac(struct trident_state *state)
 {
     struct trident_card *card = state->card;
@@ -989,7 +1017,7 @@
 static int alloc_dmabuf(struct trident_state *state)
 {
     struct dmabuf *dmabuf = &state->dmabuf;
-    void *rawbuf=NULL;
+    void *rawbuf = NULL;
     int order;
     struct page *page, *pend;

@@ -1074,21 +1102,14 @@
                    }
               }
               else {
-                   if ((order = state->dmabuf.buforder - 1) >= DMABUF_MINORDER)
{
-                        dmabuf->rawbuf =
pci_alloc_consistent(state->card->pci_dev,
-                                                   PAGE_SIZE << order,
-                                                   &dmabuf->dma_handle);
-                   }
+                   if ((order = state->dmabuf.buforder - 1) >= DMABUF_MINORDER)
+                        dmabuf->rawbuf = (void *)__get_free_pages(GFP_KERNEL |
GFP_DMA, order);
                    if (!dmabuf->rawbuf) {
                         free_pages((unsigned long)state->dmabuf.rawbuf,
state->dmabuf.buforder);
                         state->dmabuf.rawbuf = NULL;
                         i-=2;
-                        for (; i >= 0; i--) {
-                             pci_free_consistent(state->card->pci_dev,
-                                            PAGE_SIZE <<
state->other_states[i]->dmabuf.buforder,
-
state->other_states[i]->dmabuf.rawbuf,
-
state->other_states[i]->dmabuf.dma_handle);
-                        }
+                        for (; i >= 0; i--)
+                             free_pages((unsigned
long)state->other_states[i]->dmabuf.rawbuf,
state->other_states[i]->dmabuf.buforder);
                         unlock_set_fmt(state);
                         return -ENOMEM;
                    }
@@ -1234,7 +1255,6 @@
               tmo = (dmabuf->dmasize * HZ) / dmabuf->rate;
          }
          tmo >>= sample_shift[dmabuf->fmt];
-//       printk("trident: diff=%d count= %d/%d total=%d tmo=%d hwptr=%d
swptr=%d
curptr=%d\n",diff,dmabuf->count,dmabuf->dmasize,dmabuf->total_bytes,tmo,dmabuf->hwptr,dmabuf->swptr,trident_get_dma_addr(state));
          if (!schedule_timeout(tmo ? tmo : 1) && tmo){
               break;
          }
@@ -1461,7 +1481,7 @@
                    if (!ret) ret = -EAGAIN;
                    return ret;
               }
-              /* No matter how much space left in the buffer, we have to wait
until
+              /* No matter how much space left in the buffer, we have to wait
untill
                  CSO == ESO/2 or CSO == ESO when address engine interrupts */
               tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 2);
               tmo >>= sample_shift[dmabuf->fmt];
@@ -1479,7 +1499,7 @@
                           dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
                           dmabuf->hwptr, dmabuf->swptr);
 #endif
-                   /* a buffer overrun, we delay the recovery until next time
the
+                   /* a buffer overrun, we delay the recovery untill next time
the
                       while loop begin and we REALLY have space to record */
               }
               if (signal_pending(current)) {
@@ -1561,7 +1581,7 @@
                    if (!ret) ret = -EAGAIN;
                    return ret;
               }
-              /* No matter how much data left in the buffer, we have to wait
until
+              /* No matter how much data left in the buffer, we have to wait
untill
                  CSO == ESO/2 or CSO == ESO when address engine interrupts */
               lock_set_fmt(state);
               tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 2);
@@ -1581,7 +1601,7 @@
                           dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
                           dmabuf->hwptr, dmabuf->swptr);
 #endif
-                   /* a buffer underrun, we delay the recovery until next time
the
+                   /* a buffer underrun, we delay the recovery untill next time
the
                       while loop begin and we REALLY have data to play */
               }
               if (signal_pending(current)) {
@@ -1644,17 +1664,10 @@
     unsigned int mask = 0;

     VALIDATE_STATE(state);
-
-    if (file->f_mode & FMODE_WRITE) {
-         if (!dmabuf->ready && prog_dmabuf(state, 0))
-              return 0;
+    if (file->f_mode & FMODE_WRITE)
          poll_wait(file, &dmabuf->wait, wait);
-    }
-    if (file->f_mode & FMODE_READ) {
-         if (!dmabuf->ready && prog_dmabuf(state, 1))
-              return 0;
+    if (file->f_mode & FMODE_READ)
          poll_wait(file, &dmabuf->wait, wait);
-    }

     spin_lock_irqsave(&state->card->lock, flags);
     trident_update_ptr(state);
@@ -1877,13 +1890,14 @@
                              }
                              down(&state->card->open_sem);
                              ret = ali_allocate_other_states_resources(state,
6);
+                             up(&state->card->open_sem);
                              if (ret < 0) {
-                                  up(&state->card->open_sem);
                                   unlock_set_fmt(state);
                                   return ret;
                              }
+                             //Added by Matt Wu
                              state->card->multi_channel_use_count ++;
-                             up(&state->card->open_sem);
+                             //End add
                         }
                         else val = 2;   /*yield to 2-channels*/
                    }
@@ -1939,7 +1953,7 @@
     case SNDCTL_DSP_GETOSPACE:
          if (!(file->f_mode & FMODE_WRITE))
               return -EINVAL;
-         if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
+         if (!dmabuf->enable && (val = prog_dmabuf(state, 0)) != 0)
               return val;
          spin_lock_irqsave(&state->card->lock, flags);
          trident_update_ptr(state);
@@ -1953,7 +1967,7 @@
     case SNDCTL_DSP_GETISPACE:
          if (!(file->f_mode & FMODE_READ))
               return -EINVAL;
-         if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0)
+         if (!dmabuf->enable && (val = prog_dmabuf(state, 1)) != 0)
               return val;
          spin_lock_irqsave(&state->card->lock, flags);
          trident_update_ptr(state);
@@ -1974,9 +1988,9 @@

     case SNDCTL_DSP_GETTRIGGER:
          val = 0;
-         if ((file->f_mode & FMODE_READ) && dmabuf->enable)
+         if (file->f_mode & FMODE_READ && dmabuf->enable)
               val |= PCM_ENABLE_INPUT;
-         if ((file->f_mode & FMODE_WRITE) && dmabuf->enable)
+         if (file->f_mode & FMODE_WRITE && dmabuf->enable)
               val |= PCM_ENABLE_OUTPUT;
          return put_user(val, (int *)arg);

@@ -2004,8 +2018,6 @@
     case SNDCTL_DSP_GETIPTR:
          if (!(file->f_mode & FMODE_READ))
               return -EINVAL;
-         if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0)
-              return val;
          spin_lock_irqsave(&state->card->lock, flags);
          trident_update_ptr(state);
          cinfo.bytes = dmabuf->total_bytes;
@@ -2019,8 +2031,6 @@
     case SNDCTL_DSP_GETOPTR:
          if (!(file->f_mode & FMODE_WRITE))
               return -EINVAL;
-         if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
-              return val;
          spin_lock_irqsave(&state->card->lock, flags);
          trident_update_ptr(state);
          cinfo.bytes = dmabuf->total_bytes;
@@ -2037,8 +2047,6 @@
     case SNDCTL_DSP_GETODELAY:
          if (!(file->f_mode & FMODE_WRITE))
               return -EINVAL;
-         if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
-              return val;
          spin_lock_irqsave(&state->card->lock, flags);
          trident_update_ptr(state);
          val = dmabuf->count;
@@ -2098,19 +2106,21 @@
     struct trident_state *state = NULL;
     struct dmabuf *dmabuf = NULL;

+    //Add by Matt Wu 01-05-2001
+    if(file->f_mode & FMODE_READ)
+    {
+         if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+              if (card->multi_channel_use_count > 0) {
+                   printk("Err: The card is now set as multi_channels
mode!\n");
+                   return -EBUSY;
+              }
+         }
+    }
+    //End add
+
     /* find an avaiable virtual channel (instance of /dev/dsp) */
     while (card != NULL) {
          down(&card->open_sem);
-         if(file->f_mode & FMODE_READ)
-         {
-              /* Skip opens on cards that are in 6 channel mode */
-              if (card->multi_channel_use_count > 0)
-              {
-                   up(&card->open_sem);
-                   card = card->next;
-                   continue;
-              }
-         }
          for (i = 0; i < NR_HW_CH; i++) {
               if (card->states[i] == NULL) {{nt
                    state = card->states[i] = (struct trident_state *)
@@ -2168,6 +2178,7 @@
     }

     if (file->f_mode & FMODE_READ) {
+
          /* FIXME: Trident 4d can only record in signed 16-bits stereo, 48kHz
sample,
             to be dealed with in trident_set_adc_rate() ?? */
          dmabuf->fmt &= ~TRIDENT_FMT_MASK;
@@ -2183,7 +2194,12 @@
                    (CHANNEL_REC|PCM_LR|MONO_MIX);
          }
          trident_set_adc_rate(state, 8000);
-         card->rec_channel_use_count ++;
+
+         //Add by Matt Wu 01-05-2001
+         if(card->pci_id == PCI_DEVICE_ID_ALI_5451)
+              card->rec_channel_use_count ++;
+         //End add
+
     }

     state->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
@@ -2225,24 +2241,31 @@
          dealloc_dmabuf(state);
          state->card->free_pcm_channel(state->card, dmabuf->channel->num);

-         if (state->chans_num > 2)
-         {
-              if( card->multi_channel_use_count-- < 0 )
-                   card->multi_channel_use_count = 0;
-
-              if (card->multi_channel_use_count == 0)
-                   ali_close_multi_channels();
-
-              ali_free_other_states_resources(state);
+         //Added by Matt Wu
+         if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+              if (state->chans_num > 2) {
+                   if (card->multi_channel_use_count-- < 0)
+                        card->multi_channel_use_count = 0;
+                   if (card->multi_channel_use_count == 0)
+                        ali_close_multi_channels();
+                   ali_free_other_states_resources(state);
+              }
          }
+         //End add
+
     }
     if (file->f_mode & FMODE_READ) {
          stop_adc(state);
          dealloc_dmabuf(state);
          state->card->free_pcm_channel(state->card, dmabuf->channel->num);

-         if( card->rec_channel_use_count-- < 0 )
-              card->rec_channel_use_count = 0;
+         //Added by Matt Wu
+         if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+              if( card->rec_channel_use_count-- < 0 )
+                   card->rec_channel_use_count = 0;
+         }
+         //End add
+
     }

     card->states[state->virt] = NULL;
@@ -2373,9 +2396,8 @@
 }

 /* Write AC97 codec registers for ALi*/
-static void ali_ac97_set(struct ac97_codec *codec, u8 reg, u16 val)
+static void ali_ac97_set(struct trident_card *card, int secondary, u8 reg, u16
val)
 {
-    struct trident_card *card = (struct trident_card *)codec->private_data;
     unsigned int address, mask;
     unsigned int wCount1 = 0xffff;
     unsigned int wCount2= 0xffff;
@@ -2384,13 +2406,10 @@
     u32 data;

     data = ((u32) val) << 16;
-
-    if(!card)
-         BUG();
-
     address = ALI_AC97_WRITE;
     mask = ALI_AC97_WRITE_ACTION | ALI_AC97_AUDIO_BUSY;
-    if (codec->id)
+
+    if (secondary)
          mask |= ALI_AC97_SECONDARY;
     if (card->revision == ALI_5451_V02)
          mask |= ALI_AC97_WRITE_MIXER_REGISTER;
@@ -2421,9 +2440,8 @@
 }

 /* Read AC97 codec registers for ALi*/
-static u16 ali_ac97_get(struct ac97_codec *codec, u8 reg)
+static u16 ali_ac97_get(struct trident_card *card, int secondary, u8 reg)
 {
-    struct trident_card *card = (struct trident_card *)codec->private_data;
     unsigned int address, mask;
         unsigned int wCount1 = 0xffff;
         unsigned int wCount2= 0xffff;
@@ -2434,10 +2452,9 @@
     address = ALI_AC97_READ;
     if (card->revision == ALI_5451_V02) {
          address = ALI_AC97_WRITE;
-         mask &= ALI_AC97_READ_MIXER_REGISTER;
     }
     mask = ALI_AC97_READ_ACTION | ALI_AC97_AUDIO_BUSY;
-    if (codec->id)
+    if (secondary)
          mask |= ALI_AC97_SECONDARY;

     spin_lock_irqsave(&card->lock, flags);
@@ -2469,6 +2486,58 @@
     printk(KERN_ERR "ali: AC97 CODEC read timed out.\n");
     return 0;
 }
+static u16 ali_ac97_read(struct ac97_codec *codec, u8 reg)
+{
+    int id;
+    u16 data;
+    struct trident_card *card = NULL;
+
+    //Added by Matt Wu
+    if (!codec) {
+         printk("ac97 read error: INVALID CODEC.\n" );
+         return 0;
+    }
+
+    card = (struct trident_card *)codec->private_data;
+
+    if(!bRegsReady)
+         return ali_ac97_get(card, codec->id, reg);
+
+    if(codec->id)
+         id = 1;
+    else
+         id = 0;
+
+    data = MixerRegs[reg/2][id];
+    return data;
+}
+
+static void ali_ac97_write(struct ac97_codec *codec, u8 reg, u16 val)
+{
+    int id;
+    struct trident_card *card = NULL;
+
+    //Added by Matt Wu
+    if (!codec) {
+         printk("ac97 write error: INVALID CODEC.\n" );
+         return;
+    }
+
+    card = (struct trident_card *)codec->private_data;
+
+    if (!bRegsReady) {
+         ali_ac97_set(card, codec->id, reg, val);
+         return;
+    }
+
+    if(codec->id)
+         id = 1;
+    else
+         id = 0;
+
+    MixerRegs[reg/2][id] = val;
+    ali_ac97_set(card, codec->id, reg, val);
+}

 static void ali_enable_special_channel(struct trident_state *stat)
 {
@@ -2478,13 +2547,15 @@
     s_channels = inl(TRID_REG(card, ALI_GLOBAL_CONTROL));
     s_channels |= (1<<stat->dmabuf.channel->num);
     outl(s_channels, TRID_REG(card, ALI_GLOBAL_CONTROL));
+#ifdef DEBUG
+    printk("D4h=%lxh\n", inl(TRID_REG(card, ALI_GLOBAL_CONTROL)));
+#endif
 }

 /*
 flag:    ALI_SPDIF_OUT_TO_SPDIF_OUT
     ALI_PCM_TO_SPDIF_OUT
 */
-
 static void ali_setup_spdif_out(struct trident_card *card, int flag)
 {
     unsigned long spdif;
@@ -2493,7 +2564,7 @@
         char temp;
         struct pci_dev *pci_dev = NULL;

-        pci_dev = pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533,
pci_dev);
+        pci_dev = pci_find_device(0x10b9,0x1533, pci_dev);
         if (pci_dev == NULL)
                 return;
         pci_read_config_byte(pci_dev, 0x61, &temp);
@@ -2507,6 +2578,7 @@
         temp |= 0x10;
         pci_write_config_byte(pci_dev, 0x7e, temp);

+
     ch = inb(TRID_REG(card, ALI_SCTRL));
     outb(ch | ALI_SPDIF_OUT_ENABLE, TRID_REG(card, ALI_SCTRL));
     ch = inb(TRID_REG(card, ALI_SPDIF_CTRL));
@@ -2574,7 +2646,7 @@
 */
 }

-static void ali_delay(struct trident_card *card,int interval)
+void ali_delay(struct trident_card *card,int interval)
 {
     unsigned long  begintimer,currenttimer;

@@ -2585,7 +2657,7 @@
          currenttimer = inl(TRID_REG(card,  ALI_STIMER));
 }

-static void ali_detect_spdif_rate(struct trident_card *card)
+void ali_detect_spdif_rate(struct trident_card *card)
 {
     u16 wval  = 0;
     u16 count = 0;
@@ -2611,7 +2683,7 @@

     if (count > 50000)
     {
-         printk(KERN_WARNING "trident: Error in ali_detect_spdif_rate!\n");
+         printk("Error in ali_detect_spdif_rate!\n");
          return;
     }

@@ -2634,7 +2706,7 @@

     if (count > 50000)
     {
-         printk(KERN_WARNING "trident: Error in ali_detect_spdif_rate!\n");
+         printk("Error in ali_detect_spdif_rate!\n");
          return;
     }

@@ -2704,18 +2776,18 @@

 }

-static int ali_close_multi_channels(void)
+static int ali_close_multi_channels()
 {
     char temp = 0;
     struct pci_dev *pci_dev = NULL;

-        pci_dev = pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533,
pci_dev);
+        pci_dev = pci_find_device(0x10b9,0x1533, pci_dev);
         if (pci_dev == NULL)
                 return -1;
     temp = 0x80;
     pci_write_config_byte(pci_dev, 0x59, ~temp);

-    pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
pci_dev);
+    pci_dev = pci_find_device(0x10b9,0x7101, pci_dev);
     if (pci_dev == NULL)
                 return -1;

@@ -2731,33 +2803,84 @@
     char temp = 0;
     struct pci_dev *pci_dev = NULL;

-    pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
pci_dev);
+    pci_dev = pci_find_device(0x10b9,0x1533, pci_dev);
     if (pci_dev == NULL)
                 return -1;
+#ifdef DEBUG
+    pci_read_config_byte(pci_dev, 0x59, &temp);
+    printk("Old value of 1533 59h=%xh\n", temp);
+#endif
     temp = 0x80;
     pci_write_config_byte(pci_dev, 0x59, temp);
+#ifdef DEBUG
+    printk("1533 59h=%xh\n", temp);
+#endif

-    pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
pci_dev);
+    pci_dev = pci_find_device(0x10b9,0x7101, pci_dev);
     if (pci_dev == NULL)
                 return -1;
+#ifdef DEBUG
+    pci_read_config_byte(pci_dev, 0xB8, &temp);
+    printk("Old value of 7101 B8h=%xh\n", temp);
+#endif
     temp = 0x20;
     pci_write_config_byte(pci_dev, (int)0xB8,(u8) temp);
+#ifdef DEBUG
+        printk("7101 b8h=%xh\n", temp);
+#endif
     if (chan_nums == 6) {
          dwValue = inl(TRID_REG(card, ALI_SCTRL)) | 0x000f0000;
          outl(dwValue, TRID_REG(card, ALI_SCTRL));
-         mdelay(4);
-         dwValue = inl(TRID_REG(card, ALI_SCTRL));
-         if (dwValue & 0x2000000) {
-              ali_ac97_set(card->ac97_codec[0], 0x02, 8080);
-              ali_ac97_set(card->ac97_codec[0], 0x36, 0);
-              ali_ac97_set(card->ac97_codec[0], 0x38, 0);
-              ali_ac97_set(card->ac97_codec[1], 0x36, 0);
-              ali_ac97_set(card->ac97_codec[1], 0x38, 0);
-              ali_ac97_set(card->ac97_codec[1], 0x02, 0);
-              ali_ac97_set(card->ac97_codec[1], 0x18, 0x0808);
-              ali_ac97_set(card->ac97_codec[1], 0x74, 0x3);
-              return 1;
-         }
+#ifdef DEBUG
+         printk("SCTRL=%lxh\n", inl(TRID_REG(card, ALI_SCTRL)));
+#endif
+         udelay(4000);
+         //while(--wCount) {
+              dwValue = inl(TRID_REG(card, ALI_SCTRL));
+              if (dwValue & 0x2000000) {
+#ifdef DEBUG
+                   printk("codec0 28h= %xh\n", ali_ac97_get(card, 0, 0x28));
+                   printk("codec0 2ch= %xh\n", ali_ac97_get(card, 0, 0x2c));
+                   printk("codec0 2eh= %xh\n", ali_ac97_get(card, 0, 0x2E));
+                   printk("codec0 30h= %xh\n", ali_ac97_get(card, 0, 0x30));
+                   printk("codec1 28h= %xh\n", ali_ac97_get(card, 1, 0x28));
+                                printk("codec1 2ch= %xh\n", ali_ac97_get(card,
1, 0x2c));
+                                printk("codec1 2eh= %xh\n", ali_ac97_get(card,
1, 0x2E));
+                                printk("codec1 30h= %xh\n", ali_ac97_get(card,
1, 0x30));
+                   //printk("codec0 2ch= %xh\n", ali_ac97_get(card, 0, 0x32));
+                   printk("codec0 02h= %xh\n", ali_ac97_get(card, 0, 0x02));
+#endif
+                   ali_ac97_write(card->ac97_codec[0], 0x02, 8080);
+#ifdef DEBUG
+                   printk("codec0 02h= %xh\n", ali_ac97_get(card, 0, 0x02));
+#endif
+                   ali_ac97_write(card->ac97_codec[0], 0x36, 0);
+#ifdef DEBUG
+                   printk("after set codec 0 36h, codec0 02h= %xh\n",
ali_ac97_get(card, 0, 0x02));
+#endif
+                   ali_ac97_write(card->ac97_codec[0], 0x38, 0);
+#ifdef DEBUG
+                   printk("after set codec0 38h, codec0 02h= %xh\n",
ali_ac97_get(card, 0, 0x02));
+#endif
+                   ali_ac97_write(card->ac97_codec[1], 0x36, 0);
+#ifdef DEBUG
+                   printk("after set codec 1 36h, codec0 02h= %xh\n",
ali_ac97_get(card, 0, 0x02));
+#endif
+                                ali_ac97_write(card->ac97_codec[1], 0x38, 0);
+#ifdef DEBUG
+                   printk("after set codec 1 38h, codec0 02h= %xh\n",
ali_ac97_get(card, 0, 0x02));
+#endif
+                   ali_ac97_write(card->ac97_codec[1], 0x02, 0x0606);
+                   ali_ac97_write(card->ac97_codec[1], 0x18, 0x0303);
+                   ali_ac97_write(card->ac97_codec[1], 0x74, 0x3);
+#ifdef DEBUG
+                   printk("codec1 02h= %xh\n", ali_ac97_get(card, 1, 0x02));
+                    printk("codec1 18h= %xh\n", ali_ac97_get(card, 1, 0x18));
+                    printk("codec1 74h= %xh\n", ali_ac97_get(card, 1, 0x74));
+#endif
+                   return 1;
+              }
+         //}
     }
     return -EINVAL;
 }
@@ -2853,7 +2976,7 @@
     outl(ALI_DISABLE_ALL_IRQ, TRID_REG(card, T4D_MISCINT));

     for (i = 1; i < ALI_MIXER_REGS; i++)
-         ali_registers.mixer_regs[i] = ali_ac97_get (card->ac97_codec[0], i*2);
+         ali_registers.mixer_regs[i] = ali_ac97_read (card->ac97_codec[0],
i*2);

     for (i = 0; i < ALI_GLOBAL_REGS; i++)
     {
@@ -2884,7 +3007,7 @@
     cli();

     for (i = 1; i < ALI_MIXER_REGS; i++)
-         ali_ac97_set(card->ac97_codec[0], i*2, ali_registers.mixer_regs[i]);
+         ali_ac97_write(card->ac97_codec[0], i*2, ali_registers.mixer_regs[i]);

     for (i = 0; i < ALI_CHANNELS; i++)
     {
@@ -2941,7 +3064,7 @@
               return channel;
          }
     }
-
+
     for (idx = ALI_PCM_OUT_CHANNEL_FIRST; idx <= ALI_PCM_OUT_CHANNEL_LAST ;
idx++) {
          if (!(bank->bitmap & (1 << idx))) {
               struct trident_channel *channel = &bank->channels[idx];
@@ -2952,7 +3075,7 @@
     }

     /* no more free channels avaliable */
-//  printk(KERN_ERR "ali: no more channels available on Bank A.\n");
+    printk(KERN_ERR "ali: no more channels available on Bank A.\n");
     return NULL;
 }

@@ -2975,7 +3098,7 @@
     }

     /* no free recordable channels avaliable */
-//  printk(KERN_ERR "ali: no recordable channels available on Bank A.\n");
+    printk(KERN_ERR "ali: no recordable channels available on Bank A.\n");
     return NULL;
 }

@@ -2984,6 +3107,9 @@
     unsigned char ch_st_sel;
     unsigned short status_rate;

+#ifdef DEBUG
+    printk("ali: spdif out rate =%d\n", rate);
+#endif
     switch(rate) {
     case 44100:
          status_rate = 0;
@@ -3006,6 +3132,9 @@
     ch_st_sel &= (~0x80);    //select left
     outb(ch_st_sel, TRID_REG(card, ALI_SPDIF_CTRL));
     outw(status_rate | 0x10, TRID_REG(card, ALI_SPDIF_CS + 2));
+#ifdef DEBUG
+    printk("ali: SPDIF_CS=%lxh\n", inl(TRID_REG(card, ALI_SPDIF_CS)));
+#endif
 }

 static void ali_address_interrupt(struct trident_card *card)
@@ -3164,34 +3293,20 @@
 {
     struct trident_card *card = (struct trident_card *)data;
     unsigned long flags;
-    char c;
-
-    if (count<0)
-         return -EINVAL;
-    if (count == 0)
-         return 0;
-    if (get_user(c, buffer))
-         return -EFAULT;

     spin_lock_irqsave(&card->lock, flags);
-    switch (c) {
-        case '0':
+    if (*buffer == '0') {    //default
          ali_setup_spdif_out(card, ALI_PCM_TO_SPDIF_OUT);
          ali_disable_special_channel(card, ALI_SPDIF_OUT_CHANNEL);
-         break;
-        case '1':
+    }
+    else if (*buffer == '1')
          ali_setup_spdif_out(card,
ALI_SPDIF_OUT_TO_SPDIF_OUT|ALI_SPDIF_OUT_PCM);
-         break;
-        case '2':
+    else if (*buffer == '2') //AC3 data
          ali_setup_spdif_out(card,
ALI_SPDIF_OUT_TO_SPDIF_OUT|ALI_SPDIF_OUT_NON_PCM);
-         break;
-        case '3':
+    else if (*buffer == '3')
          ali_disable_spdif_in(card);    //default
-         break;
-        case '4':
+    else if (*buffer == '4')
          ali_setup_spdif_in(card);
-         break;
-    }
     spin_unlock_irqrestore(&card->lock, flags);

     return count;
@@ -3236,29 +3351,120 @@
     open:          trident_open_mixdev,
 };

+static int ali_reset_5451(struct trident_card *card)
+{
+    struct pci_dev *pci_dev = NULL;
+    unsigned int   dwVal;
+    unsigned short wCount, wReg;
+
+        pci_dev = pci_find_device(0x10b9,0x1533, pci_dev);
+    if (pci_dev == NULL){
+         return -1;
+    }
+
+    pci_read_config_dword(pci_dev, 0x7c, &dwVal);
+    pci_write_config_dword(pci_dev, 0x7c, dwVal | 0x08000000);
+    udelay(5000);
+    pci_read_config_dword(pci_dev, 0x7c, &dwVal);
+    pci_write_config_dword(pci_dev, 0x7c, dwVal & 0xf7ffffff);
+    udelay(5000);
+
+        pci_dev = card->pci_dev;
+    if (pci_dev == NULL){
+         return -1;
+    }
+    pci_read_config_dword(pci_dev, 0x44, &dwVal);
+    pci_write_config_dword(pci_dev, 0x44, dwVal | 0x000c0000);
+    udelay(500);
+    pci_read_config_dword(pci_dev, 0x44, &dwVal);
+    pci_write_config_dword(pci_dev, 0x44, dwVal & 0xfffbffff);
+    udelay(5000);
+
+    wCount = 200;
+    while(wCount--) {

+         wReg = ali_ac97_get(card, 0, AC97_POWER_CONTROL);
+         if((wReg & 0x000f) == 0x000f)
+              return 0;
+         udelay(500);
+    }
+    return 0;
+}
+static int ali_reset_codec(struct ac97_codec *codec)
+{
+    struct pci_dev *pci_dev = NULL;
+    unsigned char bVal = 0;
+    unsigned int   dwVal;
+    unsigned short wCount, wReg;
+    struct trident_card *card = NULL;
+
+
+    card = (struct trident_card *)codec->private_data;
+    if (!card) {
+         printk("ali_reset_codec: invalid structure codec.\n");
+         return -1;
+    }
+
+        pci_dev = pci_find_device(0x10b9,0x1533, pci_dev);
+    if (pci_dev == NULL){
+         return -1;
+    }
+
+    pci_read_config_dword(pci_dev, 0x7c, &dwVal);
+    pci_write_config_dword(pci_dev, 0x7c, dwVal | 0x08000000);
+    udelay(5000);
+    pci_read_config_dword(pci_dev, 0x7c, &dwVal);
+    pci_write_config_dword(pci_dev, 0x7c, dwVal & 0xf7ffffff);
+    udelay(5000);
+
+    bVal = inb(TRID_REG(card,ALI_SCTRL));
+    bVal |= 0x02;
+    outb(TRID_REG(card,ALI_SCTRL),bVal);
+    udelay(50);
+    bVal = inb(TRID_REG(card,ALI_SCTRL));
+    bVal &= 0xfd;
+    outb(TRID_REG(card,ALI_SCTRL),bVal);
+    udelay(5000);
+
+    wCount = 200;
+    while(wCount--) {
+         wReg = ali_ac97_get(card, 0, AC97_POWER_CONTROL);
+         if((wReg & 0x000f) == 0x000f)
+              return 0;
+         udelay(500);
+    }
+    return -1;
+}
+
 /* AC97 codec initialisation. */
 static int __init trident_ac97_init(struct trident_card *card)
 {
     int num_ac97 = 0;
     unsigned long ready_2nd = 0;
     struct ac97_codec *codec;
+    int i = 0;

     /* initialize controller side of AC link, and find out if secondary codes
        really exist */
-    switch (card->pci_id)
-    {
+
+    switch (card->pci_id) {
+
     case PCI_DEVICE_ID_ALI_5451:
-         outl(0x80000000,TRID_REG(card, ALI_GLOBAL_CONTROL));
-         outl(0x00000000,TRID_REG(card, 0xa4));
-         outl(0xffffffff,TRID_REG(card, 0x98));
-         outl(0x00000000,TRID_REG(card, 0xa8));
-         outb(0x10,     TRID_REG(card, 0x22));
+         if (ali_reset_5451(card)) {
+              printk("trident_ac97_init: err reset 5451.\n");
+              return -1;
+         }
+         outl(0x80000001,TRID_REG(card, ALI_GLOBAL_CONTROL));
+         outl(0x00000000,TRID_REG(card, T4D_AINTEN_A));
+         outl(0xffffffff,TRID_REG(card, T4D_AINT_A));
+         outl(0x00000000,TRID_REG(card, T4D_MUSICVOL_WAVEVOL));
+         outb(0x10,     TRID_REG(card, ALI_MPUR2));
          ready_2nd = inl(TRID_REG(card, ALI_SCTRL));
          ready_2nd &= 0x3fff;
          outl(ready_2nd | PCMOUT | 0x8000, TRID_REG(card, ALI_SCTRL));
          ready_2nd = inl(TRID_REG(card, ALI_SCTRL));
          ready_2nd &= SI_AC97_SECONDARY_READY;
-//       printk("codec 2 ready flag= %lx\n", ready_2nd);
+         if (card->revision < ALI_5451_V02)
+              ready_2nd = 0;
          break;
     case PCI_DEVICE_ID_SI_7018:
          /* disable AC97 GPIO interrupt */
@@ -3295,8 +3501,8 @@
          codec->id = num_ac97;

          if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
-              codec->codec_read = ali_ac97_get;
-              codec->codec_write = ali_ac97_set;
+              codec->codec_read = ali_ac97_read;
+              codec->codec_write = ali_ac97_write;
          }
          else {
               codec->codec_read = trident_ac97_get;
@@ -3316,35 +3522,41 @@

          /* if there is no secondary codec at all, don't probe any more */
          if (!ready_2nd)
-              return num_ac97+1;
+              break;
+    }
+
+    if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+
+         for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
+
+              if (card->ac97_codec[num_ac97] == NULL)
+                   break;
+/*
+              if (ali_reset_codec(card->ac97_codec[num_ac97])) {{e
+                   printk("trident_ac97_init: err reset codec.\n");
+                   return -1;
+              }
+*/
+              for (i=0; i<64;i++)
+                   MixerRegs[i][num_ac97] = ali_ac97_get(card, num_ac97,i*2);
+         }
     }

     return 1/*num_ac97*/;
 }

 /* install the driver, we do not allocate hardware channel nor DMA buffer now,
they are defered
-   until "ACCESS" time (in prog_dmabuf called by open/read/write/ioctl/mmap) */
+   untill "ACCESS" time (in prog_dmabuf called by open/read/write/ioctl/mmap)
*/
 static int __init trident_probe(struct pci_dev *pci_dev, const struct
pci_device_id *pci_id)
 {
     unsigned long iobase;
     struct trident_card *card;
-    dma_addr_t mask;
-    int bits;
     u8 revision;
+    int i;

-    if (pci_enable_device(pci_dev))
-        return -ENODEV;
-
-    if (pci_dev->device == PCI_DEVICE_ID_ALI_5451) {
-         mask = 0xffffffff;
-         bits = 32;
-    } else {
-         mask = TRIDENT_DMA_MASK;
-         bits = 30;
-    }
-    if (pci_set_dma_mask(pci_dev, mask)) {
+    if (!pci_dma_supported(pci_dev, TRIDENT_DMA_MASK)) {
          printk(KERN_ERR "trident: architecture does not support"
-                " %dbit PCI busmaster DMA\n", bits);
+                " 30bit PCI busmaster DMA\n");
          return -ENODEV;
     }
     pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &revision);
@@ -3356,6 +3568,9 @@
          return -ENODEV;
     }

+    if (pci_enable_device(pci_dev))
+        return -ENODEV;
+
     if ((card = kmalloc(sizeof(struct trident_card), GFP_KERNEL)) == NULL) {
          printk(KERN_ERR "trident: out of memory\n");
          return -ENOMEM;
@@ -3398,9 +3613,11 @@

          card->address_interrupt = ali_address_interrupt;

-         /* Added by Matt Wu 01-05-2001 for spdif in */
+         //Add by Matt Wu 01-05-2001 for spdif in
          card->multi_channel_use_count = 0;
          card->rec_channel_use_count = 0;
+         //End add
+

          /* ALi SPDIF OUT function */
          if(card->revision == ALI_5451_V02) {
@@ -3438,27 +3655,39 @@
          kfree(card);
          return -ENODEV;
     }
-    /* initialize AC97 codec and register /dev/mixer */
+    bRegsReady = 0;
+    /* initilize AC97 codec and register /dev/mixer */
     if (trident_ac97_init(card) <= 0) {
+    /* unregister audio devices */
+         for (i = 0; i < NR_AC97; i++) {
+              if (card->ac97_codec[i] != NULL) {
+              unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
+              kfree (card->ac97_codec[i]);
+              }
+         }
          unregister_sound_dsp(card->dev_audio);
          release_region(iobase, 256);
          free_irq(card->irq, card);
          kfree(card);
          return -ENODEV;
     }
+    bRegsReady = 1;
     outl(0x00, TRID_REG(card, T4D_MUSICVOL_WAVEVOL));

     if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+         if(card->revision == ALI_5451_V02)
+              ali_close_multi_channels();
          /* edited by HMSEO for GT sound */
 #ifdef CONFIG_ALPHA_NAUTILUS
          u16 ac97_data;
-         ac97_data = ali_ac97_get (card->ac97_codec[0], AC97_POWER_CONTROL);
-         ali_ac97_set (card->ac97_codec[0], AC97_POWER_CONTROL, ac97_data |
ALI_EAPD_POWER_DOWN);
+         ac97_data = ali_ac97_get(card, 0, AC97_POWER_CONTROL);
+         ali_ac97_set(card, 0, AC97_POWER_CONTROL, ac97_data |
ALI_EAPD_POWER_DOWN);
 #endif
          /* edited by HMSEO for GT sound*/
     }

     pci_set_drvdata(pci_dev, card);
+    pci_dev->dma_mask = TRIDENT_DMA_MASK;

     /* Enable Address Engine Interrupts */
     trident_enable_loop_interrupts(card);
--------------------------------------------------------------------


