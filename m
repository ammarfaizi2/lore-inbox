Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUHVRXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUHVRXK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268038AbUHVRUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:20:51 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:29354 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268037AbUHVRS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:18:59 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: der.eremit@email.de, christer@weinigel.se, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
	<2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
	<2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
	<2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
	<2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
	<E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
	<412889FC.nail9MX1X3XW5@burner>
	<Pine.LNX.4.58.0408221450540.297@neptune.local>
	<m37jrr40zi.fsf@zoo.weinigel.se> <4128CAA2.nail9RG21R1OG@burner>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 22 Aug 2004 19:18:57 +0200
In-Reply-To: <4128CAA2.nail9RG21R1OG@burner>
Message-ID: <m3u0uv2iri.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:
> But in order to rip an audio CD, you need to use e.g. MODE SELECT.
> If you start to distinct safe SCSI commands from possibly unsafe ones, then 
> MODE SELECT could not be in the list of safe ones.

Yes, I'm quite aware of that.  

So a filter would have to be smarter than just checking the command
codes.  There would have to be a special case for the mode page
commands which filters on accessible mode pages.

Are there any other commands that would need filtering at a finer
grain than the command level?

Additionally, another thing that is really needed is to match
the different variants of hdr->dxfer_direction against the direction
of the commands, otherwise one could ask for a REQUEST_SENSE but with
a direction of SG_DXFER_TO_DEV.  This isn't a security problem in the
sense that it can destroy the drive itself, but it might hang the
IDE state machine in the kernel, motherboard or drive.  

> > Not really, if I have write permisson to a CD burner, being able to
> > burn a coaster by issuing strange commands is something I expect.
> > Being able to destroy the firmware of the drive is not something I
> > expect a normal user to be able to do.
> 
> At SCSI level, there is no real difference.

SG_IO does not have to work at the SCSI level, it can filter the
commands at a higher level.

> A powerful CD/DVD recording program needs to sometimes issue "secret"
> and vendor unique SCSI commands in order to give nice features.
> 
> On a Plextor drive, you need to be able to issue a vendor unique SCSI command
> to know the recommended write speed for a specific medium. A SCSI command
> from same list of vendor unique commands allows you to tell the drive to read
> any medium at 52x. This could destroy the medium _and_ the drive.
> 
> As you see: you cannot have the needed knowledge inside the kernel.

So guess why I suggested that the kernel should contain the mechanics
to filter commands (and yes, I was aware of the mode page problems but
didn't want to make a long mail even longer), and that the list of
commands would be uploaded to the kernel from userspace.  It was at
the end of the mail you replied to...

That way an application, such as cdrecord, could keep a list of safe
commands for each device and use the appropriate list for each kind of
device.  If the device is a tape, allow access to the mode page that
can control BPI and compression settings.  If it's a cdrom, allow
access to the mode page with CDDA settings.

Of course, if it isn't possible to do this at a mode page level, maybe
the access controls would have to be at the level of individual bits
in a mode page, then it gets trickier.  It might, or might not be
feasible to implement such a filte.  I don't know which is true or
which is not, I'm just trying to look at ways of solving the problem.

> > 2. A Linux system should have as few suid root binaries as possible.
> 
> If you like this completely, you would need to implement something RBAC and
> getppriv(2)(setpiriv(2) on Solaris. If you have this, you have zero suid
> root binaries on a 'Trusted OS' and one suid binary (/usr/bin/pfexec) on a non 
> Trusted system.

Which is not all that different from suid binaries.  Instead of
trusting an application, you're trusting a user or a role.  This isn't
much different from giving "trusted" users access to /dev/scd0.  

> > As you said, since the old kernel behaviour is a gaping security hole,
> > Linus had no other choice than to add a CAP_SYS_RAWIO check to the
> > SG_IO call.  This fulfills goal 1.  Unfortunately it breaks just about
> 
> Not true: a simple check like in my scg driver:
> 
>         /* 
>          * Must have read/write access to /dev/scgxx 
>          * to send commands over SCSI Bus. 
>          */ 
>         if ((flag&(FREAD|FWRITE)) != (FREAD|FWRITE)) 
>                 return (EACCES); 
>
> was sudfficient.

No.  Sure, you can redefine read access to a SCSI device to mean "may
only use normal read" and write access to "may use read, write and
send raw SCSI commands", but that is a rather bad fit to how
read/write normally are used.

What do you do if you want to allow users with read access to
read a SCSI tape (and to be able select the BPI)?  With your
suggestion, the user will need write access too, but I may just want
to give the user read access.

> BTW: 'mt' should not need to send SCSI comands. THis shoul dbe handled via
> specilized ioctls.

So why can't cdrecord use specialized ioctls then?

> With checking for ((flag&(FREAD|FWRITE)) != (FREAD|FWRITE)) less applications
> would break.

cdrecord probably wouldn't break.  Other applications that open
/dev/scd0 as readonly would break.  cdrecord isn't the only
application in the world you know.

The Linux philosophy is "do it right".  And when Linus has been
changing interfaces he has said that he prefers something to break
noisily (not compile) rather than to get compile fixes that leave the
bugs still in there.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
