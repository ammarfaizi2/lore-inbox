Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWAXRmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWAXRmq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWAXRmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:42:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:4526 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030490AbWAXRmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:42:46 -0500
Date: Tue, 24 Jan 2006 18:42:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Lee Revell <rlrevell@joe-job.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:
 Rationale for RLIMIT_MEMLOCK?)
In-Reply-To: <20060123212119.GI1820@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1839653833-1138124561=:28682"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1839653833-1138124561=:28682
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


I'm joining in,
>
>1. compile a list of their requirements,

Have as few code duplicated (e.g. ATAPI and SCSI may share some - after 
all, ATAPI is (to me) some sort of SCSI tunneled in ATA.)

Make it, in accordance with the above, possible to have as few kernel 
modules loaded as possible and therefore reducing footprint - if I had not 
to load sd_mod for usb_storage fun, I would get an itch to load a 78564 
byte scsi_mod module just to be able to use ATAPI. (MINOR one, though.)

Want to write CDs and DVDs "as usual" (see below).

De-forest the SCSI subsystem for privilege checking (see below).


>2. find out the current state of affairs,

I am currently able to properly write all sorts of CD-R/RW and DVD±R/RW, 
DVD-DL with no problems using
    cdrecord -dev=/dev/hdb
it _currently_ works, no matter how ugly or not this is from either Jörg's 
or any other developer's POV - therefore it's fine from the end-user's POV.

I can write DVDs at 8x speed (approx 10816 KB/sec) - which looks like DMA 
is working through the current mechanism, although I can't confirm it.

There have been reports that cdrecord does not work when setuid, but only 
when you are "truly root". Not sure where this comes from,
(current->euid==0&&current->uid!=0 maybe?) scsi layer somewhere?

I'm fine (=I agree) with the general possibility of having it setuid, 
though.

>3. match the lists found in 1 and 2
>
>4. ONLY AFTER THAT negotiate who is going to change what to make things
>   work better for us end users.

>S3 Device enumeration/probing is a sore spot. Unprivileged "cdrecord
>dev=ATA: -scandisk" doesn't work, and recent discussions on the cdwrite@
>list didn't make any progress. My observation is that cdrecord stops
>probing /dev/hd* devices as soon as one yields EPERM, on the assumption
>"if I cannot access /dev/hda, I will not have sufficient privilege to
>write a CD anyways". I find this wrong, Jörg finds it correct and argues
>"if you can access /dev/hdc as unprivileged user, that's a security
>problem".

If you can access a _harddisk_ as a normal user, you _do have_ a security 
problem. If you can access a cdrom as normal user, well, the opinions 
differ here. I think you _should not either_, because it might happen that 
you just left your presentation cd in a cdrom device in a public box. You 
would certainly not want to have everyone read that out.

SUSE currently does it in A Nice Way: setfacl'ing the devices to include 
read access for currently logged-in users. (Well, if someone logs on tty1 
after you, you're screwed anyway - he could have just ejected the cd when 
he's physically at the box.)

Yes, the device numbering is not optimal. (I already hear someone saying 
'have udev make some sweety symlink in /dev'.)
But in case of /dev/hd*, we are pretty sure of what device is connected 
where. In case of sd*, it's AFAICS not - the next device plugged in gets 
the next free sd slot.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
--1283855629-1839653833-1138124561=:28682--
