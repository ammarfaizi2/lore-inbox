Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273810AbRI0Sig>; Thu, 27 Sep 2001 14:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273813AbRI0Si0>; Thu, 27 Sep 2001 14:38:26 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:38135 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S273810AbRI0SiO>; Thu, 27 Sep 2001 14:38:14 -0400
Date: Thu, 27 Sep 2001 19:37:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Linux-2.4.10 + ext3
Message-ID: <20010927193750.I16055@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com> <20010926174943.W3437@redhat.com> <20010927141244.F26535@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010927141244.F26535@atrey.karlin.mff.cuni.cz>; from jack@suse.cz on Thu, Sep 27, 2001 at 02:12:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 27, 2001 at 02:12:44PM +0200, Jan Kara wrote:

> > And there are recursions we just can't get rid of --- an inode delete
> > ends up deallocating the inode on disk and updating the dquot (which
> > does a dqput, which writes the quota entry using the normal VFS API),
> > and we _have_ to make that quota-file write a nested transaction if we
> > want quotas to be atomic with respect to journal recovery.  Short of
> > adding a new context parameter to be passed all the way through the
> > quota and VM layers wherever this sort of recursion is possible, we
> > need to attach that context to the task.  (Without a task struct
> > field, though, we can still hash outstanding transaction handles by
> > pid for fast lookup.)
>   Actually Alan should now have patch in his queue which makes
> quota guarantee no recursion on DQUOT_ALLOC/FREE operations (apart from
> mark_inode_dirty()). Recursion is possible only in DQUOT_DROP,
> DQUOT_INIT and DQUOT_TRANSFER. So this patch might help ext3 a bit.

Possibly: it might be possible to defer the dquot_drop until after
we've closed the transaction which deleted the inode.  Thanks.

Cheers,
 Stephen
