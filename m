Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRB1Xx3>; Wed, 28 Feb 2001 18:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRB1XxT>; Wed, 28 Feb 2001 18:53:19 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:51214 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129156AbRB1XxI>; Wed, 28 Feb 2001 18:53:08 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Thu, 1 Mar 2001 09:15:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15005.30849.720697.525157@notabene.cse.unsw.edu.au>
Cc: David Fries <dfries@umr.edu>, linux-kernel@vger.kernel.org
Subject: Re: Stale NFS handles on 2.4.2
In-Reply-To: message from Trond Myklebust on  February 28
In-Reply-To: <20010214002750.B11906@unthought.net>
	<20010224141855.B12988@d-131-151-189-65.dynamic.umr.edu>
	<15000.39826.947692.141119@notabene.cse.unsw.edu.au>
	<20010224235342.D483@d-131-151-189-65.dynamic.umr.edu>
	<15000.53110.664338.230709@notabene.cse.unsw.edu.au>
	<20010225131013.E483@d-131-151-189-65.dynamic.umr.edu>
	<15004.16978.439300.108625@notabene.cse.unsw.edu.au>
	<shsd7c3817s.fsf@charged.uio.no>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  February 28, trond.myklebust@fys.uio.no wrote:
> >>>>> " " == Neil Brown <neilb@cse.unsw.edu.au> writes:
> 
>      > So... you can access things under /home/david, but you cannot
>      > access /home/david itself?  So, supposing that "fred" were some
>      > file that you happen to know is in /home/david, then
> 
>      >     ls /home/david fails with ESTALE and does not cause
>      > 			       any traffic to the server and
> 
> This is normal. Once an inode gets flagged as being stale, then it
> remains stale. After all it would be a bug too if a filehandle were
> stale one moment, and then not the next.
> 
I don't think that is necessarily a bug.
If I mis-configured the server to deny access to a particular client,
the client would start getting NFSERR_STALE responses.  I notice the
problem and reconfigure the server and I would expect the ESTALE
errors to go away.  But apparently they don't.   Or atleast they don't
as long as the inode stays in the cache.  Once it gets flushed from
the cache, a lookup will cause everything to work again.
But if an object below a "STALE" directory is being held open, the
inode will never get flushed and so the inode stays stale.

What is really odd about this situation is that whenever David tries
to access his home directory (/home/david) nfs_lookup_revalidate will
be called which will (if the cache isn't fresh enough) do a "lookup"
which returns the filehandle and attributes of /home/david.  This
should be enough to convince the client that the filehandle isn't
stale anymore.  However nfs_refresh_inode doesn't use this information
to clear the NFS_INO_STALE flag.  Maybe it should.

In short, I really don't think that NFS_INO_STALE (or any other item
if information received from the server) should be considered to be
permanent and never rechecked.

NeilBrown


> The question here is therefore really why did the server tell us that
> the filehandle was stale in the first place.
> 
> Cheers,
>    Trond
