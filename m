Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVFGO1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVFGO1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVFGO1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:27:53 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:38924 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261878AbVFGO1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:27:31 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Oleg <graycardinal@pisem.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: kmem_cache_create: duplicate cache fat_cache
References: <200505181217.29904.graycardinal@pisem.net>
	<87br779jen.fsf@devron.myhome.or.jp>
	<42A4A77A.5060101@colorfullife.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 07 Jun 2005 23:26:47 +0900
In-Reply-To: <42A4A77A.5060101@colorfullife.com> (Manfred Spraul's message of "Mon, 06 Jun 2005 21:43:54 +0200")
Message-ID: <87d5qyjl94.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> OGAWA Hirofumi wrote:
>
>>Ummm... why is this normal situation? Didn't you run the
>>modules_install after changed .config?  Anyway, this patch returns
>>NULL instead of calling BUG().  This case seems to also happen with
>>user error.
>>
> Either return NULL or ignore the collision. I don't know what's the
> better solution.
>
> I'm open to either approach - it depends on what the
> kmem_cache_create() caller expects.

> --- 2.6/mm/slab.c	2005-06-05 17:29:01.000000000 +0200
> +++ build-2.6/mm/slab.c	2005-06-06 21:34:38.000000000 +0200
> @@ -1480,9 +1480,14 @@
>  			} 	
>  			if (!strcmp(pc->name,name)) { 
>  				printk("kmem_cache_create: duplicate cache %s\n",name); 
> -				up(&cache_chain_sem); 
> -				unlock_cpu_hotplug();
> -				BUG(); 
> +				/* This is a severe bug, because it breaks
> +				 * tuning by writing to /proc/slabinfo.
> +				 * But everything else works, and since
> +				 * duplicate caches typically happen if
> +				 * someone inserts a module twice, we'll
> +				 * continue.
> +				 */
> +				WARN_ON(1); 
>  			}	
>  		}
>  		set_fs(old_fs);

Ah, I see. I think this is friendly to developers and probably more
proper than my patch for this problem.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
