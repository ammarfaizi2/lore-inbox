Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVB1U2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVB1U2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVB1U2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:28:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:10908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261711AbVB1U2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:28:18 -0500
Date: Mon, 28 Feb 2005 12:29:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: two pipe bugfixes
In-Reply-To: <20050228195556.GL8880@opteron.random>
Message-ID: <Pine.LNX.4.58.0502281227300.25732@ppc970.osdl.org>
References: <20050228042544.GA8742@opteron.random>
 <Pine.LNX.4.58.0502272143500.25732@ppc970.osdl.org> <20050228190437.GI8880@opteron.random>
 <Pine.LNX.4.58.0502281113380.25732@ppc970.osdl.org> <20050228195556.GL8880@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Feb 2005, Andrea Arcangeli wrote:
> 
> Thanks, I'll check it in the next bk snapshot.

Here's my version of the poll changes. The EPIPE one is just your original 
first patch hunk (with a properly updated commit message).

		Linus

-----

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/28 08:36:14-08:00 torvalds@ppc970.osdl.org 
#   Make pipe "poll()" take direction of pipe into account.
#   
#   The pipe code has traditionally not cared about which end-point of the
#   pipe you are polling, meaning that if you poll the write-only end of a
#   pipe, it will still set the "this pipe is readable" bits if there is
#   data to be read on the read side.
#   
#   That makes no sense, and together with the new bigger buffers breaks
#   python-twisted.
#   
#   Based on debugging/patch by Andrea Arcangeli and testcase from
#   Thomas Crhak
# 
# fs/pipe.c
#   2005/02/28 08:36:06-08:00 torvalds@ppc970.osdl.org +11 -6
#   Make pipe "poll()" take direction of pipe into account.
# 
diff -Nru a/fs/pipe.c b/fs/pipe.c
--- a/fs/pipe.c	2005-02-28 12:28:35 -08:00
+++ b/fs/pipe.c	2005-02-28 12:28:35 -08:00
@@ -398,13 +398,18 @@
 
 	/* Reading only -- no need for acquiring the semaphore.  */
 	nrbufs = info->nrbufs;
-	mask = (nrbufs > 0) ? POLLIN | POLLRDNORM : 0;
-	mask |= (nrbufs < PIPE_BUFFERS) ? POLLOUT | POLLWRNORM : 0;
+	mask = 0;
+	if (filp->f_mode & FMODE_READ) {
+		mask = (nrbufs > 0) ? POLLIN | POLLRDNORM : 0;
+		if (!PIPE_WRITERS(*inode) && filp->f_version != PIPE_WCOUNTER(*inode))
+			mask |= POLLHUP;
+	}
 
-	if (!PIPE_WRITERS(*inode) && filp->f_version != PIPE_WCOUNTER(*inode))
-		mask |= POLLHUP;
-	if (!PIPE_READERS(*inode))
-		mask |= POLLERR;
+	if (filp->f_mode & FMODE_WRITE) {
+		mask |= (nrbufs < PIPE_BUFFERS) ? POLLOUT | POLLWRNORM : 0;
+		if (!PIPE_READERS(*inode))
+			mask |= POLLERR;
+	}
 
 	return mask;
 }
