Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSBDTtM>; Mon, 4 Feb 2002 14:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287439AbSBDTtD>; Mon, 4 Feb 2002 14:49:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64827 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S287425AbSBDTs4>; Mon, 4 Feb 2002 14:48:56 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Erik A. Hendriks" <hendriks@lanl.gov>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>
	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>
	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com>
	<m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com>
	<20020204134927.A5079@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Feb 2002 12:45:08 -0700
In-Reply-To: <20020204134927.A5079@almesberger.net>
Message-ID: <m1sn8h6ngb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Hi guys,
> 

> Having said this, I still think a bootimg-like API would be better than
> a file based API. So, concerning this thread:

I have come to agree with this sentiment.  However I do have a small
issue with the current bootimg api.  Everything is done in page sized
chunks.  Which feels like it is exporting too much of the current
implementation.

struct boot_image {
	void **image_map;	/* pointers to image pages in user memory */
	int pages;		/* length in pages */
	unsigned long *load_map;/* list of destination pages (physical addr) */
	unsigned long start;	/* jump to this physical address */
	int flags;		/* for future use, must be zero for now */
};
asmlinkage int sys_bootimg(struct boot_image *user_dsc)

My preference goes to something like:
struct segment {
        void *vaddr;		/* virtual address of the data to start with */
        unsigned long paddr;	/* physical address to copy this segment to */
        unsigned long size;	/* size in bytes of this segment */
};
asmlinkage int sys_kexec(struct segment *segments, int nr_segments, unsigned long start_addr);

The big difference I believe is that you will have far fewer segments,
in my scheme, and where everything is on a byte granularity the user
space implementation doesn't have to know how the kernel side of
the implementation interacts with pages.

I hadn't realized until just a minute ago when I looked again that you
were exporting pages.

> My assumption is that you need to do some processing before telling the
> kernel to reboot, and that you want to be able to do such processing in
> user space (e.g. extract the current memory map and pass it to the new
> kernel, forward the results of bus scans, create a RAM disk with driver
> modules on the fly, etc.)
> 
> In particular, the "old" kernel may need to pass information obtained
> from the firmware to the "new" kernel.

Except for the case of Loadlin where the old firmware is destroyed,
and you cannot requery the firmware.  You have a more robust solution
if you let the new kernel query the firmware itself.  In general it is
not safe to use firmware device drivers, but otherwise you are o.k.  

> With decent firmware, there
> could also be user-provided data that needs to be propagated, such as
> portions of the command line. Well-known information of this type can
> be encoded in the kernel, but I think this just leads to bloat, as more
> and more policy will have to be encoded there, let alone the packing
> and unpacking issues.

For the most part I agree, that the bootimg type interface will avoid
bloat.  At the same time, some of this information that we would like
to pass is easier to get at in kernel space, oh well.

> Also, in many cases, interactions beween the kernel side of the boot
> loader and the rest of the kernel would actually be a good thing to
> have in user space anyway, e.g. the ability to shut down or
> "immobilize" certain devices, or to retrieve device status
> information.

Possibly.
 
> As I've shown with bootimg, it's pretty trivial to load all kinds of
> formats (including ELF) via a memory-based interface, and you enjoy
> considerable freedom in how you generate the data in memory. If you
> want, you can even go and modify in-kernel data structures directly,
> so you don't need a nice and clean interface for each and every bit
> of data, but you can evolve interfaces when necessary.

I will stop just a moment to say it is extremely nasty to read the ELF
section header instead of the ELF program header for boot purposes.
For an ELF static executable it is totally valid not to have a section
header.

> In cases where a boot (pre)loader program wouldn't be desirable, a
> set of library functions could serve the same purpose. In fact, the
> boot (pre)loader should be based on them, too.

Actually a library of functions to do the conversions sounds very
reasonable.
 
> So, while a file-based interface looks cool, I think a "thin"
> memory-based interface will serve us better in the long run.

I actually pretty much agree.  But mostly because it becomes easier to
do a clean shutdown.  If you just wrote a file it is kind of hard to
have a read-only filesystem, plus it looks like it will reduce the
strife a little bit...

Eric
