Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130488AbRCGJus>; Wed, 7 Mar 2001 04:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130778AbRCGJui>; Wed, 7 Mar 2001 04:50:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50334 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130488AbRCGJue>;
	Wed, 7 Mar 2001 04:50:34 -0500
Date: Wed, 7 Mar 2001 04:49:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Jeremy Elson <jelson@circlemud.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another?
In-Reply-To: <3AA5FD4B.B2CE1AAF@alsa-project.org>
Message-ID: <Pine.GSO.4.21.0103070429140.2127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2001, Abramo Bagnara wrote:

> > No, they don't. OOB data is equivalent to data on parallel channel.
> 
> Al, you're perfectly right in principle (although last time I've checked
> pipe and unix socket did not support OOB data. Is this changed
> recently?).

ioctl() is OOB stuff. Replace with second pipe and you don't need it
anymore.

> But you're forgetting that we need to cope with non collaborative
> applications (that *use* ioctl).

Erm. If ioctls are device-specific - the program is already bound to
specific driver. If they are for class of devices (and if I guessed
right that's the case you are interested in - sound, isn't it?) we
could let the stub driver in kernel open two pipes and redirect
read()/write() on device to the first one turn ioctls into read()/write()
on the second. That way you can get userland programs serving that
stuff with no magic required.

I mean something along the lines of

foo_write(struct file *file, char *buf, size_t size, loff_t *ppos)
{
	return f1->f_ops->write(file, buf, size, ppos);
}
foo_ioctl(struct file *file, int cmd, long arg)
{
	loff_t dummy;
	switch (cmd) {
		case SNDCTL_DSP_RESET:
			f2->f_ops->write(file, "dsp_reset", 10, &dummy);
			return 0;
		....
	}
}
where f1 and f2 are named pipes opened at init time. Notice that
it doesn't introduce extra copying - just splits the stream with OOB data
into two normal byte streams that can be served by naive userland code.
After that any client that uses current sound API is able to talk to
userland drivers and said drivers don't have to pull any special tricks -
they just open two pipes and do usual select()/read()/write() loop.
Kernel side is also quite simple that way - plain redirect for read/write
and trivial decoder for the sound ioctls.
							Cheers,
								Al

