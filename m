Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbRHFJ2n>; Mon, 6 Aug 2001 05:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267657AbRHFJ2e>; Mon, 6 Aug 2001 05:28:34 -0400
Received: from [202.96.209.75] ([202.96.209.75]:25080 "EHLO fep2.online.sh.cn")
	by vger.kernel.org with ESMTP id <S267643AbRHFJ2V>;
	Mon, 6 Aug 2001 05:28:21 -0400
X-Lotus-FromDomain: ACER
From: Matt_Wu@acersoftech.com.cn
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, Matt_Wu@acersoftech.com.cn
Message-ID: <48256AA0.0033618D.00@cnshans1.acersoftech.com.cn>
Date: Mon, 6 Aug 2001 17:26:07 +0800
Subject: [PATCH] update for ALi Audio Driver (0.14.9) 
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear all,

We added hardware volume control to ALi audio driver.

Best regards,

Matt Wu
http://www.ali.com.tw

Information about update:
Updated files:      trident.c trident.h
Location:      drivers/sound
Driver Version:     0.14.9
Kernel Version:     2.4.X

patch file:
--------------------------------------------------------------------
--- drivers/sound/trident.c.orig   Mon Aug  6 10:46:59 2001
+++ drivers/sound/trident.c   Mon Aug  6 11:51:34 2001
@@ -31,6 +31,9 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.9
+ *  Jul 10 2001 Matt Wu
+ *  Add H/W Volume Control
  *  v0.14.8a
  *  July 7 2001 Alan Cox
  *  Moved Matt Wu's ac97 register cache into the card structure
@@ -146,6 +149,7 @@
 #include <asm/hardirq.h>
 #include <linux/bitops.h>
 #include <linux/proc_fs.h>
+#include <linux/interrupt.h>

 #if defined CONFIG_ALPHA_NAUTILUS || CONFIG_ALPHA_GENERIC
 #include <asm/hwrpb.h>
@@ -155,7 +159,7 @@

 #include <linux/pm.h>

-#define DRIVER_VERSION "0.14.8"
+#define DRIVER_VERSION "0.14.9"

 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC   0x5072696E /* "Prin" */
@@ -348,6 +352,10 @@
     int rec_channel_use_count;
     u16 mixer_regs[64][NR_AC97];  /* Made card local by Alan */
     int mixer_regs_ready;
+
+    /* Added for hardware volume control */
+    int hwvolctl;
+    u32 current_time;
 };

 /* table to map from CHANNELMASK to channel attribute for SiS 7018 */
@@ -363,6 +371,25 @@
     DSP_BIND_I2S, DSP_BIND_CENTER_LFE, DSP_BIND_SURR, DSP_BIND_SPDIF
 };

+#define  INTERVAL  (HZ/10)
+
+typedef struct _task_stru {
+    struct trident_card *card;
+    struct tq_struct task;
+    struct timer_list timer;
+    int data;
+    int delay;
+} task_stru;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 3)
+static int pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask)
+{
+    return (!pci_dma_supported(dev, TRIDENT_DMA_MASK));
+}
+#endif
+
+task_stru *new_task_stru(void);
+
 /* Added by Matt Wu 01-05-2001 for spdif in */
 static int ali_close_multi_channels(void);
 static void ali_delay(struct trident_card *card,int interval);
@@ -1415,10 +1442,123 @@
     }
 }

