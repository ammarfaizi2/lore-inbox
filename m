Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbUESK3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUESK3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUESK3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:29:44 -0400
Received: from holomorphy.com ([207.189.100.168]:41614 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263304AbUESK33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:29:29 -0400
Date: Wed, 19 May 2004 03:28:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       arjanv@redhat.com, benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040519102846.GG1223@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>, arjanv@redhat.com,
	benh@kernel.crashing.org, kronos@kronoz.cjb.net,
	linux-kernel@vger.kernel.org
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org> <20040517233515.GR5414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517233515.GR5414@waste.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 06:35:15PM -0500, Matt Mackall wrote:
> I have a cleaned up version of this script in -tiny which is a bit
> nicer for adding new arches to and produces simpler output:
>  1428 huft_build
>  1292 inflate_dynamic
>  1168 inflate_fixed
>   528 ip_setsockopt
>   496 tcp_check_req
>   496 tcp_v4_conn_request
>   484 tcp_timewait_state_process
>   440 ip_getsockopt
>   408 extract_entropy
>   364 shrink_zone
>   324 do_execve

By eyeballing things, I see >= 384B on-stack in ep_send_events(). Hence:

kmalloc() the event buffer, since 384B on-stack is a bit large for i386.
Also minor cleanups so the thing can actually be read.
Untested, but simple.

Index: mm3-2.6.6/fs/eventpoll.c
===================================================================
--- mm3-2.6.6.orig/fs/eventpoll.c	2004-05-16 19:54:38.000000000 -0700
+++ mm3-2.6.6/fs/eventpoll.c	2004-05-19 03:09:24.000000000 -0700
@@ -148,14 +148,6 @@
 #define EP_ITEM_FROM_EPQUEUE(p) (container_of(p, struct ep_pqueue, pt)->epi)
 
 /*
- * This is used to optimize the event transfer to userspace. Since this
- * is kept on stack, it should be pretty small.
- */
-#define EP_MAX_BUF_EVENTS 32
-
-
-
-/*
  * Node that is linked into the "wake_task_list" member of the "struct poll_safewake".
  * It is used to keep track on all tasks that are currently inside the wake_up() code
  * to 1) short-circuit the one coming from the same task and same wait queue head
@@ -1426,16 +1418,20 @@
  * This function is called without holding the "ep->lock" since the call to
  * __copy_to_user() might sleep, and also f_op->poll() might reenable the IRQ
  * because of the way poll() is traditionally implemented in Linux.
+ * Buffering events is used to optimize the event transfer to userspace.
  */
 static int ep_send_events(struct eventpoll *ep, struct list_head *txlist,
 			  struct epoll_event __user *events)
 {
-	int eventcnt = 0, eventbuf = 0;
+	int eventcnt = 0, eventbuf = 0, bytes;
 	unsigned int revents;
 	struct list_head *lnk;
 	struct epitem *epi;
-	struct epoll_event event[EP_MAX_BUF_EVENTS];
+	struct epoll_event *event;
 
+	event = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
 	/*
 	 * We can loop without lock because this is a task private list.
 	 * The test done during the collection loop will guarantee us that
@@ -1458,30 +1454,36 @@
 		 * the item to its "txlist" will write this field.
 		 */
 		epi->revents = revents & epi->event.events;
+		if (!epi->revents)
+			continue;
 
-		if (epi->revents) {
-			event[eventbuf] = epi->event;
-			event[eventbuf].events &= revents;
-			eventbuf++;
-			if (eventbuf == EP_MAX_BUF_EVENTS) {
-				if (__copy_to_user(&events[eventcnt], event,
-						   eventbuf * sizeof(struct epoll_event)))
-					return -EFAULT;
-				eventcnt += eventbuf;
-				eventbuf = 0;
-			}
-			if (epi->event.events & EPOLLONESHOT)
-				epi->event.events &= EP_PRIVATE_BITS;
+		event[eventbuf] = epi->event;
+		event[eventbuf].events &= revents;
+		eventbuf++;
+		if (eventbuf < PAGE_SIZE/sizeof(struct epoll_event))
+			goto mask_private_bits;
+		bytes = eventbuf * sizeof(struct epoll_event);
+		if (__copy_to_user(&events[eventcnt], event, bytes)) {
+			eventcnt = -EFAULT;
+			goto out;
 		}
-	}
-
-	if (eventbuf) {
-		if (__copy_to_user(&events[eventcnt], event,
-				   eventbuf * sizeof(struct epoll_event)))
-			return -EFAULT;
 		eventcnt += eventbuf;
-	}
-
+		eventbuf = 0;
+mask_private_bits:
+		if (epi->event.events & EPOLLONESHOT)
+			epi->event.events &= EP_PRIVATE_BITS;
+	}
+
+	if (!eventbuf)
+		goto out;
+	bytes = eventbuf * sizeof(struct epoll_event);
+	if (__copy_to_user(&events[eventcnt], event, bytes)) {
+		eventcnt = -EFAULT;
+		goto out;
+	}
+	eventcnt += eventbuf;
+out:
+	kfree(event);
 	return eventcnt;
 }
 
