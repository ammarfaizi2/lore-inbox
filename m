Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbUJ1RWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUJ1RWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUJ1RWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:22:08 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:33758 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262904AbUJ1RVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:21:34 -0400
Message-ID: <41812A92.4020803@colorfullife.com>
Date: Thu, 28 Oct 2004 19:21:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@dsv.su.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Livelock with the shmctl04 test program from linux test project
References: <41794334.1080206@colorfullife.com> <1098961145.787.7.camel@boxen>
In-Reply-To: <1098961145.787.7.camel@boxen>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:

>Sorry for late reply, but I just can't understand why & how this happens, been trying to grasp
>the IPC/SHM part but I'm missing something. One processor gets locked up and never released.
>  
>
Ok - that's a deadlock.

>I did:
>
>printk("taking lock\n"); 
>spin_lock(&info->lock);
>printk("lock taken\n");
>
>and it never prints out "lock taken" so i know where it locks up. Now the fun part,
>spinlock debugging doesn't catch it,
>
That's not surprising: the full debug code is only active for 
uniprocessor kernels. On SMP, only a simple check for unitialized 
spinlocks is performed.
Btw, I'd use
    printk("thread %d, struct %p: taking lock", current->pid, info);
Then you are certain that you are not fooled by multiple concurrent 
operations.

> but I did a simple patch to show who is holding a lock
>at the current time, and it appears noone has taken the lock. I really don't get this.
>
>  
>
I must think about it. Who's printed as the last owner that released the 
lock? Perhaps there is a race with segment destruction: The structures 
are protected by RCU.

Could you enable debug spinlocks and slab debugging? I would have 
expected an error message from spinlock debugging due to bad magic.

--
    Manfred
