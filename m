Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUKFRNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUKFRNd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 12:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUKFRNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 12:13:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1192 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261425AbUKFRNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 12:13:20 -0500
Message-ID: <418D0623.8000302@pobox.com>
Date: Sat, 06 Nov 2004 12:13:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: james4765@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hw_random: Update printk()'s in hw_random.c
References: <20041105211912.17210.55119.84600@localhost.localdomain>
In-Reply-To: <20041105211912.17210.55119.84600@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james4765@verizon.net wrote:
> Update drivers/char/hw_random.c to pr_debug()/pr_info()
> 
> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -urN --exclude='*~' linux-2.6.9-original/drivers/char/hw_random.c linux-2.6.9/drivers/char/hw_random.c
> --- linux-2.6.9-original/drivers/char/hw_random.c	2004-10-18 17:53:50.000000000 -0400
> +++ linux-2.6.9/drivers/char/hw_random.c	2004-11-05 15:26:10.869606837 -0500
> @@ -56,31 +56,28 @@
>  /*
>   * debugging macros
>   */
> -#undef RNG_DEBUG /* define to enable copious debugging info */
> +#undef DEBUG /* define to enable copious debugging info */

I think the '#undef DEBUG' line is supposed to precede all the 
#includes, yes?


> +/* pr_debug() collapses to a no-op if DEBUG is not defined */
> +#define DPRINTK(fmt, args...) pr_debug(PFX "%s: " fmt, __FUNCTION__ , ## args)
>  
> -#ifdef RNG_DEBUG
> -/* note: prints function name for you */
> -#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
> -#else
> -#define DPRINTK(fmt, args...)
> -#endif
>  
> -#define RNG_NDEBUG        /* define to disable lightweight runtime checks */
> +#undef RNG_NDEBUG        /* define to enable lightweight runtime checks */
>  #ifdef RNG_NDEBUG
> -#define assert(expr)
> +#define assert(expr)							\
> +		if(!(expr)) {						\
> +		pr_debug(PFX "Assertion failed! %s,%s,%s,line=%d\n",	\
> +		#expr,__FILE__,__FUNCTION__,__LINE__);			\
> +		}
>  #else
> -#define assert(expr) \
> -        if(!(expr)) {                                   \
> -        printk( "Assertion failed! %s,%s,%s,line=%d\n", \
> -        #expr,__FILE__,__FUNCTION__,__LINE__);          \
> -        }
> +#define assert(expr)
>  #endif
>  
>  #define RNG_MISCDEV_MINOR		183 /* official */
>  
>  static int rng_dev_open (struct inode *inode, struct file *filp);
>  static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
> -			     loff_t * offp);
> +		loff_t * offp);

seemingly bogus whitespace change


>  static int __init intel_init (struct pci_dev *dev);
>  static void intel_cleanup(void);
> @@ -322,7 +319,7 @@
>  	rnen |= (1 << 7);	/* PMIO enable */
>  	pci_write_config_byte(dev, 0x41, rnen);
>  
> -	printk(KERN_INFO PFX "AMD768 system management I/O registers at 0x%X.\n", pmbase);
> +	pr_info(PFX "AMD768 system management I/O registers at 0x%X.\n",pmbase);
>  
>  	amd_dev = dev;
>  
> @@ -413,7 +410,8 @@
>  	 * completes.
>  	 */
>  	via_rng_datum = 0; /* paranoia, not really necessary */
> -	bytes_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_1) & VIA_XSTORE_CNT_MASK;
> +	bytes_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_1) &
> +			VIA_XSTORE_CNT_MASK;

bogus whitespace change
