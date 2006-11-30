Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933883AbWK3FOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933883AbWK3FOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 00:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936179AbWK3FOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 00:14:45 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:12721 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S933883AbWK3FOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 00:14:44 -0500
X-Sasl-enc: IzsOPGJ+erwcF65b2Wh8bIgqGOxX6ow452LKFBxzcvI/ 1164863684
Subject: Re: [PATCH] autofs: fix error code path in autofs_fill_sb()
From: Ian Kent <raven@themaw.net>
To: Jiri Kosina <jkosina@suse.cz>, Andrew Morton <akpm@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611300123160.28502@twin.jikos.cz>
References: <Pine.LNX.4.64.0611300123160.28502@twin.jikos.cz>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 13:14:35 +0800
Message-Id: <1164863675.3127.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-30 at 01:26 +0100, Jiri Kosina wrote:
> [PATCH] autofs: fix error code path in autofs_fill_sb()
> 
> When kernel is compiled with old version of autofs (CONFIG_AUTOFS_FS), and 
> new (observed at least with 5.x.x) automount deamon is started, kernel 
> correctly reports incompatible version of kernel and userland daemon, but 
> then screws things up instead of correct handling of the error:
> 
>  autofs: kernel does not match daemon version
>  =====================================
>  [ BUG: bad unlock balance detected! ]
>  -------------------------------------
>  automount/4199 is trying to release lock (&type->s_umount_key) at:
>  [<c0163b9e>] get_sb_nodev+0x76/0xa4
>  but there are no more locks to release!
> 
>  other info that might help us debug this:
>  no locks held by automount/4199.
> 
>  stack backtrace:
>   [<c0103b15>] dump_trace+0x68/0x1b2
>   [<c0103c77>] show_trace_log_lvl+0x18/0x2c
>   [<c01041db>] show_trace+0xf/0x11
>   [<c010424d>] dump_stack+0x12/0x14
>   [<c012e02c>] print_unlock_inbalance_bug+0xe7/0xf3
>   [<c012fd4f>] lock_release+0x8d/0x164
>   [<c012b452>] up_write+0x14/0x27
>   [<c0163b9e>] get_sb_nodev+0x76/0xa4
>   [<c0163689>] vfs_kern_mount+0x83/0xf6
>   [<c016373e>] do_kern_mount+0x2d/0x3e
>   [<c017513f>] do_mount+0x607/0x67a
>   [<c0175224>] sys_mount+0x72/0xa4
>   [<c0102b96>] sysenter_past_esp+0x5f/0x99
>  DWARF2 unwinder stuck at sysenter_past_esp+0x5f/0x99
>  Leftover inexact backtrace:
>   =======================
> 
> and then deadlock comes.
> 
> The problem: autofs_fill_super() returns EINVAL to get_sb_nodev(), but before
> that, it calls kill_anon_super() to destroy the superblock which won't be 
> needed. This is however way too soon to call kill_anon_super(), because 
> get_sb_nodev() has to perform its own cleanup of the superblock first
> (deactivate_super(), etc.). The correct time to call kill_anon_super() is in
> the autofs_kill_sb() callback, which is called by deactivate_super() at proper
> time, when the superblock is ready to be killed.
> 
> I can see the same faulty codepath also in autofs4. This patch solves issues in
> both filesystems in a same way - it postpones the kill_anon_super() until the 
> proper time is signalized by deactivate_super() calling the kill_sb() callback.
> 
> Patch against 2.6.19-rc6-mm2.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Acked-by: Ian Kent <raven@themaw.net>

It looks so obvious now.
Updating the comment above would be a good idea also, see attached.

> 
> --- 
> 
>  fs/autofs/inode.c        |    4 ++--
>  fs/autofs4/inode.c       |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index 38ede5c..61e04ab 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -31,7 +31,7 @@ void autofs_kill_sb(struct super_block *
>  	 * just exit when we are called from deactivate_super.
>  	 */
>  	if (!sbi)
> -		return;
> +		goto out_kill_sb;
>  
>  	if ( !sbi->catatonic )
>  		autofs_catatonic_mode(sbi); /* Free wait queues, close pipe */
> @@ -44,6 +44,7 @@ void autofs_kill_sb(struct super_block *
>  
>  	kfree(sb->s_fs_info);
>  
> +out_kill_sb:
>  	DPRINTK(("autofs: shutting down\n"));
>  	kill_anon_super(sb);
>  }
> @@ -209,7 +210,6 @@ fail_iput:
>  fail_free:
>  	kfree(sbi);
>  	s->s_fs_info = NULL;
> -	kill_anon_super(s);
>  fail_unlock:
>  	return -EINVAL;
>  }
> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> index ce7c0f1..be14200 100644
> --- a/fs/autofs4/inode.c
> +++ b/fs/autofs4/inode.c
> @@ -155,7 +155,7 @@ void autofs4_kill_sb(struct super_block
>  	 * just exit when we are called from deactivate_super.
>  	 */
>  	if (!sbi)
> -		return;
> +		goto out_kill_sb;
>  
>  	sb->s_fs_info = NULL;
>  
> @@ -167,6 +167,7 @@ void autofs4_kill_sb(struct super_block
>  
>  	kfree(sbi);
>  
> +out_kill_sb:
>  	DPRINTK("shutting down");
>  	kill_anon_super(sb);
>  }
> @@ -426,7 +427,6 @@ fail_ino:
>  fail_free:
>  	kfree(sbi);
>  	s->s_fs_info = NULL;
> -	kill_anon_super(s);
>  fail_unlock:
>  	return -EINVAL;
>  }
> 
> 

Update descriptive comment also.

Signed-off-by: Ian Kent <raven@themaw.net>

---
--- linux-2.6.19-rc5-mm1/fs/autofs4/inode.c.fix-error-in-autofs_fill_sb-comment	2006-11-30 13:05:13.000000000 +0800
+++ linux-2.6.19-rc5-mm1/fs/autofs4/inode.c	2006-11-30 13:09:27.000000000 +0800
@@ -152,7 +152,8 @@ void autofs4_kill_sb(struct super_block 
 	/*
 	 * In the event of a failure in get_sb_nodev the superblock
 	 * info is not present so nothing else has been setup, so
-	 * just exit when we are called from deactivate_super.
+	 * just call kill_anon_super when we are called from
+	 * deactivate_super.
 	 */
 	if (!sbi)
 		goto out_kill_sb;
--- linux-2.6.19-rc5-mm1/fs/autofs/inode.c.fix-error-in-autofs_fill_sb-comment	2006-11-30 13:05:02.000000000 +0800
+++ linux-2.6.19-rc5-mm1/fs/autofs/inode.c	2006-11-30 13:09:00.000000000 +0800
@@ -28,7 +28,8 @@ void autofs_kill_sb(struct super_block *
 	/*
 	 * In the event of a failure in get_sb_nodev the superblock
 	 * info is not present so nothing else has been setup, so
-	 * just exit when we are called from deactivate_super.
+	 * just call kill_anon_super when we are called from
+	 * deactivate_super.
 	 */
 	if (!sbi)
 		goto out_kill_sb;


