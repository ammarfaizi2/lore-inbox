Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268916AbUJEJ3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268916AbUJEJ3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 05:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJEJ3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 05:29:42 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:58992 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268919AbUJEJ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 05:29:05 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Fw: Re: 2.6.9-rc2-mm4
Date: Tue, 5 Oct 2004 11:29:02 +0200
User-Agent: KMail/1.7
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040929214637.44e5882f.akpm@osdl.org> <200410042311.55584.petkov@uni-muenster.de> <20041005071245.GB2433@suse.de>
In-Reply-To: <20041005071245.GB2433@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410051129.02523.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 October 2004 09:12, Jens Axboe wrote:
> On Mon, Oct 04 2004, Borislav Petkov wrote:
> > On Monday 04 October 2004 22:42, Jens Axboe wrote:
> > > On Mon, Oct 04 2004, Borislav Petkov wrote:
> > > > On Monday 04 October 2004 19:36, Jens Axboe wrote:
> > > > > On Mon, Oct 04 2004, Borislav Petkov wrote:
> > > > > > Ok here we go,
> > > > > >
> > > > > > final results:
> > > > > >
> > > > > >  2.6.8-rc1: OK
> > > > > >  2.6.8-rc2: OK
> > > > > >  2.6.8-rc3: OK
> > > > > >  2.6.8-rc3-bk1: OK
> > > > > >  2.6.8-rc3-bk2: OK
> > > > > >  2.6.8-rc3-bk3: OK
> > > > > >  2.6.8-rc3-bk4: OK
> > > > > >  2.6.8-rc4: BUG!
> > > > > >
> > > > > > So, assuming that everything went fine during testing, the bug
> > > > > > got introduced in the transition between 2.6.8-rc3-bk4 and
> > > > > > 2.6.8-rc4.
> > > > >
> > > > > That's some nice testing, thank you. Try backing out this hunk:
> > > > >
> > > > > diff -urp linux-2.6.8-rc3-bk4/drivers/block/scsi_ioctl.c
> > > > > linux-2.6.8-rc4/drivers/block/scsi_ioctl.c ---
> > > > > linux-2.6.8-rc3-bk4/drivers/block/scsi_ioctl.c 2004-08-03
> > > > > 23:28:51.000000000 +0200 +++
> > > > > linux-2.6.8-rc4/drivers/block/scsi_ioctl.c 2004-08-10
> > > > > 04:24:08.000000000 +0200 @@ -90,7 +90,7 @@ static int
> > > > > sg_set_reserved_size(request_ if (size < 0)
> > > > >    return -EINVAL;
> > > > >   if (size > (q->max_sectors << 9))
> > > > > -  return -EINVAL;
> > > > > +  size = q->max_sectors << 9;
> > > > >
> > > > >   q->sg_reserved_size = size;
> > > > >   return 0;
> > > > >
> > > > > It's the only thing that sticks out, and it could easily explain it
> > > > > if your cd ripper starts issuing requests that are too big. Maybe
> > > > > even add a printk() here, so it will look like this in the kernel
> > > > > you test:
> > > > >
> > > > >  if (size > (q->sectors << 9)) {
> > > > >   printk("%u rejected\n", size);
> > > > >   return -EINVAL;
> > > > >  }
> > > > >
> > > > > to verify.
> > > >
> > > > Yeah, that was it. Two lines in the log:
> > > >
> > > > Oct 4 22:07:04 zmei kernel: 3145728 rejected
> > > > Oct 4 22:07:04 zmei kernel: 3145728 rejected
> > > >
> > > > Hmm, so this means that my dvd drive is sending too big requests.
> > > > What do we do: firmware upgrade?
> > >
> > > It actually means we have a little discrepancy between what programs
> > > expact of the api. What program are you using? They are supposed to
> > > read back what value has been set with SG_GET_RESERVED_SIZE, I guess
> > > this one does not
> >
> > It is called cdda2wav and it is part of the cdrtools package by Joerg
> > Schilling.
>
> Then it's a bug for sure. Not because it's Joerg, but because the
> semantics in the newer kernel is what he wanted. And what sg has been
> doing for a long time. The difference is that if you go through
> sg/ide-scsi, the scsi mid layer will handle requeueing a request for
> you. Most other drivers don't support requests larger than what the
> drive can handle in one operation.
>
> You don't have an old version or anything like that, do you?
You mean cdda2wav? No I think it is a bleeding edge version since I run debian 
unstable:

Package: cdda2wav
Status: install ok installed
Priority: optional
Section: sound
Installed-Size: 324
Maintainer: Joerg Jaspert <joerg@debian.org>
Architecture: i386
Source: cdrtools
Version: 4:2.0+a38-1
Depends: libc6 (>= 2.3.2.ds1-4)
Suggests: vorbis-tools, cdrtools-doc
Conflicts: xcdroast (<< 0.98+0alpha11)
Description: Creates WAV files from audio CDs
 cdda2wav lets you digitally copy audio tracks from a CD-ROM, avoiding
 the distortion that is introduced when recording via a sound card. Data
 can be dumped into raw (cdr), wav or sun format sound files. Options control
 the recording format (stereo/mono; 8/16 bits; sampling rate, etc).
 .
 Please install cdrtools-doc if you want most of the documentation and
 Readme-files.

It is one of the latest alpha versions according to the cdrtools website.

Boris.
