Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWFYNKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWFYNKq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWFYNJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:09:17 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:734 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751242AbWFYNJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:09:15 -0400
Message-ID: <351240952.23410@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625130921.549904049@localhost.localdomain>
References: <20060625130704.464870100@localhost.localdomain>
Date: Sun, 25 Jun 2006 21:07:05 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 1/6] readahead: context based method - slow start
Content-Disposition: inline; filename=readahead-context-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The context method will lead to noticable overhead on sparse random reads.
Having the readahead window to start slowly makes it much better.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-mm2.orig/mm/readahead.c
+++ linux-2.6.17-mm2/mm/readahead.c
@@ -1548,6 +1548,11 @@ try_context_based_readahead(struct addre
 			return -1;
 	} else if (prev_page || probe_page(mapping, index - 1)) {
 		ra_index = index;
+		/*
+		 * Slow start of readahead window.
+		 * It helps avoid most readahead miss on sparse random reads.
+		 */
+		ra_min = readahead_hit_rate;
 	} else if (readahead_hit_rate > 1) {
 		ra_index = find_segtail_backward(mapping, index,
 						readahead_hit_rate + ra_min);

--
