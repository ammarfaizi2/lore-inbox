Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbVHJOke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbVHJOke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbVHJOke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:40:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30946 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965136AbVHJOkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:40:33 -0400
Date: Wed, 10 Aug 2005 16:40:24 +0200
From: Jan Kara <jack@suse.cz>
To: Tarmo =?iso-8859-2?Q?T=E4nav?= <tarmo@itech.ee>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org,
       mason@suse.com, jeffm@suse.com
Subject: Re: BUG: reiserfs+acl+quota deadlock
Message-ID: <20050810144024.GA18584@atrey.karlin.mff.cuni.cz>
References: <1123643111.27819.23.camel@localhost> <20050810130009.GE22112@atrey.karlin.mff.cuni.cz> <1123684298.14562.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123684298.14562.4.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tried the attached patch but it changed nothing, I trying to create
> a new file as a user whose quota grace time has ran out will still
> cause everything accessing the users homedir (the one with the quota)
> to hang in D state.
> 
> Also note that the bug I reported only exists when acl is also
> enabled (does not have to be used). And although my kernel is not
> built with debug (or reiserfs debug) support, I don't get any
> oopses or reiserfs errors.. it just hangs.
  Oops, sorry. I forgot to mount the fs with ACL mount option and so I
was not able to reproduce the hang. My fault, your bug is a different
problem. Now it hangs also for me so I can debug it :)

								Honza

> On K, 2005-08-10 at 15:00 +0200, Jan Kara wrote:
> >   Hello,
> > 
> > > I've already reported a similiar bug to the one I found now
> > > and that was fixed by:
> > > "[PATCH] reiserfs: fix deadlock in inode creation failure path w/
> > > default ACL"
> > > 
> > > This bug is similiar in effect but has some differences in how
> > > to trigger it. The end effect will be just like with the other
> > > bug that the affected directory will be unaccessible to any user
> > > or process.
> > > 
> > > So here's the way to reproduce it, as minimal as I could get it:
> > > 
> > > You need reiserfs, quota and acl support in kernel.
> > > you also need quota tools (edquota, quotaon, quotacheck), I used
> > > linuxquota 3.12.
> > > 
> > > # cd /mnt
> > > # dd if=/dev/zero of=test bs=1M count=50
> > > 50+0 records in
> > > 50+0 records out
> > > # mkreiserfs -f test >/dev/null
> > > mkreiserfs 3.6.19 (2003 www.namesys.com)
> > > 
> > > test is not a block special device
> > > Continue (y/n):y
> > > # mkdir mpoint
> > > # mount test mpoint -o loop,acl,usrquota
> > > # mkdir mpoint/user1
> > > # useradd -d /mnt/mpoint/user1 user1     # may also use existing user
> > > # chown user1 mpoint/user1
> > > # quotacheck -v mpoint                   # initializes quota file
> > > # edquota user1
> > > ---- set soft block limit to 1000, hard limit to 4000 ----
> > > # edquota -t
> > > ---- set the grace periods to something small: 1minutes ---
> > > # quotaon mpoint
> > > # ## at this point "repquota -a" should show the quota for user1
> > > # su user1
> > > # cd
> > > # ## now we are in user1 home dir as user1
> > > # cat /dev/zero > file1
> > > loop2: warning, user block quota exceeded.
> > > loop2: write failed, user block limit reached.
> > > cat: write error: No space left on device
> > > --- now we wait till the grace period expires (repquota -a) ----
> > > # cat "" > otherfile
> > > loop2: write failed, user block quota exceeded too long.
> > > ---- and it will hang forever ----
> > > # ## /mnt/mpoint can still be accessed, but /mnt/mpoint/user1 can't
> > > 
> > > 
> > > I tested this on an -mm patchset kernel (2.6.13-rc5-mm1), but I
> > > discovered the bug in my server which runs plain 2.6.12 with the
> > > patch from Jeff Mahoney for the first reiserfs+acl bug.
> > > 
> > > The main difference between the two bugs is that the first one requires
> > > the existance of a default acl, this one does not, but it does require
> > > acl to be enabled.
> >   This seems to be the same problem as bug #4771 that I've just fix. Can
> > you try attached patch please?
> >   Andrew, can you include the patch into -mm if ReiserFS guys won't object?
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
