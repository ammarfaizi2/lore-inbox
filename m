Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423141AbWJZKl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423141AbWJZKl6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423231AbWJZKl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:41:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20892 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423141AbWJZKl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:41:57 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>  <16969.1161771256@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 11:40:55 +0100
Message-ID: <8567.1161859255@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> So you have two problems:
> 1) You want the cachefiles kernel module to be able to internally access
> the cache files without regard to the permissions of the current
> process.
> 2) You want to control how userspace may access the cache files in a way
> that allows the cache daemon to do its job without exposing the cache to
> corruption or leakage by other processes.

That's about it, yes.

I wanted the management daemon to live in userspace because it has to create a
couple of big tables of cullable objects and then keep them around for when
culling becomes a necessity.  Filling the tables takes a long time, and it
gets longer the more object you have in the cache.

> With regard to (1), bypassing security checks for internal access is
> already done in certain cases (e.g. fs-private inodes, kernel-internal
> sockets).  That can be done just by a flag on the task as in option (3);
> it is separate from the issue of how to label the new file.

Yeah...

> Your solutions for (2) seem to treat the entire cache as having the same
> security properties regardless of the files that are being cached - a
> single ownership and security context for all cache files.

Yes.  NFS handles the security for the user, so for files in the cache that
are acting as data storage objects, I can just have as restrictive a security
as I can manage.

> This requires a fully trusted cache daemon that can arbitrarily tamper with
> any content cached in this manner.

Well, we could say that the cache daemon isn't actually allowed to read or
write any of these files; all it need to do is read their cache xattrs, names
and atimes, and rename and delete them.  It also needs to be able to do
readdir and lookup on the directories contained therein.

> I think you need to support at least per-cache security attributes, and
> allow people to run separate instances of the cache daemon for caches with
> different security attributes (if not already possible), so that no single
> cache daemon process needs to be all powerful.

My plan is to have a separate cache daemon for each cache.  That way the cull
table filling isn't serialised over all caches.

> If I understand correctly, you don't want to just propagate the security
> attributes of the original file being cached to the cache file,

That is correct.

> because that would expose the cache to corruption by processes that can
> access the original file

Yes.

> and because you would then have to deal with updating those attributes upon
> changes to the original's attributes.

Yes.

But also because the netfs may impose stricter access controls than can be
represented in filesystem underlying the cache.

But mainly because the cache management daemon has to be able to operate on
the cache.

> But per-cache security attributes would be a reasonable approach to enabling
> finer-grained protection.

I'm not sure what you mean by this exactly.  I'd be happy to set the same
security attributes on the files and directories in the cache that impose
draconian restrictions, but whatever I do has to be representable in the
backing filesystem across reboots.

> Then the question is just how the cachefile module sets the security
> attributes (including uid/gid and security context) to the appropriate
> per-cache value when creating the cache files.

Yes.

> That could just be a matter of setting the fsuid/fsgid and fscreate
> attributes (the latter requiring a hook call) prior to creation, if that
> approach is palatable.

It is to me.

> It would help to understand the objection to setting fsuid/fsgid more
> clearly - it may have had more to do with always setting them to 0 for all
> cache files, or with using that as a way to work around the lack of an
> explicit mechanism for bypassing security checks for internal accesses than
> with the setting of the fsuid/fsgid itself.

Christoph did enscribe thus:

| - in cachefiles_walk_to_object reseting the fsuid/fsgid is not allowed

Which I take to mean that I'm not allowed to change fsuid and fsgid.  Why not,
I'm not entirely certain.  I wouldn't have thought it would matter as long as
I put them back again before returning.

David
