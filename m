Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSF3AyU>; Sat, 29 Jun 2002 20:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSF3AyT>; Sat, 29 Jun 2002 20:54:19 -0400
Received: from mpdr0.chicago.il.ameritech.net ([67.38.100.19]:15865 "EHLO
	mpdr0.chicago.il.ameritech.net") by vger.kernel.org with ESMTP
	id <S314451AbSF3Ax6>; Sat, 29 Jun 2002 20:53:58 -0400
Date: Sat, 29 Jun 2002 19:56:43 -0500
From: Mark J Roberts <mjr@znex.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] emu10k1 audigy support.
Message-ID: <20020630005643.GA202@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Key: 0x025D0C28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The emu10k1 driver in 2.4.19-rc1 still doesn't support my audigy
card. Here's a patch based on the latest emu10k1 cvs. It seems to
work, but I'm not vouching for it beyond that.

It would be nice if the maintainers of this driver could get audigy
support into the official tree. In the meantime maybe this will be
of use to someone.

diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/8010.h linux/drivers/sound/emu10k1/8010.h
--- linux-2.4.19-rc1/drivers/sound/emu10k1/8010.h	Fri Aug 10 23:02:18 2001
+++ linux/drivers/sound/emu10k1/8010.h	Sat Jun 29 19:24:26 2002
@@ -1,7 +1,7 @@
 /*
  **********************************************************************
  *     8010.h
- *     Copyright 1999, 2000 Creative Labs, Inc.
+ *     Copyright 1999-2001 Creative Labs, Inc.
  *
  **********************************************************************
  *
@@ -11,6 +11,8 @@
  *     November 2, 1999     Alan Cox	    Cleaned of 8bit chars, DOS
  *					    line endings
  *     December 8, 1999     Jon Taylor	    Added lots of new register info
+ *     May 16, 2001         Daniel Bertrand Added unofficial DBG register info
+ *     Oct-Nov 2001         D.B.            Added unofficial Audigy registers 
  *
  **********************************************************************
  *
@@ -39,6 +41,14 @@
 
 #include <linux/types.h>
 
+// Driver version:
+#define MAJOR_VER 0
+#define MINOR_VER 19
+#define DRIVER_VERSION "0.19a"
+
+
+// Audigy specify registers are prefixed with 'A_'
+
 /************************************************************************************************/
 /* PCI function 0 registers, address = <val> + PCIBASE0						*/
 /************************************************************************************************/
@@ -57,6 +67,11 @@
 #define IPR			0x08		/* Global interrupt pending register		*/
 						/* Clear pending interrupts by writing a 1 to	*/
 						/* the relevant bits and zero to the other bits	*/
+
+/* The next two interrupts are for the midi port on the Audigy Drive (A_MPU1)			*/
+#define A_IPR_MIDITRANSBUFEMPTY2	0x10000000	/* MIDI UART transmit buffer empty		*/
+#define A_IPR_MIDIRECVBUFEMPTY2	0x08000000	/* MIDI UART receive buffer empty		*/
+
 #define IPR_SAMPLERATETRACKER	0x01000000	/* Sample rate tracker lock status change	*/
 #define IPR_FXDSP		0x00800000	/* Enable FX DSP interrupts			*/
 #define IPR_FORCEINT		0x00400000	/* Force Sound Blaster interrupt		*/
@@ -81,6 +96,10 @@
 						/* IP is written with CL set, the bit in CLIPL	*/
 						/* or CLIPH corresponding to the CIN value 	*/
 						/* written will be cleared.			*/
+#define A_IPR_MIDITRANSBUFEMPTY1	IPR_MIDITRANSBUFEMPTY	/* MIDI UART transmit buffer empty		*/
+#define A_IPR_MIDIRECVBUFEMPTY1	IPR_MIDIRECVBUFEMPTY	/* MIDI UART receive buffer empty		*/
+
+
 
 #define INTE			0x0c		/* Interrupt enable register			*/
 #define INTE_VIRTUALSB_MASK	0xc0000000	/* Virtual Soundblaster I/O port capture	*/
@@ -108,6 +127,11 @@
 						/* behavior and possibly random segfaults and	*/
 						/* lockups if enabled.				*/
 
+/* The next two interrupts are for the midi port on the Audigy Drive (A_MPU1)			*/
+#define A_INTE_MIDITXENABLE2	0x00020000	/* Enable MIDI transmit-buffer-empty interrupts	*/
+#define A_INTE_MIDIRXENABLE2	0x00010000	/* Enable MIDI receive-buffer-empty interrupts	*/
+
+
 #define INTE_SAMPLERATETRACKER	0x00002000	/* Enable sample rate tracker interrupts	*/
 						/* NOTE: This bit must always be enabled       	*/
 #define INTE_FXDSPENABLE	0x00001000	/* Enable FX DSP interrupts			*/
@@ -124,6 +148,10 @@
 #define INTE_MIDITXENABLE	0x00000002	/* Enable MIDI transmit-buffer-empty interrupts	*/
 #define INTE_MIDIRXENABLE	0x00000001	/* Enable MIDI receive-buffer-empty interrupts	*/
 
+/* The next two interrupts are for the midi port on the Audigy (A_MPU2)	*/
+#define A_INTE_MIDITXENABLE1  	INTE_MIDITXENABLE
+#define A_INTE_MIDIRXENABLE1	INTE_MIDIRXENABLE
+
 #define WC			0x10		/* Wall Clock register				*/
 #define WC_SAMPLECOUNTER_MASK	0x03FFFFC0	/* Sample periods elapsed since reset		*/
 #define WC_SAMPLECOUNTER	0x14060010
@@ -186,6 +214,8 @@
 						/* Should be set to 1 when the EMU10K1 is	*/
 						/* completely initialized.			*/
 
+//For Audigy, MPU port move to 0x70-0x74 ptr register
+
 #define MUDATA			0x18		/* MPU401 data register (8 bits)       		*/
 
 #define MUCMD			0x19		/* MPU401 command register (8 bits)    		*/
@@ -197,6 +227,10 @@
 #define MUSTAT_IRDYN		0x80		/* 0 = MIDI data or command ACK			*/
 #define MUSTAT_ORDYN		0x40		/* 0 = MUDATA can accept a command or data	*/
 
+#define A_IOCFG			0x18		/* GPIO on Audigy card (16bits)			*/
+#define A_GPINPUT_MASK		0xff00
+#define A_GPOUTPUT_MASK		0x00ff
+
 #define TIMER			0x1a		/* Timer terminal count register		*/
 						/* NOTE: After the rate is changed, a maximum	*/
 						/* of 1024 sample periods should be allowed	*/
@@ -386,6 +420,8 @@
 #define TREMFRQ 		0x1c		/* Tremolo amount and modulation LFO frequency register	*/
 #define TREMFRQ_DEPTH		0x0000ff00	/* Tremolo depth					*/
 						/* Signed 2's complement, with +/- 12dB extremes	*/
+#define TREMFRQ_FREQUENCY	0x000000ff	/* Tremolo LFO frequency				*/
+						/* ??Hz steps, maximum of ?? Hz.			*/
 
 #define FM2FRQ2 		0x1d		/* Vibrato amount and vibrato LFO frequency register	*/
 #define FM2FRQ2_DEPTH		0x0000ff00	/* Vibrato LFO vibrato depth				*/
@@ -426,7 +462,12 @@
 #define ADCCR_LCHANENABLE	0x00000008	/* Enables left channel for writing to the host		*/
 						/* NOTE: To guarantee phase coherency, both channels	*/
 						/* must be disabled prior to enabling both channels.	*/
+#define A_ADCCR_RCHANENABLE	0x00000020
+#define A_ADCCR_LCHANENABLE	0x00000010
+
+#define A_ADCCR_SAMPLERATE_MASK 0x0000000F      /* Audigy sample rate convertor output rate		*/
 #define ADCCR_SAMPLERATE_MASK	0x00000007	/* Sample rate convertor output rate			*/
+
 #define ADCCR_SAMPLERATE_48	0x00000000	/* 48kHz sample rate					*/
 #define ADCCR_SAMPLERATE_44	0x00000001	/* 44.1kHz sample rate					*/
 #define ADCCR_SAMPLERATE_32	0x00000002	/* 32kHz sample rate					*/
@@ -436,10 +477,16 @@
 #define ADCCR_SAMPLERATE_11	0x00000006	/* 11.025kHz sample rate				*/
 #define ADCCR_SAMPLERATE_8	0x00000007	/* 8kHz sample rate					*/
 
+#define A_ADCCR_SAMPLERATE_12	0x00000006	/* 12kHz sample rate					*/
+#define A_ADCCR_SAMPLERATE_11	0x00000007	/* 11.025kHz sample rate				*/
+#define A_ADCCR_SAMPLERATE_8	0x00000008	/* 8kHz sample rate					*/
+
 #define FXWC			0x43		/* FX output write channels register			*/
 						/* When set, each bit enables the writing of the	*/
-						/* corresponding FX output channel into host memory	*/
-
+						/* corresponding FX output channel (internal registers  */
+						/* 0x20-0x3f) into host memory. This mode of recording	*/
+						/* is 16bit, 48KHz only. All 32	channels can be enabled */
+						/* simultaneously.					*/
 #define TCBS			0x44		/* Tank cache buffer size register			*/
 #define TCBS_MASK		0x00000007	/* Tank cache buffer size field				*/
 #define TCBS_BUFFSIZE_16K	0x00000000
@@ -519,6 +566,13 @@
 
 #define REG53			0x53		/* DO NOT PROGRAM THIS REGISTER!!! MAY DESTROY CHIP */
 
+#define A_DBG			 0x53
+#define A_DBG_SINGLE_STEP	 0x00020000	/* Set to zero to start dsp */
+#define A_DBG_ZC		 0x40000000	/* zero tram counter */
+#define A_DBG_STEP_ADDR		 0x000003ff
+#define A_DBG_SATURATION_OCCURED 0x20000000
+#define A_DBG_SATURATION_ADDR	 0x0ffc0000
+
 #define SPCS0			0x54		/* SPDIF output Channel Status 0 register	*/
 
 #define SPCS1			0x55		/* SPDIF output Channel Status 1 register	*/
@@ -582,10 +636,19 @@
 #define SRCS_RATELOCKED		0x01000000	/* Sample rate locked				*/
 #define SRCS_ESTSAMPLERATE	0x0007ffff	/* Do not modify this field.			*/
 
+
+/* Note that these values can vary +/- by a small amount                                        */
+#define SRCS_SPDIFRATE_44	0x0003acd9
+#define SRCS_SPDIFRATE_48	0x00040000
+#define SRCS_SPDIFRATE_96	0x00080000
+
 #define MICIDX                  0x63            /* Microphone recording buffer index register   */
 #define MICIDX_MASK             0x0000ffff      /* 16-bit value                                 */
 #define MICIDX_IDX		0x10000063
 
+#define A_ADCIDX		0x63
+#define A_ADCIDX_IDX		0x10000063
+
 #define ADCIDX			0x64		/* ADC recording buffer index register		*/
 #define ADCIDX_MASK		0x0000ffff	/* 16 bit index field				*/
 #define ADCIDX_IDX		0x10000064
@@ -594,9 +657,50 @@
 #define FXIDX_MASK		0x0000ffff	/* 16-bit value					*/
 #define FXIDX_IDX		0x10000065
 
+/* This is the MPU port on the card (via the game port)						*/
+#define A_MUDATA1		0x70
+#define A_MUCMD1		0x71
+#define A_MUSTAT1		A_MUCMD1
+
+/* This is the MPU port on the Audigy Drive 							*/
+#define A_MUDATA2		0x72
+#define A_MUCMD2		0x73
+#define A_MUSTAT2		A_MUCMD2	
+
+/* The next two are the Audigy equivalent of FXWC						*/
+/* the Audigy can record any output (16bit, 48kHz, up to 64 channel simultaneously) 		*/
+/* Each bit selects a channel for recording */
+#define A_FXWC1			0x74            /* Selects 0x7f-0x60 for FX recording           */
+#define A_FXWC2			0x75		/* Selects 0x9f-0x80 for FX recording           */
+
+#define A_SPDIF_SAMPLERATE	0x76		/* Set the sample rate of SPDIF output		*/
+#define A_SPDIF_48000		0x00000080
+#define A_SPDIF_44100		0x00000000
+#define A_SPDIF_96000		0x00000040
+
+#define A_FXRT2			0x7c
+#define A_FXRT_CHANNELE		0x0000003f	/* Effects send bus number for channel's effects send E	*/
+#define A_FXRT_CHANNELF		0x00003f00	/* Effects send bus number for channel's effects send F	*/
+#define A_FXRT_CHANNELG		0x003f0000	/* Effects send bus number for channel's effects send G	*/
+#define A_FXRT_CHANNELH		0x3f000000	/* Effects send bus number for channel's effects send H	*/
+
+#define A_SENDAMOUNTS		0x7d
+#define A_FXSENDAMOUNT_E_MASK	0xff000000
+#define A_FXSENDAMOUNT_F_MASK	0x00ff0000
+#define A_FXSENDAMOUNT_G_MASK	0x0000ff00
+#define A_FXSENDAMOUNT_H_MASK	0x000000ff
+
+/* The send amounts for this one are the same as used with the emu10k1 */
+#define A_FXRT1			0x7e
+#define A_FXRT_CHANNELA		0x0000003f
+#define A_FXRT_CHANNELB		0x00003f00
+#define A_FXRT_CHANNELC		0x003f0000
+#define A_FXRT_CHANNELD		0x3f000000
+
+
 /* Each FX general purpose register is 32 bits in length, all bits are used			*/
 #define FXGPREGBASE		0x100		/* FX general purpose registers base       	*/
-
+#define A_FXGPREGBASE		0x400		/* Audigy GPRs, 0x400 to 0x5ff			*/
 /* Tank audio data is logarithmically compressed down to 16 bits before writing to TRAM and is	*/
 /* decompressed back to 20 bits on a read.  There are a total of 160 locations, the last 32	*/
 /* locations are for external TRAM. 								*/
@@ -620,5 +724,15 @@
 #define HIWORD_OPCODE_MASK	0x00f00000	/* Instruction opcode				*/
 #define HIWORD_RESULT_MASK	0x000ffc00	/* Instruction result				*/
 #define HIWORD_OPA_MASK		0x000003ff	/* Instruction operand A			*/
+
+
+/* Audigy Soundcard have a different instruction format */
+#define AUDIGY_CODEBASE		0x600
+#define A_LOWORD_OPY_MASK	0x000007ff		
+#define A_LOWORD_OPX_MASK	0x007ff000
+#define A_HIWORD_OPCODE_MASK	0x0f000000
+#define A_HIWORD_RESULT_MASK	0x007ff000
+#define A_HIWORD_OPA_MASK	0x000007ff
+
 
 #endif /* _8010_H */
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/Makefile linux/drivers/sound/emu10k1/Makefile
--- linux-2.4.19-rc1/drivers/sound/emu10k1/Makefile	Sun Aug 12 12:25:31 2001
+++ linux/drivers/sound/emu10k1/Makefile	Sat Jun 29 17:57:41 2002
@@ -6,7 +6,9 @@
 
 obj-y :=     audio.o cardmi.o cardmo.o cardwi.o cardwo.o ecard.o \
              efxmgr.o emuadxmg.o hwaccess.o irqmgr.o main.o midi.o \
-             mixer.o passthrough.o recmgr.o timer.o voicemgr.o
+             mixer.o passthrough.o recmgr.o timer.o voicemgr.o \
+             joystick.o
+
 obj-m := $(O_TARGET)
 
 ifdef DEBUG
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/audio.c linux/drivers/sound/emu10k1/audio.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/audio.c	Sat Jun 29 19:39:04 2002
+++ linux/drivers/sound/emu10k1/audio.c	Sat Jun 29 17:33:40 2002
@@ -50,6 +50,7 @@
 #include "audio.h"
 #include "8010.h"
 
+
 static void calculate_ofrag(struct woinst *);
 static void calculate_ifrag(struct wiinst *);
 
@@ -144,6 +145,7 @@
 static ssize_t emu10k1_audio_write(struct file *file, const char *buffer, size_t count, loff_t * ppos)
 {
 	struct emu10k1_wavedevice *wave_dev = (struct emu10k1_wavedevice *) file->private_data;
+
 	struct woinst *woinst = wave_dev->woinst;
 	ssize_t ret;
 	unsigned long flags;
@@ -162,8 +164,8 @@
 		spin_unlock_irqrestore(&woinst->lock, flags);
 		return -ENXIO;
 	}
