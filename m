Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUEEAmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUEEAmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUEEAmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:42:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:62643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261273AbUEEAmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:42:19 -0400
Date: Tue, 4 May 2004 17:42:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: manfred@colorfullife.com
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix memleak in sys_mq_timedsend
Message-ID: <20040504174214.D21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move error handling to capture all three possible error conditions on
sending to a full queue.  Without this fix any unprivileged user can
leak arbitrary amounts of kernel memory.

--- ./ipc/mqueue.c~fix_memleak	2004-05-04 15:08:52.000000000 -0700
+++ ./ipc/mqueue.c	2004-05-04 15:10:59.000000000 -0700
@@ -811,9 +811,9 @@ asmlinkage long sys_mq_timedsend(mqd_t m
 			wait.msg = (void *) msg_ptr;
 			wait.state = STATE_NONE;
 			ret = wq_sleep(info, SEND, timeout, &wait);
-			if (ret < 0)
-				free_msg(msg_ptr);
 		}
+		if (ret < 0)
+			free_msg(msg_ptr);
 	} else {
 		receiver = wq_get_first_waiter(info, RECV);
 		if (receiver) {

