Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268020AbUHVQdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268020AbUHVQdu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268023AbUHVQdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:33:50 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:40339 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S268020AbUHVQdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:33:38 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sun, 22 Aug 2004 18:32:34 +0200
To: der.eremit@email.de, christer@weinigel.se
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <4128CAA2.nail9RG21R1OG@burner>
References: <2ptdY-42Y-55@gated-at.bofh.it>
 <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it>
 <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it>
 <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it>
 <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
 <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
 <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner>
 <Pine.LNX.4.58.0408221450540.297@neptune.local>
 <m37jrr40zi.fsf@zoo.weinigel.se>
In-Reply-To: <m37jrr40zi.fsf@zoo.weinigel.se>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel <christer@weinigel.se> wrote:

> Pascal Schmidt <der.eremit@email.de> writes:
>
> > I would even go as far as *not* to have that mean "you can also
> > read/write via SG_IO", because for normal uses of the device,
> > read(2) and write(2) should be enough.
>
> Ripping a CD is in my opinion a normal use of a CD.

But in order to rip an audio CD, you need to use e.g. MODE SELECT.
If you start to distinct safe SCSI commands from possibly unsafe ones, then 
MODE SELECT could not be in the list of safe ones.

> > On Sun, 22 Aug 2004, Joerg Schilling wrote:
> > > There are several SCSI commands that look safe but would result in coasters
> > > if issued while a CD or DVD is written.
> > 
> > Good point.
>
> Not really, if I have write permisson to a CD burner, being able to
> burn a coaster by issuing strange commands is something I expect.
> Being able to destroy the firmware of the drive is not something I
> expect a normal user to be able to do.

At SCSI level, there is no real difference.


> There are at least three conflicting goals here:
>
> 1. Only someone with CAP_SYS_RAWIO (i.e. root) should be able to do
>    possible destructive things to a device, and only root should be
>    able to bypass the normal security checks in the kernel (e.g. get
>    access to /dev/mem since access to it means that you can read and
>    modify internal kernel structures).

A powerful CD/DVD recording program needs to sometimes issue "secret"
and vendor unique SCSI commands in order to give nice features.

On a Plextor drive, you need to be able to issue a vendor unique SCSI command
to know the recommended write speed for a specific medium. A SCSI command
from same list of vendor unique commands allows you to tell the drive to read
any medium at 52x. This could destroy the medium _and_ the drive.

As you see: you cannot have the needed knowledge inside the kernel.


> 2. A Linux system should have as few suid root binaries as possible.

If you like this completely, you would need to implement something RBAC and
getppriv(2)(setpiriv(2) on Solaris. If you have this, you have zero suid
root binaries on a 'Trusted OS' and one suid binary (/usr/bin/pfexec) on a non 
Trusted system.

> 3. A normal user should be able to perform most tasks without needing
>    root.

Duable if my remark to 2) has been implemented.

> As you said, since the old kernel behaviour is a gaping security hole,
> Linus had no other choice than to add a CAP_SYS_RAWIO check to the
> SG_IO call.  This fulfills goal 1.  Unfortunately it breaks just about

Not true: a simple check like in my scg driver:

        /* 
         * Must have read/write access to /dev/scgxx 
         * to send commands over SCSI Bus. 
         */ 
        if ((flag&(FREAD|FWRITE)) != (FREAD|FWRITE)) 
                return (EACCES); 

was sudfficient.

> every application that expects to be able to send raw SCSI commands
> without being root.
>
> There are a couple of ways of fulfilling goal 3 and allow normal users
> to burn a CDR:
>
> One is to make cdrecord suid root and then make it drop all
> capabilities except for SYS_CAP_RAWIO.  But even if cdrecord is
> audited, there are a lot of other applications that need to be able to
> send raw SCSI commands such as mt (to change the compression or tape
> format of a streamer).  And this violates goal 2, every security guide
> I've seen lately recommends minimizing the amount of suid binaries,
> not adding more.

A better way is to have services like this in /usr/bin/pfexec that 
do the ecirity related parts before calling the other binaries.

BTW: 'mt' should not need to send SCSI comands. THis shoul dbe handled via
specilized ioctls.


> I think Joerg is being much too harsh, adding a check for
> CAP_SYS_RAWIO fixes a bloody large security hole.  It broke a few
> applications, but tough shit, that is what happens every now and then

With checking for ((flag&(FREAD|FWRITE)) != (FREAD|FWRITE)) less applications
would break.

> when plugging security holes.  It would be much worse to leave the
> hole open.  The timing may coincide badly with the release cycle of
> cdrecord, but thats life.  For now users will have to run cdrecord as
> root to be able to burn a CDR.

The result will be that users "find solutions" that will be less secure as
when only a check for ((flag&(FREAD|FWRITE)) != (FREAD|FWRITE)) has been 
introduced and _later_ (in an agreement with prominent applications)
require root when issuing SCSI commands.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
