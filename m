Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVDYV0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVDYV0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVDYV0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:26:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:37601 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261223AbVDYVYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:24:10 -0400
Date: Mon, 25 Apr 2005 14:23:51 -0700
From: Greg KH <greg@kroah.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/7] dlm: device interface
Message-ID: <20050425212350.GB25247@kroah.com>
References: <20050425151303.GF6826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425151303.GF6826@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:13:03PM +0800, David Teigland wrote:
> +#ifndef __KERNEL
> +#define __user
> +#endif

What is this for?

> +/* struct passed to the lock write */
> +struct dlm_lock_params {
> +	uint8_t mode;
> +	uint16_t flags;
> +	uint32_t lkid;
> +	uint32_t parent;

These are crossing the userspace/kernelspace boundry, please mark them
__u8, __u16, and __u32.

> +	struct dlm_range range;
> +	uint8_t namelen;
> +        void __user *castparam;
> +	void __user *castaddr;
> +	void __user *bastparam;
> +        void __user *bastaddr;
> +	struct dlm_lksb __user *lksb;
> +	char lvb[DLM_LVB_LEN];
> +	char name[1];

Mix of tabs and spaces.

> +/*
> + * ioctls to create/remove lockspaces, and check how many
> + * outstanding ASTs there are against a particular LS.
> + */

Your comment is wrong, based on the code.

> +static int dlm_ioctl(struct inode *inode, struct file *file,
> +		     uint command, ulong u)
> +{
> +	struct file_info *fi = file->private_data;
> +	int status = -EINVAL;
> +	int count;
> +	struct list_head *tmp_list;
> +
> +	switch (command) {
> +
> +		/* Are there any ASTs for us to read?
> +		 * Warning, this returns the number of messages (ASTs)
> +		 * in the queue, NOT the number of bytes to read
> +		 */
> +	case FIONREAD:
> +		count = 0;
> +		spin_lock(&fi->fi_ast_lock);
> +		list_for_each(tmp_list, &fi->fi_ast_list)
> +			count++;
> +		spin_unlock(&fi->fi_ast_lock);
> +		status = put_user(count, (int *)u);
> +		break;

Is this really needed?

thanks,

greg k-h
