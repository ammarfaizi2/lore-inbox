Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWI1PSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWI1PSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWI1PSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:18:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:51351 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965030AbWI1PSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:18:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LTa+t56BIHih3u8+v0iL6Cili/zZLzuE9oQ8UUFAed6gE6W8TauptQ76CFzK9pe5qSuzR12SSjc56CjLvymAEpm9D4p25pqSvCDHNe9MooAG+ey2t4Z9mHPxaGxF2qhloql5n2UX1W65ySfQHPtap8IJz0dUZ4EizLcAOkF82sE=
Message-ID: <76505a370609280818r3ffc9a4akf4cec6ed366d32e3@mail.gmail.com>
Date: Thu, 28 Sep 2006 23:18:45 +0800
From: keios <keios.cn@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] low performance of lib/sort.c , kernel 2.6.18
Cc: "Andrew Morton" <akpm@osdl.org>, "Matt Mackall" <mpm@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is a non-standard heap-sort algorithm implementation because the
index of child node is wrong . The sort function still outputs right
result, but the performance is O( n * ( log(n) + 1 ) ) , about 10% ~
20% worse than standard algorithm .

Signed-off-by: keios <keios.cn@gmail.com>
-----
diff -Nraup a/lib/sort.c b/lib/sort.c
--- a/lib/sort.c	2006-09-20 11:42:06.000000000 +0800
+++ b/lib/sort.c	2006-09-27 21:26:38.000000000 +0800
@@ -49,15 +49,15 @@ void sort(void *base, size_t num, size_t
 	  void (*swap)(void *, void *, int size))
 {
 	/* pre-scale counters for performance */
-	int i = (num/2) * size, n = num * size, c, r;
+	int i = (num/2 - 1) * size, n = num * size, c, r;

 	if (!swap)
 		swap = (size == 4 ? u32_swap : generic_swap);

 	/* heapify */
 	for ( ; i >= 0; i -= size) {
-		for (r = i; r * 2 < n; r  = c) {
-			c = r * 2;
+		for (r = i; r * 2 + size < n; r  = c) {
+			c = r * 2 + size;
 			if (c < n - size && cmp(base + c, base + c + size) < 0)
 				c += size;
 			if (cmp(base + r, base + c) >= 0)
@@ -69,8 +69,8 @@ void sort(void *base, size_t num, size_t
 	/* sort */
 	for (i = n - size; i >= 0; i -= size) {
 		swap(base, base + i, size);
-		for (r = 0; r * 2 < i; r = c) {
-			c = r * 2;
+		for (r = 0; r * 2 + size < i; r = c) {
+			c = r * 2 + size;
 			if (c < i - size && cmp(base + c, base + c + size) < 0)
 				c += size;
 			if (cmp(base + r, base + c) >= 0)
