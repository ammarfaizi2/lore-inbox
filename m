Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279603AbRJXVZG>; Wed, 24 Oct 2001 17:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279606AbRJXVYr>; Wed, 24 Oct 2001 17:24:47 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:34526 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S279603AbRJXVYl>; Wed, 24 Oct 2001 17:24:41 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jan Kara <jack@suse.cz>
Date: Thu, 25 Oct 2001 07:24:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15319.12709.29314.342313@notabene.cse.unsw.edu.au>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: message from Jan Kara on Wednesday October 24
In-Reply-To: <15310.25406.789271.793284@notabene.cse.unsw.edu.au>
	<20011024171658.B10075@atrey.karlin.mff.cuni.cz>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 24, jack@suse.cz wrote:
>   Hello,
> 
> >  In my ongoing effort to provide centralised file storage that I can
> >  be proud of, I have put together some code to implement tree quotas.
> > 

> >                                         du -s $HOME should *always*
> >  match your usage according to "quota".

>   But how do you solve the following: mv <dir> <some_other_dir>
> The parent changes. You need to go through all the subdirs of <dir> and change
> the TID. This is really hard to get right and to avoid deadlocks
> and races... At least it seems to me so.
> 

It is possible that at times not all objects in a tree have the same
tree-id.  This can happen in a number of ways.  One is moving a
directory between quota-trees.  Another is changing the owner of the
top directory in a quota tree.  Another is enabling tree quotas for
the first time in a filesystem (TID is not kept up-to-date if
treequotas are not enabled).  However:

1/ Non-root users (actually non-CAP_CHOWN processes)  cannot create
   such a situation. e.g. If the directory move would change the TID,
   then it is forbidden (EXDEV).
2/ At every lookup in a path_walk, the TID is checked against the
   parent.  If it is wrong, it is changed.  This causes TID's to tend
   towards correctness.


So if you move a directory between quota trees, then the usages will
be wrong in the first instance.  But only root can make this happen.
However, there is an easy way to fix it: just run a find or a du in
the new tree. 

If you get a situation where a file is linked into two different
quota-trees (which non-CAP_CHOWN processes  cannot do, but "root"
could achieve in several ways), then its usage charge will effectively
bounce between the two trees as it is accessed from either side.
Every time this happens, a KERN_WARNING message gets logged.

It is not a 'perfect' solution, as some times the real tree usage will
not match the recorded tree usages.

It is an 'acceptable' solution.  It keeps the goal that if you do a
"du" and then look at your quota usage, they will match (though the
other way round could in unusual circumstances not match).  It also
prevents non-root users from creating problematic situations.

It is, I think, the 'best' solution that is possible.

Note that the automatic re-assignment of quota that happens on lookup
if the TID is wrong by-passes quota checks.  It will always succeeed
no matter who is doing the lookup (I found a use for ATTR_FORCE!!).

Also the patch that I posted before had a few bugs.

  http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.13-pre6/patch-A-TreeQuotas

has those bugs removed.

NeilBrown
