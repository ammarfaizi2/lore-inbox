Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266587AbRGEAl3>; Wed, 4 Jul 2001 20:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266588AbRGEAlV>; Wed, 4 Jul 2001 20:41:21 -0400
Received: from [202.96.209.76] ([202.96.209.76]:60040 "EHLO fep3.online.sh.cn")
	by vger.kernel.org with ESMTP id <S266587AbRGEAlH>;
	Wed, 4 Jul 2001 20:41:07 -0400
X-Lotus-FromDomain: ACER
From: Matt_Wu@acersoftech.com.cn
To: linux-kernel@vger.kernel.org
Message-ID: <48256A80.00041BF1.00@cnshans1.acersoftech.com.cn>
Date: Thu, 5 Jul 2001 08:52:00 +0800
Subject: Re: [PATCH] update for ALi Audio Driver
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Sorry for my mistake. The patch I sent yesterday is wrong because it's not
edited from the current source. And here is new patch for ALi M5451 audio
driver.

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
--- drivers/sound/trident.c.orig   Tue Jul  3 13:41:23 2001
+++ drivers/sound/trident.c   Thu Jul  5 05:54:48 2001
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
@@ -320,9 +326,9 @@
     void (*free_pcm_channel)(struct trident_card *, unsigned int chan);
     void (*address_interrupt)(struct trident_card *);

-    /* Add by Matt Wu 01-05-2001 for spdif in */
-    int multi_channel_use_count;
-    int rec_channel_use_count;
+    /* Added by Matt Wu 01-05-2001 for spdif in */
+    int  multi_channel_use_count;
+    int  rec_channel_use_count;
 };

 /* table to map from CHANNELMASK to channel attribute for SiS 7018 */
@@ -338,11 +344,16 @@
     DSP_BIND_I2S, DSP_BIND_CENTER_LFE, DSP_BIND_SURR, DSP_BIND_SPDIF
 };

-/* Add by Matt Wu 01-05-2001 for spdif in */
+/* Added by Matt Wu 01-05-2001 for spdif in */
 static int ali_close_multi_channels(void);
 static void ali_delay(struct trident_card *card,int interval);
 static void ali_detect_spdif_rate(struct trident_card *card);

+u16 MixerRegs[64][NR_AC97];
+int bRegsReady = 0;
+
+static void ali_ac97_write(struct ac97_codec *codec, u8 reg, u16 val);
+static u16 ali_ac97_read(struct ac97_codec *codec, u8 reg);
 static struct trident_card *devs;

 static void trident_ac97_set(struct ac97_codec *codec, u8 reg, u16 val);
@@ -353,8 +364,8 @@
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
@@ -607,6 +618,10 @@
               continue;
          outl(data[i], TRID_REG(card, CHANNEL_START + 4*i));
     }
+    if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+         outl(ALI_EMOD_Still, TRID_REG(card, ALI_EBUF1));
+         outl(ALI_EMOD_Still, TRID_REG(card, ALI_EBUF2));
+    }
     return TRUE;
 }

@@ -950,6 +965,7 @@
     trident_disable_voice_irq(card, chan_num);
 }

+
 static void stop_dac(struct trident_state *state)
 {
     struct trident_card *card = state->card;
@@ -989,7 +1005,7 @@
 static int alloc_dmabuf(struct trident_state *state)
 {
     struct dmabuf *dmabuf = &state->dmabuf;
-    void *rawbuf=NULL;
+    void *rawbuf = NULL;
     int order;
     struct page *page, *pend;

@@ -1221,7 +1237,7 @@
               return -EBUSY;
          }

-         /* No matter how much data left in the buffer, we have to wait untill
+         /* No matter how much data left in the buffer, we have to wait until
             CSO == ESO/2 or CSO == ESO when address engine interrupts */
          if (state->card->pci_id == PCI_DEVICE_ID_ALI_5451)
          {
@@ -1234,7 +1250,6 @@
               tmo = (dmabuf->dmasize * HZ) / dmabuf->rate;
          }
          tmo >>= sample_shift[dmabuf->fmt];
-//       printk("trident: diff=%d count= %d/%d total=%d tmo=%d hwptr=%d
swptr=%d
curptr=%d\n",diff,dmabuf->count,dmabuf->dmasize,dmabuf->total_bytes,tmo,dmabuf->hwptr,dmabuf->swptr,trident_get_dma_addr(state));
          if (!schedule_timeout(tmo ? tmo : 1) && tmo){
               break;
          }
@@ -2098,6 +2113,17 @@
     struct trident_state *state = NULL;
     struct dmabuf *dmabuf = NULL;

+    /* Added by Matt Wu 01-05-2001 */
+    if(file->f_mode & FMODE_READ)
+    {
+         if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {{=%d
+              if (card->multi_channel_use_count > 0) {
+                   printk("Err: The card is now set as multi_channels
mode!\n");
+                   return -EBUSY;
+              }
+         }
+    }
+
     /* find an avaiable virtual channel (instance of /dev/dsp) */
     while (card != NULL) {
          down(&card->open_sem);
@@ -2168,6 +2194,7 @@
     }

     if (file->f_mode & FMODE_READ) {
+
          /* FIXME: Trident 4d can only record in signed 16-bits stereo, 48kHz
sample,
             to be dealed with in trident_set_adc_rate() ?? */
          dmabuf->fmt &= ~TRIDENT_FMT_MASK;
@@ -2183,7 +2210,11 @@
                    (CHANNEL_REC|PCM_LR|MONO_MIX);
          }
          trident_set_adc_rate(state, 8000);
-         card->rec_channel_use_count ++;
+
+         /* Added by Matt Wu 01-05-2001 */
+         if(card->pci_id == PCI_DEVICE_ID_ALI_5451)
+              card->rec_channel_use_count ++;
+
     }

     state->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
@@ -2225,24 +2256,29 @@
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
+         /* Added by Matt Wu */
+         if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+              if (state->chans_num > 2) {
+                   if (card->multi_channel_use_count-- < 0)
+                        card->multi_channel_use_count = 0;
+                   if (card->multi_channel_use_count == 0)
+                        ali_close_multi_channels();
+                   ali_free_other_states_resources(state);
+              }
          }
+
     }
     if (file->f_mode & FMODE_READ) {
          stop_adc(state);
          dealloc_dmabuf(state);
          state->card->free_pcm_channel(state->card, dmabuf->channel->num);

-         if( card->rec_channel_use_count-- < 0 )
-              card->rec_channel_use_count = 0;
+         /* Added by Matt Wu */
+         if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+              if( card->rec_channel_use_count-- < 0 )
+                   card->rec_channel_use_count = 0;
+         }
+
     }

     card->states[state->virt] = NULL;
