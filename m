Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWCVTX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWCVTX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWCVTX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:23:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49933 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932396AbWCVTX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:23:56 -0500
Date: Wed, 22 Mar 2006 19:23:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Corey Minyard <minyard@acm.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: [PATCH] Fix release function in IPMI device model
Message-ID: <20060322192345.GB26357@flint.arm.linux.org.uk>
Mail-Followup-To: Corey Minyard <minyard@acm.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Yani Ioannou <yani.ioannou@gmail.com>
References: <20060322155742.GA28674@i2.minyard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322155742.GA28674@i2.minyard.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 09:57:42AM -0600, Corey Minyard wrote:
> @@ -1800,7 +1802,7 @@ static struct bmc_device *ipmi_find_bmc_
>  
>  static void ipmi_bmc_release(struct device *dev)
>  {
> -	printk(KERN_DEBUG "ipmi_bmc release\n");
> +	kfree(to_bmc_device(to_platform_device(dev)));
>  }
>  
>  static ssize_t device_id_show(struct device *dev,

Okay, so the release function is in the same module as the code which
is unregistering it.  No, wrong.

What this means is that if you rmmod this module, but userspace has
some file associated with the platform device still open, and then it
drops that refcount, your release function will be called.

But wait, the module code has been unmapped.  Instant oops.

Use the additions to the platform device API to sanely handle platform
devices, and don't try to wrap a platform device up into some other
data structure.

There's comments on lkml about this additional platform device API
(search for platform_device_alloc) or in the git commit comments.
I don't have any references to either to hand, sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
