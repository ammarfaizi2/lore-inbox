Return-Path: <linux-kernel-owner+w=401wt.eu-S964784AbWLOUmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWLOUmT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWLOUmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:42:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42976 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964784AbWLOUmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:42:18 -0500
Date: Fri, 15 Dec 2006 12:42:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michal Sabala <lkml@saahbs.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-Id: <20061215124208.a053f4d3.akpm@osdl.org>
In-Reply-To: <20061215175030.GG6220@prosiaczek>
References: <20061215023014.GC2721@prosiaczek>
	<1166199855.5761.34.camel@lade.trondhjem.org>
	<20061215175030.GG6220@prosiaczek>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 11:50:30 -0600
Michal Sabala <lkml@saahbs.net> wrote:

> On 2006/12/15 at 10:24:15 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> > On Thu, 2006-12-14 at 20:30 -0600, Michal Sabala wrote:
> > > 
> > > `cat /proc/*PID*/wchan` for all hanging processes contains page_sync.
> > 
> > Have you tried an 'echo t >/proc/sysrq-trigger' on a client with one of
> > these hanging processes? If so, what does the output look like?
> 
> Hello Trond,
> 
> Below is the sysrq trace output for XFree86 which entered the
> uninterruptible sleep state on the P4 machine with nfs /home. Please
> note that XFree86 does not have any files open in /home - as reported by
> `lsof`. Below, I also listed the output of vmstat.

We'd need to see the trace of all D-state processes, please.  Xfree86 might
just be a victim of a deadlock elsewhere.  However there is a problem here..


> 
> XFree86       D 00000003     0  2471   2453                     (NOTLB)
>        c4871c0c 00003082 c86b72bc 00000003 cb7c94a4 0000001d 3b67f3ff c0146dd2 
>        c1184180 cb3e7110 00000000 001ec7ff a60f8097 00000089 c02e1e60 cb3e7000 
>        c1184180 00000000 c1180030 c4871c18 c028c7d8 c4871c5c c01435b6 c01435f3 
> Call Trace:
>  [<c0146dd2>] free_pages_bulk+0x1d/0x1d4
>  [<c028c7d8>] io_schedule+0x26/0x30
>  [<c01435b6>] sync_page+0x0/0x40
>  [<c01435f3>] sync_page+0x3d/0x40
>  [<c028c9ce>] __wait_on_bit_lock+0x2c/0x52
>  [<c0143c13>] __lock_page+0x6a/0x72
>  [<c012ec77>] wake_bit_function+0x0/0x3c
>  [<c012ec77>] wake_bit_function+0x0/0x3c
>  [<c0149d2f>] pagevec_lookup+0x17/0x1d
>  [<c014a085>] truncate_inode_pages_range+0x20a/0x260
>  [<c014a0e4>] truncate_inode_pages+0x9/0xc
>  [<c0172c8a>] generic_delete_inode+0xb6/0x10f
>  [<c0172e73>] iput+0x5f/0x61
>  [<c01706bd>] dentry_iput+0x68/0x83
>  [<c01707d8>] dput+0x100/0x118
>  [<ccb6c334>] put_nfs_open_context+0x67/0x88 [nfs]
>  [<ccb701ed>] nfs_release_request+0x38/0x47 [nfs]
>  [<ccb736dd>] nfs_wait_on_requests_locked+0x62/0x98 [nfs]
>  [<ccb74c32>] nfs_sync_inode_wait+0x4a/0x130 [nfs]
>  [<ccb6b639>] nfs_release_page+0x0/0x30 [nfs]
>  [<ccb6b655>] nfs_release_page+0x1c/0x30 [nfs]
>  [<c015f37c>] try_to_release_page+0x34/0x46
>  [<c014aa8b>] shrink_page_list+0x263/0x350
>  [<c0104db8>] do_IRQ+0x48/0x50
>  [<c01036c6>] common_interrupt+0x1a/0x20
>  [<c014acd7>] shrink_inactive_list+0x9b/0x248
>  [<c014b2fd>] shrink_zone+0xb5/0xd0
>  [<c014b382>] shrink_zones+0x6a/0x7e
>  [<c014b48e>] try_to_free_pages+0xf8/0x1da
>  [<c0147a18>] __alloc_pages+0x17c/0x278
>  [<c014f555>] do_anonymous_page+0x45/0x150
>  [<c014f9f7>] __handle_mm_fault+0xda/0x1bf
>  [<c0115849>] do_page_fault+0x1c4/0x4bc
>  [<c01021b7>] restore_sigcontext+0x10c/0x15f
>  [<c0115685>] do_page_fault+0x0/0x4bc
>  [<c0103809>] error_code+0x39/0x40

nfs_release_page() was called with a locked page.  It's doing a bunch of
stuff which results in a call to truncate_inode_pages(), which will run
lock_page(), which is deadlocky.

But it's rather obviously deadlocky, so perhaps NFS drops and reacquires
the page lock somewhere?

