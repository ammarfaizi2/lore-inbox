Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVCVWVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVCVWVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVCVWUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:20:55 -0500
Received: from dahlia.cs.vt.edu ([128.173.54.76]:35968 "EHLO dahlia.cs.vt.edu")
	by vger.kernel.org with ESMTP id S262120AbVCVWS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:18:28 -0500
Date: Tue, 22 Mar 2005 17:18:27 -0500
From: Bharath Ramesh <bramesh@vt.edu>
To: linux-kernel@vger.kernel.org
Subject: ASYNC IO using RT Signals
Message-ID: <20050322221827.GA3766@vt.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A question on sigwaitinfo based IO mechanism in multithreaded
applications.

I am trying to use RT signals to notify me of IO events using RT signals
instead of SIGIO in a multithreaded applications. I noticed that there
was some discussion on lkml during november 1999 with the subject of the
discussion as "Signal driven IO". In the thread I noticed that RT
signals were being delivered to the worker thread. I am running 2.6.10
kernel and I am trying to use the very same mechanism and I find that
only SIGIO being propogated to the worker threads and RT signals only
being propogated to the main thread and not the worker threads where I
actually want them to be propogated too. On further inspection I found
that the following patch which I have attached solves the problem.

I am not sure if this is a bug or feature in the kernel.

Thanks,

Bharath

---
Bharath Ramesh       <bramesh@vt.edu>       http://csgrad.cs.vt.edu/~bramesh


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- linux-2.6.10/fs/fcntl.c.orig	2004-12-24 16:35:01.000000000 -0500
+++ linux-2.6.10/fs/fcntl.c	2005-03-22 14:30:14.298415152 -0500
@@ -469,7 +469,7 @@ static void send_sigio_to_task(struct ta
 			else
 				si.si_band = band_table[reason - POLL_IN];
 			si.si_fd    = fd;
-			if (!send_sig_info(fown->signum, &si, p))
+			if (!send_group_sig_info(fown->signum, &si, p))
 				break;
 		/* fall-through: fall back on the old plain SIGIO signal */
 		case 0:

--tKW2IUtsqtDRztdT--
