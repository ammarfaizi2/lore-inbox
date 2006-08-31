Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWHaKap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWHaKap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWHaKap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:30:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59863 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751087AbWHaKao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:30:44 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060830211203.GA12953@us.ibm.com> 
References: <20060830211203.GA12953@us.ibm.com>  <20060825221615.GA11613@us.ibm.com> <20060824182044.GE17658@us.ibm.com> <20060824181722.GA17658@us.ibm.com> <22796.1156542677@warthog.cambridge.redhat.com> <27154.1156546746@warthog.cambridge.redhat.com> 
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 31 Aug 2006 11:30:31 +0100
Message-ID: <10689.1157020231@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> Note that I used to depend on iget() to wind up calling
> ecryptfs_read_inode(); it looks like iget5_locked() does not make that
> call,

Exactly so.  iget5_locked() returns with a new inode in a partially
constructed state, thus obviating the need for read_inode().  If you look at
the implementation of iget():

	static inline struct inode *iget(struct super_block *sb,
					 unsigned long ino)
	{
		struct inode *inode = iget_locked(sb, ino);

		if (inode && (inode->i_state & I_NEW)) {
			sb->s_op->read_inode(inode);
			unlock_new_inode(inode);
		}

		return inode;
	}

You can see that read_inode() is _only_ used there and can be dispensed with
if you're using iget_locked() or iget5_locked() directly.  This gives you more
control over what data you have available when initialising an inode.

> +	inode = iget5_locked(sb, lower_inode->i_ino, ecryptfs_inode_test,
> +			     ecryptfs_inode_set, lower_inode);

The second argument of iget5_locked() is a hash value.  I would use
lower_inode not lower_inode->i_ino as the former is fundamental to your search
and the latter irrelevant.

> +	inode->i_ino = lower_inode->i_ino;
> +	if (inode->i_state & I_NEW) {
> +		ecryptfs_init_inode(inode);
> +		unlock_new_inode(inode);
> +	}

Shouldn't the setting of i_ino be inside the if-statement?

You should set the lower inode pointer in ecryptfs_inode_set() so that the
ecryptfs inode is linked to the lower inode whilst inode_lock is held (see
get_new_inode()).  You could also set i_ino there too.  Consider this bit of
pseudocode:

	int ecryptfs_inode_set(struct inode *inode, void *lower_inode)
	{
		ecryptfs_set_lower_inode(inode, lower_inode);
		inode->i_ino = lower_inode->i_ino;
		return 0;
	}

David
