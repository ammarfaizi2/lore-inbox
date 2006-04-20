Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWDTLkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDTLkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 07:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDTLkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 07:40:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37312 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750704AbWDTLkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 07:40:12 -0400
Date: Thu, 20 Apr 2006 06:40:10 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
Message-ID: <20060420114010.GB18604@sergelap.austin.ibm.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com> <20060420094036.GU27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420094036.GU27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Al Viro (viro@ftp.linux.org.uk):
> 
> > +static int _aa_perm_dentry(struct aaprofile *active, struct dentry *dentry,
> > +			   int mask, const char **pname)
> > +{
> > +	char *name = NULL, *failed_name = NULL;
> > +	struct aa_path_data data;
> > +	int error = 0, failed_error = 0, path_error,
> > +	    complain = PROFILE_COMPLAIN(active);
> > +
> > +	/* search all paths to dentry */
> > +
> > +	aa_path_begin(dentry, &data);
> > +	do {
> > +		name = aa_path_getname(&data);
> > +		if (name) {
> > +			/* error here is 0 (success) or +ve (mask of perms) */
> > +			error = aa_file_perm(active, name, mask);
> > +
> > +			/* access via any path is enough */
> > +			if (complain || error == 0)
> > +				break; /* Caller must free name */
> > +
> > +			/* Already have an path that failed? */
> > +			if (failed_name) {
> > +				aa_put_name(name);
> > +			} else {
> > +				failed_name = name;
> > +				failed_error = error;
> > +			}
> > +		}
> > +	} while (name);
> 
> Is that a joke?  Are you really proposing to do _that_ on anything resembling
> a hot path?
> 
> BTW, the problems here really have nothing to do with namespaces or
> lazy umount, seeing that it's whitelisting.  Moderate amount of bindings
> will kill you here.  So much that I suspect that one-time overhead of
> creating a namespace and umounting / remounting noexec / etc. on
> execve() will be cheaper than all this crap.

I guess this would require per-vfsmount flags (i.e. mount --bind -o ro)
to be implemented, but IIUC the suggestion is

given a policy

/bin/stty {
	/bin/stty r
}

during execve AA would unshare(CLONE_NEWNS), remount / readonly and
noexec,  and mount /bin/stty into place with exec privs.  I guess
getting /bin/stty into place shouldn't be much of a challenge (i.e.
just do the operations in the order
	mkdir /.tmp123
	mount --bind -o ro,noexec / /.tmp123
	mount --bind /bin/stty /.tmp123/bin/stty
	mount --bind /.tmp123 /
)
but implementing the 'ux' exec permission which apparmor currently has
(i.e. giving the ability for stty to then execute /bin/login without
restrictions) could be more challenging.

This also might beg for sys_unshare() (and corresponding code in clone)
to have it's own security_vfs_unshare() hook, rather than being globbed
in with CAP_SYS_ADMIN.

-serge
