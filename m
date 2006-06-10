Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWFJB16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWFJB16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWFJB16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:27:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:10406 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932615AbWFJB16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:27:58 -0400
Date: Sat, 10 Jun 2006 02:27:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060610012757.GC27946@ftp.linux.org.uk>
References: <E1Foqjw-00010e-Ln@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Foqjw-00010e-Ln@candygram.thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 07:50:08PM -0400, Theodore Ts'o wrote:
> 4) i_state and i_flags are both 4-byte longs, but they only need to be
>    2-byte shorts, and could be placed next to each other.

void wake_up_inode(struct inode *inode)
{
        /*
         * Prevent speculative execution through spin_unlock(&inode_lock);
         */
        smp_mb();
        wake_up_bit(&inode->i_state, __I_LOCK);
}

> 5) Nuke i_cindex.  This is only used by ieee1394's
>    ieee_file_to_instance.  There must be another place where we can
>    store this --- say, in a ieee1394-specific field in struct file?  Or
>    maybe it can be derived some other way, but to chew up 4 bytes in
>    i_cindex for all inodes just for ieee1394's benefit seems like the
>    Wrong Thing(tm).

No, it's actually the right thing for _all_ char devices.  And it's used
before we get a struct file.  If anything, ->i_rdev should go long-term...

> 6) Separate out those elements which are only used if the inode is open
>    into a separate data structure (call it "struct inode_state" for
>    the sake of argument):
> 
> 	i_flock, i_mapping, i_data, i_dnotify_mask, i_dnotify,
> 	inotify_watches, inotify_sem, i_state, dirtied_when,
> 	i_size_seqcount, i_mutex, i_alloc_sem
> 
>    This is the motherload.  Moving these fields out to a separate
>    structure which is only allocated for inodes which are open will save
>    a huge amount of memory.  But, of course, sweeping through all of the
>    code which uses these variables to move them would be a major code
>    change.  (We can do it initially with #define magic, but we will need
>    to audit the code paths to see if it's always to safe to assume that
>    inode is open before dereferencing the i_state pointer, or whether we
>    need to check to see if it is valid first.)

It is not safe e.g. for ->i_mutex, since that puppy is used not only when
there's an opened file over this inode (or, in fact, before any method
had been called for this inode).

It is _certainly_ not safe for ->i_state (take a look at fs/inode.c).

It is not safe for ->i_data, unless you are willing to dispose of page
cache on close (even leaving aside such things as directories).

No comments on idiotify fields - IIRC, they can also be used before any
->open() on the inode in question.