+static void ali_hwvol_control(struct trident_card *card, int opt)
+{
+    u16 dwTemp, volume[2], mute, diff, *pVol[2];
+
+    dwTemp = ali_ac97_read(card->ac97_codec[0], 0x02);
+    mute = dwTemp & 0x8000;
+    volume[0] = dwTemp & 0x001f;
+    volume[1] = (dwTemp & 0x1f00) >> 8;
+    if (volume[0] < volume [1]) {
+         pVol[0] = &volume[0];
+         pVol[1] = &volume[1];
+    } else {
+         pVol[1] = &volume[0];
+         pVol[0] = &volume[1];
+    }
+    diff = *(pVol[1]) - *(pVol[0]);
+
+    if (opt == 1) {                     // MUTE
+         dwTemp ^= 0x8000;
+         ali_ac97_write(card->ac97_codec[0], 0x02, dwTemp);
+    } else if (opt == 2) {   // Down
+         if (mute)
+              return;
+         if (*(pVol[1]) < 0x001f) {
+              (*pVol[1])++;
+              *(pVol[0]) = *(pVol[1]) - diff;
+         }
+         dwTemp &= 0xe0e0;
+         dwTemp |= (volume[0]) | (volume[1] << 8);
+         ali_ac97_write(card->ac97_codec[0], 0x02, dwTemp);
+         card->ac97_codec[0]->mixer_state[0] = ((32-volume[0])*25/8) |
(((32-volume[1])*25/8) << 8);
+    } else if (opt == 4) {   // Up
+         if (mute)
+              return;
+         if (*(pVol[0]) >0) {{
+              (*pVol[0])--;
+              *(pVol[1]) = *(pVol[0]) + diff;
+         }
+         dwTemp &= 0xe0e0;
+         dwTemp |= (volume[0]) | (volume[1] << 8);
+         ali_ac97_write(card->ac97_codec[0], 0x02, dwTemp);
+         card->ac97_codec[0]->mixer_state[0] = ((32-volume[0])*25/8) |
(((32-volume[1])*25/8) << 8);
+    } else {
+    }
+}
+
+task_stru *new_task_stru()
+{
+    task_stru *ptask = NULL;
+    ptask = (task_stru *)kmalloc(sizeof(task_stru), GFP_KERNEL);
+    if (ptask)
+         memset(ptask, 0, sizeof(task_stru));
+    return ptask;
+}
+
+static void ali_timeout(unsigned long ptr)
+{
+    task_stru *ptask = (task_stru *)ptr;
+    struct trident_card *card = ptask->card;
+    u16 wTemp = 0;
+
+    /* Enable GPIO IRQ (MISCINT bit 18h)*/
+    wTemp = inw(TRID_REG(card, T4D_MISCINT + 2));
+    wTemp |= 0x0004;
+    outw(wTemp, TRID_REG(card, T4D_MISCINT + 2));
+
+    kfree(ptask);
+}
+
+static void ali_set_timer(task_stru *ptask)
+{
+    /* Add Timer Routine to Enable GPIO IRQ */
+    init_timer(&ptask->timer);
+    ptask->timer.function = ali_timeout;
+    ptask->timer.data = (unsigned long) ptask;
+    ptask->timer.expires = jiffies + ptask->delay;
+    add_timer(&ptask->timer);
+}
+
+static void ali_bh_interrupt(void *ptr)
+{
+    task_stru *ptask = (task_stru *)ptr;
+
+    ali_hwvol_control(ptask->card, ptask->data);
+    ali_set_timer(ptask);
+}
+
+static void ali_queue_task(struct trident_card *card, int opt, int delay)
+{
+    u16 wTemp;
+    task_stru *ptask;
+
+    ptask = new_task_stru();
+    if (ptask) {
+         /* Disable GPIO IRQ (MISCINT bit 18h)*/
+         wTemp = inw(TRID_REG(card, T4D_MISCINT + 2));
+         wTemp &= (u16)(~0x0004);
+         outw(wTemp, TRID_REG(card, T4D_MISCINT + 2));
+
+         /* queue task */
+         ptask->task.routine = ali_bh_interrupt;
+         ptask->task.data = ptask;
+         ptask->card = card;
+         ptask->data = opt;
+         ptask->delay = delay;
+         queue_task(&(ptask->task), &tq_immediate);
+         mark_bh(IMMEDIATE_BH);
+    }
+    else
+         ali_hwvol_control(card, opt);
+}
+
 static void trident_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
     struct trident_card *card = (struct trident_card *)dev_id;
     u32 event;
+    u32 gpio;

     spin_lock(&card->lock);
     event = inl(TRID_REG(card, T4D_MISCINT));
@@ -1431,9 +1571,21 @@
          card->address_interrupt(card);
     }

+    /* GPIO IRQ (H/W Volume Control) */
+    event = inl(TRID_REG(card, T4D_MISCINT));
+    if (event & (1<<25)) {
+         gpio = inl(TRID_REG(card, ALI_GPIO));
+         if (jiffies - card->current_time >= INTERVAL) {
+              card->current_time = jiffies;
+              ali_queue_task(card, gpio&0x07, INTERVAL);
+         }
+    }
+
     /* manually clear interrupt status, bad hardware design, blame T^2 */
