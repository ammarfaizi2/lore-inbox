Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVAYRIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVAYRIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVAYRIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:08:13 -0500
Received: from mailfe05.swip.net ([212.247.154.129]:22781 "EHLO
	mailfe05.swip.net") by vger.kernel.org with ESMTP id S262023AbVAYRGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:06:48 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: PANIC in check_process_timers() running 2.6.11-rc2-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: roland@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1106669452.705.29.camel@boxen>
References: <1106669452.705.29.camel@boxen>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 18:06:42 +0100
Message-Id: <1106672802.705.37.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Roland
> 
> Just got this running LTP-20050107 on 2.6.11-rc2-mm1, haven't looked
> further yet. Box is i386 UP with preempt, I'm putting dmesg at the 
> bottom of mail.


It's possible that the last refcount of signal->live is dropped in
do_exit and we're interrupted by the timer leaving nthreads to 0.
Takes a few tries to hit but not impossible, this fixes it for me.


Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

Index: linux-2.6.10/kernel/posix-cpu-timers.c
===================================================================
--- linux-2.6.10.orig/kernel/posix-cpu-timers.c	2005-01-25 17:40:22.000000000 +0100
+++ linux-2.6.10/kernel/posix-cpu-timers.c	2005-01-25 17:43:15.000000000 +0100
@@ -1132,6 +1132,13 @@
 		unsigned long long sched_left, sched;
 		const unsigned int nthreads = atomic_read(&sig->live);
 
+		/*
+		 * We interrupted do_exit and the refcount has dropped,
+		 * leave the task to exit
+		 */
+		if (nthreads == 0)
+			return;
+
 		prof_left = cputime_sub(prof_expires,
 					cputime_add(utime, stime)) / nthreads;
 		virt_left = cputime_sub(virt_expires, utime) / nthreads;



