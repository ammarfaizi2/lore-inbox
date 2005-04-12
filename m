Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVDMEh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVDMEh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVDMEeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 00:34:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:27633 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262553AbVDLS7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:59:25 -0400
From: Peter Missel <peter.missel@onlinehome.de>
To: "Tobias van Dyk" <vdykt@icon.co.za>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] saa7134: Add OEM version of already supported card
Date: Tue, 12 Apr 2005 20:58:52 +0200
User-Agent: KMail/1.8
References: <001501c53ebd$0ca61840$0700000a@pentium4> <200504121734.21666.peter.missel@onlinehome.de> <001901c53f8c$811beef0$0700000a@pentium4>
In-Reply-To: <001901c53f8c$811beef0$0700000a@pentium4>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504122058.53245.peter.missel@onlinehome.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:eea5ddcdb9e55c285e39b42944f081ba
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias!

Thanks for checking the hardware. It is the same card, 
the same configuration on the GPx resistors, 
just a different subsystem vendor ID stored in its EEPROM.

The below patch is all it should take to have it auto-detected. 
The driver will say it's a FlyTV, simply because the name strings
are stored with the card design data, not the device ID data.

Maintainers: NB, this is my 3rd patch over 2.6.12-rc2 on this file. 
The patches don't overlap.

Peter

--- linux-2.6.12-rc2/drivers/media/video/saa7134/saa7134-cards.c	2005-04-09 12:01:47.000000000 +0200
+++ video4linux/saa7134-cards.c	2005-04-12 20:56:18.000000000 +0200

@@ -1628,11 +1628,17 @@
         },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
-		.subvendor    = 0x5168,
+		.subvendor    = 0x5168,	/* Animation Technologies (LifeView) */
 		.subdevice    = 0x0214, /* Standard PCI, LR214WF */
 		.driver_data  = SAA7134_BOARD_FLYTVPLATINUM_FM,
         },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x1489, /* KYE */
+		.subdevice    = 0x0214, /* Genius VideoWonder ProTV */
+		.driver_data  = SAA7134_BOARD_FLYTVPLATINUM_FM, /* is an LR214WF actually */
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
 		.subvendor    = 0x16be,
 		.subdevice    = 0x0003,

