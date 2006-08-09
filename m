Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWHIVwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWHIVwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWHIVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:52:35 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:53466 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751386AbWHIVwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:52:34 -0400
Date: Wed, 9 Aug 2006 17:52:00 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       ezk@cs.sunysb.edu, dquigley@ic.sunysb.edu, dpquigl@tycho.nsa.gov
Subject: [RFC] Privilege escalation in filesystems
Message-ID: <20060809215200.GB1882@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While going though the Unionfs code, Chris Wedgwood commented that it might
make sense to ask the list about temporary privilege escalation in file
systems.

Much like NFS, at times Unionfs has to perform operations as another user.
(See below for details as to when and why this has to happen.)

I'd like to know what the preferred way of doing that is. I noticed that NFS
does a simple assignment:

(fs/nfs/nfs4recover.c:nfs4_save_user)
current->fsuid = 0;
current->fsgid = 0;

Should the capabilities be set/dropped as well? Would it be worth it to
provide some kind of generic way of accomplishing this having file system
messing with current directly?


Unionfs specific details:
-------------------------

Namespace unification requires that there is a way to mark a directory
"opaque" - meaning that lookup/readdir should not merge the objects of this
directory with those of a directory of a lower priority. When one creates a
new, empty directory using mkdir(2), the new directory should be empty
according to POSIX/UNIX. To prevent contents of directories on lower
priority branches from appearing in this newly created directory, the
directory is made opaque.

Suppose we have a union of /mnt/a and /mnt/b that are initially empty. Then
we perform the following steps:

$ cd /union
$ mkdir foo
$ find /union
/union/
/union/foo/
$ find /mnt/
/mnt/
/mnt/a/
/mnt/a/foo/
/mnt/a/foo/.wh.__dir_opaque
/mnt/b/

The .wh.__dir_opaque informs our implementation of Unionfs that the
directory is opaque.

The privilege problem appears when we try to remove the directory foo. If
we have write permission to /union, we should be able to remove any file or
(empty) directory. In the above example, /union/foo is empty.
If the foo is owned by someone else and we don't have write permission to
it, we'll fail to remove the opaque whiteout from foo (.wh.__dir_opaque),
which would in turn prevent us from removing foo itself. If we become a
superuser temporarily, we can remove the whiteout as well as the directory,
and all is well.

Josef "Jeff" Sipek.

-- 
UNIX is user-friendly ... it's just selective about who it's friends are
