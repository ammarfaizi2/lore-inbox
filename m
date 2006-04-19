Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWDSSKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWDSSKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWDSSKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:10:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48062 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750773AbWDSSKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:10:33 -0400
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
From: Arjan van de Ven <arjan@infradead.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 20:10:30 +0200
Message-Id: <1145470230.3085.84.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote:
> +/**
> + * _aa_perm_dentry
> + * @active: profile to check against
> + * @dentry: requested dentry
> + * @mask: mask of requested operations
> + * @pname: pointer to hold matched pathname (if any)
> + *
> + * Helper function.  Obtain pathname for specified dentry. 

which namespace will this be in?

> Verify if profile
> + * authorizes mask operations on pathname (due to lack of vfsmnt it is sadly
> + * necessary to search mountpoints in namespace -- when nameidata is passed
> + * more fully, this code can go away).  If more than one mountpoint matches
> + * but none satisfy the profile, only the first pathname (mountpoint) is
> + * returned for subsequent logging.

that sounds too bad ;) 
If I manage to mount /etc/passwd as /tmp/passwd, you'll only find the
later and your entire security system seems to be down the drain.
> +/**
> + * aa_register - register a new program
> + * @filp: file of program being registered
> + *
> + * Try to register a new program during execve().  This should give the
> + * new program a valid subdomain.
> + */
> +int aa_register(struct file *filp)
> +{
> +	char *filename;
> +	struct subdomain *sd;
> +	struct aaprofile *active;
> +	struct aaprofile *newprofile = NULL, unconstrained_flag;
> +	int 	error = -ENOMEM,
> +		exec_mode = 0,
> +		find_profile = 0,
> +		find_profile_mandatory = 0,
> +		complain = 0;
> +
> +	AA_DEBUG("%s\n", __FUNCTION__);
> +
> +	sd = AA_SUBDOMAIN(current->security);
> +
> +	if (sd) {
> +		complain = SUBDOMAIN_COMPLAIN(sd);
> +	} else {
> +		/* task has no subdomain.  This can happen when a task is
> +		 * created when subdomain is not loaded.  Allocate and
> +		 * attach a subdomain to the task
> +		 */
> +		sd = alloc_subdomain(current);
> +		if (!sd) {
> +			AA_WARN("%s: Failed to allocate subdomain\n",
> +				__FUNCTION__);
> +			goto out;
> +		}
> +
> +		current->security = sd;
> +	}
> +
> +	filename = aa_get_name(filp->f_dentry, filp->f_vfsmnt);

what if filp->f_dentry is NULL ?
like when the file got unlinked under you?


