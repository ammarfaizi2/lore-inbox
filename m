Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUF3GCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUF3GCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUF3GCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:02:30 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:29316 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266565AbUF3GCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:02:22 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Wed, 30 Jun 2004 01:02:16 -0500
User-Agent: KMail/1.6.2
Cc: laflipas@telefonica.net, linux-kernel@vger.kernel.org, t.hirsch@web.de,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20040629143232.52963.qmail@web81303.mail.yahoo.com> <200406291808.08186.Marc.Waeckerlin@siemens.com> <200406291253.10542.dtor_core@ameritech.net>
In-Reply-To: <200406291253.10542.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406300102.16083.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 June 2004 12:53 pm, Dmitry Torokhov wrote:
> On Tuesday 29 June 2004 11:08 am, Marc Waeckerlin wrote:
> > Am Dienstag, 29. Juni 2004 16.32 schrieben Sie unter "Re: Continue: psmouse.c 
> > - synaptics touchpad driver sync problem":
> > > Marc Waeckerlin wrote:
> > > > Am Freitag, 25. Juni 2004 16.02 schrieb Dmitry Torokhov unter "Re:
> > > > Continue:
> > > > > Anyway, I also have a tiy patch to try out (attached, not tested/
> > > > > not compiled). Please let me know how ifit makes any improvement.
> > > > No, unfortunately no improvement at all.
> > >
> > > Yeah, I figure there would not be any. Still I have a nagging suspicion
> > > that the mux gets confused and I would like to see the full dmesg with
> > > this patch applied and DEBUG enabled.
> > 
> > "dmesg" won't help, because the buffer gets filled too quickly. I send you the 
> > part from /var/log/messages since last boot. File size is 386KB, so I send it 
> > to you directly, not through the mailing list. You are free to forward it, if 
> > you think it's useful for others.
> >
> 
> Ok, this is much better, it confirms my suspicions... It seems that your
> keyboard controller gets confused where the data is coming from. Please
> try the patch below (against vanilla 2.6.7, not compiled/tested). 
> 

Ok, just to explain the problems that I see in the log you sent (I am also
CCing Vojtech Pavlik as he might be interested in some of the analysis):

> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12) [178780]
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux3, 12) [178792]
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: f2 <- i8042 (interrupt, aux3, 12) [178795]
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [178797]
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux3, 12) [178806]
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: f0 <- i8042 (interrupt, aux3, 12) [178808]
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: 09 <- i8042 (interrupt, aux3, 12) [178810]
> Jun 28 16:01:16 qingwa kernel: i8042.c: MUX reports error condition 18 (35)
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux0, 12) [178822]
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: fb <- i8042 (interrupt, aux3, 12) [178825]
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: 0a <- i8042 (interrupt, aux3, 12) [178827]
> Jun 28 16:01:16 qingwa kernel: drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, aux3, 12) [178835]

The mux got confused as to where the byte came from. They byte itself seems to
be in line with other data in the stream. At this moment your mouse has probably
started jumping around. The patch I send earlier should help with this kind of
problem. 

> Jun 28 16:01:19 qingwa kernel: drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, kbd, 1) [181671]
> Jun 28 16:01:19 qingwa kernel: drivers/input/serio/i8042.c: 81 <- i8042 (interrupt, kbd, 1) [181738]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux3, 12) [181815]
> Jun 28 16:01:20 qingwa kernel: psmouse.c: Mouse at isa0060/serio4/input0 lost synchronization, throwing 2 bytes away.
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux3, 12) [181818]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [181819]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux3, 12) [181828]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12) [181830]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, kbd, 1) [181838]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [181840]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, aux3, 12) [181848]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: fd <- i8042 (interrupt, aux3, 12) [181850]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 81 <- i8042 (interrupt, kbd, 1) [181860]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux3, 12) [181862]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, kbd, 1) [181875]
> Jun 28 16:01:20 qingwa kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
> Jun 28 16:01:20 qingwa kernel: atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12) [181878]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [181880]

Not quite sure what all this is about... Did you plug external keyboard here?

> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, aux3, 12) [182553]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [182555]
> Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux3, 12) [182558]
> Jun 28 16:01:22 qingwa kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux3, 12) [184572]
> Jun 28 16:01:22 qingwa kernel: psmouse.c: Mouse at isa0060/serio4/input0 lost synchronization, throwing 2 bytes away.
> Jun 28 16:01:22 qingwa kernel: drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux3, 12) [184574]
> Jun 28 16:01:22 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [184576]
> Jun 28 16:01:22 qingwa kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux3, 12) [184585]

