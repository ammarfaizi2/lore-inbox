Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965339AbWJ2TVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965339AbWJ2TVU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbWJ2TUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:53 -0500
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:64604 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965336AbWJ2TUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=bk2/cFAthvWX3mt8W73vPSOlcT8VVbKEt8D3TepI6beTjxQ5fCv5bQhbBhjww+wD2xyo3PGzjUdXvAk9NjO6gTr0cI3WX5mNTdIHrnLuVoBq2BBS6qdn2PRD5eZcJ59+gMfglQuUNMAfaVnKV1fPn4FKSblw+EPpBveShfDSez8=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 08/11] uml ubd driver: convert do_ubd to a boolean variable
Date: Sun, 29 Oct 2006 20:20:43 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192043.12292.76166.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

do_ubd is actually just a boolean variable - the way it is used currently is a
leftover from the old 2.4 block layer, but it is still used; its use is
suspicious, but removing it would be too intrusive for now and needs more
thinking.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 48b2a4f..1a85d39 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -112,7 +112,9 @@ static DEFINE_SPINLOCK(ubd_io_lock);
 
 static DEFINE_MUTEX(ubd_lock);
 
-static void (*do_ubd)(void);
+/* XXX - this made sense in 2.4 days, now it's only used as a boolean, and
+ * probably it doesn't make sense even for that. */
+static int do_ubd;
 
 static int ubd_open(struct inode * inode, struct file * filp);
 static int ubd_release(struct inode * inode, struct file * file);
@@ -508,6 +510,7 @@ static inline void ubd_finish(struct req
 	spin_unlock(&ubd_io_lock);
 }
 
+/* XXX - move this inside ubd_intr. */
 /* Called without ubd_io_lock held, and only in interrupt context. */
 static void ubd_handler(void)
 {
@@ -515,7 +518,7 @@ static void ubd_handler(void)
 	struct request *rq = elv_next_request(ubd_queue);
 	int n;
 
-	do_ubd = NULL;
+	do_ubd = 0;
 	intr_count++;
 	n = os_read_file(thread_fd, &req, sizeof(req));
 	if(n != sizeof(req)){
@@ -1058,7 +1061,7 @@ static void do_ubd_request(request_queue
 			return;
 		err = prepare_request(req, &io_req);
 		if(!err){
-			do_ubd = ubd_handler;
+			do_ubd = 1;
 			n = os_write_file(thread_fd, (char *) &io_req,
 					 sizeof(io_req));
 			if(n != sizeof(io_req))
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
