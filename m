Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278665AbRK1RbR>; Wed, 28 Nov 2001 12:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRK1RbH>; Wed, 28 Nov 2001 12:31:07 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:43649 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S278381AbRK1Ra4>; Wed, 28 Nov 2001 12:30:56 -0500
Message-ID: <00b201c17832$4c4ff150$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Jens Axboe" <axboe@suse.de>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Linus Torvalds" <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL> <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com> <20011127183418.A812@vger.timpanogas.org> <20011128143551.U23858@suse.de>
Subject: Re: Block I/O Enchancements, 2.5.1-pre2
Date: Wed, 28 Nov 2001 10:29:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Jens Axboe" <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Linus Torvalds" <torvalds@transmeta.com>;
<linux-kernel@vger.kernel.org>; <jmerkey@timpanogas.org>
Sent: Wednesday, November 28, 2001 6:35 AM
Subject: Re: Block I/O Enchancements, 2.5.1-pre2


> On Tue, Nov 27 2001, Jeff V. Merkey wrote:
> > On Tue, Nov 27, 2001 at 05:04:46PM -0800, Linus Torvalds wrote:
> > >
> > > On Wed, 28 Nov 2001, Paul Mackerras wrote:
> > > >
> > > > Is there a description of the new block layer and its interface to
> > > > block device drivers somewhere?  That would be helpful, since Ben
> > > > Herrenschmidt and I are going to have to convert several
> > > > powermac-specific drivers.
> > >
> > > Jens has something written up, which he sent to me as an introduction
to
> > > the patch. I'll send that out unless he does a cleaned-up version, but
I'd
> > > actually prefer for him to do the sending. Jens?
> > >
> > > Linus
> > >
> >
> >
> > Linus/Jens,
> >
> > I've just completed my review of submit_bio and the changes to
> > generic_make_request and I have some questions for whomever
> > can answer.
> >
> > 1.  The changes made to submit_bh indicate I can now send long
> > chains of variable block size requests to the I/O layer similiar
> > to the capability of Windows 2000 and NetWare I/O subsystems.
>
> Yes, you can build generically a single I/O unit that spans up to 256
> pages. If you bypass the bio_alloc/bvec_alloc mechanism, the sky is the
> limit. Beware that a really big bio may need to be split up in the end
> for devices that can't handle them that big.


I got your docs and tried this.

>
> > 2.  The elevator layer is merging these requests, and making a
> > single sweep request for contiguous sector runs.
>
> Like always, yes.
>
> > 3.  In theory, I should be able to support page cache capability
> > for NWFS and possibly NTFS in Linux the way these wierd non-Unix
> > OS's work.
>
> Maybe :-)

The next posting of NWFS will have the page cache enabled.  I am testing the
code
this morning.  I also have reduced the memory usage to about 1/100 of what I
was doing
with the in-memory name hashes.  I never liked the way NetWare did this.
It's fast
as hell for lookups, but sure uses a lot of memory.

>
> > 4.  This interface may **NOT** support non-block aligned requests
> > across all the drivers.  I also need to be able to submit a
> > request chain 512-2048-512-1024-4096 where the first IO requested
> > may by on a non-block aligned boundry.  i.e.  Device is configured
> > for 1024 byte blocks, I start the request as 512 @ LBA 1 -> 1024 @ LBA
2,
> > etc.  The code looks like it will work.
>
> As long as the smallest unit above is at least the size of the hardware
> sector on the target, it should be ok.

Some of the Adaptec drivers will be busted.  I remmeber trying this once
before at
Linus' suggestion about a year ago, and I saw significant breakage.  Oh
well, this
is 2.5.  I guess folks will just have to fix their drivers if this breaks
them.

>
> > I would love to test this wonderful code and will hopefully this
evening,
> > however, all the SCSI drivers appear to be broken, as well as the
> > 3Ware. :-)
>
> Well not all, but many. I only converted stuff I could personally test,
> basically, plus a bit more. Usually converting a SCSI driver is not a
> lot of work, please see the changes to sym/sym2 etc in the pre2 patch.

I am testing on IDE systems -- no IDE breakage at present.  Andre's IDE
drivers are
some of the fastest implementations out there and are comparable in
performance to
SCSI.

Jeff


>
> --
> Jens Axboe
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

