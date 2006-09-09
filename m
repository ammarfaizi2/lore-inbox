Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWIIVtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWIIVtk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 17:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWIIVtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 17:49:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:19043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964868AbWIIVtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 17:49:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=QdLdm+FaaROlsyCBWT9cmKV7KIMGrznde8LUNXjYU0LI+XihU4Sy7BkgXvaPtIEg432DXI1UOt1cpGuxtgBFZDyJCMdC+JkCHwBZRgQfR/9NlN191Bp2IH8WVjTaD4fSnZSD/6jHv4ObDXnxu3oOnhqZDTRU+AMWhQbNOTlx46g=
Date: Sun, 10 Sep 2006 01:49:41 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
       Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
Message-ID: <20060909214941.GA5192@martell.zuzino.mipt.ru>
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <2006-09-09-17-18-13+trackit+sam@rfc1149.net> <1157817522.6877.46.camel@localhost.localdomain> <2006-09-09-17-38-12+trackit+sam@rfc1149.net> <2006-09-09-18-28-44+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2006-09-09-18-28-44+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 06:28:44PM +0200, Samuel Tardieu wrote:
> --- /dev/null
> +++ b/drivers/char/watchdog/w83697hf_wdt.c

> +#define W83697HF_EFER (wdt_io+0)   /* Extended function enable register */
> +#define W83697HF_EFIR (wdt_io+0)   /* Extended function index register */
> +#define W83697HF_EFDR (wdt_io+1)   /* Extended function data register */

Perhaps REG_ENABLE, REG_IDX, REG_DATA (with common short prefix) so
you won't refer to comments every time to understant meaning?

> +static inline void
> +w83697hf_unlock(void)

Make it on one line:

	static inline void w83697hf_unlock(void)

Ditto for all such short lines.

> +static int
> +w83697hf_init(void)

Can be __init?

> +{
> +	if (!request_region(wdt_io, 2, WATCHDOG_NAME)) {
> +		printk(KERN_ERR PFX "I/O address 0x%x already in use\n", wdt_io);
> +		return -EIO;
> +	}
> +
> +	printk(KERN_DEBUG PFX "Looking for watchdog at address 0x%x\n", wdt_io);
> +	w83697hf_unlock();
> +	if (w83697hf_get_reg(0x20) == 0x60) {
> +		printk(KERN_INFO PFX "watchdog found at address 0x%x\n", wdt_io);
> +		w83697hf_lock();
> +		return 0;
> +	}
> +	w83697hf_lock();   /* Reprotect in case it was a compatible device */
> +
> +	printk(KERN_INFO PFX "watchdog not found at address 0x%x\n", wdt_io);

KERN_ERR probably.

> +	release_region(wdt_io, 2);
> +	return -EIO;
> +}

Generally errorless codepath is kept straight and error codepaths branch
from it. I don't remember if this in CodingStyle, so feel free to
ignore. ;-) Something like that:

	if (w83697hf_get_reg(0x20) != 0x60) {
		w83697hf_lock();   /* Reprotect in case it was a compatible device */
			...
		return
	}
	printk(KERN_INFO PFX "watchdog found at address 0x%x\n", wdt_io);
		...

