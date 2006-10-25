Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423187AbWJYKP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423187AbWJYKP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423188AbWJYKP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:15:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423187AbWJYKP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:15:26 -0400
From: David Howells <dhowells@redhat.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org
cc: selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, dhowells@redhat.com,
       aviro@redhat.com
Subject: Security issues with local filesystem caching
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 25 Oct 2006 11:14:16 +0100
Message-ID: <16969.1161771256@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Some issues have been raised by Christoph Hellwig over how I'm handling
filesystem security in my CacheFiles module, and I'd like advice on how to deal
with them.

CacheFiles stores its cache objects as files and directories in a tree under a
directory nominated by the configuration.  This means the data it is holding
(a) is potentially exposed to userspace, and (b) must be labelled for access
control according to the usual filesystem rules.

Currently, CacheFiles temporarily changes fsuid and fsgid to 0 whilst doing its
own pathwalk through the cache and whilst creating files and directories in the
cache.  This allows it to deal with DAC security directly.  All the directories
it creates are given permissions mask 0700 and all files 0000.

However, Christoph has objected to this practice, and has said that I'm not
allowed to change fsuid and fsgid.  The problem with not doing so is that this
code is running in the context of the process that issued the original open(),
read(), write(), etc, and so any accesses or creations it does would be done
with that process's fsuid and fsgid, which would lead to a cache with bits that
can't be shared between users.

Another thing I'm currently doing is bypassing the usual calls to the LSM
hooks.  This means that I'm not setting and checking security labels and MACs.
The reason for this is again that I'm running in some random process's context
and labelling and MAC'ing will affect the sharability of the cache.  This was
objected to also.

This also bypasses auditing (I think).  I don't want the CacheFiles module's
access to the cache to be logged against whatever process was accessing, say,
an NFS file.  That process didn't ask to access the cache, and the cache is
meant to be transparent.

I can see a few ways to deal with this:

 (1) Do all the cache operations in their own thread (sort of like knfsd).

 (2) Add further security ops for the caching code to call.  These might be of
     use elsewhere in the kernel.  These would set cache-specific security
     labels and check for them.

 (3) Add a flag or something to current to override the normal security on the
     basis that it should be using the cache's security rather than the
     process's security.


Option (1) would lead to serialisation of all cached NFS operations over the
accesses to disk.  Some of these accesses to disk involve sequences of mkdir(),
lookup(), [sg]etxattr() and create() inode op calls - all of which are
synchronous.  On the other hand, option (1) gives the simplest way of
overriding security, and would entail the least work.  It would, though, give
the biggest performance degradation.

Option (2) would require additional security ops, though possibly not many.  It
might be sufficient to just add two: to set and to check the security for a
cache object (be it file or directory).  This option would also preclude use of
the vfs_mkdir() VFS op and suchlike, as they use the wrong sort of security.
Some other way of handling the UNIX file ownership would also have to be sought.

Option (3) would require the current security handling in both the filesystem
(DAC) and security modules (MAC) to check for the overriding context in
current, and to go with that instead.  It might be possible to make such a
thing incorporate fsuid and fsgid.

Thoughts anyone?

David
