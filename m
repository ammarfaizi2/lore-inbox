Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760640AbWLFOXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760640AbWLFOXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760645AbWLFOXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:23:14 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:39109 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760640AbWLFOXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:23:14 -0500
Message-id: <762111721879732035@fi.muni.cz>
In-reply-to: <1165363148-XGI7ZY4B0EPYUYH@www.vabmail.com>
Subject: [PATCH 1/1] Char: isicom, fix card locking
From: Jiri Slaby <jirislaby@gmail.com>
To: Eric Fox <efox@einsteinindustries.com>
Cc: <linux-kernel@vger.kernel.org>
Date: Wed,  6 Dec 2006 15:23:08 +0100 (CET)
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Fox wrote:
> Here is what i was able to capture from a terminal logged in to the machine
> with the ISI board:
> 
> strace setserial -g /dev/ttyM0
> execve("/bin/setserial", ["setserial", "-g", "/dev/ttyM0"], [/* 17 vars
> */]) = 0
> uname({sys="Linux", node="dialin-0.vab.com", ...}) = 0
> brk(0)                                  = 0x804d000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
> directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=19713, ...}) = 0
> old_mmap(NULL, 19713, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f05000
> close(3)                                = 0
> open("/lib/tls/libc.so.6", O_RDONLY)    = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\36"..., 512) =
> 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=1454802, ...}) = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7f04000
> old_mmap(0x39d000, 1223900, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
> 3, 0) = 0x39d000
> old_mmap(0x4c2000, 16384, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x124000) = 0x4c2000
> old_mmap(0x4c6000, 7388, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4c6000
> close(3)                                = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7f03000
> mprotect(0x4c2000, 4096, PROT_READ)     = 0
> mprotect(0x399000, 4096, PROT_READ)     = 0
> set_thread_area({entry_number:-1 -> 6, base_addr:0xb7f036c0, limit:1048575,
> seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, useable:1}) = 0
> munmap(0xb7f05000, 19713)               = 0
> open("/dev/ttyM0", O_RDWR|O_NONBLOCK
> 
> 
> And, here is what I captured using minicom from another machine connected
> to the serial port console of the machine with the ISI board (minicom.cap):
> 
> strace setserial -g /dev/ttyM0
> execve("/bin/setserial", ["setserial", "-g", "/dev/ttyM0"], [/* 17 vars
> */]) = 0
> uname({sys="Linux", node="dialin-0.vab.com", ...BUG: soft lockup detected
> on CPU#1!
>  [<c01041a3>] dump_trace+0x6b/0x1ab
>  [<c010436a>] show_trace_log_lvl+0x17/0x2b
>  [<c037ddb1>] __func__.5+0x84c/0x497af
> DWARF2 unwinder stuck at __func__.5+0x84c/0x497af
> 
> Leftover inexact backtrace:
> 
>  [<c010438d>] show_trace+0xf/0x11
>  [<c010446c>] dump_stack+0x13/0x15
>  [<c0138dca>] softlockup_tick+0xa1/0xaf
>  [<c0124bc2>] update_process_times+0x39/0x5c
>  [<c0111219>] smp_apic_timer_interrupt+0x8a/0xa2
>  [<c0103f0b>] apic_timer_interrupt+0x1f/0x24
>  [<c0365437>] _spin_lock_irqsave+0x16/0x27
>  [<f882407e>] lock_card_at_interrupt+0x17/0x47 [isicom]
>  [<f88241ca>] isicom_tx+0x64/0xe9 [isicom]
>  [<f8824166>] isicom_tx+0x0/0xe9 [isicom]
>  [<c0124d00>] run_timer_softirq+0x112/0x15c
>  [<c0120bd1>] __do_softirq+0x5e/0xba
>  [<c0120c5b>] do_softirq+0x2e/0x32
>  [<c011121e>] smp_apic_timer_interrupt+0x8f/0xa2
>  [<c0103f0b>] apic_timer_interrupt+0x1f/0x24
>  [<c0101973>] mwait_idle_with_hints+0x34/0x38
>  [<c0101983>] mwait_idle+0xc/0x1b
>  [<c010183f>] cpu_idle+0x66/0x7b
>  =======================
> BUG: soft lockup detected on CPU#1!
>  [<c01041a3>] dump_trace+0x6b/0x1ab
>  [<c010436a>] show_trace_log_lvl+0x17/0x2b
>  [<c037ddb1>] __func__.5+0x84c/0x497af
> DWARF2 unwinder stuck at __func__.5+0x84c/0x497af
> 
> 
> Hope some of this will help.

Certainly, it did, could you test the attached patch?

--
isicom, fix card locking

Somebody omitted spin_unlock in interrupt handler and hence card causes
dead-lock. Add two unlocks, before returning from handler, if the lock was
acquired before.
Thanks Eric Fox <efox@einsteinindustries.com> for pointing this out.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 09a4c63d32367a615fc42a2e8455e5fd37f9c3ed
tree 2c2a050cbc551021d09a581d5cc16fd6a7934c69
parent e62438630ca37539c8cc1553710bbfaa3cf960a7
author Jiri Slaby <jirislaby@gmail.com> Wed, 06 Dec 2006 15:13:18 +0100
committer Jiri Slaby <jirislaby@gmail.com> Wed, 06 Dec 2006 15:18:43 +0100

 drivers/char/isicom.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 58c955e..c55b359 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -592,6 +592,7 @@ static irqreturn_t isicom_interrupt(int 
 			ClearInterrupt(base);
 		else
 			outw(0x0000, base+0x04); /* enable interrupts */
+		spin_unlock(&card->card_lock);
 		return IRQ_HANDLED;
 	}
 
@@ -712,6 +713,7 @@ static irqreturn_t isicom_interrupt(int 
 		ClearInterrupt(base);
 	else
 		outw(0x0000, base+0x04); /* enable interrupts */
+	spin_unlock(&card->card_lock);
 
 	return IRQ_HANDLED;
 }
