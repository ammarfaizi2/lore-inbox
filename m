Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268335AbUIFRvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268335AbUIFRvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 13:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268396AbUIFRuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 13:50:20 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:61871 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268381AbUIFRt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 13:49:57 -0400
Subject: [patch 1/3] uml-ubd-no-empty-queue
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 06 Sep 2004 19:44:46 +0200
Message-Id: <20040906174447.238788D1E@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid using, in the UBD driver, the elv_queue_empty function. It's for
the block layer only; in fact, the Anticipatory Scheduler can return NULL
with elv_next_request() even if the queue is not empty, because it waits
for the process to send another request before seeking on the disk.

In fact, if (with uml-ubd-any-elevator) we let UBD use any scheduler,
elevator=as will make the UBD driver Oops, if we don't have this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-no-empty-queue arch/um/drivers/ubd_kern.c
--- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-ubd-no-empty-queue	2004-08-29 14:40:51.313410952 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-08-29 14:40:51.315410648 +0200
@@ -1038,8 +1038,7 @@ static void do_ubd_request(request_queue
 	int err, n;
 
 	if(thread_fd == -1){
-		while(!elv_queue_empty(q)){
-			req = elv_next_request(q);
+		while((req = elv_next_request(q)) != NULL){
 			err = prepare_request(req, &io_req);
 			if(!err){
 				do_io(&io_req);
@@ -1048,9 +1047,8 @@ static void do_ubd_request(request_queue
 		}
 	}
 	else {
-		if(do_ubd || elv_queue_empty(q))
+		if(do_ubd || (req = elv_next_request(q)) == NULL)
 			return;
-		req = elv_next_request(q);
 		err = prepare_request(req, &io_req);
 		if(!err){
 			do_ubd = ubd_handler;
_
