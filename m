Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWDTJkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWDTJkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWDTJkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:40:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55514 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750792AbWDTJkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:40:39 -0400
Date: Thu, 20 Apr 2006 10:40:36 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
Message-ID: <20060420094036.GU27946@ftp.linux.org.uk>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int _aa_perm_dentry(struct aaprofile *active, struct dentry *dentry,
> +			   int mask, const char **pname)
> +{
> +	char *name = NULL, *failed_name = NULL;
> +	struct aa_path_data data;
> +	int error = 0, failed_error = 0, path_error,
> +	    complain = PROFILE_COMPLAIN(active);
> +
> +	/* search all paths to dentry */
> +
> +	aa_path_begin(dentry, &data);
> +	do {
> +		name = aa_path_getname(&data);
> +		if (name) {
> +			/* error here is 0 (success) or +ve (mask of perms) */
> +			error = aa_file_perm(active, name, mask);
> +
> +			/* access via any path is enough */
> +			if (complain || error == 0)
> +				break; /* Caller must free name */
> +
> +			/* Already have an path that failed? */
> +			if (failed_name) {
> +				aa_put_name(name);
> +			} else {
> +				failed_name = name;
> +				failed_error = error;
> +			}
> +		}
> +	} while (name);

Is that a joke?  Are you really proposing to do _that_ on anything resembling
a hot path?

BTW, the problems here really have nothing to do with namespaces or
lazy umount, seeing that it's whitelisting.  Moderate amount of bindings
will kill you here.  So much that I suspect that one-time overhead of
creating a namespace and umounting / remounting noexec / etc. on
execve() will be cheaper than all this crap.
