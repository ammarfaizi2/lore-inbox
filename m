Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUA3Ubw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUA3Ubw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:31:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:27342 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263510AbUA3Ubu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:31:50 -0500
Date: Fri, 30 Jan 2004 12:33:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: arjanv@redhat.com, thomas.schlichter@web.de, thoffman@arnor.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-Id: <20040130123301.70009427.akpm@osdl.org>
In-Reply-To: <20040130201731.GY9155@sun.com>
References: <20040130014108.09c964fd.akpm@osdl.org>
	<1075489136.5995.30.camel@moria.arnor.net>
	<200401302007.26333.thomas.schlichter@web.de>
	<1075490624.4272.7.camel@laptop.fenrus.com>
	<20040130114701.18aec4e8.akpm@osdl.org>
	<20040130201731.GY9155@sun.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> On Fri, Jan 30, 2004 at 11:47:01AM -0800, Andrew Morton wrote:
> > > directly calling sys_ANYTHING sounds really wrong to me...
> 
> It sounded wrong to me, but it gets done ALL OVER.
> 
> > Tim, I do think it would be neater to add another entry point in sys.c for
> > nfsd and just do a memcpy.
> 
> Do you prefer:
> 
> a) make a function
> 	sys.c: ksetgroups(int gidsetsize, gid_t *grouplist)
>    which does the same as sys_setgroups, but without the copy_from_user()
>    stuff?  The only user (for now, maybe ever) is nfsd.
> 
> b) make a function
> 	sys.c: nfsd_setgroups(int gidsetsize, gid_t *grouplist)
>    which does the same as sys_setgroups, but without the copy_from_user()
> 
> c) make the nfsd code build a struct group_info and call
>    set_current_groups()
> 

Can we do d)?

static long do_setgroups(int gidsetsize, gid_t __user *user_grouplist,
			gid_t *kern_grouplist)
{
	gid_t groups[NGROUPS];
	int retval;

	if (!capable(CAP_SETGID))
		return -EPERM;
	if ((unsigned) gidsetsize > NGROUPS)
		return -EINVAL;
	if (user_grouplist) {
		if (copy_from_user(groups, user_grouplist,
				gidsetsize * sizeof(gid_t)))
			return -EFAULT;
	} else {
		memcpy(groups, kern_grouplist, gidsetsize * sizeof(gid_t));
	}
	retval = security_task_setgroups(gidsetsize, groups);
	if (retval)
		return retval;
	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
	current->ngroups = gidsetsize;
	return 0;
}

asmlinkage long sys_setgroups(int gidsetsize, gid_t __user *grouplist)
{
	return do_setgroups(gidsetsize, grouplist, NULL);
}

long kern_setgroups(int gidsetsize, gid_t *grouplist)
{
	return do_setgroups(gidsetsize, NULL, grouplist);
}

It's a bit grubby, but the grubbiness is localised.

