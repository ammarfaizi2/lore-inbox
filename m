Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268045AbTCFPsI>; Thu, 6 Mar 2003 10:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268110AbTCFPsH>; Thu, 6 Mar 2003 10:48:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56454 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268045AbTCFPsC>;
	Thu, 6 Mar 2003 10:48:02 -0500
Date: Thu, 6 Mar 2003 09:34:35 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Fix to the new sysfs bin file support
In-Reply-To: <1046918323.2915.45.camel@vmhack>
Message-ID: <Pine.LNX.4.33.0303060919520.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Mar 2003, Rusty Lynch wrote:

> I happen to notice the new binary file support in sysfs and had to take
> for a spin.  If I understand this correct my write file will need to
> allocate the buffer->data, but then I have no way of freeing that memory
> since I don't get a release callback.

Hm, good point. Perhaps a better way to do it would be:

open()
	allocate buffer
	fill buffer

read()
	copy_to_user()

write()
	copy_from_user()
	sync with driver

close()
	free buffer

Once the buffer is filled, then the user could read()/seek() on it to 
their hearts' content, without having to call the driver back. 

On a write, the user would end up modifying the desired bits of the
buffer, then sysfs would call the ->write() method, passing the entire 
buffer. 

All this assumes that the buffer will not change while the file is open, 
but for these purposes, I think that's ok to make.

> Here is a patch that:
> * makes sysfs cleanup the buffer->data allocated by the attribute write
> functions
> * fixes a bug that causes the kernel to oops when somebody attempts to
> write to the file.

Thanks.

> BTW, would you be totally opposed to a patch that added open, release,
> and ioctl to the list of functions supported by sysfs binary files?

->ioctl() - No. 

Why ->open() and ->release()? If we free the buffer in our release(), then 
why do you need a notification? 

> Another question... How would a driver know that the various write and
> read calls are coming from the same open, or would there be a way for a
> driver to make it so that only one thing can open the sysfs file at a
> time?

I don't think you could know that a ->read() came from the same process as 
the previous ->read(). Why would you need to know that?

Thanks,

	-pat

