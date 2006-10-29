Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965330AbWJ2TUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbWJ2TUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965342AbWJ2TUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:49 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:25448 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965334AbWJ2TUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=bQ+4CLgt/0K9Wzw2BV1KLd1GKmRYEfO/8vidT0wvqXuHjwDrMUS7/tI3jjcP4OYnABq8J0W6F1pu0Jdrw5cGKzUej52mlfsV6g9bopN/Qlx66IHSjQC+mILEj7KdfDeExoGTH9Qxl+UAwKbcfVaPTqqUN6DaW570NgIm36neo74=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 06/11] uml ubd driver: ubd_io_lock usage fixup
Date: Sun, 29 Oct 2006 20:20:38 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192038.12292.46985.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add some comments about requirements for ubd_io_lock and expand its use.

When an irq signals that the "controller" (i.e. another thread on the host,
which does the actual requests and is the only one blocked on I/O on the host)
has done some work, we call again the request function ourselves
(do_ubd_request).

We now do that with ubd_io_lock held - that's useful to protect against
concurrent calls to elv_next_request and so on.

XXX: Maybe we shouldn't call at all the request function. Input needed on this.
Are we supposed to plug and unplug the queue? That code "indirectly" does that
by setting a flag, called do_ubd, which makes the request function return (it's
a residual of 2.4 block layer interface).

Meanwhile, however, merge this patch, which improves things.

Cc: Jens Axboe <axboe@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index e4fd29a..1202592 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -106,6 +106,8 @@ static inline void ubd_set_bit(__u64 bit
 
 #define DRIVER_NAME "uml-blkdev"
 
+/* Can be taken in interrupt context, and is passed to the block layer to lock
+ * the request queue. Kernel side code knows that. */
 static DEFINE_SPINLOCK(ubd_io_lock);
 
 static DEFINE_MUTEX(ubd_lock);
@@ -497,6 +499,8 @@ static void __ubd_finish(struct request
 	end_request(req, 1);
 }
 
+/* Callable only from interrupt context - otherwise you need to do
+ * spin_lock_irq()/spin_lock_irqsave() */
 static inline void ubd_finish(struct request *req, int error)
 {
  	spin_lock(&ubd_io_lock);
@@ -504,7 +508,7 @@ static inline void ubd_finish(struct req
 	spin_unlock(&ubd_io_lock);
 }
 
-/* Called without ubd_io_lock held */
+/* Called without ubd_io_lock held, and only in interrupt context. */
 static void ubd_handler(void)
 {
 	struct io_thread_req req;
@@ -525,7 +529,9 @@ static void ubd_handler(void)
 
 	ubd_finish(rq, req.error);
 	reactivate_fd(thread_fd, UBD_IRQ);	
+	spin_lock(&ubd_io_lock);
 	do_ubd_request(ubd_queue);
+	spin_unlock(&ubd_io_lock);
 }
 
 static irqreturn_t ubd_intr(int irq, void *dev)
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