-
-	if (woinst->format.passthrough) {
+	// This is for emu10k1 revs less than 7, we need to go through tram
+	if (woinst->format.passthrough == 1 ) {
 		int r;
 		
 		woinst->buffer.ossfragshift = PT_BLOCKSIZE_LOG2;
@@ -354,8 +356,9 @@
 
 	case SNDCTL_DSP_GETCAPS:
 		DPF(2, "SNDCTL_DSP_GETCAPS:\n");
-		return put_user(DSP_CAP_DUPLEX | DSP_CAP_REALTIME | DSP_CAP_TRIGGER | DSP_CAP_MMAP | DSP_CAP_COPROC, (int *) arg);
-
+		return put_user(DSP_CAP_DUPLEX | DSP_CAP_REALTIME |
+				DSP_CAP_TRIGGER | DSP_CAP_MMAP |
+				DSP_CAP_COPROC| DSP_CAP_MULTI, (int *) arg);
 	case SNDCTL_DSP_SPEED:
 		DPF(2, "SNDCTL_DSP_SPEED:\n");
 
@@ -532,8 +535,8 @@
 		else if (file->f_mode & FMODE_WRITE) {
 			val = AFMT_S16_LE | AFMT_U8;
 			if (emu10k1_find_control_gpr(&wave_dev->card->mgr,
-			    			     wave_dev->card->pt.patch_name, 
-			    			     wave_dev->card->pt.enable_gpr_name) >= 0)
+						     wave_dev->card->pt.patch_name, 
+						     wave_dev->card->pt.enable_gpr_name) >= 0)
 				val |= AFMT_AC3;
 		}
 		return put_user(val, (int *) arg);
