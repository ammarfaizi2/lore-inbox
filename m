Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbUKVW6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUKVW6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUKVW5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:57:06 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18331 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261194AbUKVWxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:53:52 -0500
Date: Mon, 22 Nov 2004 14:50:33 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][9/12] Add InfiniBand userspace MAD support
Message-ID: <20041122225033.GD15634@kroah.com>
References: <20041122714.nKCPmH9LMhT0X7WE@topspin.com> <20041122714.9zlcKGKvXlpga8EP@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122714.9zlcKGKvXlpga8EP@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 07:14:11AM -0800, Roland Dreier wrote:
> Add a driver that provides a character special device for each
> InfiniBand port.  This device allows userspace to send and receive
> MADs via write() and read() (with some control operations implemented
> as ioctls).

Do you really need these ioctls?

For example:

> +static int ib_umad_ioctl(struct inode *inode, struct file *filp,
> +			 unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case IB_USER_MAD_GET_ABI_VERSION:
> +		return put_user(IB_USER_MAD_ABI_VERSION,
> +				(u32 __user *) arg) ? -EFAULT : 0;

This could be in a sysfs file, right?

> +	case IB_USER_MAD_REGISTER_AGENT:
> +		return ib_umad_reg_agent(filp->private_data, arg);
> +	case IB_USER_MAD_UNREGISTER_AGENT:
> +		return ib_umad_unreg_agent(filp->private_data, arg);

You are letting any user, with any privilege register or unregister an
"agent"?

And shouldn't you lock your list of agent ids when adding or removing
one, or are you relying on the BKL of the ioctl call?  If so, please
document this.

Also, these "agents" seem to be a type of filter, right?  Is there no
other way to implement this than an ioctl?

thanks,

greg k-h
