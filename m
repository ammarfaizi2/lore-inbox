Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945974AbWJZW4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945974AbWJZW4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945973AbWJZW4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:56:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51627 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1945975AbWJZW4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:56:02 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>  <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 23:53:20 +0100
Message-ID: <2340.1161903200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> When the daemon writes the context value (a string) to the cachefiles
> module interface for a given cache, the cachefiles module would do
> something like the following:

This looks reasonable.

> SELinux would then provide selinux_secctx_to_secid() and
> selinux_cache_set_context() implementations; the former would just be call to
> selinux_string_to_sid(),

That sounds fairly easy.

> while the latter would require some new permission check to be defined
> unless we can treat this as equivalent to some existing operation.

So what does this actually check?  I assume it checks that the process's
current context permits the use of the specified secid in this snippet:

	/* Check permission of current to set this context. */
	rc = security_cache_set_context(secid);

> You'll find that there is already a security_secid_to_secctx() hook defined
> for LSM, so the first hook just adds the other direction.

Okay.

> 	cache->secid = secid;

I was wondering if the cache struct should have a "void *security" that the LSM
modules can set, free and assert temporarily, but this sounds like it will do.

> Later, when going to create a file in that cache, the cachefiles module
> would do something like:
> 	/* Save and switch the fs secid for creation. */
> 	fssecid = security_getfssecid();
> 	security_setfssecid(cache->secid);
> 	<create file>
> 	/* Restore the original fs secid. */
> 	security_setfssecid(fssecid);
> SELinux would then provide selinux_getfsecid() and selinux_setfssecid()
> implementations that are just:
> 	u32 selinux_getfssecid(void)
> 	{
> 		struct task_security_struct *tsec = current->security;
> 		return tsec->create_sid;
> 	}
> 	void selinux_setfssecid(u32 secid)
> 	{
> 		struct task_security_struct *tsec = current->security;
> 		tsec->create_sid = secid;
> 	}

That sounds doable.  I presume I should attend to fsuid/fsgid myself, much as
I'm doing now?

David