It seems that we are missing a byte between ff and 18, delay between 2 bytes
is about a second... Where did the byte go? Do you have DMA turned on on your
hard driver? Anything polling battery status? Can't do anything here...

> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [188150]
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, aux1, 12) [188152]
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 05 <- i8042 (interrupt, aux1, 12) [188154]
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [188155]
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 8b <- i8042 (interrupt, aux1, 12) [188157]
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [188474]
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, aux1, 12) [188503]
> Jun 28 16:01:26 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 05 <- i8042 (interrupt, aux1, 12) [188503]
> Jun 28 16:01:26 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 85 <- i8042 (interrupt, aux1, 12) [188835]
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux1, 12) [188835]
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [188836]
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [188838]
> Jun 28 16:01:26 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [188839]
> Jun 28 16:01:26 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [188841]
> Jun 28 16:01:26 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [188843]
> Jun 28 16:01:26 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> Jun 28 16:01:26 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [188844]
> Jun 28 16:01:26 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1

Ok, here we lost byte right after 8b before 80 so it took 80 as the last byte
of a packet instead of first byte of the next packet. The gap between bytes
is about 300ms so timeout was not detected. Because of that it had hard time
synching aftewards. This is a classic example when having too big timeout
actually hurts.

Could you change drivers/input/mouse/psmouse-base.c - psmouse_interrupt()
in call to time time_after HZ/2 to HZ/4. You may see more "lost x bytes"
messages but I bet touchpad handling will feel much better.

Vojtech, what is your opinion?

> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, aux1, 12) [191319]
> Jun 28 16:01:29 qingwa kernel: i8042.c: MUX reports error condition b3 (35)
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: b3 <- i8042 (interrupt, aux0, 12) [191325]
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 52 <- i8042 (interrupt, aux1, 12) [191327]
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: d0 <- i8042 (interrupt, aux1, 12) [191328]
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 2e <- i8042 (interrupt, aux1, 12) [191330]
> Jun 28 16:01:29 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 30 <- i8042 (interrupt, aux1, 12) [191331]
> Jun 28 16:01:29 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, aux1, 12) [191333]
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: b3 <- i8042 (interrupt, aux1, 12) [191335]
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 50 <- i8042 (interrupt, aux1, 12) [191336]
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: d0 <- i8042 (interrupt, aux1, 12) [191338]
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 29 <- i8042 (interrupt, aux1, 12) [191339]
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: 30 <- i8042 (interrupt, aux1, 12) [191342]
> Jun 28 16:01:29 qingwa kernel: psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
> Jun 28 16:01:29 qingwa kernel: drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, aux1, 12) [191343]

Again MUX got confused momentarily, the patch should fix that.

> Jun 28 16:01:31 qingwa kernel: drivers/input/serio/i8042.c: b8 <- i8042 (interrupt, kbd, 1) [193334]
> Jun 28 16:01:31 qingwa kernel: drivers/input/serio/i8042.c: 9d <- i8042 (interrupt, kbd, 1) [193359]
> Jun 28 16:01:33 qingwa kernel: i8042.c: MUX reports error condition fd (f5)
> Jun 28 16:01:33 qingwa kernel: drivers/input/serio/i8042.c: fd <- i8042 (interrupt, aux3, 12, timeout) [195950]
> Jun 28 16:01:33 qingwa kernel: psmouse.c: bad data from KBC - timeout
> Jun 28 16:01:36 qingwa kernel: drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, kbd, 1) [198170]
> Jun 28 16:01:36 qingwa kernel: drivers/input/serio/i8042.c: 93 <- i8042 (interrupt, kbd, 1) [198243]

This one seems to be legit and handled OK although I am not sure what caused
AUX3 to report timeout - it wasn't transmitting for quite some time.

> Jun 28 16:01:44 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [206317]
> Jun 28 16:01:44 qingwa kernel: drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [206320]
> Jun 28 16:01:44 qingwa kernel: i8042.c: MUX reports error condition 00 (35)
> Jun 28 16:01:44 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux0, 12) [206326]
> Jun 28 16:01:44 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [206327]

Confused again...

Anyway, please try the patch and the change to the timeout in
psmouse_interrupt. I am anxiously awaiting result of your testing.

-- 
Dmitry
