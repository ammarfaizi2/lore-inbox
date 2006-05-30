Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWE3Iq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWE3Iq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 04:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWE3Iqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 04:46:55 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:24975 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932188AbWE3Iqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 04:46:55 -0400
Message-ID: <348978812.17342@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060530084702.611578500@localhost.localdomain>
References: <20060530084030.274375770@localhost.localdomain>
Date: Tue, 30 May 2006 16:40:31 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [patch 1/4] readahead: state based method - stand-alone size limit code
Content-Disposition: inline; filename=readahead-method-stateful-fix-size-limit-sep.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Separate out the readahead/lookahead sizes limiting code,
and put them to stand-alone limit_rala() function.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1009,10 +1009,8 @@ static int ra_dispatch(struct file_ra_st
  *	- @la_size stores the look-ahead size of previous request.
  */
 static int adjust_rala(unsigned long ra_max,
-				unsigned long *ra_size, unsigned long *la_size)
+			unsigned long *ra_size, unsigned long *la_size)
 {
-	unsigned long stream_shift = *la_size;
-
 	/*
 	 * Substract the old look-ahead to get real safe size for the next
 	 * read-ahead request.
@@ -1029,8 +1027,16 @@ static int adjust_rala(unsigned long ra_
 	 */
 	*la_size = *ra_size / LOOKAHEAD_RATIO;
 
+	return 1;
+}
+
+static void limit_rala(unsigned long ra_max, unsigned long la_old,
+			unsigned long *ra_size, unsigned long *la_size)
+{
+	unsigned long stream_shift;
+
 	/*
-	 * Apply upper limits.
+	 * Apply basic upper limits.
 	 */
 	if (*ra_size > ra_max)
 		*ra_size = ra_max;
@@ -1041,11 +1047,9 @@ static int adjust_rala(unsigned long ra_
 	 * Make sure stream_shift is not too small.
 	 * (So that the next global_shift will not be too small.)
 	 */
-	stream_shift += (*ra_size - *la_size);
+	stream_shift = la_old + (*ra_size - *la_size);
 	if (stream_shift < *ra_size / 4)
 		*la_size -= (*ra_size / 4 - stream_shift);
-
-	return 1;
 }
 
 /*
@@ -1117,13 +1121,13 @@ state_based_readahead(struct address_spa
 			struct page *page, pgoff_t index,
 			unsigned long req_size, unsigned long ra_max)
 {
-	unsigned long ra_old;
-	unsigned long ra_size;
-	unsigned long la_size;
+	unsigned long ra_old, ra_size;
+	unsigned long la_old, la_size;
 	unsigned long remain_space;
 	unsigned long growth_limit;
 
-	la_size = ra->readahead_index - index;
+	la_old = la_size = ra->readahead_index - index;
+	ra_old = ra_readahead_size(ra);
 	ra_size = compute_thrashing_threshold(ra, &remain_space);
 
 	if (page && remain_space <= la_size && la_size > 1) {
@@ -1131,7 +1135,6 @@ state_based_readahead(struct address_spa
 		return 0;
 	}
 
-	ra_old = ra_readahead_size(ra);
 	growth_limit = req_size;
 	growth_limit += ra_max / 16;
 	growth_limit += (2 + readahead_ratio / 64) * ra_old;
@@ -1141,6 +1144,8 @@ state_based_readahead(struct address_spa
 	if (!adjust_rala(growth_limit, &ra_size, &la_size))
 		return 0;
 
+	limit_rala(growth_limit, la_old, &ra_size, &la_size);
+
 	ra_set_class(ra, RA_CLASS_STATE);
 	ra_set_index(ra, index, ra->readahead_index);
 	ra_set_size(ra, ra_size, la_size);

--
