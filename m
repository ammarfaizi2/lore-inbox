Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPUA1>; Thu, 16 Nov 2000 15:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKPUAR>; Thu, 16 Nov 2000 15:00:17 -0500
Received: from slc725.modem.xmission.com ([166.70.7.217]:20489 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129069AbQKPUAG>; Thu, 16 Nov 2000 15:00:06 -0500
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001111171158.B17692@progenylinux.com> <m1bsvmcb4z.fsf@frodo.biederman.org> <20001114154953.E8753@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Nov 2000 10:33:07 -0700
In-Reply-To: Werner Almesberger's message of "Tue, 14 Nov 2000 15:49:53 +0100"
Message-ID: <m1vgtn7rfw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <Werner.Almesberger@epfl.ch> writes:

> Eric W. Biederman wrote:
> > There are a couple of differences.  
> > But the big one is I'm trying to do it right.
> 
> So why do you need a file-based interface then ? ;-)

When possible it is nice to set as much policy as possible,
without removing functionality.

> Since this is a highly privileged operation anyway, you may as
> well trust user space to use the right data format ...

Hmm. I hadn't thought of it from that angle.
I don't think I have much code tied up in format checks
so I'm not too worried.  If something goes wrong it is simple
a question of where it will crash.  Doing some checking simply
allows for better debugging of problems :)

One thing I'm going to have to consider though is if the memory
regions that the new kernel is going into are actually memory.  The
pro argument is that checking for reserved areas of memory catches
changes to an architecture that were unexpected.  The recent issues
with the extended BIOS area growing are a good example of this.


> I get the impression that you incur quite a lot of overhead just
> to make it fit with the exec interface. I agree that it's
> conceptually nice, and it looks cleanly done, but I don't quite
> see the practical value. (Except, perhaps, that this allowed you
> to pick the rather cute name "kexec" ;-)

Well there is that.  Somehow implementing scatter/gather from 
a user space process seemed like a potential mess, and extra work.

In part I am starting with a network boot loader, so building
a file format that works was needed anyway.  As far as overhead my
impression is that there is none in speed, and only one or two extra
ones functions in space. 

> > Additionally mine is the only one that has a real chance of booting
> > a non-linux kernel.
> 
> Hmm, I think all approaches could boot a non-Linux kernel, but ...
bootimg is close.

I was thinking a couple of directions here.
- Mine is the only interface that can boot a non-Linux kernel
  natively.  Bootimg doesn't count because it doesn't do anything
  natively :)

In particular every other boot loader passes the nasty empty zero page
to the new kernel.  Definitely requiring a chain loader.

With an OS neutral format, cataloging the non-probable hardware
details, and providing those details in an extensible format, I gain a lot 
in easy extensibility.

I need to find time soon and write up all of the file format details
in an RFC like the GRUB multiboot spec.  Possibly even submit it
to the IETF as an RFC for compatible booting and multiple platforms.

And this raises an important point.  Lazy programmers tend to go
with whatever is easiest.  Having a good file format, making this
the easy case, should reduce the number of formats supported
and increase boot interoperability.  Most of what was said
on this score with GRUB I agree with.  I would even be following
the GRUB multiboot spec except it doesn't allow passing of the
unprobeable hardware details and it doesn't allow easy expansion of
what it does pass.  This is the big reason I'm not in favor
of the bootimg approach, that doesn't define anything.


> As far as loading is concerned, bootimg probably has an advantage
> there, because you can put things together in memory (e.g. some
> OS-specific chain loader), without going to secondary storage.

Well with ramfs is hardly secondary storage, though it has
a touch more overhead.  And you only need to do this for the
non common case.  Getting images to adapt to a specific bootloader
isn't to hard.  Every other boot loader in the world does it.

> (Proof of concept: bootimg is able to load all currently supported
> kernel image formats on ia32.)

I do conceded that bootimg has this ability as well in theory.

I actually have booted multiboot compliant images in an earlier
version of my patch and the cost to support both formats in a kernel
loader is negligible.  My mkelfImage builds linux kernels that
support being booted both ways.

> As far as execution is concerned, you're probably slightly better
> off with an approach that goes back to real mode. (Or use a chain
> loader - this can be transparent to the kernel.) But then, I'm not
> sure if you can re-animate the BIOS in any consistent way, so your
> choice of operating systems may be quite limited, or you have to
> provide your own BIOS substitute.

Agreed if the goal is to boot code is designed to start with a single
sector loaded at 0x7c00.  If I really care I might worry about that.
Since linux preserved the first page of memory which includes the
interrupt table reanimating the BIOS might not be so bad. 

My primary non-linux target are the BSD's, and various experimental
OS's.  And in those cases why go to the pain of dropping out of
protected mode if you are going to just load back into it again.

All of what I do is colored by the fact that my most important
environment I have no BIOS.  So for me I can't reanimate the BIOS
because it isn't there.  Once this bullet is bitten though this
buys a lot.  I can now write a multiplatform boot loader, with
sophisticated features.

> Concerning complexity, you don't need to use assembler for the
> copying (arch/i386/kernel/relocate_kernel.S), see bootimg,
> kernel/bootimg_pic.c

I don't doubt that you can build code that works.  I have
yet to be convinced that the code is safe.  
... Thinking ...
Compiling the code in it's own file and putting it in it's own section
of the kernel for size would probably do it though.  Being sure
the code is PIC is a little tricky though.

> 
> Also, why did you implement your own memory management in
> fs/kexec.c:kimage_get_chunk ?

That really isn't memory management because no actual memory is
allocated.  All that does is find an area of memory < 4GB that is not
reserved and is no other page is going to be placed there.  

In retrospect I probably should be looking through the map of memory
I'm going to provide to the new image and not mem_map.  As with most
code there is certainly room for improvement. 

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
