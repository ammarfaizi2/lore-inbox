Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTESB3h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 21:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbTESB3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 21:29:37 -0400
Received: from dp.samba.org ([66.70.73.150]:51601 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262290AbTESB3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 21:29:36 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: try_then_request_module
Date: Mon, 19 May 2003 11:41:20 +1000
Message-Id: <20030519014233.5BF032C08C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ChangeSet 2003/05/17 12:39:18-07:00, torvalds @ home.transmeta.com [diffview]
> 
> Make request_module() take a printf-like vararg argument instead of a string.
> 
> This is what a lot of the callers really wanted.

Excellent!  I'll close my older version of the same thing.

If someone is feeling eager, many callers could change to
try_then_request_module(), eg:

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.69-bk13/drivers/net/ppp_generic.c working-2.5.69-bk13-try/drivers/net/ppp_generic.c
--- linux-2.5.69-bk13/drivers/net/ppp_generic.c	2003-05-19 10:53:44.000000000 +1000
+++ working-2.5.69-bk13-try/drivers/net/ppp_generic.c	2003-05-19 11:38:40.000000000 +1000
@@ -1959,13 +1959,8 @@ ppp_set_compress(struct ppp *ppp, unsign
 	    || ccp_option[1] < 2 || ccp_option[1] > data.length)
 		goto out;
 
-	cp = find_compressor(ccp_option[0]);
-#ifdef CONFIG_KMOD
-	if (cp == 0) {
-		request_module("ppp-compress-%d", ccp_option[0]);
-		cp = find_compressor(ccp_option[0]);
-	}
-#endif /* CONFIG_KMOD */
+	cp = try_then_request_module(find_compressor(ccp_option[0]),
+				     "ppp-compress-%d", ccp_option[0]);
 	if (cp == 0)
 		goto out;
 

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
