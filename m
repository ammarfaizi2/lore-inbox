Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267529AbUHVQAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267529AbUHVQAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267537AbUHVQAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:00:22 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:45993 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S267529AbUHVQAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:00:03 -0400
To: Pascal Schmidt <der.eremit@email.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
	<2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
	<2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
	<2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
	<2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
	<E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
	<412889FC.nail9MX1X3XW5@burner>
	<Pine.LNX.4.58.0408221450540.297@neptune.local>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 22 Aug 2004 18:00:01 +0200
In-Reply-To: <Pine.LNX.4.58.0408221450540.297@neptune.local>
Message-ID: <m37jrr40zi.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Schmidt <der.eremit@email.de> writes:

> I would even go as far as *not* to have that mean "you can also
> read/write via SG_IO", because for normal uses of the device,
> read(2) and write(2) should be enough.

Ripping a CD is in my opinion a normal use of a CD.

> On Sun, 22 Aug 2004, Joerg Schilling wrote:
> > There are several SCSI commands that look safe but would result in coasters
> > if issued while a CD or DVD is written.
> 
> Good point.

Not really, if I have write permisson to a CD burner, being able to
burn a coaster by issuing strange commands is something I expect.
Being able to destroy the firmware of the drive is not something I
expect a normal user to be able to do.

There are at least three conflicting goals here:

1. Only someone with CAP_SYS_RAWIO (i.e. root) should be able to do
   possible destructive things to a device, and only root should be
   able to bypass the normal security checks in the kernel (e.g. get
   access to /dev/mem since access to it means that you can read and
   modify internal kernel structures).

2. A Linux system should have as few suid root binaries as possible.

3. A normal user should be able to perform most tasks without needing
   root.

As you said, since the old kernel behaviour is a gaping security hole,
Linus had no other choice than to add a CAP_SYS_RAWIO check to the
SG_IO call.  This fulfills goal 1.  Unfortunately it breaks just about
every application that expects to be able to send raw SCSI commands
without being root.

There are a couple of ways of fulfilling goal 3 and allow normal users
to burn a CDR:

One is to make cdrecord suid root and then make it drop all
capabilities except for SYS_CAP_RAWIO.  But even if cdrecord is
audited, there are a lot of other applications that need to be able to
send raw SCSI commands such as mt (to change the compression or tape
format of a streamer).  And this violates goal 2, every security guide
I've seen lately recommends minimizing the amount of suid binaries,
not adding more.

Another way is to add specialized ioctls in the kernel for everything,
such as the CDROMPLAYTRKIND to play a track.  Unfortunately, this gets
a bit unmaintainable with all the different devices out there.  It
would be akin to putting the whole of cdrecord into the kernel.

Yet another way is to try to filter the raw SCSI commands and only
allow through "known safe" commands, which is what some other people
have been trying to do.  

I think Joerg is being much too harsh, adding a check for
CAP_SYS_RAWIO fixes a bloody large security hole.  It broke a few
applications, but tough shit, that is what happens every now and then
when plugging security holes.  It would be much worse to leave the
hole open.  The timing may coincide badly with the release cycle of
cdrecord, but thats life.  For now users will have to run cdrecord as
root to be able to burn a CDR.

In the future, add a patch to cdrecord so that it can be run as suid
root and not drop CAP_SYS_RAWIO which will make most users happy.
It's still a violation of goal 2 but one has to do tradeoffs every now
and then.

For the future, well, I'm not sure, but personally I think that the
filter idea is a pretty good one.  It is a coarse sieve, but by
listing some "known safe" commands most applications should work, and
if somebody needs to send a command that isn't considered as safe yet,
he can just run the application as root instead.

In my opinion, the best way forward would be to only have a
CAP_SYS_RAWIO check in the kernel and an installable command filter
that can be configured from userspace.  So when the next version of
snazzycdwriter(tm) is released it can have a line in the README file
saying:

    If you want to be able to run snazzycdwriter(tm) as a normal user,
    add the following command to your rc.local file:

        /sbin/install-scsi-filter /dev/hdc snazzycdwriter.filter

And if you have a tape drive, it could have another list of safe
commands.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
