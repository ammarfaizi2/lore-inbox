Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbULUMFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbULUMFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbULUMFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:05:55 -0500
Received: from coderock.org ([193.77.147.115]:4806 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261743AbULUMFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 07:05:44 -0500
Date: Tue, 21 Dec 2004 13:06:07 +0100
From: Domen Puncer <domen@coderock.org>
To: James Nelson <james4765@verizon.net>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: lcd: fix memory leak, code cleanup
Message-ID: <20041221120607.GA30293@nd47.coderock.org>
Mail-Followup-To: James Nelson <james4765@verizon.net>,
	kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20041221015120.29110.98832.48706@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221015120.29110.98832.48706@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/04 19:50 -0600, James Nelson wrote:
> This patch addresses the following issues:
> 
> Fix log-spamming and cryptic error messages, and add KERN_ constants.
> Convert some ints to unsigned ints.
> Add checks for CAP_SYS_ADMIN for FLASH_Burn and FLASH_Erase ioctls.
> Identify use of global variable.
> Fix memory leak in FLASH_Burn ioctl.
> Fix error return codes in lcd_ioctl().
> Move variable "index" in lcd_ioctl() to smaller scope to reduce memory usage.
> Convert cli()/sti() to spin_lock_irqsave()/spin_unlock_irqrestore().
> Fix legibility issues in FLASH_Burn ioctl.
>


> -				cli();
> +				spin_lock_irqsave(&lcd_lock, flags);
>  				for (index = 0; index < (128); index++) {
>  
>  					WRITE_FLASH(kFlash_Addr1,
> @@ -480,32 +485,30 @@
>  						    kFlash_Data2);
>  					WRITE_FLASH(kFlash_Addr1,
>  						    kFlash_Prog);
> -					*((volatile unsigned char *)
> -					  burn_addr) =
> -		 (volatile unsigned char) rom[index];
> -
> -					while ((!dqpoll
> -						(burn_addr,
> -						 (volatile unsigned char)
> -						 rom[index]))
> -					       && (!timeout(burn_addr))) {
> -					}
> +					*((volatile unsigned char *)burn_addr) =
> +					  (volatile unsigned char) rom[index];
> +
> +					while ((!dqpoll (burn_addr,
> +						(volatile unsigned char)
> +						rom[index])) &&
> +						(!timeout(burn_addr))) { }
>  					burn_addr++;
>  				}
> -				restore_flags(flags);
> -				if (*
> -				    ((volatile unsigned char *) (burn_addr
> -								 - 1)) ==
> -				    (volatile unsigned char) rom[index -
> -								 1]) {
> +				spin_unlock_irqrestore(&lcd_lock, flags);


Although this will work, i think local_irq_{disable,enable} is the right
solution (we don't protect any data, just make sure timings are right).

For making it SMP safe, easiest/sane solution seems semaphore in
lcd_dev, which is down_interruptible(), at beginning of read, write
and ioctl.

Comments?


	Domen
