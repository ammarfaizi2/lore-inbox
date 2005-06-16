Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVFPD4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVFPD4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 23:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVFPD4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 23:56:51 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:14908 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261725AbVFPD43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 23:56:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=AF4T6XWacV+RFW7BegKJ6j0ef2HOL9reg+LMyxViqBl/4uhccnEt3+gv5dsPL1pMxDc+FaCGagmCNLQNMABI3amMkfOdWeNDSz4EUf+KQwvCEOFXGujIvDtwOiSGGRKKxAimacbDW2GQiuEGiJqjAho3wEKKyKsgc0+fF8tZWOg=
Date: Thu, 16 Jun 2005 12:56:22 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6.12-rc6-mm1] blk: cfq_find_next_crq fix
Message-ID: <20050616035622.GA29153@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.
 Hello, Andrew.

 In cfq_find_next_crq(), cfq tries to find the next request by
choosing one of two requests before and after the current one.
Currently, when choosing the next request, if there's no next request,
the next candidate is NULL, resulting in selection of the previous
request.  This results in weird scheduling.  Once we reach the end, we
always seek backward.

 The correct behavior is using the first request as the next
candidate.  cfq_choose_req() already has logics for handling wrapped
requests.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-06-15 22:44:55.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-06-15 22:45:21.000000000 +0900
@@ -375,9 +375,10 @@ cfq_find_next_crq(struct cfq_data *cfqd,
 	struct cfq_rq *crq_next = NULL, *crq_prev = NULL;
 	struct rb_node *rbnext, *rbprev;
 
+	rbnext = NULL;
 	if (ON_RB(&last->rb_node))
 		rbnext = rb_next(&last->rb_node);
-	else {
+	if (!rbnext) {
 		rbnext = rb_first(&cfqq->sort_list);
 		if (rbnext == &last->rb_node)
 			rbnext = NULL;
