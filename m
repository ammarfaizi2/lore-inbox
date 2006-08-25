Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422845AbWHYW7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbWHYW7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 18:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWHYW7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 18:59:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63371 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422845AbWHYW7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 18:59:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060825221615.GA11613@us.ibm.com> 
References: <20060825221615.GA11613@us.ibm.com>  <20060824182044.GE17658@us.ibm.com> <20060824181722.GA17658@us.ibm.com> <22796.1156542677@warthog.cambridge.redhat.com> 
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 23:59:06 +0100
Message-ID: <27154.1156546746@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> > > filldir()'s inode number is now type u64 instead of ino_t.
> > 
> > Btw, in ecryptfs_interpose(), you have:
> > 
> > 	inode = iget(sb, lower_inode->i_ino);
> > 
> > But you have to be *very* *very* careful doing that.  i_ino may be
> > ambiguous.  My suggestions to make i_ino bigger were turned down by
> > Al Viro; and even it were bigger, it might still not be unique.
> 
> Is this the case as long as we stay under the same mountpoint?

Yes.

Imagine, for a moment, that you are running on a 32-bit system, and that you
are using, say, XFS, and that XFS has 64-bit inode numbers.  i_ino is 32-bits,
so clearly XFS can't place its full inode number in there.

What XFS can do is:

 (1) Use iget5 to do its own inode search and set, disregarding i_ino for that
     purpose.

 (2) Place just the lower 32-bits of the inode number in i_ino.

 (3) Return the 64-bit inode number directly through the getattr() and
     readdir() ops, without recourse to i_ino.

 (4) Ignore i_ino entirely, except for spicing up printk()'s.


Now, consider, say, NFS.  NFS now puts some or all of 64-bit inode numbers in
the i_ino field, but it actually differentiates inodes using iget5 and
comparing file handles - which it really can't represent in i_ino.

It doesn't actually check that the server hasn't given it two fileids the same,
so even with a 64-bit i_ino, you just have to hope that you can get unique
values.

And, in fact, imagine the following scenario:

 (1) An NFS inode with fileid N is in the client's icache, and this corresponds
     to some remote file on the server.

 (2) The remote file is then deleted (but the client isn't told).

 (3) A new remote file is created that would has the same fileid (N), but a
     different file handle.

 (4) The client looks up the new remote file under a different name (so
     different dentry), and sets up a client inode for it with the new
     filehandle.

 (5) The client will now have two NFS inodes from the server with the same
     fileid, but with different filehandles.  As far as the NFS client
     filesystem is concerned, they are _different_ files, but as far as
     eCryptFS is concerned, they are the _same_ because is passed the lower
     i_ino to iget().


I think what you need to do is actually simple.  Use iget5 to look up your
inode, using the _pointer_ to the lower inode as the key.  Then just fill in
i_ino from the lower inode.  The lower inode can't escape whilst you have it
pinned, so the pointer is, in effect, invariant whilst you are using it.

David
