Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966259AbWKNUIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966259AbWKNUIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966305AbWKNUIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:08:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:425 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966259AbWKNUIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:08:51 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 00/19] Permit filesystem local caching and NFS superblock sharing 
Date: Tue, 14 Nov 2006 20:06:21 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



These patches add local caching for network filesystems such as NFS and AFS.

I've addressed all but one of Christoph's objections.  The one objection I
haven't yet dealt with is the addition of a new operation for writing a page of
the file, but that's controversial, and I'd like feedback on what I've done so
far.

The main thing that I've dealt with is the security issue in CacheFiles:

CacheFiles now calls the VFS wrappers for invoking filesystem operations, such
as vfs_mkdir().  It does not call any of the inode operations directly anymore.

This means, however, that it has to deal with SELinux, especially when in
enforcing mode.

The cachefilesd RPM installs a policy for labelling and accessing the files in
the cache, and for providing a security ID for the cachefilesd daemon to run
as.  It _also_ provides a security ID for the cachefiles module to act as when
it is accessing the filesystem on behalf of the process.

The way this is done is that one of the patches:

	CacheFiles: Add an act-as SID override in task_security_struct

permits the module to temporarily change the security ID as which a process
_acts_.  It does _not_ change the process's actual security ID, and so does not
interfere with signals, ptraces, /proc/pid/ accesses aimed at that process.

Furthermore, following consultations with Stephen Smalley and others of the
SELinux project, it was deemed correct to override fsuid and fsgid of the host
process whilst accessing the cache, so these are also modified temporarily by
the module during such accesses.

Finally, the file creation SID is also temporarily overridden whilst the module
accesses the cache.

All this permits the ownership and accessibility of files in the cache to
preclude ordinary access by all processes running on the system, with the
exception of cachefilesd.  When SELinux is in enforcing mode, the daemon may
not read or write the files in the cache according to the policy.

Thanks to Dan Walsh and Karl MacMillan for helping me get the SELinux policy
working.  There is documentation on this in the patches and in the cachefilesd
SRPM/tarball.


Additionally, sysctls are no longer used.  Some parameters are modifiable via
sysfs.  CacheFiles parameters pertaining to the cache are still only modifiable
by sending commands to the module over its control interface, though the
control interface is now a character device (following GregKH's suggestion).

---
The kernel patches are committed to a GIT tree based on Linus's:

	git://git.infradead.org/users/dhowells/fscache-2.6.git

Which can be viewed through:

	http://git.infradead.org/?p=users/dhowells/fscache-2.6.git;a=summary

A tarball of patches is available at:

	http://people.redhat.com/~dhowells/fscache/patches/nfs+fscache-19.tar.bz2


To use this version of CacheFiles, the cachefilesd-0.8 is also required.  It
is available as an SRPM:

	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.8-15.fc7.src.rpm

Or as individual bits:

	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.8.tar.bz2
	http://people.redhat.com/~dhowells/fscache/cachefilesd.fc
	http://people.redhat.com/~dhowells/fscache/cachefilesd.if
	http://people.redhat.com/~dhowells/fscache/cachefilesd.te
	http://people.redhat.com/~dhowells/fscache/cachefilesd.spec

David
