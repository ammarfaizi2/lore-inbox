Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266285AbUA2GbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 01:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266286AbUA2GbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 01:31:19 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:47945 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266285AbUA2GbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 01:31:12 -0500
Date: Thu, 29 Jan 2004 17:30:09 +1100
From: Nathan Scott <nathans@sgi.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040129063009.GD2474@frodo>
References: <bv8qr7$m2v$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bv8qr7$m2v$1@news.cistron.nl>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 05:17:27PM +0000, Miquel van Smoorenburg wrote:
> I have a Linux 2.6.2-rc2 NFS file server and another similar
> box as client. Kernel is compiled for SMP (hyperthreading).
> 
> On the NFS server I'm exporting an XFS filesystem to the client
> over Gigabit ethernet. The client mounts using
> mount -o nfsvers=3,intr,rsize=32768,wsize=32768 server:/export/hwr /mnt
> 
> On the client I then run a large dd to a file on the server,
> like dd if=/dev/zero of=/mnt/file bs=4096 count=800000
> 
> In a few seconds, the server locks up. It spins in
> generic_fillattr(), apparently in the i_size_read() inline function.
> Server responds to pings and sysrq, but nothing else.
> 
> 2.6.1 doesn't show this behaviour. I tested several kernels:
> 
> 2.6.1           	OK!
> 2.6.1-bk4		OK!
> 2.6.1-bk5		doesn't boot
> 2.6.1-bk6		hangs
> 2.6.2-rc1		hangs
> 2.6.2-rc2		hangs
> 2.6.2-rc2-gcc-2.95	hangs
> 2.6.2-rc1-mm3		OK!
> 2.6.2-rc2-mm1		OK!

> I can't reproduce it on the local filesystem on the NFS server
> directly, and I can't reproduce it on other filesystems than XFS.
> But NFSD+XFS locks up every time.

Hmmmm... I don't think Andrew has any XFS fixes in his tree that
might help there; and I can't think of any XFS change in -rc1 that
might have caused this (does the fs/xfs subdir from 2.6.1 plonked
down in place of the 2.6.2-rc1/2 version still have the problem?)

i_size_read seems to have a fair bit of config dependency - are you
CONFIG_SMP / CONFIG_PREEMPT / neither?  and is your BITS_PER_LONG
32 or 64?  thanks.

> (By the way, on 2.6.2-rc1-mm3 and 2.6.2-rc2-mm1 mounting an XFS
>  filesystem results in lots of:
> 
>  Badness in interruptible_sleep_on at kernel/sched.c:2239
>  Call Trace:
>   [<c011f5a3>] interruptible_sleep_on+0xf6/0xfb
>   [<c011f209>] default_wake_function+0x0/0x12
>   [<f8ac0fa2>] pagebuf_daemon+0x231/0x24c [xfs]
>   [<c0339ed6>] ret_from_fork+0x6/0x14
>   [<f8ac0d47>] pagebuf_daemon_wakeup+0x0/0x2a [xfs]
>   [<f8ac0d71>] pagebuf_daemon+0x0/0x24c [xfs]
>   [<c0109269>] kernel_thread_helper+0x5/0xb       )
> 

There's fixes floating around for this, I'll get it merged soon.

cheers.

-- 
Nathan
