Return-Path: <linux-kernel-owner+w=401wt.eu-S932653AbXAQTUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbXAQTUm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 14:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbXAQTUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 14:20:42 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:20101 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653AbXAQTUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 14:20:41 -0500
Message-ID: <45AE7705.4040603@fr.ibm.com>
Date: Wed, 17 Jan 2007 20:20:37 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Daniel Hokka Zakrisson <daniel@hozac.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, akpm@osdl.org,
       trond.myklebust@fys.uio.no,
       Linux Containers <containers@lists.osdl.org>
Subject: Re: NFS causing oops when freeing namespace
References: <57238.192.168.101.6.1169029688.squirrel@intranet> <m18xg1akmd.fsf@ebiederm.dsl.xmission.com> <51072.192.168.101.6.1169039633.squirrel@intranet> <20070117185823.GA878@tv-sign.ru>
In-Reply-To: <20070117185823.GA878@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> On 01/17, Daniel Hokka Zakrisson wrote:
>>>> Call Trace:
>>>>  [<c03be6f0>] _spin_lock_irqsave+0x20/0x90
>>>>  [<c01f6115>] lockd_down+0x125/0x190
>>>>  [<c01d26bd>] nfs_free_server+0x6d/0xd0
>>>>  [<c01d8e9c>] nfs_kill_super+0xc/0x20
>>>>  [<c0161c5d>] deactivate_super+0x7d/0xa0
>>>>  [<c0175e0e>] release_mounts+0x6e/0x80
>>>>  [<c0175e86>] __put_mnt_ns+0x66/0x80
>>>>  [<c0132b3e>] free_nsproxy+0x5e/0x60
>>>>  [<c011f021>] do_exit+0x791/0x810
>>>>  [<c011f0c6>] do_group_exit+0x26/0x70
>>>>  [<c0103142>] sysenter_past_esp+0x5f/0x85
>>>>  [<c03b0033>] rpc_wake_up+0x3/0x70
>> It was the only semi-plausible explanation I could come up with. I added a
>> printk in do_exit right before exit_task_namespaces, where sighand was
>> still set, and one right before the spin_lock_irq in lockd_down, where it
>> had suddenly been set to NULL.
> 
> I can't reproduce the problem, but

I did on a 2.6.20-rc4-mm1.

> 	do_exit:
> 		exit_notify(tsk);
> 		exit_task_namespaces(tsk);
> 
> the task could be reaped by its parent in between.

indeed. while it goes spleeping in lockd_down() just before it does

	spin_lock_irq(&current->sighand->siglock);

current->sighand is valid before interruptible_sleep_on_timeout() and
not after.
 
> We should not use ->signal/->sighand after exit_notify().
> 
> Can we move exit_task_namespaces() up?

yes but I moved it down because it invalidates ->nsproxy ... 

C.