On Tuesday 12 April 2005 20:21, Tobias van Dyk wrote:
> Peter here is the info:
> Things I'd like you to check:
>
> * There should be a small white sticker on the top side, near the
> audio/video
> connectors, with an 8-digit hex number on. LifeView stick the card's
> subsystem ID there. That should read 14890214 (or 02141489, can't actually
> remember the ordering) for yours, further evidence that it's jumped off the
> same production line. (Does the fine print say "LR214F" anywhere on the
> card?)
> ===============>
> Yes sticker is 02141489
> PCB has LR214 REV D written at bottom righthand side
>
> * On the right edge of the card, there is a row of tiny configuration
> resistors labelled "GP1" through "GP7". I'd like you to write down which
> ones
> are populated and which ones are absent. Gerd and I assume that drivers may
> detect the finer details of a card's configuration from there, e.g. absence
> or presence of FM radio feature, so we need to collect how they're
> configured
> for the various versions of each LifeView card design.
> ==============>
> Surface mount R's:
> GP1 and GP2 no resistors soldered
> GP3 GP4 GP5 GP6 GP7 has soldered resistors
>
> The tuning offset - I did a clean edit and compile - I do get a signal
> at -0.15 MHz below the true frequency but it is much weaker (distorted) -
> the one at -3.95 MHz is stronger - I cannot think why the two cards should
> be different is this respect. I tried to start the FMTuner "clean" and
> after TV settings - it does not make a difference. TV norm is PAL-I
>
> Regards
> Tobias
> ----- Original Message -----
> From: "Peter Missel" <peter.missel@onlinehome.de>
> To: <video4linux-list@redhat.com>
> Cc: "Tobias van Dyk" <vdykt@icon.co.za>
> Sent: Tuesday, April 12, 2005 5:34 PM
> Subject: Re: Genius VideoWonder ProTV SAA7135 and TDA8275 Working
>
> > Tobias,
> >
> > on the audio offset, that's odd, it's definitely just .15 MHz for me.
> > What TV
> > norm are you on? Maybe there's something the tuner code forgets to adjust
> > when switching from TV to radio or somesuch problem.
> >
> > I've had a look around the web, and this card of yours indeed looks
> > EXACTLY
> > like the FlyTV Platinum FM - even more so from the dmesg capture you
> > gave. It
> > seems to be like I suspected, same thing with a different subsystem
> > vendor ID
> > (but even the same subsystem ID 0x0214).
> >
> > Things I'd like you to check:
> >
> > * There should be a small white sticker on the top side, near the
> > audio/video
> > connectors, with an 8-digit hex number on. LifeView stick the card's
> > subsystem ID there. That should read 14890214 (or 02141489, can't
> > actually remember the ordering) for yours, further evidence that it's
> > jumped off the
> > same production line. (Does the fine print say "LR214F" anywhere on the
> > card?)
> >
> > * On the right edge of the card, there is a row of tiny configuration
> > resistors labelled "GP1" through "GP7". I'd like you to write down which
> > ones
> > are populated and which ones are absent. Gerd and I assume that drivers
> > may
> > detect the finer details of a card's configuration from there, e.g.
> > absence
> > or presence of FM radio feature, so we need to collect how they're
> > configured
> > for the various versions of each LifeView card design.
> >
> > Anyone happen to have a FlyTV Platinum w/o FM? Only $38 from newegg, if
> > someone in the US wants to contribute (and end up with a really nice TV
> > card) ...
> >
> > The above checked and sorted, we can make a simple addition to the
> > saa7134 card database, attributing this alternate subsystem ID with the
> > given implementation of the FlyTV Pl.FM (so we don't have to duplicate
> > code and data all over the place).
> >
> > regards,
> > Peter
> >
> > On Tuesday 12 April 2005 08:40, Tobias van Dyk wrote:
> >> Peter I thank you for all your input!
> >>
> >> system: Kernel 2.6.11.7 on Mandrake 10.1
> >>
> >> 4 MHz offset - it is actually -3.95 MHz for example:
> >> 101.5 MHz shows as 97.55
> >>  94.2 MHz shows as 90.25
> >> I do not know why it is also not -0.15 MHz - I will do a clean snapshot
> >> edit again over the weekend
> >>
> >> Genius/Kye Videowonder Pro TV Product page is here:
> >> http://www.geniusnet.com.tw/product/product-1.asp?pdtno=534
> >>
> >> lspci -v ================>
> >> 02:02.0 Multimedia controller: Philips Semiconductors SAA7133
> >> Audio+video broadcast decoder (rev f0)
> >>         Subsystem: KYE Systems Corporation: Unknown device 0214
> >>         Flags: bus master, medium devsel, latency 32, IRQ 11
> >>         Memory at de000000 (32-bit, non-prefetchable) [size=2K]
> >>         Capabilities: [40] Power Management version 2
> >> lspci -vn ================>
> >> 02:02.0 Class 0480: 1131:7133 (rev f0)
> >>         Subsystem: 1489:0214
> >>         Flags: bus master, medium devsel, latency 32, IRQ 11
> >>         Memory at de000000 (32-bit, non-prefetchable) [size=2K]
> >>         Capabilities: [40] Power Management version 2
> >> lsmod | grep saa ============>
> >> saa7134               102516  0
> >> video_buf              16676  1 saa7134
> >> v4l2_common             4512  1 saa7134
> >> v4l1_compat            12964  1 saa7134
> >> ir_common               5892  1 saa7134
> >> videodev                7264  1 saa7134
> >> soundcore               7104  2 saa7134,snd
> >> i2c_core               17808  6
> >> tuner,saa7134,w83627hf,eeprom,i2c_sensor,i2c_isa
> >> dmesg after modprobe ================>
> >> saa7130/34: v4l2 driver version 0.2.12 loaded
> >> saa7130/34: snapshot date 2005-04-04
> >> saa7133[0]: found at 0000:02:02.0, rev: 240, irq: 11, latency: 32, mmio:
> >> 0xde000000
> >> saa7133[0]: subsystem: 1489:0214, board: LifeView FlyTV Platinum FM
> >> [card=54,insmod option]
> >> saa7133[0]: board init: gpio is 21c00
> >> saa7133[0]: dsp access wait timeout [bit=WRR]
> >> saa7133[0]: dsp access wait timeout [bit=WRR]
> >> saa7133[0]: i2c eeprom 00: 89 14 14 02 10 28 ff ff ff ff ff ff ff ff ff
> >> ff
> >> saa7133[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >> ff
> >> saa7133[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >> ff
> >> saa7133[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >> ff
> >> tuner 1-004b: chip found @ 0x96 (saa7133[0])
> >> tuner 1-004b: tuner: type set to tda8290+75
> >> saa7133[0]: registered device video0 [v4l2]
> >> saa7133[0]: registered device vbi0
> >> saa7133[0]: registered device radio0
> >>
> >> ========================================================================
> >>=== = DScaler's RegSpy Dumps (State changes for FMRadio/AVInput/AirTV
> >> given at end):
> >> SAA7133 Card [0]:
> >> Vendor ID:           0x1131
> >> Device ID:           0x7133
> >> Subsystem ID:        0x02141489
> >> ========================================================================
> >>=== ====== SAA7133 Card - Register Dump:
> >> SAA7134_GPIO_GPMODE:             80010000   (10000000 00000001 00000000
> >> 00000000)
> >> SAA7134_GPIO_GPSTATUS:           00031c00   (00000000 00000011 00011100
> >> 00000000)
> >> SAA7134_ANALOG_IN_CTRL1:         81         (10000001)
> >> SAA7134_ANALOG_IO_SELECT:        90         (10010000)
> >> SAA7134_AUDIO_CLOCK:             90909090   (10010000 10010000 10010000
> >> 10010000)
> >> SAA7134_VIDEO_PORT_CTRL0:        00000000   (00000000 00000000 00000000
> >> 00000000)
> >> SAA7134_VIDEO_PORT_CTRL4:        00000000   (00000000 00000000 00000000
> >> 00000000)
> >> SAA7134_VIDEO_PORT_CTRL8:        00         (00000000)
> >> SAA7134_I2S_OUTPUT_SELECT:       00         (00000000)
> >> SAA7134_I2S_OUTPUT_FORMAT:       00         (00000000)
> >> SAA7134_I2S_OUTPUT_LEVEL:        00         (00000000)
> >> SAA7134_I2S_AUDIO_OUTPUT:        00         (00000000)
> >> SAA7134_TS_PARALLEL:             00         (00000000)
> >> SAA7134_TS_PARALLEL_SERIAL:      00         (00000000)
> >> SAA7134_TS_SERIAL0:              00         (00000000)
> >> SAA7134_TS_SERIAL1:              00         (00000000)
> >> SAA7134_TS_DMA0:                 00         (00000000)
> >> SAA7134_TS_DMA1:                 00         (00000000)
> >> SAA7134_TS_DMA2:                 00         (00000000)
> >> SAA7134_SPECIAL_MODE:            01         (00000001)
> >> 0x140:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >> 0x144:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >> 0x148:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >> 0x14C:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >> 0x150:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >> 0x154:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >> 0x158:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >> 0x164:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >> 0x16C:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >> 0x174:                           00000000   (00000000 00000000 00000000
> >> 00000000)
> >>
> >> AirTV setting ===============>
> >> SAA7134_GPIO_GPMODE:             80010000   (10000000 00000001 00000000
> >> 00000000)
> >> SAA7134_GPIO_GPSTATUS:           00031c00   (00000000 00000011 00011100
> >> 00000000)
> >> SAA7134_ANALOG_IN_CTRL1:         81         (10000001)
> >> SAA7134_ANALOG_IO_SELECT:        90         (10010000)
> >> SAA7134_AUDIO_CLOCK:             90909090   (10010000 10010000 10010000
> >> 10010000)
> >> FMRadio setting =============>
> >> SAA7134_GPIO_GPMODE:             80010000   (10000000 00000001 00000000
> >> 00000000)
> >> SAA7134_GPIO_GPSTATUS:           00021c00   (00000000 00000010 00011100
> >> 00000000)
> >> SAA7134_ANALOG_IN_CTRL1:         81         (10000001)
> >> SAA7134_ANALOG_IO_SELECT:        90         (10010000)
> >> SAA7134_AUDIO_CLOCK:             90909090   (10010000 10010000 10010000
> >> 10010000)
> >> AVInput setting =============>
> >> SAA7134_GPIO_GPMODE:             80010000   (10000000 00000001 00000000
> >> 00000000)
> >> SAA7134_GPIO_GPSTATUS:           00031c00   (00000000 00000011 00011100
> >> 00000000)
> >> SAA7134_ANALOG_IN_CTRL1:         83         (10000011)
> >> SAA7134_ANALOG_IO_SELECT:        90         (10010000)
> >> SAA7134_AUDIO_CLOCK:             90909090   (10010000 10010000 10010000
> >> 10010000)
> >> ----- Original Message -----
> >> From: "Peter Missel" <peter.missel@onlinehome.de>
> >> To: <video4linux-list@redhat.com>
> >> Sent: Monday, April 11, 2005 11:43 PM
> >> Subject: Re: Genius VideoWonder ProTV SAA7135 and TDA8275 Working
> >>
> >> > Hmmm ... I just got a normal radio unit for comparison, and found that
> >> > we
> >> > aren't actually 4 MHz off - I misidentified the station because there
> >> > happens
> >> > to be one with quite similar a night program exactly there at +4MHz
> >> > from
> >> > my
> >> > favorite ...
> >> >
> >> > With the station sending on 93.4 MHz actually, I get best tunage on
> >> > the FlyTV
> >> > when the tuner module thinks it tuned to 93.25. A couple more stations
> >> > revealed:
> >> >
> >> > (tuner freq) -> (actual station freq)
> >> >
> >> > 87.75 -> 87.9
> >> > 93.25 -> 93.4
> >> > 96.55 -> 96.7
> >> > 99.85 -> 100.0
> >> >
> >> > To me it looks more like we're tuning to about .15 MHz higher than the
> >> > application asks for.
> >> >
> >> > good night - Peter
> >> >
> >> > On Monday 11 April 2005 22:51, Peter Missel wrote:
> >> >> Hi Tobias!
> >> >>
> >> >> Yes indeed, radio IS working on the FlyTV Platinum FM too - excellent
> >> >> observation on the 4-MHz offset there! "radio" applet indeed displays
> >> >> "mono" but what I have here (a strong local station) clearly does
> >> >> play in stereo.
> >> >>
> >> >> There seems to be something amiss in the audio handling on saa7135 in
> >> >> general, since in TV modes, I can't switch audio modes
> >> >> (stereo/mono/lang1/lang2) either.
> >> >>
> >> >> Could you provide us with more detail about that "Genius" card? (With
> >> >> LifeView shifting most of their units feeding badge engineering OEMs,
> >> >> there's some chance it is the same card anyway.)
> >> >>
> >> >> In the meantime, excuse me while I try to find that 4-MHz offset ...
> >> >>
> >> >> regards,
> >> >> Peter
> >> >>
> >> >> On Monday 11 April 2005 19:36, Tobias van Dyk wrote:
> >> >> > Genius VideoWonder ProTV with SAA7135 and TDA8275 Tuner is working
> >> >> > 99%
> >> >> > (FM Tiuner, TV Tuner and video inputs), with modprobe saa7134
> >> >> > card=54
> >> >> > tuner=54 after the GPIO changes suggested by Peter to the LifeView
> >> >> > FlyTV
> >> >> > Platinum. His changes were applied to the 4 April snapshot
> >> >> > video4linux-20050403-221421.tar.gz
> >> >> >
> >> >> > What is not working 100% is the FMTuner (tested using GnomeRadio) -
> >> >> > it
> >> >> > has a -4 MHz offset in its tuning and all stations is reported as
> >> >> > mono
> >> >> > only
> >> >> >
> >> >> > The working relevant section in saa7134-cards.c is:
> >> >> >
> >> >> > [SAA7134_BOARD_FLYTVPLATINUM_FM] = {
> >> >> >   /* LifeView FlyTV Platinum FM (LR214WF) */
> >> >> >   /* "Peter Missel */
> >> >> >   .name           = "LifeView FlyTV Platinum FM",
> >> >> >   .audio_clock    = 0x00200000,
> >> >> >   .tuner_type     = TUNER_PHILIPS_TDA8290,
> >> >> >   .gpiomask       = 0x1E000, /* Set GP16, unused 15,14,13 to Output
> >> >> > */
> >> >> >   .inputs         = {{
> >> >> >    .name = name_tv,
> >> >> >    .vmux = 1,
> >> >> >    .amux = TV,
> >> >> >    .gpio = 0x10000, /* GP16=1 selects TV input */
> >> >> >    .tv   = 1,
> >> >> >                 },{
> >> >> > /*   .name = name_tv_mono,
> >> >> >    .vmux = 1,
> >> >> >    .amux = LINE2,
> >> >> >    .gpio = 0x0000,
> >> >> >    .tv   = 1,
> >> >> >   },{
> >> >> > */   .name = name_comp1, /* Composite signal on S-Video input */
> >> >> >    .vmux = 0,
> >> >> >    .amux = LINE2,
> >> >> > //   .gpio = 0x4000,
> >> >> >   },{
> >> >> >    .name = name_comp2, /* Composite input */
> >> >> >    .vmux = 3,
> >> >> >    .amux = LINE2,
> >> >> > //   .gpio = 0x4000,
> >> >> >   },{
> >> >> >    .name = name_svideo, /* S-Video signal on S-Video input */
> >> >> >    .vmux = 8,
> >> >> >    .amux = LINE2,
> >> >> > //   .gpio = 0x4000,
> >> >> >   }},
> >> >> >   .radio = {
> >> >> > /* I'd certainly be tempted, but seeing how I myself was forced to
> >> >> > pretty
> >> >> > much orphan an open-source project in the course of the past year,
> >> >> > I'll pass. So I'll be going with my homebrew mix-and-match version
> >> >> > for
> >> >> > myself
> >> >> > so that my card works, and as soon as someone picks up
> >> >> > maintainership,
> >> >> > I'll submit the current state of affairs properly. Meanwhile,
> >> >> > here's my latest changes toward getting everything on the FlyTV
> >> >> > Platinum FM going ... GPIO based radio/FM switching. Radio isn't
> >> >> > working yet though, and I
> >> >> > haven't put any work at all into getting the remote control going.
> >> >> > Current state of affairs: TV and aux inputs work, radio and remote
> >> >> > don't.
> >> >> > */ .name = name_radio,
> >> >> > //   .amux = LINE2,
> >> >> > //   .gpio = 0x2000,
> >> >> >    .amux = TV,
> >> >> >    .gpio = 0x00000, /* GP16=0 selects FM radio antenna */
> >> >> >   },
> >> >> >  },
> >> >> > --
> >> >> > video4linux-list mailing list
> >> >> > Unsubscribe
> >> >> > mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> >> >> > https://www.redhat.com/mailman/listinfo/video4linux-list
> >> >>
> >> >> --
> >> >> video4linux-list mailing list
> >> >> Unsubscribe
> >> >> mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> >> >> https://www.redhat.com/mailman/listinfo/video4linux-list
> >> >
> >> > --
> >> > video4linux-list mailing list
> >> > Unsubscribe
> >> > mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> >> > https://www.redhat.com/mailman/listinfo/video4linux-list
> >>
> >> --
> >> video4linux-list mailing list
> >> Unsubscribe
> >> mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> >> https://www.redhat.com/mailman/listinfo/video4linux-list
