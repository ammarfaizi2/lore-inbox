Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWJRD7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWJRD7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 23:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWJRD7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 23:59:43 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:46818 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751308AbWJRD7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 23:59:42 -0400
Message-ID: <4535A89E.9070609@in.ibm.com>
Date: Wed, 18 Oct 2006 09:37:58 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Issues with possible recursive locking
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I was removing dlm module,I hit in to below error.

========================================== 
[ INFO: possible recursive locking detected ]

2.6.18#1
---------------------------------------------
modprobe/4501 is trying to acquire lock:
(&inode->i_mutex){--..}, at: [<c0611e5a>] mutex_lock+0x21/0x24

but task is already holding lock:
(&inode->i_mutex){--..}, at: [<c0611e5a>] mutex_lock+0x21/0x24

other info that might help us debug this:
1 lock held by modprobe/4501:
#0:  (&inode->i_mutex){--..}, at: [<c0611e5a>] mutex_lock+0x21/0x24

stack backtrace:
[<c04051ed>] show_trace_log_lvl+0x58/0x16a
[<c04057fa>] show_trace+0xd/0x10
[<c0405913>] dump_stack+0x19/0x1b
[<c043b6f1>] __lock_acquire+0x778/0x99c
[<c043be86>] lock_acquire+0x4b/0x6d
[<c0611ceb>] __mutex_lock_slowpath+0xbc/0x20a
[<c0611e5a>] mutex_lock+0x21/0x24
[<f89c2562>] configfs_unregister_subsystem+0x3e/0xa8 [configfs]
[<f8f4263f>] dlm_config_exit+0xd/0xf [dlm]
[<f8f4db94>] exit_dlm+0x12/0x23 [dlm]
[<c0442790>] sys_delete_module+0x18d/0x1b5
[<c0403fb7>] syscall_call+0x7/0xb
===========================================================
Cause for this problem is, lock-validator validates the locks through 
lock class. And by definition,a lock in struct inode considered as one 
class, irrespective of number of of instances of different inode present 
in the system.
Hence 2 consecutive mutex lock on d_inode->i_mutex considered as 
recursive lock,eventhough both inodes are different. Thats what 
happening below. Is it not a kernel design constraint ??

==============================================
void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
{
       struct config_group *group = &subsys->su_group;
       struct dentry *dentry = group->cg_item.ci_dentry;

       if (dentry->d_parent != configfs_sb->s_root) {
               printk(KERN_ERR "configfs: Tried to unregister 
non-subsystem!\n");
               return;
       }

       mutex_lock(&configfs_sb->s_root->d_inode->i_mutex);
       mutex_lock(&dentry->d_inode->i_mutex);                         
==> problem is here
       if (configfs_detach_prep(dentry)) {
               printk(KERN_ERR "configfs: Tried to unregister non-empty
subsystem!\n");
       }
===========================================


