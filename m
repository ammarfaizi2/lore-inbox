Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTANXDd>; Tue, 14 Jan 2003 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbTANXDd>; Tue, 14 Jan 2003 18:03:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15055 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265242AbTANXC5>; Tue, 14 Jan 2003 18:02:57 -0500
Date: Wed, 15 Jan 2003 00:11:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.21pre2 trident / ali5451
Message-ID: <20030114231141.GF15211@fs.tum.de>
References: <20021228021630.GA324@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021228021630.GA324@schottelius.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 02:16:30AM +0000, Nico Schottelius wrote:
> trident.o doesn load anymore...
> while trying to insert it, the whole system hangs.
> 
> flapp:/home/user/nico/ccc/video # modprobe trident
> /lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o: init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg
> /lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o: insmod /lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o failed
> /lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o: insmod trident failed
>...
> In 2.4.19 it worked, in 2.5.53 the alsa device works, but trident not, again.

Did 2.4.20 work?

If not, please undo the changes below in 2.4.20 (pipe this mail to
"patch -p1 -R") and check whether this modified 2.4.20 works for you.

> Greetings,
> 
> Nico

cu
Adrian


--- linux-2.4.19/drivers/sound/trident.c	2002-08-03 00:39:44.000000000 +0000
+++ linux-2.4.20/drivers/sound/trident.c	2002-11-26 12:25:34.000000000 +0000
@@ -36,6 +36,41 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.10h
+ *	Sept 10 2002 Pascal Schmidt <der.eremit@email.de>
+ *	added support for ALi 5451 joystick port
+ *  v0.14.10g
+ *	Sept 05 2002 Alan Cox <alan@redhat.com>
+ *	adapt to new pci joystick attachment interface
+ *  v0.14.10f
+ *      July 24 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      patch from Eric Lemar (via Ian Soboroff): in suspend and resume, 
+ *      fix wrong cast from pci_dev* to struct trident_card*. 
+ *  v0.14.10e
+ *      July 19 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      rewrite the DMA buffer allocation/deallcoation functions, to make it 
+ *      modular and fix a bug where we would call free_pages on memory 
+ *      obtained with pci_alloc_consistent. Also remove unnecessary #ifdef 
+ *      CONFIG_PROC_FS and various other cleanups.
+ *  v0.14.10d
+ *      July 19 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      made several printk(KERN_NOTICE...) into TRDBG(...), to avoid spamming
+ *      my syslog with hundreds of messages. 
+ *  v0.14.10c
+ *      July 16 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      Cleaned up Lei Hu's 0.4.10 driver to conform to Documentation/CodingStyle
+ *      and the coding style used in the rest of the file. 
+ *  v0.14.10b
+ *      June 23 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      add a missing unlock_set_fmt, remove a superflous lock/unlock pair 
+ *      with nothing in between. 
+ *  v0.14.10a
+ *      June 21 2002 Muli Ben-Yehuda <mulix@actcom.co.il> 
+ *      use a debug macro instead of #ifdef CONFIG_DEBUG, trim to 80 columns 
+ *      per line, use 'do {} while (0)' in statement macros. 
+ *  v0.14.10
+ *      June 6 2002 Lei Hu <Lei_hu@ali.com.tw>
+ *      rewrite the part to read/write registers of audio codec for Ali5451 
  *  v0.14.9d
  *  	October 8 2001 Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *	use set_current_state, properly release resources on failure in
@@ -46,7 +81,7 @@
  *	this chip is often found in settop boxes (combined video+audio)
  *  v0.14.9b
  *	Switch to static inline not extern inline (gcc 3)
- *  v0.14.9a
+ *  v0.14.9a 
  *	Aug 6 2001 Alan Cox
  *	0.14.9 crashed on rmmod due to a timer/bh left running. Simplified
  *	the existing logic (the BH doesnt help as ac97 is lock_irqsave)
@@ -158,19 +193,22 @@
 #include <linux/slab.h>
 #include <linux/soundcard.h>
 #include <linux/pci.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/wrapper.h>
-#include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <linux/bitops.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
+#include <linux/gameport.h>
+#include <linux/pci_gameport.h>
+#include <asm/uaccess.h>
+#include <asm/hardirq.h>
+#include <asm/io.h>
+#include <asm/dma.h>
 
 #if defined CONFIG_ALPHA_NAUTILUS || CONFIG_ALPHA_GENERIC
 #include <asm/hwrpb.h>
@@ -178,9 +216,7 @@
 
 #include "trident.h"
 
-#include <linux/pm.h>
-
-#define DRIVER_VERSION "0.14.9d"
+#define DRIVER_VERSION "0.14.10h"
 
 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC	0x5072696E /* "Prin" */
@@ -198,7 +234,13 @@
 /* minor number of /dev/swmodem (temporary, experimental) */
 #define SND_DEV_SWMODEM	7
 
-static const unsigned ali_multi_channels_5_1[] = { /*ALI_SURR_LEFT_CHANNEL, ALI_SURR_RIGHT_CHANNEL,*/ ALI_CENTER_CHANNEL, ALI_LEF_CHANNEL, ALI_SURR_LEFT_CHANNEL, ALI_SURR_RIGHT_CHANNEL};
+static const unsigned ali_multi_channels_5_1[] = { 
+	/*ALI_SURR_LEFT_CHANNEL, ALI_SURR_RIGHT_CHANNEL,*/
+	ALI_CENTER_CHANNEL, 
+	ALI_LEF_CHANNEL, 
+	ALI_SURR_LEFT_CHANNEL, 
+	ALI_SURR_RIGHT_CHANNEL
+};
 
 static const unsigned sample_size[] = { 1, 2, 2, 4 };
 static const unsigned sample_shift[] = { 0, 1, 1, 2 };
@@ -288,7 +330,7 @@
 		
 	} dmabuf;
 
-	/* 5.1channels */	
+	/* 5.1 channels */	
 	struct trident_state *other_states[4];
 	int multi_channels_adjust_count;
 	unsigned chans_num;
@@ -315,6 +357,7 @@
 	u32 aint;
 	u32 aint_en;
 };
+
 static struct trident_pcm_bank_address bank_a_addrs =
 {
 	T4D_START_A,
@@ -322,6 +365,7 @@
 	T4D_AINT_A,
 	T4D_AINTEN_A
 };
