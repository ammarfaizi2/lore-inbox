Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264198AbUEXTl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbUEXTl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUEXTl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:41:27 -0400
Received: from [141.156.69.115] ([141.156.69.115]:42672 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S264198AbUEXTlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:41:23 -0400
Message-ID: <40B24F52.8050805@infosciences.com>
Date: Mon, 24 May 2004 15:38:58 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com> <20040521223024.GA7399@kroah.com> <40B22EED.4080808@infosciences.com>
In-Reply-To: <40B22EED.4080808@infosciences.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nardelli wrote:
> 
> One more question - my system does not really like it when I redirect /dev/urandom
> to either the first or second port.  I know that it obviosuly makes no sense to
> do such a thing, but is it expected that there should be no problems associated
> with this.  I'm not finished testing, so I'm not sure how severe a problem develops.
> I'll report in when I know more about this.
> 

Here's some preliminary info:

1) Whether writing to the 1st or 2nd port, the machine hangs pretty badly
after catting /dev/urandom for more than 1 second or two.  This continues
even after catting has stopped, and the device has been disconnected.  This
smells like some type of resource leak, probably memory, to me.

2) I've included an Oops when writing to the 1st serial port, showing some
difficulty allocating memory.

3) After looking at visor_write(), I was a bit surprised to see it
allocating its own urb and buffer, while I thought it would be using
the ones that were allocated in usb-serial.usb_serial_probe().  After
looking at other serial devices that use usb_submit_urb() in their
write() functions, I found that the following used the buffers/urb
allocated for them:

cyberjack, digi_acceleport, generic, io_ti, ipaq, ir-usb, keyspan_pda,
kobil_sct, mct_u232, omninet, pl2303, safe_serial

while I found that the following created their own (some for each write):

empeg, ftdi_sio, keyspan, kl5kusb105, visor, whiteheat

I'm not so sure about:
io_edgeport


Is this expected behavior, or am I just missing something here?

It would seem like reusing the buffer and urb would be advantageous,
but there may be more issues here than I am aware of.



