Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275294AbRJYPsK>; Thu, 25 Oct 2001 11:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275270AbRJYPsB>; Thu, 25 Oct 2001 11:48:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31749 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275178AbRJYPrw>; Thu, 25 Oct 2001 11:47:52 -0400
Date: Thu, 25 Oct 2001 17:48:15 +0200
From: Jan Kara <jack@suse.cz>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011025174815.C4644@atrey.karlin.mff.cuni.cz>
In-Reply-To: <15310.25406.789271.793284@notabene.cse.unsw.edu.au> <20011024171658.B10075@atrey.karlin.mff.cuni.cz> <15319.12709.29314.342313@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15319.12709.29314.342313@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> > >  In my ongoing effort to provide centralised file storage that I can
> > >  be proud of, I have put together some code to implement tree quotas.
> > > 
> 
> > >                                         du -s $HOME should *always*
> > >  match your usage according to "quota".
> 
> >   But how do you solve the following: mv <dir> <some_other_dir>
> > The parent changes. You need to go through all the subdirs of <dir> and change
> > the TID. This is really hard to get right and to avoid deadlocks
> > and races... At least it seems to me so.
> > 
> 
> It is possible that at times not all objects in a tree have the same
> tree-id.  This can happen in a number of ways.  One is moving a
> directory between quota-trees.  Another is changing the owner of the
> top directory in a quota tree.  Another is enabling tree quotas for
> the first time in a filesystem (TID is not kept up-to-date if
> treequotas are not enabled).  However:
> 
> 1/ Non-root users (actually non-CAP_CHOWN processes)  cannot create
>    such a situation. e.g. If the directory move would change the TID,
>    then it is forbidden (EXDEV).
> 2/ At every lookup in a path_walk, the TID is checked against the
>    parent.  If it is wrong, it is changed.  This causes TID's to tend
>    towards correctness.
> 
> 
> So if you move a directory between quota trees, then the usages will
> be wrong in the first instance.  But only root can make this happen.
> However, there is an easy way to fix it: just run a find or a du in
> the new tree. 
  Umm.. I'm not sure about one thing: When you move the dir between the
trees when you update TID's? I understood that not during the move...
So the only possibility that I see is that each time you read the inode
you check whether its TID is OK. But that means going through dirs everytime
you read some inode which doesn't look nice to me...

> If you get a situation where a file is linked into two different
> quota-trees (which non-CAP_CHOWN processes  cannot do, but "root"
> could achieve in several ways), then its usage charge will effectively
> bounce between the two trees as it is accessed from either side.
> Every time this happens, a KERN_WARNING message gets logged.
> 
> It is not a 'perfect' solution, as some times the real tree usage will
> not match the recorded tree usages.
> 
> It is an 'acceptable' solution.  It keeps the goal that if you do a
> "du" and then look at your quota usage, they will match (though the
> other way round could in unusual circumstances not match).  It also
> prevents non-root users from creating problematic situations.
> 
> It is, I think, the 'best' solution that is possible.
  I also don't see a better solution but I'm not sure this solution is good
enough to be implemented (to me it looks more like a hack than a regular
part of system...).

									Honza

--
Jan Kara <jack@suse.cz>
SuSE CR Labs
