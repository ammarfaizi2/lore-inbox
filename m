Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTFLJpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264618AbTFLJpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:45:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:43687 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264610AbTFLJpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:45:16 -0400
Date: Thu, 12 Jun 2003 15:31:26 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
Subject: [patch] LIST_POISON with rcu
Message-ID: <20030612100126.GA1212@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

LIST_POISON will not work with RCU based lists as we depend on the
fact the deleted list element can still point to the existing list. 
Though any new user will not be able to reach the deleted element.
This is one of the reasons why we don't do list_del_init_rcu(). 
The folloing patch fixes this.

Trond, I am not sure if you are seeing the d_move() oops because
of this. It will be nice if you can post the oops message also.

Regards,
Maneesh

diff -urN linux-2.5.70-mm8/include/linux/list.h linux-2.5.70-mm8-LIST_POISON/include/linux/list.h
--- linux-2.5.70-mm8/include/linux/list.h	Thu Jun 12 15:26:06 2003
+++ linux-2.5.70-mm8-LIST_POISON/include/linux/list.h	Thu Jun 12 15:24:51 2003
@@ -162,8 +162,6 @@
 static inline void list_del_rcu(struct list_head *entry)
 {
 	__list_del(entry->prev, entry->next);
-	entry->next = LIST_POISON1;
-	entry->prev = LIST_POISON2;
 }
 
 /**
@@ -434,7 +432,10 @@
 	n->pprev = LIST_POISON2;
 }
 
-#define hlist_del_rcu hlist_del  /* list_del_rcu is identical too? */
+static __inline__ void hlist_del_rcu(struct hlist_node *n)
+{
+	__hlist_del(n);
+}
 
 static __inline__ void hlist_del_init(struct hlist_node *n) 
 {



-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
