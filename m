Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRB1Sb1>; Wed, 28 Feb 2001 13:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129167AbRB1SbR>; Wed, 28 Feb 2001 13:31:17 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:29569 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S129166AbRB1SbH>; Wed, 28 Feb 2001 13:31:07 -0500
Date: Wed, 28 Feb 2001 10:31:01 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
cc: "William A. Stein" <was@math.harvard.edu>
Subject: via 686a audio driver rate locked at 48Khz
Message-ID: <Pine.LNX.4.30.0102280937520.6854-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a system with an MSI-6321 motherboard with the Via 686a
southbridge, and I'm having a little trouble with the via82cxxx_audio
sound driver.  The stock 2.4.2 driver produces only a rhythmic a buzzing
sound.  I saw a patch here a week or two ago for 'rate locking', so I
tried that (it didn't apply cleanly to 2.4.2, but I think I applied it by
hand correctly).

That patch makes some things work fine (e.g. playing a .wav file), but
others sound lousy (e.g. playing a 44.1KHz mp3 with xmms).  Am I correct
in thinking that it sounds lousy because of the translation from 44.1KHz
sampling to 48KHz sampling?  If so, is there any hope of supporting
Variable Rate on this hardware?

Below is copious debugging output, although not the output of
via-audio-diag, as I could not find it on sourceforge (and the gtf.org URL
is gone).

Thanks,
Wayne



(1) The relevant part of lspci -n -x -vvv:

00:07.5 Class 0401: 1106:3058 (rev 20)
	Subsystem: 1106:3058
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at 9c00 [size=256]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at a400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 58 30 01 00 10 02 20 00 01 04 00 00 00 00
10: 01 9c 00 00 01 a0 00 00 01 a4 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 58 30
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 03 00 00



(2) The patch I used (which also enables VIA_DEBUG and VIA_PROC_FS):

--- /usr/local/src/linux-2.4.2/drivers/sound/via82cxxx_audio.c.orig	Tue Feb  6 22:04:12 2001
+++ /usr/local/src/linux-2.4.2/drivers/sound/via82cxxx_audio.c	Wed Feb 28 10:07:01 2001
@@ -41,7 +41,10 @@
 #include <asm/semaphore.h>


-#undef VIA_DEBUG	/* define to enable debugging output and checks */
+/* #undef VIA_DEBUG	/* define to enable debugging output and checks */
+#define VIA_DEBUG
+#define VIA_PROC_FS 1
+
 #ifdef VIA_DEBUG
 /* note: prints function name for you */
 #define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
@@ -282,6 +285,8 @@

 	unsigned rev_h : 1;

+	int locked_rate : 1;
+
 	struct semaphore syscall_sem;
 	struct semaphore open_sem;

@@ -508,10 +513,16 @@
 static int via_set_rate (struct ac97_codec *ac97,
 			 struct via_channel *chan, unsigned rate)
 {
+	struct via_info *card = ac97->private_data;
 	int rate_reg;

 	DPRINTK ("ENTER, rate = %d\n", rate);

+	if (card->locked_rate) {
+		chan->rate = 48000;
+		goto out;
+	}
+
 	if (rate > 48000)		rate = 48000;
 	if (rate < 4000) 		rate = 4000;

@@ -535,6 +546,13 @@
 	 */
 	chan->rate = via_ac97_read_reg (ac97, rate_reg);

+	if (chan->rate == 0) {
+		card->locked_rate = 1;
+		chan->rate = 48000;
+		printk (KERN_WARNING PFX "Codec rate locked at 48Khz\n");
+	}
+
+out:
 	DPRINTK ("EXIT, returning rate %d Hz\n", chan->rate);
 	return chan->rate;
 }
@@ -1421,15 +1439,19 @@
 	/* WARNING: this line is magic.  Remove this
 	 * and things break. */
 	/* enable variable rate, variable rate MIC ADC */
-	tmp16 = via_ac97_read_reg (&card->ac97, 0x2A);
-	via_ac97_write_reg (&card->ac97, 0x2A, tmp16 | (1<<0));
-
-	pci_read_config_byte (pdev, VIA_ACLINK_CTRL, &tmp8);
-	if ((tmp8 & (VIA_CR41_AC97_ENABLE | VIA_CR41_AC97_RESET)) == 0) {
-		printk (KERN_ERR PFX "cannot enable AC97 controller, aborting\n");
-		DPRINTK ("EXIT, tmp8=%X, returning -ENODEV\n", tmp8);
-		return -ENODEV;
-	}
+ 	/*
+ 	 * If we cannot enable VRA, we have a locked-rate codec.
+ 	 * We try again to enable VRA before assuming so, however.
+ 	 */
+ 	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+ 	if ((tmp16 & 1) == 0) {
+ 		via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
+ 		tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+ 		if ((tmp16 & 1) == 0) {
+ 			card->locked_rate = 1;
+ 			printk (KERN_WARNING PFX "Codec rate locked at 48Khz\n");
+ 		}
+ 	}

 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
