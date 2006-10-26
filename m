Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945906AbWJZRpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945906AbWJZRpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945904AbWJZRpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:45:23 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:51929 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1423591AbWJZRpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:45:22 -0400
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <24017.1161882574@redhat.com>
References: <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com>   <24017.1161882574@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 26 Oct 2006 13:45:06 -0400
Message-Id: <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 18:09 +0100, David Howells wrote:
> > and prior to creating a file within the cache, it would set the current
> > fscreate attribute (via a security hook call) to that per-cache value, in
> > much the same way it is presently setting the fsuid/fsgid.
> 
> That sounds reasonable.  There has to be some way to revert it, though.

Yes, that can be done.  See below.

> > The fscreate attribute is normally set via the security_setprocattr hook
> > (when a task writes to /proc/self/attr/fscreate);
> 
> That makes it sound like fscreate is a per-process attribute, not a per-thread
> attribute.  The former would definitely be a problem.

It is actually per-task (thread), sorry for the confusing reference
to /proc/self.

> > You may also want to convert the context value to a secid once when it is
> > first configured, and then later just pass the secid to the hook call for
> > setting the fscreate value for efficiency.
> 
> I'm not sure what you mean by that.  Can you give a pseudo-code example?

When the daemon writes the context value (a string) to the cachefiles
module interface for a given cache, the cachefiles module would do
something like the following:
	/* Map the context to an integer. */
	rc = security_secctx_to_secid(value, size, &secid);
	if (rc)
		goto err;
	/* Check permission of current to set this context. */
	rc = security_cache_set_context(secid);
	if (rc)
		goto err;
	cache->secid = secid;
SELinux would then provide selinux_secctx_to_secid() and
selinux_cache_set_context() implementations; the former would just be
call to selinux_string_to_sid(), while the latter would require some new
permission check to be defined unless we can treat this as equivalent to
some existing operation.  You'll find that there is already a
security_secid_to_secctx() hook defined for LSM, so the first hook just
adds the other direction.

Later, when going to create a file in that cache, the cachefiles module
would do something like:
	/* Save and switch the fs secid for creation. */
	fssecid = security_getfssecid();
	security_setfssecid(cache->secid);
	<create file>
	/* Restore the original fs secid. */
	security_setfssecid(fssecid);
SELinux would then provide selinux_getfsecid() and selinux_setfssecid()
implementations that are just:
	u32 selinux_getfssecid(void)
	{
		struct task_security_struct *tsec = current->security;
		return tsec->create_sid;
	}
	void selinux_setfssecid(u32 secid)
	{
		struct task_security_struct *tsec = current->security;
		tsec->create_sid = secid;
	}

-- 
Stephen Smalley
National Security Agency

