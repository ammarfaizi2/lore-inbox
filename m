Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291179AbSAaRfp>; Thu, 31 Jan 2002 12:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291177AbSAaRf1>; Thu, 31 Jan 2002 12:35:27 -0500
Received: from acl.lanl.gov ([128.165.147.1]:9560 "HELO acl.lanl.gov")
	by vger.kernel.org with SMTP id <S291174AbSAaRfS>;
	Thu, 31 Jan 2002 12:35:18 -0500
Date: Thu, 31 Jan 2002 10:35:16 -0700
From: "Erik A. Hendriks" <hendriks@lanl.gov>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
Message-ID: <20020131103516.I26855@lanl.gov>
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org> <3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org> <3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org> <3C58CAE0.4040102@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C58CAE0.4040102@zytor.com>; from hpa@zytor.com on Wed, Jan 30, 2002 at 08:41:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:41:04PM -0800, H. Peter Anvin wrote:
> Eric W. Biederman wrote:
> 
> > 
> > I am reluctant to go with a bootimg like interface because having a
> > standard format encourages people to standardize.  Though a good
> > argument can persuade me.  I don't loose any flexibility in comparison
> > to bootimg because composing files on the fly is not significantly
> > harder than composing a bootable image in ram. 
> > 
> > Please tell me if I haven't clearly answered your concerns about
> > being locked into a single image.
> > 
> 
> 
> I have to think about it.  I'm not convinced that this particular 
> flavour of standardization is a step in the right direction -- in fact, 
> it is *guaranteed* to provide significant additional complexity for 
> bootloaders, and bzImage support is still going to have to be provided 
> for the forseeable future.  Since you express that it will basically be 
> necessary to stitch the ELF file together on the fly I don't see much 
> point, quite frankly; it seems like extra complexity for no good reason.

I'm inclined to agree with Peter here.

For Linux, placing an initrd image with ELF is seriously problematic
since only the boot loader will the necessary information to know
where to put it.

(Note: I suppose initramfs will make some or all of this go away but
as long as initrds are around - which I think will be a long while,
these problems exist.)

  - It needs to be placed far enough away from the kernel to avoid
    getting overwritten when the kernel starts allocating memory for
    stuff at boot time.  I had this problem myself with two kernel
    monte and a fixed load address for initrds.

  - It needs to be placed on free memory.  The boot loader would
    potentially have access to memory maps to know where not to place
    the initrd.  I don't know if any do this at this point but I have
    had problems with bootloaders dropping initrds in reserved
    regions.  I ended up switching from syslinux to LILO (or maybe it
    was the other way) to get around that.

    As soon as you throw multiple architectures into the mix, I think
    anything you think you can assume about what memory is reasonable
    to use disappears.

    Two kernel monte still has this problem.  Reading the E820 map or
    something like it is on my to-do list somewhere.

I don't think that being able to compose an elf image on the fly would
solve either of these problems since the boot loader needs to make a
relocation decision.  Running a linker on the fly would be pretty
nasty anyway, IMO.  Nobody is suggesting any kind of dynamic linking
in the boot loader are they?

I like some of the patches that change Linux so you enter in 32 bit
protected mode.  Switching back to 16bit mode might cause some trouble
on boards with screwy BIOSes.  I did the "stay in protected mode"
thing for two kernel monte because some BIOSes would get hung if I
switch to protected mode and then back again before calling the APM
setup.  The trick there is to keep the setup information from the real
mode code and use it for the next kernel.  Gross, if you ask me.

I think ELF is overkill for what you're doing with it.  It's an
established format but so what?  It's not like you'll be able to take
advantage of large existing code base.  Sure, ld exists to create your
image but that's not the hard part.  The boot loaders would all have
to include new code for this.  Also, your patch (for x86 only, it
seems.  didn't you have alpha support too?) is far from trivial.  In
short, I don't see how using ELF (or creating a new boot format at
all) is going to save much, if any, work.

I have this funny feeling some of the initrd discussion might have
been discussed/addressed elsewhere.  I hope I'm not too out of touch
:)

Anyway, there's $.02.

- Erik

P.S.  The two second delay in two kernel monte is intentional and
      easily removed.  It's there to let me glimpse the messages
      before it actually does the reset.


