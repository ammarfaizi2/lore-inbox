Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWHER5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWHER5f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 13:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWHER5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 13:57:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:47827 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030258AbWHER5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 13:57:34 -0400
Date: Sat, 5 Aug 2006 10:57:02 -0700
From: Greg KH <greg@kroah.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take4 1/4] kevent: Core files.
Message-ID: <20060805175702.GA27992@kroah.com>
References: <11547829553148@2ka.mipt.ru> <11547829581556@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11547829581556@2ka.mipt.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 05:02:38PM +0400, Evgeniy Polyakov wrote:
> +static int __devinit kevent_user_init(void)
> +{
> +	struct class_device *dev;
> +	int err = 0;
> +	
> +	err = register_filesystem(&kevent_fs_type);
> +	if (err)
> +		panic("%s: failed to register filesystem: err=%d.\n",
> +			       kevent_name, err);
> +
> +	kevent_mnt = kern_mount(&kevent_fs_type);
> +	if (IS_ERR(kevent_mnt))
> +		panic("%s: failed to mount silesystem: err=%ld.\n", 
> +				kevent_name, PTR_ERR(kevent_mnt));
> +	
> +	kevent_user_major = register_chrdev(0, kevent_name, &kevent_user_fops);
> +	if (kevent_user_major < 0) {
> +		printk(KERN_ERR "Failed to register \"%s\" char device: err=%d.\n", 
> +				kevent_name, kevent_user_major);
> +		return -ENODEV;
> +	}
> +
> +	kevent_user_class = class_create(THIS_MODULE, "kevent");
> +	if (IS_ERR(kevent_user_class)) {
> +		printk(KERN_ERR "Failed to register \"%s\" class: err=%ld.\n", 
> +				kevent_name, PTR_ERR(kevent_user_class));
> +		err = PTR_ERR(kevent_user_class);
> +		goto err_out_unregister;
> +	}
> +
> +	dev = class_device_create(kevent_user_class, NULL, 
> +			MKDEV(kevent_user_major, 0), NULL, kevent_name);
> +	if (IS_ERR(dev)) {
> +		printk(KERN_ERR "Failed to create %d.%d class device in \"%s\" class: err=%ld.\n", 
> +				kevent_user_major, 0, kevent_name, PTR_ERR(dev));
> +		err = PTR_ERR(dev);
> +		goto err_out_class_destroy;
> +	}

As you are only using 1 minor number in this code, why not just use a
miscdevice instead?  It saves a bit of overhead and makes the code a
tiny bit smaller :)

thanks,

greg k-h
