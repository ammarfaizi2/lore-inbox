Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVLTNeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVLTNeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 08:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVLTNeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 08:34:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55215 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751012AbVLTNeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 08:34:13 -0500
Date: Tue, 20 Dec 2005 07:33:41 -0600
From: Cliff Wickman <cpw@sgi.com>
To: Bharata B Rao <bharata@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very rare crash in prune_dcache
Message-ID: <20051220133341.GA9329@sgi.com>
References: <43A7286F.3080104@cs.fiu.edu> <20051219223435.GA2576@sgi.com> <20051220064629.GA31099@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220064629.GA31099@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharata,

On Tue, Dec 20, 2005 at 12:16:29PM +0530, Bharata B Rao wrote:
> Hi Cliff,
> 
> > I suspect a race condition inside prune_dcache().
> > 
> > The prune_dcache() function:
> >         lock dcache_lock
> >         scan the dentry_unused list of dentry's for a given number ("count") of
> >         dentry's to free:
                    --------
                    get (remove) dentry from dentry_unused list
                    --------
> >                 if a dentry to free, call prune_one_dentry()
> >                         dentry_iput()
> >                                 unlock dcache_lock
> >                                 iput() any associated inode
> >                         d_free() the dentry
> >                         lock dcache_lock
> >         unlock dcache_lock
> > 
> > Two processors entering prune_dcache() near the same time will both scan
> > the dentry_unused list and could try to iput() the same inode twice.  That is
> > because the dcache_lock is released while running iput().
>
> Isn't this what dcache_lock doing presently ? As per vanilla 2.6.5 kernel
> I don't see how the race condition you mention above can happen.
> 
> In prune_dcache(), a dentry is first removed off the dentry_unused list
> (under dcache_lock) before calling prune_one_dentry(). So how is it 
> possible that an another thread executing prune_dcache() will hit
> the same dentry again ?

Yes, I think you're right.   And it's not theoretically possible for
two dentry's to point to the same inode.  So the inode that caused our
crash must have been corrupted elsewhere.
Thanks.

-Cliff

-- 
Cliff Wickman
Silicon Graphics, Inc.
cpw@sgi.com
(651) 683-3824
