Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSGNSKY>; Sun, 14 Jul 2002 14:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSGNSKX>; Sun, 14 Jul 2002 14:10:23 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:12501 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316994AbSGNSKS>; Sun, 14 Jul 2002 14:10:18 -0400
Date: Sun, 14 Jul 2002 20:11:33 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141811.g6EIBXKc019318@burner.fokus.gmd.de>
To: schilling@fokus.gmd.de, zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From zaitcev@redhat.com Sun Jul 14 17:05:31 2002

>>>I will violently oppose anything that implies that the IDE layer uses the
>>>SCSI layer normally.  No way, Jose. I'm all for scrapping, but the thing
>>>that should be scrapped is ide-scsi.
>> 
>> Nobody who has a technical backgroupd and knows what to do wuld ever
>> make such a proposal.
>> 
>> Instead, there needs to be one or more SCSI HA driver as part of the
>> SCSI stack. This driver also needs to deal with plain ATA in order
>> to be able to coordinate access.
>> 
>> Jörg

>Such driver would only work with ATAPI devices. Joerg, does not
>seem to realize that the vast majority of IDE devices do not
>support ATAPI at all. As a rule of thumb, winchesters do not,
>CD-ROMs and such do, and tapes do too. To make a pseudo-HA
>driver which speaks plain IDE and plugs into SCSI subsistem
>would saddle the IDE with SCSI limitations, and add one more
>layer for no benefit whatsoever.

You did not seem to read my previous postings. It is simple to have
a second upper level interface for the IDE HBS driver that connects to
e.g. the ATA HD driver interface. If you like to have 100% backwards
compatibility you could even put the current non-standard part from 
ide-cd on top of this 2nd type of upper level code. Make sure, that 
the ATAPI/SCSI part is probed first, to allow to connect the SCSI 
drivers first and lock the ATA type interface against being used by
drivers like ide-cd in case that a SCSI type of high level driver did
feel responsible to deal with a specific drive.

Of curse this will only work if there is some kind of accepted 
development leadership that makes a concept, works on data structures and 
finally instructs the maintainers of old code to find a way to convert
their current driver to the new model. This new model usually would
cause parts of the code that exists more than once to be removed from
all the old drivers that have been considered to represent 'the wrong way'
in the tree of the evolution of the kernel.

Stop looking at your own belly and have a look at what other OS do.
It seems to be one of the main problems in the Linux development.


People usually only look at Linux and inside Linux, they only look at 
their part of the kernel. Doing it this way, they define their own 
interfaces and don't look enough to the left and to the right.

To make it not look as if I am only bashing current IDE/SCSI code, let
me give an example from the filesystem part.

Have a look at the file 

ftp://ftp.fokus.gmd.de/pub/unix/star/testscript/rock.tar.bz2

It is a tar archive that contains 207,440 empty files and one directory 
using the names of the files in the 'rock' subdirectory from the 
freedb project. This is a snapshot taken on May 30th 2002.

If you extract this archive on a machine running Solaris or FreeBSD,
it takes less than 7 minutes.

A pentium 800 running Solaris 9 results in:

# star -xp -time < rock.tar.bz2
star: WARNING: Archive is bzip2 compressed, trying to use the -bz option.
star: 10372 blocks + 1536 bytes (total of 106210816 bytes = 103721.50k).
star: Total time 405.988sec (255 kBytes/sec)
6:46.051r 12.920u 63.420s 18% 0M 0+0k 0st 0+0io 0pf+0w

You see during the 6:43, the machine is 82% idle.


A Pentium 1200 running Linux-2.5.25 (ext3) results in:

# star -xp -time < rock.tar.bz2
star: WARNING: Archive is bzip2 compressed, trying to use the -bz option.
star: 10372 blocks + 1536 bytes (total of 106210816 bytes = 103721.50k).
star: Total time 3190.483sec (32 kBytes/sec)
53:10.490r 12.299u 2970.099s 93% 0M 0+0k 0st 0+0io 4411pf+0w

You see, during the 53:20, the machine is only 7% idle!

It wasted 2900 seconds of CPU time on Linux. Let me guess: this was done
inside the function strcmp().

There are ~ 5 different filesystems on Linux, but none if the projects seem
to care about the code outside the FS low level code. I suspect, that
this is not any better if you use reiserfs.

Solaris and FreeBSD put all the effort into one filesystem trying to make
it as good as possible. In Linux, it seems that nobody prooved the overall
concept of the kernel.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
