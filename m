Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSG1UVo>; Sun, 28 Jul 2002 16:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSG1UVo>; Sun, 28 Jul 2002 16:21:44 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:52628 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317299AbSG1UVT>; Sun, 28 Jul 2002 16:21:19 -0400
Date: Sun, 28 Jul 2002 23:19:32 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Muli Ben-Yehuda <mulix@actcom.co.il>
Subject: [PATCH] 2.5.29 sound/oss/trident.c [1/2] merge driver from 2.4-ac
Message-ID: <20020728201932.GA10499@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,=20

This patch (1/2) brings the sound/oss/trident.c driver up to date with
the driver in the 2.4-ac tree. It fixes the following bugs:=20

* fix wrong cast in suspend/resume (Eric Lemar via Ian Soboroff)

* fix bug where we would free with free_pages() memory allocated via
pci_alloc_consistent().=20

* add a missing unlock on an error path.=20

* rewrite the code to read/write registers of audio codecs for Ali5451
(Lei Hu)

It also does various cleanups so that the code conforms to
Documentation/CodingStyle and is nicer to work with.=20

Patch is against 2.5.29 (latest bitkeeper), compiled and
tested. Please apply.=20

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.479   -> 1.480 =20
#	 sound/oss/trident.h	1.7     -> 1.8   =20
#	 sound/oss/trident.c	1.22    -> 1.23  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/28	mulix@alhambra.merseine.nu	1.480
# merge the 2.4-ac trident.c driver
# --------------------------------------------
#
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	Sun Jul 28 23:07:47 2002
+++ b/sound/oss/trident.c	Sun Jul 28 23:07:47 2002
@@ -36,6 +36,35 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.10f
+ *      July 24 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      patch from Eric Lemar (via Ian Soboroff): in suspend and resume,=
=20
+ *      fix wrong cast from pci_dev* to struct trident_card*.=20
+ *  v0.14.10e
+ *      July 19 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      rewrite the DMA buffer allocation/deallcoation functions, to make =
it=20
+ *      modular and fix a bug where we would call free_pages on memory=20
+ *      obtained with pci_alloc_consistent. Also remove unnecessary #ifdef=
=20
+ *      CONFIG_PROC_FS and various other cleanups.
+ *  v0.14.10d
+ *      July 19 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      made several printk(KERN_NOTICE...) into TRDBG(...), to avoid spam=
ming
+ *      my syslog with hundreds of messages.=20
+ *  v0.14.10c
+ *      July 16 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      Cleaned up Lei Hu's 0.4.10 driver to conform to Documentation/Codi=
ngStyle
+ *      and the coding style used in the rest of the file.=20
+ *  v0.14.10b
+ *      June 23 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
+ *      add a missing unlock_set_fmt, remove a superflous lock/unlock pair=
=20
+ *      with nothing in between.=20
+ *  v0.14.10a
+ *      June 21 2002 Muli Ben-Yehuda <mulix@actcom.co.il>=20
+ *      use a debug macro instead of #ifdef CONFIG_DEBUG, trim to 80 colum=
ns=20
+ *      per line, use 'do {} while (0)' in statement macros.=20
+ *  v0.14.10
+ *      June 6 2002 Lei Hu <Lei_hu@ali.com.tw>
+ *      rewrite the part to read/write registers of audio codec for Ali545=
1=20
  *  v0.14.9e
  *      January 2 2002 Vojtech Pavlik <vojtech@ucw.cz> added gameport
  *      support to avoid resource conflict with pcigame.c
@@ -161,20 +190,21 @@
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
 #include <linux/gameport.h>
+#include <asm/uaccess.h>
+#include <asm/hardirq.h>
+#include <asm/io.h>
+#include <asm/dma.h>
=20
 #if defined CONFIG_ALPHA_NAUTILUS || CONFIG_ALPHA_GENERIC
 #include <asm/hwrpb.h>
@@ -182,9 +212,7 @@
=20
 #include "trident.h"
=20
-#include <linux/pm.h>
-
-#define DRIVER_VERSION "0.14.9e"
+#define DRIVER_VERSION "0.14.10f"
=20
 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC	0x5072696E /* "Prin" */
@@ -202,7 +230,13 @@
 /* minor number of /dev/swmodem (temporary, experimental) */
 #define SND_DEV_SWMODEM	7
=20
-static const unsigned ali_multi_channels_5_1[] =3D { /*ALI_SURR_LEFT_CHANN=
EL, ALI_SURR_RIGHT_CHANNEL,*/ ALI_CENTER_CHANNEL, ALI_LEF_CHANNEL, ALI_SURR=
_LEFT_CHANNEL, ALI_SURR_RIGHT_CHANNEL};
+static const unsigned ali_multi_channels_5_1[] =3D {=20
+	/*ALI_SURR_LEFT_CHANNEL, ALI_SURR_RIGHT_CHANNEL,*/
+	ALI_CENTER_CHANNEL,=20
+	ALI_LEF_CHANNEL,=20
+	ALI_SURR_LEFT_CHANNEL,=20
+	ALI_SURR_RIGHT_CHANNEL
+};
=20
 static const unsigned sample_size[] =3D { 1, 2, 2, 4 };
 static const unsigned sample_shift[] =3D { 0, 1, 1, 2 };
@@ -292,7 +326,7 @@
 	=09
 	} dmabuf;
=20
-	/* 5.1channels */=09
+	/* 5.1 channels */=09
 	struct trident_state *other_states[4];
 	int multi_channels_adjust_count;
 	unsigned chans_num;
@@ -319,6 +353,7 @@
 	u32 aint;
 	u32 aint_en;
 };
+
 static struct trident_pcm_bank_address bank_a_addrs =3D
 {
 	T4D_START_A,
@@ -326,6 +361,7 @@
 	T4D_AINT_A,
 	T4D_AINTEN_A
 };
+
 static struct trident_pcm_bank_address bank_b_addrs =3D
 {
 	T4D_START_B,
@@ -333,6 +369,7 @@
 	T4D_AINT_B,
 	T4D_AINTEN_B
 };
+
 struct trident_pcm_bank {
 	/* register addresses to control bank operations */
 	struct trident_pcm_bank_address *addresses;
@@ -398,6 +435,7 @@
 	HSET, MIC, MODEM_LINE1, MODEM_LINE2,
 	I2S_LR, SPDIF_LR
 };
