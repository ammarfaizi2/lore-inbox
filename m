Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161721AbWKFJLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161721AbWKFJLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 04:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWKFJLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 04:11:48 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:40440 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161730AbWKFJLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 04:11:47 -0500
Message-ID: <454EFDD8.4020608@in.ibm.com>
Date: Mon, 06 Nov 2006 14:48:16 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Tilman Schmidt <tilman@imap.cc>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, edward@namesys.com,
       reiserfs-dev@namesys.com, apw@shadowen.com
Subject: [PATCH] Re:[2.6.19-rc4] "possible recursive locking detected" in
 reiserfs_xattr_set
References: <454B6A64.1000107@imap.cc>
In-Reply-To: <454B6A64.1000107@imap.cc>
Content-Type: multipart/mixed;
 boundary="------------080604060805090505090801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080604060805090505090801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tilman Schmidt wrote:
> JFTR, these messages still appear with 2.6.19-rc4:
>
> Nov  3 11:08:05 gx110 kernel: [ 1025.512025]
> Nov  3 11:08:05 gx110 kernel: [ 1025.512031] =============================================
> Nov  3 11:08:05 gx110 kernel: [ 1025.512053] [ INFO: possible recursive locking detected ]
> Nov  3 11:08:05 gx110 kernel: [ 1025.512064] 2.6.19-rc4-noinitrd #1
> Nov  3 11:08:05 gx110 kernel: [ 1025.512071] ---------------------------------------------
> Nov  3 11:08:05 gx110 kernel: [ 1025.512080] kdm/3234 is trying to acquire lock:
> Nov  3 11:08:05 gx110 kernel: [ 1025.512089]  (&inode->i_mutex){--..}, at: [<c035aced>] mutex_lock+0x1c/0x1f
> Nov  3 11:08:05 gx110 kernel: [ 1025.512124]
> Nov  3 11:08:05 gx110 kernel: [ 1025.512126] but task is already holding lock:
> Nov  3 11:08:05 gx110 kernel: [ 1025.512134]  (&inode->i_mutex){--..}, at: [<c035aced>] mutex_lock+0x1c/0x1f
> Nov  3 11:08:05 gx110 kernel: [ 1025.512152]
> Nov  3 11:08:05 gx110 kernel: [ 1025.512155] other info that might help us debug this:
> Nov  3 11:08:05 gx110 kernel: [ 1025.512165] 3 locks held by kdm/3234:
> Nov  3 11:08:05 gx110 kernel: [ 1025.512172]  #0:  (&inode->i_mutex){--..}, at: [<c035aced>] mutex_lock+0x1c/0x1f
> Nov  3 11:08:05 gx110 kernel: [ 1025.512192]  #1:  (&REISERFS_I(inode)->xattr_sem){----}, at: [<c01c3951>] reiserfs_acl_chmod+0xe1/0x180
> Nov  3 11:08:05 gx110 kernel: [ 1025.512234]  #2:  (&REISERFS_SB(s)->xattr_dir_sem){----}, at: [<c01c3986>] reiserfs_acl_chmod+0x116/0x180
> Nov  3 11:08:05 gx110 kernel: [ 1025.512257]
> Nov  3 11:08:05 gx110 kernel: [ 1025.512260] stack backtrace:
> Nov  3 11:08:05 gx110 kernel: [ 1025.512274]  [<c0103dc4>] dump_trace+0x64/0x1cc
> Nov  3 11:08:05 gx110 kernel: [ 1025.512300]  [<c0103f45>] show_trace_log_lvl+0x19/0x2e
> Nov  3 11:08:05 gx110 kernel: [ 1025.512317]  [<c01042a2>] show_trace+0x12/0x14
> Nov  3 11:08:05 gx110 kernel: [ 1025.512334]  [<c01042bb>] dump_stack+0x17/0x19
> Nov  3 11:08:05 gx110 kernel: [ 1025.512348]  [<c012fdd9>] __lock_acquire+0x106/0x99c
> Nov  3 11:08:05 gx110 kernel: [ 1025.512373]  [<c0130930>] lock_acquire+0x5b/0x7b
> Nov  3 11:08:05 gx110 kernel: [ 1025.512457]  [<c035ab5d>] __mutex_lock_slowpath+0xc6/0x23a
> Nov  3 11:08:05 gx110 kernel: [ 1025.512482]  [<c035aced>] mutex_lock+0x1c/0x1f
> Nov  3 11:08:05 gx110 kernel: [ 1025.512504]  [<c01c29c5>] reiserfs_xattr_set+0xe4/0x2bf
> Nov  3 11:08:05 gx110 kernel: [ 1025.512529]  [<c01c33ef>] reiserfs_set_acl+0x18d/0x204
> Nov  3 11:08:05 gx110 kernel: [ 1025.512553]  [<c01c3994>] reiserfs_acl_chmod+0x124/0x180
> Nov  3 11:08:05 gx110 kernel: [ 1025.512577]  [<c01a3c41>] reiserfs_setattr+0x20b/0x243
> Nov  3 11:08:05 gx110 kernel: [ 1025.512608]  [<c017395b>] notify_change+0x135/0x2c2
> Nov  3 11:08:05 gx110 kernel: [ 1025.512645]  [<c015fbba>] sys_fchmodat+0xa0/0xca
> Nov  3 11:08:05 gx110 kernel: [ 1025.512670]  [<c015fc05>] sys_chmod+0x21/0x23
> Nov  3 11:08:05 gx110 kernel: [ 1025.512691]  [<c0102dfd>] sysenter_past_esp+0x56/0x8d
> Nov  3 11:08:05 gx110 kernel: [ 1025.512718] DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> Nov  3 11:08:05 gx110 kernel: [ 1025.512733]
> Nov  3 11:08:05 gx110 kernel: [ 1025.512746] Leftover inexact backtrace:
> Nov  3 11:08:05 gx110 kernel: [ 1025.512750]
> Nov  3 11:08:05 gx110 kernel: [ 1025.512771]  =======================
>
> The message appears when the first KDE session is started.
>
>   
This patch should solve your problem. Please let me know your comments 
for this patch.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>





--------------080604060805090505090801
Content-Type: text/plain;
 name="reiserfs.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs.fix"

 open.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19-rc4/fs/open.c
===================================================================
--- linux-2.6.19-rc4.orig/fs/open.c	2006-10-31 09:07:36.000000000 +0530
+++ linux-2.6.19-rc4/fs/open.c	2006-11-06 14:28:19.000000000 +0530
@@ -549,7 +549,7 @@
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto dput_and_out;
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_PARENT);
 	if (mode == (mode_t) -1)
 		mode = inode->i_mode;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);

--------------080604060805090505090801--
