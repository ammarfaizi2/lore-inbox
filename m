Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVD3QRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVD3QRj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVD3QRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:17:39 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:42673 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261277AbVD3QRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:17:30 -0400
To: smfrench@austin.rr.com
CC: miklos@szeredi.hu, hch@infradead.org, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
In-reply-to: <427387FB.4030901@austin.rr.com> (message from Steve French on
	Sat, 30 Apr 2005 08:28:27 -0500)
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu> <20050430082952.GA23253@infradead.org> <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu> <E1DRpfS-0002Nc-00@dorka.pomaz.szeredi.hu> <427387FB.4030901@austin.rr.com>
Message-Id: <E1DRueC-0002gU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Apr 2005 18:16:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Don't see how FUSE is that much safer, if you allocate kernel memory
> at all you eventually can create DoS, and you can not do a
> filesystem without allocating some kernel memory, but it does not
> seem that easy to do intentionally.

Allocating kernel memory is usually not a problem, when it's
associated with some object, whose number is already limited by the
kernel.  These are: cache entries (inode, dentry), file pointers
(limited in various ways), or super blocks (should be limited in case
of user mounts).

The big problem is the page cache, because that is not limited.  The
user can mmap huge amounts of memory, dirty them, and then when the
machine runs out of memory, and writeback kicks in, it may already be
too late.

This problem can be demonstrated with _any_ network filesystem that
supports shared writable mapping, and is mounted from the local
machine.  One exception is CODA, because it uses disk files as file
backing, and so does not have problems with writeback.

FUSE solves the problem by simply not allowing shared writable
mapping.  It's a _very_ hard thing to solve otherwise.  CIFS, smbfs,
etc, can do the same for unprivileged mounts, or untrusted servers.

> At least for the CIFS case you can turn off the page cache for
> inode data on a per mount basis (with the forcedirectio mount flag)
> if you worry about the server intentionally holding up writes.

That's sounds like a solution to this problem.

> Unless the write is past end of file, writes are timed out
> reasonably quickly anyway, and end up killing the session, which
> depending on the setting of the hard/soft flag probably should
> result in a page fault.

A timeout is also OK, but you should be careful, that the page under
writeback does get freed after the timeout.

Miklos
