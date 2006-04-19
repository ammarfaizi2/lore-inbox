Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWDSSBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWDSSBe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWDSSBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:01:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42220 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751059AbWDSSBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:01:33 -0400
Subject: Re: [RFC][PATCH 2/11] security: AppArmor - Core headers
From: Arjan van de Ven <arjan@infradead.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060419174921.29149.80148.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419174921.29149.80148.sendpatchset@ermintrude.int.wirex.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 20:01:30 +0200
Message-Id: <1145469690.3085.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote:
> This patch provides the various common headerfiles used by the AppArmor module.
> 
> apparmor.h contains the core data structures.
> shared.h contains definitions that are common to the userspace policy loader.
> inline.h implements various inline utility functions
> 
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> 
> ---
>  security/apparmor/apparmor.h |  325 +++++++++++++++++++++++++++++++++++++++++
>  security/apparmor/inline.h   |  333 +++++++++++++++++++++++++++++++++++++++++++
>  security/apparmor/shared.h   |   41 +++++
>  3 files changed, 699 insertions(+)
> 
> --- /dev/null
> +++ linux-2.6.17-rc1/security/apparmor/apparmor.h
> @@ -0,0 +1,325 @@
> +/*
> + *	Copyright (C) 1998-2005 Novell/SUSE
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License as
> + *	published by the Free Software Foundation, version 2 of the
> + *	License.
> + *
> + *	AppArmor internal prototypes
> + */
> +
> +#ifndef __SUBDOMAIN_H
> +#define __SUBDOMAIN_H

this is an odd include guard for a file called apparmor.h

> +#include "shared.h"
> +
> +/* Control parameters (0 or 1), settable thru module/boot flags or
> + * via /sys/kernel/security/apparmor/control */
> +extern int apparmor_complain;
> +extern int apparmor_debug;
> +extern int apparmor_audit;
> +extern int apparmor_logsyscall;

looks like these should be in a header too

> +
> +/* PIPEFS_MAGIC */
> +#include <linux/pipe_fs_i.h>
> +/* from net/socket.c */
> +#define SOCKFS_MAGIC 0x534F434B
> +/* from inotify.c  */
> +#define INOTIFYFS_MAGIC 0xBAD1DEA

> +
> +#define VALID_FSTYPE(inode) ((inode)->i_sb->s_magic != PIPEFS_MAGIC && \
> +                             (inode)->i_sb->s_magic != SOCKFS_MAGIC && \
> +                             (inode)->i_sb->s_magic != INOTIFYFS_MAGIC)

ehhhh what is this about? Isn't this highly fragile???

> +
> +/*
> + * DEBUG remains global (no per profile flag) since it is mostly used in sysctl
> + * which is not related to profile accesses.
> + */
> +
> +#define AA_DEBUG(fmt, args...)						\
> +	do {								\
> +		if (apparmor_debug)					\
> +			printk(KERN_DEBUG "AppArmor: " fmt, ##args);	\
> +	} while (0)
> +#define AA_INFO(fmt, args...)	printk(KERN_INFO "AppArmor: " fmt, ##args)
> +#define AA_WARN(fmt, args...)	printk(KERN_WARNING "AppArmor: " fmt, ##args)
> +#define AA_ERROR(fmt, args...)	printk(KERN_ERR "AppArmor: " fmt, ##args)
> +

eh why? at least use prdebug and the like, but don't do your own

> +/* aa_audit - AppArmor auditing structure
> + * Structure is populated by access control code and passed to aa_audit which
> + * provides for a single point of logging.

why duplicate the audit infrastructure??

(and it's not possible to use LSM for auditing really; so it's not just
duplication, it's a bad idea)


> +/** aa_path_getname
> + * @data: data object previously initialized by aa_path_begin
> + *
> + * Return the next mountpoint which has the same root dentry as data->root.
> + * If no more mount points exist (or in case of error) NULL is returned
> + * (caller should call aa_path_end() and inspect return code to differentiate)
> + */
> +static inline char *aa_path_getname(struct aa_path_data *data)
> +{
> +	char *name = NULL;
> +	struct vfsmount *mnt;
> +
> +	while (data->pos != data->head) {
> +		mnt = list_entry(data->pos, struct vfsmount, mnt_list);
> +
> +		/* advance to next -- so that it is done before we break */
> +		data->pos = data->pos->next;
> +		prefetch(data->pos->next);
> +
> +		if (mnt->mnt_root == data->root) {
> +			name = aa_get_name(data->dentry, mnt);
> +			if (!name)
> +				data->errno = -ENOMEM;
> +			break;
> +		}
> +	}
> +
> +	return name;

what's the locking rules and refcounting rules for this stuff ??



