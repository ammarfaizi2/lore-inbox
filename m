Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTBEQkG>; Wed, 5 Feb 2003 11:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTBEQkG>; Wed, 5 Feb 2003 11:40:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23823 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261660AbTBEQkF>; Wed, 5 Feb 2003 11:40:05 -0500
Date: Wed, 5 Feb 2003 16:49:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, tytso@thunk.org,
       rddunlap@osdl.org
Subject: Re: [PATCH][RESEND 3] disassociate_ctty SMP fix
Message-ID: <20030205164937.C28758@flint.arm.linux.org.uk>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, tytso@thunk.org, rddunlap@osdl.org
References: <Pine.LNX.4.50L.0302042235180.32328-100000@imladris.surriel.com> <Pine.LNX.4.50L.0302042306230.32328-100000@imladris.surriel.com> <20030204175109.57bbfc51.akpm@digeo.com> <Pine.LNX.4.50L.0302042356580.32328-100000@imladris.surriel.com> <20030205095114.A25479@flint.arm.linux.org.uk> <20030205145126.A28758@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205145126.A28758@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Feb 05, 2003 at 02:51:26PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's my proposed fix, which appears to work with preempt.  I haven't
tested on non-preempt, nor (obviously since its from me) SMP.  However,
I forsee no problems caused by this change.

release_dev() sets filp->private_data to NULL when the tty layer has
done with the file descriptor.  However, it remains on the tty_files
list until __fput completes.

--- orig/drivers/char/tty_io.c	Fri Jan 17 10:39:10 2003
+++ linux/drivers/char/tty_io.c	Wed Feb  5 16:38:23 2003
@@ -442,6 +442,13 @@
 	file_list_lock();
 	for (l = tty->tty_files.next; l != &tty->tty_files; l = l->next) {
 		struct file * filp = list_entry(l, struct file, f_list);
+		/*
+		 * If this file descriptor has been closed, ignore it; it
+		 * will be going away shortly. (We don't test filp->f_count
+		 * for zero since that could open another race.) --rmk
+		 */
+		if (filp->private_data == NULL)
+			continue;
 		if (IS_CONSOLE_DEV(filp->f_dentry->d_inode->i_rdev) ||
 		    IS_SYSCONS_DEV(filp->f_dentry->d_inode->i_rdev)) {
 			cons_filp = filp;

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

