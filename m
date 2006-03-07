Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752080AbWCGHDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbWCGHDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbWCGHDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:03:47 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:61338 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752080AbWCGHDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:03:46 -0500
Date: Tue, 7 Mar 2006 12:33:01 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Neil Brown <neilb@suse.de>, Balbir Singh <bsingharora@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>,
       Kirill Korotaev <dev@openvz.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060307070301.GA12165@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <17414.38749.886125.282255@cse.unsw.edu.au> <17419.53761.295044.78549@cse.unsw.edu.au> <661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com> <17420.59580.915759.44913@cse.unsw.edu.au> <440D2536.60005@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440D2536.60005@sw.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 09:16:22AM +0300, Kirill Korotaev wrote:
> >>The code changes look big, have you looked at
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=113817279225962&w=2
> >
> >
> >No I haven't.  I like it.
> > - Holding the semaphore shouldn't be a problem.
> > - calling down_read_trylock ought to be fast
> > - I *think* the unwanted calls to prune_dcache are always under
> >   PF_MEMALLOC - they certainly seem to be.
> No, it looks as it is not :(
> Have you noticed my comment about "count" argument to prune_dcache()?
> For example, prune_dcache() is called from shrink_dcache_parent() which 
> is called in many places and not all of them have PF_MEMALLOC or 
> s_umount semaphore for write. But prune_dcache() doesn't care for super 
> blocks etc. It simply shrinks N dentries which are found _first_.
> 
> So the condition:
> +		if ((current->flags & PF_MEMALLOC) &&
> +			!(ret = down_read_trylock(&s->s_umount))) {
> is not always true when the race occurs, as PF_MEMALLOC is not always set.

I understand your comment about shrink_dcache_parent() being called
from several places. prune_one_dentry() would eventually dput the parent,
but unmount would go ahead and unmount the filesystem before the
dput of the parent could happen.

Given that background, I thought our main concern was with respect to
unmount. The race was between shrink_dcache_parent() (called from unmount)
and shrink_dcache_memory() (called from the allocator), hence the fix
for the race condition.

I just noticied that 2.6.16-rc* now seems to have drop_slab() where
PF_MEMALLOC is not set. So, we can still race with my fix if there
if /proc/sys/vm/drop_caches is written to and unmount is done in parallel.

A simple hack would be to set PF_MEMALLOC in drop_slab(), but I do not
think it is a good idea.

> 
> >And it is a nice small change.
> >Have you had any other feedback on this?
> here it is :)
> 

Thanks for your detailed feedback

> Thanks,
> Kirill
> 

Regards,
Balbir