@@ -2373,9 +2409,8 @@
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
@@ -2383,14 +2418,14 @@
     unsigned long flags;
     u32 data;

-    data = ((u32) val) << 16;
-
     if(!card)
          BUG();
-
+
+    data = ((u32) val) << 16;
     address = ALI_AC97_WRITE;
     mask = ALI_AC97_WRITE_ACTION | ALI_AC97_AUDIO_BUSY;
-    if (codec->id)
+
+    if (secondary)
          mask |= ALI_AC97_SECONDARY;
     if (card->revision == ALI_5451_V02)
          mask |= ALI_AC97_WRITE_MIXER_REGISTER;
@@ -2421,9 +2456,8 @@
 }

 /* Read AC97 codec registers for ALi*/
-static u16 ali_ac97_get(struct ac97_codec *codec, u8 reg)
+static u16 ali_ac97_get(struct trident_card *card, int secondary, u8 reg)
 {
-    struct trident_card *card = (struct trident_card *)codec->private_data;
     unsigned int address, mask;
         unsigned int wCount1 = 0xffff;
         unsigned int wCount2= 0xffff;
@@ -2431,13 +2465,15 @@
     unsigned long flags;
     u32 data;

+    if(!card)
+         BUG();
+
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
@@ -2469,6 +2505,58 @@
     printk(KERN_ERR "ali: AC97 CODEC read timed out.\n");
     return 0;
 }
+static u16 ali_ac97_read(struct ac97_codec *codec, u8 reg)
+{
+    int id;
+    u16 data;
+    struct trident_card *card = NULL;
+
+    /* Added by Matt Wu */
+    if (!codec) {
+         printk(KERN_ERR "trident: ac97 write error: Invalid Codec.\n" );
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
+    /*  Added by Matt Wu */
+    if (!codec) {
+         printk(KERN_ERR "trident: ac97 write error: Invalid Codec.\n" );
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
@@ -2484,7 +2572,6 @@
 flag:    ALI_SPDIF_OUT_TO_SPDIF_OUT
     ALI_PCM_TO_SPDIF_OUT
 */
-
 static void ali_setup_spdif_out(struct trident_card *card, int flag)
 {
     unsigned long spdif;
@@ -2494,6 +2581,7 @@
         struct pci_dev *pci_dev = NULL;

         pci_dev = pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533,
pci_dev);
+
         if (pci_dev == NULL)
                 return;
         pci_read_config_byte(pci_dev, 0x61, &temp);
@@ -2507,6 +2595,7 @@
         temp |= 0x10;
         pci_write_config_byte(pci_dev, 0x7e, temp);

+
     ch = inb(TRID_REG(card, ALI_SCTRL));
     outb(ch | ALI_SPDIF_OUT_ENABLE, TRID_REG(card, ALI_SCTRL));
     ch = inb(TRID_REG(card, ALI_SPDIF_CTRL));
@@ -2731,12 +2820,11 @@
     char temp = 0;
     struct pci_dev *pci_dev = NULL;

-    pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
pci_dev);
+    pci_dev = pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533,
pci_dev);
     if (pci_dev == NULL)
                 return -1;
     temp = 0x80;
     pci_write_config_byte(pci_dev, 0x59, temp);
-
     pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
pci_dev);
     if (pci_dev == NULL)
                 return -1;
