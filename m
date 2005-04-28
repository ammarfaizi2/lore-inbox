Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVD1Kau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVD1Kau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 06:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVD1Kaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 06:30:35 -0400
Received: from mail.dif.dk ([193.138.115.101]:21739 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261987AbVD1KaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 06:30:13 -0400
Date: Thu, 28 Apr 2005 12:29:47 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Herbert Xu <herbert@gondor.apana.org.au>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] new valid_signal function (fwd)
Message-ID: <Pine.LNX.4.62.0504281216230.10786@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

A while back I attempted to fix a little, not at all critical, gcc -W 
warning in fs/fcntl.c, during the discussion Matthew Wilcox noted that 
there were other locations that did the same thing and at least one 
location where there was an off-by-one error. He suggested that one good 
way of fixing the whole thing would be to introduce a new valid_signal() 
function. This can all be found in the '[PATCH] fs/fcntl.c : don't test 
unsigned value for less than zero' thread.
I created a patch to do that and also one that put it to good use and 
posted both patches to the list and a few people that I thought were 
relevant (same people that are CC: on this mail), but never heard anythng 
back and I didn't see the patches get merged either, so now I'm sending 
them to you in the hope that you'll merge them in -mm.

Below is the first patch that adds the new function.

-- Jesper Juhl


---------- Forwarded message ----------
Date: Mon, 18 Apr 2005 22:53:26 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Herbert Xu <herbert@gondor.apana.org.au>,
    Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/2] new valid_signal function

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



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
