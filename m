Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUJHVqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUJHVqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUJHVqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:46:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:44204 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265395AbUJHVqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:46:03 -0400
Date: Fri, 8 Oct 2004 14:45:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041008144539.K2357@build.pdx.osdl.net>
References: <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net> <87k6ubcccl.fsf@sulphur.joq.us> <1096663225.27818.12.camel@krustophenia.net> <20041001142259.I1924@build.pdx.osdl.net> <1096669179.27818.29.camel@krustophenia.net> <20041001152746.L1924@build.pdx.osdl.net> <877jq5vhcw.fsf@sulphur.joq.us> <1097193102.9372.25.camel@krustophenia.net> <1097269108.1442.53.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1097269108.1442.53.camel@krustophenia.net>; from rlrevell@joe-job.com on Fri, Oct 08, 2004 at 04:58:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> +  # sysctl -w security/realtime/any=0
> +  # sysctl -w security/realtime/gid=29
> +  # sysctl -w security/realtime/mlock=1
> +

I think these should move to sysfs.

> +Jack O'Quin, joq@joq.us
> diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/include/linux/sysctl.h linux-2.6.8.1-rt02/include/linux/sysctl.h
> --- linux-2.6.8.1/include/linux/sysctl.h	Sat Aug 14 05:55:33 2004
> +++ linux-2.6.8.1-rt02/include/linux/sysctl.h	Sun Oct  3 10:56:16 2004
> @@ -61,7 +61,14 @@
>  	CTL_DEV=7,		/* Devices */
>  	CTL_BUS=8,		/* Busses */
>  	CTL_ABI=9,		/* Binary emulation */
> -	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
> +	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
> +	CTL_SECURITY=11         /* Security modules */
> +};
> +
> +/* CTL_SECURITY names: */
> +enum
> +{
> +	SECURITY_REALTIME=1	/* Realtime LSM */
>  };

Without adding this extra bit.

> diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/security/Kconfig linux-2.6.8.1-rt02/security/Kconfig
> --- linux-2.6.8.1/security/Kconfig	Sat Aug 14 05:55:47 2004
> +++ linux-2.6.8.1-rt02/security/Kconfig	Sun Oct  3 10:56:17 2004
> @@ -84,6 +84,17 @@
>  	  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config SECURITY_REALTIME
> +	tristate "Realtime Capabilities"
> +	depends on SECURITY && SECURITY_CAPABILITIES!=y

Capabilities can be disabled on boot command line.

> --- linux-2.6.8.1/security/realtime.c	Wed Dec 31 18:00:00 1969
> +++ linux-2.6.8.1-rt02/security/realtime.c	Mon Oct  4 21:35:41 2004
> +static int any = 0;			/* if TRUE, any process is realtime */

unecessary init to 0

> +MODULE_PARM(any, "i");

please use module_param (bonus, you get free entry on command line when
non-modular, and entry in /sysfs if you want).

> +MODULE_PARM_DESC(any, " grant realtime privileges to any process.");
> +
> +static int gid = -1;			/* realtime group id, or NO_GROUP */
> +MODULE_PARM(gid, "i");

module_param.

> +MODULE_PARM_DESC(gid, " the group ID with access to realtime privileges.");
> +
> +static int mlock = 1;			/* enable mlock() privileges */
> +MODULE_PARM(mlock, "i");

module_param.

> +MODULE_PARM_DESC(mlock, " enable memory locking privileges.");
> +
> +/* helper function for testing group membership */
> +static inline int gid_ok(int gid, int e_gid) {
> +	int i;
> +	int rt_ok = 0;
> +
> +	if (gid == -1)
> +		return 0;
> +
> +	if ((gid == e_gid) || (gid == current->gid))
> +		return 1;
> +
> +	get_group_info(current->group_info);
> +	for (i = 0; i < current->group_info->ngroups; ++i) {
> +		if (gid == GROUP_AT(current->group_info, i)) {
> +			rt_ok = 1;
> +			break;
> +		}
> +	}

why not in_group_p?

> +	put_group_info(current->group_info);
> +
> +	return rt_ok;
> +}
> +
> +int realtime_bprm_set_security(struct linux_binprm *bprm)
> +{
> +	/* Copied from security/commoncap.c: cap_bprm_set_security()... */
> +	/* Copied from fs/exec.c:prepare_binprm. */
> +	/* We don't have VFS support for capabilities yet */
> +	cap_clear(bprm->cap_inheritable);
> +	cap_clear(bprm->cap_permitted);
> +	cap_clear(bprm->cap_effective);
> +
> +	/*  If a non-zero `any' parameter was specified, we grant
> +	 *  realtime privileges to every process.  If the `gid'
> +	 *  parameter was specified and it matches the group id of the
> +	 *  executable, of the current process or any supplementary
> +	 *  groups, we grant realtime capabilites.
> +	 */
> +
> +	if (any || gid_ok(gid, bprm->e_gid)) {
> +		cap_raise(bprm->cap_effective, CAP_SYS_NICE);
> +		cap_raise(bprm->cap_permitted, CAP_SYS_NICE);
> +		if (mlock) {
> +			cap_raise(bprm->cap_effective, CAP_IPC_LOCK);
> +			cap_raise(bprm->cap_permitted, CAP_IPC_LOCK);
> +			cap_raise(bprm->cap_effective,
> +				  CAP_SYS_RESOURCE);
> +			cap_raise(bprm->cap_permitted,
> +				  CAP_SYS_RESOURCE);
> +		}
> +	}

Maybe it would be better to call cap_bprm_set_security first, then or in
the bits you care about.  That way you don't have to worry about any changes
over there.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
