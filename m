Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVH3XGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVH3XGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVH3XGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:06:31 -0400
Received: from hera.kernel.org ([209.128.68.125]:51180 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932281AbVH3XGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:06:30 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC][PATCH 3 of 4] Configfs is really sysfs
Date: Tue, 30 Aug 2005 16:06:43 -0700
Organization: OSDL
Message-ID: <20050830160643.65111ad0@dxpl.pdx.osdl.net>
References: <200508310854.40482.phillips@istop.com>
	<200508310857.57617.phillips@istop.com>
	<200508310859.55746.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1125443184 31810 10.8.0.74 (30 Aug 2005 23:06:24 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 30 Aug 2005 23:06:24 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005 08:59:55 +1000
Daniel Phillips <phillips@istop.com> wrote:

> Configfs rewritten as a single file and updated to use kobjects instead of its
> own clone of kobjects (config_items).
> 

Some style issues:
	Mixed case in labels
	Bad identation

> +static int sysfs_create(struct dentry *dentry, int mode, int (*init) (struct inode *))
> +{
> +	int error = 0;
> +	struct inode *inode = NULL;
> +	if (dentry) {
> +		if (!dentry->d_inode) {
> +			if ((inode = sysfs_new_inode(mode))) {
> +				if (dentry->d_parent
> +				    && dentry->d_parent->d_inode) {
> +					struct inode *p_inode =
> +					    dentry->d_parent->d_inode;
> +					p_inode->i_mtime = p_inode->i_ctime =
> +					    CURRENT_TIME;
> +				}
> +				goto Proceed;
> +			} else
> +				error = -ENOMEM;
> +		} else
> +			error = -EEXIST;
> +	} else
> +		error = -ENOENT;
> +	goto Done;
> +
> +      Proceed:
> +	if (init)
> +		error = init(inode);
> +	if (!error) {
> +		d_instantiate(dentry, inode);
> +		if (S_ISDIR(mode) || S_ISLNK(mode)) /* pin link and directory dentries */
> +			dget(dentry);
> +	} else
> +		iput(inode);
> +      Done:

Why the mixed case label?

> +	return error;
> +}


> +/* 
> + * configfs client helpers
> + */
> +
> +void config_group_init_type_name(struct kset *group, const char *name, struct kobj_type *type)
> +{
> + kobject_set_name(&group->kobj, name);
> + group->kobj.ktype = type;
> + config_group_init(group);
> +}

Use tabs not one space for indent.

> +void config_group_init(struct kset *group)
> +{
> + kobject_init(&group->kobj);
> + INIT_LIST_HEAD(&group->cg_children);
> +}
> +
> +void kobject_init_type_name(struct kobject *kobj, const char *name, struct kobj_type *type)
> +{
> + kobject_set_name(kobj, name);
> + kobj->ktype = type;
> + kobject_init(kobj);
> +}
> +
> +EXPORT_SYMBOL(configfs_register_subsystem);
> +EXPORT_SYMBOL(configfs_unregister_subsystem);
> +EXPORT_SYMBOL(config_group_init_type_name);
> +EXPORT_SYMBOL(config_group_init);
> +EXPORT_SYMBOL(kobject_init_type_name);
>
