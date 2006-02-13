Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWBMDyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWBMDyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 22:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWBMDyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 22:54:20 -0500
Received: from [205.233.219.253] ([205.233.219.253]:21456 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1751568AbWBMDyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 22:54:19 -0500
Date: Sun, 12 Feb 2006 22:51:50 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC 2/4] firewire: dynamic cdev allocation below firewire major
Message-ID: <20060213035150.GE3072@conscoop.ottawa.on.ca>
References: <1138919238.3621.12.camel@localhost> <1138920012.3621.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138920012.3621.19.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:40:12PM +0100, Johannes Berg wrote:
> This  patch implements dynamic minor number allocation below the 171
> major allocated for ieee1394. Since on today's systems one doesn't need
> to have fixed device numbers any more we could just use any, but it's
> probably still useful to use the ieee1394 major number for any firewire
> related devices (like mem1394).

I don't really like this.  There's no benefit to using the 1394 major
number.  I'd rather see an improved alloc_chrdev_region() that does
something like this but for the whole kernel (currently it "wastes" an
entire major even if you only want 1 minor, and for what you're doing,
grabbing 1 minor at a time makes the most sense.)

I'll get to that someday unless someone beats me to it (tm) because it
will be necessary for the raw1394 security improvements I'm (slowly)
working on.  Unless someone convinces me that dynamic allocation under
171 is really the way to go.

Cheers,
Jody

> 
> diff --git a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
> index 25ef5a8..17afc3b 100644
> --- a/drivers/ieee1394/ieee1394_core.c
> +++ b/drivers/ieee1394/ieee1394_core.c
> @@ -29,10 +29,12 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/bitmap.h>
>  #include <linux/bitops.h>
>  #include <linux/kdev_t.h>
>  #include <linux/skbuff.h>
>  #include <linux/suspend.h>
> +#include <linux/cdev.h>
>  
>  #include <asm/byteorder.h>
>  #include <asm/semaphore.h>
> @@ -1053,9 +1055,14 @@ static int hpsbpkt_thread(void *__hi)
>  	complete_and_exit(&khpsbpkt_complete, 0);
>  }
>  
> +/* used further below, but needs to be here for initialisation */
> +static spinlock_t used_minors_lock;
> +
>  static int __init ieee1394_init(void)
>  {
>  	int i, ret;
> +	
> +	spin_lock_init(&used_minors_lock);
>  
>  	skb_queue_head_init(&hpsbpkt_queue);
>  
> @@ -1197,6 +1204,47 @@ static void __exit ieee1394_cleanup(void
>  module_init(ieee1394_init);
>  module_exit(ieee1394_cleanup);
>  
> +/* dynamic minor allocation functions */
> +static DECLARE_BITMAP(used_minors, IEEE1394_MINOR_DYNAMIC_COUNT);
> +
> +int hpsb_cdev_add(struct cdev *chardev)
> +{
> +	int minor, ret;
> +
> +	spin_lock(&used_minors_lock);
> +	minor = find_first_zero_bit(used_minors, IEEE1394_MINOR_DYNAMIC_COUNT);
> +	if (minor >= IEEE1394_MINOR_DYNAMIC_COUNT) {
> +		spin_unlock(&used_minors_lock);
> +		return -ENODEV;
> +	}
> +	set_bit(minor, used_minors);
> +	spin_unlock(&used_minors_lock);
> +
> +	minor += IEEE1394_MINOR_DYNAMIC_FIRST;
> +	ret = cdev_add(chardev, MKDEV(IEEE1394_MAJOR, minor), 1);
> +	if (unlikely(ret)) {
> +		spin_lock(&used_minors_lock);
> +		clear_bit(minor-IEEE1394_MINOR_DYNAMIC_FIRST, used_minors);
> +		spin_unlock(&used_minors_lock);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hpsb_cdev_add);
> +
> +void hpsb_cdev_del(struct cdev *chardev)
> +{
> +	dev_t dev;
> +
> +	BUG_ON(MAJOR(chardev->dev) != IEEE1394_MAJOR);
> +	dev = chardev->dev;
> +	cdev_del(chardev);
> +
> +	spin_lock(&used_minors_lock);
> +	clear_bit(MINOR(dev) - IEEE1394_MINOR_DYNAMIC_FIRST, used_minors);
> +	spin_unlock(&used_minors_lock);
> +}
> +EXPORT_SYMBOL_GPL(hpsb_cdev_del);
> +
>  /* Exported symbols */
>  
>  /** hosts.c **/
> diff --git a/drivers/ieee1394/ieee1394_core.h b/drivers/ieee1394/ieee1394_core.h
> index b354660..d248ed7 100644
> --- a/drivers/ieee1394/ieee1394_core.h
> +++ b/drivers/ieee1394/ieee1394_core.h
> @@ -186,19 +186,38 @@ void hpsb_packet_received(struct hpsb_ho
>   * 171:0-255, the various drivers must then cdev_add() their cdev
>   * objects to handle their respective sub-regions.
>   *
> + * Alternatively, drivers may use a dynamic minor number character
> + * device by using the functions hpsb_cdev_add and hpsb_cdev_del.
> + * hpsb_cdev_add requires an initialised struct cdev and will add
> + * it with cdev_add() automatically, reserving a new minor number
> + * for the new device (unless cdev_add() fails). It returns the
> + * status of cdev_add(), or -ENODEV if no minor could be allocated.
> + * 
> + * Currently 64 minor numbers are reserved for that, if necessary
> + * this number can be increased by simply adjusting the constant
> + * IEEE1394_MINOR_DYNAMIC_FIRST.
> + *
>   * Minor device number block allocations:
>   *
>   * Block 0  (  0- 15)  raw1394
>   * Block 1  ( 16- 31)  video1394
>   * Block 2  ( 32- 47)  dv1394
>   *
> - * Blocks 3-14 free for future allocation
> + * Blocks 3-10 free for future allocation
>   *
> + * Block 11 (176-191)  dynamic allocation region
> + * Block 12 (192-207)  dynamic allocation region
> + * Block 13 (208-223)  dynamic allocation region
> + * Block 14 (224-239)  dynamic allocation region
>   * Block 15 (240-255)  reserved for drivers under development, etc.
>   */
>  
>  #define IEEE1394_MAJOR			 171
>  
> +#define IEEE1394_MINOR_DYNAMIC_FIRST	176
> +#define IEEE1394_MINOR_DYNAMIC_LAST	239
> +#define IEEE1394_MINOR_DYNAMIC_COUNT	(IEEE1394_MINOR_DYNAMIC_LAST-IEEE1394_MINOR_DYNAMIC_FIRST+1)
> +
>  #define IEEE1394_MINOR_BLOCK_RAW1394	   0
>  #define IEEE1394_MINOR_BLOCK_VIDEO1394	   1
>  #define IEEE1394_MINOR_BLOCK_DV1394	   2
> @@ -218,6 +237,11 @@ static inline unsigned char ieee1394_fil
>  	return file->f_dentry->d_inode->i_cindex;
>  }
>  
> +/* add a dynamic ieee1394 device */
> +int hpsb_cdev_add(struct cdev *chardev);
> +/* remove a dynamic ieee1394 device */
> +void hpsb_cdev_del(struct cdev *chardev);
> +
>  extern int hpsb_disable_irm;
>  
>  /* Our sysfs bus entry */
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
