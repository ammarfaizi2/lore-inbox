Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRDWUS3>; Mon, 23 Apr 2001 16:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRDWUSU>; Mon, 23 Apr 2001 16:18:20 -0400
Received: from cnxt10143.conexant.com ([198.62.10.143]:21772 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130552AbRDWUSN>; Mon, 23 Apr 2001 16:18:13 -0400
Date: Mon, 23 Apr 2001 22:17:26 +0200 (CEST)
From: <rui.sousa@mindspeed.com>
X-X-Sender: <rsousa@localhost.localdomain>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Matt <madmatt@bits.bris.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: ioctl arg passing
In-Reply-To: <20010423195043.S682@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.33.0104232155230.1417-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, Ingo Oeser wrote:

> On Mon, Apr 23, 2001 at 05:06:48PM +0100, Matt wrote:
> > I'm writing a char device driver for a dsp card that drives a motion
> > platform.
>
> Can you elaborate on the dsp card? Is it freely programmable? I'm
> working on a project to support this kind of stuff via a
> dedicated subsystem for Linux.

Very interesting... The emu10k1 driver (SBLive!) that will appear
shortly in acXX will support loading code to it's DSP. It's a very
simple chip with only 16 instructions but it can generate
hardware interrupts, DMA to host memory, 32 bit math. The maximum
program size is 512 instructions (64 bits each) and can make use of 256
registers (32 bits).

Is there a web page for your project?


> The problem is, that it's hard to get access to such cards. So
> development is moving very slow :-(

If you care, the cheapest emu10k1 is 40$...

> > To pass the instructions I'm using a generic ioctl which passes the data
> > between user & kernel-space using a struct which is basically like:
> >
> > struct instruction_t {
> > 	__s16 code;
> > 	__s16 rxlen;
> > 	__s16 *rxbuf;
> > 	__s16 txlen;
> > 	__s16 *txbuf;
> > };
>
> Such stuff is handled already by my subsystem. You just have to
> provide some function to do some checks on memory buffers
> (readable, writeable, executable, unreachable, properly aligned
> and sized transfer unit and so on) and functions for transfers
> (which can be sych/asych), ioctls and and debugging interface for
> special purposes.
>
> > (rx|tx)len is the length of the extra data that is provided/requested
> > in/to be in (rx|tx)buf. Got me so far?
> >
> > Am I allowed to do this across the ioctl interface? In my ioctl
> > "handler" I'm attempting to do:
> >
> > --8<--
> >
> > struct instruction_t local;
> > __s16 *temp;
> >
> > copy_from_user( &local, ( struct instruction_t * ) arg, sizeof( struct instruction_t ) );
> > temp = kmalloc( sizeof( __s16 ) * local.rxlen, GFP_KERNEL );
> > copy_from_user( temp, arg, sizeof( __s16 ) * local.rxlen );
                          ^^^ local.rxbuf, no ?

> > local.rxbuf = temp;
> > temp = kmalloc( sizeof( __s16 ) * local.txlen, GFP_KERNEL );
> > ....
> >
> > --8<--
> >
> > Is this going to work as expected? Or am I gonna generate oops-a-plenty?

I've used this method in some of my drivers. It works just fine, but
as everybody already told you, you should do some checking on the values
you are passed from user space.

> What do you want to do with the buffers? If you plan to expose
> them to user space, this is just plain wrong.
>
> If you use it only inside the kernel, please check that you avoid
> using more than PAGE_SIZE as rxlen/txlen. Do scatter-gather
> instead and vmalloc(). Either in the driver or by hardware
> features.
>
> Regards
>
> Ingo Oeser
>

Rui Sousa

