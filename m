Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132024AbQKVBDB>; Tue, 21 Nov 2000 20:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbQKVBCv>; Tue, 21 Nov 2000 20:02:51 -0500
Received: from adsl-63-194-89-126.dsl.snfc21.pacbell.net ([63.194.89.126]:41996
	"HELO skull.piratehaven.org") by vger.kernel.org with SMTP
	id <S131993AbQKVBCb>; Tue, 21 Nov 2000 20:02:31 -0500
Date: Tue, 21 Nov 2000 16:27:32 -0800
From: Brian Pomerantz <bapper@piratehaven.org>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CMA <cma@mclink.it>, tytso@mit.edu,
        card@masi.ibp.fr, linux-kernel@vger.kernel.org
Subject: Re: e2fs performance as function of block size
Message-ID: <20001121162732.A7479@skull.piratehaven.org>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, CMA <cma@mclink.it>,
	tytso@mit.edu, card@masi.ibp.fr, linux-kernel@vger.kernel.org
In-Reply-To: <E13yMvv-0005Ly-00@the-village.bc.nu> <3A1B0DFC.72E4E9FF@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A1B0DFC.72E4E9FF@timpanogas.org>
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 05:06:20PM -0700, Jeff V. Merkey wrote:
> 
> 
> Alan Cox wrote:
> > 
> > > Sirs,
> > > performing extensive tests on linux platform performance, optimized as
> > > database server, I got IMHO confusing results:
> > > in particular e2fs initialized to use 1024 block/fragment size showed
> > > significant I/O gains over 4096 block/fragment size, while I expected t=
> > > he
> > > opposite. I would appreciate some hints to understand this.
> > 
> > It may be that your database is writing out 1K sized blocks on random
> > boundaries. If so then the behaviour you describe would be quite reasonable.
> 
> Alan,
> 
> Perhaps, but I have reported this before and seen something similiar. 
> It's as though the disk drivers are optimized for this case (1024).  I
> get better performance running NWFS at 1024 block size vs. all the other
> sizes, even with EXT2 configured to use 4096, etc.  At first glance,
> when I was changing block sizes, I did note that by default, EXT2 set to
> 1024 would mix buffer sizes in the buffer cache, which skewed caching
> behavior, but there is clearly some optimization relative to this size
> inherent in the design of Linux -- and it may be a pure accident.  This
> person may be mixing and matching block sizes in the buffer cache, which
> would satisfy your explanation.
> 

You may want to try using raw I/O to fully characterize the behavior
of you device.  I found that when I use raw I/O I could get very good
performance characteristics for devices.  If you use dd with a raw
device you can vary the block size to see what kind of performance you
get out of different sizes.  This will completely bypass any affects
of buffer cache to get you the performance of the disk in question.
An example of this would be to run this sequence of commands noting
the time it takes to run it (all transfers 100MB):

	time dd if=/dev/zero of=/dev/raw1 bs=512 count=204800
	time dd if=/dev/zero of=/dev/raw1 bs=1k  count=102400
	time dd if=/dev/zero of=/dev/raw1 bs=4k  count=25600
	...

The standard Stephen Tweedie raw I/O will do up to 64KB chunks, beyond
that you'll probably have to write one specific to your device (SGI
has one for SCSI which I've gotten up to 1MB reads/writes).  Using dd
doesn't necessarily show you your performance as most access patterns
will not be completely sequential in nature, but you can figure out
what your "sweet spot" is for your block size.


BAPper
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
