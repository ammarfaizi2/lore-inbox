Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUA1AmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUA1AmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:42:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:15845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265661AbUA1Al5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:41:57 -0500
Date: Tue, 27 Jan 2004 16:41:52 -0800
From: Chris Wright <chrisw@osdl.org>
To: Tim Hockin <thockin@sun.com>
Cc: torvalds@osdl.org,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
Subject: Re: NGROUPS 2.6.2rc2
Message-ID: <20040127164152.C11525@osdlab.pdx.osdl.net>
References: <20040127225311.GA9155@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040127225311.GA9155@sun.com>; from thockin@sun.com on Tue, Jan 27, 2004 at 02:53:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tim Hockin (thockin@sun.com) wrote:
> +/* validate and set current->group_info */
> +int set_current_groups(struct group_info *info)
> +{
> +	int retval;
> +	struct group_info *old_info;
> +
> +	retval = security_task_setgroups(info);
> +	if (retval)
> +		return retval;
> +
> +	groups_sort(info);
> +	old_info = current->group_info;
> +	current->group_info = info;
> +	put_group_info(old_info);
> +
> +	return 0;
> +}
<snip>
> ===== fs/proc/array.c 1.55 vs edited =====
> --- 1.55/fs/proc/array.c	Tue Oct 14 14:00:09 2003
> +++ edited/fs/proc/array.c	Tue Jan 27 12:40:02 2004
> @@ -176,8 +176,8 @@
>  		p->files ? p->files->max_fds : 0);
>  	task_unlock(p);
>  
> -	for (g = 0; g < p->ngroups; g++)
> -		buffer += sprintf(buffer, "%d ", p->groups[g]);
> +	for (g = 0; g < min(p->group_info->ngroups,NGROUPS_SMALL); g++)
> +		buffer += sprintf(buffer, "%d ", GROUP_AT(p->group_info,g));
>  
>  	buffer += sprintf(buffer, "\n");
>  	return buffer;

this seems racy with no get/put?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
