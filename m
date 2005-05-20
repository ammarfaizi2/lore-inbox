Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVETKiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVETKiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 06:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVETKiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 06:38:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:456 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261243AbVETKiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 06:38:02 -0400
Date: Fri, 20 May 2005 11:38:25 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linuxram@us.ibm.com, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH retry] namespace.c: fix race in mark_mounts_for_expiry()
Message-ID: <20050520103825.GM29811@parcelfarce.linux.theplanet.co.uk>
References: <E1DZ4IA-0003XJ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DZ4IA-0003XJ-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 11:59:42AM +0200, Miklos Szeredi wrote:
> One more try.  I hope everybody's happy now.
> 
> This patch fixes a race found by Ram in mark_mounts_for_expiry() in
> fs/namespace.c.
> 
> The bug can only be triggered with simultaneous exiting of a process
> having a private namespace, and expiry of a mount from within that
> namespace.  It's practically impossible to trigger, and I haven't even
> tried.  But still, a bug is a bug.
> 
> The race happens when put_namespace() is called by another task, while
> mark_mounts_for_expiry() is between atomic_read() and get_namespace().
> In that case get_namespace() will be called on an already dead
> namespace with unforeseeable results.
> 
> The solution is to use atomic_dec_and_lock() in put_namespace() as
> suggested by Al Viro.

That's not quite what I meant.  Instead of screwing with atomic_read()
in there, why don't we simply do the following:
	a) atomic_dec_and_lock() in put_namespace()
	b) __put_namespace() called without dropping lock
	c) the first thing done by __put_namespace would be
struct vfsmount *root = namespace->root;
namespace->root = NULL;
spin_unlock(...);
....
umount_tree(root);
...
	d) check in mark_... would be simply namespace && namespace->root.

And we are all set; no screwing around with atomic_read(), no magic at all.
Dying namespace gets NULL ->root.
All changes of ->root happen under spinlock.
If under a spinlock we see non-NULL ->mnt_namespace, it won't be freed until
we drop the lock (we will set ->mnt_namespace to NULL under that lock before
we get to freeing namespace).
If under a spinlock we see non-NULL ->mnt_namespace and ->mnt_namespace->root,
we can grab a reference to namespace and be sure that it won't go away.
