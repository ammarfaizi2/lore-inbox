Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292458AbSCRTRw>; Mon, 18 Mar 2002 14:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292368AbSCRTRq>; Mon, 18 Mar 2002 14:17:46 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36362 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S292316AbSCRTR2>; Mon, 18 Mar 2002 14:17:28 -0500
Message-ID: <3C963CD5.8E371FF@zip.com.au>
Date: Mon, 18 Mar 2002 11:15:33 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin K. Petersen" <mkp@mkp.net>
CC: Joel Becker <jlbec@evilplan.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au>
		<3C945D7D.8040703@mandrakesoft.com>
		<5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
		<20020318080531.W4836@parcelfarce.linux.theplanet.co.uk>
		<3C95A1DB.CA13A822@zip.com.au> <yq1bsdmq6so.fsf@austin.mkp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin K. Petersen" wrote:
> 
> >>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:
> 
> Andrew> O_DIRECT is broken against RAID0 (at least) in 2.5 at present.
> Andrew> The RAID driver gets sent BIOs which straddle two or more
> Andrew> chunks and RAID spits out lots of unpleasant warnings.  Neil
> Andrew> has been informed...
> 
> Yep.  I've been porting my original kiobuf based request splitter to
> biobufs.  It's almost there, I've just been extremely busy with
> something else for a while.
> 
> It's not only when you straddle chunks.  The current code does not
> handle requests straddling RAID zones either.

google fails me - where does your kiobuf-based splitter live?

I'm curious to know how this will all work.  Will it take a
large BIO and split it into a number of smaller, newly allocated
BIOs?  That would be kinda sad, IMO - the current bio-per-bh
allocations in the normal I/O path are really expensive, and
it seems wrong to take a large BIO, split it into lots of
teeny ones and then reassemble all the way down at the driver
level.

If that's really the only way in which we can solve this problem,
would it not be better to pass information up to the higher layer,
telling it when the BIO which is currently under assembly cannot
be grown further?  Say, blk_can_i_add_more_stuff_to_this_bio()?

Anyway.  I'm interested.  O_DIRECT is a bit of a weird curiosity,
but I'm working on making these big-BIO code paths *the* way in which
data gets to and from disk.  It needs to be efficient ;)

-
