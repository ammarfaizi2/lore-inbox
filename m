Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWJaH0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWJaH0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbWJaH0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:26:21 -0500
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:29850 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S1422775AbWJaH0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:26:20 -0500
Date: Tue, 31 Oct 2006 08:25:53 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: [PATCH] splice : two smp_mb() can be omitted
In-reply-to: <20061030224802.f73842b8.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jens Axboe <jens.axboe@oracle.com>
Message-id: <4546FA81.1020804@cosmosbay.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_o63J8Dn/1f4ErCrnvKHPbg)"
References: <1162199005.24143.169.camel@taijtu>
 <20061030224802.f73842b8.akpm@osdl.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_o63J8Dn/1f4ErCrnvKHPbg)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

This patch deletes two calls to smp_mb() that were done after mutex_unlock() 
that contains an implicit memory barrier.

The first one in splice_to_pipe(), where 'do_wakeup' is set to true only if 
pipe->inode is set (and in this case the
if (pipe->inode)
    mutex_unlock(&pipe->inode->i_mutex);
is done too)

The second one in link_pipe(), following inode_double_unlock() that contains 
calls to mutex_unlock() too.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary_(ID_o63J8Dn/1f4ErCrnvKHPbg)
Content-type: text/plain; name=splice.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=splice.patch

--- linux/fs/splice.c	2006-10-31 07:49:52.000000000 +0100
+++ linux-ed/fs/splice.c	2006-10-31 08:04:58.000000000 +0100
@@ -248,7 +248,6 @@
 		mutex_unlock(&pipe->inode->i_mutex);
 
 	if (do_wakeup) {
-		smp_mb();
 		if (waitqueue_active(&pipe->wait))
 			wake_up_interruptible(&pipe->wait);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
@@ -1518,7 +1517,6 @@
 	 * If we put data in the output pipe, wakeup any potential readers.
 	 */
 	if (ret > 0) {
-		smp_mb();
 		if (waitqueue_active(&opipe->wait))
 			wake_up_interruptible(&opipe->wait);
 		kill_fasync(&opipe->fasync_readers, SIGIO, POLL_IN);

--Boundary_(ID_o63J8Dn/1f4ErCrnvKHPbg)--
