Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTJ2TYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTJ2TYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:24:05 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:31916 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261376AbTJ2TX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:23:59 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 29 Oct 2003 11:23:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ben Mansell <ben@zeus.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll gives broken results when interrupted with a signal
In-Reply-To: <Pine.LNX.4.58.0310291729310.2982@stones.cam.zeus.com>
Message-ID: <Pine.LNX.4.56.0310291121560.973@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0310291439110.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310290923100.2049@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310291729310.2982@stones.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, Ben Mansell wrote:

> UP machine - x86_64 however, if that makes any difference (sorry, my
> initial message didn't contain much information, as I wasn't sure what
> was relevant and what was not). The descriptor is passed over the unix
> domain socket between the two processes.
>
> I'm willing to try any debug patch that might help track down the
> problem.

Can you try the patch below and show me a dmesg when this happen?
Also, it shouldn't change a whit, but are you able to try on a x86 UP?



- Davide



diff -Nru linux-2.6.0-test9.vanilla/fs/eventpoll.c linux-2.6.0-test9.mod/fs/eventpoll.c
--- linux-2.6.0-test9.vanilla/fs/eventpoll.c	2003-10-25 11:43:26.000000000 -0700
+++ linux-2.6.0-test9.mod/fs/eventpoll.c	2003-10-29 11:21:27.849490320 -0800
@@ -75,7 +75,7 @@

 #define EVENTPOLLFS_MAGIC 0x03111965 /* My birthday should work for this :) */

-#define DEBUG_EPOLL 0
+#define DEBUG_EPOLL 1

 #if DEBUG_EPOLL > 0
 #define DPRINTK(x) printk x
@@ -462,6 +462,9 @@
 	struct eventpoll *ep;
 	struct epitem *epi;

+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: eventpoll_release_file(%p)\n",
+		     current, file));
+
 	/*
 	 * We don't want to get "file->f_ep_lock" because it is not
 	 * necessary. It is not necessary because we're in the "struct file"
@@ -478,6 +481,10 @@

 		ep = epi->ep;
 		EP_LIST_DEL(&epi->fllink);
+
+		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: remove ep=%p epi=%p\n",
+			     current, ep, epi));
+
 		down_write(&ep->sem);
 		ep_remove(ep, epi);
 		up_write(&ep->sem);
@@ -1432,6 +1439,9 @@
 	list_for_each(lnk, txlist) {
 		epi = list_entry(lnk, struct epitem, txlink);

+		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: polling file=%p ep=%p epi=%p\n",
+			     current, epi->file, ep, epi));
+
 		/*
 		 * Get the ready file event set. We can safely use the file
 		 * because we are holding the "sem" in read and this will
@@ -1447,6 +1457,9 @@
 		epi->revents = revents & epi->event.events;

 		if (epi->revents) {
+			DNPRINTK(3, (KERN_INFO "[%p] eventpoll: pollres file=%p ep=%p epi=%p events=%u\n",
+				     current, epi->file, ep, epi, epi->revents));
+
 			event[eventbuf] = epi->event;
 			event[eventbuf].events &= revents;
 			eventbuf++;
