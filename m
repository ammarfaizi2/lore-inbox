Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbTCHTvf>; Sat, 8 Mar 2003 14:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbTCHTvc>; Sat, 8 Mar 2003 14:51:32 -0500
Received: from netrider.rowland.org ([192.131.102.5]:24843 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP
	id <S262174AbTCHTvV>; Sat, 8 Mar 2003 14:51:21 -0500
Date: Sat, 8 Mar 2003 15:01:57 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Frans Pop <aragorn@tiscali.nl>
cc: linux-kernel@vger.kernel.org, <gadio@netvision.net.il>,
       <zaitcev@redhat.com>
Subject: Re: PATCH for ide-tape driver
In-Reply-To: <20030307230024.6C544429D2@rhea.tiscali.nl>
Message-ID: <Pine.LNX.4.44L0.0303081426330.26251-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Mar 2003, Frans Pop wrote:

> I have been experiencing problems with this driver.
> When I do 'tar cf /dev/tape --verify <filespec>', I consistently get an error 
> message 'Unexpected EOF in archive'.
> I have Googled for this problem and found others have it to, but no sulution 
> available.
> 
> I also tried the scsi-ide driver, but this produced errors as well, so I 
> decided to try to debug the ide-tape driver.
> 
> My system is a Compaq Deskpro Pentium 300 with Debian Woody 3.0r1 that I 
> upgraded to latest stable kernel 2.4.21-pre4 to work on this patch.
> My tape drive is a Conner CCT-8000A (TR-4).
> I have tested and created the patch working from v1.17c of ide-tape.c.
> 
> I have created a patch after fairly extensive debugging and testing.
> During this process I found 2 technical bugs in the driver that I fixed also. 
> These bugs produced the following log messages:
> - bug: nr_stages should be 0 now
> - ide-tape pipeline bug: first_stage 00000000, next_stage 00000000, 
> last_stage 00000000, nr_stages 1
> 
> I have created a website at http://home.tiscali.nl/isildur/ where the patch 
> can be downloaded. On this site I have documented quite extensively what I 
> have done.

Frans:

Your web site is very impressive.  Clearly you have spent a lot of time 
and effort to analyze the problems and solve them.

When I was working on the ide-tape driver, I found it rather confusing and
oddly-structured -- the result of many accumulated additions and changes,
no doubt.  I salute anyone who is willing to go to the trouble of figuring 
out how it really operates.  If you feel up to a more prolonged project, 
here are some ideas for things you could do:

	Take out all the Onstream additions.  There really needs to be
	two versions of the driver: one for Onstream tape drives and one 
	for everything else.  That will simplify the code immensely.

	Add an option to remove the write pipeline, thereby making output
	synchronous.  While this will slow the operation, it will make it
	possible for the driver to accurately report write errors, which
	is pretty important when performing backups.

	Make the pipeline options configurable at module load time as
	module parameters, as opposed to the awkward procfs interface
	currently there.  Better yet, implement the new driver model
	in Linux 2.5.

	Clean up the pipline operations and make them more obviously
	correct.  In particular, I am far from convinced that the
	feedback mechanism for adding/removing pipeline stages is 
	adequate.

	Clean up the error logging code: replace preprocessor commands
	with inline functions.

Regarding your changes:  I won't have a chance to go over the functional
parts of your patch until next week.  Your point that an ioctl following a
write should automatically create a filemark is correct.  The fact that it
did not do so before is a reflection on the ad-hoc structuring of the
driver.

Your additional error logging looks fine at first glance.


> IMO there seem to be some important discrepancies in the way file spacing is 
> handled in the kernel and the way it is used in tar and mt. This is also 
> documented on the website.

I read your web pages.  I can't speak about tar (my tape backups generally 
use 'backup' and 'restore') and I don't know what it does when you specify 
--verify.  (You might try reading the source code for tar to find out what 
the mystery ioctl is intended for.)

I'm not sure what version of mt you are using.  Here's an extract from the 
man page on my system (RedHat 7.1, version 0.5b of the mt-st package, 
man page copyrighted 1998):

       fsf    Forward space count files.  The tape is  positioned
              on the first block of the next file.

       fsfm   Forward  space count files.  The tape is positioned
              on the last block of the previous file.

       bsf    Backward space count files.  The tape is positioned
              on the last block of the previous file.

       bsfm   Backward space count files.  The tape is positioned
              on the first block of the next file.

This agrees with mtio.h and the behavior you observed (no surprise there; 
my patch addressed that very issue).

On older Unix-type systems, such as Irix or AIX, the fsfm and bsfm 
commands didn't exist.  On those systems, bsf was specified as leaving the 
tape on the beginning-of-tape side of the last filemark crossed.

Furthermore, these commands are implemented by issuing the SPACE command 
to the drive.  This command is documented in the SCSI specification as 
leaving the tape on the B.O.T. side for backwards seeks.  That's what you 
would expect, since in its most straightforward mode of operation the 
firmware won't know that the tape has reached a filemark until it has 
gone past the filemark.

All this makes it sound like the user interface for your version of mt is 
the odd man out.  Of course, the fact that the user interface is different 
doesn't _necessarily_ imply an inconsistency.  In principle it is possible 
that your mt implements the bsf command by issuing the equivalent of a 
bsfm ioctl call.  In practice, however, I doubt that is the case.


I will write back after I've had the time to go over your patch.  Thanks a 
lot for all your work on the driver.

Alan Stern

