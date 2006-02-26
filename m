Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWBZTxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWBZTxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWBZTxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:53:25 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:57830 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751392AbWBZTxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:53:24 -0500
Message-ID: <44020681.8F74CD53@tv-sign.ru>
Date: Sun, 26 Feb 2006 22:50:25 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Bryan Fink <bfink@eventmonitor.com>, linux-kernel@vger.kernel.org,
       Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH] readahead: fix initial window size calculation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I hope it is ok to send this patch without Steven's reply)

From: Steven Pratt <slpratt@austin.ibm.com>

The current current get_init_ra_size is not optimal across different IO
sizes and max_readahead values.  Here is a quick summary of sizes
computed under current design and under the attached patch.  All of
these assume 1st IO at offset 0, or 1st detected sequential IO.

32k max, 4k request

old         new
-----------------
 8k        8k
16k       16k
32k       32k

128k max, 4k request
old         new
-----------------
32k         16k
64k         32k
128k        64k
128k       128k

128k max, 32k request
old         new
-----------------
32k         64k    <-----
64k        128k
128k       128k

512k max, 4k request
old         new
-----------------
4k         32k     <----
16k        64k
64k       128k
128k      256k
512k      512k

--- 2.6.16-rc3/mm/readahead.c~	2006-02-27 00:53:17.881019192 +0300
+++ 2.6.16-rc3/mm/readahead.c	2006-02-27 01:10:39.172718792 +0300
@@ -83,10 +83,10 @@ static unsigned long get_init_ra_size(un
 {
 	unsigned long newsize = roundup_pow_of_two(size);
 
-	if (newsize <= max / 64)
-		newsize = newsize * newsize;
+	if (newsize <= max / 32)
+		newsize = newsize * 4;
 	else if (newsize <= max / 4)
-		newsize = max / 4;
+		newsize = newsize * 2;
 	else
 		newsize = max;
 	return newsize;
