Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290913AbSAaEbB>; Wed, 30 Jan 2002 23:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290914AbSAaEav>; Wed, 30 Jan 2002 23:30:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54068 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S290913AbSAaEal>; Wed, 30 Jan 2002 23:30:41 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
	<3C58B078.3070803@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2002 21:27:07 -0700
In-Reply-To: <3C58B078.3070803@zytor.com>
Message-ID: <m1vgdjb0x0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Neither is bzImage... you can use bzImage format for other things.  

Agreed.  Though the bzImage format does have a smaller set of programs
it can handle than an ELF image, and is a little harder to setup.
In particular many simple stand alone programs are ELF bootable by
accident. 

> My main
> worry about this is that it locks you into booting a single image (as opposed to
> 
> kernel+initramfs, the latter of which can be composed on the fly if desirable),
> which is a huge step backwards IMNSHO.

Compose on the fly requires some amount of knowledge of what you are
booting.  You cannot edit an arbitrary image, and know it will work.
The ELF file format does still help in that case though as it exports
which addresses are already taken. 

Beyond that ELF has a .note section and more usefully a PT_NOTE
program header that points at the .note section.  Using ELF notes I
can export information like where initrd_start and initrd_size are in
the ELF image, so they can be modified.   

ELF notes are composed of 3 pieces. name (string), descriptor (string)
and type. name is a label defining who defined the note (we can use
Linux).  type is a 32 bit binary integer, so there is plenty of room
for everything we need. descriptor we can use for the contents.  

Through this we can also export things like the command line.  I have
prototyped this with my mkelfImage utility and it doesn't look to hard
to handle.  And I use a checksum it adds to verify the images integrity
in LinuxBIOS.

Beyond that I can still build a bootable bzImage with my patched
kernel.  setup_arch() looks, sees that we have already queried the
BIOS and skips that step.  And the code used to query the BIOS is
exactly the same in both cases there is just has a different delivery
mechanism.

Beyond that having the ability to do the composition before booting is
important for the network booting case.  Making network bootloaders
simpler.  For network booting having ramdisks tends actually to be
more important then in regular booting because you can't count on
anything else being there on the machine.  So I have no intention of
not supporting initramfs.

My kexec system call directly supports ELF images simply because it
makes debugging easier.  It means I don't have to compute everything
on the fly.  I can go back and look to see what I did wrong or I can
try the same image on a known good bootloader.  

I am reluctant to go with a bootimg like interface because having a
standard format encourages people to standardize.  Though a good
argument can persuade me.  I don't loose any flexibility in comparison
to bootimg because composing files on the fly is not significantly
harder than composing a bootable image in ram. 

Please tell me if I haven't clearly answered your concerns about
being locked into a single image.

Eric
