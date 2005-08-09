Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVHIOzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVHIOzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVHIOzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:55:43 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:1962 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964810AbVHIOzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:55:42 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080223445375c907@mail.gmail.com>
            <20050808095747.GD13951@redhat.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Tue, 09 Aug 2005 17:55:41 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F8C3ED.00001BC1@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, 

Here are some more comments. 

                     Pekka 

+/************************************************************************** 
****
> +*******************************************************************************
> +**
> +**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
> +**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
> +**
> +**  This copyrighted material is made available to anyone wishing to use,
> +**  modify, copy, or redistribute it subject to the terms and conditions
> +**  of the GNU General Public License v.2.
> +**
> +*******************************************************************************
> +******************************************************************************/

Do you really need this verbose banner? 

> +#define NO_CREATE 0
> +#define CREATE 1
> +
> +#define NO_WAIT 0
> +#define WAIT 1
> +
> +#define NO_FORCE 0
> +#define FORCE 1

The code seems to interchangeably use FORCE and NO_FORCE together
with TRUE and FALSE.  Perhaps they could be dropped? 

> +#define GLF_PLUG		0
> +#define GLF_LOCK		1
> +#define GLF_STICKY		2
> +#define GLF_PREFETCH		3
> +#define GLF_SYNC		4
> +#define GLF_DIRTY		5
> +#define GLF_SKIP_WAITERS2	6
> +#define GLF_GREEDY		7

Would be nice if these were either enums or had a comment linking
them to the struct member they are used for. 

> +#define GIF_MIN_INIT		0
> +#define GIF_QD_LOCKED		1
> +#define GIF_PAGED		2
> +#define GIF_SW_PAGED		3

Same here and in few other places too. 

> +#define LO_BEFORE_COMMIT(sdp) \
> +do { \
> +	int __lops_x; \
> +	for (__lops_x = 0; gfs2_log_ops[__lops_x]; __lops_x++) \
> +		if (gfs2_log_ops[__lops_x]->lo_before_commit) \
> +			gfs2_log_ops[__lops_x]->lo_before_commit((sdp)); \
> +} while (0)
> +
> +#define LO_AFTER_COMMIT(sdp, ai) \
> +do { \
> +	int __lops_x; \
> +	for (__lops_x = 0; gfs2_log_ops[__lops_x]; __lops_x++) \
> +		if (gfs2_log_ops[__lops_x]->lo_after_commit) \
> +			gfs2_log_ops[__lops_x]->lo_after_commit((sdp), (ai)); \
> +} while (0)
> +
> +#define LO_BEFORE_SCAN(jd, head, pass) \
> +do \
> +{ \
> +  int __lops_x; \
> +  for (__lops_x = 0; gfs2_log_ops[__lops_x]; __lops_x++) \
> +    if (gfs2_log_ops[__lops_x]->lo_before_scan) \
> +      gfs2_log_ops[__lops_x]->lo_before_scan((jd), (head), (pass)); \
> +} \
> +while (0)

static inline functions, please. 

> +static inline int LO_SCAN_ELEMENTS(struct gfs2_jdesc *jd, unsigned int start,
> +				   struct gfs2_log_descriptor *ld,
> +				   unsigned int pass)

Lower case name, please. 

> +{
> +	unsigned int x;
> +	int error;
> +
> +	for (x = 0; gfs2_log_ops[x]; x++)
> +		if (gfs2_log_ops[x]->lo_scan_elements) {
> +			error = gfs2_log_ops[x]->lo_scan_elements(jd, start,
> +								 ld, pass);
> +			if (error)
> +				return error;
> +		}
> +
> +	return 0;
> +}
> +
> +#define LO_AFTER_SCAN(jd, error, pass) \
> +do \
> +{ \
> +  int __lops_x; \
> +  for (__lops_x = 0; gfs2_log_ops[__lops_x]; __lops_x++) \
> +    if (gfs2_log_ops[__lops_x]->lo_before_scan) \
> +      gfs2_log_ops[__lops_x]->lo_after_scan((jd), (error), (pass)); \
> +} \
> +while (0)

