Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270648AbRHNSeN>; Tue, 14 Aug 2001 14:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270647AbRHNSeA>; Tue, 14 Aug 2001 14:34:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53108 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270634AbRHNSdr> convert rfc822-to-8bit; Tue, 14 Aug 2001 14:33:47 -0400
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, Gujin-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
In-Reply-To: <20010814110628.19798.qmail@web11805.mail.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Aug 2001 09:46:38 -0600
In-Reply-To: <20010814110628.19798.qmail@web11805.mail.yahoo.com>
Message-ID: <m1sneuprtt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Etienne Lorrain <etienne_lorrain@yahoo.fr> writes:

>  --- "Eric W. Biederman" <ebiederm@xmission.com> a écrit :
> > Etienne Lorrain <etienne_lorrain@yahoo.fr> writes:
> > >  If someone wants to change it completely, he will
> > >  have to rewrite tools which are accessing this structure (rdev) and
> > >  also the bootloaders which are setting up fields into it already.
> > >  This will involve re-coding real-mode i8086 assembly, and there is less
> > >  and less people knowing how to do it.
> > 
> > True.  However for the moment I am up for making this kind of change.
> > rdev needs to be recoded anyway as it is not portable.  We need a rdev
> > like tool to attach a command line and a ramdisk to arbitrary linux
> > kernels.
> 
>   I am from the old Unix school, I like text - so IMHO this could go in
>  a string, like "root=/dev/hda3 initrd=initrd-3.gz". That is why I proposed
>  to put that string in the "comment" field of the gzip file (see RFC).
>  Unfortunately right now there is no tool to set up this field, but all the
>  uncompression tools seems to treat correctly (skip) this field if present.
>  Is there someone against it? Is there a software (like the "znote"
>  for pkzip) available on Internet to set the comment field of a gz file?

If you are going with gzip.  That definentily sounds like a good strategy.
 
> > >  My main problem is the order the things are done: First load compressed
> > >  files at defined addresses, then call a kernel function which callback
> > >  the BIOS, then uncompress files.
> > 
> > How is this a problem.  Is it the error handling or something else?
> 
>  I hate to destroy random memory content and then ask to the lower
>  layers to behave correctly. For instance I used a DOS debugger to find
>  some of my bugs - it is not possible if the memory at 0x100000 has been
>  overwritten. Even simply my logger/debugger (writing information in a
>  log file under DOS) can not work.

There is sense it that.  Having a way to do all reasonable of the
error checking up front and then going forward with running the kernel.

> > I like the fact that the kernel decompresses itself.  This is one less
> > thing that the bootloader doesn't have to do.  And allows the
> > compression scheme to be changed at least theoretically.
> 
>  I need the decompressor. People will want icons to clic on for Linux,
>  and I plan to uncompress them with my gunzip. Maybe one day I will even
>  compress a part of my bootloader, for instance the different language
>  messages or even part of the code. Note that this ungzip-er is very small,
>  5 Kb for the one in 0.4, 4.5 Kb for the current one - and in some cases
>  do not even need a 32 Kb memory window, unlike the real zlib.
>  Keep in mind that this bootloader may one day go to the EEPROM of a
>  network card (32 Kb max) or in the empty FLASH area of the BIOS...
>  Also have a look at the memory requirement of bzip2, few Mb...

O.k.  I'll definentily have to have a look at it then.  The gunzip code
I have seems to have been larger.
 
> > Why does Gujin need to do the decompression?  Is this simply for
> > better error checking, and error handling?
> 
>  Also, the CRC32 calculation is nearly the only way to guaranty that you
>  have a real kernel - and did not do any error in loading the file. The
>  usual problems I am waiting here is to load wrong sectors because I have
>  a bug in the CHS description of the disk, or I have read a corrupted sector
>  because the floppy had bad sectors and the ECC correction did a bad job.

O.k.  That is one area where you are definentily ahead of me.  I have
been playing with some kind of checksum but I haven't yet.
 
> > >  Once Gujin has started, I have a complete C environment so I can load
> > >  files, treat errors, display messages. I can do this either from cold
> > >  boot or from DOS (think of the first install of Linux on a system).
> > 
> > This definentily sounds nice.  Do you envision the setup code
> > returning to the bootloader if a fatal error occurs?
> 
>   Even more, I envision running GPL maintenance software - and return to
>  the bootloader at the end because this software did take care to not
>  modify memory below 1Mb.
>  For instance I have corrected a small bug in the bootloader (first stage)
>  because I had a sector to read on the HD - and this sector cannot be read
>  at the first time (needs a 0x20 - read with retry - IDE command,
>  a 0x21 - read without retry - return "uncorrected ECC error") and I was
>  not waiting enough for the ECC correction to finnish its task.
>  Because one of the main feature of e2fs is to not fragment files, you
>  will never run an unfragmenter, so there will (probably) be more and
>  more sectors which will need ECC correction each time they are read.
>  What is then needed is a small application displaying the ratio of
>  block needing ECC correction and maybe just read and rewrite them
>  to optimise the system.
> 
> > >  This interface would still not handle a distribution where there is
> > >  few kernel files:
> > >  /boot/Linux-2.4.8-SMP
> > >  /boot/Linux-2.4.8-UP
> > >  /boot/Linux-2.4.8-386
> > >  /boot/Linux-2.4.8-Pentium
> > >  And the bootloader should just select automagically the right kernel.
> > 
> > At this port I have linux booting from linux so what I would do is
> > load /boot/Linux-2.4.8-i386 and then from linux select the right
> > kernel modify the bootloader parameters, and boot the optimal kernel.
> 
>   IHMO a bit complex, managing the command line parameters for the two
>  kernels (like ide addresses, scsi disk order...)

Oh it can get complex, but if all you want to do is to invoke another
kernel with exactly the same options you were invoked with it is a
simple thing to do.

> > >  Moreover, going from a simple solution (loading the binary image of
> > >  an ELF file) to a complex one (as described) to solve problem which
> > >  may appear in the future is not my way of thinking: it is already
> > >  complex enought to do simple software.
> > 
> > I believe it can be done much more simply.  And I think I can make the
> > time to get it done, over the long term.   I can do with an ELF
> > binary, not it's binary ala objdump -O binary I can do what you
> > propose to do with concatenated GZIP files.  And with that I don't
> > need decompression code in the bootloader. 
> 
>   For me, I choose to load a GZIP because its format is trivial enough
>  to extract, and a "objdump -O binary" because I do not want to do the
>  loading part of an ELF file. 

For purposes of a loading a binary the ELF program header simply says load
this chunk of file to this chunk of memory.  So while it is a touch more
complex then a GZIP header it is simpler than a whole gzip file.

With ELF I have so far implemented 3 bootloaders, that can handle it
which allows me to boot arbitrary kernels.

> GZIP is also used for initrd, so you need
>  it if you want to check the integrity what you have loaded.
>   You can try any other method you want, I can't say I never did a
>  wrong choice.

Where I have been focusing is on network booting, and booting in small
environments without a BIOS.  And for those having the option to
package the kernel and ramdisk, and the command line together is
important, as is the option to reduce size by using a different
compression algorithm.  Which is my primary reason for wanting to
include the decompressor with the kernel, and require the bootloader
to use it.


That isn't all of my comments but I need to run off to work now.

Later,
Eric
