Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbUKSNLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUKSNLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUKSNLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:11:21 -0500
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:18411
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S261399AbUKSNLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:11:15 -0500
Date: Fri, 19 Nov 2004 14:10:41 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: NFS hang on unlink with linux-2.4.28 again
Message-ID: <20041119131041.GA7004@titan.lahn.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
References: <200411171156.iAHBuA1E013082@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411171156.iAHBuA1E013082@hera.kernel.org>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Nov 17, 2004 at 03:56:10AM -0800, Marcelo Tosatti wrote:
> Summary of changes from v2.4.28-rc2 to v2.4.28-rc3
> ============================================
> Trond Myklebust:
>   o NFS: Always wake up tasks that are waiting on the sillyrenamed file to complete

I had had the hope, that your following patch
> --- linux-2.4.27/fs/nfs/unlink.c        2004-08-07 16:26:06.000000000 -0700
> +++ linux-2.4.28/fs/nfs/unlink.c        2004-11-17 03:54:21.957412655 -0800
> @@ -130,13 +130,14 @@
>         if (nfs_async_handle_jukebox(task))
>                 return;
>         if (!dir)
> -               return;
> +               goto out;
>         dir_i = dir->d_inode;
>         nfs_zap_caches(dir_i);
>         NFS_PROTO(dir_i)->unlink_done(dir, &task->tk_msg);
>         put_rpccred(data->cred);
>         data->cred = NULL;
>         dput(dir);
> +out:
>         data->completed = 1;
>         wake_up(&data->waitq);
>  }
would have fixed my hang problem, but one of our computers (NFS3 over
TCP in another IP-Segment) just locked up again:

rpciod        S F763E000     0  2620      1          2668  2621 (L-TLB)
Call Trace:
 [<f9f75050>] nfs_complete_unlink+0x1c0/0x1d0 [nfs]
 [<f9f6cd7f>] nfs_dentry_iput+0x3f/0xa0 [nfs]
 [<c015b052>] dput+0x132/0x190 [kernel]
 [<c0145d97>] fput+0xe7/0x140 [kernel]
 [<f9f723b6>] nfs_clear_request+0x86/0x90 [nfs]
 [<f9f773c4>] nfs_commit_done+0x2a4/0x4f0 [nfs]
 [<f9f48155>] call_decode+0x125/0x240 [sunrpc]
 [<f9f4c282>] __rpc_execute+0x242/0x330 [sunrpc]
 [<c011b370>] schedule+0x300/0x590 [kernel]
 [<f9f4c272>] __rpc_execute+0x232/0x330 [sunrpc]
 [<f9f4c4cc>] __rpc_schedule+0xdc/0x160 [sunrpc]
 [<f9f4cf20>] rpciod+0xe0/0x280 [sunrpc]
 [<f9f4ce40>] rpciod+0x0/0x280 [sunrpc]
 [<c010764e>] arch_kernel_thread+0x2e/0x40 [kernel]
 [<f9f5ac0c>] rpciod_killer+0x0/0xc [sunrpc]
 [<f9f4ce40>] rpciod+0x0/0x280 [sunrpc]

gconfd-2      S FFFFFFFF     0  2668      1          2674  2620 (NOTLB)
Call Trace:
 [<f9f72611>] nfs_wait_on_request+0x131/0x140 [nfs]
 [<f9f75ae5>] nfs_update_request+0x95/0x360 [nfs]
 [<f9f75f99>] nfs_updatepage+0xc9/0x2b0 [nfs]
 [<f9f75e9f>] nfs_flush_incompatible+0x8f/0xc0 [nfs]
 [<f9f6e26a>] nfs_commit_write+0x4a/0x80 [nfs]
 [<c0135ad9>] do_generic_file_write+0x289/0x480 [kernel]
 [<c02298d8>] sk_free+0x58/0x90 [kernel]
 [<c0136021>] generic_file_write+0x121/0x140 [kernel]
 [<c015af51>] dput+0x31/0x190 [kernel]
 [<f9f6e37a>] nfs_file_write+0x7a/0xe0 [nfs]
 [<c0144d5d>] sys_write+0xad/0x170 [kernel]
 [<c0144687>] sys_close+0x67/0x80 [kernel]
 [<c010979f>] system_call+0x33/0x38 [kernel]

