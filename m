Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVCGAxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVCGAxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVCGAxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:53:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:43994 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261204AbVCGAwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:52:39 -0500
Date: Sun, 6 Mar 2005 16:52:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, yrgrknmxpzlk@gawab.com
Subject: Re: [patch 11/12] sound/oss/emu10k1/* - compile warning cleanup
Message-Id: <20050306165233.511fcee3.akpm@osdl.org>
In-Reply-To: <20050305153542.7A66E1F208@trashy.coderock.org>
References: <20050305153542.7A66E1F208@trashy.coderock.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> 
> compile warning cleanup - handle copy_to/from_user error 
> returns

If a write() gets a fault it's supposed to return the number of bytes which
it actually wrote, which may be zero.

Still, returning -EFAULT is better than appearing to have succeeded.

> +			printk( KERN_ERR "emu10k1: %s: copy_to_user failed\n",__FUNCTION__);

Someone needs to read Documentation/CodingStyle.  I'll change these to

 printk(KERN_ERR "emu10k1: %s: copy_to_user failed\n", __FUNCTION__);

> +			return;
> +		}
> +	}
>  	else {
>  		u8 byte;
>  		u32 i;
> @@ -316,7 +320,10 @@ static void copy_block(u8 __user *dst, u
>  
>  		for (i = 0; i < len; i++) {
>  			byte = src[2 * i] ^ 0x80;
> -			__copy_to_user(dst + i, &byte, 1);
> +			if (__copy_to_user(dst + i, &byte, 1)) {
> +				printk( KERN_ERR "emu10k1: %s: copy_to_user failed\n",__FUNCTION__);
> +				return;
> +			}
>  		}
>  	}
>  }
> diff -puN sound/oss/emu10k1/passthrough.c~return_code-sound_oss_emu10k1 sound/oss/emu10k1/passthrough.c
> --- kj/sound/oss/emu10k1/passthrough.c~return_code-sound_oss_emu10k1	2005-03-05 16:13:11.000000000 +0100
> +++ kj-domen/sound/oss/emu10k1/passthrough.c	2005-03-05 16:13:11.000000000 +0100
> @@ -162,12 +162,14 @@ ssize_t emu10k1_pt_write(struct file *fi
>  
>  		DPD(3, "prepend size %d, prepending %d bytes\n", pt->prepend_size, needed);
>  		if (count < needed) {
> -			copy_from_user(pt->buf + pt->prepend_size, buffer, count);
> +			if (copy_from_user(pt->buf + pt->prepend_size, buffer, count))
> +				return -EFAULT;
>  			pt->prepend_size += count;
>  			DPD(3, "prepend size now %d\n", pt->prepend_size);
>  			return count;
>  		}
> -		copy_from_user(pt->buf + pt->prepend_size, buffer, needed);
> +		if (copy_from_user(pt->buf + pt->prepend_size, buffer, needed))
> +			return -EFAULT;
>  		r = pt_putblock(wave_dev, (u16 *) pt->buf, nonblock);
>  		if (r)
>  			return r;
> @@ -178,7 +180,8 @@ ssize_t emu10k1_pt_write(struct file *fi
>  	blocks_copied = 0;
>  	while (blocks > 0) {
>  		u16 __user *bufptr = (u16 __user *) buffer + (bytes_copied/2);
> -		copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE);
> +		if (copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE))
> +			return -EFAULT;
>  		r = pt_putblock(wave_dev, (u16 *)pt->buf, nonblock);
>  		if (r) {
>  			if (bytes_copied)
> @@ -193,7 +196,8 @@ ssize_t emu10k1_pt_write(struct file *fi
>  	i = count - bytes_copied;
>  	if (i) {
>  		pt->prepend_size = i;
> -		copy_from_user(pt->buf, buffer + bytes_copied, i);
> +		if (copy_from_user(pt->buf, buffer + bytes_copied, i))
> +			return -EFAULT;
>  		bytes_copied += i;
>  		DPD(3, "filling prepend buffer with %d bytes", i);
>  	}
> _
