Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTKHDMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 22:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTKHDMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 22:12:17 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:60698 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261538AbTKHDMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 22:12:15 -0500
Date: Fri, 7 Nov 2003 19:11:29 -0800 (PST)
From: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Message-Id: <200311080311.hA83BT4O062092@classic.engr.sgi.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: patch to kernel/resource.c [lk2.6]
Cc: cngam@classic.engr.sgi.com, habeck@sgi.com, jbarnes@classic.engr.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe there is a bug in kernel/resource.c.

We (SGI sn2 I/O code) are using this for allocating dma map resources,
and we tracked failures we were seeing to find_resource().

The problem is that when testing bounds in the forever loop, the
end bound would be one higher than it should be if it gets set
from another resource (it's set to the proper value when it gets
set from the root), causing find_resource to return an invalid
min/max when the requested size was one greater than would fit
between two existing resources.

jeremy



--- ../linux-ioc4/kernel/resource.c	Fri Oct 24 18:47:19 2003
+++ kernel/resource.c	Fri Nov  7 18:53:14 2003
@@ -236,25 +236,33 @@
 static int find_resource(struct resource *root, struct resource *new,
 			 unsigned long size,
 			 unsigned long min, unsigned long max,
 			 unsigned long align,
 			 void (*alignf)(void *, struct resource *,
 					unsigned long, unsigned long),
 			 void *alignf_data)
 {
 	struct resource *this = root->child;
 
 	new->start = root->start;
+	/*
+	 * Skip past an allocated resource that starts at 0, since the assignment
+	 * of this->start - 1 to new->end below would cause an underflow.
+	 */
+	if (this && this->start == 0) {
+		new->start = this->end + 1;
+		this = this->sibling;
+	}
 	for(;;) {
 		if (this)
-			new->end = this->start;
+			new->end = this->start - 1;
 		else
 			new->end = root->end;
 		if (new->start < min)
 			new->start = min;
 		if (new->end > max)
 			new->end = max;
 		new->start = (new->start + align - 1) & ~(align - 1);
 		if (alignf)
 			alignf(alignf_data, new, size, align);
 		if (new->start < new->end && new->end - new->start + 1 >= size) {
 			new->end = new->start + size - 1;
