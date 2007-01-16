Return-Path: <linux-kernel-owner+w=401wt.eu-S1751437AbXAPUdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXAPUdU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbXAPUdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:33:20 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:39559 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751437AbXAPUdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:33:19 -0500
Date: Tue, 16 Jan 2007 15:33:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Attribute removal patch causes lockdep warning
Message-ID: <Pine.LNX.4.44L0.0701161139450.2276-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver:

Are you aware that your patch for safe attribute file removal provokes a 
lockdep warning at bootup?

[   25.270416] =============================================
[   25.270518] [ INFO: possible recursive locking detected ]
[   25.270571] 2.6.20-rc4 #3
[   25.270619] ---------------------------------------------
[   25.270671] init/1 is trying to acquire lock:
[   25.270722]  (&sysfs_inode_imutex_key){--..}, at: [<c0293d72>] mutex_lock+0x1c/0x1f
[   25.270932] 
[   25.270934] but task is already holding lock:
[   25.271028]  (&sysfs_inode_imutex_key){--..}, at: [<c0293d72>] mutex_lock+0x1c/0x1f
[   25.271233] 
[   25.271234] other info that might help us debug this:
[   25.271330] 2 locks held by init/1:
[   25.271378]  #0:  (tty_mutex){--..}, at: [<c0293d72>] mutex_lock+0x1c/0x1f
[   25.271607]  #1:  (&sysfs_inode_imutex_key){--..}, at: [<c0293d72>] mutex_lock+0x1c/0x1f
[   25.271847] 
[   25.271848] stack backtrace:
[   25.271940]  [<c01040ce>] show_trace_log_lvl+0x1a/0x2f
[   25.272032]  [<c0104781>] show_trace+0x12/0x14
[   25.272121]  [<c0104833>] dump_stack+0x16/0x18
[   25.272208]  [<c01376b9>] __lock_acquire+0x116/0x9fd
[   25.272298]  [<c0138289>] lock_acquire+0x56/0x6f
[   25.272385]  [<c0293bc9>] __mutex_lock_slowpath+0xe5/0x272
[   25.272473]  [<c0293d72>] mutex_lock+0x1c/0x1f
[   25.272559]  [<c018e9ff>] sysfs_drop_dentry+0xb7/0x12d
[   25.272648]  [<c018eb40>] sysfs_hash_and_remove+0x8c/0x12e
[   25.272737]  [<c019080a>] sysfs_remove_link+0xb/0xd
[   25.272824]  [<c0213025>] device_del+0x96/0x1f4
[   25.272913]  [<c021318e>] device_unregister+0xb/0x15
[   25.273000]  [<c0213225>] device_destroy+0x8d/0x93
[   25.273086]  [<c01ffa60>] vcs_remove_sysfs+0x1a/0x36
[   25.273175]  [<c0204765>] con_close+0x4c/0x60
[   25.273263]  [<c01f8f72>] release_dev+0x221/0x631
[   25.273349]  [<c01f9394>] tty_release+0x12/0x1c
[   25.273435]  [<c0160b77>] __fput+0xb9/0x155
[   25.273522]  [<c0160c2a>] fput+0x17/0x19
[   25.273607]  [<c015e618>] filp_close+0x54/0x5c
[   25.273693]  [<c015f633>] sys_close+0x78/0xb0
[   25.273779]  [<c010309e>] sysenter_past_esp+0x5f/0x99
[   25.273866]  =======================

This has been the case for quite a while.  As near as I can tell, closing
a console device calls orphan_all_buffers() while holding an inode mutex.  
Since that routine acquires an inode mutex, there is a potential for
deadlock.

This isn't meant to imply that your patch is wrong.  Actually I think the 
patch is good and should be kept; it ought to be possible to resolve the 
warning by changing something else -- although I don't know what.  Do you 
see anything in the console or vc driver that could be fixed?

Alan Stern

