Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752629AbWKBUer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbWKBUer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbWKBUer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:34:47 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:20473 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1752620AbWKBUeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:34:46 -0500
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <25037.1162487801@redhat.com>
References: <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil>
	 <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com>   <25037.1162487801@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 02 Nov 2006 15:33:41 -0500
Message-Id: <1162499621.5519.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 17:16 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > Unless there is some benefit to setting a ->fssid and checking against
> > it (e.g. safeguarding the module against unintentional internal access),
> > I think the task flag approach is preferable.
> 
> Well, I think the use of ->fssid is simpler and faster from an implementation
> standpoint (see the attached patch), and it can always be used for such as the
> in-kernel nfsd later.
> 
> The way I've done it in this patch is to have ->fssid shadow ->sid as long as
> they're the same.  But ->fssid can be set to something else and then later
> reset, at which point it becomes the same as ->sid again.  A hook is provided
> to perform both of these operations:
> 
> 	security_set_fssid(overriding_SID);  //set
> 	...
> 	security_set_fssid(SECSID_NULL);  //reset
> 
> The rest of the patch is that more or less anywhere ->sid is used to represent
> a process as an actor, this is replaced with ->fssid.  This part requires no
> conditional jumps.  It becomes a bit tricky around execve() time, but I think
> it's reasonable to ignore that as execve() is unlikely to happen in an
> overridden context; or maybe the execve() related ops should be failed if
> ->sid != ->fssid.
> 
> Do you think this is reasonable?  Or do you definitely want me to use the
> suppression flag approach instead?

It doesn't look simpler, but if you take this approach, then:
1) fssid needs to be renamed to reflect its use as the subject/actor
label (e.g. => "subjsid"),
2) Use "secid" in the core code and LSM interfaces rather than just
"sid" to avoid confusion with session ids (e.g. => "subjsecid"),
3) Define and use a SECID_NULL or similar in the LSM interface
(SECSID_NULL is SELinux private),
4) Be careful about overuse of this id (see below for some examples).

> The flag approach is a bit more work to implement and will slow most ops down
> by virtue of including an extra check, though not all ops can be bypassed (for
> instance the op that assigns a security label to an inode can't be bypassed).

In most cases, you could just generalize the existing IS_PRIVATE(inode)
tests in the security static inlines in security.h to also incorporate a
task flag test.  security_inode_init_security() would be an exception.

> There are a couple of things I'm not sure about with the ->fssid approach:
> 
>  (1) What will auditing do?  Is it possible to have an SID that isn't audited?
> 
>  (2) How do I come up with a security label for the module to use?

Note that these issues don't exist in the task flag approach.  I'm not
entirely sure what you mean by (1); the existing syscall audit support
would never look at your fssid, just the ->sid, and only at syscall
entry and exit.  SELinux avc audit messages from permission checks would
include the fssid's context if that was the basis of the check.  

For (2), you have to make up a SID.  This differs from how NFS would use
such a facility, since it could just use the client process' context (if
that were available), but in this case you have no process credential
that is exactly what you want to apply (not even the cache daemon's SID
is precisely right).  This goes back to the earlier discussion of
security_transition_sid.  But this requires policy configuration to make
it work properly, and the absence of the necessary type transition and
allow rules could yield a broken cache. This makes me doubtful about
this approach for cachefiles (vs. NFS, where it makes more sense).

> diff --git a/include/linux/security.h b/include/linux/security.h
> index ff20ec4..48e9e43 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1166,6 +1166,11 @@ #ifdef CONFIG_SECURITY
>   *	Set the current FS security ID.
>   *	@secid contains the security ID to set.
>   *
> + * @set_fssid:

s/fssid/subjsecid/ or similar.  Likewise throughout.

> @@ -2837,7 +2841,7 @@ static int selinux_task_kill(struct task
>  		perm = signal_to_av(sig);
>  	tsec = p->security;
>  	if (secid)
> -		rc = avc_has_perm(secid, tsec->sid, SECCLASS_PROCESS, perm, NULL);
> +		rc = avc_has_perm(secid, tsec->fssid, SECCLASS_PROCESS, perm, NULL);

The task is the target of a check here, so you don't want to use the
overriding SID for it.  Otherwise, you may have a false denial or a
false allow of the signal.

> @@ -2882,7 +2888,7 @@ static void selinux_task_to_inode(struct
>  	struct task_security_struct *tsec = p->security;
>  	struct inode_security_struct *isec = inode->i_security;
>  
> -	isec->sid = tsec->sid;
> +	isec->sid = tsec->fssid;

Here we are labeling a /proc/pid inode with the task SID, when it is
created or revalidated, so you don't want to use the overriding SID here
either.  

-- 
Stephen Smalley
National Security Agency

