Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291426AbSAaXk1>; Thu, 31 Jan 2002 18:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291425AbSAaXkT>; Thu, 31 Jan 2002 18:40:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10294 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S291429AbSAaXkE>; Thu, 31 Jan 2002 18:40:04 -0500
To: "Erik A. Hendriks" <hendriks@lanl.gov>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 31 Jan 2002 16:36:27 -0700
In-Reply-To: <20020131103516.I26855@lanl.gov>
Message-ID: <m1elk6t7no.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Erik A. Hendriks" <hendriks@lanl.gov> writes:

> I'm inclined to agree with Peter here.
> 
> For Linux, placing an initrd image with ELF is seriously problematic
> since only the boot loader will the necessary information to know
> where to put it.

The bootloader barely has a clue about where in memory the ramdisk
should go.  It just places it up very high in memory and hopes the
kernel won't over write it.  Which is very interesting because except
for the bootmem allocator the current kernel allocates from high
memory down. 
 
> (Note: I suppose initramfs will make some or all of this go away but
> as long as initrds are around - which I think will be a long while,
> these problems exist.)
> 
>   - It needs to be placed far enough away from the kernel to avoid
>     getting overwritten when the kernel starts allocating memory for
>     stuff at boot time.  I had this problem myself with two kernel
>     monte and a fixed load address for initrds.

I had that problem and I fixed the kernel.  All that isn't fixed yet
is the bootmem allocator.  Since 2.4.10 anything above 8MB is safe.
For the final version of my patch I intend to allow it so that
anything the kernel that isn't in an ELF segment the kernel doesn't
have a problem with.  Which basically means statically allocating the
bootmem bitmap, or possibly the bootmem range array.

>   - It needs to be placed on free memory.  The boot loader would
>     potentially have access to memory maps to know where not to place
>     the initrd.  I don't know if any do this at this point but I have
>     had problems with bootloaders dropping initrds in reserved
>     regions.  I ended up switching from syslinux to LILO (or maybe it
>     was the other way) to get around that.

I agree that is an issue.  And etherboot looks and if the kernel is
attempting to load in reserved memory it says sorry I can't load
that.  Not brilliant but since that case virtually never happens it
isn't a problem.  For a given architecture the memory layout is pretty
much fixed.
 
>     As soon as you throw multiple architectures into the mix, I think
>     anything you think you can assume about what memory is reasonable
>     to use disappears.

Sort of.  The assumptions change per architecture.  But I haven't
heard of an architecture where some addresses are not safe.

>     Two kernel monte still has this problem.  Reading the E820 map or
>     something like it is on my to-do list somewhere.
> 
> I don't think that being able to compose an elf image on the fly would
> solve either of these problems since the boot loader needs to make a
> relocation decision.  Running a linker on the fly would be pretty
> nasty anyway, IMO.  Nobody is suggesting any kind of dynamic linking
> in the boot loader are they?

No.  Dynamic linking with relocation is nasty.  

First with a fixed kernel a relocation decision isn't necessary.  And
even if it is all you need is essentially the e820 map which should be
fairly straight forward to export to user space, and verify in kernel
space.  One of my todo items is to actually to verify the load
addresses against addresses where we have ram, and refuse the image
if necessary.


> I like some of the patches that change Linux so you enter in 32 bit
> protected mode.  Switching back to 16bit mode might cause some trouble
> on boards with screwy BIOSes.  I did the "stay in protected mode"
> thing for two kernel monte because some BIOSes would get hung if I
> switch to protected mode and then back again before calling the APM
> setup.  The trick there is to keep the setup information from the real
> mode code and use it for the next kernel.  Gross, if you ask me.

Agreed.  I haven't seen the nasty APM code.  So I'm not certain how to
comment.  In my case, the only switch I have is back to real mode from
protected mode in the loaded image.  Which I believe works just fine.
Perhaps the first kernel would have to call the APM setup stuff, to
make this stable I'm not certain.

> I think ELF is overkill for what you're doing with it.  

Static ELF executables are trivial.  I went looking for a portable
format that had just a start address, and load this chunk of file into
this location in memory.  ELF was the cleanest example of that I could
find.  It has a few extra fields I can ignore but otherwise it works.

> It's an
> established format but so what?  It's not like you'll be able to take
> advantage of large existing code base.  Sure, ld exists to create your
> image but that's not the hard part.  The boot loaders would all have
> to include new code for this.  

Only if we stopped supporting bzImage, which I have no current
intentions of doing.  

Not that I'm worried the baseline code to load an ELF image really is
trivial, all you really have to ad to a bootloader is an extra for
loop. 

> Also, your patch (for x86 only, it
> seems.  didn't you have alpha support too?) is far from trivial. 

The only one of my patches that is x86 only at the moment is the patch
to build an ELF bootable Linux kernel image.  I still support alpha in
my kexec work.  Though I need to go back and test to see if it is
still working.

And my patch is far from trivial.  But most of the code is in the
scatter/gather algorithm for loading the kernel into pages the kernel
has free.  And then going through those pages to make certain the
assembly code can do a simple memcpy from that list of pages to their
destination address.  Monte does something very similar.  The nice
thing is that code is architecture independent so it can be trivially
reused. 

Also the code is essentially independent from most of the rest of the
kernel.  So once it gets stable very little needs to change.  You have
doubtless observed this already.

> In
> short, I don't see how using ELF (or creating a new boot format at
> all) is going to save much, if any, work.

I already need a new format for LinuxBIOS, because I can't use
bzImages.  


> I have this funny feeling some of the initrd discussion might have
> been discussed/addressed elsewhere.  I hope I'm not too out of touch
> :)

My take on the current x86 boot protocol is that it is flawed with
respect to ramdisks.  When it was initially implemented the kernel was
assigned no responsibility for not overwriting the ramdisk and the
trick of putting the ramdisk as high up in memory as possible was
developed.  Later when the top of memory was to high for the kernel
again the boot protocol was fixed, and correspondingly the
bootloaders.   

Personally I think all of that is just flawed.  The bootloaders should
be simple.  They should be able to load the ramdisk at a fixed address
(assuming the memory isn't reserved).   And they shouldn't need to be
changed every time the kernel has a problem.

> Anyway, there's $.02.

Thanks.

> - Erik
> 
> P.S.  The two second delay in two kernel monte is intentional and
>       easily removed.  It's there to let me glimpse the messages
>       before it actually does the reset.

Cool.  That makes me feel a lot better about monte.  Not that I every
really had a problem with it.

My main purpose in this conversation is to get people familiar with
what I'm doing, to see if there really are areas that I have missed,
and to convince people I intend to support this for the long term.  So
I can get Linux booting Linux functionality into the kernel.

My code still needs some work of course, but all of the major elements
are there.

Eric