+
 static struct trident_pcm_bank_address bank_b_addrs =
 {
 	T4D_START_B,
@@ -329,6 +373,7 @@
 	T4D_AINT_B,
 	T4D_AINTEN_B
 };
+
 struct trident_pcm_bank {
 	/* register addresses to control bank operations */
 	struct trident_pcm_bank_address *addresses;
@@ -382,6 +427,8 @@
 	/* Added for hardware volume control */
 	int hwvolctl;
 	struct timer_list timer;
+
+	struct pcigame *joystick;	/* joystick device */
 };
 
 /* table to map from CHANNELMASK to channel attribute for SiS 7018 */
@@ -391,6 +438,7 @@
 	HSET, MIC, MODEM_LINE1, MODEM_LINE2,
 	I2S_LR, SPDIF_LR
 };
+
 /* table to map from channel attribute to CHANNELMASK for SiS 7018 */
 static int attr2mask [] = {
 	DSP_BIND_MODEM1, DSP_BIND_MODEM2, DSP_BIND_FRONT, DSP_BIND_HANDSET,
@@ -399,7 +447,7 @@
 
 /* Added by Matt Wu 01-05-2001 for spdif in */
 static int ali_close_multi_channels(void);
-static void ali_delay(struct trident_card *card,int interval);
+static void ali_delay(struct trident_card *card, int interval);
 static void ali_detect_spdif_rate(struct trident_card *card);
 
 static void ali_ac97_write(struct ac97_codec *codec, u8 reg, u16 val);
@@ -431,8 +479,11 @@
 static void ali_disable_spdif_in(struct trident_card *card);
 static void ali_disable_special_channel(struct trident_card *card, int ch);
 static void ali_setup_spdif_out(struct trident_card *card, int flag);
-static int ali_write_5_1(struct trident_state *state, const char *buffer,int cnt_for_multi_channel, unsigned int *copy_count, unsigned int *state_cnt);
-static int ali_allocate_other_states_resources(struct trident_state *state, int chan_nums);
+static int ali_write_5_1(struct trident_state *state, const char *buffer,
+			 int cnt_for_multi_channel, unsigned int *copy_count, 
+			 unsigned int *state_cnt);
+static int ali_allocate_other_states_resources(struct trident_state *state, 
+					       int chan_nums);
 static void ali_free_other_states_resources(struct trident_state *state);
 
 
@@ -443,22 +494,29 @@
 	unsigned mixer_regs[ALI_MIXER_REGS];
 } ali_registers;
 
-#define seek_offset(dma_ptr, buffer, cnt, offset, copy_count)	(dma_ptr) += (offset);	\
-							(buffer) += (offset);	\
-							(cnt) -= (offset);	\
-							(copy_count) += (offset);
-
-#define lock_set_fmt(state)	{spin_lock_irqsave(&state->card->lock, flags);			\
-				if (state->fmt_flag) {						\
-					spin_unlock_irqrestore(&state->card->lock, flags);	\
-					return -EFAULT;						\
-				}								\
-				state->fmt_flag = 1;						\
-				spin_unlock_irqrestore(&state->card->lock, flags);}
+#define seek_offset(dma_ptr, buffer, cnt, offset, copy_count)	do { \
+        (dma_ptr) += (offset);	  \
+	(buffer) += (offset);	  \
+        (cnt) -= (offset);	  \
+	(copy_count) += (offset); \
+} while (0)
+	  
+
+#define lock_set_fmt(state) do { \
+        spin_lock_irqsave(&state->card->lock, flags);			\
+	if (state->fmt_flag) {						\
+	       spin_unlock_irqrestore(&state->card->lock, flags);	\
+               return -EFAULT;					        \
+	}								\
+	state->fmt_flag = 1;						\
+	spin_unlock_irqrestore(&state->card->lock, flags);              \
+} while (0)
 				
-#define unlock_set_fmt(state)	{spin_lock_irqsave(&state->card->lock, flags);		\
-				state->fmt_flag = 0;					\
-				spin_unlock_irqrestore(&state->card->lock, flags);}
+#define unlock_set_fmt(state)  do {                             \
+        spin_lock_irqsave(&state->card->lock, flags);		\
+	state->fmt_flag = 0;					\
+	spin_unlock_irqrestore(&state->card->lock, flags);      \
+} while (0)
 
 static int trident_enable_loop_interrupts(struct trident_card * card)
 {
@@ -483,10 +541,9 @@
 
 	outl(global_control, TRID_REG(card, T4D_LFO_GC_CIR));
 
-#ifdef DEBUG
-	printk("trident: Enable Loop Interrupts, globctl = 0x%08X\n",
-			inl(TRID_REG(card, T4D_LFO_GC_CIR)));
-#endif
+	TRDBG("trident: Enable Loop Interrupts, globctl = 0x%08X\n",
+	      inl(TRID_REG(card, T4D_LFO_GC_CIR)));
+
 	return (TRUE);
 }
 
@@ -498,10 +555,9 @@
 	global_control &= ~(ENDLP_IE | MIDLP_IE);
 	outl(global_control, TRID_REG(card, T4D_LFO_GC_CIR));
 
-#ifdef DEBUG
-	printk("trident: Disabled Loop Interrupts, globctl = 0x%08X\n",
-	       global_control);
-#endif
+	TRDBG("trident: Disabled Loop Interrupts, globctl = 0x%08X\n",
+	      global_control);
+
 	return (TRUE);
 }
 
@@ -517,9 +573,9 @@
 
 #ifdef DEBUG
 	reg = inl(TRID_REG(card, addr));
