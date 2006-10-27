Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752275AbWJ0PoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbWJ0PoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbWJ0PoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:44:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28585 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752275AbWJ0PoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:44:01 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161960520.16681.380.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161960520.16681.380.camel@moss-spartans.epoch.ncsc.mil>  <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> <2340.1161903200@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, aviro@redhat.com,
       linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 27 Oct 2006 16:42:46 +0100
Message-ID: <4786.1161963766@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> We might want more information passed into the hook, like the cache
> directory itself,

I can do that.  I have the cache directory path and the cache tag name both
available as strings.

> 	int security_cache_set_context(struct vfsmount *mnt, struct dentry *dentry, u32 secid)
> 	{

Where are you envisioning this going?  In SELinux, in the LSM core or in
cachefiles?  I was also wondering if I could generalise it to handle all cache
types, but the permissions checks are probably going to be quite different for
each type.  For instance, CacheFiles uses files on a mounted fs, whilst CacheFS
uses a block device.

> We would either need to introduce new permission definitions to SELinux to
> distinguish this operation, or we would need to map it to something similar,
> e.g. apply the same checks that we would perform if the cache daemon was
> directly trying to set its fscreate value to this context and create files in
> that context.

Mapping it to something similar sounds reasonable, though I'd quite like
something general, so that I can check for any type of cache coming up.

Also, with your multiple cache example, how would I bring each cachefilesd
daemon up in a different context so that it could handle a different cache with
a different context?

> > That sounds doable.  I presume I should attend to fsuid/fsgid myself, much
> > as I'm doing now?
> 
> Yes, I think so, although you may want to make those values configurable
> too (although it isn't clear that a cache daemon can be run as non-root
> at present).

Actually, that's not something I had considered, but there's no particular
reason that files in the cache have to be owned by root specifically; nor is
there a reason why cachefilesd needs to run as root.  The main thing is that
the files are owned by whatever user the daemon runs as.  It'd mean creating
another special user for it, but we do that all the time...

> I think we likely also want to refer to the above secid as fscreateid or
> similar instead of just fsecid for clarity, because it isn't quite the
> same thing as a fsuid/fsgid; it is _only_ used for labeling of new
> files, not as the label of the process for permission checking purposes.
> So it would be security_getfscreateid() and security_setfscreateid().
> Process labels and file labels are distinct.

Gotcha.

David
