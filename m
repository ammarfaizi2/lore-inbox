Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWBYHGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWBYHGc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 02:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWBYHGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 02:06:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:8359 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932406AbWBYHGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 02:06:31 -0500
Date: Thu, 23 Feb 2006 19:40:07 -0800
From: Greg KH <gregkh@suse.de>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 1/3] sysfs representation of stacked devices (common) (rev.2)
Message-ID: <20060224034007.GA2769@suse.de>
References: <43FC8C00.5020600@ce.jp.nec.com> <43FC8D8C.1060904@ce.jp.nec.com> <20060222184853.GB13638@suse.de> <43FCE40A.1010206@ce.jp.nec.com> <20060222222846.GA14249@suse.de> <43FE09E1.4080907@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE09E1.4080907@ce.jp.nec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 02:15:45PM -0500, Jun'ichi Nomura wrote:
> Hello Greg,
> 
> >>>>+/* This is a mere directory in sysfs. No methods are needed. */
> >>>>+static struct kobj_type bd_holder_ktype = {
> >>>>+	.release	= NULL,
> >>>>+	.sysfs_ops	= NULL,
> >>>>+	.default_attrs	= NULL,
> >>>>+};
> >>>
> >>>That doesn't look right.  You always need a release function.
> 
> I updated the patch based your comments.
> Could you take a look at this version whether there's
> any problematic use of sysfs/kobjects?
> 
>   - I removed embedded child-kobjects from struct block_device
>     and struct gendisk which I added in my previous patch.
>     Kobject registration occurs when gendisk or hd_struct is
>     registered. Release function of the kobject type is added.
>   - Reference counting of kobjects is done in much symmetric
>     manner than before.
>   - Added bd_claim_by_disk/bd_release_from_disk inline functions
>     to help proper reference counting.

Looks great, only one comment:

> --- linux-2.6.16-rc4/fs/partitions/check.c	2006-02-17 17:23:45.000000000 -0500
> +++ linux-2.6.16-rc4/fs/partitions/check.c	2006-02-22 23:18:06.000000000 -0500
> @@ -297,6 +297,56 @@ struct kobj_type ktype_part = {
>  	.sysfs_ops	= &part_sysfs_ops,
>  };
>  
> +static void dir_release(struct kobject *kobj)
> +{
> +	kfree(kobj);
> +}
> +
> +static struct kobj_type dir_ktype = {
> +	.release	= dir_release,
> +	.sysfs_ops	= NULL,
> +	.default_attrs	= NULL,
> +};
> +
> +static inline struct kobject *add_dir(struct kobject *parent, const char *name)
> +{
> +	struct kobject *k;
> +
> +	if (!parent)
> +		return NULL;
> +
> +	k = kmalloc(sizeof(*k), GFP_KERNEL);
> +	if (!k)
> +		return NULL;
> +
> +	memset(k, 0, sizeof(*k));
> +	k->parent = parent;
> +	k->ktype = &dir_ktype;
> +	kobject_set_name(k, name);
> +	kobject_register(k);
> +
> +	return k;
> +}

This code looks good enough that we should add it to the core kobject
code, don't you think?  Also, you might use kzalloc instead of kmalloc
here.

thanks,

greg k-h