-    outl((ST_TARGET_REACHED | MIXER_OVERFLOW | MIXER_UNDERFLOW),
+    event = inl(TRID_REG(card, T4D_MISCINT));
+    outl(event | (ST_TARGET_REACHED | MIXER_OVERFLOW | MIXER_UNDERFLOW),
          TRID_REG(card, T4D_MISCINT));
+
     spin_unlock(&card->lock);
 }

@@ -3637,10 +3789,10 @@
 {
     unsigned long iobase;
     struct trident_card *card;
-    dma_addr_t mask;
-    int bits;
-    u8 revision;
+    struct pci_dev *pci_dev_m1533 = NULL;
+    u8 revision, bChar;
     int i = 0;
+    u16 wTemp;

     if (pci_enable_device(pci_dev))
         return -ENODEV;
@@ -3708,6 +3860,23 @@
               }
 #endif
          }
+
+         /* Add H/W Volume Control By Matt Wu Jul. 06, 2001 */
+         card->hwvolctl = 0;
+         pci_dev_m1533 =
pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533, pci_dev_m1533);
+
+         if (pci_dev_m1533 == NULL)
+              return -ENODEV;
+         pci_read_config_byte(pci_dev_m1533, 0x63, &bChar);
+         if (bChar & (1<<5))
+              card->hwvolctl = 1;
+         if (card->hwvolctl) {
+              /* Clear m1533 pci cfg 78h bit 30 to zero, which makes
+                 GPIO11/12/13 work as ACGP_UP/DOWN/MUTE. */
+              pci_read_config_byte(pci_dev_m1533, 0x7b, &bChar);
+              bChar &= 0xbf; /*clear bit 6 */
+              pci_write_config_byte(pci_dev_m1533, 0x7b, bChar);
+         }
     }
     else {
          card->alloc_pcm_channel = trident_alloc_pcm_channel;
@@ -3753,6 +3922,21 @@
     outl(0x00, TRID_REG(card, T4D_MUSICVOL_WAVEVOL));

     if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
+
+         /* Add H/W Volume Control By Matt Wu Jul. 06, 2001 */
+         if(card->hwvolctl) {
+              /* Enable GPIO IRQ (MISCINT bit 18h)*/
+              wTemp = inw(TRID_REG(card, T4D_MISCINT + 2));
+              wTemp |= 0x0004;
+              outw(wTemp, TRID_REG(card, T4D_MISCINT + 2));
+
+              /* Enable H/W Volume Control GLOVAL CONTROL bit 0*/
+              wTemp = inw(TRID_REG(card, ALI_GLOBAL_CONTROL));
+              wTemp |= 0x0001;
+              outw(wTemp, TRID_REG(card, ALI_GLOBAL_CONTROL));
+
+              card->current_time = jiffies;
+         }
          if(card->revision == ALI_5451_V02)
               ali_close_multi_channels();
          /* edited by HMSEO for GT sound */
--- drivers/sound/trident.h.orig   Mon Aug  6 10:47:09 2001
+++ drivers/sound/trident.h   Mon Aug  6 11:37:51 2001
@@ -90,10 +90,10 @@
     T4D_STOP_B      = 0xb8, T4D_CSPF_B  = 0xbc,
     T4D_SBBL_SBCL  = 0xc0, T4D_SBCTRL_SBE2R_SBDD    = 0xc4,
     T4D_STIMER     = 0xc8, T4D_LFO_B_I2S_DELTA      = 0xcc,
-    T4D_AINT_B     = 0xd8,   T4D_AINTEN_B    = 0xdc,
-    ALI_MPUR2 = 0x22,
-    ALI_EBUF1 = 0xf4,
-    ALI_EBUF2 = 0xf8
+    T4D_AINT_B     = 0xd8, T4D_AINTEN_B    = 0xdc,
+    ALI_MPUR2 = 0x22, ALI_GPIO    = 0x7c,
+    ALI_EBUF1 = 0xf4,
+    ALI_EBUF2 = 0xf8
 };

 enum ali_op_registers {
--------------------------------------------------------------------


