Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261378AbSJAVBa>; Tue, 1 Oct 2002 17:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSJAVBa>; Tue, 1 Oct 2002 17:01:30 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:8709 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S261378AbSJAVB1>; Tue, 1 Oct 2002 17:01:27 -0400
Date: Tue, 1 Oct 2002 23:10:34 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: calling context when writing to tty_driver
In-Reply-To: <20021001183400.GA8959@kroah.com>
Message-ID: <Pine.LNX.4.21.0210012150300.485-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Greg KH wrote:

> > just hitting another "sleeping on semaphore from illegal context" issue
> > with 2.5.39. Happened on down() in either usbserial->write_room() or
> > usbserial->write(), when invoked from bh context.
> 
> Can you send me the whole backtrace?  I'm curious as to who is calling
> those functions from bh context.

It's from an intermediate state of my attempt to rewrite the irda ldisc
(irtty) to make it working with the new serial driver and usbserial as
well. It's all working with serial (uart) which doesn't sleep neither in
write_room() nor write() - except when called from userland.

With usbserial however port->sem is acquired in both cases. It gets
invoked from non-sleep context in two cases:

1) start of transmission (frame comes from network layer):

	netdev->hard_start_xmit() - under xmit-lock
		- takes some spinlock_bh to serialize with write_wakeup()
		- calls tty_driver->write_room() and tty_driver->write()

2) sending more data after serial driver has transmitted some bytes:

	tty_driver in bh context (urb-complete for usbserial)
	calls ldisc->write_wakeup()
		which uses tty_driver->write_room() / write()
		to send the next few bytes from the frame

The backtrace below is from case 1. In both cases it would be extremely
painful to defer all the real work to process context - then we could as
well nuke write_wakeup() and write_room() and make tty_driver->write()
just blocking.

Agreed, there aren't many users of write_wakeup but it seems they all rely
on case 2 above (at least): ppp, n_hdlc, slip, x25, input/serio to give a
few examples. Well, they are probably always used on top of serial without
problem - but I'd expect the same issue might already hit bluetooth (i.e.
hci_ldisc) when running over usbserial.

> > Currently, usbserial calls write_wakeup() from bh (on OUT urb completion)
> > but needs process context for write_room() and write(). My impression is
> > the whole point of write_room() is to find out how many data can be
> > accepted by the write() - if write() would be allowed to sleep it could
> > just block to deal with any amount of data.
> 
> Making write() block for any amount of data would increase the
> complexity of the drivers.  What should probably be done is convert the
> usb-serial drivers to use the new serial core, but I don't have the time
> to do this work right now.  Any takers?

Given the above mentioned observations with other write_wakeup() users I
tend to assume my approach to call write_room()/write() from non-sleep
context couldn't be that wrong. And it works with existing serial driver
(old and new one).

Another question/suggestion: do we need to acquire port->sem in usbserial?
Couldn't this be done with a spinlock - at least when called from_user?
If we agree serial drivers shouldn't sleep in write_room()/write() my
impression is this needs to be addressed somehow, regardless whether
usbserial uses the new serial core or not. Anybody tried this with a
bluetooth dongle over usbserial?

Martin

----------------------------------------

backtrace from 2.5.39:

 Sleeping function called from illegal context at /mnt/disk/kernel/v2.5.39-md/include/asm/semaphore.h
 c02bbc94 c011aa62 c024f160 cc8d0780 00000077 ffffffea cc8ce500 cc8d0780 
        00000077 c55c4000 c95f3c00 c02bbd58 cbcf42e4 cc8c60b7 c55c4000 00000000 
        c5d43000 0000001c c95f3c00 c95f3c00 cbcf42e4 cc8c1377 c95f3c00 c5d43000 
 Call Trace
  [__might_sleep+66/71]__might_sleep+0x42/0x47
  [<c011aa62>]__might_sleep+0x42/0x47
  [<cc8d0780>].LC4+0x0/0x100 [usbserial]
  [<cc8ce500>]serial_write+0x80/0x130 [usbserial]
  [<cc8d0780>].LC4+0x0/0x100 [usbserial]
  [<cc8c60b7>]irtty_do_write+0x57/0x60 [sir_tty]
  [<cc8c1377>]sirdev_do_write+0x67/0x88 [irda_sir]
  [<cc8c193b>]sirdev_hard_xmit+0x25f/0x2f0 [irda_sir]
  [__wake_up_common+47/80]__wake_up_common+0x2f/0x50
  [<c0118adf>]__wake_up_common+0x2f/0x50
  [default_wake_function+33/64]default_wake_function+0x21/0x40
  [<c0118a91>]default_wake_function+0x21/0x40
  [qdisc_restart+160/608]qdisc_restart+0xa0/0x260
  [<c0209080>]qdisc_restart+0xa0/0x260
  [dev_queue_xmit+270/1088]dev_queue_xmit+0x10e/0x440
  [<c0200aae>]dev_queue_xmit+0x10e/0x440
  [alloc_skb+232/480]alloc_skb+0xe8/0x1e0
  [<c01fd348>]alloc_skb+0xe8/0x1e0
  [<cc899a02>]irlap_send_discovery_xid_frame+0x312/0x320 [irda]

