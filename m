Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTLTVLN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 16:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTLTVLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 16:11:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:9880 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261539AbTLTVLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 16:11:09 -0500
Message-ID: <3FE4BAE3.5000609@osdl.org>
Date: Sat, 20 Dec 2003 13:10:59 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC,PATCH] use rcu for fasync_lock
References: <3FE492EF.2090202@colorfullife.com>
In-Reply-To: <3FE492EF.2090202@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> Hi,
>
> kill_fasync and fasync_helper were intended for mice and similar, rare 
> users, thus it uses a simple rwlock for the locking. This is not true 
> anymore: e.g. every pipe read and write operation calls kill_fasync, 
> which must acquire the rwlock before handling the fasync list.
> What about switching to rcu? I did a reaim run on a 4-way pIII with 
> STP, and it reduced the time within kill_fasync by 80%:
>
> diffprofile reaim_End_stock reaim_End_rcu              21166     1.2% 
> default_idle
>     18882     0.9% total
>       290    12.8% page_address
>       269    23.5% group_send_sig_info
>       259    41.1% do_brk
>       244     6.3% current_kernel_time
> [ delta < 200: skipped]
>      -205   -16.1% get_signal_to_deliver
>      -240    -3.7% page_add_rmap
>      -364    -4.7% __might_sleep
>      -369    -8.4% page_remove_rmap
>      -975   -81.2% kill_fasync
>
> What do you think? Patch against 2.6.0 is attached.
>
> -- 
>    Manfred
>
>------------------------------------------------------------------------
>
>--- 2.6/fs/fcntl.c	2003-12-04 19:44:38.000000000 +0100
>+++ build-2.6/fs/fcntl.c	2003-12-20 10:56:23.344256035 +0100
>@@ -537,9 +537,19 @@
> 	return ret;
> }
> 
>-static rwlock_t fasync_lock = RW_LOCK_UNLOCKED;
>+static spinlock_t fasync_lock = SPIN_LOCK_UNLOCKED;
> static kmem_cache_t *fasync_cache;
> 
>+struct fasync_rcu_struct {
>+	struct fasync_struct data;
>+	struct rcu_head rcu;
>+};
>  
>
Why do needless wrapping of existing structure? Just add and rcu element 
to it!


