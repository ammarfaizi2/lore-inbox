Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVIYGGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVIYGGb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 02:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVIYGGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 02:06:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64961 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751107AbVIYGGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 02:06:31 -0400
Date: Sat, 24 Sep 2005 23:05:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: willy@w.ods.org, nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Message-Id: <20050924230545.3245da3f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0509241113370.31327@localhost.localdomain>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
	<20050924040534.GB18716@alpha.home.local>
	<29495f1d05092321447417503@mail.gmail.com>
	<20050924061500.GA24628@alpha.home.local>
	<Pine.LNX.4.63.0509240800020.31060@localhost.localdomain>
	<20050924172011.GA25997@alpha.home.local>
	<Pine.LNX.4.63.0509241113370.31327@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> wrote:
>
> The attached patch uses the kernel min() macro, that is optimized has 
>  single compare by gcc-O2. Andrew, this goes over (hopefully ;) the bits 
>  you already have in -mm.

OK, well I've rather lost the plot with all the patches flying around.

I now have one single patch against epoll.c, below.  Please confirm that
this is what was intended.   If not, I'll drop it and let's start again.





From: Davide Libenzi <davidel@xmailserver.org>

The sys_epoll_wait() function was not handling correctly negative timeouts
(besides -1), and like sys_poll(), was comparing millisec to secs in
testing the upper timeout limit.

Signed-off-by: Davide Libenzi <davidel@xmailserver.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/eventpoll.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN fs/eventpoll.c~sys_epoll_wait-fix-handling-of-negative-timeouts fs/eventpoll.c
--- devel/fs/eventpoll.c~sys_epoll_wait-fix-handling-of-negative-timeouts	2005-09-24 23:01:00.000000000 -0700
+++ devel-akpm/fs/eventpoll.c	2005-09-24 23:02:50.000000000 -0700
@@ -101,6 +101,10 @@
 /* Maximum number of poll wake up nests we are allowing */
 #define EP_MAX_POLLWAKE_NESTS 4
 
+/* Maximum msec timeout value storeable in a long int */
+#define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, LONG_MAX / HZ - 1000ULL)
+
+
 struct epoll_filefd {
 	struct file *file;
 	int fd;
@@ -1506,8 +1510,8 @@ static int ep_poll(struct eventpoll *ep,
 	 * and the overflow condition. The passed timeout is in milliseconds,
 	 * that why (t * HZ) / 1000.
 	 */
-	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
-		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
+	jtimeout = (timeout < 0 || timeout >= EP_MAX_MSTIMEO) ?
+		MAX_SCHEDULE_TIMEOUT : (timeout * HZ + 999) / 1000;
 
 retry:
 	write_lock_irqsave(&ep->lock, flags);
_

