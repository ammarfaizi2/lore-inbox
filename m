Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423608AbWJZQgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423608AbWJZQgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423611AbWJZQgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:36:32 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:8645 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1423608AbWJZQgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:36:31 -0400
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <22702.1161878644@redhat.com>
References: <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 26 Oct 2006 12:34:47 -0400
Message-Id: <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 17:04 +0100, David Howells wrote:
> > Thus, the cache daemon instance for external data can't tamper with the
> > cache of internal data, or vice versa.  Now, your default configuration may
> > just use a single set of security attributes for all caches, and you might
> > have a default definition in your configuration that is applied in the
> > absence of any per-cache value, but you would be providing a mechanism by
> > which people who want to isolate different caches can do so.
> 
> Sounds okay.  I'm not sure how I'd allow that to be configured.  I suspect
> it'd have to involve the cache module calling an LSM hook for each cache.

I'd expect some userspace process to provide the proper context for each
cache to the cache module during normal configuration, and that context
would come from the same config file that defines the rest of the cache
info.  There would need to be a permission check (via a security hook
call) at that point between the process' context and the provided
context to prevent a given process from setting the context arbitrarily.
Is the configuration of the cache module done by the cache daemon
itself?  What access checks is it normally subjected to?  Do you already
perform a check against the cache dir?

The cache module would then internally store the per-cache context
values, and prior to creating a file within the cache, it would set the
current fscreate attribute (via a security hook call) to that per-cache
value, in much the same way it is presently setting the fsuid/fsgid.
The fscreate attribute is normally set via the security_setprocattr hook
(when a task writes to /proc/self/attr/fscreate); however, you may want
a specialized hook for this purpose that distinguishes the fact that you
are doing this internally.  Or possibly your mechanism for exempting the
cache module from permission checking would allow you to just use
security_setprocattr as is.  You may also want to convert the context
value to a secid once when it is first configured, and then later just
pass the secid to the hook call for setting the fscreate value for
efficiency.  We would need a security_secctx_to_secid() hook for that,
and then a variant of security_setprocattr() that takes a secid instead
of a context value.  Some similar handling already exists for audit,
secmark, peersec, and netlink, although some of those are using selinux
specific interfaces presently (but they can be turned into LSM hooks
fairly easily).

-- 
Stephen Smalley
National Security Agency

