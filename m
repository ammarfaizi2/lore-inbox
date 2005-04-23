Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVDWXTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVDWXTN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVDWXTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:19:13 -0400
Received: from mail.dif.dk ([193.138.115.101]:23956 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262169AbVDWXTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:19:10 -0400
Date: Sun, 24 Apr 2005 01:22:21 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] prevent possible infinite loop in fs/select.c::do_pollfd()
Message-ID: <Pine.LNX.4.62.0504240112340.2474@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a sufficiently large 'num' is passed to the function, the for loop 
becomes an infinite loop - as far as I can see, that's a bug waiting to 
happen. Sure, 'len' in struct poll_list is currently an int, so currently 
this can't happen, but that might change in the future. In my oppinion, 
a function should be able to function correctly with the complete range 
of values that can potentially be passed via its parameters, and without 
the patch below that's just not true for this function.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm3-orig/fs/select.c	2005-04-05 21:21:47.000000000 +0200
+++ linux-2.6.12-rc2-mm3/fs/select.c	2005-04-24 01:11:13.000000000 +0200
@@ -397,7 +397,7 @@ struct poll_list {
 static void do_pollfd(unsigned int num, struct pollfd * fdpage,
 	poll_table ** pwait, int *count)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < num; i++) {
 		int fd;


