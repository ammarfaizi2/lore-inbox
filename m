Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270563AbRHNLGu>; Tue, 14 Aug 2001 07:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270564AbRHNLGk>; Tue, 14 Aug 2001 07:06:40 -0400
Received: from web11805.mail.yahoo.com ([216.136.172.159]:55052 "HELO
	web11805.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270563AbRHNLGT>; Tue, 14 Aug 2001 07:06:19 -0400
Message-ID: <20010814110628.19798.qmail@web11805.mail.yahoo.com>
Date: Tue, 14 Aug 2001 13:06:28 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Gujin-devel@lists.sourceforge.net
In-Reply-To: <m1wv47oz6q.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- "Eric W. Biederman" <ebiederm@xmission.com> a écrit :
> Etienne Lorrain <etienne_lorrain@yahoo.fr> writes:
> >  If someone wants to change it completely, he will
> >  have to rewrite tools which are accessing this structure (rdev) and
> >  also the bootloaders which are setting up fields into it already.
> >  This will involve re-coding real-mode i8086 assembly, and there is less
> >  and less people knowing how to do it.
> 
> True.  However for the moment I am up for making this kind of change.
> rdev needs to be recoded anyway as it is not portable.  We need a rdev
> like tool to attach a command line and a ramdisk to arbitrary linux
> kernels.

  I am from the old Unix school, I like text - so IMHO this could go in
 a string, like "root=/dev/hda3 initrd=initrd-3.gz". That is why I proposed
 to put that string in the "comment" field of the gzip file (see RFC).
 Unfortunately right now there is no tool to set up this field, but all the
 uncompression tools seems to treat correctly (skip) this field if present.
 Is there someone against it? Is there a software (like the "znote"
 for pkzip) available on Internet to set the comment field of a gz file?

> >  My main problem is the order the things are done: First load compressed
> >  files at defined addresses, then call a kernel function which callback
> >  the BIOS, then uncompress files.
> 
> How is this a problem.  Is it the error handling or something else?

 I hate to destroy random memory content and then ask to the lower
 layers to behave correctly. For instance I used a DOS debugger to find
 some of my bugs - it is not possible if the memory at 0x100000 has been
 overwritten. Even simply my logger/debugger (writing information in a
 log file under DOS) can not work.

> I like the fact that the kernel decompresses itself.  This is one less
> thing that the bootloader doesn't have to do.  And allows the
> compression scheme to be changed at least theoretically.

 I need the decompressor. People will want icons to clic on for Linux,
 and I plan to uncompress them with my gunzip. Maybe one day I will even
 compress a part of my bootloader, for instance the different language
 messages or even part of the code. Note that this ungzip-er is very small,
 5 Kb for the one in 0.4, 4.5 Kb for the current one - and in some cases
 do not even need a 32 Kb memory window, unlike the real zlib.
 Keep in mind that this bootloader may one day go to the EEPROM of a
 network card (32 Kb max) or in the empty FLASH area of the BIOS...
 Also have a look at the memory requirement of bzip2, few Mb...

> Why does Gujin need to do the decompression?  Is this simply for
> better error checking, and error handling?

 Also, the CRC32 calculation is nearly the only way to guaranty that you
 have a real kernel - and did not do any error in loading the file. The
 usual problems I am waiting here is to load wrong sectors because I have
 a bug in the CHS description of the disk, or I have read a corrupted sector
 because the floppy had bad sectors and the ECC correction did a bad job.

> >  Once Gujin has started, I have a complete C environment so I can load
> >  files, treat errors, display messages. I can do this either from cold
> >  boot or from DOS (think of the first install of Linux on a system).
> 
> This definentily sounds nice.  Do you envision the setup code
> returning to the bootloader if a fatal error occurs?

  Even more, I envision running GPL maintenance software - and return to
 the bootloader at the end because this software did take care to not
 modify memory below 1Mb.
 For instance I have corrected a small bug in the bootloader (first stage)
 because I had a sector to read on the HD - and this sector cannot be read
 at the first time (needs a 0x20 - read with retry - IDE command,
 a 0x21 - read without retry - return "uncorrected ECC error") and I was
 not waiting enough for the ECC correction to finnish its task.
 Because one of the main feature of e2fs is to not fragment files, you
 will never run an unfragmenter, so there will (probably) be more and
 more sectors which will need ECC correction each time they are read.
 What is then needed is a small application displaying the ratio of
 block needing ECC correction and maybe just read and rewrite them
 to optimise the system.

> >  This interface would still not handle a distribution where there is
> >  few kernel files:
> >  /boot/Linux-2.4.8-SMP
> >  /boot/Linux-2.4.8-UP
> >  /boot/Linux-2.4.8-386
> >  /boot/Linux-2.4.8-Pentium
> >  And the bootloader should just select automagically the right kernel.
> 
> At this port I have linux booting from linux so what I would do is
> load /boot/Linux-2.4.8-i386 and then from linux select the right
> kernel modify the bootloader parameters, and boot the optimal kernel.

  IHMO a bit complex, managing the command line parameters for the two
 kernels (like ide addresses, scsi disk order...)

> >  Moreover, going from a simple solution (loading the binary image of
> >  an ELF file) to a complex one (as described) to solve problem which
> >  may appear in the future is not my way of thinking: it is already
> >  complex enought to do simple software.
> 
> I believe it can be done much more simply.  And I think I can make the
> time to get it done, over the long term.   I can do with an ELF
> binary, not it's binary ala objdump -O binary I can do what you
> propose to do with concatenated GZIP files.  And with that I don't
> need decompression code in the bootloader. 

  For me, I choose to load a GZIP because its format is trivial enough
 to extract, and a "objdump -O binary" because I do not want to do the
 loading part of an ELF file. GZIP is also used for initrd, so you need
 it if you want to check the integrity what you have loaded.
  You can try any other method you want, I can't say I never did a
 wrong choice.
 
  Etienne.


___________________________________________________________
Do You Yahoo!? -- Vos albums photos en ligne, 
Yahoo! Photos : http://fr.photos.yahoo.com
