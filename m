Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWAYOGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWAYOGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWAYOGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:06:07 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:26276 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751169AbWAYOGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:06:06 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 15:04:53 +0100
To: matthias.andree@gmx.de, jengelh@linux01.gwdg.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: 
 Rationale for RLIMIT_MEMLOCK?)
Message-ID: <43D78585.nailD7855YVBX@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org>
 <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >1. compile a list of their requirements,
>
> Have as few code duplicated (e.g. ATAPI and SCSI may share some - after 
> all, ATAPI is (to me) some sort of SCSI tunneled in ATA.)

Thank you! This is a vote _pro_ a unified SCSI generic implementation for all
types of devices. The current implementation unneccssarily duplicates a lot 
of code.

> Make it, in accordance with the above, possible to have as few kernel 
> modules loaded as possible and therefore reducing footprint - if I had not 
> to load sd_mod for usb_storage fun, I would get an itch to load a 78564 
> byte scsi_mod module just to be able to use ATAPI. (MINOR one, though.)

On Solaris, the SCSI glue code (between hostadaptor drivers and target drivers) is 
really small:

/usr/ccs/bin/size /kernel/misc/scsi 
28482 + 27042 + 2036 = 57560

And if you check the amount of completely unneeded code Linux currently has 
just to implement e.g. SG_IO in /dev/hd*, it could even _save_ space in the 
kernel when converting to a clean SCSI based design.


> Want to write CDs and DVDs "as usual" (see below).

Be careful: libscg is a _generic_ SCSI transport library.
Closing the eyes for anything but CD writing is not the right way.


> De-forest the SCSI subsystem for privilege checking (see below).

Sorry, I see nothing related below.


> >2. find out the current state of affairs,
>
> I am currently able to properly write all sorts of CD-R/RW and DVDÂ±R/RW, 
> DVD-DL with no problems using
>     cdrecord -dev=/dev/hdb

Maybe I should enforce the official libscg device syntax in order to prevent 
this from working in the future.

Anyway: the fact that it may work is no proof for correctness.


> I can write DVDs at 8x speed (approx 10816 KB/sec) - which looks like DMA 
> is working through the current mechanism, although I can't confirm it.

In case you don't knw the story:

	Linus Torvalds once claimed that introducing SG_IO support for
	/dev/hd* would be acompanied with cleaning up DMA support in the kernel.

	At that moment it turned out that it did not help at all as /dev/hd*
	did not give DMA. Later this bug was fixed, but I am still waiting
	to see the proposed DMA fix for ide-scsi.


> There have been reports that cdrecord does not work when setuid, but only 
> when you are "truly root". Not sure where this comes from,
> (current->euid==0&&current->uid!=0 maybe?) scsi layer somewhere?

Depends on what you talk about. 

Since about a year, there is a workaround for the incompatible interface change 
introduced with Linux-2.6.8.1

On a recent RedHat system, cdrecord works installed suid root.

On a system running a kernel.org based Linux it has been reported to fail
because it does not get a SCSI transfer buffer.



> >write a CD anyways". I find this wrong, JÃ¶rg finds it correct and argues
> >"if you can access /dev/hdc as unprivileged user, that's a security
> >problem".
>
> If you can access a _harddisk_ as a normal user, you _do have_ a security 
> problem. If you can access a cdrom as normal user, well, the opinions 
> differ here. I think you _should not either_, because it might happen that 
> you just left your presentation cd in a cdrom device in a public box. You 
> would certainly not want to have everyone read that out.

Do you  want everybody to be able to read or format a floppy disk?
Ignoring usual security rules sometimes _seem_ to make life easier but usually 
does not. Just look in what kind of jungle Microsoft is just because that 
started to allow insanely things for the sake of "user convenience".


> SUSE currently does it in A Nice Way: setfacl'ing the devices to include 
> read access for currently logged-in users. (Well, if someone logs on tty1 
> after you, you're screwed anyway - he could have just ejected the cd when 
> he's physically at the box.)

It may make sense to do something like this for the user logged into the 
console. In general it is a security problem.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
