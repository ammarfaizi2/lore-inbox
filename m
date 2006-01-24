Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbWAXSSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbWAXSSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWAXSSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:18:20 -0500
Received: from mail.gmx.de ([213.165.64.21]:63400 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932485AbWAXSST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:18:19 -0500
X-Authenticated: #428038
Date: Tue, 24 Jan 2006 19:18:13 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060124181813.GA30863@merlin.emma.line.org>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Lee Revell <rlrevell@joe-job.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe> <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt schrieb am 2006-01-24:

> >2. find out the current state of affairs,
> 
> I am currently able to properly write all sorts of CD-R/RW and DVD±R/RW, 
> DVD-DL with no problems using
>     cdrecord -dev=/dev/hdb
> it _currently_ works, no matter how ugly or not this is from either Jörg's 
> or any other developer's POV - therefore it's fine from the end-user's POV.

cdrecord simply assumes that if you don't have access to /dev/hda,
scanning the other devices is pointless, on the assumption it were a
security risk. How this fits into user profiles that might allow access
to /dev/hdc, is unclear to me.

> I can write DVDs at 8x speed (approx 10816 KB/sec) - which looks like DMA 
> is working through the current mechanism, although I can't confirm it.

/dev/hd* and ATA: support DMA, newer cdrecord versions actually check
the DMA speed before starting write operations without burnproof.

> There have been reports that cdrecord does not work when setuid, but only 
> when you are "truly root". Not sure where this comes from,
> (current->euid==0&&current->uid!=0 maybe?) scsi layer somewhere?

Locking pages in memory so they aren't swapped out (a requirement for
real-time applications) -- that's the original reason for my
RLIMIT_MEMLOCK question that preceded this thread.

> If you can access a _harddisk_ as a normal user, you _do have_ a security 
> problem. If you can access a cdrom as normal user, well, the opinions 
> differ here. I think you _should not either_, because it might happen that 
> you just left your presentation cd in a cdrom device in a public box. You 
> would certainly not want to have everyone read that out.

That's less of a problem than sending vendor-specific commands - one
might be "update firmware", which would allow the user to destroy the
drive.

> SUSE currently does it in A Nice Way: setfacl'ing the devices to include 
> read access for currently logged-in users. (Well, if someone logs on tty1 
> after you, you're screwed anyway - he could have just ejected the cd when 
> he's physically at the box.)

There are some things to complicate matters. SUSE patch subfs into the
kernel and ship the needed user-space, think of this as quick
automounter. It releases the drive and unmounts the medium when the last
file is closed. In older SUSE releases, tty? logins didn't trigger
such access controls, only "desktop" logins through kdm or gdm.

> Yes, the device numbering is not optimal. (I already hear someone saying 
> 'have udev make some sweety symlink in /dev'.)
> But in case of /dev/hd*, we are pretty sure of what device is connected 
> where. In case of sd*, it's AFAICS not - the next device plugged in gets 
> the next free sd slot.

What matters is sg, and perhaps sr.

-- 
Matthias Andree
