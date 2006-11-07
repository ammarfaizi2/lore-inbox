Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753748AbWKGWS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbWKGWS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbWKGWS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:18:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752951AbWKGWS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:18:57 -0500
Date: Tue, 7 Nov 2006 14:17:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take23 0/5] kevent: Generic event handling mechanism.
Message-Id: <20061107141718.f7414b31.akpm@osdl.org>
In-Reply-To: <11629182482886@2ka.mipt.ru>
References: <1154985aa0591036@2ka.mipt.ru>
	<11629182482886@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 19:50:48 +0300
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> Generic event handling mechanism.

I updated the version in -mm to v23.  So people can play with it and review
it.  It looks like a bit of work will be needed to get it to compile.


It seems that most of the fixes which were added to the previous version
were merged or are now irrelevant, however you lost this change:


From: Andrew Morton <akpm@osdl.org>

If kevent_user_wait() gets -EFAULT on the attempt to copy the first event, it
will return 0, which is indistinguishable from "no events pending".

It can and should return EFAULT in this case.

Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/kevent/kevent_user.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN kernel/kevent/kevent_user.c~kevent_user_wait-retval-fix kernel/kevent/kevent_user.c
--- a/kernel/kevent/kevent_user.c~kevent_user_wait-retval-fix
+++ a/kernel/kevent/kevent_user.c
@@ -690,8 +690,11 @@ static int kevent_user_wait(struct file 
 
 	while (num < max_nr && ((k = kqueue_dequeue_ready(u)) != NULL)) {
 		if (copy_to_user(buf + num*sizeof(struct ukevent),
-					&k->event, sizeof(struct ukevent)))
+					&k->event, sizeof(struct ukevent))) {
+			if (num == 0)
+				num = -EFAULT;
 			break;
+		}
 		kevent_complete_ready(k);
 		++num;
 		kevent_stat_wait(u);
_

