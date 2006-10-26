Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423594AbWJZQFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423594AbWJZQFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423596AbWJZQFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:05:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423594AbWJZQFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:05:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>  <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 17:04:04 +0100
Message-ID: <22702.1161878644@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > Well, we could say that the cache daemon isn't actually allowed to read or
> > write any of these files; all it need to do is read their cache xattrs,
> > names and atimes, and rename and delete them.  It also needs to be able to
> > do readdir and lookup on the directories contained therein.
> 
> Yes, SELinux policy could impose such a restriction, as well as ensuring
> that only the cache daemon can access the cache in the first place (vs.  any
> arbitrary uid 0 process).

Okay.

> However, can the cache daemon effectively redirect an access by a process to
> a file that is being cached to another file by renaming cache files within
> the cache, such that the higher level permission checking and auditing would
> be applied to one file but the actual access would occur to another one?  If
> so, then it can effectively downgrade any file it is caching to the security
> context of any other file it is caching.

Whilst it can do a rename trick like that, there's then another check made by
the module once it has the dentry it wants.  This involves checking the
netfs's idea of the net file state against the cache's idea of the net file
state (coherency management) which is stored in an xattr attached to the cache
file.

This could be extended to revalidate the key also in some manner, but
currently if the mtime, ctime or file size are different to that on the
server, the cache file will be scrapped.

> > > But per-cache security attributes would be a reasonable approach to
> > > enabling finer-grained protection.
> > 
> > I'm not sure what you mean by this exactly.  I'd be happy to set the same
> > security attributes on the files and directories in the cache that impose
> > draconian restrictions, but whatever I do has to be representable in the
> > backing filesystem across reboots.
> 
> What I mean is that the cachefiles configuration would allow one to
> specify a set of security attributes (uid, gid, security context) per
> cache, and those attributes would then be applied by the cachefiles
> kernel module when creating files within that cache.

Oh, I see what you mean.  Yes, that's what I'm thinking of.

> This means that all files within a given cache have the same security
> attributes, but different caches can have different attributes.

That's fine too.

> Then one can run different cache daemon instances with different process
> security attributes, and ensure that each one can only access the caches it
> is responsible for managing.

Okay.

> Thus, the cache daemon instance for external data can't tamper with the
> cache of internal data, or vice versa.  Now, your default configuration may
> just use a single set of security attributes for all caches, and you might
> have a default definition in your configuration that is applied in the
> absence of any per-cache value, but you would be providing a mechanism by
> which people who want to isolate different caches can do so.

Sounds okay.  I'm not sure how I'd allow that to be configured.  I suspect
it'd have to involve the cache module calling an LSM hook for each cache.

> > > It would help to understand the objection to setting fsuid/fsgid more
> > > clearly - it may have had more to do with always setting them to 0 for
> > > all cache files, or with using that as a way to work around the lack of
> > > an explicit mechanism for bypassing security checks for internal
> > > accesses than with the setting of the fsuid/fsgid itself.
> > 
> > Christoph did enscribe thus:
> > 
> > | - in cachefiles_walk_to_object reseting the fsuid/fsgid is not allowed
> > 
> > Which I take to mean that I'm not allowed to change fsuid and fsgid.  Why
> > not, I'm not entirely certain.  I wouldn't have thought it would matter as
> > long as I put them back again before returning.
> 
> I think he also talked about binding the right access control credentials to
> the cache files, which I think is more along the lines of the discussion
> above (and Viro's concern).  I don't think it is so much about setting
> fsuid/fsgid per se, but about being able to protect the cache at finer
> granularity.

He did state both objections, yes; but he did specifically say something about
fsuid and fsgid.  However, he can always be overridden.

David
