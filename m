Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266499AbUHBNLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUHBNLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUHBNLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:11:15 -0400
Received: from mail.jambit.com ([62.245.207.83]:41735 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S266499AbUHBNKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:10:52 -0400
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: akpm@osdl.org
Date: Mon, 02 Aug 2004 15:10:43 +0200
MIME-Version: 1.0
Subject: Off by one error for SIGXCPURLMIC_CPU checking
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, michael.kerrisk@gmx.net
Message-ID: <410E5973.9054.18DDCD2@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

There is a lonstanding off-by-one error that results from an incorrect 
comparison when checking whether a process has consumed CPU time in 
excess of its RLIMIT_CPU limits.  

This means, for example, that if we use setrlimit() to set the soft CPU 
limit (rlim_cur) to 5 seconds and the hard limit (rlim_max) to 10 seconds, 

then the process only receives a SIGXCPU signal after consuming 6 seconds 
of CPU time, and, if it continues consuming CPU after handling that 
signal, only receives SIGKILL after consuming 11 seconds of CPU time.

The fix is trivial, and included below.

Cheers,

Michael


--- /spare/KERNEL/linux-2.6.7/kernel/timer.c	2004-06-16 07:19:52.000000000 
+0200
+++ /spare/KERNEL/linux-2.6.7-xcpu/kernel/timer.c	2004-08-02 
09:34:10.000000000 +0200
@@ -792,12 +792,12 @@
 
 	psecs = (p->utime += user);
 	psecs += (p->stime += system);
-	if (psecs / HZ > p->rlim[RLIMIT_CPU].rlim_cur) {
+	if (psecs / HZ >= p->rlim[RLIMIT_CPU].rlim_cur) {
 		/* Send SIGXCPU every second.. */
 		if (!(psecs % HZ))
 			send_sig(SIGXCPU, p, 1);
 		/* and SIGKILL when we go over max.. */
-		if (psecs / HZ > p->rlim[RLIMIT_CPU].rlim_max)
+		if (psecs / HZ >= p->rlim[RLIMIT_CPU].rlim_max)
 			send_sig(SIGKILL, p, 1);
 	}
 }

