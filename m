Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbQLCOBY>; Sun, 3 Dec 2000 09:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbQLCOBO>; Sun, 3 Dec 2000 09:01:14 -0500
Received: from pat.uio.no ([129.240.130.16]:18112 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129632AbQLCOBJ>;
	Sun, 3 Dec 2000 09:01:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14890.19197.796098.104054@charged.uio.no>
Date: Sun, 3 Dec 2000 14:30:37 +0100 (CET)
To: buhr@stat.wisc.edu (Kevin Buhr)
Cc: linux-kernel@vger.kernel.org
Subject: negative NFS cookies: bad C library or bad kernel?
In-Reply-To: <vbaaeae2joz.fsf@mozart.stat.wisc.edu>
In-Reply-To: <vbaaeae2joz.fsf@mozart.stat.wisc.edu>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Kevin Buhr <buhr@stat.wisc.edu> writes:

     > However, who's to blame here?  It can't be CFS---any four-byte
     > cookie should be valid, right?

     > Is the kernel NFS client code to blame?  If it's going to be
     > using cookies as offsets, shouldn't we have an nfs_lseek that
     > special-cases directory lseeks (at least those using SEEK_SET)
     > to take negative offsets, so utilities and libraries don't need
     > to be bigfile-aware just to read directories?  And what in the
     > world can we do about bogus code like the:

The problem here is that in NFS we have to match cookies in lieu of
using true directory 'offsets'. I did try to work around this by using
offsets into the page cache and the likes, however this sort of scheme
is almost impossible to implement sanely because an offset into the
page cache changes all the time. This was why I returned to Olaf's
scheme in which we use the cookie as the return value for lseek &
friends.

The problem then arises that lseek tries to cram both a returned
offset and an error value into the return values. When NFS returns an
opaque type, this causes a problem; one that won't be fixed by adding
an nfs_lseek. Furthermore, lseek is 32-bits: for NFSv3 and higher, the
cookie is 64-bits...

I know of no scheme that can fix all problems with lseek.
For example concerning SEEK_CUR: forget about it. NFS is not POSIX and
never will be. You simply cannot give meaningful semantics to SEEK_CUR
as long as the client knows nothing about the organization of dirents
on the server.

We can return offsets that are based on the internal caching of
dirents, but the problem then is that you need to find some permanent
'index' that doesn't change when we invalidate the cache and read it
in anew. Making stuff like 'rm -rf *' work (when the directory size &
organization keeps changing) is quite a challenge...
One possibility would be to make a pointer into a table of cookies be
our 'offset'. That could work if we can ensure that cookies can't move
around...

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
