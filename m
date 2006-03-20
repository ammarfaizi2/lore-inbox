Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWCTPyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWCTPyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbWCTPxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:53:45 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:54504 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965233AbWCTPxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:53:05 -0500
Date: Mon, 20 Mar 2006 08:53:04 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make sure nobody's leaking resources
Message-ID: <20060320155304.GI8980@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, releasing a resource also releases all of its children.  That
made sense when request_resource was the main method of dividing up the
memory map.  With the increased use of insert_resource, it seems to me
that we should instead reparent the newly orphaned resources.  Before
we do that, let's make sure that nobody's actually relying on the current
semantics.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff -urpNX dontdiff linus-2.6/kernel/resource.c parisc-2.6/kernel/resource.c
--- linus-2.6/kernel/resource.c	2006-03-20 07:29:06.000000000 -0700
+++ parisc-2.6/kernel/resource.c	2006-03-20 07:00:47.000000000 -0700
@@ -181,6 +181,8 @@ static int __release_resource(struct res
 {
 	struct resource *tmp, **p;
 
+	BUG_ON(old->child);
+
 	p = &old->parent->child;
 	for (;;) {
 		tmp = *p;
