Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUIJV07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUIJV07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUIJV07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:26:59 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:559
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S267893AbUIJV0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:26:43 -0400
Date: Fri, 10 Sep 2004 22:57:35 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Debian GNU/Linux m68k <debian-68k@lists.debian.org>,
       uClinux list <uclinux-dev@uclinux.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: `new' syscalls for m68k
Message-ID: <Pine.LNX.4.58.0409102250300.24607@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm updating the syscall table for m68k...

Below is a patch that adds all syscalls that m68k is currently lacking
(compared to ia32). However, I'm wondering whether we need all of them:
  - Are sys_sched_[gs]etaffinity() needed for non-SMP?
  - I disabled [sg]et_thread_area() since sys_[gs]et_thread_area() are
    missing. Do we have to implement them, or should we use some other
    method for Thread Local Storage?
  - What about sys_vserver()?
  - What about sys_kexec_load()?
  - Any others we can/should drop?

I'm CCing uclinux-dev since I'd like to bring the syscalls for m68knommu in
sync with m68k afterwards.

NOTE: This patch is _not_ to be applied yet!

Thanks for your comments!

--- linux-2.6.9-rc1/arch/m68k/kernel/entry.S	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.9-rc1/arch/m68k/kernel/entry.S	2004-09-10 21:07:03.000000000 +0200
@@ -663,3 +663,51 @@ sys_call_table:
 	.long sys_lremovexattr
 	.long sys_fremovexattr
 	.long sys_futex		/* 235 */
+	.long sys_sendfile64
+	.long sys_mincore
+	.long sys_madvise
+	.long sys_fcntl64
+	.long sys_readahead	/* 240 */
+	.long sys_sched_setaffinity
+	.long sys_sched_getaffinity
+	.long sys_ni_syscall	/* sys_set_thread_area */
+	.long sys_ni_syscall	/* sys_get_thread_area */
+	.long sys_io_setup	/* 245 */
+	.long sys_io_destroy
+	.long sys_io_getevents
+	.long sys_io_submit
+	.long sys_io_cancel
+	.long sys_fadvise64	/* 250 */
+	.long sys_exit_group
+	.long sys_lookup_dcookie
+	.long sys_epoll_create
+	.long sys_epoll_ctl
+	.long sys_epoll_wait	/* 255 */
+	.long sys_remap_file_pages
+	.long sys_set_tid_address
+	.long sys_timer_create
+	.long sys_timer_settime
+	.long sys_timer_gettime	/* 260 */
+	.long sys_timer_getoverrun
+	.long sys_timer_delete
+	.long sys_clock_settime
+	.long sys_clock_gettime
+	.long sys_clock_getres	/* 265 */
+	.long sys_clock_nanosleep
+	.long sys_statfs64
+	.long sys_fstatfs64
+	.long sys_tgkill
+	.long sys_utimes	/* 270 */
+	.long sys_fadvise64_64
+	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_mbind
+	.long sys_get_mempolicy
+	.long sys_set_mempolicy	/* 275 */
+	.long sys_mq_open
+	.long sys_mq_unlink
+	.long sys_mq_timedsend
+	.long sys_mq_timedreceive
+	.long sys_mq_notify	/* 280 */
+	.long sys_mq_getsetattr
+	.long sys_ni_syscall	/* reserved for kexec */
+
--- linux-2.6.9-rc1/include/asm-m68k/unistd.h	2004-06-16 12:50:43.000000000 +0200
+++ linux-m68k-2.6.9-rc1/include/asm-m68k/unistd.h	2004-09-10 21:05:06.000000000 +0200
@@ -238,8 +238,55 @@
 #define __NR_lremovexattr	233
 #define __NR_fremovexattr	234
 #define __NR_futex		235
+#define __NR_sendfile64		236
+#define __NR_mincore		237
+#define __NR_madvise		238
+#define __NR_fcntl64		239
+#define __NR_readahead		240
+#define __NR_sched_setaffinity	241 // Do we need this?
+#define __NR_sched_getaffinity	242 // Do we need this?
+#define __NR_set_thread_area	243 // We don't have sys_set_thread_area yet
+#define __NR_get_thread_area	244 // We don't have sys_get_thread_area yet
+#define __NR_io_setup		245
+#define __NR_io_destroy		246
+#define __NR_io_getevents	247
+#define __NR_io_submit		248
+#define __NR_io_cancel		249
+#define __NR_fadvise64		250
+#define __NR_exit_group		251
+#define __NR_lookup_dcookie	252
+#define __NR_epoll_create	253
+#define __NR_epoll_ctl		254
+#define __NR_epoll_wait		255
+#define __NR_remap_file_pages	256
+#define __NR_set_tid_address	257
+#define __NR_timer_create	258
+#define __NR_timer_settime	(__NR_timer_create+1)
+#define __NR_timer_gettime	(__NR_timer_create+2)
+#define __NR_timer_getoverrun	(__NR_timer_create+3)
+#define __NR_timer_delete	(__NR_timer_create+4)
+#define __NR_clock_settime	(__NR_timer_create+5)
+#define __NR_clock_gettime	(__NR_timer_create+6)
+#define __NR_clock_getres	(__NR_timer_create+7)
+#define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_statfs64		267
+#define __NR_fstatfs64		268
+#define __NR_tgkill		269
+#define __NR_utimes		270
+#define __NR_fadvise64_64	271
+#define __NR_vserver		272
+#define __NR_mbind		273
+#define __NR_get_mempolicy	274
+#define __NR_set_mempolicy	275
+#define __NR_mq_open		276
+#define __NR_mq_unlink		(__NR_mq_open+1)
+#define __NR_mq_timedsend	(__NR_mq_open+2)
+#define __NR_mq_timedreceive	(__NR_mq_open+3)
+#define __NR_mq_notify		(__NR_mq_open+4)
+#define __NR_mq_getsetattr	(__NR_mq_open+5)
+#define __NR_sys_kexec_load	282 // Do we need this?

-#define NR_syscalls		236
+#define NR_syscalls		283

 /* user-visible error numbers are in the range -1 - -124: see
    <asm-m68k/errno.h> */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
