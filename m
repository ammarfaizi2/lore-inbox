Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUHFNbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUHFNbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUHFNax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:30:53 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:735 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S268135AbUHFNal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:30:41 -0400
Date: Fri, 6 Aug 2004 15:30:02 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jens Axboe <axboe@suse.de>

>> >SG_IO for atapi was born working that way. This should have been fixed
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> Sorry - you should know better that this is not true :-( The unneeded
>> /dev/hd interface has been created with the _same_ DMA problems,
>> ide-scsi still has. Later, when I complained about the problem it has
>> been fixed. As the ide-scsi interface has not been fixed at the same
>> time, this did not look very friendly to me...

>I think I know the history of it, I picked up the pieces of the stuff
>Linus originally did. Originally, there was _no_ dma support. I can only
>imagine that Linus put it in to have someone fix it, because it was
>unustable at the time. I forget how long that lasted, but it can't have
>been more than a few weeks. So it was not the same problem at all. It
>did not use dma because it set up a contig buffer in rq->buffer, which
>ide-cd doesn't convert to prd tables for dma. This was quickly fixed and
>with granular alignment/length restrictions for dma operations, as I
>outlined it defaulted to 4-bytes for ide-cd then. This was all during
>the 2.5 development cycle.

Let me give you a short answer: If DMA creates so many problem on Linux,
how about imlementing a generic DMA abstraction layer like Solaris does?


>> Sorry, but you are wrong: ATAPI CD/DVD writers are primary SCSI
>> devices and thus need to primaryly appear in the SCSI device tree.
>> Adding SG_IO support to fd's that are a result of a call to
>> open("/dev/hd... is a nice extra but definitely not needed.

>Bogus, and I'll again refrain from commenting on that because it's a
>matter of opinion and we all know yours. They use the same command set,
>but there's absolutely no reason why you would need to export them as
>SCSI devices and fake bus/id/lun naming etc.

If you like to ignore the X10t13 SCSI standard group, it is your private 
decision but then it is hard to have a common language for discussions :-(


>> >It has been argued several times that we will not doctor bus/id/lun on
>> >atapi devices, because it does not make sense. So I'm regarding this as
>> >invalid.
>> 
>> Sorry, I have more than 20 years of experiences in Kernel and
>> Application hacking. I am able to decide myself what is a bug and what
>> is something that needs to be called at least "non-orthogonal
>> behavior". This is devinitely a bug or missing orthogonality. See
>> above to understand (These are primarily SCSI devices and therefore
>> they need to have instance numbers within the set of devices in the
>> SCSI device tree).

>Those 20 years at least do seem to buy you a whole lot of arrogance.

Looks like you are a bit confused, see below.....

>I'll explain to you why no thread you start here on lkml goes anywhere -
>because you refuse to listen to anyone. You have 20 years of experience
>so anything you say must be absolutely true, there's not a gram of
>reason in the world coming from other people. Thus there's no point in
>debating with you on these issues.

Please try to distinct between threads I did start and threads I have been
drawn into. I am open to any serious discussion, however if you like
to insist in things that have been agreed on being suboptimal for more than
20 years, you should have very good reasons _and_ be willing to explain
them.

I don't see any arrogance in my mails but in former discussions on LKML,
there have been other people who did believe that they could replace missing
knowledge by arrogance. Fortunately, they did not join this thread ;-)

Let me lead you to the right place to look for:

	The CAM interface (which is from the SCSI standards group)
	usually is implemeted in a way that applications open /dev/cam and
	later supply bus, target and lun in order to get connected
	to any device on the system that talks SCSI.

Let me repeat: If you believe that this is a bad idea, give very good reasons.

 
>I'll say again that _I_ think making up SCSI like addressing for ATAPI
>is completely bogus, because ATAPI isn't addressed that way. You are
>inventing magic numbers! Just because these devices happen to share the
>same command set (almost, which btw do most storage devices these days)
>does not mean they share the bus topology.

But what you think, differs from what the SCSI standards people do.

>> If you do not fix this, you just verify that Linux does not like it's
>> users.  Linux users like to call cdrecord -scanbus and they like to
>> see _all_ SCSI devices from a single call to cdrecord. The fact that
>> the Linux kernel does not return instance numbers for /dev/hd* SCSI
>> devices makes it impossible to implement a unique address space :-(

>I'm sure new users love to find out they need to use -dev=0,1,0 to
>specify their cd burner, they must find that really intuitive and
>straight forward. It's much easier than just using /dev/cdr, or whatever
>you want to name the special file. Indeed.

Looks like a typical answer from somebody who's thoughts are limited to a Linux
environment. Take into account, that cdrecord runs on more than 30 different
platforms and that several of these platforms do not have device nodes like
UNIX has. Cdrecord has been implemented to use a portable addressing method.


>That's fine if you work on nothing but that, but I personally don't want
>to subscribe to more lists. I don't have time to follow them anyways. If
>there's a Linux kernel bug, people should be pointed at linux-kernel and
>follow the general rules of reporting issues there.

As 50% of all problems reported for cdrecord on Linux look like Linux
kernel problems, this is what I do every day.

>> >> -	Linux Kernel include files (starting with Linux-2.5) are buggy and 
>> >> 	prevent compilation. Many files may be affected but let me name
>> >> 	the most important files for me:
>> >> 
>> >> 	-	/usr/src/linux/include/scsi/scsi.h depends on a nonexistant
>> >> 		type "u8". The correct way to fix this would be to replace
>> >> 		any "u8" by "uint8_t". A quick and dirty fix is to call:
>> >> 
>> >> 			"change u8 __u8 /usr/src/linux/include/scsi/scsi.h"
>> >> 
>> >> 		ftp://ftp.berlios.de/pub/change/
>> >> 
>> >> 	-	/usr/src/linux/include/scsi/sg.h includes "extra text" "__user"
>> >> 		in some structure definitions. This may be fixed by adding
>> >> 		#include <linux/compiler.h> somewhere at the beginning of
>> >> 		/usr/src/linux/include/scsi/sg.h
>> >> 
>> >> 	This bug has been reported several times (starting with Linux-2.5).
>> >> 
>> >> 	Time to fix: 5 minutes.
...
>> Of course, you have a second way to go:
>> 
>> 	You could set up a copy of the Linux Kernel include file tree,
>> 	fix this tree and include the fixed version with _every_ Linux source
>> 	distribution. Of course, you need to make sure that the interfaces
>> 	seen in the fixed include tree always exactly match the related
>> 	Kernel sources. Guess which method creates a higher work load.

>I've never followed these threads closely, and I'm not the guy to
>comment on that. It's been discussed here recently, you might want to
>search linux-kernel archives for include/abi and similar.

I am sorry, I am receiving far too much mail to have the time for searching
such an archive. If nobody points me to a file, I would not do it.

>> Let me make a proposal:
>> 
>> The most important problem currently is caused by the bugs in the Linux
>> kernel include files. As it takes only 5 minutes to fix the include 
>> file bugs that are related to cdrtools, I would like to see this bug
>> fixed first.

>Then either fix it and post the patch, or write a detailed bug report
>and hope that someone else fixes it. That's how it works. You have no
>support contract with me.

See above, the fix is in my mail and it has been copied over several times
now....

>> After I've seen a kernel without the named bugs appering on
>> kernel.org, I am very willing to help you to find the reason for the
>> other bugs.  Make your choice which of the problems to check
>> first....... however, it would be a nice gesture to fix the DMA only
>> for x % 512 == 0 problem in ide-scsi next.

>The importance of that bug is slowly decreasing - in 2.6 ide-scsi isn't
>needed, and 2.4 is pretty much set in stone and I doubt we'd fix this
>bug in fear of introducing regressions on some hardware.

The importance could be limited if there were unique instance numbers
for ATAPI devices using the same address space as the other SCSI devices.
For now, ide-scsi is really important.

>> I don't like to sell my soul and this is exactly why I prefer Solaris.

>I'd consider signing licenses to be able to get the OS at least partly
>selling my soul, where as Linux requires you to sign nothing and is
>completely free and open.

Let's see whether "Linux" is open enough to listen to the demands of the
users......

>> I wish that discussions with the Linux kernel hackers would be as
>> easy and fruitful as they are with the Solaris kernel hackers.
>>
>> I wish that bugs in the Linux kernel were fixed as fast as they are
>> fixed on Solaris.

>Maybe you'll have better luck when they are all hacking Linux instead in
>the future.

It seems that you are listening to missinformed people. Why should
Sun use Linux as long as they would miss all the benefits from the new
features of e.g. Solaris 10?


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
