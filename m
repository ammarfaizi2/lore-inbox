Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268565AbUJDVSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268565AbUJDVSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUJDVSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:18:31 -0400
Received: from pD9FF1A09.dip.t-dialin.net ([217.255.26.9]:16644 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S268565AbUJDVSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:18:12 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Fw: Re: 2.6.9-rc2-mm4
Date: Mon, 4 Oct 2004 23:14:13 +0200
User-Agent: KMail/1.7
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040929214637.44e5882f.akpm@osdl.org> <200410042212.32106.petkov@uni-muenster.de> <20041004204214.GB9022@suse.de>
In-Reply-To: <20041004204214.GB9022@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410042314.13588.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 22:42, Jens Axboe wrote:
> On Mon, Oct 04 2004, Borislav Petkov wrote:
> > On Monday 04 October 2004 19:36, Jens Axboe wrote:
> > > On Mon, Oct 04 2004, Borislav Petkov wrote:
> > > > Ok here we go,
> > > >
> > > > final results:
> > > >
> > > >  2.6.8-rc1: OK
> > > >  2.6.8-rc2: OK
> > > >  2.6.8-rc3: OK
> > > >  2.6.8-rc3-bk1: OK
> > > >  2.6.8-rc3-bk2: OK
> > > >  2.6.8-rc3-bk3: OK
> > > >  2.6.8-rc3-bk4: OK
> > > >  2.6.8-rc4: BUG!
> > > >
> > > > So, assuming that everything went fine during testing, the bug got
> > > > introduced in the transition between 2.6.8-rc3-bk4 and 2.6.8-rc4.
> > >
> > > That's some nice testing, thank you. Try backing out this hunk:
> > >
> > > diff -urp linux-2.6.8-rc3-bk4/drivers/block/scsi_ioctl.c
> > > linux-2.6.8-rc4/drivers/block/scsi_ioctl.c ---
> > > linux-2.6.8-rc3-bk4/drivers/block/scsi_ioctl.c 2004-08-03
> > > 23:28:51.000000000 +0200 +++
> > > linux-2.6.8-rc4/drivers/block/scsi_ioctl.c 2004-08-10
> > > 04:24:08.000000000 +0200 @@ -90,7 +90,7 @@ static int
> > > sg_set_reserved_size(request_ if (size < 0)
> > >    return -EINVAL;
> > >   if (size > (q->max_sectors << 9))
> > > -  return -EINVAL;
> > > +  size = q->max_sectors << 9;
> > >
> > >   q->sg_reserved_size = size;
> > >   return 0;
> > >
> > > It's the only thing that sticks out, and it could easily explain it if
> > > your cd ripper starts issuing requests that are too big. Maybe even add
> > > a printk() here, so it will look like this in the kernel you test:
> > >
> > >  if (size > (q->sectors << 9)) {
> > >   printk("%u rejected\n", size);
> > >   return -EINVAL;
> > >  }
> > >
> > > to verify.
> >
> > Yeah, that was it. Two lines in the log:
> >
> > Oct 4 22:07:04 zmei kernel: 3145728 rejected
> > Oct 4 22:07:04 zmei kernel: 3145728 rejected
> >
> > Hmm, so this means that my dvd drive is sending too big requests. What do
> > we do: firmware upgrade?
>
> It actually means we have a little discrepancy between what programs
> expact of the api. What program are you using? They are supposed to read
> back what value has been set with SG_GET_RESERVED_SIZE, I guess this one
> does not.
>
> What's a little extra strange is that this command apparently doesn't
> have ->dxfer_len set to the correct size, or it should be caught in
> sg_io() at issue time.

Sorry if I've flooded your mails but I've been playing with Postfix ... 8)

Boris.
