Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWJHVEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWJHVEa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWJHVE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:04:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40134 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751394AbWJHVE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:04:29 -0400
Date: Sun, 8 Oct 2006 14:02:44 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Paolo Abeni <paolo.abeni@email.it>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: [PATCH] usbmon: control the max amount of captured data for
 eachurb
Message-Id: <20061008140244.8828307e.zaitcev@redhat.com>
In-Reply-To: <1160339657.2479.13.camel@localhost.localdomain>
References: <1160339657.2479.13.camel@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Oct 2006 22:34:17 +0200, Paolo Abeni <paolo.abeni@email.it> wrote:

> An ioctl method is added to each usbmon text files. The ioctl implements
> two operation: retrieving the max size of data that usbmon is able to
> capture for each URB, and changing this value.
>[...]
> This change is useful to get full content of exchanged URB. A recently
> introduced libpcap patch make it possible to sniff from USB port via
> usbmon, but the full USB packet contents is currently unavailable.

I wish whoever did the libpcap fixes designed a new, non-text API instead.
There is no reason to format URBs into text for that.

Is there no chance of that happening?

Also, the patch is a little dirty stylistically, not to mention full of
little, annoying buglets.

> +/* ioctl macros */
> +#define MON_IOC_MAGIC 0xff

Oh bah. Could you at least use something like 0x92 or whatever?
You are going to confuse strace and if you do this.

> +#define MON_IOCS_DATA_MAX _IOW(MON_IOC_MAGIC, 1, int)
> +#define MON_IOCG_DATA_MAX _IOR(MON_IOC_MAGIC, 2, int)

Is that right? You are passing pointers to int, so ioctl numbers get
wrong sizes. This is important on some platforms, and doubly so when
32-bit binaries run under 64-bit kernel.

> +	int ret=0, pos;

This needs to be made prettier, on separate lines and with spaces.

> +    	/* try to allocate early all required buffer and preserve old values 
> +	 * in case of failure */
> +	if (!(new_printf_buf = kmalloc(printf_size, GFP_KERNEL)))
> +	{

I'd appreciate if this looked like this:

	/*
	 * Blah blah blah
	 */
	if ((new_prinf_buf = kmalloc(size, GFP)) == NULL) {
	}

> +	if (!(new_e_slab = kmem_cache_create(new_name,
> +	    sizeof(struct mon_event_text)+data_max, sizeof(long), 0,
> +	    mon_text_ctor, NULL))) {
> +		kfree(new_printf_buf);
> +		ret = -1;
> +		goto out;
> +	}

This is a highly dubious way to allocate, when we talk about data_max 1024.

> +	/* event list must be flush because old entries have differnd size */

"flushed", and "different".

> +static inline struct mon_event_text * mon_event_alloc(
> +    struct mon_reader_text *rp)
> +{
> +	struct mon_event_text *ep = kmem_cache_alloc(rp->e_slab, SLAB_ATOMIC);
> +	if (!ep)
> +		return 0;
> +	ep->data = ((unsigned char*)ep) + sizeof(struct mon_event_text);
> +	return ep;
> +}

Aside from needlessly made inline, this is not bad. But you
obviously thought about out-of-line data, why stop here?

> @@ -249,7 +340,7 @@ static int mon_text_open(struct inode *i
>  	INIT_LIST_HEAD(&rp->e_list);
>  	init_waitqueue_head(&rp->wait);
>  	mutex_init(&rp->printf_lock);
> -
> +	
>  	rp->printf_size = PRINTF_DFL;

Pointless whitespace addition. Don't.

> +    	int ret=0, new_data_max;

Same syntax as before.

> +	u32 __user *argp = (u32 __user *)arg;
>[.]
> +	case MON_IOCS_DATA_MAX:
> +		if (get_user(new_data_max, argp))

This obviously is not needed, because the new size would fit the ioctl
argument just fine.

> +	default:
> +		ret = -ENOTTY;

Good!

Anyway, maybe I should look into it closer. What do you use on top of
libpcap? Wireshark?

-- Pete
