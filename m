Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUCKVBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUCKVBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:01:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:29379 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261739AbUCKVA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:00:58 -0500
Date: Thu, 11 Mar 2004 10:52:21 -0800
From: Greg KH <greg@kroah.com>
To: Leann Ogasawara <ogasawara@osdl.org>
Cc: linux-kernel@vger.kernel.org, Hanna Linder <hannal@us.ibm.com>,
       faith@valinux.com
Subject: Re: [Dri-devel][PATCH] sysfs simple class support for DRI char device
Message-ID: <20040311185221.GA20223@kroah.com>
References: <1078517655.29095.32.camel@ibm-d.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078517655.29095.32.camel@ibm-d.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 12:14:15PM -0800, Leann Ogasawara wrote:
> Hi All,
> 
> Patch adds sysfs simple class support for DRI character device (Major
> 226).  Also, adds some error checking.  Feedback appreciated.  Thanks,

Looks good, but...

>  
>  	DRM_DEBUG("\n");
> -	if (register_chrdev(DRM_MAJOR, "drm", &DRM(stub_fops)))
> +	ret1 = register_chrdev(DRM_MAJOR, "drm", &DRM(stub_fops));
> +	if (!ret1) {
> +		drm_class = class_simple_create(THIS_MODULE, "drm");
> +		if (IS_ERR(drm_class)) {
> +			printk (KERN_ERR "Error creating drm class.\n");
> +			unregister_chrdev(DRM_MAJOR, "drm");
> +			return PTR_ERR(drm_class);
> +		}
> +	}
> +	else if (ret1 == -EBUSY)
>  		i = (struct drm_stub_info *)inter_module_get("drm");
> +	else
> +		return -1;

If ret1 == -EBUSY then we never create the "drm" class_simple structure,
right?  That's not good.

Care to fix this up and send a new patch?

thanks,

greg k-h