@@ -815,9 +818,9 @@
 			spin_lock_irqsave(&woinst->lock, flags);
 
 			if (woinst->state & WAVE_STATE_OPEN || 
-			    (woinst->format.passthrough && wave_dev->card->pt.state)) {
+			    ((woinst->format.passthrough == 1) && wave_dev->card->pt.state)) {
 				int num_fragments;
-				if (woinst->format.passthrough) {
+				if (woinst->format.passthrough==1) {
 					emu10k1_pt_waveout_update(wave_dev);
 					cinfo.bytes = woinst->total_played;
 				} else {
@@ -903,7 +906,7 @@
 
 		if (file->f_mode & FMODE_WRITE) {
 			/* digital pass-through fragment count and size are fixed values */
-			if (woinst->state & WAVE_STATE_OPEN || woinst->format.passthrough)
+			if (woinst->state & WAVE_STATE_OPEN || (woinst->format.passthrough==1))
 				return -EINVAL;	/* too late to change */
 
 			woinst->buffer.ossfragshift = val & 0xffff;
@@ -940,19 +943,35 @@
 				kfree (buf);
 				return -EINVAL;
 			}
+
+			if (buf->command == CMD_WRITE) {
+				
 #ifdef DBGEMU
-			if ( (buf->offs < 0) || (buf->offs + buf->len > 0x800) || (buf->len > 1000)) {
+				if ((buf->offs < 0) || (buf->offs + buf->len > 0xe00) || (buf->len > 1000)) {
 #else
-			if ( ((buf->offs < 0x100 ) || (buf->offs + buf->len > 0x800) || (buf->len > 1000))
-			     && !( ( buf->offs == DBG) && (buf->len ==1) )){
-#endif	
-				kfree(buf);
-				return -EINVAL;
+				if (((buf->offs < 0x100) || (buf->offs + buf->len > (wave_dev->card->is_audigy ? 0xe00 : 0x800)) || (buf->len > 1000)
+				) && !(
+					//any register allowed raw access to users goes here:
+					(buf->offs == DBG ||
+					  buf->offs == A_DBG)
+					&& (buf->len == 1))) {
+#endif		
+					kfree(buf);
+					return -EINVAL;
+				}
+			} else {
+				if ((buf->offs < 0) || (buf->offs + buf->len > 0xe00) || (buf->len > 1000)) {
+					kfree(buf);
+					return -EINVAL;
+				}
 			}
-
+			
+				
+			if (((unsigned)buf->flags) > 0x3f)
+				buf->flags=0;
 			if (buf->command == CMD_READ) {
 				for (i = 0; i < buf->len; i++)
-					((u32 *) buf->data)[i] = sblive_readptr(wave_dev->card, buf->offs + i, 0);
+					((u32 *) buf->data)[i] = sblive_readptr(wave_dev->card, buf->offs + i, buf->flags);
 
 				if (copy_to_user((copr_buffer *) arg, buf, sizeof(copr_buffer))) {
 					kfree(buf);
@@ -960,7 +979,7 @@
 				}
 			} else {
 				for (i = 0; i < buf->len; i++)
-					sblive_writeptr(wave_dev->card, buf->offs + i, 0, ((u32 *) buf->data)[i]);
+					sblive_writeptr(wave_dev->card, buf->offs + i, buf->flags, ((u32 *) buf->data)[i]);
 			}
 
 			kfree (buf);
@@ -1244,8 +1263,9 @@
 		struct woinst *woinst = wave_dev->woinst;
 
 		spin_lock_irqsave(&woinst->lock, flags);
-
-		if (woinst->format.passthrough && card->pt.state != PT_STATE_INACTIVE) {
+		if(woinst->format.passthrough==2)
+			card->pt.state=PT_STATE_PLAYING;
+		if (woinst->format.passthrough && card->pt.state != PT_STATE_INACTIVE){
 			spin_lock(&card->pt.lock);
                         emu10k1_pt_stop(card);
 			spin_unlock(&card->pt.lock);
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/cardmi.c linux/drivers/sound/emu10k1/cardmi.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/cardmi.c	Fri Aug 10 23:02:18 2001
+++ linux/drivers/sound/emu10k1/cardmi.c	Sat Jun 29 17:33:41 2002
@@ -113,7 +113,7 @@
 	}
 
 	/* Disable RX interrupt */
-	emu10k1_irq_disable(card, INTE_MIDIRXENABLE);
+	emu10k1_irq_disable(card, card->is_audigy ? A_INTE_MIDIRXENABLE : INTE_MIDIRXENABLE);
 
 	emu10k1_mpu_release(card);
 
@@ -189,7 +189,7 @@
 		card_mpuin->qhead = 0;
 		card_mpuin->qtail = 0;
 
-		emu10k1_irq_enable(card, INTE_MIDIRXENABLE);
+		emu10k1_irq_enable(card, card->is_audigy ? A_INTE_MIDIRXENABLE : INTE_MIDIRXENABLE);
 	}
 
 	return 0;
@@ -207,7 +207,7 @@
 
 	DPF(2, "emu10k1_mpuin_stop()\n");
 
-	emu10k1_irq_disable(card, INTE_MIDIRXENABLE);
+	emu10k1_irq_disable(card, card->is_audigy ? A_INTE_MIDIRXENABLE : INTE_MIDIRXENABLE);
 
 	card_mpuin->status &= ~FLAGS_MIDM_STARTED;	/* clear */
 
@@ -246,7 +246,7 @@
 
 	DPF(2, "emu10k1_mpuin_reset()\n");
 
-	emu10k1_irq_disable(card, INTE_MIDIRXENABLE);
+	emu10k1_irq_disable(card, card->is_audigy ? A_INTE_MIDIRXENABLE : INTE_MIDIRXENABLE);
 
 	while (card_mpuin->firstmidiq) {
 		midiq = card_mpuin->firstmidiq;
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/cardmo.c linux/drivers/sound/emu10k1/cardmo.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/cardmo.c	Fri Aug 10 23:02:18 2001
+++ linux/drivers/sound/emu10k1/cardmo.c	Sat Jun 29 17:33:41 2002
@@ -72,7 +72,7 @@
 
 	DPF(2, "emu10k1_mpuout_close()\n");
 
-	emu10k1_irq_disable(card, INTE_MIDITXENABLE);
+	emu10k1_irq_disable(card, card->is_audigy ? A_INTE_MIDITXENABLE : INTE_MIDITXENABLE);
 
 	spin_lock_irqsave(&card_mpuout->lock, flags);
 
@@ -142,7 +142,7 @@
 
 	card_mpuout->intr = 0;
 
-	emu10k1_irq_enable(card, INTE_MIDITXENABLE);
+	emu10k1_irq_enable(card, card->is_audigy ? A_INTE_MIDITXENABLE : INTE_MIDITXENABLE);
 
 	spin_unlock_irqrestore(&card_mpuout->lock, flags);
 
@@ -206,7 +206,7 @@
 
 	if ((card_mpuout->firstmidiq != NULL) || cByteSent) {
 		card_mpuout->intr = 0;
-		emu10k1_irq_enable(card, INTE_MIDITXENABLE);
+		emu10k1_irq_enable(card, card->is_audigy ? A_INTE_MIDITXENABLE : INTE_MIDITXENABLE);
 	}
 
 	spin_unlock_irqrestore(&card_mpuout->lock, flags);
@@ -221,7 +221,7 @@
 	DPF(4, "emu10k1_mpuout_irqhandler\n");
 
 	card_mpuout->intr = 1;
-	emu10k1_irq_disable(card, INTE_MIDITXENABLE);
+	emu10k1_irq_disable(card, card->is_audigy ? A_INTE_MIDITXENABLE : INTE_MIDITXENABLE);
 
 	tasklet_hi_schedule(&card_mpuout->tasklet);
 
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/cardwo.c linux/drivers/sound/emu10k1/cardwo.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/cardwo.c	Mon Feb 25 13:38:06 2002
+++ linux/drivers/sound/emu10k1/cardwo.c	Sat Jun 29 17:33:41 2002
@@ -85,25 +85,36 @@
 		break;
 	}	
 	if (do_passthrough) {
-		i = emu10k1_find_control_gpr(&card->mgr, card->pt.patch_name, card->pt.intr_gpr_name);
-		j = emu10k1_find_control_gpr(&card->mgr, card->pt.patch_name, card->pt.enable_gpr_name);
 		/* currently only one waveout instance may use pass-through */
-		if (i < 0 || j < 0 || woinst->state != WAVE_STATE_CLOSED || 
+		if (woinst->state != WAVE_STATE_CLOSED || 
 		    card->pt.state != PT_STATE_INACTIVE ||
-		    (wave_fmt->samplingrate != 48000 && !is_ac3) ||
 		    (wave_fmt->samplingrate != 48000 && !is_ac3)) {
 			DPF(2, "unable to set pass-through mode\n");
-		} else {
-			wave_fmt->samplingrate = 48000;
-			wave_fmt->channels = 2;
-			wave_fmt->passthrough = 1;
-			card->pt.intr_gpr = i;
-			card->pt.enable_gpr = j;
-			card->pt.state = PT_STATE_INACTIVE;
-			card->pt.pos_gpr = emu10k1_find_control_gpr(&card->mgr, card->pt.patch_name, card->pt.pos_gpr_name);
-			DPD(2, "is_ac3 is %d\n", is_ac3);
-			card->pt.ac3data = is_ac3;
-	                wave_fmt->bitsperchannel = 16;
+		} else if (USE_PT_METHOD1) {
+			i = emu10k1_find_control_gpr(&card->mgr, card->pt.patch_name, card->pt.intr_gpr_name);
+			j = emu10k1_find_control_gpr(&card->mgr, card->pt.patch_name, card->pt.enable_gpr_name);
+			if (i < 0 || j < 0)
+				DPF(2, "unable to set pass-through mode\n");
+			else {
+				wave_fmt->samplingrate = 48000;
+				wave_fmt->channels = 2;
+				card->pt.pos_gpr = emu10k1_find_control_gpr(&card->mgr, card->pt.patch_name,
+									    card->pt.pos_gpr_name);
+				wave_fmt->passthrough = 1;
+				card->pt.intr_gpr = i;
+				card->pt.enable_gpr = j;
+				card->pt.state = PT_STATE_INACTIVE;
+			
+				DPD(2, "is_ac3 is %d\n", is_ac3);
+				card->pt.ac3data = is_ac3;
+				wave_fmt->bitsperchannel = 16;
+			}
+		}else{
+			DPF(2, "Using Passthrough Method 2\n");
+			card->pt.enable_gpr = emu10k1_find_control_gpr(&card->mgr, card->pt.patch_name,
+								       card->pt.enable_gpr_name);
+			wave_fmt->passthrough = 2;
+			wave_fmt->bitsperchannel = 16;
 		}
 	}
 
@@ -149,33 +160,37 @@
 	voice->endloop = voice->startloop + woinst->buffer.size / woinst->format.bytespervoicesample;
 	voice->start = voice->startloop;
 
-	if (voice->flags & VOICE_FLAGS_STEREO) {
-		voice->params[0].send_a = card->waveout.send_a[1];
-		voice->params[0].send_b = card->waveout.send_b[1];
-		voice->params[0].send_c = card->waveout.send_c[1];
-		voice->params[0].send_d = card->waveout.send_d[1];
-
-		if (woinst->device)
-			voice->params[0].send_routing = 0x7654;
-		else
-			voice->params[0].send_routing = card->waveout.send_routing[1];
-
-		voice->params[0].volume_target = 0xffff;
-		voice->params[0].initial_fc = 0xff;
-		voice->params[0].initial_attn = 0x00;
-		voice->params[0].byampl_env_sustain = 0x7f;
-		voice->params[0].byampl_env_decay = 0x7f;
-
-		voice->params[1].send_a = card->waveout.send_a[2];
-		voice->params[1].send_b = card->waveout.send_b[2];
-		voice->params[1].send_c = card->waveout.send_c[2];
-		voice->params[1].send_d = card->waveout.send_d[2];
-
-		if (woinst->device)
-			voice->params[1].send_routing = 0x7654;
-		else
-			voice->params[1].send_routing = card->waveout.send_routing[2];
+	
+	voice->params[0].volume_target = 0xffff;
+	voice->params[0].initial_fc = 0xff;
+	voice->params[0].initial_attn = 0x00;
+	voice->params[0].byampl_env_sustain = 0x7f;
+	voice->params[0].byampl_env_decay = 0x7f;
 
+	
+	if (voice->flags & VOICE_FLAGS_STEREO) {
+		if (woinst->format.passthrough == 2) {
+			voice->params[0].send_routing  = voice->params[1].send_routing  = card->waveout.send_routing[ROUTE_PT];
+			voice->params[0].send_routing2 = voice->params[1].send_routing2 = card->waveout.send_routing2[ROUTE_PT];
+			voice->params[0].send_dcba = 0xff;
+			voice->params[1].send_dcba = 0xff00;
+			voice->params[0].send_hgfe = voice->params[1].send_hgfe=0;
+		} else {
+			voice->params[0].send_dcba = card->waveout.send_dcba[SEND_LEFT];
+			voice->params[0].send_hgfe = card->waveout.send_hgfe[SEND_LEFT];
+			voice->params[1].send_dcba = card->waveout.send_dcba[SEND_RIGHT];
+			voice->params[1].send_hgfe = card->waveout.send_hgfe[SEND_RIGHT];
+
+			if (woinst->device) {
+				// /dev/dps1
+				voice->params[0].send_routing  = voice->params[1].send_routing  = card->waveout.send_routing[ROUTE_PCM1];
+				voice->params[0].send_routing2 = voice->params[1].send_routing2 = card->waveout.send_routing2[ROUTE_PCM1];
+			} else {
+				voice->params[0].send_routing  = voice->params[1].send_routing  = card->waveout.send_routing[ROUTE_PCM];
+				voice->params[0].send_routing2 = voice->params[1].send_routing2 = card->waveout.send_routing2[ROUTE_PCM];
+			}
+		}
+		
 		voice->params[1].volume_target = 0xffff;
 		voice->params[1].initial_fc = 0xff;
 		voice->params[1].initial_attn = 0x00;
@@ -183,30 +198,28 @@
 		voice->params[1].byampl_env_decay = 0x7f;
 	} else {
 		if (woinst->num_voices > 1) {
-			voice->params[0].send_a = 0xff;
-			voice->params[0].send_b = 0;
-			voice->params[0].send_c = 0;
-			voice->params[0].send_d = 0;
-
-			voice->params[0].send_routing =
-			 0xfff0 + card->mchannel_fx + voicenum;
+			// Multichannel pcm
+			voice->params[0].send_dcba=0xff;
+			voice->params[0].send_hgfe=0;
+			if (card->is_audigy) {
+				voice->params[0].send_routing = 0x3f3f3f00 + card->mchannel_fx + voicenum;
+				voice->params[0].send_routing2 = 0x3f3f3f3f;
+			} else {
+				voice->params[0].send_routing = 0xfff0 + card->mchannel_fx + voicenum;
+			}
+			
 		} else {
-			voice->params[0].send_a = card->waveout.send_a[0];
-			voice->params[0].send_b = card->waveout.send_b[0];
-			voice->params[0].send_c = card->waveout.send_c[0];
-			voice->params[0].send_d = card->waveout.send_d[0];
-
-			if (woinst->device)
-				voice->params[0].send_routing = 0x7654;
-			else
-				voice->params[0].send_routing = card->waveout.send_routing[0];
-		}	
-
-		voice->params[0].volume_target = 0xffff;
-		voice->params[0].initial_fc = 0xff;
-		voice->params[0].initial_attn = 0x00;
-		voice->params[0].byampl_env_sustain = 0x7f;
-		voice->params[0].byampl_env_decay = 0x7f;
+			voice->params[0].send_dcba = card->waveout.send_dcba[SEND_MONO];
+			voice->params[0].send_hgfe = card->waveout.send_hgfe[SEND_MONO];
+
+			if (woinst->device) {
+				voice->params[0].send_routing = card->waveout.send_routing[ROUTE_PCM1];
+				voice->params[0].send_routing2 = card->waveout.send_routing2[ROUTE_PCM1];
+			} else {
+				voice->params[0].send_routing = card->waveout.send_routing[ROUTE_PCM];
+				voice->params[0].send_routing2 = card->waveout.send_routing2[ROUTE_PCM];
+			}
+		}
 	}
 
 	DPD(2, "voice: startloop=%#x, endloop=%#x\n", voice->startloop, voice->endloop);
@@ -280,8 +293,15 @@
 {
 	struct emu10k1_card *card = wave_dev->card;
 	struct woinst *woinst = wave_dev->woinst;
+	struct pt_data *pt = &card->pt;
 
 	DPF(2, "emu10k1_waveout_start()\n");
+
+	if (woinst->format.passthrough == 2) {
+		emu10k1_pt_setup(wave_dev);
+		sblive_writeptr(card, (card->is_audigy ? A_GPR_BASE : GPR_BASE) + pt->enable_gpr, 0, 1);
+		pt->state = PT_STATE_PLAYING;
+	}
 
 	/* Actual start */
 	emu10k1_voices_start(woinst->voice, woinst->num_voices, woinst->total_played);
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/efxmgr.c linux/drivers/sound/emu10k1/efxmgr.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/efxmgr.c	Sat Jun 29 19:39:04 2002
+++ linux/drivers/sound/emu10k1/efxmgr.c	Sat Jun 29 17:33:41 2002
@@ -80,15 +80,20 @@
 	if (addr < 0 || addr >= NUM_GPRS)
 		return;
 
-	if (flag)
-		val += sblive_readptr(card, GPR_BASE + addr, 0);
-
-	if (val > mgr->gpr[addr].max)
-		val = mgr->gpr[addr].max;
-	else if (val < mgr->gpr[addr].min)
-		val = mgr->gpr[addr].min;
-
-	sblive_writeptr(card, GPR_BASE + addr, 0, val);
+	//fixme: once patch manager is up, remember to fix this for the audigy
+	if (card->is_audigy) {
+		sblive_writeptr(card, A_GPR_BASE + addr, 0, val);
+	} else {
+		if (flag)
+			val += sblive_readptr(card, GPR_BASE + addr, 0);
+		if (val > mgr->gpr[addr].max)
+			val = mgr->gpr[addr].max;
+		else if (val < mgr->gpr[addr].min)
+			val = mgr->gpr[addr].min;
+		sblive_writeptr(card, GPR_BASE + addr, 0, val);
+	}
+	
+	
 }
 
 //TODO: make this configurable:
@@ -171,6 +176,7 @@
 {
 	struct patch_manager *mgr = &card->mgr;
 	unsigned long flags;
+
 
 	static const s32 log2lin[4] ={           //  attenuation (dB)
 		0x7fffffff,                      //       0.0         
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/efxmgr.h linux/drivers/sound/emu10k1/efxmgr.h
--- linux-2.4.19-rc1/drivers/sound/emu10k1/efxmgr.h	Sat Jun 29 19:39:04 2002
+++ linux/drivers/sound/emu10k1/efxmgr.h	Sat Jun 29 17:33:41 2002
@@ -32,16 +32,30 @@
 #ifndef _EFXMGR_H
 #define _EFXMGR_H
 
-#define WRITE_EFX(a, b, c) sblive_writeptr((a), MICROCODEBASE + (b), 0, (c))
+struct emu_efx_info_t{
+	int opcode_shift;
+	int high_operand_shift;
+	int instruction_start;
+	int gpr_base;
+	int output_base;
+};
+
+
+#define WRITE_EFX(a, b, c) sblive_writeptr((a), emu_efx_info[card->is_audigy].instruction_start + (b), 0, (c))
 
 #define OP(op, z, w, x, y) \
-	do { WRITE_EFX(card, (pc) * 2, ((x) << 10) | (y)); \
-	WRITE_EFX(card, (pc) * 2 + 1, ((op) << 20) | ((z) << 10) | (w)); \
+	do { WRITE_EFX(card, (pc) * 2, ((x) << emu_efx_info[card->is_audigy].high_operand_shift) | (y)); \
+	WRITE_EFX(card, (pc) * 2 + 1, ((op) << emu_efx_info[card->is_audigy].opcode_shift ) | ((z) << emu_efx_info[card->is_audigy].high_operand_shift) | (w)); \
 	++pc; } while (0)
 
 #define NUM_INPUTS 0x20
 #define NUM_OUTPUTS 0x20
 #define NUM_GPRS 0x100
+
+#define A_NUM_INPUTS 0x60
+#define A_NUM_OUTPUTS 0x60  //fixme: this may or may not be true
+#define A_NUM_GPRS 0x200
+
 #define GPR_NAME_SIZE   32
 #define PATCH_NAME_SIZE 32
 
@@ -59,15 +73,15 @@
 struct dsp_patch {
 	char name[PATCH_NAME_SIZE];
 	u8 id;
-	unsigned long input;	/* bitmap of the lines used as inputs */
-	unsigned long output;	/* bitmap of the lines used as outputs */
+	unsigned long input;                      /* bitmap of the lines used as inputs */
+	unsigned long output;                     /* bitmap of the lines used as outputs */
 	u16 code_start;
 	u16 code_size;
 
-	unsigned long gpr_used[NUM_GPRS / (sizeof(unsigned long) * 8) + 1];	/* bitmap of used gprs */
+	unsigned long gpr_used[NUM_GPRS / (sizeof(unsigned long) * 8) + 1];    /* bitmap of used gprs */
 	unsigned long gpr_input[NUM_GPRS / (sizeof(unsigned long) * 8) + 1];
-	u8 traml_istart;	/* starting address of the internal tram lines used */
-	u8 traml_isize;		/* number of internal tram lines used */
+	u8 traml_istart;  /* starting address of the internal tram lines used */
+	u8 traml_isize;   /* number of internal tram lines used */
 
 	u8 traml_estart;
 	u8 traml_esize;
@@ -79,10 +93,10 @@
 };
 
 struct dsp_gpr {
-	u8 type;			/* gpr type, STATIC, DYNAMIC, INPUT, OUTPUT, CONTROL */
-	char name[GPR_NAME_SIZE];	/* gpr value, only valid for control gprs */
-	s32 min, max;			/* value range for this gpr, only valid for control gprs */
-	u8 line;			/* which input/output line is the gpr attached, only valid for input/output gprs */
+	u8 type;                      /* gpr type, STATIC, DYNAMIC, INPUT, OUTPUT, CONTROL */
+	char name[GPR_NAME_SIZE];       /* gpr value, only valid for control gprs */
+	s32 min, max;         /* value range for this gpr, only valid for control gprs */
+	u8 line;                    /* which input/output line is the gpr attached, only valid for input/output gprs */
 	u8 usage;
 };
 
@@ -97,6 +111,9 @@
 
 #define GPR_BASE 0x100
 #define OUTPUT_BASE 0x20
+
+#define A_GPR_BASE 0x400
+#define A_OUTPUT_BASE 0x60
 
 #define MAX_PATCHES_PAGES 32
 
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/hwaccess.c linux/drivers/sound/emu10k1/hwaccess.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/hwaccess.c	Fri Aug 10 23:02:18 2001
+++ linux/drivers/sound/emu10k1/hwaccess.c	Sat Jun 29 17:33:41 2002
@@ -159,6 +159,20 @@
 
 	return;
 }
+void emu10k1_writefn0_2(struct emu10k1_card *card, u32 reg, u32 data, int size)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&card->lock, flags);
+
+	if(size==32)
+		outl(data, card->iobase + (reg&0x1F));
+	else if(size==16)
+		outw(data, card->iobase + (reg&0x1F));
+	else
+		outw(data, card->iobase + (reg&0x1F));
+	spin_unlock_irqrestore(&card->lock, flags);
+	return;
+}
 
 u32 emu10k1_readfn0(struct emu10k1_card * card, u32 reg)
 {
@@ -191,12 +205,13 @@
 * write/read Emu10k1 pointer-offset register set, accessed through      *
 *  the PTR and DATA registers                                           *
 *************************************************************************/
+#define A_PTR_ADDRESS_MASK 0x0fff0000
 void sblive_writeptr(struct emu10k1_card *card, u32 reg, u32 channel, u32 data)
 {
 	u32 regptr;
 	unsigned long flags;
 
-	regptr = ((reg << 16) & PTR_ADDRESS_MASK) | (channel & PTR_CHANNELNUM_MASK);
+	regptr = ((reg << 16) & A_PTR_ADDRESS_MASK) | (channel & PTR_CHANNELNUM_MASK);
 
 	if (reg & 0xff000000) {
 		u32 mask;
@@ -233,7 +248,7 @@
 	spin_lock_irqsave(&card->lock, flags);
 	while ((reg = va_arg(args, u32)) != TAGLIST_END) {
 		u32 data = va_arg(args, u32);
-		u32 regptr = (((reg << 16) & PTR_ADDRESS_MASK)
+		u32 regptr = (((reg << 16) & A_PTR_ADDRESS_MASK)
 			      | (channel & PTR_CHANNELNUM_MASK));
 		outl(regptr, card->iobase + PTR);
 		if (reg & 0xff000000) {
@@ -258,7 +273,7 @@
 	u32 regptr, val;
 	unsigned long flags;
 
-	regptr = ((reg << 16) & PTR_ADDRESS_MASK) | (channel & PTR_CHANNELNUM_MASK);
+	regptr = ((reg << 16) & A_PTR_ADDRESS_MASK) | (channel & PTR_CHANNELNUM_MASK);
 
 	if (reg & 0xff000000) {
 		u32 mask;
@@ -380,7 +395,7 @@
 
 	outb(reg, card->iobase + AC97ADDRESS);
 	outw(value, card->iobase + AC97DATA);
-
+	outb( AC97_EXTENDED_ID, card->iobase + AC97ADDRESS); 
 	spin_unlock_irqrestore(&card->lock, flags);
 }
 
@@ -393,15 +408,23 @@
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&card->lock, flags);
+	if (card->is_audigy) {
+		if ((sblive_readptr(card, A_MUSTAT,0) & MUSTAT_ORDYN) == 0) {
+			sblive_writeptr(card, A_MUDATA, 0, data);
+			ret = 0;
+		} else
+			ret = -1;
+	} else {
+		spin_lock_irqsave(&card->lock, flags);
 
-	if ((inb(card->iobase + MUSTAT) & MUSTAT_ORDYN) == 0) {
-		outb(data, card->iobase + MUDATA);
-		ret = 0;
-	} else
-		ret = -1;
+		if ((inb(card->iobase + MUSTAT) & MUSTAT_ORDYN) == 0) {
+			outb(data, card->iobase + MUDATA);
+			ret = 0;
+		} else
+			ret = -1;
 
-	spin_unlock_irqrestore(&card->lock, flags);
+		spin_unlock_irqrestore(&card->lock, flags);
+	}
 
 	return ret;
 }
@@ -411,15 +434,23 @@
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&card->lock, flags);
+	if (card->is_audigy) {
+		if ((sblive_readptr(card, A_MUSTAT,0) & MUSTAT_IRDYN) == 0) {
+			*data = sblive_readptr(card, A_MUDATA,0);
+			ret = 0;
+		} else
+			ret = -1;
+	} else {
+		spin_lock_irqsave(&card->lock, flags);
 
-	if ((inb(card->iobase + MUSTAT) & MUSTAT_IRDYN) == 0) {
-		*data = inb(card->iobase + MUDATA);
-		ret = 0;
-	} else
-		ret = -1;
+		if ((inb(card->iobase + MUSTAT) & MUSTAT_IRDYN) == 0) {
+			*data = inb(card->iobase + MUDATA);
+			ret = 0;
+		} else
+			ret = -1;
 
-	spin_unlock_irqrestore(&card->lock, flags);
+		spin_unlock_irqrestore(&card->lock, flags);
+	}
 
 	return ret;
 }
@@ -430,37 +461,54 @@
 	unsigned long flags;
 
 	DPF(2, "emu10k1_mpu_reset()\n");
+	if (card->is_audigy) {
+		if (card->mpuacqcount == 0) {
+			sblive_writeptr(card, A_MUCMD, 0, MUCMD_RESET);
+			sblive_wcwait(card, 8);
+			sblive_writeptr(card, A_MUCMD, 0, MUCMD_RESET);
+			sblive_wcwait(card, 8);
+			sblive_writeptr(card, A_MUCMD, 0, MUCMD_ENTERUARTMODE);
+			sblive_wcwait(card, 8);
+			status = sblive_readptr(card, A_MUDATA, 0);
+			if (status == 0xfe)
+				return 0;
+			else
+				return -1;
+		}
 
-	if (card->mpuacqcount == 0) {
-		spin_lock_irqsave(&card->lock, flags);
-		outb(MUCMD_RESET, card->iobase + MUCMD);
-		spin_unlock_irqrestore(&card->lock, flags);
+		return 0;
+	} else {
+		if (card->mpuacqcount == 0) {
+			spin_lock_irqsave(&card->lock, flags);
+			outb(MUCMD_RESET, card->iobase + MUCMD);
+			spin_unlock_irqrestore(&card->lock, flags);
 
-		sblive_wcwait(card, 8);
+			sblive_wcwait(card, 8);
 
-		spin_lock_irqsave(&card->lock, flags);
-		outb(MUCMD_RESET, card->iobase + MUCMD);
-		spin_unlock_irqrestore(&card->lock, flags);
+			spin_lock_irqsave(&card->lock, flags);
+			outb(MUCMD_RESET, card->iobase + MUCMD);
+			spin_unlock_irqrestore(&card->lock, flags);
 
-		sblive_wcwait(card, 8);
+			sblive_wcwait(card, 8);
 
-		spin_lock_irqsave(&card->lock, flags);
-		outb(MUCMD_ENTERUARTMODE, card->iobase + MUCMD);
-		spin_unlock_irqrestore(&card->lock, flags);
+			spin_lock_irqsave(&card->lock, flags);
+			outb(MUCMD_ENTERUARTMODE, card->iobase + MUCMD);
+			spin_unlock_irqrestore(&card->lock, flags);
 
-		sblive_wcwait(card, 8);
+			sblive_wcwait(card, 8);
 
-		spin_lock_irqsave(&card->lock, flags);
-		status = inb(card->iobase + MUDATA);
-		spin_unlock_irqrestore(&card->lock, flags);
+			spin_lock_irqsave(&card->lock, flags);
+			status = inb(card->iobase + MUDATA);
+			spin_unlock_irqrestore(&card->lock, flags);
 
-		if (status == 0xfe)
-			return 0;
-		else
-			return -1;
-	}
+			if (status == 0xfe)
+				return 0;
+			else
+				return -1;
+		}
 
-	return 0;
+		return 0;
+	}
 }
 
 int emu10k1_mpu_acquire(struct emu10k1_card *card)
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/hwaccess.h linux/drivers/sound/emu10k1/hwaccess.h
--- linux-2.4.19-rc1/drivers/sound/emu10k1/hwaccess.h	Sat Jun 29 19:39:04 2002
+++ linux/drivers/sound/emu10k1/hwaccess.h	Sat Jun 29 19:24:28 2002
@@ -79,13 +79,21 @@
 
 struct emu10k1_waveout
 {
-	u16 send_routing[3];
-
-	u8 send_a[3];
-	u8 send_b[3];
-	u8 send_c[3];
-	u8 send_d[3];
+	u32 send_routing[3];
+	// audigy only:
+	u32 send_routing2[3];
+
+	u32 send_dcba[3];
+	// audigy only:
+	u32 send_hgfe[3];
 };
+#define ROUTE_PCM 0
+#define ROUTE_PT 1
+#define ROUTE_PCM1 2
+
+#define SEND_MONO 0
+#define SEND_LEFT 1
+#define SEND_RIGHT 2
 
 struct emu10k1_wavein
 {
@@ -129,7 +137,7 @@
 #define CMD_AC97_BOOST		_IOW('D', 20, struct mixer_private_ioctl)
 
 //up this number when breaking compatibility
-#define PRIVATE3_VERSION 1
+#define PRIVATE3_VERSION 2
 
 struct emu10k1_card 
 {
@@ -181,7 +189,7 @@
 	u32	    has_toslink;	       // TOSLink detection
 
 	u8 chiprev;                    /* Chip revision                */
-
+	u8 is_audigy;
 	u8 is_aps;
 
 	struct patch_manager mgr;
@@ -191,8 +199,6 @@
 int emu10k1_addxmgr_alloc(u32, struct emu10k1_card *);
 void emu10k1_addxmgr_free(struct emu10k1_card *, int);
 
-
-
 int emu10k1_find_control_gpr(struct patch_manager *, const char *, const char *);
 void emu10k1_set_control_gpr(struct emu10k1_card *, int , s32, int );
 
@@ -213,6 +219,7 @@
 /* Hardware Abstraction Layer access functions */
 
 void emu10k1_writefn0(struct emu10k1_card *, u32 , u32 );
+void emu10k1_writefn0_2(struct emu10k1_card *card, u32 reg, u32 data, int size);
 u32 emu10k1_readfn0(struct emu10k1_card *, u32 );
 
 void sblive_writeptr(struct emu10k1_card *, u32 , u32 , u32 );
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/irqmgr.c linux/drivers/sound/emu10k1/irqmgr.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/irqmgr.c	Mon Feb 25 13:38:06 2002
+++ linux/drivers/sound/emu10k1/irqmgr.c	Sat Jun 29 17:33:41 2002
@@ -97,7 +97,7 @@
 		}
 
 		if (irqstatus){
-			printk(KERN_ERR "emu10k1: Warning, unhandled interrupt: %#08x\n", irqstatus);
+			printk(KERN_ERR "emu10k1: Warning, unhandled interrupt: 0x%08x\n", irqstatus);
 			//make sure any interrupts we don't handle are disabled:
 			emu10k1_irq_disable(card, ~(INTE_MIDIRXENABLE | INTE_MIDITXENABLE | INTE_INTERVALTIMERENB |
 						INTE_VOLDECRENABLE | INTE_VOLINCRENABLE | INTE_MUTEENABLE |
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/irqmgr.h linux/drivers/sound/emu10k1/irqmgr.h
--- linux-2.4.19-rc1/drivers/sound/emu10k1/irqmgr.h	Fri Aug 10 23:02:18 2001
+++ linux/drivers/sound/emu10k1/irqmgr.h	Sat Jun 29 17:33:41 2002
@@ -33,15 +33,15 @@
 #define _IRQ_H
 
 /* EMU Irq Types */
-#define IRQTYPE_PCIBUSERROR         IPR_PCIERROR
-#define IRQTYPE_MIXERBUTTON         (IPR_VOLINCR | IPR_VOLDECR | IPR_MUTE)
-#define IRQTYPE_VOICE               (IPR_CHANNELLOOP | IPR_CHANNELNUMBERMASK)
-#define IRQTYPE_RECORD              (IPR_ADCBUFFULL | IPR_ADCBUFHALFFULL | IPR_MICBUFFULL | IPR_MICBUFHALFFULL | IPR_EFXBUFFULL | IPR_EFXBUFHALFFULL)
-#define IRQTYPE_MPUOUT              IPR_MIDITRANSBUFEMPTY
-#define IRQTYPE_MPUIN               IPR_MIDIRECVBUFEMPTY
-#define IRQTYPE_TIMER               IPR_INTERVALTIMER
-#define IRQTYPE_SPDIF               (IPR_GPSPDIFSTATUSCHANGE | IPR_CDROMSTATUSCHANGE)
-#define IRQTYPE_DSP                 IPR_FXDSP
+#define IRQTYPE_PCIBUSERROR	IPR_PCIERROR
+#define IRQTYPE_MIXERBUTTON	(IPR_VOLINCR | IPR_VOLDECR | IPR_MUTE)
+#define IRQTYPE_VOICE		(IPR_CHANNELLOOP | IPR_CHANNELNUMBERMASK)
+#define IRQTYPE_RECORD		(IPR_ADCBUFFULL | IPR_ADCBUFHALFFULL | IPR_MICBUFFULL | IPR_MICBUFHALFFULL | IPR_EFXBUFFULL | IPR_EFXBUFHALFFULL)
+#define IRQTYPE_MPUOUT		(IPR_MIDITRANSBUFEMPTY | A_IPR_MIDITRANSBUFEMPTY2) 
+#define IRQTYPE_MPUIN		(IPR_MIDIRECVBUFEMPTY | A_IPR_MIDIRECVBUFEMPTY2)
+#define IRQTYPE_TIMER		IPR_INTERVALTIMER
+#define IRQTYPE_SPDIF		(IPR_GPSPDIFSTATUSCHANGE | IPR_CDROMSTATUSCHANGE)
+#define IRQTYPE_DSP		IPR_FXDSP
 
 void emu10k1_timer_irqhandler(struct emu10k1_card *);
 void emu10k1_dsp_irqhandler(struct emu10k1_card *);
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/joystick.c linux/drivers/sound/emu10k1/joystick.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/joystick.c	Wed Dec 31 18:00:00 1969
+++ linux/drivers/sound/emu10k1/joystick.c	Sat Jun 29 17:58:20 2002
@@ -0,0 +1,212 @@
+/*
+ **********************************************************************
+ *     joystick.c - Creative EMU10K1 Joystick port driver
+ *     Copyright 2000 Rui Sousa.
+ *
+ **********************************************************************
+ *
+ *     Date                 Author          Summary of changes
+ *     ----                 ------          ------------------
+ *     April  1, 2000       Rui Sousa       initial version 
+ *     April 28, 2000       Rui Sousa       fixed a kernel oops,
+ *					    make use of kcompat24 for
+ *					    2.2 kernels compatibility.
+ *     May    1, 2000       Rui Sousa       improved kernel compatibility
+ *                                          layer.
+ *
+ **********************************************************************
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This program is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this program; if not, write to the Free
+ *     Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
+ *     USA.
+ *
+ **********************************************************************/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/version.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/list.h>
+
+#define DRIVER_VERSION "0.3.2"
+
+#ifndef PCI_VENDOR_ID_CREATIVE
+#define PCI_VENDOR_ID_CREATIVE 0x1102
+#endif
+
+#ifndef PCI_DEVICE_ID_CREATIVE_EMU10K1_JOYSTICK
+#define PCI_DEVICE_ID_CREATIVE_EMU10K1_JOYSTICK 0x7002
+#endif
+
+#ifndef PCI_DEVICE_ID_CREATIVE_AUDIGY_JOYSTICK
+#define PCI_DEVICE_ID_CREATIVE_AUDIGY_JOYSTICK 0x7003
+#endif
+
+
+
+/* PCI function 1 registers, address = <val> + PCIBASE1 */
+
+#define JOYSTICK1               0x00            /* Analog joystick port register                */
+#define JOYSTICK2               0x01            /* Analog joystick port register                */
+#define JOYSTICK3               0x02            /* Analog joystick port register                */
+#define JOYSTICK4               0x03            /* Analog joystick port register                */
+#define JOYSTICK5               0x04            /* Analog joystick port register                */
+#define JOYSTICK6               0x05            /* Analog joystick port register                */
+#define JOYSTICK7               0x06            /* Analog joystick port register                */
+#define JOYSTICK8               0x07            /* Analog joystick port register                */
+
+/* When writing, any write causes JOYSTICK_COMPARATOR output enable to be pulsed on write.      */
+/* When reading, use these bitfields: */
+#define JOYSTICK_BUTTONS        0x0f            /* Joystick button data                         */
+#define JOYSTICK_COMPARATOR     0xf0            /* Joystick comparator data                     */
+
+#define NR_DEV 5
+
+static int io[NR_DEV] = { 0, };
+
+enum {
+	EMU10K1_JOYSTICK = 0
+};
+
+static char *card_names[] = {
+	"EMU10K1 Joystick Port"
+};
+
+static struct pci_device_id emu10k1_joy_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_EMU10K1_JOYSTICK,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, EMU10K1_JOYSTICK},/*Sblive gameport */
+	 { PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_AUDIGY_JOYSTICK,
+	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, EMU10K1_JOYSTICK}, /* Audigy gameport */
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, emu10k1_joy_pci_tbl);
+
+struct emu10k1_joy_card {
+	struct list_head list;
+
+	struct pci_dev *pci_dev;
+	unsigned long iobase;
+	unsigned long length;
+	u8 addr_changed;
+};
+
+static LIST_HEAD(emu10k1_joy_devs);
+static unsigned int devindex = 0;
+
+/* Driver initialization routine */
+static int __devinit emu10k1_joy_probe(struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
+{
+	struct emu10k1_joy_card *card;
+	u16 model;
+	u8 chiprev;
+
+	if ((card = kmalloc(sizeof(struct emu10k1_joy_card), GFP_KERNEL)) == NULL) {
+		printk(KERN_ERR "emu10k1-joy: out of memory\n");
+		return -ENOMEM;
+	}
+	memset(card, 0, sizeof(struct emu10k1_joy_card));
+
+	if (pci_enable_device(pci_dev)) {
+		printk(KERN_ERR "emu10k1-joy: couldn't enable device\n");
+		kfree(card);
+		return -ENODEV;
+	}
+
+	card->iobase = pci_resource_start(pci_dev, 0); 
+	card->length = pci_resource_len(pci_dev, 0);
+
+	if (request_region(card->iobase, card->length, card_names[pci_id->driver_data])
+	    == NULL) {
+		printk(KERN_ERR "emu10k1-joy: IO space in use\n");
+		kfree(card);
+		return -ENODEV;
+	}
+
+	pci_set_drvdata(pci_dev, card);
+
+	card->pci_dev = pci_dev;
+	card->addr_changed = 0;
+
+	pci_read_config_byte(pci_dev, PCI_REVISION_ID, &chiprev);
+	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_ID, &model);
+
+	printk(KERN_INFO "emu10k1-joy: %s rev %d model 0x%x found, IO at 0x%04lx-0x%04lx\n",
+		card_names[pci_id->driver_data], chiprev, model, card->iobase,
+		card->iobase + card->length - 1);
+
+	if (io[devindex]) {
+		if ((io[devindex] & ~0x18) != 0x200) {
+			printk(KERN_ERR "emu10k1-joy: invalid io value\n");
+			release_region(card->iobase, card->length);
+			kfree(card);
+			return -ENODEV;
+		}
+
+		card->addr_changed = 1;
+		pci_write_config_dword(pci_dev, PCI_BASE_ADDRESS_0, io[devindex]);
+		printk(KERN_INFO "emu10k1-joy: IO ports mirrored at 0x%03x\n", io[devindex]);
+	}
+
+	list_add(&card->list, &emu10k1_joy_devs);
+	devindex++;
+
+	return 0;
+}
+
+static void __devexit emu10k1_joy_remove(struct pci_dev *pci_dev)
+{
+	struct emu10k1_joy_card *card = pci_get_drvdata(pci_dev);
+
+	if(card->addr_changed)
+		pci_write_config_dword(pci_dev, PCI_BASE_ADDRESS_0, card->iobase);
+
+	release_region(card->iobase, card->length);
+
+	list_del(&card->list);
+	kfree(card);
+	pci_set_drvdata(pci_dev, NULL);
+}
+
+MODULE_PARM(io, "1-" __MODULE_STRING(NR_DEV) "i");
+MODULE_PARM_DESC(io, "sets joystick port address");
+MODULE_AUTHOR("Rui Sousa (Email to: emu10k1-devel@lists.sourceforge.net)");
+MODULE_DESCRIPTION("Creative EMU10K1 PCI Joystick Port v" DRIVER_VERSION
+		   "\nCopyright (C) 2000 Rui Sousa");
+
+static struct pci_driver emu10k1_joy_pci_driver = {
+	name:"emu10k1 joystick",
+	id_table:emu10k1_joy_pci_tbl,
+	probe:emu10k1_joy_probe,
+	remove:emu10k1_joy_remove,
+};
+
+static int __init emu10k1_joy_init_module(void)
+{
+	printk(KERN_INFO "Creative EMU10K1 PCI Joystick Port, version " DRIVER_VERSION ", " __TIME__
+	       " " __DATE__ "\n");
+
+	return pci_module_init(&emu10k1_joy_pci_driver);
+}
+
+static void __exit emu10k1_joy_cleanup_module(void)
+{
+	pci_unregister_driver(&emu10k1_joy_pci_driver);
+	return;
+}
+
+module_init(emu10k1_joy_init_module);
+module_exit(emu10k1_joy_cleanup_module);
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/main.c linux/drivers/sound/emu10k1/main.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/main.c	Sat Jun 29 19:39:04 2002
+++ linux/drivers/sound/emu10k1/main.c	Sat Jun 29 17:33:41 2002
@@ -78,9 +78,11 @@
  *          Cleaned up poll() functions (audio and midi). Don't start input.
  *	    Restrict DMA pages used to 512Mib range.
  *	    New AC97_BOOST mixer ioctl.
- *     0.19 Real fix for kernel with highmem support (cast dma_handle to u32)
- *	    Fix recording buffering parameters calculation
+ *    0.19a Added Support for Audigy Cards
+ *	    Real fix for kernel with highmem support (cast dma_handle to u32).
+ *	    Fix recording buffering parameters calculation.
  *	    Use unsigned long for variables in bit ops.
+ *
  *********************************************************************/
 
 /* These are only included once per module */
@@ -113,10 +115,9 @@
 #define SNDCARD_EMU10K1 46
 #endif
  
-#define DRIVER_VERSION "0.19"
+/* the emu10k1 should supprt 31 bit bus master */
+#define EMU10K1_DMA_MASK                0x7fffffff	/* DMA buffer mask for pci_alloc_consist */
 
-/* the emu10k1 _seems_ to only supports 29 bit (512MiB) bit bus master */
-#define EMU10K1_DMA_MASK                0x1fffffff	/* DMA buffer mask for pci_alloc_consist */
 
 #ifndef PCI_VENDOR_ID_CREATIVE
 #define PCI_VENDOR_ID_CREATIVE 0x1102
@@ -125,20 +126,27 @@
 #ifndef PCI_DEVICE_ID_CREATIVE_EMU10K1
 #define PCI_DEVICE_ID_CREATIVE_EMU10K1 0x0002
 #endif
+#ifndef PCI_DEVICE_ID_CREATIVE_AUDIGY
+#define PCI_DEVICE_ID_CREATIVE_AUDIGY 0x0004
+#endif
 
 #define EMU_APS_SUBID	0x40011102
  
 enum {
 	EMU10K1 = 0,
+	AUDIGY,
 };
 
 static char *card_names[] __devinitdata = {
 	"EMU10K1",
+	"Audigy",
 };
 
 static struct pci_device_id emu10k1_pci_tbl[] = {
 	{PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_EMU10K1,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, EMU10K1},
+	{PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_AUDIGY,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, AUDIGY},
 	{0,}
 };
 
@@ -173,28 +181,48 @@
 	}
 
 	/* Assign default playback voice parameters */
-	card->mchannel_fx = 8;
-	/* mono voice */
-	card->waveout.send_a[0] = 0xff;
-	card->waveout.send_b[0] = 0xff;
-	card->waveout.send_c[0] = 0x00;
-	card->waveout.send_d[0] = 0x00;
-	card->waveout.send_routing[0] = 0x3210;
-
-	/* stereo voice */
-	/* left */
-	card->waveout.send_a[1] = 0xff;
-	card->waveout.send_b[1] = 0x00;
-	card->waveout.send_c[1] = 0x00;
-	card->waveout.send_d[1] = 0x00;
-	card->waveout.send_routing[1] = 0x3210;
-
-	/* right */
-	card->waveout.send_a[2] = 0x00;
-	card->waveout.send_b[2] = 0xff;
-	card->waveout.send_c[2] = 0x00;
-	card->waveout.send_d[2] = 0x00;
-	card->waveout.send_routing[2] = 0x3210;
+	if (card->is_audigy)
+		card->mchannel_fx = 0;
+	else
+		card->mchannel_fx = 8;
+
+
+	if (card->is_audigy) {
+		/* mono voice */
+		card->waveout.send_dcba[SEND_MONO] = 0xffffffff;
+		card->waveout.send_hgfe[SEND_MONO] = 0x0000ffff;
+	
+		/* stereo voice */
+		/* left */
+		card->waveout.send_dcba[SEND_LEFT] = 0x00ff00ff;
+		card->waveout.send_hgfe[SEND_LEFT] = 0x00007f7f;	
+		/* right */
+		card->waveout.send_dcba[SEND_RIGHT] = 0xff00ff00;
+		card->waveout.send_hgfe[SEND_RIGHT] = 0x00007f7f;
+
+		card->waveout.send_routing[ROUTE_PCM] = 0x03020100; // Regular pcm
+		card->waveout.send_routing2[ROUTE_PCM] = 0x07060504;
+
+		card->waveout.send_routing[ROUTE_PT] = 0x3f3f3d3c; // Passthrough
+		card->waveout.send_routing2[ROUTE_PT] = 0x3f3f3f3f;
+		
+		card->waveout.send_routing[ROUTE_PCM1] = 0x03020100; // Spare
+		card->waveout.send_routing2[ROUTE_PCM1] = 0x07060404;
+		
+	} else {
+		/* mono voice */
+		card->waveout.send_dcba[SEND_MONO] = 0x0000ffff;
+	
+		/* stereo voice */
+		/* left */
+		card->waveout.send_dcba[SEND_LEFT] = 0x000000ff;
+		/* right */
+		card->waveout.send_dcba[SEND_RIGHT] = 0x0000ff00;
+
+		card->waveout.send_routing[ROUTE_PCM] = 0x3210; // pcm
+		card->waveout.send_routing[ROUTE_PT] = 0x3210; // passthrough
+		card->waveout.send_routing[ROUTE_PCM1] = 0x7654; // /dev/dsp1
+	}
 
 	/* Assign default recording parameters */
 	/* FIXME */
@@ -204,6 +232,7 @@
 		card->wavein.recsrc = WAVERECORD_AC97;
 
 	card->wavein.fxwc = 0x0003;
+
 	return 0;
 
 err_dev1:
@@ -218,6 +247,82 @@
 	unregister_sound_dsp(card->audio_dev);
 }
 
+int emu10k1_info_proc (char *page, char **start, off_t off,
+		    int count, int *eof, void *data)
+{
+	struct emu10k1_card *card = data;
+	int len = 0;
+	
+	if (card == NULL)
+		return -ENODEV;
+
+	len += sprintf (page + len, "Driver Version : %s\n", DRIVER_VERSION);
+	len += sprintf (page + len, "Card type      : %s\n", card->is_aps ? "Aps" : (card->is_audigy ? "Audigy" : "Emu10k1"));
+	len += sprintf (page + len, "Revision       : %d\n", card->chiprev);
+	len += sprintf (page + len, "Model          : %#06x\n", card->model);
+	len += sprintf (page + len, "IO             : %#06lx-%#06lx\n", card->iobase, card->iobase + card->length - 1);
+	len += sprintf (page + len, "IRQ            : %d\n\n", card->irq);
+	
+	len += sprintf (page + len, "Registered /dev Entries:\n");
+	len += sprintf (page + len, "/dev/dsp%d\n", card->audio_dev / 16);
+	len += sprintf (page + len, "/dev/dsp%d\n", card->audio_dev1 / 16);
+	len += sprintf (page + len, "/dev/mixer%d\n", card->ac97.dev_mixer / 16);
+	len += sprintf (page + len, "/dev/midi%d\n", card->midi_dev / 16);
+
+#ifdef EMU10K1_SEQUENCER
+	len += sprintf (page + len, "/dev/sequencer\n");
+#endif
+
+	return len;
+}
+
+static int __devinit emu10k1_proc_init(struct emu10k1_card *card)
+{
+	char s[32];
+
+	if (!proc_mkdir ("driver/emu10k1", 0)) {
+		printk(KERN_ERR "emu10k1: unable to create proc directory driver/emu10k1\n");
+		goto err_out;
+	}
+
+	sprintf(s, "driver/emu10k1/%s", card->pci_dev->slot_name);
+	if (!proc_mkdir (s, 0)) {
+		printk(KERN_ERR "emu10k1: unable to create proc directory %s\n", s);
+		goto err_emu10k1_proc;
+	}
+
+	sprintf(s, "driver/emu10k1/%s/info", card->pci_dev->slot_name);
+	if (!create_proc_read_entry (s, 0, 0, emu10k1_info_proc, card)) {
+		printk(KERN_ERR "emu10k1: unable to create proc entry %s\n", s);
+		goto err_dev_proc;
+	}
+
+	return 0;
+
+ err_dev_proc:
+	sprintf(s, "driver/emu10k1/%s", card->pci_dev->slot_name);
+	remove_proc_entry(s, NULL);
+
+ err_emu10k1_proc:
+	remove_proc_entry("driver/emu10k1", NULL);
+
+ err_out:
+	return -EIO;
+}
+
+static void __devinit emu10k1_proc_cleanup(struct emu10k1_card *card)
+{
+	char s[32];
+
+	sprintf(s, "driver/emu10k1/%s/info", card->pci_dev->slot_name);
+	remove_proc_entry(s, NULL);
+
+	sprintf(s, "driver/emu10k1/%s", card->pci_dev->slot_name);
+	remove_proc_entry(s, NULL);
+		
+	remove_proc_entry("driver/emu10k1", NULL);
+}
+
 static int __devinit emu10k1_mixer_init(struct emu10k1_card *card)
 {
 	char s[32];
@@ -250,21 +355,10 @@
 		// Force 5bit:		    
 		//card->ac97.bit_resolution=5;
 
-		if (!proc_mkdir ("driver/emu10k1", 0)) {
-			printk(KERN_ERR "emu10k1: unable to create proc directory driver/emu10k1\n");
-			goto err_out;
-		}
-
-		sprintf(s, "driver/emu10k1/%s", card->pci_dev->slot_name);
-		if (!proc_mkdir (s, 0)) {
-			printk(KERN_ERR "emu10k1: unable to create proc directory %s\n", s);
-			goto err_emu10k1_proc;
-		}
-	
 		sprintf(s, "driver/emu10k1/%s/ac97", card->pci_dev->slot_name);
 		if (!create_proc_read_entry (s, 0, 0, ac97_read_proc, &card->ac97)) {
 			printk(KERN_ERR "emu10k1: unable to create proc entry %s\n", s);
-			goto err_ac97_proc;
+			goto err_out;
 		}
 
 		/* these will store the original values and never be modified */
@@ -274,12 +368,6 @@
 
 	return 0;
 
- err_ac97_proc:
-	sprintf(s, "driver/emu10k1/%s", card->pci_dev->slot_name);
-	remove_proc_entry(s, NULL);
-
- err_emu10k1_proc:
-	remove_proc_entry("driver/emu10k1", NULL);
  err_out:
 	unregister_sound_mixer (card->ac97.dev_mixer);
 	return -EIO;
@@ -292,11 +380,6 @@
 	if (!card->is_aps) {
 		sprintf(s, "driver/emu10k1/%s/ac97", card->pci_dev->slot_name);
 		remove_proc_entry(s, NULL);
-
-		sprintf(s, "driver/emu10k1/%s", card->pci_dev->slot_name);
-		remove_proc_entry(s, NULL);
-
-		remove_proc_entry("driver/emu10k1", NULL);
 	}
 
 	unregister_sound_mixer (card->ac97.dev_mixer);
@@ -451,24 +534,25 @@
 	s32 left, right;
 	int i;
 	u32 pc = 0;
-	u32 patch_n;
+	u32 patch_n=0;
+	struct emu_efx_info_t emu_efx_info[2]=
+		{{ 20, 10, 0x400, 0x100, 0x20 },
+		 { 24, 12, 0x600, 0x400, 0x60 },
+		}; 
+			
 
 	for (i = 0; i < SOUND_MIXER_NRDEVICES; i++) {
 		mgr->ctrl_gpr[i][0] = -1;
 		mgr->ctrl_gpr[i][1] = -1;
 	}
 
-	for (i = 0; i < 512; i++)
-		OP(6, 0x40, 0x40, 0x40, 0x40);
 
-	for (i = 0; i < 256; i++)
-		sblive_writeptr_tag(card, 0,
-				    FXGPREGBASE + i, 0,
-				    TANKMEMADDRREGBASE + i, 0,
-				    TAGLIST_END);
-
-	/* !! The number bellow must equal the number of patches, currently 11 !! */
-	mgr->current_pages = (11 + PATCHES_PER_PAGE - 1) / PATCHES_PER_PAGE;
+	if (card->is_audigy)
+		mgr->current_pages = (2 + PATCHES_PER_PAGE - 1) / PATCHES_PER_PAGE;
+	else
+		/* !! The number below must equal the number of patches, currently 11 !! */
+		mgr->current_pages = (11 + PATCHES_PER_PAGE - 1) / PATCHES_PER_PAGE;
+	
 	for (i = 0; i < mgr->current_pages; i++) {
 		mgr->patch[i] = (void *)__get_free_page(GFP_KERNEL);
 		if (mgr->patch[i] == NULL) {
@@ -479,215 +563,298 @@
 		memset(mgr->patch[i], 0, PAGE_SIZE);
 	}
 
-	pc = 0;
-	patch_n = 0;
-	//first free GPR = 0x11b
-
-	/* FX volume correction and Volume control*/
-	INPUT_PATCH_START(patch, "Pcm L vol", 0x0, 0);
-	GET_OUTPUT_GPR(patch, 0x100, 0x0);
-	GET_CONTROL_GPR(patch, 0x106, "Vol", 0, 0x7fffffff);
-	GET_DYNAMIC_GPR(patch, 0x112);
-
-	OP(4, 0x112, 0x40, PCM_IN_L, 0x44); //*4
-	OP(0, 0x100, 0x040, 0x112, 0x106);  //*vol
-	INPUT_PATCH_END(patch);
-
-
-	INPUT_PATCH_START(patch, "Pcm R vol", 0x1, 0);
-	GET_OUTPUT_GPR(patch, 0x101, 0x1);
-	GET_CONTROL_GPR(patch, 0x107, "Vol", 0, 0x7fffffff);
-	GET_DYNAMIC_GPR(patch, 0x112);
-
-	OP(4, 0x112, 0x40, PCM_IN_R, 0x44); 
-	OP(0, 0x101, 0x040, 0x112, 0x107);
-
-	INPUT_PATCH_END(patch);
-
-
-	// CD-Digital In Volume control
-	INPUT_PATCH_START(patch, "CD-Digital Vol L", 0x12, 0);
-	GET_OUTPUT_GPR(patch, 0x10c, 0x12);
-	GET_CONTROL_GPR(patch, 0x10d, "Vol", 0, 0x7fffffff);
-
-	OP(0, 0x10c, 0x040, SPDIF_CD_L, 0x10d);
-	INPUT_PATCH_END(patch);
-
-	INPUT_PATCH_START(patch, "CD-Digital Vol R", 0x13, 0);
-	GET_OUTPUT_GPR(patch, 0x10e, 0x13);
-	GET_CONTROL_GPR(patch, 0x10f, "Vol", 0, 0x7fffffff);
-
-	OP(0, 0x10e, 0x040, SPDIF_CD_R, 0x10f);
-	INPUT_PATCH_END(patch);
-
-	//Volume Correction for Multi-channel Inputs
-	INPUT_PATCH_START(patch, "Multi-Channel Gain", 0x08, 0);
-	patch->input=patch->output=0x3F00;
-
-	GET_OUTPUT_GPR(patch, 0x113, MULTI_FRONT_L);
-	GET_OUTPUT_GPR(patch, 0x114, MULTI_FRONT_R);
-	GET_OUTPUT_GPR(patch, 0x115, MULTI_REAR_L);
-	GET_OUTPUT_GPR(patch, 0x116, MULTI_REAR_R);
-	GET_OUTPUT_GPR(patch, 0x117, MULTI_CENTER);
-	GET_OUTPUT_GPR(patch, 0x118, MULTI_LFE);
-
-	OP(4, 0x113, 0x40, MULTI_FRONT_L, 0x44);
-	OP(4, 0x114, 0x40, MULTI_FRONT_R, 0x44);
-	OP(4, 0x115, 0x40, MULTI_REAR_L, 0x44);
-	OP(4, 0x116, 0x40, MULTI_REAR_R, 0x44);
-	OP(4, 0x117, 0x40, MULTI_CENTER, 0x44);
-	OP(4, 0x118, 0x40, MULTI_LFE, 0x44);
-	
-	INPUT_PATCH_END(patch);
-
-
-	//Routing patch start
-	ROUTING_PATCH_START(rpatch, "Routing");
-	GET_INPUT_GPR(rpatch, 0x100, 0x0);
-	GET_INPUT_GPR(rpatch, 0x101, 0x1);
-	GET_INPUT_GPR(rpatch, 0x10c, 0x12);
-	GET_INPUT_GPR(rpatch, 0x10e, 0x13);
-	GET_INPUT_GPR(rpatch, 0x113, MULTI_FRONT_L);
-	GET_INPUT_GPR(rpatch, 0x114, MULTI_FRONT_R);
-	GET_INPUT_GPR(rpatch, 0x115, MULTI_REAR_L);
-	GET_INPUT_GPR(rpatch, 0x116, MULTI_REAR_R);
-	GET_INPUT_GPR(rpatch, 0x117, MULTI_CENTER);
-	GET_INPUT_GPR(rpatch, 0x118, MULTI_LFE);
-
-	GET_DYNAMIC_GPR(rpatch, 0x102);
-	GET_DYNAMIC_GPR(rpatch, 0x103);
-
-	GET_OUTPUT_GPR(rpatch, 0x104, 0x8);
-	GET_OUTPUT_GPR(rpatch, 0x105, 0x9);
-	GET_OUTPUT_GPR(rpatch, 0x10a, 0x2);
-	GET_OUTPUT_GPR(rpatch, 0x10b, 0x3);
-
-
-	/* input buffer */
-	OP(6, 0x102, AC97_IN_L, 0x40, 0x40);
-	OP(6, 0x103, AC97_IN_R, 0x40, 0x40);
-
-
-	/* Digital In + PCM + MULTI_FRONT-> AC97 out (front speakers)*/
-	OP(6, AC97_FRONT_L, 0x100, 0x10c, 0x113);
-
-	CONNECT(MULTI_FRONT_L, AC97_FRONT_L);
-	CONNECT(PCM_IN_L, AC97_FRONT_L);
-	CONNECT(SPDIF_CD_L, AC97_FRONT_L);
-
-	OP(6, AC97_FRONT_R, 0x101, 0x10e, 0x114);
-
-	CONNECT(MULTI_FRONT_R, AC97_FRONT_R);
-	CONNECT(PCM_IN_R, AC97_FRONT_R);
-	CONNECT(SPDIF_CD_R, AC97_FRONT_R);
-
-	/* Digital In + PCM + AC97 In + PCM1 + MULTI_REAR --> Rear Channel */ 
-	OP(6, 0x104, PCM1_IN_L, 0x100, 0x115);
-	OP(6, 0x104, 0x104, 0x10c, 0x102);
-
-	CONNECT(MULTI_REAR_L, ANALOG_REAR_L);
-	CONNECT(AC97_IN_L, ANALOG_REAR_L);
-	CONNECT(PCM_IN_L, ANALOG_REAR_L);
-	CONNECT(SPDIF_CD_L, ANALOG_REAR_L);
-	CONNECT(PCM1_IN_L, ANALOG_REAR_L);
-
-	OP(6, 0x105, PCM1_IN_R, 0x101, 0x116);
-	OP(6, 0x105, 0x105, 0x10e, 0x103);
-
-	CONNECT(MULTI_REAR_R, ANALOG_REAR_R);
-	CONNECT(AC97_IN_R, ANALOG_REAR_R);
-	CONNECT(PCM_IN_R, ANALOG_REAR_R);
-	CONNECT(SPDIF_CD_R, ANALOG_REAR_R);
-	CONNECT(PCM1_IN_R, ANALOG_REAR_R);
-
-	/* Digital In + PCM + AC97 In + MULTI_FRONT --> Digital out */
-	OP(6, 0x10a, 0x100, 0x102, 0x10c);
-	OP(6, 0x10a, 0x10a, 0x113, 0x40);
-
-	CONNECT(MULTI_FRONT_L, DIGITAL_OUT_L);
-	CONNECT(PCM_IN_L, DIGITAL_OUT_L);
-	CONNECT(AC97_IN_L, DIGITAL_OUT_L);
-	CONNECT(SPDIF_CD_L, DIGITAL_OUT_L);
-
-	OP(6, 0x10b, 0x101, 0x103, 0x10e);
-	OP(6, 0x10b, 0x10b, 0x114, 0x40);
-
-	CONNECT(MULTI_FRONT_R, DIGITAL_OUT_R);
-	CONNECT(PCM_IN_R, DIGITAL_OUT_R);
-	CONNECT(AC97_IN_R, DIGITAL_OUT_R);
-	CONNECT(SPDIF_CD_R, DIGITAL_OUT_R);
-
-	/* AC97 In --> ADC Recording Buffer */
-	OP(6, ADC_REC_L, 0x102, 0x40, 0x40);
-
-	CONNECT(AC97_IN_L, ADC_REC_L);
-
-	OP(6, ADC_REC_R, 0x103, 0x40, 0x40);
-
-	CONNECT(AC97_IN_R, ADC_REC_R);
+	if (card->is_audigy) {
+		for (i = 0; i < 1024; i++)
+			OP(0xf, 0x0c0, 0x0c0, 0x0cf, 0x0c0);
+
+		for (i = 0; i < 512 ; i++)
+			sblive_writeptr(card, A_GPR_BASE+i,0,0);
+
+		pc=0;
+
+		//Pcm input volume
+		OP(0, 0x402, 0x0c0, 0x406, 0x000);
+		OP(0, 0x403, 0x0c0, 0x407, 0x001);
+
+		//CD-Digital input Volume
+		OP(0, 0x404, 0x0c0, 0x40d, 0x42);
+		OP(0, 0x405, 0x0c0, 0x40f, 0x43);
+
+		// CD + PCM 
+		OP(6, 0x400, 0x0c0, 0x402, 0x404);
+		OP(6, 0x401, 0x0c0, 0x403, 0x405);
+		
+		// Front Output + Master Volume
+		OP(0, 0x68, 0x0c0, 0x408, 0x400);
+		OP(0, 0x69, 0x0c0, 0x409, 0x401);
+
+		// Add-in analog inputs for other speakers
+		OP(6, 0x400, 0x40, 0x400, 0xc0);
+		OP(6, 0x401, 0x41, 0x401, 0xc0);
+
+		// Digital Front + Master Volume
+		OP(0, 0x60, 0x0c0, 0x408, 0x400);
+		OP(0, 0x61, 0x0c0, 0x409, 0x401);
+
+		// Rear Output + Rear Volume
+		OP(0, 0x06e, 0x0c0, 0x419, 0x400);
+		OP(0, 0x06f, 0x0c0, 0x41a, 0x401);		
+
+		// Digital Rear Output + Rear Volume
+		OP(0, 0x066, 0x0c0, 0x419, 0x400);
+		OP(0, 0x067, 0x0c0, 0x41a, 0x401);		
+
+		// Audigy Drive, Headphone out
+		OP(6, 0x64, 0x0c0, 0x0c0, 0x400);
+		OP(6, 0x65, 0x0c0, 0x0c0, 0x401);
+
+		// ac97 Recording
+		OP(6, 0x76, 0x0c0, 0x0c0, 0x40);
+		OP(6, 0x77, 0x0c0, 0x0c0, 0x41);
+		
+		// Center = sub = Left/2 + Right/2
+		OP(0xe, 0x400, 0x401, 0xcd, 0x400);
+
+		// center/sub  Volume (master)
+		OP(0, 0x06a, 0x0c0, 0x408, 0x400);
+		OP(0, 0x06b, 0x0c0, 0x409, 0x400);
+
+		// Digital center/sub  Volume (master)
+		OP(0, 0x062, 0x0c0, 0x408, 0x400);
+		OP(0, 0x063, 0x0c0, 0x409, 0x400);
+
+		ROUTING_PATCH_START(rpatch, "Routing");
+		ROUTING_PATCH_END(rpatch);
+
+		/* delimiter patch */
+		patch = PATCH(mgr, patch_n);
+		patch->code_size = 0;
 
+	
+		sblive_writeptr(card, 0x53, 0, 0);
+	} else {
+		for (i = 0; i < 512 ; i++)
+			OP(6, 0x40, 0x40, 0x40, 0x40);
+
+		for (i = 0; i < 256; i++)
+			sblive_writeptr_tag(card, 0,
+					    FXGPREGBASE + i, 0,
+					    TANKMEMADDRREGBASE + i, 0,
+					    TAGLIST_END);
 
-	/* fx12:Analog-Center */
-	OP(6, ANALOG_CENTER, 0x117, 0x40, 0x40);
-	CONNECT(MULTI_CENTER, ANALOG_CENTER);
+		
+		pc = 0;
 
-	/* fx11:Analog-LFE */
-	OP(6, ANALOG_LFE, 0x118, 0x40, 0x40);
-	CONNECT(MULTI_LFE, ANALOG_LFE);
+		//first free GPR = 0x11b
+	
+		
+		/* FX volume correction and Volume control*/
+		INPUT_PATCH_START(patch, "Pcm L vol", 0x0, 0);
+		GET_OUTPUT_GPR(patch, 0x100, 0x0);
+		GET_CONTROL_GPR(patch, 0x106, "Vol", 0, 0x7fffffff);
+		GET_DYNAMIC_GPR(patch, 0x112);
+
+		OP(4, 0x112, 0x40, PCM_IN_L, 0x44); //*4	
+		OP(0, 0x100, 0x040, 0x112, 0x106);  //*vol	
+		INPUT_PATCH_END(patch);
+
+
+		INPUT_PATCH_START(patch, "Pcm R vol", 0x1, 0);
+		GET_OUTPUT_GPR(patch, 0x101, 0x1);
+		GET_CONTROL_GPR(patch, 0x107, "Vol", 0, 0x7fffffff);
+		GET_DYNAMIC_GPR(patch, 0x112);
+
+		OP(4, 0x112, 0x40, PCM_IN_R, 0x44); 
+		OP(0, 0x101, 0x040, 0x112, 0x107);
+
+		INPUT_PATCH_END(patch);
+
+
+		// CD-Digital In Volume control	
+		INPUT_PATCH_START(patch, "CD-Digital Vol L", 0x12, 0);
+		GET_OUTPUT_GPR(patch, 0x10c, 0x12);
+		GET_CONTROL_GPR(patch, 0x10d, "Vol", 0, 0x7fffffff);
+
+		OP(0, 0x10c, 0x040, SPDIF_CD_L, 0x10d);
+		INPUT_PATCH_END(patch);
+
+		INPUT_PATCH_START(patch, "CD-Digital Vol R", 0x13, 0);
+		GET_OUTPUT_GPR(patch, 0x10e, 0x13);
+		GET_CONTROL_GPR(patch, 0x10f, "Vol", 0, 0x7fffffff);
+
+		OP(0, 0x10e, 0x040, SPDIF_CD_R, 0x10f);
+		INPUT_PATCH_END(patch);
+
+		//Volume Correction for Multi-channel Inputs	
+		INPUT_PATCH_START(patch, "Multi-Channel Gain", 0x08, 0);
+		patch->input=patch->output=0x3F00;
+
+		GET_OUTPUT_GPR(patch, 0x113, MULTI_FRONT_L);
+		GET_OUTPUT_GPR(patch, 0x114, MULTI_FRONT_R);
+		GET_OUTPUT_GPR(patch, 0x115, MULTI_REAR_L);
+		GET_OUTPUT_GPR(patch, 0x116, MULTI_REAR_R);
+		GET_OUTPUT_GPR(patch, 0x117, MULTI_CENTER);
+		GET_OUTPUT_GPR(patch, 0x118, MULTI_LFE);
+
+		OP(4, 0x113, 0x40, MULTI_FRONT_L, 0x44);
+		OP(4, 0x114, 0x40, MULTI_FRONT_R, 0x44);
+		OP(4, 0x115, 0x40, MULTI_REAR_L, 0x44);
+		OP(4, 0x116, 0x40, MULTI_REAR_R, 0x44);
+		OP(4, 0x117, 0x40, MULTI_CENTER, 0x44);
+		OP(4, 0x118, 0x40, MULTI_LFE, 0x44);
+	
+		INPUT_PATCH_END(patch);
 
-	/* fx12:Digital-Center */
-	OP(6, DIGITAL_CENTER, 0x117, 0x40, 0x40);
-	CONNECT(MULTI_CENTER, DIGITAL_CENTER);
 
-	/* fx11:Analog-LFE */
-	OP(6, DIGITAL_LFE, 0x118, 0x40, 0x40);
-	CONNECT(MULTI_LFE, DIGITAL_LFE);
+		//Routing patch start	
+		ROUTING_PATCH_START(rpatch, "Routing");
+		GET_INPUT_GPR(rpatch, 0x100, 0x0);
+		GET_INPUT_GPR(rpatch, 0x101, 0x1);
+		GET_INPUT_GPR(rpatch, 0x10c, 0x12);
+		GET_INPUT_GPR(rpatch, 0x10e, 0x13);
+		GET_INPUT_GPR(rpatch, 0x113, MULTI_FRONT_L);
+		GET_INPUT_GPR(rpatch, 0x114, MULTI_FRONT_R);
+		GET_INPUT_GPR(rpatch, 0x115, MULTI_REAR_L);
+		GET_INPUT_GPR(rpatch, 0x116, MULTI_REAR_R);
+		GET_INPUT_GPR(rpatch, 0x117, MULTI_CENTER);
+		GET_INPUT_GPR(rpatch, 0x118, MULTI_LFE);
+
+		GET_DYNAMIC_GPR(rpatch, 0x102);
+		GET_DYNAMIC_GPR(rpatch, 0x103);
+
+		GET_OUTPUT_GPR(rpatch, 0x104, 0x8);
+		GET_OUTPUT_GPR(rpatch, 0x105, 0x9);
+		GET_OUTPUT_GPR(rpatch, 0x10a, 0x2);
+		GET_OUTPUT_GPR(rpatch, 0x10b, 0x3);
+		
+		
+		/* input buffer */
+		OP(6, 0x102, AC97_IN_L, 0x40, 0x40);
+		OP(6, 0x103, AC97_IN_R, 0x40, 0x40);
+
+
+		/* Digital In + PCM + MULTI_FRONT-> AC97 out (front speakers)*/
+		OP(6, AC97_FRONT_L, 0x100, 0x10c, 0x113);
+
+		CONNECT(MULTI_FRONT_L, AC97_FRONT_L);
+		CONNECT(PCM_IN_L, AC97_FRONT_L);
+		CONNECT(SPDIF_CD_L, AC97_FRONT_L);
+
+		OP(6, AC97_FRONT_R, 0x101, 0x10e, 0x114);
+
+		CONNECT(MULTI_FRONT_R, AC97_FRONT_R);
+		CONNECT(PCM_IN_R, AC97_FRONT_R);
+		CONNECT(SPDIF_CD_R, AC97_FRONT_R);
+
+		/* Digital In + PCM + AC97 In + PCM1 + MULTI_REAR --> Rear Channel */ 
+		OP(6, 0x104, PCM1_IN_L, 0x100, 0x115);
+		OP(6, 0x104, 0x104, 0x10c, 0x102);
+
+		CONNECT(MULTI_REAR_L, ANALOG_REAR_L);
+		CONNECT(AC97_IN_L, ANALOG_REAR_L);
+		CONNECT(PCM_IN_L, ANALOG_REAR_L);
+		CONNECT(SPDIF_CD_L, ANALOG_REAR_L);
+		CONNECT(PCM1_IN_L, ANALOG_REAR_L);
+
+		OP(6, 0x105, PCM1_IN_R, 0x101, 0x116);
+		OP(6, 0x105, 0x105, 0x10e, 0x103);
+
+		CONNECT(MULTI_REAR_R, ANALOG_REAR_R);
+		CONNECT(AC97_IN_R, ANALOG_REAR_R);
+		CONNECT(PCM_IN_R, ANALOG_REAR_R);
+		CONNECT(SPDIF_CD_R, ANALOG_REAR_R);
+		CONNECT(PCM1_IN_R, ANALOG_REAR_R);
+
+		/* Digital In + PCM + AC97 In + MULTI_FRONT --> Digital out */
+		OP(6, 0x10b, 0x100, 0x102, 0x10c);
+		OP(6, 0x10b, 0x10b, 0x113, 0x40);
+
+		CONNECT(MULTI_FRONT_L, DIGITAL_OUT_L);
+		CONNECT(PCM_IN_L, DIGITAL_OUT_L);
+		CONNECT(AC97_IN_L, DIGITAL_OUT_L);
+		CONNECT(SPDIF_CD_L, DIGITAL_OUT_L);
+
+		OP(6, 0x10a, 0x101, 0x103, 0x10e);
+		OP(6, 0x10b, 0x10b, 0x114, 0x40);
+
+		CONNECT(MULTI_FRONT_R, DIGITAL_OUT_R);
+		CONNECT(PCM_IN_R, DIGITAL_OUT_R);
+		CONNECT(AC97_IN_R, DIGITAL_OUT_R);
+		CONNECT(SPDIF_CD_R, DIGITAL_OUT_R);
+
+		/* AC97 In --> ADC Recording Buffer */
+		OP(6, ADC_REC_L, 0x102, 0x40, 0x40);
+
+		CONNECT(AC97_IN_L, ADC_REC_L);
+
+		OP(6, ADC_REC_R, 0x103, 0x40, 0x40);
+
+		CONNECT(AC97_IN_R, ADC_REC_R);
+
+
+		/* fx12:Analog-Center */
+		OP(6, ANALOG_CENTER, 0x117, 0x40, 0x40);
+		CONNECT(MULTI_CENTER, ANALOG_CENTER);
+
+		/* fx11:Analog-LFE */
+		OP(6, ANALOG_LFE, 0x118, 0x40, 0x40);
+		CONNECT(MULTI_LFE, ANALOG_LFE);
+
+		/* fx12:Digital-Center */
+		OP(6, DIGITAL_CENTER, 0x117, 0x40, 0x40);
+		CONNECT(MULTI_CENTER, DIGITAL_CENTER);
+		
+		/* fx11:Analog-LFE */
+		OP(6, DIGITAL_LFE, 0x118, 0x40, 0x40);
+		CONNECT(MULTI_LFE, DIGITAL_LFE);
 	
-	ROUTING_PATCH_END(rpatch);
-
+		ROUTING_PATCH_END(rpatch);
 
-	// Rear volume control
-	OUTPUT_PATCH_START(patch, "Vol Rear L", 0x8, 0);
-	GET_INPUT_GPR(patch, 0x104, 0x8);
-	GET_CONTROL_GPR(patch, 0x119, "Vol", 0, 0x7fffffff);
 
-	OP(0, ANALOG_REAR_L, 0x040, 0x104, 0x119);
-	OUTPUT_PATCH_END(patch);
+		// Rear volume control	
+		OUTPUT_PATCH_START(patch, "Vol Rear L", 0x8, 0);
+		GET_INPUT_GPR(patch, 0x104, 0x8);
+		GET_CONTROL_GPR(patch, 0x119, "Vol", 0, 0x7fffffff);
 
+		OP(0, ANALOG_REAR_L, 0x040, 0x104, 0x119);
+		OUTPUT_PATCH_END(patch);
 
-	OUTPUT_PATCH_START(patch, "Vol Rear R", 0x9, 0);
-	GET_INPUT_GPR(patch, 0x105, 0x9);
-	GET_CONTROL_GPR(patch, 0x11a, "Vol", 0, 0x7fffffff);
+		OUTPUT_PATCH_START(patch, "Vol Rear R", 0x9, 0);
+		GET_INPUT_GPR(patch, 0x105, 0x9);
+		GET_CONTROL_GPR(patch, 0x11a, "Vol", 0, 0x7fffffff);
 
-	OP(0, ANALOG_REAR_R, 0x040, 0x105, 0x11a);
-	OUTPUT_PATCH_END(patch);
+		OP(0, ANALOG_REAR_R, 0x040, 0x105, 0x11a);
+		OUTPUT_PATCH_END(patch);
 
 
-	//Master volume control on front-digital
-	OUTPUT_PATCH_START(patch, "Vol Master L", 0x2, 1);
-	GET_INPUT_GPR(patch, 0x10a, 0x2);
-	GET_CONTROL_GPR(patch, 0x108, "Vol", 0, 0x7fffffff);
+		//Master volume control on front-digital	
+		OUTPUT_PATCH_START(patch, "Vol Master L", 0x2, 1);
+		GET_INPUT_GPR(patch, 0x10a, 0x2);
+		GET_CONTROL_GPR(patch, 0x108, "Vol", 0, 0x7fffffff);
 
-	OP(0, DIGITAL_OUT_L, 0x040, 0x10a, 0x108);
-	OUTPUT_PATCH_END(patch);
+		OP(0, DIGITAL_OUT_L, 0x040, 0x10a, 0x108);
+		OUTPUT_PATCH_END(patch);
 
 
-	OUTPUT_PATCH_START(patch, "Vol Master R", 0x3, 1);
-	GET_INPUT_GPR(patch, 0x10b, 0x3);
-	GET_CONTROL_GPR(patch, 0x109, "Vol", 0, 0x7fffffff);
+		OUTPUT_PATCH_START(patch, "Vol Master R", 0x3, 1);
+		GET_INPUT_GPR(patch, 0x10b, 0x3);
+		GET_CONTROL_GPR(patch, 0x109, "Vol", 0, 0x7fffffff);
 
-	OP(0, DIGITAL_OUT_R, 0x040, 0x10b, 0x109);
-	OUTPUT_PATCH_END(patch);
+		OP(0, DIGITAL_OUT_R, 0x040, 0x10b, 0x109);
+		OUTPUT_PATCH_END(patch);
 
 
-	/* delimiter patch */
-	patch = PATCH(mgr, patch_n);
-	patch->code_size = 0;
+		/* delimiter patch */
+		patch = PATCH(mgr, patch_n);
+		patch->code_size = 0;
 
-	sblive_writeptr(card, DBG, 0, 0);
+	
+		sblive_writeptr(card, DBG, 0, 0);
+	}
 
 	mgr->lock = SPIN_LOCK_UNLOCKED;
 
+	// Set up Volume controls, try to keep this the same for both Audigy and Live
 
 	//Master volume
 	mgr->ctrl_gpr[SOUND_MIXER_VOLUME][0] = 8;
@@ -735,8 +902,16 @@
 	emu10k1_set_volume_gpr(card, 0xd, left, VOL_5BIT);
 	emu10k1_set_volume_gpr(card, 0xf, right, VOL_5BIT);
 
-	//hard wire the ac97's pcm, we'll do that in dsp code instead.
-	emu10k1_ac97_write(&card->ac97, 0x18, 0x0);
+
+	//hard wire the ac97's pcm, pcm volume is done above using dsp code.
+	if (card->is_audigy)
+		//for Audigy, we mute it and use the philips 6 channel DAC instead
+		emu10k1_ac97_write(&card->ac97, 0x18, 0x8000);
+	else
+		//For the Live we hardwire it to full volume
+		emu10k1_ac97_write(&card->ac97, 0x18, 0x0);
+
+	//remove it from the ac97_codec's control
 	card->ac97_supported_mixers &= ~SOUND_MASK_PCM;
 	card->ac97_stereo_mixers &= ~SOUND_MASK_PCM;
 
@@ -774,6 +949,12 @@
 			    SOLEL, 0,
 			    SOLEH, 0,
 			    TAGLIST_END);
+	if (card->is_audigy) {
+		sblive_writeptr_tag(card,0,
+				    0x5e,0xf00,
+				    0x5f,0x3,
+				    TAGLIST_END);
+	}
 
 	/* Init envelope engine */
 	for (nCh = 0; nCh < NUM_G; nCh++) {
@@ -809,7 +990,23 @@
 				    ENVVOL, 0,
 				    ENVVAL, 0,
                                     TAGLIST_END);
+
 		sblive_writeptr(card, CPF, nCh, 0);
+		/*
+		  Audigy FXRT initialization
+		  reversed eng'd, may not be accurate.
+		 */
+		if (card->is_audigy) {
+			sblive_writeptr_tag(card,nCh,
+					    0x4c,0x0,
+					    0x4d,0x0,
+					    0x4e,0x0,
+					    0x4f,0x0,
+					    A_FXRT1, 0x3f3f3f3f,
+					    A_FXRT2, 0x3f3f3f3f,
+					    A_SENDAMOUNTS, 0,
+					    TAGLIST_END);
+		}
 	}
 	
 
@@ -869,7 +1066,8 @@
 	}
 
 	for (pagecount = 0; pagecount < MAXPAGES; pagecount++)
-		((u32 *) card->virtualpagetable.addr)[pagecount] = cpu_to_le32(((u32) card->silentpage.dma_handle * 2) | pagecount);
+		((u32 *) card->virtualpagetable.addr)[pagecount] = cpu_to_le32(((u32) card->silentpage.dma_handle * 2) | 
+pagecount);
 
 	/* Init page table & tank memory base register */
 	sblive_writeptr_tag(card, 0,
@@ -891,9 +1089,10 @@
 	/* Lock Tank Memory = 1 */
 	/* Lock Sound Memory = 0 */
 	/* Auto Mute = 1 */
-
-	if (card->model == 0x20 || card->model == 0xc400 ||
-	  (card->model == 0x21 && card->chiprev < 6))
+	if (card->is_audigy)
+		emu10k1_writefn0(card, HCFG, HCFG_AUDIOENABLE  | HCFG_AUTOMUTE | HCFG_JOYENABLE);
+	else if (card->model == 0x20 || card->model == 0xc400 ||
+		 (card->model == 0x21 && card->chiprev < 6))
 	        emu10k1_writefn0(card, HCFG, HCFG_AUDIOENABLE  | HCFG_LOCKTANKCACHE_MASK | HCFG_AUTOMUTE);
 	else
 		emu10k1_writefn0(card, HCFG, HCFG_AUDIOENABLE  | HCFG_LOCKTANKCACHE_MASK | HCFG_AUTOMUTE | HCFG_JOYENABLE);
@@ -998,6 +1197,9 @@
 			    SOLEH, 0,
 			    TAGLIST_END);
 
+	if (card->is_audigy)
+		sblive_writeptr(card, 0, A_DBG,  A_DBG_SINGLE_STEP);
+
 
 	pci_free_consistent(card->pci_dev, card->virtualpagetable.size, card->virtualpagetable.addr, card->virtualpagetable.dma_handle);
 	pci_free_consistent(card->pci_dev, card->silentpage.size, card->silentpage.addr, card->silentpage.dma_handle);
@@ -1017,7 +1219,7 @@
 	int ret;
 
 	if (pci_set_dma_mask(pci_dev, EMU10K1_DMA_MASK)) {
-		printk(KERN_ERR "emu10k1: architecture does not support 32bit PCI busmaster DMA\n");
+		printk(KERN_ERR "emu10k1: architecture does not support 31bit PCI busmaster DMA\n");
 		return -ENODEV;
 	}
 
@@ -1056,10 +1258,13 @@
 	pci_read_config_byte(pci_dev, PCI_REVISION_ID, &card->chiprev);
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_ID, &card->model);
 
-	printk(KERN_INFO "emu10k1: %s rev %d model 0x%x found, IO at 0x%04lx-0x%04lx, IRQ %d\n",
+	printk(KERN_INFO "emu10k1: %s rev %d model 0x%04x found, IO at 0x%04lx-0x%04lx, IRQ %d\n",
 		card_names[pci_id->driver_data], card->chiprev, card->model, card->iobase,
 		card->iobase + card->length - 1, card->irq);
 
+	if (pci_id->device == PCI_DEVICE_ID_CREATIVE_AUDIGY)
+		card->is_audigy = 1;
+
 	pci_read_config_dword(pci_dev, PCI_SUBSYSTEM_VENDOR_ID, &subsysvid);
 	card->is_aps = (subsysvid == EMU_APS_SUBID);
 
@@ -1074,6 +1279,12 @@
                 goto err_audio;
         }
 
+	ret = emu10k1_proc_init(card);
+	if(ret < 0) {
+		printk(KERN_ERR "emu10k1: cannot initialize proc directory\n");
+                goto err_proc;
+	}
+
 	ret = emu10k1_mixer_init(card);
 	if(ret < 0) {
 		printk(KERN_ERR "emu10k1: cannot initialize AC97 codec\n");
@@ -1106,6 +1317,9 @@
 	emu10k1_mixer_cleanup(card);
 
 err_mixer:
+	emu10k1_proc_cleanup(card);
+
+err_proc:
 	emu10k1_audio_cleanup(card);
 
 err_audio:
@@ -1121,6 +1335,7 @@
 	return ret;
 }
 
+	
 static void __devexit emu10k1_remove(struct pci_dev *pci_dev)
 {
 	struct emu10k1_card *card = pci_get_drvdata(pci_dev);
@@ -1130,6 +1345,7 @@
 	emu10k1_cleanup(card);
 	emu10k1_midi_cleanup(card);
 	emu10k1_mixer_cleanup(card);
+	emu10k1_proc_cleanup(card);
 	emu10k1_audio_cleanup(card);	
 	free_irq(card->irq, card);
 	release_region(card->iobase, card->length);
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/midi.h linux/drivers/sound/emu10k1/midi.h
--- linux-2.4.19-rc1/drivers/sound/emu10k1/midi.h	Fri Apr 21 18:08:45 2000
+++ linux/drivers/sound/emu10k1/midi.h	Sat Jun 29 17:33:41 2002
@@ -52,4 +52,27 @@
 	struct list_head mid_hdrs;
 };
 
+/* uncomment next line to use midi port on Audigy drive */
+//#define USE_AUDIGY_DRIVE_MIDI
+
+#ifdef USE_AUDIGY_DRIVE_MIDI
+#define A_MUDATA	A_MUDATA2
+#define A_MUCMD		A_MUCMD2
+#define A_MUSTAT	A_MUCMD2
+#define A_IPR_MIDITRANSBUFEMPTY	A_IPR_MIDITRANSBUFEMPTY2
+#define A_IPR_MIDIRECVBUFEMPTY	A_IPR_MIDIRECVBUFEMPTY2
+#define A_INTE_MIDITXENABLE	A_INTE_MIDITXENABLE2
+#define A_INTE_MIDIRXENABLE	A_INTE_MIDIRXENABLE2
+#else
+#define A_MUDATA	A_MUDATA1
+#define A_MUCMD		A_MUCMD1
+#define A_MUSTAT	A_MUCMD1
+#define A_IPR_MIDITRANSBUFEMPTY	A_IPR_MIDITRANSBUFEMPTY1
+#define A_IPR_MIDIRECVBUFEMPTY	A_IPR_MIDIRECVBUFEMPTY1
+#define A_INTE_MIDITXENABLE	A_INTE_MIDITXENABLE1
+#define A_INTE_MIDIRXENABLE	A_INTE_MIDIRXENABLE1
+#endif
+
+
 #endif /* _MIDI_H */
+
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/mixer.c linux/drivers/sound/emu10k1/mixer.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/mixer.c	Sat Jun 29 19:39:04 2002
+++ linux/drivers/sound/emu10k1/mixer.c	Sat Jun 29 17:33:41 2002
@@ -138,7 +138,7 @@
 	r = (r * 40 + 50) / 100;
 
 	for (i = 0; i < 5; i++)
-		sblive_writeptr(card, GPR_BASE + card->mgr.ctrl_gpr[SOUND_MIXER_BASS][0] + i, 0, bass_table[l][i]);
+		sblive_writeptr(card, (card->is_audigy ? A_GPR_BASE : GPR_BASE) + card->mgr.ctrl_gpr[SOUND_MIXER_BASS][0] + i, 0, bass_table[l][i]);
 }
 
 static void set_treble(struct emu10k1_card *card, int l, int r)
@@ -149,7 +149,7 @@
 	r = (r * 40 + 50) / 100;
 
 	for (i = 0; i < 5; i++)
-		sblive_writeptr(card, GPR_BASE + card->mgr.ctrl_gpr[SOUND_MIXER_TREBLE][0] + i , 0, treble_table[l][i]);
+		sblive_writeptr(card, (card->is_audigy ? A_GPR_BASE : GPR_BASE) + card->mgr.ctrl_gpr[SOUND_MIXER_TREBLE][0] + i , 0, treble_table[l][i]);
 }
 
 const char volume_params[SOUND_MIXER_NRDEVICES]= {
@@ -208,22 +208,26 @@
 		switch (ctl->cmd) {
 #ifdef DBGEMU
 		case CMD_WRITEFN0:
-			emu10k1_writefn0(card, ctl->val[0], ctl->val[1]);
+				
+			emu10k1_writefn0_2(card, ctl->val[0], ctl->val[1], ctl->val[2]);
 			break;
-
+#endif
 		case CMD_WRITEPTR:
-			if (ctl->val[1] >= 0x40 || ctl->val[0] > 0xff) {
+#ifdef DBGEMU
+			if (ctl->val[1] >= 0x40 || ctl->val[0] >= 0x1000) {
+#else
+			if (ctl->val[1] >= 0x40 || ctl->val[0] >= 0x1000 || ((ctl->val[0] < 0x100 ) &&
+		    //Any register allowed raw access goes here:
+				     (ctl->val[0] != A_SPDIF_SAMPLERATE) && (ctl->val[0] != A_DBG)
+			)
+				) {
+#endif
 				ret = -EINVAL;
 				break;
 			}
-
-			if ((ctl->val[0] & 0x7ff) > 0x3f)
-				ctl->val[1] = 0x00;
-
 			sblive_writeptr(card, ctl->val[0], ctl->val[1], ctl->val[2]);
-
 			break;
-#endif
+
 		case CMD_READFN0:
 			ctl->val[2] = emu10k1_readfn0(card, ctl->val[0]);
 
@@ -281,6 +285,7 @@
 		case CMD_GETRECSRC:
 			ctl->val[0] = card->wavein.recsrc;
 			ctl->val[1] = card->wavein.fxwc;
+
 			if (copy_to_user((void *) arg, ctl, sizeof(struct mixer_private_ioctl)))
 				ret = -EFAULT;
 
@@ -288,16 +293,13 @@
 
 		case CMD_GETVOICEPARAM:
 			ctl->val[0] = card->waveout.send_routing[0];
-			ctl->val[1] = card->waveout.send_a[0] | card->waveout.send_b[0] << 8 |
-			    	      card->waveout.send_c[0] << 16 | card->waveout.send_d[0] << 24;
+			ctl->val[1] = card->waveout.send_dcba[0];
 
 			ctl->val[2] = card->waveout.send_routing[1];
-			ctl->val[3] = card->waveout.send_a[1] | card->waveout.send_b[1] << 8 |
-				      card->waveout.send_c[1] << 16 | card->waveout.send_d[1] << 24;
+			ctl->val[3] = card->waveout.send_dcba[1];
 
 			ctl->val[4] = card->waveout.send_routing[2];
-			ctl->val[5] = card->waveout.send_a[2] | card->waveout.send_b[2] << 8 |
-				     card->waveout.send_c[2] << 16 | card->waveout.send_d[2] << 24;
+			ctl->val[5] = card->waveout.send_dcba[2];
 
 			if (copy_to_user((void *) arg, ctl, sizeof(struct mixer_private_ioctl)))
 				ret = -EFAULT;
@@ -305,23 +307,14 @@
 			break;
 
 		case CMD_SETVOICEPARAM:
-			card->waveout.send_routing[0] = ctl->val[0] & 0xffff;
-			card->waveout.send_a[0] = ctl->val[1] & 0xff;
-			card->waveout.send_b[0] = (ctl->val[1] >> 8) & 0xff;
-			card->waveout.send_c[0] = (ctl->val[1] >> 16) & 0xff;
-			card->waveout.send_d[0] = (ctl->val[1] >> 24) & 0xff;
-
-			card->waveout.send_routing[1] = ctl->val[2] & 0xffff;
-			card->waveout.send_a[1] = ctl->val[3] & 0xff;
-			card->waveout.send_b[1] = (ctl->val[3] >> 8) & 0xff;
-			card->waveout.send_c[1] = (ctl->val[3] >> 16) & 0xff;
-			card->waveout.send_d[1] = (ctl->val[3] >> 24) & 0xff;
-
-			card->waveout.send_routing[2] = ctl->val[4] & 0xffff;
-			card->waveout.send_a[2] = ctl->val[5] & 0xff;
-			card->waveout.send_b[2] = (ctl->val[5] >> 8) & 0xff;
-			card->waveout.send_c[2] = (ctl->val[5] >> 16) & 0xff;
-			card->waveout.send_d[2] = (ctl->val[5] >> 24) & 0xff;
+			card->waveout.send_routing[0] = ctl->val[0];
+			card->waveout.send_dcba[0] = ctl->val[1];
+
+			card->waveout.send_routing[1] = ctl->val[2];
+			card->waveout.send_dcba[1] = ctl->val[3];
+
+			card->waveout.send_routing[2] = ctl->val[4];
+			card->waveout.send_dcba[2] = ctl->val[5];
 
 			break;
 		
@@ -401,6 +394,7 @@
 					card->mgr.current_pages = page + 1;
 				}
 			}
+
 			break;
 
 		case CMD_SETGPR:
@@ -415,15 +409,20 @@
 		case CMD_SETCTLGPR:
 			addr = emu10k1_find_control_gpr(&card->mgr, (char *) ctl->val, (char *) ctl->val + PATCH_NAME_SIZE);
 			emu10k1_set_control_gpr(card, addr, *((s32 *)((char *) ctl->val + 2 * PATCH_NAME_SIZE)), 0);
+
 			break;
 
 		case CMD_SETGPOUT:
-			if (ctl->val[0] > 2 || ctl->val[1] > 1) {
+			if ( ((ctl->val[0] > 2) && (!card->is_audigy))
+			     || (ctl->val[0] > 15) || ctl->val[1] > 1) {
 				ret= -EINVAL;
 				break;
 			}
 
-			emu10k1_writefn0(card, (1 << 24) | (((ctl->val[0]) + 10) << 16) | HCFG, ctl->val[1]);
+			if (card->is_audigy)
+				emu10k1_writefn0(card, (1 << 24) | ((ctl->val[0]) << 16) | A_IOCFG, ctl->val[1]);
+			else
+				emu10k1_writefn0(card, (1 << 24) | (((ctl->val[0]) + 10) << 16) | HCFG, ctl->val[1]);
 			break;
 
 		case CMD_GETGPR2OSS:
@@ -488,24 +487,34 @@
 
 		case CMD_SETPASSTHROUGH:
 			card->pt.selected = ctl->val[0] ? 1 : 0;
+
 			if (card->pt.state != PT_STATE_INACTIVE)
 				break;
 
 			card->pt.spcs_to_use = ctl->val[0] & 0x07;
-			break;
 
+			break;
+	
 		case CMD_PRIVATE3_VERSION:
-			ctl->val[0]=PRIVATE3_VERSION;
+			ctl->val[0] = PRIVATE3_VERSION;	//private3 version
+			ctl->val[1] = MAJOR_VER;	//major driver version
+			ctl->val[2] = MINOR_VER;	//minor driver version
+			ctl->val[3] = card->is_audigy;	//1=card is audigy
+
+			if (card->is_audigy)
+				ctl->val[4]=emu10k1_readfn0(card, 0x18);
+
 			if (copy_to_user((void *) arg, ctl, sizeof(struct mixer_private_ioctl)))
 				ret = -EFAULT;
 			break;
 
 		case CMD_AC97_BOOST:
-			if(ctl->val[0])
+			if (ctl->val[0])
 				emu10k1_ac97_write(&card->ac97, 0x18, 0x0);	
 			else
 				emu10k1_ac97_write(&card->ac97, 0x18, 0x0808);
 			break;
+
 		default:
 			ret = -EINVAL;
 			break;
@@ -558,7 +567,8 @@
 
 				card->tankmem.size = size;
 
-				sblive_writeptr_tag(card, 0, TCB, (u32) card->tankmem.dma_handle, TCBS, size_reg, TAGLIST_END);
+				sblive_writeptr_tag(card, 0, TCB,(u32) card->tankmem.dma_handle, TCBS,(u32) size_reg, 
+TAGLIST_END);
 
 				emu10k1_writefn0(card, HCFG_LOCKTANKCACHE, 0);
 			}
@@ -626,7 +636,12 @@
 			mixer_info info;
 
 			strncpy(info.id, card->ac97.name, sizeof(info.id));
-			strncpy(info.name, "Creative SBLive - Emu10k1", sizeof(info.name));
+
+			if (card->is_audigy)
+				strncpy(info.name, "Audigy - Emu10k1", sizeof(info.name));
+			else
+				strncpy(info.name, "Creative SBLive - Emu10k1", sizeof(info.name));
+				
 			info.modify_counter = card->ac97.modcnt;
 
 			if (copy_to_user((void *)arg, &info, sizeof(info)))
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/passthrough.c linux/drivers/sound/emu10k1/passthrough.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/passthrough.c	Tue Oct  9 12:53:18 2001
+++ linux/drivers/sound/emu10k1/passthrough.c	Sat Jun 29 17:33:41 2002
@@ -112,7 +112,7 @@
 	return 0;
 }
 
-static int pt_setup(struct emu10k1_wavedevice *wave_dev)
+int emu10k1_pt_setup(struct emu10k1_wavedevice *wave_dev)
 {
 	u32 bits;
 	struct emu10k1_card *card = wave_dev->card;
@@ -158,7 +158,7 @@
 		pt->prepend_size = 0;
 		if (pt->buf == NULL)
 			return -ENOMEM;
-		pt_setup(wave_dev);
+		emu10k1_pt_setup(wave_dev);
 	}
 	if (pt->prepend_size) {
 		int needed = PT_BLOCKSIZE - pt->prepend_size;
@@ -211,13 +211,14 @@
 
 	if (pt->state != PT_STATE_INACTIVE) {
 		DPF(2, "digital pass-through stopped\n");
-		sblive_writeptr(card, GPR_BASE + pt->enable_gpr, 0, 0);
+		sblive_writeptr(card, (card->is_audigy ? A_GPR_BASE : GPR_BASE) + pt->enable_gpr, 0, 0);
 		for (i = 0; i < 3; i++) {
                         if (pt->spcs_to_use & (1 << i))
 				sblive_writeptr(card, SPCS0 + i, 0, pt->old_spcs[i]);
 		}
 		pt->state = PT_STATE_INACTIVE;
-		kfree(pt->buf);
+		if(pt->buf)
+			kfree(pt->buf);
 	}
 }
 
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/passthrough.h linux/drivers/sound/emu10k1/passthrough.h
--- linux-2.4.19-rc1/drivers/sound/emu10k1/passthrough.h	Tue Oct  9 12:53:18 2001
+++ linux/drivers/sound/emu10k1/passthrough.h	Sat Jun 29 17:33:41 2002
@@ -63,7 +63,36 @@
 	spinlock_t lock;
 };
 
+/*
+  Passthrough can be done in two methods:
+
+  Method 1 : tram
+     In original emu10k1, we couldn't bypass the sample rate converters. Even at 48kHz
+     (the internal sample rate of the emu10k1) the samples would get messed up.
+     To over come this, samples are copied into the tram and a special dsp patch copies
+     the samples out and generates interrupts when a block has finnished playing.
+
+  Method 2 : Interpolator bypass
+
+     Creative fixed the sample rate convert problem in emu10k1 rev 7 and higher
+     (including the emu10k2 (audigy)). This allows us to use the regular, and much simpler
+     playback method. 
+
+
+  In both methods, dsp code is used to mux audio and passthrough. This ensures that the spdif
+  doesn't receive audio and pasthrough data at the same time. The spdif flag SPCS_NOTAUDIODATA
+  is set to tell 
+
+ */
+
+// emu10k1 revs greater than or equal to 7 can use method2
+
+#define USE_PT_METHOD2  (card->is_audigy)
+#define USE_PT_METHOD1	!USE_PT_METHOD2
+
 ssize_t emu10k1_pt_write(struct file *file, const char *buf, size_t count);
+
+int emu10k1_pt_setup(struct emu10k1_wavedevice *wave_dev);
 void emu10k1_pt_stop(struct emu10k1_card *card);
 void emu10k1_pt_waveout_update(struct emu10k1_wavedevice *wave_dev);
 
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/recmgr.c linux/drivers/sound/emu10k1/recmgr.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/recmgr.c	Sat Jun 29 19:39:04 2002
+++ linux/drivers/sound/emu10k1/recmgr.c	Sat Jun 29 17:33:41 2002
@@ -69,7 +69,7 @@
 		DPF(2, "recording source: AC97\n");
 		buffer->sizereg = ADCBS;
 		buffer->addrreg = ADCBA;
-		buffer->idxreg = ADCIDX_IDX;
+		buffer->idxreg = card->is_audigy ? A_ADCIDX_IDX : ADCIDX_IDX;
 
 		switch (wiinst->format.samplingrate) {
 		case 0xBB80:
@@ -90,21 +90,27 @@
 		case 0x3E80:
 			buffer->adcctl = ADCCR_SAMPLERATE_16;
 			break;
+		// FIXME: audigy supports 12kHz recording
+		/*
+		case ????:
+			buffer->adcctl = A_ADCCR_SAMPLERATE_12;
+			break;
+		*/
 		case 0x2B11:
-			buffer->adcctl = ADCCR_SAMPLERATE_11;
+			buffer->adcctl = card->is_audigy ? A_ADCCR_SAMPLERATE_11 : ADCCR_SAMPLERATE_11;
 			break;
 		case 0x1F40:
-			buffer->adcctl = ADCCR_SAMPLERATE_8;
+			buffer->adcctl = card->is_audigy ? A_ADCCR_SAMPLERATE_8 : ADCCR_SAMPLERATE_8;
 			break;
 		default:
 			BUG();
 			break;
 		}
-
-		buffer->adcctl |= ADCCR_LCHANENABLE;
+		
+		buffer->adcctl |= card->is_audigy ? A_ADCCR_LCHANENABLE : ADCCR_LCHANENABLE;
 
 		if (wiinst->format.channels == 2)
-			buffer->adcctl |= ADCCR_RCHANENABLE;
+			buffer->adcctl |= card->is_audigy ? A_ADCCR_RCHANENABLE : ADCCR_RCHANENABLE;
 
 		break;
 
@@ -130,9 +136,9 @@
 		break;
 	}
 
-	DPD(2, "bus addx: %#x\n", (u32) buffer->dma_handle);
+	DPD(2, "bus addx: %#lx\n", (unsigned long) buffer->dma_handle);
 
-	sblive_writeptr(card, buffer->addrreg, 0, (u32) buffer->dma_handle);
+	sblive_writeptr(card, buffer->addrreg, 0, (u32)buffer->dma_handle);
 
 	return;
 }
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/voicemgr.c linux/drivers/sound/emu10k1/voicemgr.c
--- linux-2.4.19-rc1/drivers/sound/emu10k1/voicemgr.c	Sat Jun 29 19:39:04 2002
+++ linux/drivers/sound/emu10k1/voicemgr.c	Sat Jun 29 17:33:41 2002
@@ -32,6 +32,34 @@
 #include "voicemgr.h"
 #include "8010.h"
 
+#define PITCH_48000 0x00004000
+#define PITCH_96000 0x00008000
+#define PITCH_85000 0x00007155
+#define PITCH_80726 0x00006ba2
+#define PITCH_67882 0x00005a82
+#define PITCH_57081 0x00004c1c
+
+u32 emu10k1_select_interprom(struct emu10k1_card *card, struct emu_voice *voice)
+{
+	if(voice->pitch_target==PITCH_48000)
+		return CCCA_INTERPROM_0;
+	else if(voice->pitch_target<PITCH_48000)
+		return CCCA_INTERPROM_1;
+	else  if(voice->pitch_target>=PITCH_96000)
+		return CCCA_INTERPROM_0;
+	else  if(voice->pitch_target>=PITCH_85000)
+		return CCCA_INTERPROM_6;
+	else  if(voice->pitch_target>=PITCH_80726)
+		return CCCA_INTERPROM_5;
+	else  if(voice->pitch_target>=PITCH_67882)
+		return CCCA_INTERPROM_4;
+	else  if(voice->pitch_target>=PITCH_57081)
+		return CCCA_INTERPROM_3;
+	else  
+		return CCCA_INTERPROM_2;
+}
+
+
 /**
  * emu10k1_voice_alloc_buffer -
  *
@@ -216,17 +244,25 @@
 	voice->start += start;
 
 	for (i = 0; i < (voice->flags & VOICE_FLAGS_STEREO ? 2 : 1); i++) {
-		sblive_writeptr(card, FXRT, voice->num + i, voice->params[i].send_routing << 16);
+		if (card->is_audigy){
+			sblive_writeptr(card, A_FXRT1, voice->num + i, voice->params[i].send_routing);
+			sblive_writeptr(card, A_FXRT2, voice->num + i, voice->params[i].send_routing2);
+			sblive_writeptr(card,  A_SENDAMOUNTS, voice->num + i, voice->params[i].send_hgfe);
+		} else {
+			sblive_writeptr(card, FXRT, voice->num + i, voice->params[i].send_routing << 16);
+		}
 
 		/* Stop CA */
 		/* Assumption that PT is already 0 so no harm overwriting */
-		sblive_writeptr(card, PTRX, voice->num + i, (voice->params[i].send_a << 8) | voice->params[i].send_b);
+		sblive_writeptr(card, PTRX, voice->num + i, ((voice->params[i].send_dcba & 0xff) << 8)
+				| ((voice->params[i].send_dcba & 0xff00) >> 8));
 
 		sblive_writeptr_tag(card, voice->num + i,
 				/* CSL, ST, CA */
-				    DSL, voice->endloop | (voice->params[i].send_d << 24),
-				    PSST, voice->startloop | (voice->params[i].send_c << 24),
-				    CCCA, (voice->start) | CCCA_INTERPROM_0 | ((voice->flags & VOICE_FLAGS_16BIT) ? 0 : CCCA_8BITSELECT),
+				    DSL, voice->endloop | (voice->params[i].send_dcba & 0xff000000),
+				    PSST, voice->startloop | ((voice->params[i].send_dcba & 0x00ff0000) << 8),
+				    CCCA, (voice->start) |  emu10k1_select_interprom(card,voice) |
+				        ((voice->flags & VOICE_FLAGS_16BIT) ? 0 : CCCA_8BITSELECT),
 				    /* Clear filter delay memory */
 				    Z1, 0,
 				    Z2, 0,
diff -urNX /src/dontdiff linux-2.4.19-rc1/drivers/sound/emu10k1/voicemgr.h linux/drivers/sound/emu10k1/voicemgr.h
--- linux-2.4.19-rc1/drivers/sound/emu10k1/voicemgr.h	Mon Feb 25 13:38:06 2002
+++ linux/drivers/sound/emu10k1/voicemgr.h	Sat Jun 29 19:24:28 2002
@@ -48,11 +48,13 @@
 	/* FX bus amount send */
 
 	u32 send_routing;
+	// audigy only:
+	u32 send_routing2;
+
+	u32 send_dcba;
+	// audigy only:
+	u32 send_hgfe;
 
-	u32 send_a;
-	u32 send_b;
-	u32 send_c;
-	u32 send_d;
 
 	u32 initial_fc;
 	u32 fc_target;
