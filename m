Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWGDPNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWGDPNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWGDPNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:13:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62345 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932209AbWGDPNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:13:38 -0400
Subject: Re: [BUG] scsi/io-elevator held lock freed.
From: Arjan van de Ven <arjan@infradead.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <1152024854.29262.5.camel@c-67-180-134-207.hsd1.ca.comcast.net>
References: <1152024854.29262.5.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 17:13:30 +0200
Message-Id: <1152026010.3109.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 07:54 -0700, Daniel Walker wrote:
> I got this during boot. I booted the same kernel several times, and only
> saw it once. The kernel was 2.6.17-mm5 .
> 
> Daniel
> 
> 
> =========================
> [ BUG: held lock freed! ]
> -------------------------
> swapper/1 is freeing memory f73a8580-f73a867f, with a lock still held there!
> 2 locks held by swapper/1:
>  #0:  (&shost->scan_mutex){--..}, at: [<c0419098>] mutex_lock+0x8/0x10
>  #1:  (&eq->sysfs_lock){--..}, at: [<c0419098>] mutex_lock+0x8/0x10

blargh.. it'd be more useful if lockdep actually printed which lock it
is that it thinks is about to get freed.....

this patch ought to make it do that; could you at least add this to your
kernel?

Ingo, is this the right approach?

---
 kernel/lockdep.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.17-mm6/kernel/lockdep.c
===================================================================
--- linux-2.6.17-mm6.orig/kernel/lockdep.c
+++ linux-2.6.17-mm6/kernel/lockdep.c
@@ -2571,7 +2571,7 @@ static inline int in_range(const void *s
 
 static void
 print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
-		     const void *mem_to)
+		     const void *mem_to, struct held_lock *hlock)
 {
 	if (!debug_locks_off())
 		return;
@@ -2583,6 +2583,7 @@ print_freed_lock_bug(struct task_struct 
 	printk(  "-------------------------\n");
 	printk("%s/%d is freeing memory %p-%p, with a lock still held there!\n",
 		curr->comm, curr->pid, mem_from, mem_to-1);
+	print_lock(hlock);
 	lockdep_print_held_locks(curr);
 
 	printk("\nstack backtrace:\n");
@@ -2616,7 +2617,7 @@ void debug_check_no_locks_freed(const vo
 					!in_range(mem_from, lock_to, mem_to))
 			continue;
 
-		print_freed_lock_bug(curr, mem_from, mem_to);
+		print_freed_lock_bug(curr, mem_from, mem_to, hlock);
 		break;
 	}
 	local_irq_restore(flags);


