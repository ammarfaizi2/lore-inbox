Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWEVQn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWEVQn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWEVQn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:43:27 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:8407 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1750983AbWEVQn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:43:27 -0400
Message-ID: <4471EA2C.4010401@oracle.com>
Date: Mon, 22 May 2006 09:43:24 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] kmap tracking
References: <20060518155357.04066e9c.rdunlap@xenotime.net>
In-Reply-To: <20060518155357.04066e9c.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Track kmap/kunmap call history, storing caller function address,
> action, and time (jiffies), if CONFIG_DEBUG_KMAP is enabled.
> Based on a patch to 2.4.21 by Zach Brown that was used successfully
> at Oracle to track down some kmap/kunmap problems.

Thanks for bringing this to 2.6.. sorry for the lag in reviewing.

> +enum {
> +	KMAP_FIRST = 1,
> +	KMAP_ADDREF,
> +	KMAP_DECREF,
> +	KMAP_LAST,
> +};

I trust you got rid of these in the most recent version :)

> +#else
> +#define kmap_record_action(nr, action, refcount, retaddr) do {} while (0)
> +#endif

Make this an inline, please, so that we don't introduce unused var warnings.

> +static __init int kmap_history_init(void)
> +{
> +	kmap_history_file = debugfs_create_file("kmap-history", 0644, NULL,
> +			kh_running, &kmap_running_seq_fops);
> +	if (!kmap_history_file)
> +		goto out1;
> +
> +	return 0;
> +
> +out1:
> +	return -ENOMEM;

That seems noisy.. return -ENOMEM is probably fine for such a trivial
funciton :).

> +#define kmap(page)	__kmap(page, __builtin_return_address(0))
> +#define kunmap(page)	__kunmap(page, __builtin_return_address(0))

Hmm, I was hoping we wouldn't have to do this.  Can we use
__builtin_return_address(1) from within the debug paths instead of
passing down (0)?  Then we wouldn't have to ifdef around the declarations..

- z