May 24 13:54:44 iscjoe kernel: cat: page allocation failure. order:0, mode:0x20
May 24 13:54:44 iscjoe kernel: Call Trace:
May 24 13:54:44 iscjoe kernel:  [__alloc_pages+850/852] __alloc_pages+0x352/0x354
May 24 13:54:44 iscjoe kernel:  [<c013e36e>] __alloc_pages+0x352/0x354
May 24 13:54:44 iscjoe kernel:  [__get_free_pages+34/63] __get_free_pages+0x22/0x3f
May 24 13:54:44 iscjoe kernel:  [<c013e392>] __get_free_pages+0x22/0x3f
May 24 13:54:44 iscjoe kernel:  [dma_alloc_coherent+77/131] dma_alloc_coherent+0x4d/0x83
May 24 13:54:44 iscjoe kernel:  [<c010c43d>] dma_alloc_coherent+0x4d/0x83
May 24 13:54:44 iscjoe kernel:  [pool_alloc_page+92/207] pool_alloc_page+0x5c/0xcf
May 24 13:54:44 iscjoe kernel:  [<c025fba8>] pool_alloc_page+0x5c/0xcf
May 24 13:54:44 iscjoe kernel:  [dma_pool_alloc+261/445] dma_pool_alloc+0x105/0x1bd
May 24 13:54:44 iscjoe kernel:  [<c025fed9>] dma_pool_alloc+0x105/0x1bd
May 24 13:54:44 iscjoe kernel:  [get_device+26/33] get_device+0x1a/0x21
May 24 13:54:44 iscjoe kernel:  [<c025cc33>] get_device+0x1a/0x21
May 24 13:54:44 iscjoe kernel:  [uhci_append_queued_urb+178/276] uhci_append_queued_urb+0xb2/0x114
May 24 13:54:44 iscjoe kernel:  [<c02dadba>] uhci_append_queued_urb+0xb2/0x114
May 24 13:54:44 iscjoe kernel:  [uhci_alloc_td+43/124] uhci_alloc_td+0x2b/0x7c
May 24 13:54:44 iscjoe kernel:  [<c02da70c>] uhci_alloc_td+0x2b/0x7c
May 24 13:54:44 iscjoe kernel:  [uhci_submit_common+360/762] uhci_submit_common+0x168/0x2fa
May 24 13:54:44 iscjoe kernel:  [<c02db8ac>] uhci_submit_common+0x168/0x2fa
May 24 13:54:44 iscjoe kernel:  [uhci_urb_enqueue+469/731] uhci_urb_enqueue+0x1d5/0x2db
May 24 13:54:44 iscjoe kernel:  [<c02dc09d>] uhci_urb_enqueue+0x1d5/0x2db
May 24 13:54:44 iscjoe kernel:  [get_device+26/33] get_device+0x1a/0x21
May 24 13:54:44 iscjoe kernel:  [<c025cc33>] get_device+0x1a/0x21
May 24 13:54:44 iscjoe kernel:  [hcd_submit_urb+287/370] hcd_submit_urb+0x11f/0x172
May 24 13:54:44 iscjoe kernel:  [<c02c8bf4>] hcd_submit_urb+0x11f/0x172
May 24 13:54:44 iscjoe kernel:  [usb_submit_urb+602/844] usb_submit_urb+0x25a/0x34c
May 24 13:54:44 iscjoe kernel:  [<c02c99b7>] usb_submit_urb+0x25a/0x34c
May 24 13:54:44 iscjoe kernel:  [__kmalloc+436/611] __kmalloc+0x1b4/0x263
May 24 13:54:44 iscjoe kernel:  [<c01439dd>] __kmalloc+0x1b4/0x263
May 24 13:54:44 iscjoe kernel:  [pg0+273019921/1068740608] visor_write+0xdf/0x25a [visor]
May 24 13:54:44 iscjoe kernel:  [<d0922411>] visor_write+0xdf/0x25a [visor]
May 24 13:54:44 iscjoe kernel:  [pg0+273274118/1068740608] serial_write+0x85/0x100 [usbserial]
May 24 13:54:44 iscjoe kernel:  [<d0960506>] serial_write+0x85/0x100 [usbserial]
May 24 13:54:44 iscjoe kernel:  [tty_default_put_char+50/52] tty_default_put_char+0x32/0x34
May 24 13:54:44 iscjoe kernel:  [<c0230c4d>] tty_default_put_char+0x32/0x34
May 24 13:54:44 iscjoe kernel:  [opost+170/469] opost+0xaa/0x1d5
May 24 13:54:44 iscjoe kernel:  [<c0231486>] opost+0xaa/0x1d5
May 24 13:54:44 iscjoe kernel:  [write_chan+395/539] write_chan+0x18b/0x21b
May 24 13:54:44 iscjoe kernel:  [<c0233b4c>] write_chan+0x18b/0x21b
May 24 13:54:44 iscjoe kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
May 24 13:54:44 iscjoe kernel:  [<c011987e>] default_wake_function+0x0/0x12
May 24 13:54:44 iscjoe kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
May 24 13:54:44 iscjoe kernel:  [<c011987e>] default_wake_function+0x0/0x12
May 24 13:54:44 iscjoe kernel:  [tty_write+531/786] tty_write+0x213/0x312
May 24 13:54:44 iscjoe kernel:  [<c022e05e>] tty_write+0x213/0x312
May 24 13:54:44 iscjoe kernel:  [write_chan+0/539] write_chan+0x0/0x21b
May 24 13:54:44 iscjoe kernel:  [<c02339c1>] write_chan+0x0/0x21b
May 24 13:54:44 iscjoe kernel:  [tty_write+0/786] tty_write+0x0/0x312
May 24 13:54:44 iscjoe kernel:  [<c022de4b>] tty_write+0x0/0x312
May 24 13:54:44 iscjoe kernel:  [vfs_write+162/270] vfs_write+0xa2/0x10e
May 24 13:54:44 iscjoe kernel:  [<c015a4dd>] vfs_write+0xa2/0x10e
May 24 13:54:44 iscjoe kernel:  [sys_write+63/93] sys_write+0x3f/0x5d
May 24 13:54:44 iscjoe kernel:  [<c015a5e5>] sys_write+0x3f/0x5d
May 24 13:54:44 iscjoe kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
May 24 13:54:44 iscjoe kernel:  [<c0105055>] sysenter_past_esp+0x52/0x71
May 24 13:54:44 iscjoe kernel:
May 24 13:54:44 iscjoe kernel: visor ttyUSB0: visor_write - usb_submit_urb(write bulk) failed with status = -12



-- 
Joe Nardelli
jnardelli@infosciences.com
