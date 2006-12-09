Return-Path: <linux-kernel-owner+w=401wt.eu-S1754424AbWLIDtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbWLIDtI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 22:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757388AbWLIDtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 22:49:08 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60986 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754424AbWLIDtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 22:49:03 -0500
X-Sasl-enc: vJhkoSpHqOuPIxPhwyPQ0b6uV4NMMFt2TASK2/rKIQfx 1165636142
Subject: Re: [patch 28/32] autofs: fix error code path in autofs_fill_sb()
From: Ian Kent <raven@themaw.net>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jkosina@suse.cz
In-Reply-To: <20061209000246.210981000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
	 <20061209000246.210981000@sous-sol.org>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 12:48:46 +0900
Message-Id: <1165636126.3980.11.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-21.el5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 15:58 -0800, Chris Wright wrote:
> plain text document attachment
> (autofs-fix-error-code-path-in-autofs_fill_sb.patch)
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------

Stable review of what (version)?

> 
> From: Jiri Kosina <jkosina@suse.cz>
> 
> When kernel is compiled with old version of autofs (CONFIG_AUTOFS_FS), and
> new (observed at least with 5.x.x) automount deamon is started, kernel
> correctly reports incompatible version of kernel and userland daemon, but
> then screws things up instead of correct handling of the error:

No objections.
I'm sure I tested this case when I did the original patch that has the
error which this patch fixes.

The bug is clearly present and needs fixing.

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
> The problem: autofs_fill_super() returns EINVAL to get_sb_nodev(), but
> before that, it calls kill_anon_super() to destroy the superblock which
> won't be needed.  This is however way too soon to call kill_anon_super(),
> because get_sb_nodev() has to perform its own cleanup of the superblock
> first (deactivate_super(), etc.).  The correct time to call
> kill_anon_super() is in the autofs_kill_sb() callback, which is called by
> deactivate_super() at proper time, when the superblock is ready to be
> killed.
> 
> I can see the same faulty codepath also in autofs4.  This patch solves
> issues in both filesystems in a same way - it postpones the
> kill_anon_super() until the proper time is signalized by deactivate_super()
> calling the kill_sb() callback.
> 
> [raven@themaw.net: update comment]
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Acked-by: Ian Kent <raven@themaw.net>
> Cc: <stable@kernel.org>
> Signed-off-by: Ian Kent <raven@themaw.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
> 
>  fs/autofs/inode.c  |    7 ++++---
>  fs/autofs4/inode.c |    7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.19.orig/fs/autofs/inode.c
> +++ linux-2.6.19/fs/autofs/inode.c
> @@ -28,10 +28,11 @@ void autofs_kill_sb(struct super_block *
>  	/*
>  	 * In the event of a failure in get_sb_nodev the superblock
>  	 * info is not present so nothing else has been setup, so
> -	 * just exit when we are called from deactivate_super.
> +	 * just call kill_anon_super when we are called from
> +	 * deactivate_super.
>  	 */
>  	if (!sbi)
> -		return;
> +		goto out_kill_sb;
>  
>  	if ( !sbi->catatonic )
>  		autofs_catatonic_mode(sbi); /* Free wait queues, close pipe */
> @@ -44,6 +45,7 @@ void autofs_kill_sb(struct super_block *
>  
>  	kfree(sb->s_fs_info);
>  
> +out_kill_sb:
>  	DPRINTK(("autofs: shutting down\n"));
>  	kill_anon_super(sb);
>  }
> @@ -209,7 +211,6 @@ fail_iput:
>  fail_free:
>  	kfree(sbi);
>  	s->s_fs_info = NULL;
> -	kill_anon_super(s);
>  fail_unlock:
>  	return -EINVAL;
>  }
> --- linux-2.6.19.orig/fs/autofs4/inode.c
> +++ linux-2.6.19/fs/autofs4/inode.c
> @@ -152,10 +152,11 @@ void autofs4_kill_sb(struct super_block 
>  	/*
>  	 * In the event of a failure in get_sb_nodev the superblock
>  	 * info is not present so nothing else has been setup, so
> -	 * just exit when we are called from deactivate_super.
> +	 * just call kill_anon_super when we are called from
> +	 * deactivate_super.
>  	 */
>  	if (!sbi)
> -		return;
> +		goto out_kill_sb;
>  
>  	sb->s_fs_info = NULL;
>  
> @@ -167,6 +168,7 @@ void autofs4_kill_sb(struct super_block 
>  
>  	kfree(sbi);
>  
> +out_kill_sb:
>  	DPRINTK("shutting down");
>  	kill_anon_super(sb);
>  }
> @@ -426,7 +428,6 @@ fail_ino:
>  fail_free:
>  	kfree(sbi);
>  	s->s_fs_info = NULL;
> -	kill_anon_super(s);
>  fail_unlock:
>  	return -EINVAL;
>  }
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

