Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272592AbRI0MMq>; Thu, 27 Sep 2001 08:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272533AbRI0MMf>; Thu, 27 Sep 2001 08:12:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45581 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272540AbRI0MMV>; Thu, 27 Sep 2001 08:12:21 -0400
Date: Thu, 27 Sep 2001 14:12:44 +0200
From: Jan Kara <jack@suse.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Linux-2.4.10 + ext3
Message-ID: <20010927141244.F26535@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com> <20010926174943.W3437@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010926174943.W3437@redhat.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

<snip>

> ext3 needs to remain transactional even when making recursive calls
> into the filesystem, and ext3 implements quotas, which are quite
> capable of recursing into the fs if we end up hitting the VM at the
> wrong moment.  Such recursions have to be handled very, very
> carefully: a legal recursion within one filesystem is valid, but
> recursions between filesystems absolutely must be avoided, as this can
> lead to deadlock.  
> 
> And there are recursions we just can't get rid of --- an inode delete
> ends up deallocating the inode on disk and updating the dquot (which
> does a dqput, which writes the quota entry using the normal VFS API),
> and we _have_ to make that quota-file write a nested transaction if we
> want quotas to be atomic with respect to journal recovery.  Short of
> adding a new context parameter to be passed all the way through the
> quota and VM layers wherever this sort of recursion is possible, we
> need to attach that context to the task.  (Without a task struct
> field, though, we can still hash outstanding transaction handles by
> pid for fast lookup.)
  Actually Alan should now have patch in his queue which makes
quota guarantee no recursion on DQUOT_ALLOC/FREE operations (apart from
mark_inode_dirty()). Recursion is possible only in DQUOT_DROP,
DQUOT_INIT and DQUOT_TRANSFER. So this patch might help ext3 a bit.

							Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs
