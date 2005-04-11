Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVDKVAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVDKVAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVDKVAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:00:36 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:58802 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261932AbVDKU5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:57:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Date: Mon, 11 Apr 2005 22:57:39 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <4259B474.4040407@domdv.de> <20050411110822.GA10401@elf.ucw.cz> <425AA19F.6040802@domdv.de>
In-Reply-To: <425AA19F.6040802@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504112257.39708.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 11 of April 2005 18:11, Andreas Steinmetz wrote:
> Pavel Machek wrote:
> > Was it really neccessary to include "union u"? I don't like its name,
> 
> Here comes the patch with this reverted. I'm now using casts when
> 'abusing' the space for encryption. Furthermore the iv set up in the tfm
> is used instead of the local copy.

I had no time to review your patch earlier, sorry.  I'm inlining it so that I can
comment it:

> --- linux-2.6.11.2/kernel/power/swsusp.c.ast	2005-04-10 14:08:55.000000000 +0200
> +++ linux-2.6.11.2/kernel/power/swsusp.c	2005-04-11 18:05:58.000000000 +0200
> @@ -31,6 +31,9 @@
>   * Alex Badea <vampire@go.ro>:
>   * Fixed runaway init
>   *
> + * Andreas Steinmetz <ast@domdv.de>:
> + * Added encrypted suspend option
> + *
>   * More state savers are welcome. Especially for the scsi layer...
>   *
>   * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
> @@ -72,6 +75,16 @@
>  
>  #include "power.h"
>  
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +#include <linux/random.h>
> +#include <linux/crypto.h>
> +#include <asm/scatterlist.h>
> +#endif
> +
> +#define CIPHER "aes"
> +#define MAXKEY 32
> +#define MAXIV  32

Why not to put these definitions under #ifdef?

> +
>  /* References to section boundaries */
>  extern const void __nosave_begin, __nosave_end;
>  
> @@ -104,7 +117,9 @@
>  #define SWSUSP_SIG	"S1SUSPEND"
>  
>  static struct swsusp_header {
> -	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];

I would add #ifdef here as well.

> +	char reserved[PAGE_SIZE - 20 - MAXKEY - MAXIV - sizeof(swp_entry_t)];
> +	u8 key[MAXKEY];
> +	u8 iv[MAXIV];
>  	swp_entry_t swsusp_info;
>  	char	orig_sig[10];
>  	char	sig[10];
> @@ -112,6 +127,11 @@
>  
>  static struct swsusp_info swsusp_info;
>  
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +static u8 key[MAXKEY];
> +static u8 iv[MAXIV];
> +#endif
> +
>  /*
>   * XXX: We try to keep some more pages free so that I/O operations succeed
>   * without paging. Might this be more?
> @@ -130,6 +150,52 @@
>  static unsigned short swapfile_used[MAX_SWAPFILES];
>  static unsigned short root_swap;
>  
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +static struct crypto_tfm *crypto_init(int mode)

I think it's better if this function returns an int error code and the
messages are printed where it's called from.  This way, the essential
part of the code would be easier to grasp (Pavel?).

> +{
> +	struct crypto_tfm *tfm;
> +	int len;
> +
> +	tfm = crypto_alloc_tfm(CIPHER, CRYPTO_TFM_MODE_CBC);
> +	if(!tfm) {
> +		printk(KERN_ERR "swsusp: no tfm, suspend not possible\n");
> +		return NULL;
> +	}
> +
> +	if(sizeof(key) < crypto_tfm_alg_min_keysize(tfm)) {
> +		printk("swsusp: key buffer too small, suspend not possible\n");
> +		crypto_free_tfm(tfm);
> +		return NULL;
> +	}
> +
> +	if (sizeof(iv) < crypto_tfm_alg_ivsize(tfm)) {
> +		printk("swsusp: iv buffer too small, suspend not possible\n");
> +		crypto_free_tfm(tfm);
> +		return NULL;
> +	}
> +
> +	if (mode) {
> +		get_random_bytes(key, MAXKEY);

I hope you realize that this may give you a sequence of bits that you should
not use as a key ...

> +		get_random_bytes(iv, MAXIV);
> +	}
> +
> +	len = crypto_tfm_alg_max_keysize(tfm);

You have used this value earlier.  Why don't you initialize len at that time?

> +	if (len > sizeof(key))
> +		len = sizeof(key);
> +
> +	if (crypto_cipher_setkey(tfm, key, len)) {
> +		printk(KERN_ERR "swsusp: key setup failure, suspend not possible\n");
> +		crypto_free_tfm(tfm);

On any error, you call crypto_free_tfm(tfm) and return.  I would use a common
error handling code, like that:

	if (error)
		goto Error;
	/* some code */
Error:
	crypto_free_tfm(tfm);
	return error;

> +		return NULL;
> +	}
> +
> +	len = crypto_tfm_alg_blocksize(tfm);
> +	crypto_cipher_set_iv(tfm, iv, len);

I would use crypto_tfm_alg_blocksize(tfm) here directly (shorter code).

> +
> +	return tfm;
> +}
> +#endif
> +
>  static int mark_swapfiles(swp_entry_t prev)
>  {
>  	int error;
> @@ -141,6 +207,10 @@

If you used -p while making diffs, it would be easier to find out where the
changes actually started.

>  	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
>  		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
>  		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +		memcpy(swsusp_header.key, key, MAXKEY);
> +		memcpy(swsusp_header.iv, iv, MAXIV);
> +#endif
>  		swsusp_header.swsusp_info = prev;
>  		error = rw_swap_page_sync(WRITE, 
>  					  swp_entry(root_swap, 0),
> @@ -294,6 +364,19 @@

This change will not apply to the current swsusp.c (eg as in 2.6.12-rc2).

>  	int error = 0;
>  	int i;
>  	unsigned int mod = nr_copy_pages / 100;
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +	struct crypto_tfm *tfm;
> +	struct scatterlist src, dst;
> +
> +	if (!(tfm = crypto_init(1)))
> +		return -EINVAL;

It's not necessarily -EINVAL, I think.  It's better to return different
error codes on different error conditions.

> +
> +	src.offset = 0;
> +	src.length = PAGE_SIZE;
> +	dst.page   = virt_to_page((void *)&swsusp_header);
> +	dst.offset = 0;
> +	dst.length = PAGE_SIZE;
> +#endif
>  
>  	if (!mod)
>  		mod = 1;
> @@ -302,10 +385,21 @@

This change will not apply to the current swsusp.c (eg as in 2.6.12-rc2).

>  	for (i = 0; i < nr_copy_pages && !error; i++) {
>  		if (!(i%mod))
>  			printk( "\b\b\b\b%3d%%", i / mod );
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +		src.page = virt_to_page((pagedir_nosave+i)->address);
> +		error = crypto_cipher_encrypt(tfm, &dst, &src, PAGE_SIZE);
> +		if (!error)
> +			error = write_page((unsigned long)&swsusp_header,
> +					  &((pagedir_nosave+i)->swap_address));

I wouldn't use swsusp_header directly in this statement.  It's a bit confusing.

> +#else
>  		error = write_page((pagedir_nosave+i)->address,
>  					  &((pagedir_nosave+i)->swap_address));
> +#endif
>  	}
>  	printk("\b\b\b\bdone\n");
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +	crypto_free_tfm(tfm);
> +#endif
>  	return error;
>  }
>  
> @@ -404,6 +498,10 @@
>  	if ((error = close_swap()))
>  		goto FreePagedir;
>   Done:
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +	memset(key, 0, MAXKEY);
> +	memset(iv, 0, MAXIV);
> +#endif
>  	return error;
>   FreePagedir:
>  	free_pagedir_entries();
> @@ -1124,6 +1222,12 @@
>  	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
>  		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
>  
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +		memcpy(key, swsusp_header.key, MAXKEY);
> +		memcpy(iv, swsusp_header.iv, MAXIV);
> +		memset(swsusp_header.key, 0, MAXKEY);
> +		memset(swsusp_header.iv, 0, MAXIV);
> +#endif
>  		/*
>  		 * Reset swap signature now.
>  		 */
> @@ -1150,6 +1254,18 @@

This change will not apply to the current swsusp.c (eg as in 2.6.12-rc2).

>  	int error;
>  	int i;
>  	int mod = nr_copy_pages / 100;
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +	struct crypto_tfm *tfm;
> +	struct scatterlist src, dst;
> +
> +	if (!(tfm = crypto_init(0)))
> +		return -EINVAL;

Same as in data_write() (ie not necessarily -EINVAL).

> +
> +	src.offset = 0;
> +	src.length = PAGE_SIZE;
> +	dst.offset = 0;
> +	dst.length = PAGE_SIZE;
> +#endif
>  
>  	if (!mod)
>  		mod = 1;
> @@ -1163,8 +1279,18 @@
>  			printk( "\b\b\b\b%3d%%", i / mod );
>  		error = bio_read_page(swp_offset(p->swap_address),
>  				  (void *)p->address);
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +		if (!error) {
> +			src.page = dst.page = virt_to_page((void *)p->address);
> +			error = crypto_cipher_decrypt(tfm, &dst, &src,
> +							PAGE_SIZE);
> +		}
> +#endif
>  	}
>  	printk(" %d done.\n",i);
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +	crypto_free_tfm(tfm);
> +#endif
>  	return error;
>  
>  }
> @@ -1233,6 +1359,11 @@
>  	} else
>  		error = PTR_ERR(resume_bdev);
>  
> +#ifdef CONFIG_SWSUSP_ENCRYPT
> +	memset(key, 0, MAXKEY);
> +	memset(iv, 0, MAXIV);
> +#endif
> +
>  	if (!error)
>  		pr_debug("Reading resume file was successful\n");
>  	else

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
