Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWDTRr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWDTRr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWDTRr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:47:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:8935 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751173AbWDTRr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:47:56 -0400
Date: Thu, 20 Apr 2006 10:43:34 -0700
From: Tony Jones <tonyj@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 2/11] security: AppArmor - Core headers
Message-ID: <20060420174334.GB31281@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174921.29149.80148.sendpatchset@ermintrude.int.wirex.com> <1145469690.3085.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145469690.3085.74.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 08:01:30PM +0200, Arjan van de Ven wrote:
> > +#ifndef __SUBDOMAIN_H
> > +#define __SUBDOMAIN_H
> 
> this is an odd include guard for a file called apparmor.h

yes, noticed it 10 secs after I posted.   Fixed. 

> > +#include "shared.h"
> > +
> > +/* Control parameters (0 or 1), settable thru module/boot flags or
> > + * via /sys/kernel/security/apparmor/control */
> > +extern int apparmor_complain;
> > +extern int apparmor_debug;
> > +extern int apparmor_audit;
> > +extern int apparmor_logsyscall;
> 
> looks like these should be in a header too

Ok.

> > +
> > +/* PIPEFS_MAGIC */
> > +#include <linux/pipe_fs_i.h>
> > +/* from net/socket.c */
> > +#define SOCKFS_MAGIC 0x534F434B
> > +/* from inotify.c  */
> > +#define INOTIFYFS_MAGIC 0xBAD1DEA
> 
> > +
> > +#define VALID_FSTYPE(inode) ((inode)->i_sb->s_magic != PIPEFS_MAGIC && \
> > +                             (inode)->i_sb->s_magic != SOCKFS_MAGIC && \
> > +                             (inode)->i_sb->s_magic != INOTIFYFS_MAGIC)
> 
> ehhhh what is this about? Isn't this highly fragile???

Clearly a better comment is necessary.
There are a set of filesystem types for which we don't believe pathbased
mediation is relevant.   Obviously for a system which is inode based mediating
these filesystems makes more sense.  I'm unsure if it is fragile. Clearly
the set could grow, if this is what you mean, then yes, a less "fragile" way
of determining these would be useful.

> > +		if (apparmor_debug)					\
> > +			printk(KERN_DEBUG "AppArmor: " fmt, ##args);	\
> > +	} while (0)
> > +#define AA_INFO(fmt, args...)	printk(KERN_INFO "AppArmor: " fmt, ##args)
> > +#define AA_WARN(fmt, args...)	printk(KERN_WARNING "AppArmor: " fmt, ##args)
> > +#define AA_ERROR(fmt, args...)	printk(KERN_ERR "AppArmor: " fmt, ##args)
> > +
> 
> eh why? at least use prdebug and the like, but don't do your own

Ok. Thanks. I'll look at it.

> > +/* aa_audit - AppArmor auditing structure
> > + * Structure is populated by access control code and passed to aa_audit which
> > + * provides for a single point of logging.
> 
> why duplicate the audit infrastructure??
> 
> (and it's not possible to use LSM for auditing really; so it's not just
> duplication, it's a bad idea)

We're not duplicating.  aa_audit is just a common datastructure where AA
event information is stored.  It is passed to aa_audit which logs it to
the kernel audit subsystem.  It facilitates a single point of logging.

If you think this can be improved (clearly another case for better commenting)
I'd be curious to hear your views.

> > +/** aa_path_getname
> > + * @data: data object previously initialized by aa_path_begin
> > + *
> > + * Return the next mountpoint which has the same root dentry as data->root.
> > + * If no more mount points exist (or in case of error) NULL is returned
> > + * (caller should call aa_path_end() and inspect return code to differentiate)
> > + */
> > +static inline char *aa_path_getname(struct aa_path_data *data)
> > +{
> > +	char *name = NULL;
> > +	struct vfsmount *mnt;
> > +
> > +	while (data->pos != data->head) {
> > +		mnt = list_entry(data->pos, struct vfsmount, mnt_list);
> > +
> > +		/* advance to next -- so that it is done before we break */
> > +		data->pos = data->pos->next;
> > +		prefetch(data->pos->next);
> > +
> > +		if (mnt->mnt_root == data->root) {
> > +			name = aa_get_name(data->dentry, mnt);
> > +			if (!name)
> > +				data->errno = -ENOMEM;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return name;
> 
> what's the locking rules and refcounting rules for this stuff ??

This is where the issue of the namespace_sem rears it's ugly head.
The issue isn't the namespace sem, it's the lack of vfsmount information 
passed to LSM from the VFS,  It facilitates the need for this function.  
The change in visibility of the per namespace semaphore in the shared 
subtree changes just makes it a little bit worse.

Tony
