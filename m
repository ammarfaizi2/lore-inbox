Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWCGCQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWCGCQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbWCGCQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:16:46 -0500
Received: from cantor2.suse.de ([195.135.220.15]:64149 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932610AbWCGCQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:16:45 -0500
From: Neil Brown <neilb@suse.de>
To: Jan Blunck <jblunck@suse.de>
Date: Tue, 7 Mar 2006 13:15:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17420.60621.425286.979327@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Kirill Korotaev <dev@openvz.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
In-Reply-To: message from Jan Blunck on Monday March 6
References: <17414.38749.886125.282255@cse.unsw.edu.au>
	<17419.53761.295044.78549@cse.unsw.edu.au>
	<20060306115602.GC22832@hasse.suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 6, jblunck@suse.de wrote:
> 
> This are two different problems which you adress with this and your first
> patch. This one is to prevent busy inodes on umouny, the first one was to get
> the reference counting on dentries right.

I think that solving the "busy inodes" problem is sufficient.  The
reference count on dentries isn't *wrong* as someone is actually
holding a reference.  It is just that generic_shutdown_super doesn't
expect anyone else to hold any references.  Fixing the "busy inodes"
problem means that no-one else will be holding any references, so it
becomes a non-problem.
> 
> Neil, did you actually read my patch for this one?!
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114123870406751&w=2

No, I didn't :-(  I obviously didn't do enough homework.

The significant differences seem to be:
 - you test ->s_prunes inside the spinlock.  I don't bother.  Yours is
   probably safer.
 - You call wake_up every time through prune_one_dentry while I try to
   limit the calls.  As each call is a function call and a spinlock,
   maybe at least guard it with
      if(waitqueue_active()) ...


> 
> What I don't like, is that you are serializing the work of shrink_dcache_*
> although they could work in parallel on different processors.

I don't see how I am parallelising anything.  Multiple shrink_dcache_*
can still run.  The only place that extra locking is done is in
generic_shutdown_super.

But what do you think of Balbir Singh's patch?  I think it is less
intrusive and solves the problem just a well.

Thanks,
NeilBrown


