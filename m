Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267210AbUBMXoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUBMXoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:44:55 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:64395 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267210AbUBMXov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:44:51 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 13 Feb 2004 15:44:51 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] potential race in epoll_ctl(EPOLL_CTL_MOD) ...
Message-ID: <Pine.LNX.4.44.0402131415060.2128-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, a potential race can happen in epoll_ctl(EPOLL_CTL_MOD) where an 
event can happen in between f_op->poll() and the lock on ep->lock (we 
cannot call f_op->poll() inside a lock, and the f_op->poll() callback does 
not carry any info at the current time - missing wake_up_info() already ;).
In that case the event would be removed. We can easily leave the event 
inside the ready list and have the ep_send_events() logic do the job for 
us at later time.
(Thanks to david.lee@teracruz.com for reporting the thing, since it 
shouldn't have been a nice one ;)



- Davide




--- a/fs/eventpoll.c	2004-02-13 14:13:29.417933600 -0800
+++ b/fs/eventpoll.c	2004-02-13 14:13:46.999260832 -0800
@@ -1155,8 +1155,7 @@
 				if (waitqueue_active(&ep->poll_wait))
 					pwake++;
 			}
-		} else if (EP_IS_LINKED(&epi->rdllink))
-			EP_LIST_DEL(&epi->rdllink);
+		}
 	}
 
 	write_unlock_irqrestore(&ep->lock, flags);







