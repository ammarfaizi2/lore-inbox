Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVDLS6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVDLS6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVDLStU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:49:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:9418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262231AbVDLKcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:53 -0400
Message-Id: <200504121032.j3CAWbRa005637@shell0.pdx.osdl.net>
Subject: [patch 125/198] AYSNC IO using singals other than SIGIO
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, bramesh@vt.edu,
       roland@redhat.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bharath Ramesh <bramesh@vt.edu>

A question on sigwaitinfo based IO mechanism in multithreaded applications.

I am trying to use RT signals to notify me of IO events using RT signals
instead of SIGIO in a multithreaded applications.  I noticed that there was
some discussion on lkml during november 1999 with the subject of the
discussion as "Signal driven IO".  In the thread I noticed that RT signals
were being delivered to the worker thread.  I am running 2.6.10 kernel and
I am trying to use the very same mechanism and I find that only SIGIO being
propogated to the worker threads and RT signals only being propogated to
the main thread and not the worker threads where I actually want them to be
propogated too.  On further inspection I found that the following patch
which I have attached solves the problem.

I am not sure if this is a bug or feature in the kernel.


Roland McGrath <roland@redhat.com> said:

This relates only to fcntl F_SETSIG, which is a Linux extension.  So there is
no POSIX issue.  When changing various things like the normal SIGIO signalling
to do group signals, I was concerned strictly with the POSIX semantics and
generally avoided touching things in the domain of Linux inventions.  That's
why I didn't change this when I changed the call right next to it.  There is
no reason I can see that F_SETSIG-requested signals shouldn't use a group
signal like normal SIGIO does.  I'm happy to ACK this patch, there is nothing
wrong with its change to the semantics in my book.  But neither POSIX nor I
care a whit what F_SETSIG does.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/fcntl.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/fcntl.c~async-io-using-rt-signals fs/fcntl.c
--- 25/fs/fcntl.c~async-io-using-rt-signals	2005-04-12 03:21:33.611027248 -0700
+++ 25-akpm/fs/fcntl.c	2005-04-12 03:21:33.614026792 -0700
@@ -437,7 +437,7 @@ static void send_sigio_to_task(struct ta
 			else
 				si.si_band = band_table[reason - POLL_IN];
 			si.si_fd    = fd;
-			if (!send_sig_info(fown->signum, &si, p))
+			if (!send_group_sig_info(fown->signum, &si, p))
 				break;
 		/* fall-through: fall back on the old plain SIGIO signal */
 		case 0:
_