+
 /* table to map from channel attribute to CHANNELMASK for SiS 7018 */
 static int attr2mask [] =3D {
 	DSP_BIND_MODEM1, DSP_BIND_MODEM2, DSP_BIND_FRONT, DSP_BIND_HANDSET,
@@ -406,7 +444,7 @@
=20
 /* Added by Matt Wu 01-05-2001 for spdif in */
 static int ali_close_multi_channels(void);
-static void ali_delay(struct trident_card *card,int interval);
+static void ali_delay(struct trident_card *card, int interval);
 static void ali_detect_spdif_rate(struct trident_card *card);
=20
 static void ali_ac97_write(struct ac97_codec *codec, u8 reg, u16 val);
@@ -438,8 +476,11 @@
 static void ali_disable_spdif_in(struct trident_card *card);
 static void ali_disable_special_channel(struct trident_card *card, int ch);
 static void ali_setup_spdif_out(struct trident_card *card, int flag);
-static int ali_write_5_1(struct trident_state *state, const char *buffer,i=
nt cnt_for_multi_channel, unsigned int *copy_count, unsigned int *state_cnt=
);
-static int ali_allocate_other_states_resources(struct trident_state *state=
, int chan_nums);
+static int ali_write_5_1(struct trident_state *state, const char *buffer,
+			 int cnt_for_multi_channel, unsigned int *copy_count,=20
+			 unsigned int *state_cnt);
+static int ali_allocate_other_states_resources(struct trident_state *state=
,=20
+					       int chan_nums);
 static void ali_free_other_states_resources(struct trident_state *state);
=20
=20
@@ -450,22 +491,29 @@
 	unsigned mixer_regs[ALI_MIXER_REGS];
 } ali_registers;
=20
-#define seek_offset(dma_ptr, buffer, cnt, offset, copy_count)	(dma_ptr) +=
=3D (offset);	\
-							(buffer) +=3D (offset);	\
-							(cnt) -=3D (offset);	\
-							(copy_count) +=3D (offset);
-
-#define lock_set_fmt(state)	{spin_lock_irqsave(&state->card->lock, flags);=
			\
-				if (state->fmt_flag) {						\
-					spin_unlock_irqrestore(&state->card->lock, flags);	\
-					return -EFAULT;						\
-				}								\
-				state->fmt_flag =3D 1;						\
-				spin_unlock_irqrestore(&state->card->lock, flags);}
+#define seek_offset(dma_ptr, buffer, cnt, offset, copy_count)	do { \
+        (dma_ptr) +=3D (offset);	  \
+	(buffer) +=3D (offset);	  \
+        (cnt) -=3D (offset);	  \
+	(copy_count) +=3D (offset); \
+} while (0)
+	 =20
+
+#define lock_set_fmt(state) do { \
+        spin_lock_irqsave(&state->card->lock, flags);			\
+	if (state->fmt_flag) {						\
+	       spin_unlock_irqrestore(&state->card->lock, flags);	\
+               return -EFAULT;					        \
+	}								\
+	state->fmt_flag =3D 1;						\
+	spin_unlock_irqrestore(&state->card->lock, flags);              \
+} while (0)
 			=09
-#define unlock_set_fmt(state)	{spin_lock_irqsave(&state->card->lock, flags=
);		\
-				state->fmt_flag =3D 0;					\
-				spin_unlock_irqrestore(&state->card->lock, flags);}
+#define unlock_set_fmt(state)  do {                             \
+        spin_lock_irqsave(&state->card->lock, flags);		\
+	state->fmt_flag =3D 0;					\
+	spin_unlock_irqrestore(&state->card->lock, flags);      \
+} while (0)
=20
 static int trident_enable_loop_interrupts(struct trident_card * card)
 {
@@ -490,10 +538,9 @@
=20
 	outl(global_control, TRID_REG(card, T4D_LFO_GC_CIR));
=20
-#ifdef DEBUG
-	printk("trident: Enable Loop Interrupts, globctl =3D 0x%08X\n",
-			inl(TRID_REG(card, T4D_LFO_GC_CIR)));
-#endif
+	TRDBG("trident: Enable Loop Interrupts, globctl =3D 0x%08X\n",
+	      inl(TRID_REG(card, T4D_LFO_GC_CIR)));
+
 	return (TRUE);
 }
=20
@@ -505,10 +552,9 @@
 	global_control &=3D ~(ENDLP_IE | MIDLP_IE);
 	outl(global_control, TRID_REG(card, T4D_LFO_GC_CIR));
=20
-#ifdef DEBUG
-	printk("trident: Disabled Loop Interrupts, globctl =3D 0x%08X\n",
-	       global_control);
-#endif
+	TRDBG("trident: Disabled Loop Interrupts, globctl =3D 0x%08X\n",
+	      global_control);
+
 	return (TRUE);
 }
=20
@@ -524,9 +570,9 @@
=20
 #ifdef DEBUG
 	reg =3D inl(TRID_REG(card, addr));
-	printk("trident: enabled IRQ on channel %d, %s =3D 0x%08x(addr:%X)\n",
-		channel, addr=3D=3DT4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
-#endif
+	TRDBG("trident: enabled IRQ on channel %d, %s =3D 0x%08x(addr:%X)\n",
+	      channel, addr=3D=3DT4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
+#endif /* DEBUG */=20
 }
=20
 static void trident_disable_voice_irq(struct trident_card * card, unsigned=
 int channel)
@@ -544,9 +590,9 @@
=20
 #ifdef DEBUG
 	reg =3D inl(TRID_REG(card, addr));
-	printk("trident: disabled IRQ on channel %d, %s =3D 0x%08x(addr:%X)\n",
-		channel, addr=3D=3DT4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
-#endif
+	TRDBG("trident: disabled IRQ on channel %d, %s =3D 0x%08x(addr:%X)\n",
+	      channel, addr=3D=3DT4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
+#endif /* DEBUG */=20
 }
=20
 static void trident_start_voice(struct trident_card * card, unsigned int c=
hannel)
@@ -557,15 +603,15 @@
=20
 #ifdef DEBUG
 	u32 reg;
-#endif
+#endif /* DEBUG */=20
=20
 	outl(mask, TRID_REG(card, addr));
=20
-#ifdef DEBUG
+#ifdef DEBUG=20
 	reg =3D inl(TRID_REG(card, addr));
-	printk("trident: start voice on channel %d, %s =3D 0x%08x(addr:%X)\n",
-		channel, addr=3D=3DT4D_START_B? "START_B":"START_A",reg,addr);
-#endif
+	TRDBG("trident: start voice on channel %d, %s =3D 0x%08x(addr:%X)\n",
+	      channel, addr=3D=3DT4D_START_B? "START_B":"START_A",reg,addr);
+#endif /* DEBUG */=20
 }
=20
 static void trident_stop_voice(struct trident_card * card, unsigned int ch=
annel)
@@ -576,15 +622,15 @@
=20
 #ifdef DEBUG
 	u32 reg;
-#endif
+#endif /* DEBUG */=20
=20
 	outl(mask, TRID_REG(card, addr));
=20
 #ifdef DEBUG
 	reg =3D inl(TRID_REG(card, addr));
-	printk("trident: stop voice on channel %d, %s =3D 0x%08x(addr:%X)\n",
-		channel, addr=3D=3DT4D_STOP_B? "STOP_B":"STOP_A",reg,addr);
-#endif
+	TRDBG("trident: stop voice on channel %d, %s =3D 0x%08x(addr:%X)\n",
+	      channel, addr=3D=3DT4D_STOP_B? "STOP_B":"STOP_A",reg,addr);
+#endif /* DEBUG */=20
 }
