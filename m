Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313273AbSDDRWF>; Thu, 4 Apr 2002 12:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313274AbSDDRV4>; Thu, 4 Apr 2002 12:21:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13110 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313273AbSDDRVq>; Thu, 4 Apr 2002 12:21:46 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>
	<a8flgc$ms2$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2002 10:15:16 -0700
Message-ID: <m1lmc3qtaz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <m1ofh0spik.fsf@frodo.biederman.org>
> By author:    ebiederm@xmission.com (Eric W. Biederman)
> In newsgroup: linux.dev.kernel
> > 
> > +0240/4	2.04+	real_base	0x90000
> > +0244/4	2.04+	real_memsz	Memory used @ 0x90000
> > +0248/4	2.04+	real_filesz	Precomputed data for @ 0x90000
> > 
> [...]
> > +
> > +  low_base, low_memsz, low_filesz, 
> > +  real_base, real_memsz, real_filesz, 
> > +  high_base, high_memsz, high_filesz:
> > +	Up to this point building a zImage or a bzImage has been a very lossy
> > +	process.  The introduction of these six variables attempts to
> > +	rectify that situation.  They document exactly which pieces
> > +	of memory, the kernel uses during the boot process, and they
> > +	indicate exactly how large the various data segments of the
> > +	kernel are.  It is now possible to create a lossless
> > +	transformation to and from a static ELF executable.
> > +
> > +	For a bzImage the low program segment describes the memory
> > +	from 4KB - 572KB the kernel decompressors uses as a temorary
> > +	buffer.  For a zImage the low program segment describes the
> > +	memory from 4KB - 572KB where the compressed kernel is loaded. 
> > +
> > +	For a bzImage the high program segment describes the memory
> > +	from 1MB on where the compressed kernel is loaded, where
> > +	decompression takes place, where the kernel initially runs,
> > +	and where the kernels bss segment is.  For a zImage the high
> > +	program segment describes the memory from 1MB on where the
> > +	kernel is decompressed to, where the kernel initial runs, and
> > +	where the kernels bss segment is located.
> > +
> > +	The real program segment describes the memory from 572KB
> > +	(0x90000) to 640KB (0xa0000) that the real mode kernel uses.
> > +	This region may be moved lower in memory if the BIOS has
> > +	reserved region for some other purpose.  When doing so
> > +	the following considerations should be applied.
> > +	
> > +		For a zImage you may move the real mode kernel now
> > +		lower than low_base + low_memsz.
> > +
> > +		For a bzImage if you move real_base below (low_base +
> > +		low_memsz) the following are the values of the other
> > +		variables.
> > +			low_memsz -= (low_base + low_memsz) - real_base
> > +			high_memsz += (low_base + low_memsz) - real_base
> > +		
> > +	
> > +	With this information it becomes safe to to statically
> > +	relocate the real mode kernel as well as dynamically relocate
> > +	it.  real_base should not be > 0x90000.
> > +
> >  
> 
> Whereas this is technically correct, it is dangerously misleading.
> Please rephrase this to remove any unnecessary references to the
> legacy address 0x90000.

It's not legacy it is still the optimal address.  The amount of memory
required to load the kernel is directly related to how much low memory
the decompresser can use.  If you move it lower you need more memory
above 1MB to load the kernel.

To load the real mode code at < 0x90000 requires a fairly
sophisticated bootloader.  You have already convinced me how it is bad
for bootloaders to make BIOS calls on behalf of the kernel, and how
bad it is to need bootloaders to change.  So unless the real mode code
does the int 12 call itself and relocates itself as high as it can go
I really don't see the default load address changing.  And I am
documenting the default load address.

I'd like to change the way we do this, so I'm going to stare at this
problem a little bit more.  Changing the default load address and
still being able to compute how much memory the kernel is going
to use is a challenge.

Eric
