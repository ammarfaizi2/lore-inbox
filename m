Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVCNRxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVCNRxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVCNRwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:52:12 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:59116 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S261653AbVCNRtW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:49:22 -0500
To: akpm@osdl.org
Subject: [PATCH] Releasing resources with children
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx
Message-Id: <20050314174916.B49754957B9@palinux.hppa>
Date: Mon, 14 Mar 2005 10:49:16 -0700 (MST)
From: willy@parisc-linux.org (Matthew Wilcox)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Releasing resources with children

What does it mean to release a resource with children?  Should the
children become children of the released resource's parent?  Should they
be released too?  Should we fail the release?

I bet we have no callers who expect this right now, but with
insert_resource() we may get some.  At the point where someone hits this
BUG we can figure out what semantics we want.

Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>

diff -urpNX dontdiff linux-2.6.11-bk10/kernel/resource.c parisc-2.6-bk/kernel/resource.c
--- linux-2.6.11-bk10/kernel/resource.c	2005-03-14 06:44:08.205342005 -0700
+++ parisc-2.6-bk/kernel/resource.c	2005-03-14 07:07:54.000000000 -0700
@@ -181,6 +181,8 @@ static int __release_resource(struct res
 {
 	struct resource *tmp, **p;
 
+	BUG_ON(old->child);
+
 	p = &old->parent->child;
 	for (;;) {
 		tmp = *p;
