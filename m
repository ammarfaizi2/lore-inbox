Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSJCV1q>; Thu, 3 Oct 2002 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSJCV1q>; Thu, 3 Oct 2002 17:27:46 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:46347 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S261238AbSJCV1m>; Thu, 3 Oct 2002 17:27:42 -0400
Date: Thu, 3 Oct 2002 23:36:38 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Paul Mackerras <paulus@samba.org>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: calling context when writing to tty_driver
In-Reply-To: <15772.4878.969143.541225@nanango.paulus.ozlabs.org>
Message-ID: <Pine.LNX.4.44.0210032251480.3802-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Paul Mackerras wrote:

> > > If we agree serial drivers shouldn't sleep in write_room()/write() my
> > > impression is this needs to be addressed somehow, regardless whether
> > > usbserial uses the new serial core or not. Anybody tried this with a
> > > bluetooth dongle over usbserial?
> > 
> > I don't know, do we agree that you can't sleep in those functions?  If
> > so, I'll look into fixing the usbserial drivers up.
> 
> I really think that write and write_room shouldn't be allowed to
> sleep.  If they can sleep it will cause much grief for PPP, since the
> PPP start_xmit function does get called in softirq context, and in the
> common case where you are doing PPP over a serial port, that will
> ultimately end up in a call to the serial port's write routine.  If we
> can't call the write routine from softirq context, that will mean we

... would see tons (basically 1+ per frame) of this:

usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.6
usbserial.c: USB Serial support registered for PL-2303
usbserial.c: PL-2303 converter detected
usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usb.c: registered new driver pl2303
pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
Sleeping function called from illegal context at
/mnt/disk/kernel/v2.5.39-md/include/asm/semaphore.h:119
c72afe8c c011aa62 c024f160 cc88f780 00000077 ffffffea cc88d500 cc88f780 
       00000077 0000002d c921b000 00000000 c834a000 cc8a4e3c c834a000 00000000 
       c921b0ac 0000002d 00000001 00000060 00000246 cbfbdd04 000000c0 c921b000 
Call Trace:
 [<c011aa62>]__might_sleep+0x42/0x47
 [<cc88f780>].LC4+0x0/0x100 [usbserial]
 [<cc88d500>]serial_write+0x80/0x130 [usbserial]
 [<cc88f780>].LC4+0x0/0x100 [usbserial]
 [<cc8a4e3c>]ppp_async_push+0xcc/0x270 [ppp_async]
 [<cc8a4d59>]ppp_async_send+0x39/0x50 [ppp_async]
 [<cc89dd55>]ppp_channel_push+0x105/0x390 [ppp_generic]
 [<c01fd348>]alloc_skb+0xe8/0x1e0
 [<cc89c42f>]ppp_write+0x16f/0x180 [ppp_generic]
 [<c014b277>]vfs_write+0xb7/0x140
 [<c014b368>]sys_write+0x28/0x40
 [<c01077d7>]syscall_call+0x7/0xb

My initial question for the irda ldisc was basically to find out whether 
the assumption about write/write_room should not sleep was reasonable.
Looks like I'd better stay with this approach for now. The hope is it will 
continue to work with serial - and with usbserial probably later ;-)

Martin

