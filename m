Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWFZRot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWFZRot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWFZRos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:44:48 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:33384 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932069AbWFZRor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:44:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=l8UU7ukxmwtPJ3Sj+gm7RqtNHunEgQg0j+3wCeOKQgrxYf/w45EAx4YVPj8SWgrKOfVS3IKf9F7/wKiWowhIVPigrmq7S5A3bgHmx7iN8CmEl6mfKTGk/3JsNnHclKhwxEdZ9rmgYJvpKIUdhiaX+wAWRXBn0nb9kRwYXC5wI5o=  ;
Message-ID: <44A01D14.5060708@yahoo.com.au>
Date: Tue, 27 Jun 2006 03:44:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix kernel BUGs when enable SLOB allocator
References: <6d6a94c50606260551n666a62d0ue578ce3c70fae1@mail.gmail.com>
In-Reply-To: <6d6a94c50606260551n666a62d0ue578ce3c70fae1@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:
> Hi all,
> 
> When enable the SLOB allocator on a nommu system(uClinux), the
> following bug occurs when remove a large file.
> =========================================================
> root:~> cp /bin/busybox /busy
> root:~> ls -l /bin/busybox /busy
> -rwxr-xr-x    1 0        0          423904 /bin/busybox
> -rwxr-xr-x    1 0        0          423904 /busy
> root:~> md5sum /bin/busybox
> 7db253a2259ab71bc854c9e5dac544d6  /bin/busybox
> root:~> md5sum /busy
> 7db253a2259ab71bc854c9e5dac544d6  /busy
> root:~> rm /busy
> kernel BUG at mm/nommu.c:124!
> Kernel panic - not syncing: BUG!
> =========================================================
> 
> The root cause is the slob allocator get the pages but does not set
> the PageSlab bit.
> So when kobjsize is called, the bug occurs.
> 
> My patch found a simple way to fix the issue. When SLOB is enabled, we
> don't need to set the PageSlab bit, and don't need to check the
> PageSlab bit(PageSlab(page)) in the kobjsize routine call.
> 
> Signed-off-by: Aubrey Li <aubrey.adi@gmail.com>
> 
> ------
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 029fada..8a54391 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -18,7 +18,9 @@ #include <linux/swap.h>
> #include <linux/file.h>
> #include <linux/highmem.h>
> #include <linux/pagemap.h>
> -#include <linux/slab.h>
> +#ifdef CONFIG_SLAB
> +# include <linux/slab.h>
> +#endif
> #include <linux/vmalloc.h>
> #include <linux/ptrace.h>
> #include <linux/blkdev.h>
> @@ -112,7 +114,9 @@ unsigned int kobjsize(const void *objp)
>        if (!objp || !((page = virt_to_page(objp))))
>                return 0;
> 
> +#ifdef CONFIG_SLAB
>        if (PageSlab(page))
> +#endif
>                return ksize(objp);

Then what if objp isn't a slob object?

I think the better fix would be to make slob set PageSlab.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
