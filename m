Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSICQD0>; Tue, 3 Sep 2002 12:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318725AbSICQD0>; Tue, 3 Sep 2002 12:03:26 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:47030 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S318249AbSICQDY>; Tue, 3 Sep 2002 12:03:24 -0400
Date: Tue, 3 Sep 2002 12:07:56 -0400
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-PATCH-2.5] Introduce new VFS inode cache lookup function
Message-ID: <20020903160755.GD9903@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Anton Altaparmakov <aia21@cantab.net>,
	linux-kernel@vger.kernel.org
References: <20020903152228.GB9903@ravel.coda.cs.cmu.edu> <Pine.SOL.3.96.1020903162736.14707C-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.3.96.1020903162736.14707C-100000@libra.cus.cam.ac.uk>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 04:31:32PM +0100, Anton Altaparmakov wrote:
> On Tue, 3 Sep 2002, Jan Harkes wrote:
> > On Tue, Sep 03, 2002 at 06:20:44AM +0100, Anton Altaparmakov wrote:
> > > 2) It will return inodes that are I_FREEING or I_CLEAR. I will have to
> > > test for these in NTFS and then iput() to wash my hands clean of such
> > > garbage. And if I am not mistaken, the iput() actually will BUG().
> > 
> > If that is the case iget is broken. Perhaps it should test for these
> > states in find_inode (and find_inode_fast) and never return them. Are
> > those types of inodes still on the inode hash?
> 
> That is of course the big question. As I said I haven't looked at this
> very closely...

<handwaving> There is no problem here </handwaving>

invalidate_list, prune_icache, generic_delete_inode, and
generic_forget_inode all move the inode off of the inode hash before
setting the I_FREEING flag. So inodes in I_FREEING state can not be
found by find_inode.

Clear inode bugs when the inode is not I_FREEING, it then clears out the
inode and sets I_CLEAR. As a result, inodes in I_CLEAR state can not be
found by find_inode either.

So you can safely remove that test in ilookup.

> > > 4) If anything, as Christoph Hellwig suggested to me on #kernel,
> > > iget{,5}_locked() should be reimplemented in terms of my ilookup()
> > > implementation and not vice versa. (-:
> > 
> > Well, considering that this function (modulo the I_FREEING|I_CLEAR test
> > is identical to the first 10 lines in iget5_locked, this could call that
> > function. Ofcourse iget_locked is using the 'fast' version of find_inode.
> 
> Yes, indeed, and yes. I recall that Al wanted the _fast() versions to
> remain separate. This can be done easily enough here, too. For example
> ilookup()  and ilookup5() (to remain consistent with iget5() or if you
> have a better idea for a name...). 

I have no problem with the name. And coda_fid_to_inode could use
ilookup5 as well, as currently uses iget with the 'set_fail' trick.

Jan

