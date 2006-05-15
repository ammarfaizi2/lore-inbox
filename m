Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWEOLHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWEOLHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWEOLHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:07:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964880AbWEOLHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:07:19 -0400
Date: Mon, 15 May 2006 04:03:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060515040358.5e24549d.akpm@osdl.org>
In-Reply-To: <4468534A.3060604@cosmosbay.com>
References: <20060515005637.00b54560.akpm@osdl.org>
	<4468534A.3060604@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Hi Andrew
> 
> It seems latest kernels have a problem in kmem_cache_destroy()

Mainline, or just -mm?

> On a dual opteron machine (NUMA), its quite easy do trigger the bug : 
> doing a oprofile session like :
> 
> opcontrol --setup --event=CPU_CLK_UNHALTED:100000 
> --vmlinux=/usr/src/linux-2.6.17-rc4-mm1/vmlinux
> ...
> opcontrol --dump
> ...
> opcontrol --deinit    <<<-- Triggers the bug
> 
> slab error in kmem_cache_destroy(): cache `dcookie_cache': Can't free 
> all objects
> 
> Call Trace: <ffffffff80278aa4>{kmem_cache_destroy+212}
>        <ffffffff802bc559>{dcookie_unregister+345} 
> <ffffffff803bbe7a>{event_buffer_release+26}
>        <ffffffff8027cee2>{__fput+98} <ffffffff80279ecd>{filp_close+93}
>        <ffffffff8023003e>{put_files_struct+110} 
> <ffffffff8023143a>{do_exit+650}
>        <ffffffff802f58f1>{__up_write+33} 
> <ffffffff80231bb8>{do_group_exit+200}
>        <ffffffff802097ce>{system_call+126}
> 
> # grep dcookie_cache /proc/slabinfo
> dcookie_cache          0      0     32  101    1 : tunables  120   60    
> 8 : slabdata      0      0      0
> 
> 
> This problem is annoying, because in the oprofile case, we must reboot 
> the machine to be able to start a new profile session.
> 

sony:/home/akpm# opcontrol --setup --event=CPU_CLK_UNHALTED:100000  --vmlinux=/boot/vmlinux-2.6.17-rc4-mm1
sony:/home/akpm# opcontrol --start
Using 2.6+ OProfile kernel interface.
Reading module info.
Using log file /var/lib/oprofile/oprofiled.log
Daemon started.
Profiler running.
sony:/home/akpm# opcontrol --dump 
sony:/home/akpm# opcontrol --stop
Stopping profiling.
sony:/home/akpm# opcontrol --deinit
Stopping profiling.
Killing daemon.
Unloading oprofile module
sony:/home/akpm# dmesg

   <nothing>

Can you provide a more detailed method for reproducing this?
