Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWGZFhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWGZFhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 01:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWGZFhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 01:37:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:707 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030389AbWGZFhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 01:37:08 -0400
Date: Tue, 25 Jul 2006 22:33:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, reiser@namesys.com, viro@zeniv.linux.org.uk,
       viro@ftp.linux.org.uk, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: possible recursive locking detected - while running fs
 operations in loops - 2.6.18-rc2-git5
Message-Id: <20060725223327.b6d039b2.akpm@osdl.org>
In-Reply-To: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
References: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006 00:16:42 +0200
"Jesper Juhl" <jesper.juhl@gmail.com> wrote:

> I just got this from the lock validator :
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> rm/2498 is trying to acquire lock:
>  (&inode->i_mutex){--..}, at: [<c031c3ac>] mutex_lock+0x1c/0x20
> 
> but task is already holding lock:
>  (&inode->i_mutex){--..}, at: [<c031c3ac>] mutex_lock+0x1c/0x20
> 
> other info that might help us debug this:
> 2 locks held by rm/2498:
>  #0:  (&inode->i_mutex/1){--..}, at: [<c017b6f3>] do_rmdir+0x73/0xe0
>  #1:  (&inode->i_mutex){--..}, at: [<c031c3ac>] mutex_lock+0x1c/0x20
> 
> stack backtrace:
>  [<c0103faa>] show_trace_log_lvl+0x12a/0x150
>  [<c0103fe2>] show_trace+0x12/0x20
>  [<c01040f9>] dump_stack+0x19/0x20
>  [<c0138a19>] print_deadlock_bug+0xb9/0xd0
>  [<c0138a9b>] check_deadlock+0x6b/0x80
>  [<c013a344>] __lock_acquire+0x354/0x990
>  [<c013b0a5>] lock_acquire+0x75/0xa0
>  [<c031c430>] __mutex_lock_slowpath+0x70/0x2a0
>  [<c031c3ac>] mutex_lock+0x1c/0x20
>  [<c01ac8b3>] reiserfs_delete_inode+0x63/0xd0
>  [<c01854e1>] generic_delete_inode+0x61/0xe0
>  [<c01856af>] generic_drop_inode+0xf/0x20
>  [<c0185716>] iput+0x56/0x80
>  [<c01826de>] dentry_iput+0x5e/0xc0
>  [<c01827e8>] dput+0xa8/0x170
>  [<c0182c0b>] prune_one_dentry+0x6b/0x80
>  [<c0182d7b>] prune_dcache+0x15b/0x170
>  [<c0182ff0>] shrink_dcache_parent+0x10/0x20
>  [<c017b55a>] dentry_unhash+0x5a/0xc0
>  [<c017b61f>] vfs_rmdir+0x5f/0xc0
>  [<c017b74d>] do_rmdir+0xcd/0xe0
>  [<c017b770>] sys_rmdir+0x10/0x20
>  [<c010304b>] syscall_call+0x7/0xb
>  [<b7e79d7d>] 0xb7e79d7d

The VFS takes the directory i_mutex and reiserfs_delete_inode() takes the
to-be-deleted file's i_mutex.

That's notabug and lockdep will need to be taught about it.

That being said, the reiserfs locking appears to be unneeded - this inode
is going down and nobody else can look it up, so what is to be locked
against?