=20
 static u32 trident_get_interrupt_mask (struct trident_card * card, unsigne=
d int channel)
@@ -601,9 +647,9 @@
=20
 #ifdef DEBUG
 	if (reg & mask)
-		printk("trident: channel %d has interrupt, %s =3D 0x%08x\n",
-			channel,reg=3D=3DT4D_AINT_B? "AINT_B":"AINT_A", reg);
-#endif
+		TRDBG("trident: channel %d has interrupt, %s =3D 0x%08x\n",
+		      channel,reg=3D=3DT4D_AINT_B? "AINT_B":"AINT_A", reg);
+#endif /* DEBUG */=20
 	return (reg & mask) ? TRUE : FALSE;
 }
=20
@@ -619,9 +665,9 @@
=20
 #ifdef DEBUG
 	reg =3D inl(TRID_REG(card, T4D_AINT_B));
-	printk("trident: Ack channel %d interrupt, AINT_B =3D 0x%08x\n",
-	       channel, reg);
-#endif
+	TRDBG("trident: Ack channel %d interrupt, AINT_B =3D 0x%08x\n",
+	      channel, reg);
+#endif /* DEBUG */=20
 }
=20
 static struct trident_channel * trident_alloc_pcm_channel(struct trident_c=
ard *card)
@@ -869,9 +915,7 @@
=20
 	trident_write_voice_regs(state);
=20
-#ifdef DEBUG
-	printk("trident: called trident_set_dac_rate : rate =3D %d\n", rate);
-#endif
+	TRDBG("trident: called trident_set_dac_rate : rate =3D %d\n", rate);
=20
 	return rate;
 }
@@ -891,9 +935,8 @@
=20
 	trident_write_voice_regs(state);
=20
-#ifdef DEBUG
-	printk("trident: called trident_set_adc_rate : rate =3D %d\n", rate);
-#endif
+	TRDBG("trident: called trident_set_adc_rate : rate =3D %d\n", rate);
+
 	return rate;
 }
=20
@@ -935,11 +978,11 @@
 	if (dmabuf->fmt & TRIDENT_FMT_STEREO)
 		/* stereo */
 		channel->control |=3D CHANNEL_STEREO;
-#ifdef DEBUG
-	printk("trident: trident_play_setup, LBA =3D 0x%08x, "
-	       "Delta =3D 0x%08x, ESO =3D 0x%08x, Control =3D 0x%08x\n",
-	       channel->lba, channel->delta, channel->eso, channel->control);
-#endif
+
+	TRDBG("trident: trident_play_setup, LBA =3D 0x%08x, "
+	      "Delta =3D 0x%08x, ESO =3D 0x%08x, Control =3D 0x%08x\n",
+	      channel->lba, channel->delta, channel->eso, channel->control);
+
 	trident_write_voice_regs(state);
 }
=20
@@ -1021,11 +1064,11 @@
 	if (dmabuf->fmt & TRIDENT_FMT_STEREO)
 		/* stereo */
 		channel->control |=3D CHANNEL_STEREO;
-#ifdef DEBUG
-	printk("trident: trident_rec_setup, LBA =3D 0x%08x, "
-	       "Delat =3D 0x%08x, ESO =3D 0x%08x, Control =3D 0x%08x\n",
-	       channel->lba, channel->delta, channel->eso, channel->control);
-#endif
+=09
+	TRDBG("trident: trident_rec_setup, LBA =3D 0x%08x, "
+	      "Delat =3D 0x%08x, ESO =3D 0x%08x, Control =3D 0x%08x\n",
+	      channel->lba, channel->delta, channel->eso, channel->control);
+
 	trident_write_voice_regs(state);
 }
=20
@@ -1058,11 +1101,10 @@
 		return 0;
 	}
=20
-#ifdef DEBUG
-	printk("trident: trident_get_dma_addr: chip reported channel: %d, "
-	       "cso =3D 0x%04x\n",
-	       dmabuf->channel->num, cso);
-#endif
+=09
+	TRDBG("trident: trident_get_dma_addr: chip reported channel: %d, "
+	      "cso =3D 0x%04x\n", dmabuf->channel->num, cso);
+
 	/* ESO and CSO are in units of Samples, convert to byte offset */
 	cso <<=3D sample_shift[dmabuf->fmt];
=20
@@ -1160,27 +1202,18 @@
 #define DMABUF_DEFAULTORDER (15-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
=20
-/* allocate DMA buffer, playback and recording buffer should be allocated =
seperately */
-static int alloc_dmabuf(struct trident_state *state)
+/* alloc a DMA buffer of with a buffer of this order */=20
+static int alloc_dmabuf(struct dmabuf* dmabuf, struct pci_dev* pci_dev, in=
t order)
 {
-	struct dmabuf *dmabuf =3D &state->dmabuf;
 	void *rawbuf =3D NULL;
-	int order;
 	struct page *page, *pend;
=20
-	/* alloc as big a chunk as we can, FIXME: is this necessary ?? */
-	for (order =3D DMABUF_DEFAULTORDER; order >=3D DMABUF_MINORDER; order--)
-		if ((rawbuf =3D pci_alloc_consistent(state->card->pci_dev,
-						   PAGE_SIZE << order,
-						   &dmabuf->dma_handle)))
-			break;
-	if (!rawbuf)
+	if (!(rawbuf =3D pci_alloc_consistent(pci_dev, PAGE_SIZE << order,
+					    &dmabuf->dma_handle)))
 		return -ENOMEM;
=20
-#ifdef DEBUG
-	printk("trident: allocated %ld (order =3D %d) bytes at %p\n",
-	       PAGE_SIZE << order, order, rawbuf);
-#endif
+	TRDBG("trident: allocated %ld (order =3D %d) bytes at %p\n",
+	      PAGE_SIZE << order, order, rawbuf);
=20
 	dmabuf->ready  =3D dmabuf->mapped =3D 0;
 	dmabuf->rawbuf =3D rawbuf;
@@ -1194,21 +1227,37 @@
 	return 0;
 }