@@ -1478,8 +1500,8 @@
 	}

 	/* enable variable rate, variable rate MIC ADC */
-	tmp16 = via_ac97_read_reg (&card->ac97, 0x2A);
-	via_ac97_write_reg (&card->ac97, 0x2A, tmp16 | (1<<0));
+	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+	via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);

 	DPRINTK ("EXIT, returning 0\n");
 	return 0;



(3) Kernel output from loading the patched via82cxxx_audio.o (although
this was not the first time I loaded the module since the last reboot):

init_via82cxxx_audio: ENTER
via_init_proc: ENTER
via_init_proc: EXIT, returning 0
via_init_one: ENTER
Via 686a audio driver 1.1.14a
via_ac97_init: ENTER
via_ac97_reset: ENTER
via_ac97_reset: PCI config: 01 CC 40 1C 00 05
via_ac97_reset: regs==00 00 00 00000000 00000000 00AC0000 00000000
via_ac97_read_reg: ENTER
via_ac97_read_reg: EXIT, success, data=0x22a0000, retval=0x0
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_read_reg: ENTER
via_ac97_read_reg: EXIT, success, data=0x22a0000, retval=0x0
via82cxxx: Codec rate locked at 48Khz
via_ac97_reset: EXIT, returning 0
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_wait_idle: ENTER/EXIT
via_ac97_read_reg: ENTER
via_ac97_read_reg: EXIT, success, data=0x2006c00, retval=0x6c00
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_read_reg: ENTER
via_ac97_read_reg: EXIT, success, data=0x23c0000, retval=0x0
via_ac97_read_reg: ENTER
via_ac97_read_reg: EXIT, success, data=0x27c5745, retval=0x5745
via_ac97_read_reg: ENTER
via_ac97_read_reg: EXIT, success, data=0x27e4301, retval=0x4301
ac97_codec: AC97 Audio codec, id: 0x5745:0x4301 (Unknown)
via_ac97_read_reg: ENTER
via_ac97_read_reg: EXIT, success, data=0x2006c00, retval=0x6c00
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_read_reg: ENTER
via_ac97_read_reg: EXIT, success, data=0x2021f1f, retval=0x1f1f
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_read_reg: ENTER
via_ac97_read_reg: EXIT, success, data=0x22a0000, retval=0x0
via_ac97_write_reg: ENTER
via_ac97_write_reg: EXIT
via_ac97_init: EXIT, returning 0
via_dsp_init: ENTER
via_stop_everything: ENTER
via_stop_everything: EXIT
via_dsp_init: EXIT, returning 0
via_card_init_proc: ENTER
via_card_init_proc: EXIT, returning 0
via_interrupt_init: ENTER
via_interrupt_disable: ENTER
via_interrupt_disable: EXIT
via_interrupt_init: EXIT, returning 0
via82cxxx: IRQ fixup, 0x3C==0x12
via_init_one: new 0x3c==0x12
via82cxxx: board #1 at 0xAC00, IRQ 18
via_init_one: EXIT, returning 0
init_via82cxxx_audio: EXIT, returning 0



(4) /proc/driver/via/0/ac97:

Vendor name      : Unknown
Vendor id        : 5745 4301
AC97 Version     : 2.0 or later
Capabilities     :
DAC resolutions  : -16-bit-
ADC resolutions  : -16-bit-
3D enhancement   : Reserved 27
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
MIC select       : MIC1
ADC/DAC loopback : off
Ext Capabilities :
Front DAC rate   : 0



(5) /proc/driver/via/0/info:

VIA 82Cxxx Audio driver 1.1.14a

Via 82Cxxx PCI registers:

40  Codec Ready: yes
    Codec Low-power: no
    Secondary Codec Ready: no

41  Interface Enable: enable
    De-Assert Reset: yes
    Force SYNC high: no
    Force SDO high: no
    Variable Sample Rate On-Demand Mode: enable
    SGD Read Channel PCM Data Out: enable
    FM Channel PCM Data Out: disable
    SB PCM Data Out: disable

42  Game port enabled: no
    SoundBlaster enabled: no
    FM enabled: no
    MIDI enabled: no

44  AC-Link Interface Access: no
    Secondary Codec Support: no


