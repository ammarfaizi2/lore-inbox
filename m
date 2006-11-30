Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967724AbWK3A0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967724AbWK3A0c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967723AbWK3A0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:26:32 -0500
Received: from twin.jikos.cz ([213.151.79.26]:51944 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S967722AbWK3A0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:26:32 -0500
Date: Thu, 30 Nov 2006 01:26:17 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: Andrew Morton <akpm@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Ian Kent <raven@themaw.net>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] autofs: fix error code path in autofs_fill_sb()
Message-ID: <Pine.LNX.4.64.0611300123160.28502@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] autofs: fix error code path in autofs_fill_sb()

When kernel is compiled with old version of autofs (CONFIG_AUTOFS_FS), and 
new (observed at least with 5.x.x) automount deamon is started, kernel 
correctly reports incompatible version of kernel and userland daemon, but 
then screws things up instead of correct handling of the error:

 autofs: kernel does not match daemon version
 =====================================
 [ BUG: bad unlock balance detected! ]
 -------------------------------------
 automount/4199 is trying to release lock (&type->s_umount_key) at:
 [<c0163b9e>] get_sb_nodev+0x76/0xa4
 but there are no more locks to release!

 other info that might help us debug this:
 no locks held by automount/4199.

 stack backtrace:
  [<c0103b15>] dump_trace+0x68/0x1b2
  [<c0103c77>] show_trace_log_lvl+0x18/0x2c
  [<c01041db>] show_trace+0xf/0x11
  [<c010424d>] dump_stack+0x12/0x14
  [<c012e02c>] print_unlock_inbalance_bug+0xe7/0xf3
  [<c012fd4f>] lock_release+0x8d/0x164
  [<c012b452>] up_write+0x14/0x27
  [<c0163b9e>] get_sb_nodev+0x76/0xa4
  [<c0163689>] vfs_kern_mount+0x83/0xf6
  [<c016373e>] do_kern_mount+0x2d/0x3e
  [<c017513f>] do_mount+0x607/0x67a
  [<c0175224>] sys_mount+0x72/0xa4
  [<c0102b96>] sysenter_past_esp+0x5f/0x99
 DWARF2 unwinder stuck at sysenter_past_esp+0x5f/0x99
 Leftover inexact backtrace:
  =======================

and then deadlock comes.

The problem: autofs_fill_super() returns EINVAL to get_sb_nodev(), but before
that, it calls kill_anon_super() to destroy the superblock which won't be 
needed. This is however way too soon to call kill_anon_super(), because 
get_sb_nodev() has to perform its own cleanup of the superblock first
(deactivate_super(), etc.). The correct time to call kill_anon_super() is in
the autofs_kill_sb() callback, which is called by deactivate_super() at proper
time, when the superblock is ready to be killed.

I can see the same faulty codepath also in autofs4. This patch solves issues in
both filesystems in a same way - it postpones the kill_anon_super() until the 
proper time is signalized by deactivate_super() calling the kill_sb() callback.

Patch against 2.6.19-rc6-mm2.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

 fs/autofs/inode.c        |    4 ++--
 fs/autofs4/inode.c       |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 38ede5c..61e04ab 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -31,7 +31,7 @@ void autofs_kill_sb(struct super_block *
 	 * just exit when we are called from deactivate_super.
 	 */
 	if (!sbi)
-		return;
+		goto out_kill_sb;
 
 	if ( !sbi->catatonic )
 		autofs_catatonic_mode(sbi); /* Free wait queues, close pipe */
@@ -44,6 +44,7 @@ void autofs_kill_sb(struct super_block *
 
 	kfree(sb->s_fs_info);
 
+out_kill_sb:
 	DPRINTK(("autofs: shutting down\n"));
 	kill_anon_super(sb);
 }
@@ -209,7 +210,6 @@ fail_iput:
 fail_free:
 	kfree(sbi);
 	s->s_fs_info = NULL;
-	kill_anon_super(s);
 fail_unlock:
 	return -EINVAL;
 }
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index ce7c0f1..be14200 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -155,7 +155,7 @@ void autofs4_kill_sb(struct super_block
 	 * just exit when we are called from deactivate_super.
 	 */
 	if (!sbi)
-		return;
+		goto out_kill_sb;
 
 	sb->s_fs_info = NULL;
 
@@ -167,6 +167,7 @@ void autofs4_kill_sb(struct super_block
 
 	kfree(sbi);
 
+out_kill_sb:
 	DPRINTK("shutting down");
 	kill_anon_super(sb);
 }
@@ -426,7 +427,6 @@ fail_ino:
 fail_free:
 	kfree(sbi);
 	s->s_fs_info = NULL;
-	kill_anon_super(s);
 fail_unlock:
 	return -EINVAL;
 }


-- 
Jiri Kosina
SUSE Labs

