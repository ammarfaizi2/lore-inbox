Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288959AbSBDMu6>; Mon, 4 Feb 2002 07:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSBDMuj>; Mon, 4 Feb 2002 07:50:39 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:40976 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S288959AbSBDMuV>;
	Mon, 4 Feb 2002 07:50:21 -0500
Date: Mon, 4 Feb 2002 13:49:27 +0100
From: Werner Almesberger <wa@almesberger.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Erik A. Hendriks" <hendriks@lanl.gov>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
Message-ID: <20020204134927.A5079@almesberger.net>
In-Reply-To: <3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org> <3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov> <m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com> <m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com> <m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5ADDD1.6000608@zytor.com>; from hpa@zytor.com on Fri, Feb 01, 2002 at 10:26:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

sorry for joining the discussion so late, but I'm quite busy these days
(about to move around half of the planet, to start). I followed your
discussion, and, while I haven't looked at the current kexec code, from
what I've read, it should be in great shape, and I'm looking forward to
see this in the kernel soon. I keep on running out of time for bootimg,
so I guess there's no competition now anyway. And I think it is very
important that we have a solid Linux-boots-Linux solution soon, in
order to counter the trends in growing boot loader complexity. (IMHO,
GRUB is an excellent example of impressive craftsmanship, but a few
rather fundamental flaws in the overall design. Hell, I think even
LILO is too complex :-)

Having said this, I still think a bootimg-like API would be better than
a file based API. So, concerning this thread:

H. Peter Anvin wrote:
> Therefore, the bootloader must be able to obtain boot medium services 
> not just once and for all, but on a back-and-forth basis.  There needs 
> to be an API between the boot loader and the firmware, and just 
> "stuffing it into memory" doesn't count.

Hmm, I'm not sure about this point of going back and forth, and how it
relates to the design of the kernel boot loader (kexec, bootimg, etc.).
Of course, the boot loader should - before actually booting - be able
to probe hardware, execute a set of policy decisions (e.g. put the
driver for the punch card reader into the initrd), etc.

But this doesn't really affect whether a memory-based interface
(bootimg) or a file-based interface (the rest of the world :-) is
better.

My assumption is that you need to do some processing before telling the
kernel to reboot, and that you want to be able to do such processing in
user space (e.g. extract the current memory map and pass it to the new
kernel, forward the results of bus scans, create a RAM disk with driver
modules on the fly, etc.)

In particular, the "old" kernel may need to pass information obtained
from the firmware to the "new" kernel. With decent firmware, there
could also be user-provided data that needs to be propagated, such as
portions of the command line. Well-known information of this type can
be encoded in the kernel, but I think this just leads to bloat, as more
and more policy will have to be encoded there, let alone the packing
and unpacking issues.

That's where I'd see the advantage of an external program. That program
could take care of all these issues, minus a few low-level
synchronization tasks, and then launch the new kernel with all data at
easily accessible locations. Of course this program would have some
strong interdependencies with the kernel, but I think that, with time,
the interfaces would stabilize, as they have done in the case of the
existing boot protocol, etc.

Now, given that there will be a kernel-specific preloader or loader,
the question is whether a file-based interface is really useful. I
understand the point about debugging, but on the other hand, a simple
dump of the data to be passed to the kernel would be sufficient for
this purpose too.

What I don't like about a file-based interface is that it adds an
extra indirection: you must make sure you have a file system, and you
either need a program that generates this file, and another one that
does the rebooting, or you combine both into the same program - and
you're essentially at the point of having a single converter to what
could basically be an arbitrary API, just like bootimg.

Worse yet, the file-based interface kind of conveys the promise that
the preloader is actually not necessary. This creates an incentive to
keep things that way, so more and more policy will have to be added
to the kernel, simply because externalizing it would shatter that
cute "loader-less" image.

Also, in many cases, interactions beween the kernel side of the boot
loader and the rest of the kernel would actually be a good thing to
have in user space anyway, e.g. the ability to shut down or
"immobilize" certain devices, or to retrieve device status
information.

There's another problem: a kernel image could in principle be more
generic than the hardware really is (e.g. I wouldn't be surprised if
the boot loader of the IBM mainframe guys knows a thing or two it
doesn't tell the kernel. And we have a similar situation on PCs, with
a very main board specific BIOS). If any of this system-specific
information for the boot loader is persistent, this would have to be
encoded in the ELF image. So you have the mandatory ELF-to-ELF step
again.

As I've shown with bootimg, it's pretty trivial to load all kinds of
formats (including ELF) via a memory-based interface, and you enjoy
considerable freedom in how you generate the data in memory. If you
want, you can even go and modify in-kernel data structures directly,
so you don't need a nice and clean interface for each and every bit
of data, but you can evolve interfaces when necessary.

In cases where a boot (pre)loader program wouldn't be desirable, a
set of library functions could serve the same purpose. In fact, the
boot (pre)loader should be based on them, too.

So, while a file-based interface looks cool, I think a "thin"
memory-based interface will serve us better in the long run.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/
