Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUHFKnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUHFKnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 06:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUHFKnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 06:43:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43491 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268122AbUHFKmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 06:42:40 -0400
Date: Fri, 6 Aug 2004 12:42:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040806104221.GL10274@suse.de>
References: <200408061018.i76AIdmV005276@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061018.i76AIdmV005276@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, Joerg Schilling wrote:
> >> -	ide-scsi does not use DMA if the "DMA size" is not a multiple of 512.
> >> 	This bug has been reported many times! Last time was when you introduced
> >> 	the unneeded SCSI transport via /dev/hd*. This interface initially
> >> 	did have the same bug - it has been fixed. The same bug in ide-scsi
> >> 	has not been fixed although I send several related mails :-(
> 
> >SG_IO for atapi was born working that way. This should have been fixed
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Sorry - you should know better that this is not true :-( The unneeded
> /dev/hd interface has been created with the _same_ DMA problems,
> ide-scsi still has. Later, when I complained about the problem it has
> been fixed. As the ide-scsi interface has not been fixed at the same
> time, this did not look very friendly to me...

I think I know the history of it, I picked up the pieces of the stuff
Linus originally did. Originally, there was _no_ dma support. I can only
imagine that Linus put it in to have someone fix it, because it was
unustable at the time. I forget how long that lasted, but it can't have
been more than a few weeks. So it was not the same problem at all. It
did not use dma because it set up a contig buffer in rq->buffer, which
ide-cd doesn't convert to prd tables for dma. This was quickly fixed and
with granular alignment/length restrictions for dma operations, as I
outlined it defaulted to 4-bytes for ide-cd then. This was all during
the 2.5 development cycle.

> >in 2.4, agree, in 2.6 it's not so urgent (since /dev/hd* /dev/sr* works
> >direct and does dma to anything, it'll bounce to kernel buffers if it
> >has to).
> 
> Sorry, but you are wrong: ATAPI CD/DVD writers are primary SCSI
> devices and thus need to primaryly appear in the SCSI device tree.
> Adding SG_IO support to fd's that are a result of a call to
> open("/dev/hd... is a nice extra but definitely not needed.

Bogus, and I'll again refrain from commenting on that because it's a
matter of opinion and we all know yours. They use the same command set,
but there's absolutely no reason why you would need to export them as
SCSI devices and fake bus/id/lun naming etc.

> >> -	Parallel (50 bin) SCSI (unknown HBA) on Linux-2.6 does not work if
> >> 	DMA size is not a multiple of 4. The data transferred from the SCSI
> >> 	device is OK for the first part that is a multiple of 4.
> >> 	The remainder of bytes arrive as binary zeroes.
> >> 
> >> 	This is a new bug (I received the related information this week).
> 
> >Might be a hardware issue.
> 
> It is definitely not:
> 
> 1)	The user reported that this did work with a Linux-2.4 kernel
> 	The user was not 100% clear but it is likely that he did upgrade
> 	from SuSE-8.2 to SuSE-9.1
> 
> 2)	This problem is a common mistake made by coders that did not
> 	understand 32 Bit DMA correctly.

Then have that user report the user. You cannot possibly expect me to
give any sort of qualified advice based on a rapport so void of detail as
the above is!

> >> -	ioctl(f, SCSI_IOCTL_GET_IDLUN, &sg_id)) and ioctl(f, SCSI_IOCTL_GET_BUS_NUMBER, &Bus)
> >> 	do not return instance numbers if applied to a fd from /dev/hd*
> >> 
> >> 	This bug has been reported 2 years ago.
> >> 
> >> 	Time to fix: 10 minutes
> 
> >It has been argued several times that we will not doctor bus/id/lun on
> >atapi devices, because it does not make sense. So I'm regarding this as
> >invalid.
> 
> Sorry, I have more than 20 years of experiences in Kernel and
> Application hacking. I am able to decide myself what is a bug and what
> is something that needs to be called at least "non-orthogonal
> behavior". This is devinitely a bug or missing orthogonality. See
> above to understand (These are primarily SCSI devices and therefore
> they need to have instance numbers within the set of devices in the
> SCSI device tree).

