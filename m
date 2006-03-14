Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752100AbWCNCaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbWCNCaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbWCNCaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:30:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752100AbWCNCaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:30:08 -0500
Date: Mon, 13 Mar 2006 18:27:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: agk@redhat.com, gregkh@suse.de, neilb@suse.de, lmb@suse.de,
       dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dm/md dependency tree in sysfs: bd_claim_by_kobject
Message-Id: <20060313182730.335bc6c8.akpm@osdl.org>
In-Reply-To: <4415EEFD.6010002@ce.jp.nec.com>
References: <4415EC4B.4010003@ce.jp.nec.com>
	<4415EEFD.6010002@ce.jp.nec.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jun'ichi Nomura" <j-nomura@ce.jp.nec.com> wrote:
>
> This patch is part of dm/md dependency tree in sysfs.
> 
> This adds bd_claim_by_kobject() function which takes kobject as
> additional signature of holder device and creates sysfs symlinks
> between holder device and claimed device.
> bd_release_from_kobject() is a counter part of bd_claim_by_kobject.
> 
> ...
>
> @@ -402,6 +402,7 @@ struct block_device {
>  	struct list_head	bd_inodes;
>  	void *			bd_holder;
>  	int			bd_holders;
> +	struct list_head	bd_holder_list;
>  	struct block_device *	bd_contains;
>  	unsigned		bd_block_size;
>  	struct hd_struct *	bd_part;

Bear in mind that sysfs is Kconfigurable (CONFIG_SYSFS).  If possible,
newly-added code which doesn't make sense without sysfs should not appear
in a CONFIG_SYSFS=n vmlinux.

> +
> +static inline struct kobject * bdev_get_kobj(struct block_device *bdev)

pet-peeve: The space after asterisk has no use.

> +{
> +	if (bdev->bd_contains != bdev)
> +		return kobject_get(&bdev->bd_part->kobj);
> +	else
> +		return kobject_get(&bdev->bd_disk->kobj);
> +}
> +
> +static inline struct kobject * bdev_get_holder(struct block_device *bdev)
> +static inline void add_symlink(struct kobject *from, struct kobject *to)
> +static inline void del_symlink(struct kobject *from, struct kobject *to)
> +static inline int bd_holder_grab_dirs(struct block_device *bdev,
> +static inline void bd_holder_release_dirs(struct bd_holder *bo)

I suposse the inlines are OK, given that we "know" that there's only a
single callsite.  But recent gcc's take care of that automatically.

> +static int add_bd_holder(struct block_device *bdev, struct bd_holder *bo)
> +{
> +        struct bd_holder *tmp;
> +
> +	if (!bo)
> +		return 0;

whitespace went wild there.

> +static void free_bd_holder(struct bd_holder *bo)
> ...
> +
> +	bo->sdir = kobj;
> +	list_for_each_entry(tmp, &bdev->bd_holder_list, list) {
> +		if (tmp->sdir == bo->sdir) {
> +			tmp->count++;
> +			return 0;
> +		}
> +	}
> +
> +	if (!bd_holder_grab_dirs(bdev, bo))
> +		return 0;
> +
> +	add_symlink(bo->sdir, bo->sdev);
> +	add_symlink(bo->hdir, bo->hdev);
> +	list_add_tail(&bo->list, &bdev->bd_holder_list);
> +	return 1;
> +}
> 
> +static struct bd_holder *del_bd_holder(struct block_device *bdev,
> +					struct kobject *kobj)
> +{
> +	struct bd_holder *bo;
> +
> +	list_for_each_entry(bo, &bdev->bd_holder_list, list) {
> +		if (bo->sdir == kobj) {
> +			bo->count--;
> +			BUG_ON(bo->count < 0);
> +			if (!bo->count) {
> +				list_del(&bo->list);
> +				del_symlink(bo->sdir, bo->sdev);
> +				del_symlink(bo->hdir, bo->hdev);
> +				bd_holder_release_dirs(bo);
> +				return bo;
> +			}
> +			break;
> +		}
> +	}
> +
> +	return NULL;
> +}

Some comments which describe what these do, what they return and why they
return it would be nice.

> +
> +int bd_claim_by_kobject(struct block_device *bdev, void *holder,
> +			struct kobject *kobj)
> +{

Ditto.

> +	int res = -EBUSY;
> +	struct bd_holder *bo;
> +
> +	if (!kobj)
> +		return -EINVAL;
> +
> +	bo = alloc_bd_holder(kobj);
> +	if (!bo)
> +		return -ENOMEM;
> +
> +	down(&bdev->bd_sem);
> +	res = bd_claim(bdev, holder);
> +	if (res || !add_bd_holder(bdev, bo))
> +		free_bd_holder(bo);
> +	up(&bdev->bd_sem);
> +
> +	return res;
> +}
> +
> +EXPORT_SYMBOL(bd_claim_by_kobject);

I don't think the blank line before the EXPORT_SYMBOL() does anything useful.

EXPORT_SYMBOL_GPL() might be preferred.

> +void bd_release_from_kobject(struct block_device *bdev, struct kobject *kobj)
> +{
> +	struct bd_holder *bo;
> +
> +	if (!kobj)
> +		return;
> +
> +	down(&bdev->bd_sem);
> +	bd_release(bdev);
> +	if ((bo = del_bd_holder(bdev, kobj)))
> +		free_bd_holder(bo);
> +	up(&bdev->bd_sem);
> +}
> +
> +EXPORT_SYMBOL(bd_release_from_kobject);

Ditto.