gnome-smproxy S 00000000     0  2676      1          2678  2674 (NOTLB)
Call Trace:
 [<f9f72611>] nfs_wait_on_request+0x131/0x140 [nfs]
 [<f9f75799>] nfs_wait_on_requests+0x99/0xb0 [nfs]
 [<f9f77786>] nfs_sync_file+0x76/0x80 [nfs]
 [<f9f6df51>] nfs_file_flush+0x41/0xa0 [nfs]
 [<c01445ad>] filp_close+0x5d/0xd0 [kernel]
 [<c0144dc7>] sys_write+0x117/0x170 [kernel]
 [<c0144687>] sys_close+0x67/0x80 [kernel]
 [<c010979f>] system_call+0x33/0x38 [kernel]

gnome-panel   S E8EFE800     0  2808      1          2812  2784 (NOTLB)
Call Trace:
 [<f9f6d4b2>] nfs_sillyrename+0x182/0x240 [nfs]
 [<f9f75050>] nfs_complete_unlink+0x1c0/0x1d0 [nfs]
 [<f9f6cd7f>] nfs_dentry_iput+0x3f/0xa0 [nfs]
 [<c015b052>] dput+0x132/0x190 [kernel]
 [<c0145d97>] fput+0xe7/0x140 [kernel]
 [<c01445df>] filp_close+0x8f/0xd0 [kernel]
 [<c0144687>] sys_close+0x67/0x80 [kernel]
 [<c010979f>] system_call+0x33/0x38 [kernel]

gnome-termina S E019FB00     0  2895      1  2974          2814 (NOTLB)
Call Trace:
 [<f9f6d4b2>] nfs_sillyrename+0x182/0x240 [nfs]
 [<f9f75050>] nfs_complete_unlink+0x1c0/0x1d0 [nfs]
 [<f9f6cd7f>] nfs_dentry_iput+0x3f/0xa0 [nfs]
 [<c015b052>] dput+0x132/0x190 [kernel]
 [<c0145d97>] fput+0xe7/0x140 [kernel]
 [<c01445df>] filp_close+0x8f/0xd0 [kernel]
 [<c0144687>] sys_close+0x67/0x80 [kernel]
 [<c010979f>] system_call+0x33/0x38 [kernel]

emacs         S 0000674D     0  2977   2974          3145       (NOTLB)
Call Trace:
 [<f9f72611>] nfs_wait_on_request+0x131/0x140 [nfs]
 [<f9f75799>] nfs_wait_on_requests+0x99/0xb0 [nfs]
 [<f9f77786>] nfs_sync_file+0x76/0x80 [nfs]
 [<f9f6df51>] nfs_file_flush+0x41/0xa0 [nfs]
 [<c01445ad>] filp_close+0x5d/0xd0 [kernel]
 [<c0144dc7>] sys_write+0x117/0x170 [kernel]
 [<c0144687>] sys_close+0x67/0x80 [kernel]
 [<c010979f>] system_call+0x33/0x38 [kernel]

emacs         S 00000000     0  3145                2974 2977 (NOTLB)
Call Trace:
 [<f9f72611>] nfs_wait_on_request+0x131/0x140 [nfs]
 [<f9f75799>] nfs_wait_on_requests+0x99/0xb0 [nfs]
 [<f9f77786>] nfs_sync_file+0x76/0x80 [nfs]
 [<f9f6df51>] nfs_file_flush+0x41/0xa0 [nfs]
 [<c01445ad>] filp_close+0x5d/0xd0 [kernel]
 [<c0144dc7>] sys_write+0x117/0x170 [kernel]
 [<c0144687>] sys_close+0x67/0x80 [kernel]
 [<c010979f>] system_call+0x33/0x38 [kernel]

BYtE
Philipp
-- 
/ /  (_)__  __ ____  __ Philipp Hahn
/ /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
