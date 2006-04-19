Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWDSTSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWDSTSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWDSTSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:18:14 -0400
Received: from hera.kernel.org ([140.211.167.34]:19139 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751190AbWDSTSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:18:08 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC][PATCH 7/11] security: AppArmor - Misc (capabilities, data
 structures)
Date: Wed, 19 Apr 2006 11:16:30 -0700
Organization: OSDL
Message-ID: <20060419111630.5643b398@localhost.localdomain>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	<20060419175002.29149.86725.sendpatchset@ermintrude.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1145470588 19858 10.8.0.54 (19 Apr 2006 18:16:28 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 19 Apr 2006 18:16:28 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006 10:50:02 -0700
Tony Jones <tonyj@suse.de> wrote:

> This patch implements three distinct chunks.
> - list management, for profiles loaded into the system (profile_list) and for 
>   the set of confined tasks (subdomain_list)
> - the proc/pid/attr interface used by userspace for setprofile (forcing
>   a task into a new profile) and changehat (switching a task into one of it's
>   defined sub profiles).  Access to change_hat is normally via code provided
>   in libapparmor. See the overview posting for more information in change hat.
> - capability utility functions (for displaying capability names)
> 
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> 
> ---
>  security/apparmor/capabilities.c |   54 ++++++
>  security/apparmor/list.c         |  268 +++++++++++++++++++++++++++++++
>  security/apparmor/procattr.c     |  327 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 649 insertions(+)
> 
> --- /dev/null
> +++ linux-2.6.17-rc1/security/apparmor/capabilities.c
> @@ -0,0 +1,54 @@
> +/*
> + *	Copyright (C) 2005 Novell/SUSE
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License as
> + *	published by the Free Software Foundation, version 2 of the
> + *	License.
> + *
> + *	AppArmor capability definitions
> + */
> +
> +#include "apparmor.h"
> +
> +static const char *cap_names[] = {
> +	"chown",
> +	"dac_override",
> +	"dac_read_search",
> +	"fowner",
> +	"fsetid",
> +	"kill",
> +	"setgid",
> +	"setuid",
> +	"setpcap",
> +	"linux_immutable",
> +	"net_bind_service",
> +	"net_broadcast",
> +	"net_admin",
> +	"net_raw",
> +	"ipc_lock",
> +	"ipc_owner",
> +	"sys_module",
> +	"sys_rawio",
> +	"sys_chroot",
> +	"sys_ptrace",
> +	"sys_pacct",
> +	"sys_admin",
> +	"sys_boot",
> +	"sys_nice",
> +	"sys_resource",
> +	"sys_time",
> +	"sys_tty_config",
> +	"mknod",
> +	"lease"
> +};
> +
> +const char *capability_to_name(unsigned int cap)
> +{
> +	const char *name;
> +
> +	name = (cap < (sizeof(cap_names) / sizeof(char *))
> +		   ? cap_names[cap] : "invalid-capability");
> +
> +	return name;
> +}
> --- /dev/null
> +++ linux-2.6.17-rc1/security/apparmor/list.c
> @@ -0,0 +1,268 @@
> +/*
> + *	Copyright (C) 1998-2005 Novell/SUSE
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License as
> + *	published by the Free Software Foundation, version 2 of the
> + *	License.
> + *
> + *	AppArmor Profile List Management
> + */
> +
> +#include <linux/seq_file.h>
> +#include "apparmor.h"
> +#include "inline.h"
> +
> +/* list of all profiles and lock */
> +static LIST_HEAD(profile_list);
> +static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
> +
> +/* list of all subdomains and lock */
> +static LIST_HEAD(subdomain_list);
> +static rwlock_t subdomain_lock = RW_LOCK_UNLOCKED;

This would be a good candidate for RCU.