-	printk("trident: enabled IRQ on channel %d, %s = 0x%08x(addr:%X)\n",
-		channel, addr==T4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
-#endif
+	TRDBG("trident: enabled IRQ on channel %d, %s = 0x%08x(addr:%X)\n",
+	      channel, addr==T4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
+#endif /* DEBUG */ 
 }
 
 static void trident_disable_voice_irq(struct trident_card * card, unsigned int channel)
@@ -537,9 +593,9 @@
 
 #ifdef DEBUG
 	reg = inl(TRID_REG(card, addr));
-	printk("trident: disabled IRQ on channel %d, %s = 0x%08x(addr:%X)\n",
-		channel, addr==T4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
-#endif
+	TRDBG("trident: disabled IRQ on channel %d, %s = 0x%08x(addr:%X)\n",
+	      channel, addr==T4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
+#endif /* DEBUG */ 
 }
 
 static void trident_start_voice(struct trident_card * card, unsigned int channel)
@@ -550,15 +606,15 @@
 
 #ifdef DEBUG
 	u32 reg;
-#endif
+#endif /* DEBUG */ 
 
 	outl(mask, TRID_REG(card, addr));
 
-#ifdef DEBUG
+#ifdef DEBUG 
 	reg = inl(TRID_REG(card, addr));
-	printk("trident: start voice on channel %d, %s = 0x%08x(addr:%X)\n",
-		channel, addr==T4D_START_B? "START_B":"START_A",reg,addr);
-#endif
+	TRDBG("trident: start voice on channel %d, %s = 0x%08x(addr:%X)\n",
+	      channel, addr==T4D_START_B? "START_B":"START_A",reg,addr);
+#endif /* DEBUG */ 
 }
 
 static void trident_stop_voice(struct trident_card * card, unsigned int channel)
@@ -569,15 +625,15 @@
 
 #ifdef DEBUG
 	u32 reg;
-#endif
+#endif /* DEBUG */ 
 
 	outl(mask, TRID_REG(card, addr));
 
 #ifdef DEBUG
 	reg = inl(TRID_REG(card, addr));
-	printk("trident: stop voice on channel %d, %s = 0x%08x(addr:%X)\n",
-		channel, addr==T4D_STOP_B? "STOP_B":"STOP_A",reg,addr);
-#endif
+	TRDBG("trident: stop voice on channel %d, %s = 0x%08x(addr:%X)\n",
+	      channel, addr==T4D_STOP_B? "STOP_B":"STOP_A",reg,addr);
+#endif /* DEBUG */ 
 }
 
 static u32 trident_get_interrupt_mask (struct trident_card * card, unsigned int channel)
@@ -594,9 +650,9 @@
 
 #ifdef DEBUG
 	if (reg & mask)
-		printk("trident: channel %d has interrupt, %s = 0x%08x\n",
-			channel,reg==T4D_AINT_B? "AINT_B":"AINT_A", reg);
-#endif
+		TRDBG("trident: channel %d has interrupt, %s = 0x%08x\n",
+		      channel,reg==T4D_AINT_B? "AINT_B":"AINT_A", reg);
+#endif /* DEBUG */ 
 	return (reg & mask) ? TRUE : FALSE;
 }
 
@@ -612,9 +668,9 @@
 
 #ifdef DEBUG
 	reg = inl(TRID_REG(card, T4D_AINT_B));
-	printk("trident: Ack channel %d interrupt, AINT_B = 0x%08x\n",
-	       channel, reg);
-#endif
+	TRDBG("trident: Ack channel %d interrupt, AINT_B = 0x%08x\n",
+	      channel, reg);
+#endif /* DEBUG */ 
 }
 
 static struct trident_channel * trident_alloc_pcm_channel(struct trident_card *card)
@@ -862,9 +918,7 @@
 
 	trident_write_voice_regs(state);
 
-#ifdef DEBUG
-	printk("trident: called trident_set_dac_rate : rate = %d\n", rate);
-#endif
+	TRDBG("trident: called trident_set_dac_rate : rate = %d\n", rate);
 
 	return rate;
 }
@@ -884,9 +938,8 @@
 
 	trident_write_voice_regs(state);
 
-#ifdef DEBUG
-	printk("trident: called trident_set_adc_rate : rate = %d\n", rate);
-#endif
+	TRDBG("trident: called trident_set_adc_rate : rate = %d\n", rate);
+
 	return rate;
 }
 
@@ -928,11 +981,11 @@
 	if (dmabuf->fmt & TRIDENT_FMT_STEREO)
 		/* stereo */
 		channel->control |= CHANNEL_STEREO;
-#ifdef DEBUG
-	printk("trident: trident_play_setup, LBA = 0x%08x, "
-	       "Delta = 0x%08x, ESO = 0x%08x, Control = 0x%08x\n",
-	       channel->lba, channel->delta, channel->eso, channel->control);
-#endif
+
+	TRDBG("trident: trident_play_setup, LBA = 0x%08x, "
+	      "Delta = 0x%08x, ESO = 0x%08x, Control = 0x%08x\n",
+	      channel->lba, channel->delta, channel->eso, channel->control);
+
 	trident_write_voice_regs(state);
 }
 
@@ -1014,11 +1067,11 @@
 	if (dmabuf->fmt & TRIDENT_FMT_STEREO)
 		/* stereo */
 		channel->control |= CHANNEL_STEREO;
-#ifdef DEBUG
-	printk("trident: trident_rec_setup, LBA = 0x%08x, "
-	       "Delat = 0x%08x, ESO = 0x%08x, Control = 0x%08x\n",
-	       channel->lba, channel->delta, channel->eso, channel->control);
-#endif
+	
+	TRDBG("trident: trident_rec_setup, LBA = 0x%08x, "
+	      "Delat = 0x%08x, ESO = 0x%08x, Control = 0x%08x\n",
+	      channel->lba, channel->delta, channel->eso, channel->control);
+
 	trident_write_voice_regs(state);
 }
 
@@ -1051,11 +1104,10 @@
 		return 0;
 	}
 
-#ifdef DEBUG
-	printk("trident: trident_get_dma_addr: chip reported channel: %d, "
-	       "cso = 0x%04x\n",
-	       dmabuf->channel->num, cso);
-#endif
+	
+	TRDBG("trident: trident_get_dma_addr: chip reported channel: %d, "
+	      "cso = 0x%04x\n", dmabuf->channel->num, cso);
+
 	/* ESO and CSO are in units of Samples, convert to byte offset */
 	cso <<= sample_shift[dmabuf->fmt];
 
@@ -1153,27 +1205,18 @@
 #define DMABUF_DEFAULTORDER (15-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
 
