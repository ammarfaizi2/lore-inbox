Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbVCXEgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVCXEgC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 23:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVCXEgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 23:36:02 -0500
Received: from dahlia.cs.vt.edu ([128.173.54.76]:14730 "EHLO dahlia.cs.vt.edu")
	by vger.kernel.org with ESMTP id S263021AbVCXEfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 23:35:50 -0500
Date: Wed, 23 Mar 2005 23:35:59 -0500
From: Bharath Ramesh <bramesh@vt.edu>
To: linux-kernel@vger.kernel.org
Subject: Possible bug: ASYNC IO with RT Signals in threaded application doesnt work
Message-ID: <20050324043559.GA12615@vt.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a multithread application which uses ASYNC IO but is RT signal
driven. I have a worker thread which handles all connection and accepts
all data that are received. I use SIGRTMIN as the signal to be delivered
whenever my socket is ready with data. All my threads block SIGRTMIN
including the main thread. In the worker thread I have something like
this

while (1) {
  sigwaitinfo ();
  ...
  ...
  ...
}

I am never able dequeue SIGRTMIN from the pending signal queue from the
worker thread. If I do the above in the main thread then I am able
dequeue SIGRTMIN from the pending signal queue.

Is this a bug in the kernel or is it a feature. I am also attaching a
patch along with this email which solves the ASYNC IO problem with RT
signals.

Thanks,

Bharath

---
Bharath Ramesh       <bramesh@vt.edu>       http://csgrad.cs.vt.edu/~bramesh


--2oS5YaxWCcQjTEyO
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

--2oS5YaxWCcQjTEyO--