=20
-/* free DMA buffer */
-static void dealloc_dmabuf(struct trident_state *state)
+/* allocate the main DMA buffer, playback and recording buffer should be *=
/=20
+/* allocated seperately */
+static int alloc_main_dmabuf(struct trident_state *state)
 {
 	struct dmabuf *dmabuf =3D &state->dmabuf;
-	struct page *page, *pend;
+	int order;
+	int ret =3D -ENOMEM;=20
=20
+	/* alloc as big a chunk as we can, FIXME: is this necessary ?? */
+	for (order =3D DMABUF_DEFAULTORDER; order >=3D DMABUF_MINORDER; order--) {
+		if (!(ret =3D alloc_dmabuf(dmabuf, state->card->pci_dev, order)))
+			return 0;=20
+		/* else try again */=20
+	}
+	return ret;=20
+}
+
+/* deallocate a DMA buffer */=20
+static void dealloc_dmabuf(struct dmabuf* dmabuf, struct pci_dev* pci_dev)
+{
+	struct page *page, *pend;
+=09
 	if (dmabuf->rawbuf) {
 		/* undo marking the pages as reserved */
 		pend =3D virt_to_page(dmabuf->rawbuf + (PAGE_SIZE << dmabuf->buforder) -=
 1);
 		for (page =3D virt_to_page(dmabuf->rawbuf); page <=3D pend; page++)
 			mem_map_unreserve(page);
-		pci_free_consistent(state->card->pci_dev, PAGE_SIZE << dmabuf->buforder,
+		pci_free_consistent(pci_dev, PAGE_SIZE << dmabuf->buforder,
 				    dmabuf->rawbuf, dmabuf->dma_handle);
+		dmabuf->rawbuf =3D NULL;
 	}
-	dmabuf->rawbuf =3D NULL;
 	dmabuf->mapped =3D dmabuf->ready =3D 0;
 }
=20
@@ -1220,16 +1269,16 @@
 	unsigned bufsize, dma_nums;
 	unsigned long flags;
 	int ret, i, order;
-	struct page *page, *pend;
 =09
 	lock_set_fmt(state);
 	if (state->chans_num =3D=3D 6)
 		dma_nums =3D 5;
-	else 	dma_nums =3D 1;
+	else =09
+		dma_nums =3D 1;
 =09
 	for (i =3D 0; i < dma_nums; i++) {
 		if (i > 0) {
-			s =3D state->other_states[i - 1];		=09
+			s =3D state->other_states[i - 1];
 			dmabuf =3D &s->dmabuf;
 			dmabuf->fmt =3D state->dmabuf.fmt;
 			dmabuf->rate =3D state->dmabuf.rate;
@@ -1243,35 +1292,25 @@
 		/* allocate DMA buffer if not allocated yet */
 		if (!dmabuf->rawbuf) {
 			if (i =3D=3D 0) {
-				if ((ret =3D alloc_dmabuf(state))) {
+				if ((ret =3D alloc_main_dmabuf(state))) {
 					unlock_set_fmt(state);
 					return ret;
 				}
-			}
-			else {
+			} else {
+				ret =3D -ENOMEM;=20
 				if ((order =3D state->dmabuf.buforder - 1) >=3D DMABUF_MINORDER) {
-					dmabuf->rawbuf =3D pci_alloc_consistent(state->card->pci_dev,
-									      PAGE_SIZE << order,
-									      &dmabuf->dma_handle);
+					ret =3D alloc_dmabuf(dmabuf, state->card->pci_dev, order);=20
 				}
-				if (!dmabuf->rawbuf) {
-					free_pages((unsigned long)state->dmabuf.rawbuf, state->dmabuf.buforde=
r);
-					state->dmabuf.rawbuf =3D NULL;
-					i-=3D2;
-					for (; i >=3D 0; i--) {
-						pci_free_consistent(state->card->pci_dev,
-								    PAGE_SIZE << state->other_states[i]->dmabuf.buforder,
-								    state->other_states[i]->dmabuf.rawbuf,
-								    state->other_states[i]->dmabuf.dma_handle);
-					}
+				if (ret) {
+					/* release the main DMA buffer */=20
+					dealloc_dmabuf(&state->dmabuf, state->card->pci_dev);=20
+					/* release the auxiliary DMA buffers */=20
+					for (i-=3D2; i >=3D 0; i--)
+						dealloc_dmabuf(&state->other_states[i]->dmabuf,=20
+							       state->card->pci_dev);=20
 					unlock_set_fmt(state);
-					return -ENOMEM;
+					return ret;=20
 				}
-				dmabuf->ready  =3D dmabuf->mapped =3D 0;
-				dmabuf->buforder =3D order;
-				pend =3D virt_to_page(dmabuf->rawbuf + (PAGE_SIZE << order) - 1);
-				for (page =3D virt_to_page(dmabuf->rawbuf); page <=3D pend; page++)
-					mem_map_reserve(page);
 			}
 		}
 		/* FIXME: figure out all this OSS fragment stuff */
@@ -1301,22 +1340,20 @@
 		       dmabuf->dmasize);
=20
 		spin_lock_irqsave(&s->card->lock, flags);
-		if (rec) {
+		if (rec)=20
 			trident_rec_setup(s);
-		} else {
+		else=20
 			trident_play_setup(s);
-		}
+	=09
 		spin_unlock_irqrestore(&s->card->lock, flags);
=20
 		/* set the ready flag for the dma buffer */
 		dmabuf->ready =3D 1;
=20
-#ifdef DEBUG
-	printk("trident: prog_dmabuf(%d), sample rate =3D %d, format =3D %d, numf=
rag =3D %d, "
-	       "fragsize =3D %d dmasize =3D %d\n",
-	       dmabuf->channel->num, dmabuf->rate, dmabuf->fmt, dmabuf->numfrag,
-	       dmabuf->fragsize, dmabuf->dmasize);
-#endif
+		TRDBG("trident: prog_dmabuf(%d), sample rate =3D %d, format =3D %d, numf=
rag =3D %d, "
+		      "fragsize =3D %d dmasize =3D %d\n",
+		      dmabuf->channel->num, dmabuf->rate, dmabuf->fmt, dmabuf->numfrag,
+		      dmabuf->fragsize, dmabuf->dmasize);
 	}
 	unlock_set_fmt(state);
 	return 0;
@@ -1540,19 +1577,21 @@
 {
 	int i;
 	struct trident_state *state;
+	unsigned int channel;=20
 =09
 	/* Update the pointers for all channels we are running. */
 	/* FIXME: should read interrupt status only once */
 	for (i =3D 0; i < NR_HW_CH; i++) {
-		if (trident_check_channel_interrupt(card, 63 - i)) {
-			trident_ack_channel_interrupt(card, 63 - i);
+		channel =3D 63 - i;=20
+		if (trident_check_channel_interrupt(card, channel)) {
+			trident_ack_channel_interrupt(card, channel);
 			if ((state =3D card->states[i]) !=3D NULL) {
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
@@ -1660,29 +1699,29 @@
 {
 	int i,irq_status;
 	struct trident_state *state;
+	unsigned int channel;=20
=20
 	/* Update the pointers for all channels we are running. */
 	/* FIXED: read interrupt status only once */
 	irq_status=3Dinl(TRID_REG(card, T4D_AINT_A) );
-#ifdef DEBUG=09
-	printk("cyber_address_interrupt: irq_status 0x%X\n",irq_status);
-#endif
-	for (i =3D 0; i < NR_HW_CH; i++) {
-		if (irq_status & ( 1 << (31 - i)) ) {
=20
+	TRDBG("cyber_address_interrupt: irq_status 0x%X\n",irq_status);
+
+	for (i =3D 0; i < NR_HW_CH; i++) {
+		channel =3D 31 - i;=20
+		if (irq_status & ( 1 << channel) ) {
 			/* clear bit by writing a 1, zeroes are ignored */ 	=09
-			outl( (1 <<(31-i)), TRID_REG(card, T4D_AINT_A));
+			outl( (1 << channel), TRID_REG(card, T4D_AINT_A));
 	=09
-#ifdef DEBUG=09
-	printk("cyber_interrupt: channel %d\n", 31-i);
-#endif
+			TRDBG("cyber_interrupt: channel %d\n", channel);
+
 			if ((state =3D card->states[i]) !=3D NULL) {
 				trident_update_ptr(state);
 			} else {
-				printk("cyber5050: spurious channel irq %d.\n",
-				       31 - i);
-				trident_stop_voice(card, 31 - i);
-				trident_disable_voice_irq(card, 31 - i);
+				printk(KERN_WARNING "cyber5050: spurious "
+				       "channel irq %d.\n", channel);=20
+				trident_stop_voice(card, channel);
+				trident_disable_voice_irq(card, channel);
 			}
 		}
 	}
@@ -1697,9 +1736,7 @@
 	spin_lock(&card->lock);
 	event =3D inl(TRID_REG(card, T4D_MISCINT));
=20
-#ifdef DEBUG
-	printk("trident: trident_interrupt called, MISCINT =3D 0x%08x\n", event);
-#endif
+	TRDBG("trident: trident_interrupt called, MISCINT =3D 0x%08x\n", event);
=20
 	if (event & ADDRESS_IRQ) {
 		card->address_interrupt(card);
@@ -1737,9 +1774,7 @@
 	unsigned swptr;
 	int cnt;
=20
-#ifdef DEBUG
-	printk("trident: trident_read called, count =3D %d\n", count);
-#endif
+	TRDBG("trident: trident_read called, count =3D %d\n", count);
=20
 	VALIDATE_STATE(state);
 	if (ppos !=3D &file->f_pos)
@@ -1793,12 +1828,11 @@
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
@@ -1852,9 +1886,8 @@
 	unsigned int state_cnt;
 	unsigned int copy_count;
=20
-#ifdef DEBUG
-	printk("trident: trident_write called, count =3D %d\n", count);
-#endif
+	TRDBG("trident: trident_write called, count =3D %d\n", count);
+
 	VALIDATE_STATE(state);
 	if (ppos !=3D &file->f_pos)
 		return -ESPIPE;
@@ -1922,12 +1955,11 @@
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
@@ -2106,10 +2138,8 @@
 	VALIDATE_STATE(state);
 	mapped =3D ((file->f_mode & FMODE_WRITE) && dmabuf->mapped) ||
 		((file->f_mode & FMODE_READ) && dmabuf->mapped);
-#ifdef DEBUG
-	printk("trident: trident_ioctl, command =3D %2d, arg =3D 0x%08x\n",
-	       _IOC_NR(cmd), arg ? *(int *)arg : 0);
-#endif
+	TRDBG("trident: trident_ioctl, command =3D %2d, arg =3D 0x%08x\n",
+	      _IOC_NR(cmd), arg ? *(int *)arg : 0);
=20
 	switch (cmd)=20
 	{
@@ -2269,6 +2299,7 @@
 						{
 							printk(KERN_ERR "trident: Record is working on the card!\n");
 							ret =3D -EBUSY;
+							unlock_set_fmt(state);=20
 							break;
 						}
=20
@@ -2454,8 +2485,7 @@
 		if (dmabuf->mapped)
 			dmabuf->count &=3D dmabuf->fragsize-1;
 		spin_unlock_irqrestore(&state->card->lock, flags);
-		ret =3D copy_to_user((void *)arg, &cinfo, sizeof(cinfo)) ?
-				-EFAULT : 0;
+		ret =3D copy_to_user((void *)arg, &cinfo, sizeof(cinfo))?-EFAULT:0;
 		break;
=20
 	case SNDCTL_DSP_GETOPTR:
@@ -2673,10 +2703,8 @@
 	state->open_mode |=3D file->f_mode & (FMODE_READ | FMODE_WRITE);
 	up(&card->open_sem);
=20
-#ifdef DEBUG
-       printk(KERN_ERR "trident: open virtual channel %d, hard channel %d\=
n",=20
+	TRDBG("trident: open virtual channel %d, hard channel %d\n",=20
               state->virt, dmabuf->channel->num);
-#endif
=20
 	return 0;
 }
@@ -2686,7 +2714,6 @@
 	struct trident_state *state =3D (struct trident_state *)file->private_dat=
a;
 	struct trident_card *card;
 	struct dmabuf *dmabuf;
-	unsigned long flags;
=20
 	lock_kernel();
 	card =3D state->card;
@@ -2698,20 +2725,15 @@
 		drain_dac(state, file->f_flags & O_NONBLOCK);
 	}
=20
-#ifdef DEBUG
-	printk(KERN_ERR "trident: closing virtual channel %d, hard channel %d\n",=
=20
-		state->virt, dmabuf->channel->num);
-#endif
+	TRDBG("trident: closing virtual channel %d, hard channel %d\n",=20
+	      state->virt, dmabuf->channel->num);
=20
 	/* stop DMA state machine and free DMA buffers/channels */
 	down(&card->open_sem);
=20
 	if (file->f_mode & FMODE_WRITE) {
 		stop_dac(state);
-		lock_set_fmt(state);
-
-		unlock_set_fmt(state);
-		dealloc_dmabuf(state);
+		dealloc_dmabuf(&state->dmabuf, state->card->pci_dev);
 		state->card->free_pcm_channel(state->card, dmabuf->channel->num);
=20
 		/* Added by Matt Wu */
@@ -2727,7 +2749,7 @@
 	}
 	if (file->f_mode & FMODE_READ) {
 		stop_adc(state);
-		dealloc_dmabuf(state);
+		dealloc_dmabuf(&state->dmabuf, state->card->pci_dev);
 		state->card->free_pcm_channel(state->card, dmabuf->channel->num);
=20
 		/* Added by Matt Wu */
@@ -2876,62 +2898,74 @@
 	return ((u16) (data >> 16));
 }
=20
-/* Write AC97 codec registers for ALi*/
-static void ali_ac97_set(struct trident_card *card, int secondary, u8 reg,=
 u16 val)
+/* rewrite ac97 read and write mixer register by hulei for ALI*/
+static int acquirecodecaccess(struct trident_card *card)
 {
-	unsigned int address, mask;
-	unsigned int wCount1 =3D 0xffff;
-	unsigned int wCount2=3D 0xffff;
-	unsigned long chk1, chk2;
-	unsigned long flags;
-	u32 data;
-
-	data =3D ((u32) val) << 16;
-
-	if(!card)
-		BUG();
-	=09
-	address =3D ALI_AC97_WRITE;
-	mask =3D ALI_AC97_WRITE_ACTION | ALI_AC97_AUDIO_BUSY;
-	if (secondary)
-		mask |=3D ALI_AC97_SECONDARY;
-	if (card->revision =3D=3D ALI_5451_V02)
-		mask |=3D ALI_AC97_WRITE_MIXER_REGISTER;
+	u16 wsemamask=3D0x6000; /* bit 14..13 */
+	u16 wsemabits;
+        u16 wcontrol ;
+	int block =3D 0;
+	int ncount =3D 25;
+	while (1) {
+		wcontrol =3D inw(TRID_REG(card,  ALI_AC97_WRITE));
+		wsemabits =3D wcontrol & wsemamask;
 	=09
-	spin_lock_irqsave(&card->lock, flags);
-	while (wCount1--) {
-		if ((inw(TRID_REG(card, address)) & ALI_AC97_BUSY_WRITE) =3D=3D 0) {
-			data |=3D (mask | (reg & AC97_REG_ADDR));
-		=09
-			chk1 =3D inl(TRID_REG(card,  ALI_STIMER));
-			chk2 =3D inl(TRID_REG(card,  ALI_STIMER));
-			while (wCount2-- && (chk1 =3D=3D chk2))
-				chk2 =3D inl(TRID_REG(card,  ALI_STIMER));
-			if (wCount2 =3D=3D 0) {
-				spin_unlock_irqrestore(&card->lock, flags);
-				return;
-			}
-			outl(data, TRID_REG(card, address));	//write!
-			spin_unlock_irqrestore(&card->lock, flags);
-			return;	//success
+		if (wsemabits=3D=3D0x4000)
+			return 1; /* 0x4000 is audio ,then success */
+		if (ncount-- < 0)
+			break;
+		if (wsemabits =3D=3D 0)
+		{
+		unlock:
+			outl(((u32)(wcontrol & 0x1eff)|0x00004000), TRID_REG(card, ALI_AC97_WRI=
TE));
+			continue;
 		}
-		inw(TRID_REG(card, address));	//wait for a read cycle
+		udelay(20);
+	}
+	if(!block)
+	{
+		TRDBG("accesscodecsemaphore: try unlock\n");
+		block =3D 1;
+		goto unlock;
 	}
+	printk(KERN_ERR "accesscodecsemaphore: fail\n");
+	return 0;
+}
=20
-	printk(KERN_ERR "ali: AC97 CODEC write timed out.\n");
-	spin_unlock_irqrestore(&card->lock, flags);
-	return;
+static void releasecodecaccess(struct trident_card *card)
+{=20
+	unsigned long wcontrol;
+	wcontrol =3D inl(TRID_REG(card,  ALI_AC97_WRITE));
+	outl((wcontrol & 0xffff1eff), TRID_REG(card, ALI_AC97_WRITE));
+}
+
+static int waitforstimertick(struct trident_card *card)
+{
+	unsigned long chk1, chk2;
+	unsigned int wcount =3D 0xffff;
+	chk1 =3D inl(TRID_REG(card,  ALI_STIMER));
+=09
+	while(1) {
+		chk2 =3D inl(TRID_REG(card,  ALI_STIMER));
+		if( (wcount > 0) && chk1 !=3D chk2)
+			return 1;
+		if(wcount <=3D 0)
+			break;
+		udelay(50);
+	}
+
+	printk(KERN_NOTICE "waitforstimertick :BIT_CLK is dead\n");
+	return 0;
 }
=20
 /* Read AC97 codec registers for ALi*/
 static u16 ali_ac97_get(struct trident_card *card, int secondary, u8 reg)
 {
 	unsigned int address, mask;
-        unsigned int wCount1 =3D 0xffff;
-        unsigned int wCount2=3D 0xffff;
-        unsigned long chk1, chk2;
-	unsigned long flags;
+	unsigned int ncount;
+        unsigned long aud_reg;
 	u32 data;
+        u16 wcontrol;
=20
 	if(!card)
 		BUG();
@@ -2943,37 +2977,102 @@
 	mask =3D ALI_AC97_READ_ACTION | ALI_AC97_AUDIO_BUSY;
 	if (secondary)
 		mask |=3D ALI_AC97_SECONDARY;
+   =20
+	if (!acquirecodecaccess(card))
+		printk(KERN_ERR "access codec fail\n");
+=09
+	wcontrol =3D inw(TRID_REG(card, ALI_AC97_WRITE));
+	wcontrol &=3D 0xfe00;
+	wcontrol |=3D (0x8000|reg);
+	outw(wcontrol,TRID_REG(card,  ALI_AC97_WRITE));
=20
-	spin_lock_irqsave(&card->lock, flags);
 	data =3D (mask | (reg & AC97_REG_ADDR));
-	while (wCount1--) {
-		if ((inw(TRID_REG(card, address)) & ALI_AC97_BUSY_READ) =3D=3D 0) {
-			chk1 =3D inl(TRID_REG(card,  ALI_STIMER));
-			chk2 =3D inl(TRID_REG(card,  ALI_STIMER));
-			while (wCount2-- && (chk1 =3D=3D chk2))
-				chk2 =3D inl(TRID_REG(card,  ALI_STIMER));
-			if (wCount2 =3D=3D 0) {
-				printk(KERN_ERR "ali: AC97 CODEC read timed out.\n");
-				spin_unlock_irqrestore(&card->lock, flags);
-				return 0;
-			}
-			outl(data, TRID_REG(card, address));	//read!
-			wCount2 =3D 0xffff;
-			while (wCount2--) {
-				if ((inw(TRID_REG(card, address)) & ALI_AC97_BUSY_READ) =3D=3D 0) {
-					data =3D inl(TRID_REG(card, address));
-					spin_unlock_irqrestore(&card->lock, flags);
-					return ((u16) (data >> 16));
-				}
-			}
+=09
+	if(!waitforstimertick(card)) {
+		printk(KERN_ERR "BIT_CLOCK is dead\n");
+		goto releasecodec;
+	}
+=09
+	udelay(20);	=09
+=09
+	ncount=3D10;
+=09
+	while(1) {
+		if ((inw(TRID_REG(card,ALI_AC97_WRITE)) & ALI_AC97_BUSY_READ) !=3D 0)
+			break;
+		if(ncount <=3D0)
+			break;
+		if(ncount--=3D=3D1) {
+			TRDBG("ali_ac97_read :try clear busy flag\n");
+			aud_reg =3D inl(TRID_REG(card,  ALI_AC97_WRITE));
+			outl((aud_reg & 0xffff7fff), TRID_REG(card, ALI_AC97_WRITE));
 		}
-		inw(TRID_REG(card, address));	//wait a read cycle
+		udelay(10);
 	}
-	spin_unlock_irqrestore(&card->lock, flags);
+=09
+	data =3D inl(TRID_REG(card, address));
+=09
+	return ((u16) (data >> 16));
+
+ releasecodec:=20
+	releasecodecaccess(card);
 	printk(KERN_ERR "ali: AC97 CODEC read timed out.\n");
 	return 0;
 }
=20
+
+/* Write AC97 codec registers for hulei*/
+static void ali_ac97_set(struct trident_card *card, int secondary, u8 reg,=
 u16 val)
+{
+	unsigned int address, mask;
+	unsigned int ncount;
+	u32 data;
+        u16 wcontrol;
+=09
+	data =3D ((u32) val) << 16;
+=09
+	if(!card)
+		BUG();
+=09
+	address =3D ALI_AC97_WRITE;
+	mask =3D ALI_AC97_WRITE_ACTION | ALI_AC97_AUDIO_BUSY;
+	if (secondary)
+		mask |=3D ALI_AC97_SECONDARY;
+	if (card->revision =3D=3D ALI_5451_V02)
+		mask |=3D ALI_AC97_WRITE_MIXER_REGISTER;
+	=09
+        if (!acquirecodecaccess(card))     =20
+		printk(KERN_ERR "access codec fail\n");
+		=09
+	wcontrol =3D inw(TRID_REG(card, ALI_AC97_WRITE));
+	wcontrol &=3D 0xff00;
+	wcontrol |=3D (0x8100|reg);/* bit 8=3D1: (ali1535 )reserved /ali1535+ wri=
te */
+	outl(( data |wcontrol), TRID_REG(card,ALI_AC97_WRITE ));
+
+        if(!waitforstimertick(card)) {
+		printk(KERN_ERR "BIT_CLOCK is dead\n");
+		goto releasecodec;
+	}
+=09
+        ncount =3D 10;
+	while(1) {
+		wcontrol =3D inw(TRID_REG(card, ALI_AC97_WRITE));
+		if(!wcontrol & 0x8000)
+			break;
+		if(ncount <=3D 0)
+			break;
+		if(ncount-- =3D=3D 1) {
+			TRDBG("ali_ac97_set :try clear busy flag!!\n");
+			outw(wcontrol & 0x7fff, TRID_REG(card, ALI_AC97_WRITE));
+		}
+		udelay(10);
+	}
+=09
+ releasecodec:
+	releasecodecaccess(card);
+	return;
+}
+
 static void ali_enable_special_channel(struct trident_state *stat)
 {
 	struct trident_card *card =3D stat->card;
@@ -3305,11 +3404,18 @@
 			ali_ac97_write(card->ac97_codec[0], 0x02, 8080);
 			ali_ac97_write(card->ac97_codec[0], 0x36, 0);
 			ali_ac97_write(card->ac97_codec[0], 0x38, 0);
-			ali_ac97_write(card->ac97_codec[1], 0x36, 0);
-			ali_ac97_write(card->ac97_codec[1], 0x38, 0);
-			ali_ac97_write(card->ac97_codec[1], 0x02, 0x0606);
-			ali_ac97_write(card->ac97_codec[1], 0x18, 0x0303);
-			ali_ac97_write(card->ac97_codec[1], 0x74, 0x3);
+			/*
+			 *	On a board with a single codec you won't get the
+			 *	surround. On other boards configure it.
+			 */
+			if(card->ac97_codec[1]!=3DNULL)
+			{
+				ali_ac97_write(card->ac97_codec[1], 0x36, 0);
+				ali_ac97_write(card->ac97_codec[1], 0x38, 0);
+				ali_ac97_write(card->ac97_codec[1], 0x02, 0x0606);
+				ali_ac97_write(card->ac97_codec[1], 0x18, 0x0303);
+				ali_ac97_write(card->ac97_codec[1], 0x74, 0x3);
+			}
 			return 1;
 		}
 	}
@@ -3464,7 +3570,7 @@
=20
 static int trident_suspend(struct pci_dev *dev, u32 unused)
 {
-	struct trident_card *card =3D (struct trident_card *) dev;
+	struct trident_card *card =3D pci_get_drvdata(dev);=20
=20
 	if(card->pci_id =3D=3D PCI_DEVICE_ID_ALI_5451) {
 		ali_save_regs(card);
@@ -3474,7 +3580,7 @@
=20
 static int trident_resume(struct pci_dev *dev)
 {
-	struct trident_card *card =3D (struct trident_card *) dev;
+	struct trident_card *card =3D pci_get_drvdata(dev);=20
=20
 	if(card->pci_id =3D=3D PCI_DEVICE_ID_ALI_5451) {
 		ali_restore_regs(card);
@@ -3601,7 +3707,10 @@
 depend on a master state's DMA, and changing the counters of the master
 state DMA is protected by a spinlock.
 */
-static int ali_write_5_1(struct trident_state *state,  const char *buf, in=
t cnt_for_multi_channel, unsigned int *copy_count, unsigned int *state_cnt)
+static int ali_write_5_1(struct trident_state *state, =20
+			 const char *buf, int cnt_for_multi_channel,=20
+			 unsigned int *copy_count,=20
+			 unsigned int *state_cnt)
 {
 =09
 	struct dmabuf *dmabuf =3D &state->dmabuf;
@@ -3707,7 +3816,7 @@
 	other_states_count =3D state->chans_num - 2;	/* except PCM L/R channels*/
 	for ( i =3D 0; i < other_states_count; i++) {
 		s =3D state->other_states[i];
-		dealloc_dmabuf(s);
+		dealloc_dmabuf(&s->dmabuf, card->pci_dev);
 		ali_disable_special_channel(s->card, s->dmabuf.channel->num);
 		state->card->free_pcm_channel(s->card, s->dmabuf.channel->num);
 		card->states[s->virt] =3D NULL;
@@ -3715,7 +3824,6 @@
 	}
 }
=20
-#ifdef CONFIG_PROC_FS
 struct proc_dir_entry *res;
 static int ali_write_proc(struct file *file, const char *buffer, unsigned =
long count, void *data)
 {
@@ -3753,7 +3861,6 @@
=20
 	return count;
 }
-#endif
=20
 /* OSS /dev/mixer file operation methods */
 static int trident_open_mixdev(struct inode *inode, struct file *file)
@@ -3821,7 +3928,7 @@
 	pci_write_config_dword(pci_dev, 0x44, dwVal & 0xfffbffff);
 	udelay(5000);
=20
-	wCount =3D 200;
+	wCount =3D 2000;
 	while(wCount--) {
 		wReg =3D ali_ac97_get(card, 0, AC97_POWER_CONTROL);
 		if((wReg & 0x000f) =3D=3D 0x000f)
@@ -4087,13 +4194,11 @@
 		/* ALi SPDIF OUT function */
 		if(card->revision =3D=3D ALI_5451_V02) {
 			ali_setup_spdif_out(card, ALI_PCM_TO_SPDIF_OUT);	=09
-#ifdef CONFIG_PROC_FS
 			res =3D create_proc_entry("ALi5451", 0, NULL);
 			if (res) {
 				res->write_proc =3D ali_write_proc;
 				res->data =3D card;
 			}
-#endif
 		}
=20
 		/* Add H/W Volume Control By Matt Wu Jul. 06, 2001 */
@@ -4186,7 +4291,7 @@
 				ali_ac97_set(card, 0, AC97_POWER_CONTROL, ac97_data | ALI_EAPD_POWER_D=
OWN);
 			}
 		}
-#endif
+#endif /* CONFIG_ALPHA_NAUTILUS || CONFIG_ALPHA_GENERIC */=20
 		/* edited by HMSEO for GT sound*/
 	}
 	rc =3D 0;
@@ -4204,12 +4309,10 @@
 out_free_irq:
 	free_irq(card->irq, card);
 out_proc_fs:
-#ifdef CONFIG_PROC_FS
 	if (res) {
 		remove_proc_entry("ALi5451", NULL);
 		res =3D NULL;
 	}
-#endif
 	kfree(card);
 	devs =3D NULL;
 out_release_region:
@@ -4234,9 +4337,7 @@
 		ali_setup_spdif_out(card, ALI_PCM_TO_SPDIF_OUT);
                 ali_disable_special_channel(card, ALI_SPDIF_OUT_CHANNEL);
                 ali_disable_spdif_in(card);
-#ifdef CONFIG_PROC_FS
 		remove_proc_entry("ALi5451", NULL);
-#endif
 	}
=20
 	/* Unregister gameport */
@@ -4283,8 +4384,9 @@
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
=20
-	printk(KERN_INFO "Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI=
 Audio, version "
-	       DRIVER_VERSION ", " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro "
+	       "5050 PCI Audio, version " DRIVER_VERSION ", "=20
+	       __TIME__ " " __DATE__ "\n");
=20
 	if (!pci_register_driver(&trident_pci_driver)) {
 		pci_unregister_driver(&trident_pci_driver);
diff -Nru a/sound/oss/trident.h b/sound/oss/trident.h
--- a/sound/oss/trident.h	Sun Jul 28 23:07:47 2002
+++ b/sound/oss/trident.h	Sun Jul 28 23:07:47 2002
@@ -360,5 +360,16 @@
 	return r;
 }
=20
-#endif /* __TRID4DWAVE_H */
+#ifdef DEBUG
+
+#define TRDBG(msg, args...) do {          \
+        printk(KERN_DEBUG msg , ##args ); \
+} while (0)
+
+#else /* !defined(DEBUG) */=20
=20
+#define TRDBG(msg, args...) do { } while (0)
+
+#endif /* DEBUG */=20
+
+#endif /* __TRID4DWAVE_H */



--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9RFHUKRs727/VN8sRAgzJAKCGN7mXd/wkL6vvwou+xOyPmkt7zQCdF5qw
di70g+ndqQmXzcCz++vXk4U=
=HGNB
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
