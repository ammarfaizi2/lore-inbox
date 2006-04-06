Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWDFOI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWDFOI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 10:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWDFOI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 10:08:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:52869 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932096AbWDFOIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 10:08:55 -0400
Date: Thu, 6 Apr 2006 19:35:46 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: NeilBrown <neilb@suse.de>, "Andrew Morton" <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Jan Blunck" <jblunck@suse.de>,
       "Kirill Korotaev" <dev@openvz.org>, olh@suse.de
Subject: [PATCH 2.6.17-rc1-mm1] BUG due to freed dentry in dcache race fix
Message-ID: <20060406140546.GA29036@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060403133804.27986.patches@notabene> <1060403034001.28030@suse.de> <661de9470604031112j3bf81a21r7066c67f62f1de63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661de9470604031112j3bf81a21r7066c67f62f1de63@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

Please apply this patch on top of

fix-dcache-race-during-umount.patch

we need to save a reference to the s_umount read write semaphore. The dentry
can be freed by prune_one_dentry(). Dereferencing dentry->d_sb->s_umount is
not safe after that point.

I hit an Oops while running 2.6.17-rc1-mm1

DMA free:3584kB min:68kB low:84kB high:100kB active:10448kB inactive:0kB presentOops: 0002 [#1]
PREEMPT SMP
last sysfs file: /devices/pci0000:00/0000:00:0a.0/power/state
Modules linked in: loop dm_mod ide_cd cdrom ohci_hcd usbcore serverworks generii
CPU:    1
EIP:    0060:[<c10824f1>]    Not tainted VLI
EFLAGS: 00010212   (2.6.17-rc1-mm1cpum #2)
EIP is at prune_dcache+0x91/0x1d0
eax: 6b6b6ba7   ebx: e45918e0   ecx: 00000001   edx: ffffffff
esi: e45918e8   edi: 00000058   ebp: e4cfcbe0   esp: e4cfcbbc
ds: 007b   es: 007b   ss: 0068
Process hackbench (pid: 11183, threadinfo=e4cfc000 task=e4d076b0)
Stack: <0>c12fb400 e4cfcbd0 c122f5ed c2288504 00000000 00000000 0000283c 000a0f
       c2259404 e4cfcbe8 c108266e e4cfcc28 c104fe9b 00000080 000000d0 0000000b
       00000021 00000000 e4cfc000 00000000 0000008c e4cfc000 00000080 00004db7
Call Trace:
 <c1003f9d> show_stack_log_lvl+0xad/0xe0   <c10041e7> show_registers+0x1c7/0x250
 <c10043aa> die+0x13a/0x330   <c1230f50> do_page_fault+0x2d0/0x750
 <c1003987> error_code+0x4f/0x54   <c108266e> shrink_dcache_memory+0x3e/0x50
 <c104fe9b> shrink_slab+0x17b/0x240   <c105077f> try_to_free_pages+0x1bf/0x2b0
 <c104b466> __alloc_pages+0x136/0x310   <c10635fc> cache_alloc_refill+0x40c/0x70
 <c1063b86> __kmalloc_track_caller+0xc6/0xf0   <c11d922f> __alloc_skb+0x5f/0x110
 <c11d5247> sock_alloc_send_skb+0x1a7/0x200   <c1227a2d> unix_stream_sendmsg+0x0
 <c11d1bb4> do_sock_write+0xb4/0xc0   <c11d2367> sock_aio_write+0x67/0x70
 <c1067809> do_sync_write+0xb9/0xf0   <c10682f1> vfs_write+0x181/0x190
 <c1068a07> sys_write+0x47/0x70   <c122f93f> sysenter_past_esp+0x54/0x75
Code: 0a 75 f3 85 c0 0f 88 fe 00 00 00 8b 4b 60 8b 41 38 85 c0 0f 84 de 00 00 0

Thanks,
Balbir

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 fs/dcache.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN fs/dcache.c~dcache_race_umount_sem_fix fs/dcache.c
--- linux-2.6.17/fs/dcache.c~dcache_race_umount_sem_fix	2006-04-06 17:11:41.000000000 +0530
+++ linux-2.6.17-balbir/fs/dcache.c	2006-04-06 17:17:02.000000000 +0530
@@ -464,9 +464,14 @@ static void prune_dcache(int count, stru
 		 * So we try to get s_umount, and make sure s_root isn't NULL
 		 */
 		if (down_read_trylock(&dentry->d_sb->s_umount)) {
+			/*
+			 * Save the semaphore reference, prune_one_dentry() can
+			 * free the dentry
+			 */
+			struct rw_semaphore *umnt_sem = &dentry->d_sb->s_umount;
 			if (dentry->d_sb->s_root != NULL) {
 				prune_one_dentry(dentry);
-				up_read(&dentry->d_sb->s_umount);
+				up_read(umnt_sem);
 				continue;
 			}
 			up_read(&dentry->d_sb->s_umount);
_
