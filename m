Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135484AbRDWRvJ>; Mon, 23 Apr 2001 13:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135489AbRDWRvA>; Mon, 23 Apr 2001 13:51:00 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:64913 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135484AbRDWRup>; Mon, 23 Apr 2001 13:50:45 -0400
Date: Mon, 23 Apr 2001 19:50:43 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Matt <madmatt@bits.bris.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl arg passing
Message-ID: <20010423195043.S682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0104231648330.1089-100000@bits.bris.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0104231648330.1089-100000@bits.bris.ac.uk>; from madmatt@bits.bris.ac.uk on Mon, Apr 23, 2001 at 05:06:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 05:06:48PM +0100, Matt wrote:
> I'm writing a char device driver for a dsp card that drives a motion
> platform.

Can you elaborate on the dsp card? Is it freely programmable? I'm
working on a project to support this kind of stuff via a
dedicated subsystem for Linux.

The problem is, that it's hard to get access to such cards. So
development is moving very slow :-(

> To pass the instructions I'm using a generic ioctl which passes the data
> between user & kernel-space using a struct which is basically like:
> 
> struct instruction_t {
> 	__s16 code;
> 	__s16 rxlen;
> 	__s16 *rxbuf;
> 	__s16 txlen;
> 	__s16 *txbuf;
> };
 
Such stuff is handled already by my subsystem. You just have to
provide some function to do some checks on memory buffers
(readable, writeable, executable, unreachable, properly aligned
and sized transfer unit and so on) and functions for transfers
(which can be sych/asych), ioctls and and debugging interface for
special purposes.

> (rx|tx)len is the length of the extra data that is provided/requested
> in/to be in (rx|tx)buf. Got me so far?
> 
> Am I allowed to do this across the ioctl interface? In my ioctl
> "handler" I'm attempting to do:
> 
> --8<--
> 
> struct instruction_t local;
> __s16 *temp;
> 
> copy_from_user( &local, ( struct instruction_t * ) arg, sizeof( struct instruction_t ) );
> temp = kmalloc( sizeof( __s16 ) * local.rxlen, GFP_KERNEL );
> copy_from_user( temp, arg, sizeof( __s16 ) * local.rxlen );
> local.rxbuf = temp;
> temp = kmalloc( sizeof( __s16 ) * local.txlen, GFP_KERNEL );
> ....
> 
> --8<--
> 
> Is this going to work as expected? Or am I gonna generate oops-a-plenty?

What do you want to do with the buffers? If you plan to expose
them to user space, this is just plain wrong.

If you use it only inside the kernel, please check that you avoid
using more than PAGE_SIZE as rxlen/txlen. Do scatter-gather
instead and vmalloc(). Either in the driver or by hardware
features.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
