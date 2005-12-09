Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVLITjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVLITjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVLITjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:39:03 -0500
Received: from [82.138.41.32] ([82.138.41.32]:40617 "EHLO foo.vault.bofh.ru")
	by vger.kernel.org with ESMTP id S932419AbVLITjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:39:02 -0500
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
To: Ingo Molnar <mingo@elte.hu>
Subject: [RT] fix delay in do_vgettimeofday() in arch/x86_64/kernel/vsyscall.c
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 09 Dec 2005 22:38:53 +0300
Message-ID: <87d5k6ukky.fsf@foo.vault.bofh.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There are occasional very very long (30..60 sec) delays happening when calling
gettimeofday() vsyscall on x86_64 with 2.6.14-rt22 kernel.

These delays come from while() looping over invalid data that are
going to be discarded by seqlock.



 arch/x86_64/kernel/vsyscall.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -111,14 +111,15 @@ static force_inline void do_vgettimeofda
 
 		/* add nsec offset to wall_time_tv */
 		*tv = __vsyscall_gtod_data.wall_time_tv;
-		do_div(nsec_delta, NSEC_PER_USEC);
-		tv->tv_usec += (unsigned long) nsec_delta;
-
-		while (tv->tv_usec > USEC_PER_SEC) {
-			tv->tv_sec += 1;
-			tv->tv_usec -= USEC_PER_SEC;
-		}
 	} while (read_seqretry(&__vsyscall_gtod_lock, seq));
+
+	do_div(nsec_delta, NSEC_PER_USEC);
+	tv->tv_usec += (unsigned long) nsec_delta;
+
+	while (tv->tv_usec > USEC_PER_SEC) {
+		tv->tv_sec += 1;
+		tv->tv_usec -= USEC_PER_SEC;
+	}
 }
 
 /*