Those 20 years at least do seem to buy you a whole lot of arrogance.
I'll explain to you why no thread you start here on lkml goes anywhere -
because you refuse to listen to anyone. You have 20 years of experience
so anything you say must be absolutely true, there's not a gram of
reason in the world coming from other people. Thus there's no point in
debating with you on these issues.

I'll say again that _I_ think making up SCSI like addressing for ATAPI
is completely bogus, because ATAPI isn't addressed that way. You are
inventing magic numbers! Just because these devices happen to share the
same command set (almost, which btw do most storage devices these days)
does not mean they share the bus topology.

> If you do not fix this, you just verify that Linux does not like it's
> users.  Linux users like to call cdrecord -scanbus and they like to
> see _all_ SCSI devices from a single call to cdrecord. The fact that
> the Linux kernel does not return instance numbers for /dev/hd* SCSI
> devices makes it impossible to implement a unique address space :-(

I'm sure new users love to find out they need to use -dev=0,1,0 to
specify their cd burner, they must find that really intuitive and
straight forward. It's much easier than just using /dev/cdr, or whatever
you want to name the special file. Indeed.

> >> -	DMA residual count is not returned (reported in 1998).
> >> 	This is extremely important - it prevents me from unsing Linux as a
> >> 	development platform.
> >> 
> >> 	Time to fix: about one month to rework the whole SCSI driver stack.
> 
> >That's bogus, the SCSI stack (as well as the block layer) is very well
> >capable of reporting residual counts, and if the hardware can do it (we
> >can't get it from some ide hardware :/), we will report residuals.
> 
> >So if it doesn't work it's a bug, but not a design bug.
> 
> For many reasons, all people in my vicinity run Linux-2.4 kernels, so
> I have no way to test myself. It is easy for you to call "scgcheck"
> and fix the kernel until the interface matches the documentation.
>
> Just make sure not to use a broken version from the SuSE source tree....
> Here is the original:
> 
> 	ftp://ftp.berlios.de/pub/cdrecord/alpha/

I'll give that a spin, thanks.

> >> -	Only the first 14 bytes of SCSI Sense data is returned (reported
> >>	in 1998) This is extremely important - it prevents me from unsing
> >>	Linux as a development platform.	
> >> 
> >> 	Time to fix: about one month to rework the whole SCSI driver
> >> 	stack.  With good luck, this may be done on 2 days.
> 
> >2.6 uses 96 byte sense buffers inside the command and copies back as
> >much as specified in the sense buffer, I fear you have to qualify this
> >bug some more (for SCSI). ide-cd uses 18 bytes.
> 
> If this is true, it could be documented by running "scgcheck". I would
> be happy to include some text like "fixed in Linux-2.9.199" somewhere
> in README.linux or README.ATAPI.

Great.

> >> -	Many unclear problem reports lead me to the assumption that Linux-2.6
> >> 	does not set up the SCSI command timeout properly. See previous point!
> 
> >Issued through SG_IO, or how? Again, more details are required.
> 
> If you like to see more details, it would make sense to read the
> related bug reports on debian.org and to subscribe to the cdrtools
> related mailing lists.  Bugs with unclear reasons that are most likely
> caused by incorrect timeouts are reported frequently.

That's fine if you work on nothing but that, but I personally don't want
to subscribe to more lists. I don't have time to follow them anyways. If
there's a Linux kernel bug, people should be pointed at linux-kernel and
follow the general rules of reporting issues there.

Likewise if I see someone report a bug here with using cdrecord that
looks like a cdrecord issue, I'll point them at you.

> >> -	Linux Kernel include files (starting with Linux-2.5) are buggy and 
> >> 	prevent compilation. Many files may be affected but let me name
> >> 	the most important files for me:
> >> 
> >> 	-	/usr/src/linux/include/scsi/scsi.h depends on a nonexistant
> >> 		type "u8". The correct way to fix this would be to replace
> >> 		any "u8" by "uint8_t". A quick and dirty fix is to call:
> >> 
> >> 			"change u8 __u8 /usr/src/linux/include/scsi/scsi.h"
> >> 
> >> 		ftp://ftp.berlios.de/pub/change/
> >> 
> >> 	-	/usr/src/linux/include/scsi/sg.h includes "extra text" "__user"
> >> 		in some structure definitions. This may be fixed by adding
> >> 		#include <linux/compiler.h> somewhere at the beginning of
> >> 		/usr/src/linux/include/scsi/sg.h
> >> 
> >> 	This bug has been reported several times (starting with Linux-2.5).
> >> 
> >> 	Time to fix: 5 minutes.
> 
> >This has also been discussed before, you should not include the kernel
> >headers. Yes I know you don't agree, but that's how it is for now.
> 
> You just need to admit that the Linux kernel is _not_ related to the
> rest of a typical Linux installation (so this is definitely different
> situation than on e.g. FreeBSD or Solaris). If you like to compile an
> application that uses kernel interfaces, you need to make sure that
> both, the application and the kernel are compiled with the same
> "interface description" which is just the kernel include files.
> 
> Please do not come up with the same funny arguments that other people did
> use in the past by trying to tell me that the kernel interfaces used by
> libscg are interfaces provided by glibc.....
> 
> Of course, you have a second way to go:
> 
> 	You could set up a copy of the Linux Kernel include file tree,
> 	fix this tree and include the fixed version with _every_ Linux source
> 	distribution. Of course, you need to make sure that the interfaces
> 	seen in the fixed include tree always exactly match the related
> 	Kernel sources. Guess which method creates a higher work load.

I've never followed these threads closely, and I'm not the guy to
comment on that. It's been discussed here recently, you might want to
search linux-kernel archives for include/abi and similar.

> >> There may be other problems that I do not remember now. If I would get
> >> the impression that LKML is interested in fixing CD/DVD writing
> >> related bugs, I would report more.....
> 
> >If they are kernel bugs, of course we want to know! The above is a
> >pretty damn good start, I just wish you would include more info (or test
> >cases...) as they are a bit ambigious in several places. I understand if
> >you just wanted to list some of them down and that is fine. Perhaps I
> >can get you to elaborate on the ones where I added followup questions?
> 
> Let me make a proposal:
> 
> The most important problem currently is caused by the bugs in the Linux
> kernel include files. As it takes only 5 minutes to fix the include 
> file bugs that are related to cdrtools, I would like to see this bug
> fixed first.

Then either fix it and post the patch, or write a detailed bug report
and hope that someone else fixes it. That's how it works. You have no
support contract with me.

> After I've seen a kernel without the named bugs appering on
> kernel.org, I am very willing to help you to find the reason for the
> other bugs.  Make your choice which of the problems to check
> first....... however, it would be a nice gesture to fix the DMA only
> for x % 512 == 0 problem in ide-scsi next.

The importance of that bug is slowly decreasing - in 2.6 ide-scsi isn't
needed, and 2.4 is pretty much set in stone and I doubt we'd fix this
bug in fear of introducing regressions on some hardware.

> >> From the current number of problem reports, it looks like Linux-2.6 is
> >> not yet ready for general use as too many problems only appear on
> >> Linux-2.6. I currently give peeople the advise to either go back to
> >> Linux-2.4 or to check Solaris (see
> >> http://wwws.sun.com/software/solaris/solaris-express/get.html).
> 
> >If they wish to sell their soul...
> 
> I don't like to sell my soul and this is exactly why I prefer Solaris.

I'd consider signing licenses to be able to get the OS at least partly
selling my soul, where as Linux requires you to sign nothing and is
completely free and open.

> I wish that discussions with the Linux kernel hackers would be as
> easy and fruitful as they are with the Solaris kernel hackers.
>
> I wish that bugs in the Linux kernel were fixed as fast as they are
> fixed on Solaris.

Maybe you'll have better luck when they are all hacking Linux instead in
the future.

-- 
Jens Axboe

