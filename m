Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbTIMTjb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTIMTjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:39:31 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:2441 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262172AbTIMTj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:39:28 -0400
Date: Sat, 13 Sep 2003 21:39:19 +0200 (MEST)
Message-Id: <200309131939.h8DJdJpj001767@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com.br
Subject: [PATCH][2.4.23-pre4] page_alloc uninitialised variable bug
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm/page_alloc in 2.4.23-pre4 triggers this warning:

page_alloc.c: In function `balance_classzone':
page_alloc.c:259: warning: `__freed' might be used uninitialized in this function

There is a case where balance_classzone() returns NULL and an
uninitialised value in *freed, and the caller, __alloc_pages(),
also uses the uninitialised value.

Changing balance_classzone() to not do "*freed = __freed;" in
this case is inadequate since __alloc_pages() will still look
at the bogus value. Someone needs to initialise the damn thing;
the patch below makes balance_classzone() do it.

/Mikael

--- linux-2.4.23-pre4/mm/page_alloc.c.~1~	2003-09-13 19:11:48.000000000 +0200
+++ linux-2.4.23-pre4/mm/page_alloc.c	2003-09-13 20:58:56.000000000 +0200
@@ -256,7 +256,7 @@
 static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
 {
 	struct page * page = NULL;
-	int __freed;
+	int __freed = 0;
 
 	if (!(gfp_mask & __GFP_WAIT))
 		goto out;
