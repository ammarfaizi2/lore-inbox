Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWHMOcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWHMOcF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 10:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWHMOcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 10:32:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:20869 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751265AbWHMOcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 10:32:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Rs14fTKCho/Faq7SQTcOnP8ZpNKt8UgiP0q4fV6FI8RTZ3J1WlSlSCwyIH4WSudfqLR9ZsCyW2JDqgEAiuT5hyAJirdiAfKGdyyTQANqN94w+LZGvN/IqBSZW7Wv/V4aSQFmNiLsGnmRpON8uw4p7xklRaSYzpmcW4owVZGANOU=
Date: Sun, 13 Aug 2006 16:32:00 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, toyoa@mvista.com
Subject: [patch] fix posix timer errors
Message-ID: <20060813143200.GA2779@slug>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
Hi,

posix-timers-fix-clock_nanosleep-doesnt-return-the-remaining-time-in-compatibility-mode.patch
declares two functions with the wrong return type.

Also, posix-timers-fix-the-flags-handling-in-posix_cpu_nsleep.patch uses
'=' instead of '=='.

The attached patch fix both issues.

Regards,
Frederik



diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
index 1fc1ea2..479b16b 100644
--- a/kernel/posix-cpu-timers.c
+++ b/kernel/posix-cpu-timers.c
@@ -1477,7 +1477,7 @@ int posix_cpu_nsleep(const clockid_t whi
 
 	error = do_cpu_nanosleep(which_clock, flags, rqtp, &it);
 
-	if (error = -ERESTART_RESTARTBLOCK) {
+	if (error == -ERESTART_RESTARTBLOCK) {
 
 	       	if (flags & TIMER_ABSTIME)
 			return -ERESTARTNOHAND;
@@ -1511,7 +1511,7 @@ long posix_cpu_nsleep_restart(struct res
 	restart_block->fn = do_no_restart_syscall;
 	error = do_cpu_nanosleep(which_clock, TIMER_ABSTIME, &t, &it);
 
-	if (error = -ERESTART_RESTARTBLOCK) {
+	if (error == -ERESTART_RESTARTBLOCK) {
 		/*
 	 	 * Report back to the user the time still remaining.
 	 	 */
@@ -1553,7 +1553,7 @@ static int process_cpu_nsleep(const cloc
 {
 	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp, rmtp);
 }
-static int process_cpu_nsleep_restart(struct restart_block *restart_block)
+static long process_cpu_nsleep_restart(struct restart_block *restart_block)
 {
 	return -EINVAL;
 }
@@ -1577,7 +1577,7 @@ static int thread_cpu_nsleep(const clock
 {
 	return -EINVAL;
 }
-static int thread_cpu_nsleep_restart(struct restart_block *restart_block)
+static long thread_cpu_nsleep_restart(struct restart_block *restart_block)
 {
 	return -EINVAL;
 }
