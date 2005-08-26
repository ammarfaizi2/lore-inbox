Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVHZRyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVHZRyn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVHZRym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:54:42 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:65196 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965149AbVHZRyl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:54:41 -0400
Subject: [PATCH] pipe: remove redundant fifo_poll abstraction
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
In-Reply-To: <430F4E57.3000001@colorfullife.com>
References: <ilomk8.i0yljb.2ul6sqfgelx5ik5dngkbmbkeu.beaver@cs.helsinki.fi>
	 <ilomki.fs3loe.5j02sm6rx63x13ip2d9643lta.beaver@cs.helsinki.fi>
	 <20050825170217.666edda3.akpm@osdl.org>
	 <Pine.LNX.4.58.0508261000310.26177@sbz-30.cs.Helsinki.FI>
	 <430F4E57.3000001@colorfullife.com>
Date: Fri, 26 Aug 2005 20:54:07 +0300
Message-Id: <1125078847.9403.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 19:16 +0200, Manfred Spraul wrote:
> I would prefer just to remove the abstraction, together with a comment 
> that Linux fifos behave exactly like pipes, unlike the behavior of most 
> unices.

[PATCH] pipe: remove redundant fifo_poll abstraction

This patch removes a redundant fifo_poll() abstraction from fs/pipe.c and adds
a big fat comment stating we set POLLERR for FIFOs too on Linux unlike most
Unices.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 pipe.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: 2.6-mm/fs/pipe.c
===================================================================
--- 2.6-mm.orig/fs/pipe.c
+++ 2.6-mm/fs/pipe.c
@@ -419,6 +419,10 @@ pipe_poll(struct file *filp, poll_table 
 
 	if (filp->f_mode & FMODE_WRITE) {
 		mask |= (nrbufs < PIPE_BUFFERS) ? POLLOUT | POLLWRNORM : 0;
+		/*
+		 * Most Unices do not set POLLERR for FIFOs but on Linux they
+		 * behave exactly like pipes for poll().
+		 */
 		if (!PIPE_READERS(*inode))
 			mask |= POLLERR;
 	}
@@ -426,9 +430,6 @@ pipe_poll(struct file *filp, poll_table 
 	return mask;
 }
 
-/* FIXME: most Unices do not set POLLERR for fifos */
-#define fifo_poll pipe_poll
-
 static int
 pipe_release(struct inode *inode, int decr, int decw)
 {
@@ -572,7 +573,7 @@ struct file_operations read_fifo_fops = 
 	.read		= pipe_read,
 	.readv		= pipe_readv,
 	.write		= bad_pipe_w,
-	.poll		= fifo_poll,
+	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_read_open,
 	.release	= pipe_read_release,
@@ -584,7 +585,7 @@ struct file_operations write_fifo_fops =
 	.read		= bad_pipe_r,
 	.write		= pipe_write,
 	.writev		= pipe_writev,
-	.poll		= fifo_poll,
+	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_write_open,
 	.release	= pipe_write_release,
@@ -597,7 +598,7 @@ struct file_operations rdwr_fifo_fops = 
 	.readv		= pipe_readv,
 	.write		= pipe_write,
 	.writev		= pipe_writev,
-	.poll		= fifo_poll,
+	.poll		= pipe_poll,
 	.ioctl		= pipe_ioctl,
 	.open		= pipe_rdwr_open,
 	.release	= pipe_rdwr_release,


