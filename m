Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVEEJK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVEEJK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 05:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVEEJK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 05:10:56 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:60843 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261998AbVEEJKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 05:10:45 -0400
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
	clear_inode() call between
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dedekind@infradead.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20050504145811.63e9bb10.akpm@osdl.org>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	 <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	 <1114618748.12617.23.camel@sauron.oktetlabs.ru>
	 <E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <1114673528.3483.2.camel@sauron.oktetlabs.ru>
	 <20050428003450.51687b65.akpm@osdl.org>
	 <1115209055.8559.12.camel@sauron.oktetlabs.ru>
	 <20050504130450.7c90a422.akpm@osdl.org>
	 <1115242507.12012.394.camel@baythorne.infradead.org>
	 <20050504145811.63e9bb10.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 05 May 2005 10:10:40 +0100
Message-Id: <1115284240.12012.416.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-04 at 14:58 -0700, Andrew Morton wrote:
> That doesn't really settle the question of whether the callers are broken,
> whether they are doing something which the VFS really should support and
> what need to be done to the VFS to support it properly.

Filesystems exported by NFS _will_ get iget() called for recently-
deleted inodes. JFFS2 and (I believe) NTFS also do internal things which
end up having the same effect.

The premise is simple: regardless of who calls iget() and when they do
it, the VFS should not call the filesystem's read_inode() method twice
consecutively for the same inode without ever calling clear_inode() or
delete_inode() in between.

That's what __wait_on_freeing_inode() was introduced for -- so we can
make sure the clear_inode() call actually happened before we call
read_inode() again for the same inode. Unfortunately there is still a
code path where we can get it wrong, and that's what Artem is fixing.

> Looking at the proposed patch: what happens if an inode is on its way to
> dispose_list() and someone tries to do an iget() on it?  I don't think I_LOCK
> is set, so __wait_on_freeing_inode() will no longer provide this guarantee:

> /*
>  * If we try to find an inode in the inode hash while it is being deleted, we
>  * have to wait until the filesystem completes its deletion before reporting
>  * that it isn't found.  This is because iget will immediately call
>  * ->read_inode, and we want to be sure that evidence of the deletion is found
>  * by ->read_inode.

That comment isn't true any more. Look at what __wait_on_freeing_inode()
actually does, and observe the fact that all its callers actually loop
and start again after calling it. 

The current implementation of __wait_on_freeing_inode() waits until it
_might_ have changed, not until it _has_ changed. That's why it's OK for
it just to be a yield() or a wait on a bit_waitqueue.

I'm not convinced I _like_ that implementation, mind you -- it's changed
since I last looked at it. But I don't see that there's anything
strictly broken about it.

-- 
dwmw2


