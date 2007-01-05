Return-Path: <linux-kernel-owner+w=401wt.eu-S1161087AbXAEPNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbXAEPNT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 10:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbXAEPNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 10:13:19 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:45909 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161087AbXAEPNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 10:13:19 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: [-mm patch] lockdep: possible deadlock in sysfs
Date: Fri, 5 Jan 2007 16:13:25 +0100
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, maneesh@in.ibm.com, oliver@neukum.name
References: <20070104220200.ae4e9a46.akpm@osdl.org> <20070105121643.GE17863@slug>
In-Reply-To: <20070105121643.GE17863@slug>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051613.25882.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. Januar 2007 13:16 schrieb Frederik Deweerdt:
> On Thu, Jan 04, 2007 at 10:02:00PM -0800, Andrew Morton wrote:
> > 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
> > 
> Hi,
> 
> Lockdep issues the following warning:
> [    9.064000] =============================================
> [    9.064000] [ INFO: possible recursive locking detected ]
> [    9.064000] 2.6.20-rc3-mm1 #3
> [    9.064000] ---------------------------------------------
> [    9.064000] init/1 is trying to acquire lock:
> [    9.064000]  (&sysfs_inode_imutex_key){--..}, at: [<c03e6afc>] mutex_lock+0x1c/0x1f
> [    9.064000]
> [    9.064000] but task is already holding lock:
> [    9.064000]  (&sysfs_inode_imutex_key){--..}, at: [<c03e6afc>] mutex_lock+0x1c/0x1f
> [    9.065000]
> [    9.065000] other info that might help us debug this:
> [    9.065000] 2 locks held by init/1:
> [    9.065000]  #0:  (tty_mutex){--..}, at: [<c03e6afc>] mutex_lock+0x1c/0x1f
> [    9.065000]  #1:  (&sysfs_inode_imutex_key){--..}, at: [<c03e6afc>] mutex_lock+0x1c/0x1f
> [    9.065000]
> [    9.065000] stack backtrace:
> [    9.065000]  [<c010390d>] show_trace_log_lvl+0x1a/0x30
> [    9.066000]  [<c0103935>] show_trace+0x12/0x14
> [    9.066000]  [<c0103a2f>] dump_stack+0x16/0x18
> [    9.066000]  [<c0138cb8>] print_deadlock_bug+0xb9/0xc3
> [    9.066000]  [<c0138d17>] check_deadlock+0x55/0x5a
> [    9.066000]  [<c013a953>] __lock_acquire+0x371/0xbf0
> [    9.066000]  [<c013b7a9>] lock_acquire+0x69/0x83
> [    9.066000]  [<c03e6b7e>] __mutex_lock_slowpath+0x75/0x2d1
> [    9.066000]  [<c03e6afc>] mutex_lock+0x1c/0x1f
> [    9.066000]  [<c01b249c>] sysfs_drop_dentry+0xb1/0x133
> [    9.066000]  [<c01b25d1>] sysfs_hash_and_remove+0xb3/0x142
> [    9.066000]  [<c01b30ed>] sysfs_remove_file+0xd/0x10
> [    9.067000]  [<c02849e0>] device_remove_file+0x23/0x2e
> [    9.067000]  [<c02850b2>] device_del+0x188/0x1e6
> [    9.067000]  [<c028511b>] device_unregister+0xb/0x15
> [    9.067000]  [<c0285318>] device_destroy+0x9c/0xa9
> [    9.067000]  [<c0261431>] vcs_remove_sysfs+0x1c/0x3b
> [    9.067000]  [<c0267a08>] con_close+0x5e/0x6b
> [    9.067000]  [<c02598f2>] release_dev+0x4c4/0x6e5
> [    9.067000]  [<c0259faa>] tty_release+0x12/0x1c
> [    9.067000]  [<c0174872>] __fput+0x177/0x1a0
> [    9.067000]  [<c01746f5>] fput+0x3b/0x41
> [    9.068000]  [<c0172ee1>] filp_close+0x36/0x65
> [    9.068000]  [<c0172f73>] sys_close+0x63/0xa4
> [    9.068000]  [<c0102a96>] sysenter_past_esp+0x5f/0x99
> [    9.068000]  =======================
> 
> This is due to sysfs_hash_and_remove() holding dir->d_inode->i_mutex
> before calling sysfs_drop_dentry() which calls orphan_all_buffers()
> which in turn takes node->i_mutex.
> The following patch solves the problem by defering the buffers orphaning
> after the dir->d_inode->imutex is released. Not sure it's the best
> solution though, better wait for feedback from Maneesh and Oliver.

Hi,

are you sure there's a code path that takes these locks in the reverse order?
I've looked through the code twice and not found any. It doesn't make much
sense to first lock the file and afterwards the directory.

Regarding your patch, it should work, but I don't see the need for it.

	Regards
		Oliver
