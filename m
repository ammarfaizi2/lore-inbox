Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRJZEg2>; Fri, 26 Oct 2001 00:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277544AbRJZEgT>; Fri, 26 Oct 2001 00:36:19 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:39333 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277532AbRJZEgF>; Fri, 26 Oct 2001 00:36:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jan Kara <jack@suse.cz>
Date: Fri, 26 Oct 2001 14:36:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15320.59456.565780.111066@notabene.cse.unsw.edu.au>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: message from Jan Kara on Thursday October 25
In-Reply-To: <15310.25406.789271.793284@notabene.cse.unsw.edu.au>
	<20011024171658.B10075@atrey.karlin.mff.cuni.cz>
	<15319.12709.29314.342313@notabene.cse.unsw.edu.au>
	<20011025174815.C4644@atrey.karlin.mff.cuni.cz>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 25, jack@suse.cz wrote:
> > So if you move a directory between quota trees, then the usages will
> > be wrong in the first instance.  But only root can make this happen.
> > However, there is an easy way to fix it: just run a find or a du in
> > the new tree. 
>   Umm.. I'm not sure about one thing: When you move the dir between the
> trees when you update TID's? I understood that not during the move...

That is right.  Not during the move.
Well... the tid of the directory itself changes during the move.  The
tid's of descendants change later.

> So the only possibility that I see is that each time you read the inode
> you check whether its TID is OK. But that means going through dirs everytime
> you read some inode which doesn't look nice to me...
> 

Have a look at the code and see where treequota_check is called.

It is called every time a "lookup" is done, whether the result is in
the cache or not.  If the lookup found something, then you have a
inode and it's parent right there in the cache.  treequota_check
checks that the tid of the child matches that of the parent, and
changes it if not.  So the overhead is very small for the common case
where the tid is correct.

It just tests:
   is inode NULL
   are treequotas enabled for this inode
   does the tid of the child match that of the parent (or the uid of
           the child if parent.tid==0

> > 
> > It is, I think, the 'best' solution that is possible.
>   I also don't see a better solution but I'm not sure this solution is good
> enough to be implemented (to me it looks more like a hack than a regular
> part of system...).

I accept that it does look like a bit of a hack.
But I think it is simple, understandable, and predictable.
And I think that (for me) the value of tree quotas is more than enough
to offset that cost.

NeilBrown