-/* allocate DMA buffer, playback and recording buffer should be allocated seperately */
-static int alloc_dmabuf(struct trident_state *state)
+/* alloc a DMA buffer of with a buffer of this order */ 
+static int alloc_dmabuf(struct dmabuf* dmabuf, struct pci_dev* pci_dev, int order)
 {
-	struct dmabuf *dmabuf = &state->dmabuf;
 	void *rawbuf = NULL;
-	int order;
 	struct page *page, *pend;
 
-	/* alloc as big a chunk as we can, FIXME: is this necessary ?? */
-	for (order = DMABUF_DEFAULTORDER; order >= DMABUF_MINORDER; order--)
-		if ((rawbuf = pci_alloc_consistent(state->card->pci_dev,
-						   PAGE_SIZE << order,
-						   &dmabuf->dma_handle)))
-			break;
-	if (!rawbuf)
+	if (!(rawbuf = pci_alloc_consistent(pci_dev, PAGE_SIZE << order,
+					    &dmabuf->dma_handle)))
 		return -ENOMEM;
 
-#ifdef DEBUG
-	printk("trident: allocated %ld (order = %d) bytes at %p\n",
-	       PAGE_SIZE << order, order, rawbuf);
-#endif
+	TRDBG("trident: allocated %ld (order = %d) bytes at %p\n",
+	      PAGE_SIZE << order, order, rawbuf);
 
 	dmabuf->ready  = dmabuf->mapped = 0;
 	dmabuf->rawbuf = rawbuf;
@@ -1187,21 +1230,37 @@
 	return 0;
 }
 
-/* free DMA buffer */
-static void dealloc_dmabuf(struct trident_state *state)
+/* allocate the main DMA buffer, playback and recording buffer should be */ 
+/* allocated seperately */
+static int alloc_main_dmabuf(struct trident_state *state)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
-	struct page *page, *pend;
+	int order;
+	int ret = -ENOMEM; 
+
+	/* alloc as big a chunk as we can, FIXME: is this necessary ?? */
+	for (order = DMABUF_DEFAULTORDER; order >= DMABUF_MINORDER; order--) {
+		if (!(ret = alloc_dmabuf(dmabuf, state->card->pci_dev, order)))
+			return 0; 
+		/* else try again */ 
+	}
+	return ret; 
+}
 
