Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131072AbRCGNGw>; Wed, 7 Mar 2001 08:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131074AbRCGNGn>; Wed, 7 Mar 2001 08:06:43 -0500
Received: from smtp1.libero.it ([193.70.192.51]:60382 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S131072AbRCGNGe>;
	Wed, 7 Mar 2001 08:06:34 -0500
Message-ID: <3AA63116.45E8912B@alsa-project.org>
Date: Wed, 07 Mar 2001 14:01:10 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre6 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Jeremy Elson <jelson@circlemud.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another?
In-Reply-To: <Pine.GSO.4.21.0103070429140.2127-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> 
> > But you're forgetting that we need to cope with non collaborative
> > applications (that *use* ioctl).
> 
> Erm. If ioctls are device-specific - the program is already bound to
> specific driver. If they are for class of devices (and if I guessed
> right that's the case you are interested in - sound, isn't it?) we
> could let the stub driver in kernel open two pipes and redirect
> read()/write() on device to the first one turn ioctls into read()/write()
> on the second. That way you can get userland programs serving that
> stuff with no magic required.
> 
> I mean something along the lines of
> 
> foo_write(struct file *file, char *buf, size_t size, loff_t *ppos)
> {
>         return f1->f_ops->write(file, buf, size, ppos);
> }
> foo_ioctl(struct file *file, int cmd, long arg)
> {
>         loff_t dummy;
>         switch (cmd) {
>                 case SNDCTL_DSP_RESET:
>                         f2->f_ops->write(file, "dsp_reset", 10, &dummy);
>                         return 0;
>                 ....
>         }
> }
> where f1 and f2 are named pipes opened at init time. Notice that
> it doesn't introduce extra copying - just splits the stream with OOB data
> into two normal byte streams that can be served by naive userland code.
> After that any client that uses current sound API is able to talk to
> userland drivers and said drivers don't have to pull any special tricks -
> they just open two pipes and do usual select()/read()/write() loop.
> Kernel side is also quite simple that way - plain redirect for read/write
> and trivial decoder for the sound ioctls.

I agree, and this is how I wanted to implement it (apart that I thought
to packetize read/write/ioctl with an header and then to avoid to have
two pipes).

This has two major drawbacks (that have discouraged me):
a) no mmap support
b) the kernel side need to know the details of ioctl contents

a) bring to have an incomplete solution
b) bring the kernel space to be OSS dependent then giving a not general
solution for user space drivers.

The only thing I see that would cope with these drawbacks is to allow a
privileged server application to mmap the address space of another
client application. Then:

a) is solved trivially
b) is ok because server would read/write directly ioctl arguments from
client address space.

Security is a non issue here as also for kernel space driver
applications expose all their address space to driver.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