static inline function, please. 

> +
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/smp_lock.h>
> +#include <linux/spinlock.h>
> +#include <asm/semaphore.h>
> +#include <linux/completion.h>
> +#include <linux/buffer_head.h>
> +#include <asm/uaccess.h>
> +#include <linux/pagemap.h>
> +#include <linux/uio.h>
> +#include <linux/blkdev.h>
> +#include <linux/mm.h>
> +#include <asm/uaccess.h>
> +#include <linux/gfs2_ioctl.h>

Preferred order is to include linux/ first and asm/ after that. 

> +#define vma2state(vma) \
> +((((vma)->vm_flags & (VM_MAYWRITE | VM_MAYSHARE)) == \
> + (VM_MAYWRITE | VM_MAYSHARE)) ? \
> + LM_ST_EXCLUSIVE : LM_ST_SHARED) \

static inline function, please. The above is completely unreadable. 

> +struct inode *gfs2_ip2v(struct gfs2_inode *ip, int create)
> +{
> +     struct inode *inode = NULL, *tmp;
> +
> +     gfs2_assert_warn(ip->i_sbd,
> +                      test_bit(GIF_MIN_INIT, &ip->i_flags));
> +
> +     spin_lock(&ip->i_spin);
> +     if (ip->i_vnode)
> +             inode = igrab(ip->i_vnode);
> +     spin_unlock(&ip->i_spin);

Suggestion: make the above a separate function __gfs2_lookup_inode(),
use it here and where you pass NO_CREATE to get rid of the create
parameter. 

> +
> +     if (inode || !create)
> +             return inode;
> +
> +     tmp = new_inode(ip->i_sbd->sd_vfs);
> +     if (!tmp)
> +             return NULL;

[snip] 

> +	entries = gfs2_tune_get(sdp, gt_entries_per_readdir);
> +	size = sizeof(struct filldir_bad) +
> +	    entries * (sizeof(struct filldir_bad_entry) + GFS2_FAST_NAME_SIZE);
> +
> +	fdb = kmalloc(size, GFP_KERNEL);
> +	if (!fdb)
> +		return -ENOMEM;
> +	memset(fdb, 0, size);

kzalloc(), which is in 2.6.13-rc6-mm5 please. Appears in other places as 
well. 

> +		if (error) {
> +			printk("GFS2: fsid=%s: can't make FS RW: %d\n",
> +			       sdp->sd_fsname, error);
> +			goto fail_proc;
> +		}
> +	}
> +
> +	gfs2_glock_dq_uninit(&mount_gh);
> +
> +	return 0;
> +
> + fail_proc:
> +	gfs2_proc_fs_del(sdp);
> +	init_threads(sdp, UNDO);

Please provide a release_threads instead and make it deal with partial
initialization. The above is very confusing. 

> +				     parent,
> +				     strlen(system_utsname.nodename));
> +	else if (gfs2_filecmp(&dentry->d_name, "@mach", 5))
> +		new = lookup_one_len(system_utsname.machine,
> +				     parent,
> +				     strlen(system_utsname.machine));
> +	else if (gfs2_filecmp(&dentry->d_name, "@os", 3))
> +		new = lookup_one_len(system_utsname.sysname,
> +				     parent,
> +				     strlen(system_utsname.sysname));
> +	else if (gfs2_filecmp(&dentry->d_name, "@uid", 4))
> +		new = lookup_one_len(buf,
> +				     parent,
> +				     sprintf(buf, "%u", current->fsuid));
> +	else if (gfs2_filecmp(&dentry->d_name, "@gid", 4))
> +		new = lookup_one_len(buf,
> +				     parent,
> +				     sprintf(buf, "%u", current->fsgid));
> +	else if (gfs2_filecmp(&dentry->d_name, "@sys", 4))
> +		new = lookup_one_len(buf,
> +				     parent,
> +				     sprintf(buf, "%s_%s",
> +					     system_utsname.machine,
> +					     system_utsname.sysname));
> +	else if (gfs2_filecmp(&dentry->d_name, "@jid", 4))
> +		new = lookup_one_len(buf,
> +				     parent,
> +				     sprintf(buf, "%u",
> +					     sdp->sd_jdesc->jd_jid));

