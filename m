Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbTCZULh>; Wed, 26 Mar 2003 15:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbTCZULg>; Wed, 26 Mar 2003 15:11:36 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:56274 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262444AbTCZUL0>; Wed, 26 Mar 2003 15:11:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 26 Mar 2003 12:20:19 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch][bugfix] epoll cross-thread deletion fix ...
Message-ID: <Pine.LNX.4.50.0303261210470.2114-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes a bug that might happen having a thread doing epoll_wait() with
another thread doing epoll_ctl(EPOLL_CTL_DEL) and close(). The fast check
inside eventpoll_release() is good to not effect performace of code not
using epoll, but it requires get_file() to be called ( that can be avoided
by dropping the fast check ). I opted to keep the fast check and to have
epoll to call get_file() before the event send loop. I tested it on UP and
2SMP with a bug-exploiting program provided by @pivia.com ( thx to them )
and it looks fine. I also update the 2.4.20 epoll patch with this fix :

http://www.xmailserver.org/linux-patches/epoll-lt-2.4.20-0.5.diff




- Davide



eventpoll.c |   26 +++++++++++++++++++++++++-
1 files changed, 25 insertions, 1 deletion





diff -Nru linux-2.5.66.vanilla/fs/eventpoll.c linux-2.5.66.epoll/fs/eventpoll.c
--- linux-2.5.66.vanilla/fs/eventpoll.c	Mon Mar 24 14:00:19 2003
+++ linux-2.5.66.epoll/fs/eventpoll.c	Tue Mar 25 19:00:50 2003
@@ -1342,6 +1342,13 @@
 			ep_use_epitem(epi);

 			/*
+			 * We need to increase the usage count of the "struct file" because
+			 * another thread might call close() on this target and make the file
+			 * to vanish before we will be able to call f_op->poll().
+			 */
+			get_file(epi->file);
+
+			/*
 			 * This is initialized in this way so that the default
 			 * behaviour of the reinjecting code will be to push back
 			 * the item inside the ready list.
@@ -1386,6 +1393,14 @@
 		revents = epi->file->f_op->poll(epi->file, NULL);

 		/*
+		 * Release the file usage before checking the event mask.
+		 * In case this call will lead to the file removal, its
+		 * ->event.events member has been already set to zero and
+		 * this will make the event to be dropped.
+		 */
+		fput(epi->file);
+
+		/*
 		 * Set the return event set for the current file descriptor.
 		 * Note that only the task task was successfully able to link
 		 * the item to its "txlist" will write this field.
@@ -1398,8 +1413,17 @@
 			eventbuf++;
 			if (eventbuf == EP_MAX_BUF_EVENTS) {
 				if (__copy_to_user(&events[eventcnt], event,
-						   eventbuf * sizeof(struct epoll_event)))
+						   eventbuf * sizeof(struct epoll_event))) {
+					/*
+					 * We need to complete the loop to decrement the file
+					 * usage before returning from this function.
+					 */
+					for (lnk = lnk->next; lnk != txlist; lnk = lnk->next) {
+						epi = list_entry(lnk, struct epitem, txlink);
+						fput(epi->file);
+					}
 					return -EFAULT;
+				}
 				eventcnt += eventbuf;
 				eventbuf = 0;
 			}
