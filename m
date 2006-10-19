Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946225AbWJSQx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946225AbWJSQx7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946227AbWJSQx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:53:58 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:59811 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1946225AbWJSQx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:53:58 -0400
Date: Thu, 19 Oct 2006 09:53:38 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Joel Becker <Joel.Becker@oracle.com>
Subject: Re: Issues with possible recursive locking
Message-ID: <20061019165338.GC10128@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4535A89E.9070609@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4535A89E.9070609@in.ibm.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 09:37:58AM +0530, Srinivasa Ds wrote:
> When I was removing dlm module,I hit in to below error.
This patch should take care of that particular warning, please let me know
if it doesn't. I'll carry it in ocfs2.git shortly.

Hmm, I get other warnings from configfs starting and stopping the ocfs2
cluster stack, so I bet we've got some more mutex_lock() calls in there to
change to mutex_lock_nested():

[ INFO: possible recursive locking detected ]
2.6.19-rc2 #1
---------------------------------------------
o2cb_ctl/2457 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c02ff984>] mutex_lock+0x21/0x24

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c02ff984>] mutex_lock+0x21/0x24

other info that might help us debug this:
2 locks held by o2cb_ctl/2457:
 #0:  (&inode->i_mutex/1){--..}, at: [<c0177194>] lookup_create+0x1d/0x73
 #1:  (&inode->i_mutex){--..}, at: [<c02ff984>] mutex_lock+0x21/0x24

stack backtrace:
 [<c0104d0a>] dump_trace+0x64/0x1c2
 [<c0104e7a>] show_trace_log_lvl+0x12/0x25
 [<c01053c6>] show_trace+0xd/0x10
 [<c01054dc>] dump_stack+0x19/0x1b
 [<c013c7bb>] __lock_acquire+0x6c6/0x8e3
 [<c013cf1b>] lock_acquire+0x4b/0x6c
 [<c02ff81d>] __mutex_lock_slowpath+0xb0/0x1f6
 [<c02ff984>] mutex_lock+0x21/0x24
 [<f8aa2800>] configfs_add_file+0x36/0x60 [configfs]
 [<f8aa285f>] configfs_create_file+0x35/0x38 [configfs]
 [<f8aa3260>] configfs_attach_item+0x13d/0x180 [configfs]
 [<f8aa32b7>] configfs_attach_group+0x14/0x154 [configfs]
 [<f8aa3377>] configfs_attach_group+0xd4/0x154 [configfs]
 [<f8aa3d8b>] configfs_mkdir+0x1b2/0x287 [configfs]
 [<c017666a>] vfs_mkdir+0xca/0x131
 [<c0178c8d>] sys_mkdirat+0x88/0xbb
 [<c0178cd0>] sys_mkdir+0x10/0x12
 [<c0103e2b>] syscall_call+0x7/0xb
	--Mark


configfs: mutex_lock_nested() fix

configfs_unregister_subsystem() nests a pair of inode i_mutex acquisitions,
and thus needs annotation via mutex_lock_nested().

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 8a3b6a1..452cfd1 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1176,8 +1176,9 @@ void configfs_unregister_subsystem(struc
 		return;
 	}
 
-	mutex_lock(&configfs_sb->s_root->d_inode->i_mutex);
-	mutex_lock(&dentry->d_inode->i_mutex);
+	mutex_lock_nested(&configfs_sb->s_root->d_inode->i_mutex,
+			  I_MUTEX_PARENT);
+	mutex_lock_nested(&dentry->d_inode->i_mutex, I_MUTEX_CHILD);
 	if (configfs_detach_prep(dentry)) {
 		printk(KERN_ERR "configfs: Tried to unregister non-empty subsystem!\n");
 	}
