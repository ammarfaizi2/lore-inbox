Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752064AbWCGB73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbWCGB73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbWCGB72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:59:28 -0500
Received: from cantor2.suse.de ([195.135.220.15]:48274 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752064AbWCGB72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:59:28 -0500
From: Neil Brown <neilb@suse.de>
To: "Balbir Singh" <bsingharora@gmail.com>
Date: Tue, 7 Mar 2006 12:58:20 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17420.59580.915759.44913@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Olaf Hering" <olh@suse.de>, "Jan Blunck" <jblunck@suse.de>,
       "Kirill Korotaev" <dev@openvz.org>, "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
In-Reply-To: message from Balbir Singh on Monday March 6
References: <17414.38749.886125.282255@cse.unsw.edu.au>
	<17419.53761.295044.78549@cse.unsw.edu.au>
	<661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 6, bsingharora@gmail.com wrote:
> > Somewhere in among the comments (thanks), I realised that I was only
> > closing half the race.  I had tried to make sure there were no stray
> > references to any dentries, but there is still the inode which is
> > being iput which can cause problem.
> >
> > The following patch takes a totally different approach, is based on an
> > idea from Jan Kara, and is much less intrusive.
> >
> > We:
> >   - keep track of "who" is calling prune_dcache, and when a filesystem
> >     is being unmounted (s_root == NULL) we only allow the unmount thread
> >     to prune dentries.
> >   - keep track of how many dentries are in the process of having
> >     dentry_iput called on them for pruning
> >   - don't allow umount to proceed until that count hits zero
> >   - bias the count this way and that to make sure we get a wake_up at
> >     the right time
> >   - reuse 's_wait_unfrozen' to wait on the iput to complete.
> >
> > Again, I'm very keen on feedback.  This race is very hard to trigger,
> > so code review is the only real way to evaluate that patch.
> >
> > Thanks,
> > NeilBrown
> >
> 
> The code changes look big, have you looked at
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113817279225962&w=2

No I haven't.  I like it.
 - Holding the semaphore shouldn't be a problem.
 - calling down_read_trylock ought to be fast
 - I *think* the unwanted calls to prune_dcache are always under
   PF_MEMALLOC - they certainly seem to be.

And it is a nice small change.
Have you had any other feedback on this?


> 
> Some top of the head feedback below. Will try and do a detailed review later.
> 

> > +               /* avoid further wakeups */
> > +               sb->s_pending_iputs = 65000;
> 
> This looks a bit ugly, what is 65000?

Just the first big number that came to by head... probably not needed.


NeilBrown