@@ -2748,16 +2836,16 @@
          mdelay(4);
          dwValue = inl(TRID_REG(card, ALI_SCTRL));
          if (dwValue & 0x2000000) {
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
+                   ali_ac97_write(card->ac97_codec[0], 0x02, 8080);
+                   ali_ac97_write(card->ac97_codec[0], 0x36, 0);
+                   ali_ac97_write(card->ac97_codec[0], 0x38, 0);
+                   ali_ac97_write(card->ac97_codec[1], 0x36, 0);
+                                ali_ac97_write(card->ac97_codec[1], 0x38, 0);
+                   ali_ac97_write(card->ac97_codec[1], 0x02, 0x0606);
+                   ali_ac97_write(card->ac97_codec[1], 0x18, 0x0303);
+                   ali_ac97_write(card->ac97_codec[1], 0x74, 0x3);
+                   return 1;
+              }
     }
     return -EINVAL;
 }
@@ -2853,7 +2941,7 @@
     outl(ALI_DISABLE_ALL_IRQ, TRID_REG(card, T4D_MISCINT));

     for (i = 1; i < ALI_MIXER_REGS; i++)
-         ali_registers.mixer_regs[i] = ali_ac97_get (card->ac97_codec[0], i*2);
+         ali_registers.mixer_regs[i] = ali_ac97_read (card->ac97_codec[0],
i*2);

     for (i = 0; i < ALI_GLOBAL_REGS; i++)
     {
@@ -2884,7 +2972,7 @@
     cli();

     for (i = 1; i < ALI_MIXER_REGS; i++)
-         ali_ac97_set(card->ac97_codec[0], i*2, ali_registers.mixer_regs[i]);
+         ali_ac97_write(card->ac97_codec[0], i*2, ali_registers.mixer_regs[i]);

     for (i = 0; i < ALI_CHANNELS; i++)
     {
@@ -2941,7 +3029,7 @@
               return channel;
          }
     }
-
+
     for (idx = ALI_PCM_OUT_CHANNEL_FIRST; idx <= ALI_PCM_OUT_CHANNEL_LAST ;
idx++) {
          if (!(bank->bitmap & (1 << idx))) {
               struct trident_channel *channel = &bank->channels[idx];
@@ -2952,7 +3040,7 @@
     }

     /* no more free channels avaliable */
-//  printk(KERN_ERR "ali: no more channels available on Bank A.\n");
+    printk(KERN_ERR "ali: no more channels available on Bank A.\n");
     return NULL;
 }

@@ -2975,7 +3063,7 @@
     }

     /* no free recordable channels avaliable */
-//  printk(KERN_ERR "ali: no recordable channels available on Bank A.\n");
+    printk(KERN_ERR "ali: no recordable channels available on Bank A.\n");
     return NULL;
 }

@@ -3175,20 +3263,20 @@

     spin_lock_irqsave(&card->lock, flags);
     switch (c) {
-        case '0':
+         case '0':
          ali_setup_spdif_out(card, ALI_PCM_TO_SPDIF_OUT);
          ali_disable_special_channel(card, ALI_SPDIF_OUT_CHANNEL);
-         break;
-        case '1':
+         break;
+         case '1':
          ali_setup_spdif_out(card,
ALI_SPDIF_OUT_TO_SPDIF_OUT|ALI_SPDIF_OUT_PCM);
          break;
-        case '2':
+         case '2':
          ali_setup_spdif_out(card,
ALI_SPDIF_OUT_TO_SPDIF_OUT|ALI_SPDIF_OUT_NON_PCM);
          break;
-        case '3':
+         case '3':
          ali_disable_spdif_in(card);    //default
          break;
-        case '4':
+         case '4':
          ali_setup_spdif_in(card);
          break;
     }
@@ -3236,29 +3324,75 @@
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
@@ -3295,8 +3429,8 @@
          codec->id = num_ac97;

          if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
-              codec->codec_read = ali_ac97_get;
-              codec->codec_write = ali_ac97_set;
+              codec->codec_read = ali_ac97_read;
+              codec->codec_write = ali_ac97_write;
          }
          else {
               codec->codec_read = trident_ac97_get;
@@ -3316,10 +3450,22 @@

          /* if there is no secondary codec at all, don't probe any more */
          if (!ready_2nd)
-              return num_ac97+1;
+              break;
     }

-    return 1/*num_ac97*/;
+    if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+
+         for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
+
+              if (card->ac97_codec[num_ac97] == NULL)
+                   break;
+
+              for (i=0; i<64;i++)
+                   MixerRegs[i][num_ac97] = ali_ac97_get(card, num_ac97,i*2);
+         }
+    }
+
+    return num_ac97+1;
 }

 /* install the driver, we do not allocate hardware channel nor DMA buffer now,
they are defered
@@ -3331,6 +3477,7 @@
     dma_addr_t mask;
     int bits;
     u8 revision;
+    int i;

     if (pci_enable_device(pci_dev))
         return -ENODEV;
@@ -3438,27 +3585,39 @@
          kfree(card);
          return -ENODEV;
     }
+    bRegsReady = 0;
     /* initialize AC97 codec and register /dev/mixer */
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
--- drivers/sound/trident.h.orig   Tue Jul  3 13:42:35 2001
+++ drivers/sound/trident.h   Thu Jul  5 05:54:48 2001
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
--------------------------------------------------------------------


