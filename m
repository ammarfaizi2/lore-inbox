Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSDAAFD>; Sun, 31 Mar 2002 19:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSDAAEy>; Sun, 31 Mar 2002 19:04:54 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23360 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290289AbSDAAEq>; Sun, 31 Mar 2002 19:04:46 -0500
Date: Mon, 1 Apr 2002 02:04:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: 2.4.19pre5aa1 and splitted vm-33
Message-ID: <20020401020417.K1331@dualathlon.random>
In-Reply-To: <20020331164815.A1331@dualathlon.random> <20020331191059.A16769@phoenix.infradead.org> <20020331203830.D1331@dualathlon.random> <20020331200038.B18052@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 08:00:38PM +0100, Christoph Hellwig wrote:
> On Sun, Mar 31, 2002 at 08:38:30PM +0200, Andrea Arcangeli wrote:
> > Hmm that's a problem. BTW, is there any valid reason xfs isn't
> > implementing O_DIRECT via the direct_IO address space operation like the
> > other filesystems ext2/reiserfs/nfs? (of course I'm talking long term, I
> > don't pretend to change that in one day, for the short term we should
> > still allow xfs to use its own internal methods of doing O_DIRECT)
> 
> For definitve answers you have to ask Steve or some else from the XFS crow,
> but if you look at the XFS data I/O path is is completly different from
> the generic Linux filesystems due to the IRIX history/compatiblity and the
> 'need' for features not present in the core kernel.  Before 2.4.10 one
> of those was O_DIRECT, btw..

Yep I understand that, it was more a request for comments on the API, to
learn if they've any design limitation with that generic API, I know it
would be tricky to convert xfs, not something I'd expect in a minor
release, I was talking a bit longer term, not necessairly for 2.4. XFS
doesn't journal data so my point was it should be just fine in theory
with the current aops direct_IO API.

For 2.5 we also need a generic library function that puts anchors into
the pagecache hash too, simulating locked pages, to serialize the I/O on
the data too during O_DIRECT to allow cleanly O_DIRECT with _data_
journaling.

> > Fixing that should be a one liner setting a_ops->direct_IO to
> > ERR_PTR(-1L) within xfs. Comments?
> 
> Looks good to me.

Ok.

> > > For the open case putting the check into generic_file_open sounds good to me,
> > 
> > One problem with generic_file_open is that we'd need to rely on all
> > lowlevel open callbacks to do the check properly if they don't support
> > O_DIRECT and we'd need to duplicate code, only a few fs uses
> > generic_file_open.  Lefting it in the vfs looked cleaner, it reduces the
> > check to a few liner patch.
> > 
> > The lowlevel callback can always drop the kiovec during its own ->open
> > if they don't need it, even if they uses direct_IO, like nfs.
> 
> I don't think this is a good design decision, but I can live with it for
> 2.4 - for 2.5 I'm still hoping for bcrls kvec to replace the current kiobuf
> stuff and we have to see what that means for O_DIRECT.

Avoiding code duplication and taking the API simpler is the good part,
but I see nfs would be penalized (first it allocates and the
deallocates). I agree it's not the best design to get the maximal
performance with nfs and some other, it was mostly a 2.4 thing infact,
as you say with 2.5 if the kiobuf overhead is dropped then we may not
need to preallocate the kiobuf in the first place, then this whole
discussion about "where to preallocate" will be pointless. Also the
kiobuf-slab patch should just make it significantly faster compared to
the current prohibitive vmalloc.

> > > kiobufs even if XFS doesn't need them..
> > 
> > Chuck's patch is handling fcntl as well, do you see any problem there?
> > (modulo the fact the kiovec is pre-allocated even if not necessary, like
> > in open(2)?)
> 
> It's this same issue, there is no other problem in my eyes.

Ok.

Thanks,

Andrea