+/* deallocate a DMA buffer */ 
+static void dealloc_dmabuf(struct dmabuf* dmabuf, struct pci_dev* pci_dev)
+{
+	struct page *page, *pend;
+	
 	if (dmabuf->rawbuf) {
 		/* undo marking the pages as reserved */
 		pend = virt_to_page(dmabuf->rawbuf + (PAGE_SIZE << dmabuf->buforder) - 1);
 		for (page = virt_to_page(dmabuf->rawbuf); page <= pend; page++)
 			mem_map_unreserve(page);
-		pci_free_consistent(state->card->pci_dev, PAGE_SIZE << dmabuf->buforder,
+		pci_free_consistent(pci_dev, PAGE_SIZE << dmabuf->buforder,
 				    dmabuf->rawbuf, dmabuf->dma_handle);
+		dmabuf->rawbuf = NULL;
 	}
-	dmabuf->rawbuf = NULL;
 	dmabuf->mapped = dmabuf->ready = 0;
 }
 
@@ -1213,16 +1272,16 @@
 	unsigned bufsize, dma_nums;
 	unsigned long flags;
 	int ret, i, order;
-	struct page *page, *pend;
 	
 	lock_set_fmt(state);
 	if (state->chans_num == 6)
 		dma_nums = 5;
-	else 	dma_nums = 1;
+	else 	
+		dma_nums = 1;
 	
 	for (i = 0; i < dma_nums; i++) {
 		if (i > 0) {
-			s = state->other_states[i - 1];			
+			s = state->other_states[i - 1];
 			dmabuf = &s->dmabuf;
 			dmabuf->fmt = state->dmabuf.fmt;
 			dmabuf->rate = state->dmabuf.rate;
@@ -1236,35 +1295,25 @@
 		/* allocate DMA buffer if not allocated yet */
 		if (!dmabuf->rawbuf) {
 			if (i == 0) {
-				if ((ret = alloc_dmabuf(state))) {
+				if ((ret = alloc_main_dmabuf(state))) {
 					unlock_set_fmt(state);
 					return ret;
 				}
-			}
-			else {
+			} else {
+				ret = -ENOMEM; 
 				if ((order = state->dmabuf.buforder - 1) >= DMABUF_MINORDER) {
-					dmabuf->rawbuf = pci_alloc_consistent(state->card->pci_dev,
-									      PAGE_SIZE << order,
-									      &dmabuf->dma_handle);
+					ret = alloc_dmabuf(dmabuf, state->card->pci_dev, order); 
 				}
-				if (!dmabuf->rawbuf) {
-					free_pages((unsigned long)state->dmabuf.rawbuf, state->dmabuf.buforder);
-					state->dmabuf.rawbuf = NULL;
-					i-=2;
-					for (; i >= 0; i--) {
-						pci_free_consistent(state->card->pci_dev,
-								    PAGE_SIZE << state->other_states[i]->dmabuf.buforder,
-								    state->other_states[i]->dmabuf.rawbuf,
-								    state->other_states[i]->dmabuf.dma_handle);
-					}
+				if (ret) {
+					/* release the main DMA buffer */ 
+					dealloc_dmabuf(&state->dmabuf, state->card->pci_dev); 
+					/* release the auxiliary DMA buffers */ 
+					for (i-=2; i >= 0; i--)
+						dealloc_dmabuf(&state->other_states[i]->dmabuf, 
+							       state->card->pci_dev); 
 					unlock_set_fmt(state);
-					return -ENOMEM;
+					return ret; 
 				}
-				dmabuf->ready  = dmabuf->mapped = 0;
-				dmabuf->buforder = order;
-				pend = virt_to_page(dmabuf->rawbuf + (PAGE_SIZE << order) - 1);
-				for (page = virt_to_page(dmabuf->rawbuf); page <= pend; page++)
-					mem_map_reserve(page);
 			}
 		}
 		/* FIXME: figure out all this OSS fragment stuff */
@@ -1294,22 +1343,20 @@
 		       dmabuf->dmasize);
 
 		spin_lock_irqsave(&s->card->lock, flags);
-		if (rec) {
+		if (rec) 
 			trident_rec_setup(s);
-		} else {
+		else 
 			trident_play_setup(s);
-		}
+		
 		spin_unlock_irqrestore(&s->card->lock, flags);
 
 		/* set the ready flag for the dma buffer */
 		dmabuf->ready = 1;
 
-#ifdef DEBUG
-	printk("trident: prog_dmabuf(%d), sample rate = %d, format = %d, numfrag = %d, "
-	       "fragsize = %d dmasize = %d\n",
-	       dmabuf->channel->num, dmabuf->rate, dmabuf->fmt, dmabuf->numfrag,
-	       dmabuf->fragsize, dmabuf->dmasize);
-#endif
+		TRDBG("trident: prog_dmabuf(%d), sample rate = %d, format = %d, numfrag = %d, "
+		      "fragsize = %d dmasize = %d\n",
+		      dmabuf->channel->num, dmabuf->rate, dmabuf->fmt, dmabuf->numfrag,
+		      dmabuf->fragsize, dmabuf->dmasize);
 	}
 	unlock_set_fmt(state);
 	return 0;
@@ -1533,19 +1580,21 @@
 {
 	int i;
 	struct trident_state *state;
+	unsigned int channel; 
 	
 	/* Update the pointers for all channels we are running. */
 	/* FIXME: should read interrupt status only once */
 	for (i = 0; i < NR_HW_CH; i++) {
-		if (trident_check_channel_interrupt(card, 63 - i)) {
-			trident_ack_channel_interrupt(card, 63 - i);
+		channel = 63 - i; 
+		if (trident_check_channel_interrupt(card, channel)) {
+			trident_ack_channel_interrupt(card, channel);
 			if ((state = card->states[i]) != NULL) {
 				trident_update_ptr(state);
 			} else {
-				printk("trident: spurious channel irq %d.\n",
-				       63 - i);
-				trident_stop_voice(card, 63 - i);
-				trident_disable_voice_irq(card, 63 - i);
+				printk(KERN_WARNING "trident: spurious channel "
+				       "irq %d.\n", channel);
+				trident_stop_voice(card, channel);
+				trident_disable_voice_irq(card, channel);
 			}
 		}
 	}
@@ -1653,29 +1702,29 @@
 {
 	int i,irq_status;
 	struct trident_state *state;
+	unsigned int channel; 
 
 	/* Update the pointers for all channels we are running. */
 	/* FIXED: read interrupt status only once */
 	irq_status=inl(TRID_REG(card, T4D_AINT_A) );
-#ifdef DEBUG	
-	printk("cyber_address_interrupt: irq_status 0x%X\n",irq_status);
-#endif
-	for (i = 0; i < NR_HW_CH; i++) {
-		if (irq_status & ( 1 << (31 - i)) ) {
 
+	TRDBG("cyber_address_interrupt: irq_status 0x%X\n",irq_status);
+
+	for (i = 0; i < NR_HW_CH; i++) {
+		channel = 31 - i; 
+		if (irq_status & ( 1 << channel) ) {
 			/* clear bit by writing a 1, zeroes are ignored */ 		
-			outl( (1 <<(31-i)), TRID_REG(card, T4D_AINT_A));
+			outl( (1 << channel), TRID_REG(card, T4D_AINT_A));
 		
-#ifdef DEBUG	
-	printk("cyber_interrupt: channel %d\n", 31-i);
-#endif
+			TRDBG("cyber_interrupt: channel %d\n", channel);
+
 			if ((state = card->states[i]) != NULL) {
 				trident_update_ptr(state);
 			} else {
-				printk("cyber5050: spurious channel irq %d.\n",
-				       31 - i);
-				trident_stop_voice(card, 31 - i);
-				trident_disable_voice_irq(card, 31 - i);
+				printk(KERN_WARNING "cyber5050: spurious "
+				       "channel irq %d.\n", channel); 
+				trident_stop_voice(card, channel);
+				trident_disable_voice_irq(card, channel);
 			}
 		}
 	}
@@ -1690,9 +1739,7 @@
 	spin_lock(&card->lock);
 	event = inl(TRID_REG(card, T4D_MISCINT));
 
-#ifdef DEBUG
-	printk("trident: trident_interrupt called, MISCINT = 0x%08x\n", event);
-#endif
+	TRDBG("trident: trident_interrupt called, MISCINT = 0x%08x\n", event);
 
 	if (event & ADDRESS_IRQ) {
 		card->address_interrupt(card);
@@ -1730,9 +1777,7 @@
 	unsigned swptr;
 	int cnt;
 
-#ifdef DEBUG
-	printk("trident: trident_read called, count = %d\n", count);
-#endif
+	TRDBG("trident: trident_read called, count = %d\n", count);
 
 	VALIDATE_STATE(state);
 	if (ppos != &file->f_pos)
@@ -1786,12 +1831,11 @@
 			   which results in a (potential) buffer overrun. And worse, there is
 			   NOTHING we can do to prevent it. */
 			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
-#ifdef DEBUG
-				printk(KERN_ERR "trident: recording schedule timeout, "
-				       "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
-				       dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
-				       dmabuf->hwptr, dmabuf->swptr);
-#endif
+				TRDBG(KERN_ERR "trident: recording schedule timeout, "
+				      "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
+				      dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
+				      dmabuf->hwptr, dmabuf->swptr);
+
 				/* a buffer overrun, we delay the recovery until next time the
 				   while loop begin and we REALLY have space to record */
 			}
@@ -1845,9 +1889,8 @@
 	unsigned int state_cnt;
 	unsigned int copy_count;
 
-#ifdef DEBUG
-	printk("trident: trident_write called, count = %d\n", count);
-#endif
+	TRDBG("trident: trident_write called, count = %d\n", count);
+
 	VALIDATE_STATE(state);
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
@@ -1915,12 +1958,11 @@
 			   which results in a (potential) buffer underrun. And worse, there is
 			   NOTHING we can do to prevent it. */
 			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
-#ifdef DEBUG
-				printk(KERN_ERR "trident: playback schedule timeout, "
-				       "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
-				       dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
-				       dmabuf->hwptr, dmabuf->swptr);
-#endif
+				TRDBG(KERN_ERR "trident: playback schedule timeout, "
+				      "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
+				      dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
+				      dmabuf->hwptr, dmabuf->swptr);
+
 				/* a buffer underrun, we delay the recovery until next time the
 				   while loop begin and we REALLY have data to play */
 			}
@@ -2099,10 +2141,8 @@
 	VALIDATE_STATE(state);
 	mapped = ((file->f_mode & FMODE_WRITE) && dmabuf->mapped) ||
 		((file->f_mode & FMODE_READ) && dmabuf->mapped);
-#ifdef DEBUG
-	printk("trident: trident_ioctl, command = %2d, arg = 0x%08x\n",
-	       _IOC_NR(cmd), arg ? *(int *)arg : 0);
-#endif
+	TRDBG("trident: trident_ioctl, command = %2d, arg = 0x%08x\n",
+	      _IOC_NR(cmd), arg ? *(int *)arg : 0);
 
 	switch (cmd) 
 	{
@@ -2262,6 +2302,7 @@
 						{
 							printk(KERN_ERR "trident: Record is working on the card!\n");
 							ret = -EBUSY;
+							unlock_set_fmt(state); 
 							break;
 						}
 
@@ -2665,10 +2706,8 @@
 	state->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 	up(&card->open_sem);
 
-#ifdef DEBUG
-       printk(KERN_ERR "trident: open virtual channel %d, hard channel %d\n", 
+	TRDBG("trident: open virtual channel %d, hard channel %d\n", 
               state->virt, dmabuf->channel->num);
-#endif
 
 	return 0;
 }
@@ -2678,7 +2717,6 @@
 	struct trident_state *state = (struct trident_state *)file->private_data;
 	struct trident_card *card;
 	struct dmabuf *dmabuf;
-	unsigned long flags;
 
 	lock_kernel();
 	card = state->card;
@@ -2690,20 +2728,15 @@
 		drain_dac(state, file->f_flags & O_NONBLOCK);
 	}
 
-#ifdef DEBUG
-	printk(KERN_ERR "trident: closing virtual channel %d, hard channel %d\n", 
-		state->virt, dmabuf->channel->num);
-#endif
+	TRDBG("trident: closing virtual channel %d, hard channel %d\n", 
+	      state->virt, dmabuf->channel->num);
 
 	/* stop DMA state machine and free DMA buffers/channels */
 	down(&card->open_sem);
 
 	if (file->f_mode & FMODE_WRITE) {
 		stop_dac(state);
-		lock_set_fmt(state);
-
-		unlock_set_fmt(state);
-		dealloc_dmabuf(state);
+		dealloc_dmabuf(&state->dmabuf, state->card->pci_dev);
 		state->card->free_pcm_channel(state->card, dmabuf->channel->num);
 
 		/* Added by Matt Wu */
@@ -2719,7 +2752,7 @@
 	}
 	if (file->f_mode & FMODE_READ) {
 		stop_adc(state);
-		dealloc_dmabuf(state);
+		dealloc_dmabuf(&state->dmabuf, state->card->pci_dev);
 		state->card->free_pcm_channel(state->card, dmabuf->channel->num);
 
 		/* Added by Matt Wu */
@@ -2868,62 +2901,74 @@
 	return ((u16) (data >> 16));
 }
 
-/* Write AC97 codec registers for ALi*/
-static void ali_ac97_set(struct trident_card *card, int secondary, u8 reg, u16 val)
+/* rewrite ac97 read and write mixer register by hulei for ALI*/
+static int acquirecodecaccess(struct trident_card *card)
 {
-	unsigned int address, mask;
-	unsigned int wCount1 = 0xffff;
-	unsigned int wCount2= 0xffff;
-	unsigned long chk1, chk2;
-	unsigned long flags;
-	u32 data;
-
-	data = ((u32) val) << 16;
-
-	if(!card)
-		BUG();
-		
-	address = ALI_AC97_WRITE;
-	mask = ALI_AC97_WRITE_ACTION | ALI_AC97_AUDIO_BUSY;
-	if (secondary)
-		mask |= ALI_AC97_SECONDARY;
-	if (card->revision == ALI_5451_V02)
-		mask |= ALI_AC97_WRITE_MIXER_REGISTER;
+	u16 wsemamask=0x6000; /* bit 14..13 */
+	u16 wsemabits;
+        u16 wcontrol ;
+	int block = 0;
+	int ncount = 25;
+	while (1) {
+		wcontrol = inw(TRID_REG(card,  ALI_AC97_WRITE));
+		wsemabits = wcontrol & wsemamask;
 		
-	spin_lock_irqsave(&card->lock, flags);
-	while (wCount1--) {
-		if ((inw(TRID_REG(card, address)) & ALI_AC97_BUSY_WRITE) == 0) {
-			data |= (mask | (reg & AC97_REG_ADDR));
-			
-			chk1 = inl(TRID_REG(card,  ALI_STIMER));
-			chk2 = inl(TRID_REG(card,  ALI_STIMER));
-			while (wCount2-- && (chk1 == chk2))
-				chk2 = inl(TRID_REG(card,  ALI_STIMER));
-			if (wCount2 == 0) {
-				spin_unlock_irqrestore(&card->lock, flags);
-				return;
-			}
-			outl(data, TRID_REG(card, address));	//write!
-			spin_unlock_irqrestore(&card->lock, flags);
-			return;	//success
+		if (wsemabits==0x4000)
+			return 1; /* 0x4000 is audio ,then success */
+		if (ncount-- < 0)
+			break;
+		if (wsemabits == 0)
+		{
+		unlock:
+			outl(((u32)(wcontrol & 0x1eff)|0x00004000), TRID_REG(card, ALI_AC97_WRITE));
+			continue;
 		}
-		inw(TRID_REG(card, address));	//wait for a read cycle
+		udelay(20);
+	}
+	if(!block)
+	{
+		TRDBG("accesscodecsemaphore: try unlock\n");
+		block = 1;
+		goto unlock;
 	}
+	printk(KERN_ERR "accesscodecsemaphore: fail\n");
+	return 0;
+}
 
-	printk(KERN_ERR "ali: AC97 CODEC write timed out.\n");
-	spin_unlock_irqrestore(&card->lock, flags);
-	return;
+static void releasecodecaccess(struct trident_card *card)
+{ 
+	unsigned long wcontrol;
+	wcontrol = inl(TRID_REG(card,  ALI_AC97_WRITE));
+	outl((wcontrol & 0xffff1eff), TRID_REG(card, ALI_AC97_WRITE));
+}
+
+static int waitforstimertick(struct trident_card *card)
+{
+	unsigned long chk1, chk2;
+	unsigned int wcount = 0xffff;
+	chk1 = inl(TRID_REG(card,  ALI_STIMER));
+	
+	while(1) {
+		chk2 = inl(TRID_REG(card,  ALI_STIMER));
+		if( (wcount > 0) && chk1 != chk2)
+			return 1;
+		if(wcount <= 0)
+			break;
+		udelay(50);
+	}
+
+	printk(KERN_NOTICE "waitforstimertick :BIT_CLK is dead\n");
+	return 0;
 }
 
 /* Read AC97 codec registers for ALi*/
 static u16 ali_ac97_get(struct trident_card *card, int secondary, u8 reg)
 {
 	unsigned int address, mask;
-        unsigned int wCount1 = 0xffff;
-        unsigned int wCount2= 0xffff;
-        unsigned long chk1, chk2;
-	unsigned long flags;
+	unsigned int ncount;
+        unsigned long aud_reg;
 	u32 data;
+        u16 wcontrol;
 
 	if(!card)
 		BUG();
@@ -2935,37 +2980,102 @@
 	mask = ALI_AC97_READ_ACTION | ALI_AC97_AUDIO_BUSY;
 	if (secondary)
 		mask |= ALI_AC97_SECONDARY;
+    
+	if (!acquirecodecaccess(card))
+		printk(KERN_ERR "access codec fail\n");
+	
+	wcontrol = inw(TRID_REG(card, ALI_AC97_WRITE));
+	wcontrol &= 0xfe00;
+	wcontrol |= (0x8000|reg);
+	outw(wcontrol,TRID_REG(card,  ALI_AC97_WRITE));
 
-	spin_lock_irqsave(&card->lock, flags);
 	data = (mask | (reg & AC97_REG_ADDR));
-	while (wCount1--) {
-		if ((inw(TRID_REG(card, address)) & ALI_AC97_BUSY_READ) == 0) {
-			chk1 = inl(TRID_REG(card,  ALI_STIMER));
-			chk2 = inl(TRID_REG(card,  ALI_STIMER));
-			while (wCount2-- && (chk1 == chk2))
-				chk2 = inl(TRID_REG(card,  ALI_STIMER));
-			if (wCount2 == 0) {
-				printk(KERN_ERR "ali: AC97 CODEC read timed out.\n");
-				spin_unlock_irqrestore(&card->lock, flags);
-				return 0;
-			}
-			outl(data, TRID_REG(card, address));	//read!
-			wCount2 = 0xffff;
-			while (wCount2--) {
-				if ((inw(TRID_REG(card, address)) & ALI_AC97_BUSY_READ) == 0) {
-					data = inl(TRID_REG(card, address));
-					spin_unlock_irqrestore(&card->lock, flags);
-					return ((u16) (data >> 16));
-				}
-			}
+	
+	if(!waitforstimertick(card)) {
+		printk(KERN_ERR "BIT_CLOCK is dead\n");
+		goto releasecodec;
+	}
+	
+	udelay(20);		
+	
+	ncount=10;
+	
+	while(1) {
+		if ((inw(TRID_REG(card,ALI_AC97_WRITE)) & ALI_AC97_BUSY_READ) != 0)
+			break;
+		if(ncount <=0)
+			break;
+		if(ncount--==1) {
+			TRDBG("ali_ac97_read :try clear busy flag\n");
+			aud_reg = inl(TRID_REG(card,  ALI_AC97_WRITE));
+			outl((aud_reg & 0xffff7fff), TRID_REG(card, ALI_AC97_WRITE));
 		}
-		inw(TRID_REG(card, address));	//wait a read cycle
+		udelay(10);
 	}
-	spin_unlock_irqrestore(&card->lock, flags);
+	
+	data = inl(TRID_REG(card, address));
+	
+	return ((u16) (data >> 16));
+
+ releasecodec: 
+	releasecodecaccess(card);
 	printk(KERN_ERR "ali: AC97 CODEC read timed out.\n");
 	return 0;
 }
 
+
+/* Write AC97 codec registers for hulei*/
+static void ali_ac97_set(struct trident_card *card, int secondary, u8 reg, u16 val)
+{
+	unsigned int address, mask;
+	unsigned int ncount;
+	u32 data;
+        u16 wcontrol;
+	
+	data = ((u32) val) << 16;
+	
+	if(!card)
+		BUG();
+	
+	address = ALI_AC97_WRITE;
+	mask = ALI_AC97_WRITE_ACTION | ALI_AC97_AUDIO_BUSY;
+	if (secondary)
+		mask |= ALI_AC97_SECONDARY;
+	if (card->revision == ALI_5451_V02)
+		mask |= ALI_AC97_WRITE_MIXER_REGISTER;
+		
+        if (!acquirecodecaccess(card))      
+		printk(KERN_ERR "access codec fail\n");
+			
+	wcontrol = inw(TRID_REG(card, ALI_AC97_WRITE));
+	wcontrol &= 0xff00;
+	wcontrol |= (0x8100|reg);/* bit 8=1: (ali1535 )reserved /ali1535+ write */
+	outl(( data |wcontrol), TRID_REG(card,ALI_AC97_WRITE ));
+
+        if(!waitforstimertick(card)) {
+		printk(KERN_ERR "BIT_CLOCK is dead\n");
+		goto releasecodec;
+	}
+	
+        ncount = 10;
+	while(1) {
+		wcontrol = inw(TRID_REG(card, ALI_AC97_WRITE));
+		if(!wcontrol & 0x8000)
+			break;
+		if(ncount <= 0)
+			break;
+		if(ncount-- == 1) {
+			TRDBG("ali_ac97_set :try clear busy flag!!\n");
+			outw(wcontrol & 0x7fff, TRID_REG(card, ALI_AC97_WRITE));
+		}
+		udelay(10);
+	}
+	
+ releasecodec:
+	releasecodecaccess(card);
+	return;
+}
+
 static void ali_enable_special_channel(struct trident_state *stat)
 {
 	struct trident_card *card = stat->card;
@@ -3463,7 +3573,7 @@
 
 static int trident_suspend(struct pci_dev *dev, u32 unused)
 {
-	struct trident_card *card = (struct trident_card *) dev;
+	struct trident_card *card = pci_get_drvdata(dev); 
 
 	if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {
 		ali_save_regs(card);
@@ -3473,7 +3583,7 @@
 
 static int trident_resume(struct pci_dev *dev)
 {
-	struct trident_card *card = (struct trident_card *) dev;
+	struct trident_card *card = pci_get_drvdata(dev); 
 
 	if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {
 		ali_restore_regs(card);
@@ -3600,7 +3710,10 @@
 depend on a master state's DMA, and changing the counters of the master
 state DMA is protected by a spinlock.
 */
-static int ali_write_5_1(struct trident_state *state,  const char *buf, int cnt_for_multi_channel, unsigned int *copy_count, unsigned int *state_cnt)
+static int ali_write_5_1(struct trident_state *state,  
+			 const char *buf, int cnt_for_multi_channel, 
+			 unsigned int *copy_count, 
+			 unsigned int *state_cnt)
 {
 	
 	struct dmabuf *dmabuf = &state->dmabuf;
@@ -3706,7 +3819,7 @@
 	other_states_count = state->chans_num - 2;	/* except PCM L/R channels*/
 	for ( i = 0; i < other_states_count; i++) {
 		s = state->other_states[i];
-		dealloc_dmabuf(s);
+		dealloc_dmabuf(&s->dmabuf, card->pci_dev);
 		ali_disable_special_channel(s->card, s->dmabuf.channel->num);
 		state->card->free_pcm_channel(s->card, s->dmabuf.channel->num);
 		card->states[s->virt] = NULL;
@@ -3714,7 +3827,6 @@
 	}
 }
 
-#ifdef CONFIG_PROC_FS
 struct proc_dir_entry *res;
 static int ali_write_proc(struct file *file, const char *buffer, unsigned long count, void *data)
 {
@@ -3752,7 +3864,6 @@
 
 	return count;
 }
-#endif
 
 /* OSS /dev/mixer file operation methods */
 static int trident_open_mixdev(struct inode *inode, struct file *file)
@@ -4030,13 +4141,11 @@
 		/* ALi SPDIF OUT function */
 		if(card->revision == ALI_5451_V02) {
 			ali_setup_spdif_out(card, ALI_PCM_TO_SPDIF_OUT);		
-#ifdef CONFIG_PROC_FS
 			res = create_proc_entry("ALi5451", 0, NULL);
 			if (res) {
 				res->write_proc = ali_write_proc;
 				res->data = card;
 			}
-#endif
 		}
 
 		/* Add H/W Volume Control By Matt Wu Jul. 06, 2001 */
@@ -4129,7 +4238,7 @@
 				ali_ac97_set(card, 0, AC97_POWER_CONTROL, ac97_data | ALI_EAPD_POWER_DOWN);
 			}
 		}
-#endif
+#endif /* CONFIG_ALPHA_NAUTILUS || CONFIG_ALPHA_GENERIC */ 
 		/* edited by HMSEO for GT sound*/
 	}
 	rc = 0;
@@ -4137,18 +4246,21 @@
 
 	/* Enable Address Engine Interrupts */
 	trident_enable_loop_interrupts(card);
+	
+	/* Attach joystick */
+	if((pci_dev->vendor == PCI_VENDOR_ID_TRIDENT) ||
+	   (pci_dev->vendor == PCI_VENDOR_ID_AL))
+		card->joystick = pcigame_attach(pci_dev, PCIGAME_4DWAVE);
 out:	return rc;
 out_unregister_sound_dsp:
 	unregister_sound_dsp(card->dev_audio);
 out_free_irq:
 	free_irq(card->irq, card);
 out_proc_fs:
-#ifdef CONFIG_PROC_FS
 	if (res) {
 		remove_proc_entry("ALi5451", NULL);
 		res = NULL;
 	}
-#endif
 	kfree(card);
 	devs = NULL;
 out_release_region:
@@ -4173,9 +4285,7 @@
 		ali_setup_spdif_out(card, ALI_PCM_TO_SPDIF_OUT);
                 ali_disable_special_channel(card, ALI_SPDIF_OUT_CHANNEL);
                 ali_disable_spdif_in(card);
-#ifdef CONFIG_PROC_FS
 		remove_proc_entry("ALi5451", NULL);
-#endif
 	}
 
 	/* Kill interrupts, and SP/DIF */
@@ -4192,6 +4302,9 @@
 			kfree (card->ac97_codec[i]);
 		}
 	unregister_sound_dsp(card->dev_audio);
+	
+	if(card->joystick)
+		pcigame_detach(card->joystick);
 
 	kfree(card);
 
@@ -4219,8 +4332,9 @@
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
 
-	printk(KERN_INFO "Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version "
-	       DRIVER_VERSION ", " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro "
+	       "5050 PCI Audio, version " DRIVER_VERSION ", " 
+	       __TIME__ " " __DATE__ "\n");
 
 	if (!pci_register_driver(&trident_pci_driver)) {
 		pci_unregister_driver(&trident_pci_driver);
--- linux-2.4.19/drivers/sound/trident.h	2002-08-03 00:39:44.000000000 +0000
+++ linux-2.4.20/drivers/sound/trident.h	2002-11-26 12:25:09.000000000 +0000
@@ -358,5 +358,16 @@
 	return r;
 }
 
-#endif /* __TRID4DWAVE_H */
+#ifdef DEBUG
+
+#define TRDBG(msg, args...) do {          \
+        printk(KERN_DEBUG msg , ##args ); \
+} while (0)
+
+#else /* !defined(DEBUG) */ 
 
+#define TRDBG(msg, args...) do { } while (0)
+
+#endif /* DEBUG */ 
+
+#endif /* __TRID4DWAVE_H */
