Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752236AbWJ0OtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbWJ0OtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbWJ0OtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:49:15 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:54469 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1752235AbWJ0OtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:49:14 -0400
Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <2340.1161903200@redhat.com>
References: <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>
	 <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com> <24017.1161882574@redhat.com>
	 <2340.1161903200@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 27 Oct 2006 10:48:40 -0400
Message-Id: <1161960520.16681.380.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 23:53 +0100, David Howells wrote:
> > while the latter would require some new permission check to be defined
> > unless we can treat this as equivalent to some existing operation.
> 
> So what does this actually check?  I assume it checks that the process's
> current context permits the use of the specified secid in this snippet:
> 
> 	/* Check permission of current to set this context. */
> 	rc = security_cache_set_context(secid);

That's right, it would perform a check between the task's sid and the
specified secid.  We might want more information passed into the hook,
like the cache directory itself, so that we can apply checks based on
that as well (e.g. can the cache daemon apply this secid for use on
files created within this cache directory?).  We would either need to
introduce new permission definitions to SELinux to distinguish this
operation, or we would need to map it to something similar, e.g. apply
the same checks that we would perform if the cache daemon was directly
trying to set its fscreate value to this context and create files in
that context.  Possibly something like:
	int security_cache_set_context(struct vfsmount *mnt, struct dentry *dentry, u32 secid)
	{
		struct task_security_struct *tsec = current->security;
		struct superblock_security_struct *sbsec = dentry->d_inode->i_sb->s_security;
		int rc;
		/* Can current set its fscreate attribute? */
		rc = task_has_perm(current, current, 
					PROCESS__SETFSCREATE);
		if (rc)
			return rc;
		/* Can current add entries to the cache dir? */
		rc = dentry_has_perm(current, mnt, dentry, 
					DIR__ADD_NAME|DIR__SEARCH);
		if (rc)
			return rc;
		/* Can current create files with this secid? */
		rc = avc_has_perm(tsec->sid, secid, SECCLASS_FILE, 
					FILE__CREATE, NULL);
		if (rc)
			return rc;
		/* Can files with this secid be placed in that filesystem? */
		return avc_has_perm(secid, sbsec->sid, SECCLASS_FILESYSTEM, 
					FILESYSTEM__ASSOCIATE, NULL);
	}

> > Later, when going to create a file in that cache, the cachefiles module
> > would do something like:
> > 	/* Save and switch the fs secid for creation. */
> > 	fssecid = security_getfssecid();
> > 	security_setfssecid(cache->secid);
> > 	<create file>
> > 	/* Restore the original fs secid. */
> > 	security_setfssecid(fssecid);
> > SELinux would then provide selinux_getfsecid() and selinux_setfssecid()
> > implementations that are just:
> > 	u32 selinux_getfssecid(void)
> > 	{
> > 		struct task_security_struct *tsec = current->security;
> > 		return tsec->create_sid;
> > 	}
> > 	void selinux_setfssecid(u32 secid)
> > 	{
> > 		struct task_security_struct *tsec = current->security;
> > 		tsec->create_sid = secid;
> > 	}
> 
> That sounds doable.  I presume I should attend to fsuid/fsgid myself, much as
> I'm doing now?

Yes, I think so, although you may want to make those values configurable
too (although it isn't clear that a cache daemon can be run as non-root
at present).

I think we likely also want to refer to the above secid as fscreateid or
similar instead of just fsecid for clarity, because it isn't quite the
same thing as a fsuid/fsgid; it is _only_ used for labeling of new
files, not as the label of the process for permission checking purposes.
So it would be security_getfscreateid() and security_setfscreateid().
Process labels and file labels are distinct.

-- 
Stephen Smalley
National Security Agency

