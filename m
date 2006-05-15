Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWEOKJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWEOKJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWEOKJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:09:29 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:32810 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751451AbWEOKJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:09:28 -0400
X-ME-UUID: 20060515100926722.B04431C0027E@mwinf0802.wanadoo.fr
Message-ID: <4468534A.3060604@cosmosbay.com>
Date: Mon, 15 May 2006 12:09:14 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1
References: <20060515005637.00b54560.akpm@osdl.org>
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

It seems latest kernels have a problem in kmem_cache_destroy()

On a dual opteron machine (NUMA), its quite easy do trigger the bug : 
doing a oprofile session like :

opcontrol --setup --event=CPU_CLK_UNHALTED:100000 
--vmlinux=/usr/src/linux-2.6.17-rc4-mm1/vmlinux
...
opcontrol --dump
...
opcontrol --deinit    <<<-- Triggers the bug

slab error in kmem_cache_destroy(): cache `dcookie_cache': Can't free 
all objects

Call Trace: <ffffffff80278aa4>{kmem_cache_destroy+212}
       <ffffffff802bc559>{dcookie_unregister+345} 
<ffffffff803bbe7a>{event_buffer_release+26}
       <ffffffff8027cee2>{__fput+98} <ffffffff80279ecd>{filp_close+93}
       <ffffffff8023003e>{put_files_struct+110} 
<ffffffff8023143a>{do_exit+650}
       <ffffffff802f58f1>{__up_write+33} 
<ffffffff80231bb8>{do_group_exit+200}
       <ffffffff802097ce>{system_call+126}

# grep dcookie_cache /proc/slabinfo
dcookie_cache          0      0     32  101    1 : tunables  120   60    
8 : slabdata      0      0      0


This problem is annoying, because in the oprofile case, we must reboot 
the machine to be able to start a new profile session.

Eric



