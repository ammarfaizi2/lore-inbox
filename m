Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbVLOJ6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbVLOJ6B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422677AbVLOJ6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:58:01 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64264 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422675AbVLOJ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:58:00 -0500
Date: Thu, 15 Dec 2005 09:57:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tlclk.c: pointers are handled by %p
Message-ID: <20051215095754.GA32490@flint.arm.linux.org.uk>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1EmpFz-00080I-2r@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EmpFz-00080I-2r@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 09:18:35AM +0000, Al Viro wrote:
> diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
> index 12167c0..e8467dc 100644
> --- a/drivers/char/tlclk.c
> +++ b/drivers/char/tlclk.c
> @@ -776,8 +776,8 @@ static int __init tlclk_init(void)
>  	tlclk_device = platform_device_register_simple("telco_clock",
>  				-1, NULL, 0);
>  	if (!tlclk_device) {
> -		printk(KERN_ERR " platform_device_register retruns 0x%X\n",
> -			(unsigned int) tlclk_device);
> +		printk(KERN_ERR " platform_device_register retruns 0x%p\n",
> +			tlclk_device);

This looks really strange - we know what tlclk_device will be at that
printk - it'll be NULL because if it's anything different we wouldn't
be inside this if(){ }.

Moreover, this code is obviously bogus.  platform_device_register_simple
does not return NULL for the error case.  It should be something like:

	if (IS_ERR(tlclk_device)) {
		ret = PTR_ERR(tlclk_device);
		printk(KERN_ERR "platform_device_register returns %d\n",
		        ret);
		goto out4;
	}

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
