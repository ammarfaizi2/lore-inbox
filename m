Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSFDLiG>; Tue, 4 Jun 2002 07:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSFDLiF>; Tue, 4 Jun 2002 07:38:05 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:42460 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316591AbSFDLiF>; Tue, 4 Jun 2002 07:38:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andi Kleen <ak@suse.de>
Date: Tue, 4 Jun 2002 21:37:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15612.42635.591842.153876@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Caching files in nfsd was Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: message from Andi Kleen on  June 4
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  June 4, ak@suse.de wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > I _think_ that right now nfsd doesn't cache file opens (only inodes), so
> > this could be a performance issue for nfsd, but it might be possible to
> > change how nfsd acts. And it would be a _lot_ cleaner to do it at the file
> > level.
> 
> Yes.
> 
> Fixing this would also help XFS (which I hope will be merged in 2.5 as
> it works very well for a lot of people). It manages its extent
> preallocation per file and flushes extents on closes. Currently it has
> to maintain an ugly private nfs reference cache to avoid flushing an
> extent after every NFS write operation (and killing write performance
> this way)
> 
> Also letting nfsd know about the filemap.c readahead window information in 
> struct file (that is what it currently caches in the racache) is really ugly
> and a kind of layering violation...

I agree.  I would like to replace the racache with a "struct file"
cache (though it isn't high on my priorities).

The only issue that I can see (except for simple coding) is that as
NFS cannot be precise about closing at the *right* time we would be
changing from closing too early (and so re-opening) to closing too
late.
Would this be an issue for any filesystem?  My feeling is not, but I'm
open to opinions....

This is an issue for the user-space NFS daemon.  It caches open
filedescriptors and an open O_RDWR will imply an active
get_write_access which, for example, stops the file being executed on
the server.
kNFSd won't suffer from this as it can drop write_access without
closing the file.  Are there any other issues?

NeilBrown
