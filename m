Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbUBBWQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 17:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265866AbUBBWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 17:16:43 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:16010 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265830AbUBBWQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 17:16:39 -0500
Date: Mon, 2 Feb 2004 23:15:42 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Max Asbock <masbock@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver for IBM RSA service processor (2/2)
Message-ID: <20040202231542.B18524@electric-eye.fr.zoreil.com>
References: <200402021129.56837.masbock@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200402021129.56837.masbock@us.ibm.com>; from masbock@us.ibm.com on Mon, Feb 02, 2004 at 11:29:56AM -0800
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Asbock <masbock@us.ibm.com> :
[...]
> diff -urN linux-2.6.1/drivers/misc/ibmasm/ibmasmfs.c linux-2.6.1-ibmasm/drivers/misc/ibmasm/ibmasmfs.c
> --- linux-2.6.1/drivers/misc/ibmasm/ibmasmfs.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.1-ibmasm/drivers/misc/ibmasm/ibmasmfs.c	2004-01-23 15:39:00.000000000 -0800
[...]
> +static int command_file_ioctl(struct inode *inode, struct file *file, unsigned int ioctl_cmd, unsigned long arg)
> +{
> +	struct ibmasmfs_command_data *command_data = file->private_data;
> +	struct command *cmd;
> +	unsigned long flags;
> +
> +	if (ioctl_cmd != IBMASM_IO_CANCEL)
> +		return -ENOTTY;
> +
> +	spin_lock_irqsave(&command_data->sp->lock, flags);
        ^^^^^^^^^^^^^^^^^
> +	cmd = command_data->command;
> +	if (cmd == NULL) {
> +		spin_unlock_irqrestore(&command_data->sp->lock, flags);
> +		return 0;
> +	}
> +	wake_up_interruptible(&cmd->wait);
> +	spin_lock_irqsave(&command_data->sp->lock, flags);
        ^^^^^^^^^^^^^^^^^
> +	return 0;

-> Typo ? What about:
   [...]
	spin_lock_irqsave(&command_data->sp->lock, flags);
	cmd = command_data->command;
	if (cmd == NULL)
		goto out_unlock;
	wake_up_interruptible(&cmd->wait);
out_unlock:
	spin_unlock_irqrestore(&command_data->sp->lock, flags);
	return 0;
}

--
Ueimor
