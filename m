Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWJYVM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWJYVM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 17:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWJYVMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 17:12:25 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:47006 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1030332AbWJYVMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 17:12:25 -0400
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <16969.1161771256@redhat.com>
References: <16969.1161771256@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 25 Oct 2006 17:12:05 -0400
Message-Id: <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 11:14 +0100, David Howells wrote: 
> Hi,
> 
> Some issues have been raised by Christoph Hellwig over how I'm handling
> filesystem security in my CacheFiles module, and I'd like advice on how to deal
> with them.
> 
> CacheFiles stores its cache objects as files and directories in a tree under a
> directory nominated by the configuration.  This means the data it is holding
> (a) is potentially exposed to userspace, and (b) must be labelled for access
> control according to the usual filesystem rules.
> 
> Currently, CacheFiles temporarily changes fsuid and fsgid to 0 whilst doing its
> own pathwalk through the cache and whilst creating files and directories in the
> cache.  This allows it to deal with DAC security directly.  All the directories
> it creates are given permissions mask 0700 and all files 0000.
> 
> However, Christoph has objected to this practice, and has said that I'm not
> allowed to change fsuid and fsgid.  The problem with not doing so is that this
> code is running in the context of the process that issued the original open(),
> read(), write(), etc, and so any accesses or creations it does would be done
> with that process's fsuid and fsgid, which would lead to a cache with bits that
> can't be shared between users.
> 
> Another thing I'm currently doing is bypassing the usual calls to the LSM
> hooks.  This means that I'm not setting and checking security labels and MACs.
> The reason for this is again that I'm running in some random process's context
> and labelling and MAC'ing will affect the sharability of the cache.  This was
> objected to also.
> 
> This also bypasses auditing (I think).  I don't want the CacheFiles module's
> access to the cache to be logged against whatever process was accessing, say,
> an NFS file.  That process didn't ask to access the cache, and the cache is
> meant to be transparent.
> 
> I can see a few ways to deal with this:
> 
>  (1) Do all the cache operations in their own thread (sort of like knfsd).
> 
>  (2) Add further security ops for the caching code to call.  These might be of
>      use elsewhere in the kernel.  These would set cache-specific security
>      labels and check for them.
> 
>  (3) Add a flag or something to current to override the normal security on the
>      basis that it should be using the cache's security rather than the
>      process's security.
> 
> 
> Option (1) would lead to serialisation of all cached NFS operations over the
> accesses to disk.  Some of these accesses to disk involve sequences of mkdir(),
> lookup(), [sg]etxattr() and create() inode op calls - all of which are
> synchronous.  On the other hand, option (1) gives the simplest way of
> overriding security, and would entail the least work.  It would, though, give
> the biggest performance degradation.
> 
> Option (2) would require additional security ops, though possibly not many.  It
> might be sufficient to just add two: to set and to check the security for a
> cache object (be it file or directory).  This option would also preclude use of
> the vfs_mkdir() VFS op and suchlike, as they use the wrong sort of security.
> Some other way of handling the UNIX file ownership would also have to be sought.
> 
> Option (3) would require the current security handling in both the filesystem
> (DAC) and security modules (MAC) to check for the overriding context in
> current, and to go with that instead.  It might be possible to make such a
> thing incorporate fsuid and fsgid.
> 
> Thoughts anyone?

So you have two problems:
1) You want the cachefiles kernel module to be able to internally access
the cache files without regard to the permissions of the current
process.
2) You want to control how userspace may access the cache files in a way
that allows the cache daemon to do its job without exposing the cache to
corruption or leakage by other processes.

With regard to (1), bypassing security checks for internal access is
already done in certain cases (e.g. fs-private inodes, kernel-internal
sockets).  That can be done just by a flag on the task as in option (3);
it is separate from the issue of how to label the new file.

Your solutions for (2) seem to treat the entire cache as having the same
security properties regardless of the files that are being cached - a
single ownership and security context for all cache files.  This
requires a fully trusted cache daemon that can arbitrarily tamper with
any content cached in this manner.  I think you need to support at least
per-cache security attributes, and allow people to run separate
instances of the cache daemon for caches with different security
attributes (if not already possible), so that no single cache daemon
process needs to be all powerful.

If I understand correctly, you don't want to just propagate the security
attributes of the original file being cached to the cache file, because
that would expose the cache to corruption by processes that can access
the original file and because you would then have to deal with updating
those attributes upon changes to the original's attributes.  But
per-cache security attributes would be a reasonable approach to enabling
finer-grained protection.

Then the question is just how the cachefile module sets the security
attributes (including uid/gid and security context) to the appropriate
per-cache value when creating the cache files.  That could just be a
matter of setting the fsuid/fsgid and fscreate attributes (the latter
requiring a hook call) prior to creation, if that approach is palatable.
It would help to understand the objection to setting fsuid/fsgid more
clearly - it may have had more to do with always setting them to 0 for
all cache files, or with using that as a way to work around the lack of
an explicit mechanism for bypassing security checks for internal
accesses than with the setting of the fsuid/fsgid itself.

-- 
Stephen Smalley
National Security Agency

