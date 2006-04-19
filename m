Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWDSTqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWDSTqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWDSTqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:46:43 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:63480 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751202AbWDSTqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:46:42 -0400
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 15:50:43 -0400
Message-Id: <1145476243.24289.269.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote:
> +/**
> + * aa_get_name - retrieve fully qualified path name
> + * @dentry: relative path element
> + * @mnt: where in tree
> + *
> + * Returns fully qualified path name on sucess, NULL on failure.
> + * aa_put_name must be used to free allocated buffer.
> + */
> +char *aa_get_name(struct dentry *dentry, struct vfsmount *mnt)
> +{
> +	char *page, *name = NULL;
> +
> +	page = (char *)__get_free_page(GFP_KERNEL);
> +	if (!page)
> +		goto out;
> +
> +	name = d_path_flags(dentry, mnt, page, PAGE_SIZE,
> +			DPATH_SYSROOT|DPATH_NODELETED);

So on every inode hook call, you end up allocating a temporary page,
calling d_path (taking global dcache_lock), and you do this possibly
multiple times per object (due to iterating over vfsmounts) and you may
need to do it for multiple objects on a single hook call (e.g.
link/rename).   Is that correct?

> +/**
> + * aa_perm_nameidata: interface to sd_perm accepting nameidata
> + * @active: profile to check against
> + * @nd: namespace data (for vfsmnt and dentry)
> + * @mask: access mode requested
> + */
> +int aa_perm_nameidata(struct aaprofile *active, struct nameidata *nd, int mask)
> +{
> +	int error = 0;
> +
> +	if (nd)
> +		error = aa_perm(active, nd->dentry, nd->mnt, mask);
> +
> +	return error;
> +}

So what about the !nd case.  For when permission(9) is called with a
NULL nameidata.  Unconditional success in that case seems a bit
worrisome.

I also vaguely recall a problem with trying to use the nameidata
(vfsmount, dentry) pair to d_path in SELinux for audit purposes back
when avc_audit was trying to audit paths before migrating to using the
audit system for that purpose.  Interacted badly with rpc_pipefs upon
rpc_lookup_parent, IIRC.  Might want to check whether you handle it
correctly.

-- 
Stephen Smalley
National Security Agency

