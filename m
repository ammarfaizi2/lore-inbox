Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVDRUuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVDRUuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVDRUuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:50:40 -0400
Received: from mail.dif.dk ([193.138.115.101]:21697 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261175AbVDRUu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:50:29 -0400
Date: Mon, 18 Apr 2005 22:53:26 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Herbert Xu <herbert@gondor.apana.org.au>,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/2] new valid_signal function
Message-ID: <Pine.LNX.4.62.0504182240390.5362@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new function  valid_signal()  that tests if its argument 
is a valid signal number. 

The reasons for adding this new function are:
- some code currently testing _NSIG directly has off-by-one errors. Using 
this function instead avoids such errors.
- some code currently tests unsigned signal numbers for <0 which is 
pointless and generates warnings when building with gcc -W. Using this 
function instead avoids such warnings.

I considered various places to add this function but eventually settled on 
include/linux/signal.h as the most logical place for it. If there's some 
reason this is a bad choice then please let me know (hints as to a better 
location are then welcome of course).

A patch that converts most of the code that currently uses _NSIG directly 
to call this function instead is [PATCH 2/2] coming shortly..

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

 include/linux/signal.h |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2.6.12-rc2-mm3-orig/include/linux/signal.h	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/linux/signal.h	2005-04-18 20:09:50.000000000 +0200
@@ -220,6 +220,12 @@
 	INIT_LIST_HEAD(&sig->list);
 }
 
+/* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
+static inline int valid_signal(unsigned long sig)
+{
+	return sig <= _NSIG ? 1 : 0;
+}
+
 extern int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
 extern int __group_send_sig_info(int, struct siginfo *, struct task_struct *);
 extern long do_sigpending(void __user *, unsigned long);



