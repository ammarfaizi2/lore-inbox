Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVCPOEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVCPOEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVCPOEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:04:35 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:56228 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262592AbVCPOET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:04:19 -0500
Date: Wed, 16 Mar 2005 09:04:06 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
In-Reply-To: <20050316031909.08e6cab7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu>
 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu>
 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu>
 <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu>
 <20050316020408.434cc620.akpm@osdl.org> <20050316101906.GA17328@elte.hu>
 <20050316024022.6d5c4706.akpm@osdl.org> <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
 <20050316031909.08e6cab7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Mar 2005, Andrew Morton wrote:

>
> > But
> > when I made jbd_lock_bh_state a global lock, I believe it deadlocked on
> > me.
>
> That's a worry.
>

OK, I'm wrong here. I just tried it again and it didn't deadlock (that
must have been another lock I was dealing with).  But it does test if the
buffer head is locked or not, and asserts if it is. I'm running the
following patch with on problems so far. I still use the lock bits to
determine if the bh state is locked.

Do you and Ingo think that this would have too much contention.

Ingo, I still get the following bug because of the added BUFFER_FNS and
DESKTOP_PREEMPT.  I haven't tried this with RT yet. I'll see if this shows
a deadlock there.


BUG: Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c0214888
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ipv6 af_packet tsdev mousedev evdev floppy psmouse
pcspkr snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd soundcore snd_page_alloc shpchp pci_hotplug ehci_hcd
intel_agp agpgart uhci_hcd usbcore e100 mii ide_cd cdrom unix
CPU:    0
EIP:    0060:[<c0214888>]    Not tainted VLI
EFLAGS: 00010286   (2.6.11-RT-V0.7.40-00)
EIP is at vt_ioctl+0x18/0x1ab0
eax: 00000000   ebx: 00005603   ecx: 00005603   edx: cec18c80
esi: c0214870   edi: cb49e000   ebp: cb479f18   esp: cb479e48
ds: 007b   es: 007b   ss: 0068   preempt: 00000000
Process XFree86 (pid: 4744, threadinfo=cb478000 task=cb403530)
Stack: cb403680 cb478000 cb403530 c034594c cb403530 00000246 cb479e7c
c0117217
       c0345954 00000006 00000001 00000000 00000000 cb479ebc cefa1c04
c13e1000
       ced6b9b8 00000000 00000000 cb479ed4 c01707f1 ced6b9b8 00000007
00000000
Call Trace:
 [<c0103cdf>] show_stack+0x7f/0xa0 (28)
 [<c0103e95>] show_registers+0x165/0x1d0 (56)
 [<c0104088>] die+0xc8/0x150 (64)
 [<c0115376>] do_page_fault+0x356/0x6c4 (216)
 [<c0103973>] error_code+0x2b/0x30 (268)
 [<c020fd6b>] tty_ioctl+0x34b/0x490 (52)
 [<c016837f>] do_ioctl+0x4f/0x70 (32)
 [<c0168582>] vfs_ioctl+0x62/0x1d0 (40)
 [<c0168751>] sys_ioctl+0x61/0x90 (40)
 [<c0102ec3>] syscall_call+0x7/0xb (-8124)
Code: ff ff 8d 05 88 5d 34 c0 e8 f6 60 0a 00 e9 3a ff ff ff 90 55 89 e5 57
56 53 81 ec c4 00 00 00 8b 7d 08 8b 5d 10 8b 87 7c 09 00 00 <8b> 30 89 34
24 8b 04 b5 e0 b7 3c c0 89 45 8c e8 a4 6a 00 00 85




Here's the patch (on Ingo's -40 kernel).

diff -ur linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/journal.c linux-2.6.11-final-V0.7.40-00/fs/jbd/journal.c
--- linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/journal.c	2005-03-02 02:37:49.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/fs/jbd/journal.c	2005-03-16 07:47:50.000000000 -0500
@@ -82,6 +82,9 @@

 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);

+spinlock_t jbd_state_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t jbd_journal_lock = SPIN_LOCK_UNLOCKED;
+
 /*
  * Helper function used to manage commit timeouts
  */
diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h	2005-03-02 02:38:19.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h	2005-03-16 08:51:27.292105187 -0500
@@ -313,6 +313,8 @@
 BUFFER_FNS(RevokeValid, revokevalid)
 TAS_BUFFER_FNS(RevokeValid, revokevalid)
 BUFFER_FNS(Freed, freed)
+BUFFER_FNS(State,state)
+BUFFER_FNS(JournalHead,journal)

 static inline struct buffer_head *jh2bh(struct journal_head *jh)
 {
@@ -324,34 +326,50 @@
 	return bh->b_private;
 }

+extern spinlock_t jbd_state_lock;
+extern spinlock_t jbd_journal_lock;
+
 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_State, &bh->b_state);
+	spin_lock(&jbd_state_lock);
+	BUG_ON(buffer_state(bh));
+	set_buffer_state(bh);
 }

 static inline int jbd_trylock_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_trylock(BH_State, &bh->b_state);
+	if (spin_trylock(&jbd_state_lock)) {
+		BUG_ON(buffer_state(bh));
+		set_buffer_state(bh);
+		return 1;
+	}
+	return 0;
 }

 static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_is_locked(BH_State, &bh->b_state);
+	return buffer_state(bh); //spin_is_locked(&jbd_state_lock);
 }

 static inline void jbd_unlock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_State, &bh->b_state);
+	BUG_ON(!buffer_state(bh));
+	clear_buffer_state(bh);
+	spin_unlock(&jbd_state_lock);
 }

 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_JournalHead, &bh->b_state);
+	spin_lock(&jbd_journal_lock);
+	BUG_ON(buffer_journal(bh));
+	set_buffer_journal(bh);
 }

 static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_JournalHead, &bh->b_state);
+	BUG_ON(!buffer_journal(bh));
+	clear_buffer_journal(bh);
+	spin_unlock(&jbd_journal_lock);
 }

 struct jbd_revoke_table_s;
