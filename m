Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbTL0Wl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 17:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbTL0Wl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 17:41:59 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:62602 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264867AbTL0Wl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 17:41:57 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 27 Dec 2003 14:41:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Miquel van Smoorenburg <miquels@cistron.net>
Subject: [patch] One-shot support for epoll ...
Message-ID: <Pine.LNX.4.44.0312271428231.1185-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch implements the one-shot support for epoll. Because of 
the way epoll works (hooking f_op->poll()) the ET behavior is not really 
ET because it might happen that, while data is still available to read 
(for the EPOLLIN case), another chunk will become available triggering 
another event. While those conditions can be easily be handled in 
userspace, the absolute triviality of the patch and the avoidance of 
user/kernel space switches and f_op->poll() calls, make IMHO worth doing 
this inside epoll itself. The patch is on top of 2.6-mm1.



- Davide


fs/eventpoll.c            |   14 ++++++++++++++
include/linux/eventpoll.h |    3 +++
2 files changed, 17 insertions(+)




diff -Nru linux-2.6-mm1/fs/eventpoll.c linux-2.6-mm1.ep/fs/eventpoll.c
--- linux-2.6-mm1/fs/eventpoll.c	2003-12-26 11:52:59.000000000 -0800
+++ linux-2.6-mm1.ep/fs/eventpoll.c	2003-12-27 14:20:27.827167192 -0800
@@ -93,6 +93,8 @@
 #define EPI_SLAB_DEBUG 0
 #endif /* #if DEBUG_EPI != 0 */
 
+/* Epoll private bits inside the event mask */
+#define EP_PRIVATE_BITS (EPOLLONESHOT | EPOLLET)
 
 /* Maximum number of poll wake up nests we are allowing */
 #define EP_MAX_POLLWAKE_NESTS 4
@@ -1306,6 +1308,15 @@
 
 	write_lock_irqsave(&ep->lock, flags);
 
+	/*
+	 * If the event mask does not contain any poll(2) event, we consider the
+	 * descriptor to be disabled. This condition is likely the effect of the
+	 * EPOLLONESHOT bit that disables the descriptor when an event is received,
+	 * until the next EPOLL_CTL_MOD will be issued.
+	 */
+	if (!(epi->event.events & ~EP_PRIVATE_BITS))
+		goto is_disabled;
+
 	/* If this file is already in the ready list we exit soon */
 	if (EP_IS_LINKED(&epi->rdllink))
 		goto is_linked;
@@ -1322,6 +1333,7 @@
 	if (waitqueue_active(&ep->poll_wait))
 		pwake++;
 
+is_disabled:
 	write_unlock_irqrestore(&ep->lock, flags);
 
 	/* We have to call this outside the lock */
@@ -1458,6 +1470,8 @@
 				eventcnt += eventbuf;
 				eventbuf = 0;
 			}
+			if (epi->event.events & EPOLLONESHOT)
+				epi->event.events &= EP_PRIVATE_BITS;
 		}
 	}
 
diff -Nru linux-2.6-mm1/include/linux/eventpoll.h linux-2.6-mm1.ep/include/linux/eventpoll.h
--- linux-2.6-mm1/include/linux/eventpoll.h	2003-12-26 11:50:42.000000000 -0800
+++ linux-2.6-mm1.ep/include/linux/eventpoll.h	2003-12-27 14:08:19.550882016 -0800
@@ -22,6 +22,9 @@
 #define EPOLL_CTL_DEL 2
 #define EPOLL_CTL_MOD 3
 
+/* Set the One Shot behaviour for the target file descriptor */
+#define EPOLLONESHOT (1 << 30)
+
 /* Set the Edge Triggered behaviour for the target file descriptor */
 #define EPOLLET (1 << 31)
 

