Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWHJASK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWHJASK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWHJASK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:18:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:65514 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932444AbWHJARo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:17:44 -0400
Date: Wed, 9 Aug 2006 17:18:23 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: stelian@popies.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, paulus@au1.ibm.com,
       anton@au1.ibm.com, open-iscsi@googlegroups.com, pradeep@us.ibm.com,
       mashirle@us.ibm.com
Subject: [PATCH] memory ordering in __kfifo primitives
Message-ID: <20060810001823.GA3026@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Both __kfifo_put() and __kfifo_get() have header comments stating
that if there is but one concurrent reader and one concurrent writer,
locking is not necessary.  This is almost the case, but a couple of
memory barriers are needed.  Another option would be to change the
header comments to remove the bit about locking not being needed, and
to change the those callers who currently don't use locking to add
the required locking.  The attachment analyzes this approach, but the
patch below seems simpler.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 kfifo.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -urpNa -X dontdiff linux-2.6.18-rc2/kernel/kfifo.c linux-2.6.18-rc2-kfifo/kernel/kfifo.c
--- linux-2.6.18-rc2/kernel/kfifo.c	2006-07-15 14:53:08.000000000 -0700
+++ linux-2.6.18-rc2-kfifo/kernel/kfifo.c	2006-08-09 14:01:53.000000000 -0700
@@ -129,6 +129,8 @@ unsigned int __kfifo_put(struct kfifo *f
 	/* then put the rest (if any) at the beginning of the buffer */
 	memcpy(fifo->buffer, buffer + l, len - l);
 
+	smp_wmb();
+
 	fifo->in += len;
 
 	return len;
@@ -161,6 +163,8 @@ unsigned int __kfifo_get(struct kfifo *f
 	/* then get the rest (if any) from the beginning of the buffer */
 	memcpy(buffer + l, fifo->buffer, len - l);
 
+	smp_mb();
+
 	fifo->out += len;
 
 	return len;
