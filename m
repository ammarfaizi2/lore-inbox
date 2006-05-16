Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWEPSXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWEPSXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWEPSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:23:34 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45067 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932493AbWEPSXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:23:34 -0400
Date: Tue, 16 May 2006 20:23:24 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Heiko Gerstung <heiko@am-anger-1.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug related to bonding
Message-ID: <20060516182324.GA23413@w.ods.org>
References: <44684B60.1070705@am-anger-1.de> <20060516045332.GN11191@w.ods.org> <44695D2A.9080705@am-anger-1.de> <20060516123351.GA22040@w.ods.org> <4469EB32.80806@am-anger-1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469EB32.80806@am-anger-1.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Tue, May 16, 2006 at 05:09:38PM +0200, Heiko Gerstung wrote:
> Hi, Willy:
> 
> Willy Tarreau wrote:
> > So I think that the rtl8150 driver is simply buggy, or at least does not
> > expect to be used this way.
> >
> >   
> Yes, the original author (Petko) confirmed a few minutes ago that this
> is the case.
> >> Anyone here who can tell me how to handle this (or point me to a driver
> >> which already does that)?
> >>     
> >
> > May be you can try to change the 2 usb_control_msg() calls for a
> > combination of FILL_CONTROL_URB() + usb_submit_urb ? Hmmm reading the
> > code, it looks like nearly everything is already provided. In
> > rtl8150_ethtool_ioctl(), you should try to replaces occurences of
> > get_registers() by async_get_registers() that you will write by
> > comparing set_registers() with async_set_registers().
> >   
> I tried that and it seems that it segfaults now when trying to execute
> the following line:
> 
> dev->ctrl_urb->transfer_buffer_length = size;
> 
> with the following panic message:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000028
> printing eip:
> c48a229a
> *pde = 00000000
> Oops: 0002
> CPU: 0
> EIP: 0010:[<c48a229a>] Not tainted
> EFLAGS: 00010286
> eax: 00000000 ebx: c3aae000 ecx: 00000001 edx: 00000001
> esi: 0000012e edi: 00000001 ebp: 00000001 esp: c3b3fe28
> ds: 0018 es: 0018 ss: 0018
> Process modprobe.old (pid: 55, stackpage=c3b3f000)
> Stack: c48a3b05 c48a3af5 c48a3ae5 c3aae08c c030b1e0 00000064 c3b3fe63
> c3aae000
> 00000000 c48a2575 c3aae000 0000012e 00000001 c3b3fe63 10000000 c3aae000
> c10e3200 c10e3000 c48a3399 c3aae000 c39af220 c0286a00 c02e03c8 00001708
> Call Trace: [<c48a3b05>] [<c48a3af5>] [<c48a3ae5>] [<c48a2575>] [<c48a3399>]
> [<c48a3ce0>] [<c48a3d60>] [<c01c7339>] [<c48a3ce0>] [<c48a3d40>]
> [<c01c7044>]
> [<c01c7066>] [<c01c6691>] [<c48a3d40>] [<c01c6635>] [<c48a34a4>]
> [<c48a3d40>]
> [<c48a3aa0>] [<c0117ce2>] [<c48a2060>] [<c0108903>]
> 
> Code: 89 78 28 68 15 3b 8a c4 e8 69 4c 87 fb 8b 43 04 8b 93 88 00
> /etc/myscript: line 43: 55 Segmentation fault modprobe rtl8150 >
> /dev/null 2>&1
> 
> (wow! hand copying that was what I needed at the end of a working day :-))

You should really pass the oops through ksymoops. Of course, you'll need
some dump of ksyms and /proc/modules, but to get those, you simply have to
reload the bonding driver WITHOUT miimon to ensure that it does not crash,
and your memory should be in the exact same conditions. If only rtl8150 is
involved, you will not need bonding at all, only the rtl8150 driver will
be enough.

> Please find below the complete async_get_registers function I set up, I
> hope it's OK to post it here. A kernel hacker will immediately spot the
> error, no? :-)

Just a guess : I suspect that dev->ctrl_urb is NULL. I don't know how you
are supposed to initialize it though.

> Kind regards,
> Heiko

Regards,
Willy

> static int get_registers(rtl8150_t * dev, u16 indx, u16 size, void *data)
> {
> int ret;
> char *buffer;
> 
> printk("get_registers dev=%08X dev->dr=%08X indx=%d size=%d\n",(unsigned
> long) dev, (unsigned long) &dev->dr, indx,size);
> buffer = kmalloc(size, GFP_DMA);
> if (!buffer) {
> warn("%s: looks like we're out of memory", __FUNCTION__);
> return -ENOMEM;
> }
> 
> 
> if (test_bit(RX_REG_SET, &dev->flags))
> return -EAGAIN;
> 
> dev->dr.bRequestType = RTL8150_REQT_READ;
> dev->dr.bRequest = RTL8150_REQ_GET_REGS;
> dev->dr.wValue = cpu_to_le16(indx);
> dev->dr.wIndex = cpu_to_le16p(&indx);
> dev->dr.wLength = cpu_to_le16p(&size);
> 
> dev->ctrl_urb->transfer_buffer_length = size;
> 
> FILL_CONTROL_URB(dev->ctrl_urb, dev->udev,
> usb_rcvctrlpipe(dev->udev, 0), (char *) &dev->dr,
> buffer, size, ctrl_callback, dev);
> 
> if ((ret = usb_submit_urb(dev->ctrl_urb)))
> err("control request submission failed: %d", ret);
> 
> return ret;
> }
> 
