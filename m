Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312588AbSDFQwa>; Sat, 6 Apr 2002 11:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312604AbSDFQw3>; Sat, 6 Apr 2002 11:52:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47080 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312588AbSDFQw2>;
	Sat, 6 Apr 2002 11:52:28 -0500
Date: Sat, 6 Apr 2002 11:52:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [WTF] ->setattr() locking changes
In-Reply-To: <Pine.LNX.4.33.0204060818440.16963-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0204061131040.632-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Apr 2002, Linus Torvalds wrote:
 
> > _Please_, grep before doing global changes.  Trivial search for
> > notify_change() would show several calls under ->i_sem.  E.g. one
> > in fs/nfsd/vfs.c.  Or in hpfs_unlink().
> 
> Hmm.. I don't think the fs/nfsd/vfs.c case is "obviously" under i_sem.  
> Certainly not from grepping. Where?

fh_lock()/fh_unlock().  Hell, it does call notify_change() with ATTR_SIZE,
so unless i_sem was taken by caller we would be in big trouble, wouldn't
we?  Old rules were "if you call it to truncate a file, grab i_sem".

> The hpfs/namei.c one definitely needs the removal of the up/down, though. 
> Altghough for the life of me I don't see why the filesystem _does_ that at 
> all, since it should have been done by the upper layers already, no?

<looking> oh, crap.

OK, here's the story:
	* HPFS can run out of space trying to remove entry from directory.
Joys of badly implemented B-Trees.  So as a last-ditch we try to truncate
victim in hope that it will give us some space.  _If_ there is nobody else
who'd have access to it.  Thus the truncate() attempt.
	* my flame re grep(1) applies to myself - first deadlock in there
had been created by new locking rules patch (in fs/namei.c).
	* Dave's patch had added one more level of the same.  Happy, happy,
joy, joy...

	Looking at that stuff, I'd suggest to
a) kill that branch in hpfs_unlink().
b) remove fh_lock()/fh_unlock() in nfsd/vfs.c::nfsd_setattr() (Trond?)
c) add ATTR_SXID that would do s[ug]id removal - under ->i_sem and switch
   the callers to it.

Comments?  If you don't see any problems with this variant I'll do it.

