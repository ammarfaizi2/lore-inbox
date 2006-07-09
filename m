Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWGIKwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWGIKwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWGIKwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:52:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932438AbWGIKwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:52:20 -0400
Date: Sun, 9 Jul 2006 03:52:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rc1-mm1
Message-Id: <20060709035203.cdc3926f.akpm@osdl.org>
In-Reply-To: <6bffcb0e0607090332i477d594fq9ef96721574ae91b@mail.gmail.com>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<6bffcb0e0607090332i477d594fq9ef96721574ae91b@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 12:32:27 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> Hi,
> 
> On 09/07/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> >
> 
> This looks like a problem with cpufreq.
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> cpuspeed/1426 is trying to acquire lock:
>  (&inode->i_data.tree_lock){.+..}, at: [<c0151dc7>] find_get_page+0x12/0x70
> 
> but task is already holding lock:
>  (&mm->mmap_sem){----}, at: [<c0116cab>] do_page_fault+0x10d/0x4ea
> 
> which lock already depends on the new lock.
> 

rofl.  You broke lockdep.

Well.  I guess it's barely conceivable that you earlier took an oops while
holding tree_lock, so lockdep decided that mmap_sem nests inside tree_lock.


> the existing dependency chain (in reverse order) is:
> 
> -> #1 (cpucontrol){--..}:
>        [<c0139a55>] lock_acquire+0x71/0x91
>        [<c02ee288>] __mutex_lock_slowpath+0xd2/0x2f5
>        [<c02ee4c7>] mutex_lock+0x1c/0x1f
>        [<c013dd3b>] __lock_cpu_hotplug+0x34/0x4c
>        [<c013dd6c>] lock_cpu_hotplug+0xa/0xc
>        [<c029b587>] __cpufreq_driver_target+0x15/0x50
>        [<c029c3ca>] cpufreq_governor_performance+0x1a/0x20
>        [<c029a89b>] __cpufreq_governor+0x95/0x18c
>        [<c029aa72>] __cpufreq_set_policy+0xe0/0x118
>        [<c029af49>] cpufreq_set_policy+0x2d/0x6f
>        [<c029bc45>] cpufreq_add_dev+0x3ee/0x4f3
>        [<c024dccb>] sysdev_driver_register+0x5e/0x9e
>        [<c029be70>] cpufreq_register_driver+0x80/0xf4
>        [<fdba202a>] 0xfdba202a
>        [<c0140f22>] sys_init_module+0xa6/0x21d
>        [<c0103179>] sysenter_past_esp+0x56/0x8d
> 
> -> #0 (&inode->i_data.tree_lock){.+..}:
>        [<c0139a55>] lock_acquire+0x71/0x91
>        [<c02ee288>] __mutex_lock_slowpath+0xd2/0x2f5
>        [<c02ee4c7>] mutex_lock+0x1c/0x1f
>        [<c029b7f2>] store_scaling_governor+0x14a/0x1a2
>        [<c029b223>] store+0x37/0x48
>        [<c01a9f4b>] sysfs_write_file+0xa6/0xcc
>        [<c0172dab>] vfs_write+0xc9/0x172
>        [<c017341d>] sys_write+0x3b/0x71
>        [<c0103179>] sysenter_past_esp+0x56/0x8d

Straightforward ab/ba deadlock between cpufreq_policy.lock and
lock_cpu_hotplug().  But lockdep got confused about the identity of the
lock.

