Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWFZCfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWFZCfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 22:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWFZCfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 22:35:20 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:9198 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965020AbWFZCfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 22:35:19 -0400
Message-ID: <351289316.15645@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 26 Jun 2006 10:35:29 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [updated PATCH 1/6] readahead: context based method - slow start
Message-ID: <20060626023529.GB6120@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060625130704.464870100@localhost.localdomain> <20060625130921.549904049@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625130921.549904049@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The context method will lead to noticable overhead(readahead miss)
on very sparse random reads.

Having the readahead window to start slowly makes it much better.
But still startup quick if the user prefers sparse readahead.

Benchmarks of reading randomly 100,000 pages on a 1000,000 pages _sparse_ file:

        ARA before patch          ARA                STOCK
        ================    ================    ================
real    2.779s    2.782s    2.552s    2.606s    2.477s    2.521s
user    1.120s    1.184s    1.133s    1.155s    1.097s    1.159s
sys     1.248s    1.208s    1.093s    1.086s    1.079s    1.064s

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.17-mm2.orig/mm/readahead.c
+++ linux-2.6.17-mm2/mm/readahead.c
@@ -1548,6 +1548,12 @@ try_context_based_readahead(struct addre
 			return -1;
 	} else if (prev_page || probe_page(mapping, index - 1)) {
 		ra_index = index;
+		/*
+		 * Slow start of readahead window.
+		 * It helps avoid most readahead miss on sparse random reads.
+		 */
+		if (readahead_hit_rate == 1)
+			ra_min = 1;
 	} else if (readahead_hit_rate > 1) {
 		ra_index = find_segtail_backward(mapping, index,
 						readahead_hit_rate + ra_min);