Smells like policy in the kernel. Why can't this be done in the
userspace? 

> +				     parent,
> +				     strlen(system_utsname.nodename));
> +	else if (gfs2_filecmp(&dentry->d_name, "{mach}", 6))
> +		new = lookup_one_len(system_utsname.machine,
> +				     parent,
> +				     strlen(system_utsname.machine));
> +	else if (gfs2_filecmp(&dentry->d_name, "{os}", 4))
> +		new = lookup_one_len(system_utsname.sysname,
> +				     parent,
> +				     strlen(system_utsname.sysname));
> +	else if (gfs2_filecmp(&dentry->d_name, "{uid}", 5))
> +		new = lookup_one_len(buf,
> +				     parent,
> +				     sprintf(buf, "%u", current->fsuid));
> +	else if (gfs2_filecmp(&dentry->d_name, "{gid}", 5))
> +		new = lookup_one_len(buf,
> +				     parent,
> +				     sprintf(buf, "%u", current->fsgid));
> +	else if (gfs2_filecmp(&dentry->d_name, "{sys}", 5))
> +		new = lookup_one_len(buf,
> +				     parent,
> +				     sprintf(buf, "%s_%s",
> +					     system_utsname.machine,
> +					     system_utsname.sysname));
> +	else if (gfs2_filecmp(&dentry->d_name, "{jid}", 5))
> +		new = lookup_one_len(buf,
> +				     parent,
> +				     sprintf(buf, "%u",
> +					     sdp->sd_jdesc->jd_jid));

Ditto. 

> +int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc)
> +{
> +	struct gfs2_holder ri_gh;
> +	struct gfs2_rgrpd *rgd_next;
> +	struct gfs2_holder *gha, *gh;
> +	unsigned int slots = 64;
> +	unsigned int x;
> +	int done;
> +	int error = 0, err;
> +
> +	memset(sc, 0, sizeof(struct gfs2_statfs_change));
> +	gha = kmalloc(slots * sizeof(struct gfs2_holder), GFP_KERNEL);
> +	if (!gha)
> +		return -ENOMEM;
> +	memset(gha, 0, slots * sizeof(struct gfs2_holder));

kcalloc, please 

> +	line = kmalloc(256, GFP_KERNEL);
> +	if (!line)
> +		return -ENOMEM;
> +
> +	len = snprintf(line, 256, "GFS2: fsid=%s: quota %s for %s %u\r\n",
> +		       sdp->sd_fsname, type,
> +		       (test_bit(QDF_USER, &qd->qd_flags)) ? "user" : "group",
> +		       qd->qd_id);

Please use constant instead of magic number 256. 

> +struct lm_lockops gdlm_ops = {
> +	lm_proto_name:"lock_dlm",
> +	lm_mount:gdlm_mount,
> +	lm_others_may_mount:gdlm_others_may_mount,
> +	lm_unmount:gdlm_unmount,
> +	lm_withdraw:gdlm_withdraw,
> +	lm_get_lock:gdlm_get_lock,
> +	lm_put_lock:gdlm_put_lock,
> +	lm_lock:gdlm_lock,
> +	lm_unlock:gdlm_unlock,
> +	lm_plock:gdlm_plock,
> +	lm_punlock:gdlm_punlock,
> +	lm_plock_get:gdlm_plock_get,
> +	lm_cancel:gdlm_cancel,
> +	lm_hold_lvb:gdlm_hold_lvb,
> +	lm_unhold_lvb:gdlm_unhold_lvb,
> +	lm_sync_lvb:gdlm_sync_lvb,
> +	lm_recovery_done:gdlm_recovery_done,
> +	lm_owner:THIS_MODULE,
> +};

C99 initializers, please. 
