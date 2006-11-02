Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWKBVG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWKBVG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWKBVG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:06:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31675 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750855AbWKBVG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:06:26 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162499621.5519.91.camel@moss-spartans.epoch.ncsc.mil> 
References: <1162499621.5519.91.camel@moss-spartans.epoch.ncsc.mil>  <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
       jmorris@namei.org, chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 02 Nov 2006 21:05:02 +0000
Message-ID: <916.1162501502@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> It doesn't look simpler, but if you take this approach, then:
> 1) fssid needs to be renamed to reflect its use as the subject/actor
> label (e.g. => "subjsid"),

Okay.

> 2) Use "secid" in the core code and LSM interfaces rather than just
> "sid" to avoid confusion with session ids (e.g. => "subjsecid"),

Okay.

> 3) Define and use a SECID_NULL or similar in the LSM interface
> (SECSID_NULL is SELinux private),

Defining a reset function would be better.

> 4) Be careful about overuse of this id (see below for some examples).

Yeah.

> > The flag approach is a bit more work to implement and will slow most ops
> > down by virtue of including an extra check, though not all ops can be
> > bypassed (for instance the op that assigns a security label to an inode
> > can't be bypassed).
> 
> In most cases, you could just generalize the existing IS_PRIVATE(inode)
> tests in the security static inlines in security.h to also incorporate a
> task flag test.  security_inode_init_security() would be an exception.

So you were thinking of doing it in security.h?

> > There are a couple of things I'm not sure about with the ->fssid approach:
> > 
> >  (1) What will auditing do?  Is it possible to have an SID that isn't
> >      audited?
> > 
> >  (2) How do I come up with a security label for the module to use?
> 
> Note that these issues don't exist in the task flag approach.

Yes.

> I'm not entirely sure what you mean by (1); the existing syscall audit
> support would never look at your fssid, just the ->sid, and only at syscall
> entry and exit.

Which is irrelevant since the CacheFiles module doesn't make syscalls.

> SELinux avc audit messages from permission checks would include the fssid's
> context if that was the basis of the check.

That'd probably be sufficient since at least you could tell them apart.

> For (2), you have to make up a SID.

I've done this and got it working with Karl's help.

In cachefilesd.te, I have:

	...
	type cachefilesd_t;
	type cachefilesd_exec_t;
	domain_type(cachefilesd_t)
	init_daemon_domain(cachefilesd_t, cachefilesd_exec_t)

	require { type kernel_t; }
	type cachefiles_kernel_t;
	domain_type(cachefiles_kernel_t)
	type_transition cachefilesd_t kernel_t : process cachefiles_kernel_t;
	...

Then I added a CacheFiles hook to do:

	static int selinux_cachefiles_getsid(u32 secid, u32 *modsecid)
	{
		return security_transition_sid(secid, SECINITSID_KERNEL,
					       SECCLASS_PROCESS, modsecid);
	}

It takes the daemon's security ID and translates it to the module's security
ID.

The way I was thinking about it is that a CacheFiles cache has a presence in
the kernel that lasts as long as the cache is in active service.  This could
be considered the equivalent of a process, although it doesn't have a
task_struct of its own; but rather makes use of the task_struct of processes
that want to use the service.

> This differs from how NFS would use such a facility, since it could just use
> the client process' context (if that were available),

Indeed; but once NFS had a SID, the two would then be the same.

> But this requires policy configuration to make it work properly, and the
> absence of the necessary type transition and allow rules could yield a
> broken cache.

If the rule isn't there then the cache would refuse to start if SELinux is in
enforcing mode, assuming security_transition_sid() returns an error in that
case.  Otherwise it'll run in cachefilesd's context, I think, which it will
cause it to give an error and refuse to cache in enforcing mode because that
context doesn't permit it to do certain things it checks for (like creating
files and directories).

> > +		rc = avc_has_perm(secid, tsec->fssid, SECCLASS_PROCESS, perm, NULL);
> ...
> The task is the target of a check here, so you don't want to use the
> overriding SID for it.  Otherwise, you may have a false denial or a
> false allow of the signal.

Yep...  I got that one wrong.

> > -	isec->sid = tsec->sid;
> > +	isec->sid = tsec->fssid;
> 
> Here we are labeling a /proc/pid inode with the task SID, when it is
> created or revalidated, so you don't want to use the overriding SID here
> either.  

And again.


Anyway, I'll expand what I've done and give it a go.  I may find compelling
reasons[*] not to do it this way.  I can always ditch the patches after all...

[*] Overzealous auditing most probably.

Thanks,
David
