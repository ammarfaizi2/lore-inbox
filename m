Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271703AbTHHQtR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271707AbTHHQtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:49:17 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:33542 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S271703AbTHHQtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:49:10 -0400
Message-ID: <3F33D41E.89CFA182@SteelEye.com>
Date: Fri, 08 Aug 2003 12:47:26 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lou Langholtz <ldl@aros.net>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net> <3F30510A.E918924B@SteelEye.com> <3F30AF81.4070308@aros.net> <3F332ED7.712DFE5D@SteelEye.com> <3F334396.7030008@aros.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz wrote:

> >--- linux-2.6.0-test2-mm4-PRISTINE/drivers/block/nbd.c Sun Jul 27 12:58:51 2003
> >+++ linux-2.6.0-test2-mm4/drivers/block/nbd.c  Thu Aug  7 18:02:23 2003
> >@@ -416,11 +416,19 @@ void nbd_clear_que(struct nbd_device *lo
> >       BUG_ON(lo->magic != LO_MAGIC);
> > #endif
> >
> >+retry:
> >       do {
> >               req = NULL;
> >               spin_lock(&lo->queue_lock);
> >               if (!list_empty(&lo->queue_head)) {
> >                       req = list_entry(lo->queue_head.next, struct request, queuelist);
> >+                      if (req->ref_count > 1) { /* still in xmit */
> >+                              spin_unlock(&lo->queue_lock);
> >+                              printk(KERN_DEBUG "%s: request %p: still in use (%d), waiting...\n",
> >+                                  lo->disk->disk_name, req, req->ref_count);
> >+                              schedule_timeout(HZ); /* wait a second */
> >

> Isn't there something more deterministic than just waiting a second and
> hoping things clear up that you can use here? 

It's not exactly "hoping" something will happen...we're waiting until
do_nbd_request decrements the ref_count, which is completely
deterministic, but just not guaranteed to have already happened when
nbd_clear_que() starts. 

The use of the ref_count closes a race window (the one that I pointed
out in my response to Lou's original patch a few days ago). It protects
us in the following case(s):

1) do_nbd_request begins -- sock and file are valid
2) do_nbd_request queues the request and then calls nbd_send_req to send
the request out on the network
3) on another CPU, or after preempt, nbd-client gets a signal or an
"nbd-client -d" is called, which results in sock and file being set to
NULL, and the queue begins to be cleared, and requests that were on the
queue get freed (before do_nbd_request has finished accessing req for
the last time)


> How about not clearing the
> queue unless lo->sock is NULL and using whatever lock it is now that's
> protecting lo->sock. That way the queue clearing race can be eliminated too.

That makes sense. I hadn't done this (for compatibility reasons) since
"nbd-client -d" (disconnect) calls NBD_CLEAR_QUE before disconnecting
the socket. But I think we can just make NBD_CLEAR_QUE silently fail
(return 0) if lo->sock is set and basically turn that first
NBD_CLEAR_QUE into a noop, and let the nbd_clear_que() call at the end
of NBD_CLEAR_SOCK handle it (properly). Note that the race condition
above still applies, even with this lo->sock check in place. But this
check does eliminate the race in "nbd-client -d" where, e.g., requests
are being queued up faster than nbd_clear_que can dequeue them,
potentially making nbd_clear_que loop forever.

As a side note, NBD_CLEAR_QUE is actually now completely superfluous,
since NBD_DO_IT and NBD_CLEAR_SOCK (which always get called in
conjunction with NBD_CLEAR_QUE) contain the nbd_clear_que() call
themselves. We could just make NBD_CLEAR_QUE a noop in all cases, but I
guess we'd risk breaking some nbd client tool that's out there...

I'm testing the updated patch now, I'll send it out in a little while...

Thanks,
Paul
