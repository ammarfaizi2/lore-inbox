Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317403AbSFXFzU>; Mon, 24 Jun 2002 01:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317409AbSFXFzT>; Mon, 24 Jun 2002 01:55:19 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:25608 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S317403AbSFXFzO>; Mon, 24 Jun 2002 01:55:14 -0400
Date: Mon, 24 Jun 2002 08:51:30 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: drivers/sound/trident.c [1/2] debug cleanup
Message-ID: <20020624085130.O9997@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="44EoV7tf2AX9r8hV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--44EoV7tf2AX9r8hV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,=20

Here is a patch to drivers/sound/trident.c to make it adher to the
common coding style in the kernel. I'm chasing an elusive bug in it,
and cleaning it up as I go along. This patch implements a debug macro
dependant on DEBUG and protected by do {} while (0), and replaces the
various #ifdef DEBUG .. #endif statements littered in the code with it.=20

Patch was sent to maintainer, who replied that he no longer maintains
the driver.=20

Patch against 2.4.19pre9.=20

diff -Naur --exclude-from /home/mulix/work/dontdiff linux-2.4.19-pre9/drive=
rs/sound/trident.c linux-2.4.19-pre9-mx/drivers/sound/trident.c
--- linux-2.4.19-pre9/drivers/sound/trident.c	Wed May 29 10:47:59 2002
+++ linux-2.4.19-pre9-mx/drivers/sound/trident.c	Fri Jun 21 15:25:25 2002
@@ -36,6 +36,10 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.9e
+ *      June 21 2002 Muli Ben-Yehuda <mulix@actcom.co.il>=20
+ *      use a debug macro instead of #ifdef CONFIG_DEBUG, trim to 80 colum=
ns=20
+ *      per line, use 'do {} while (0)' in statement macros.=20
  *  v0.14.9d
  *  	October 8 2001 Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *	use set_current_state, properly release resources on failure in
@@ -180,7 +184,7 @@
=20
 #include <linux/pm.h>
=20
-#define DRIVER_VERSION "0.14.9d"
+#define DRIVER_VERSION "0.14.9e"
=20
 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC	0x5072696E /* "Prin" */
@@ -198,7 +202,13 @@
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
@@ -288,7 +298,7 @@
 	=09
 	} dmabuf;
=20
-	/* 5.1channels */=09
+	/* 5.1 channels */=09
 	struct trident_state *other_states[4];
 	int multi_channels_adjust_count;
 	unsigned chans_num;
@@ -431,8 +441,11 @@
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
@@ -443,22 +456,29 @@
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
+	        spin_unlock_irqrestore(&state->card->lock, flags);	\
+                        return -EFAULT;					\
+		}							\
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
@@ -483,10 +503,9 @@
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
@@ -498,10 +517,9 @@
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
@@ -517,9 +535,9 @@
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
@@ -537,9 +555,9 @@
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
@@ -550,15 +568,15 @@
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
@@ -569,15 +587,15 @@
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
@@ -594,9 +612,9 @@
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
@@ -612,9 +630,9 @@
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
@@ -862,9 +880,7 @@
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
@@ -884,9 +900,8 @@
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
@@ -928,11 +943,11 @@
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
@@ -1014,11 +1029,11 @@
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
@@ -1051,11 +1066,11 @@
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
+	      "cso =3D 0x%04x\n",
+	      dmabuf->channel->num, cso);
+
 	/* ESO and CSO are in units of Samples, convert to byte offset */
 	cso <<=3D sample_shift[dmabuf->fmt];
=20
@@ -1170,10 +1185,8 @@
 	if (!rawbuf)
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
@@ -1304,12 +1317,10 @@
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
@@ -1657,22 +1668,21 @@
 	/* Update the pointers for all channels we are running. */
 	/* FIXED: read interrupt status only once */
 	irq_status=3Dinl(TRID_REG(card, T4D_AINT_A) );
-#ifdef DEBUG=09
-	printk("cyber_address_interrupt: irq_status 0x%X\n",irq_status);
-#endif
+
+	TRDBG("cyber_address_interrupt: irq_status 0x%X\n",irq_status);
+
 	for (i =3D 0; i < NR_HW_CH; i++) {
 		if (irq_status & ( 1 << (31 - i)) ) {
=20
 			/* clear bit by writing a 1, zeroes are ignored */ 	=09
 			outl( (1 <<(31-i)), TRID_REG(card, T4D_AINT_A));
 	=09
-#ifdef DEBUG=09
-	printk("cyber_interrupt: channel %d\n", 31-i);
-#endif
+			TRDBG("cyber_interrupt: channel %d\n", 31-i);
+
 			if ((state =3D card->states[i]) !=3D NULL) {
 				trident_update_ptr(state);
 			} else {
-				printk("cyber5050: spurious channel irq %d.\n",
+				printk(KERN_WARNING "cyber5050: spurious channel irq %d.\n",
 				       31 - i);
 				trident_stop_voice(card, 31 - i);
 				trident_disable_voice_irq(card, 31 - i);
@@ -1690,9 +1700,7 @@
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
@@ -1730,9 +1738,7 @@
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
@@ -1786,12 +1792,11 @@
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
@@ -1845,9 +1850,8 @@
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
@@ -1915,12 +1919,11 @@
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
@@ -2099,10 +2102,8 @@
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
@@ -2665,10 +2666,8 @@
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
@@ -2690,10 +2689,8 @@
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
diff -Naur --exclude-from /home/mulix/work/dontdiff linux-2.4.19-pre9/drive=
rs/sound/trident.h linux-2.4.19-pre9-mx/drivers/sound/trident.h
--- linux-2.4.19-pre9/drivers/sound/trident.h	Sat Nov 10 00:07:41 2001
+++ linux-2.4.19-pre9-mx/drivers/sound/trident.h	Fri Jun 21 15:04:42 2002
@@ -358,5 +358,16 @@
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

--44EoV7tf2AX9r8hV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9FrNiKRs727/VN8sRAoS2AJ9zZEBuXGJlfwusGdkMVDKDfxCEpwCglGn0
xvIGk7AygiD9WfOtktFmVgw=
=opk8
-----END PGP SIGNATURE-----

--44EoV7tf2AX9r8hV--
