Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268810AbRG0Jxu>; Fri, 27 Jul 2001 05:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268811AbRG0Jxl>; Fri, 27 Jul 2001 05:53:41 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:41210 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S268809AbRG0JxX>; Fri, 27 Jul 2001 05:53:23 -0400
Date: Fri, 27 Jul 2001 15:27:24 +0530 (IST)
From: Balbir Singh <balbir.singh@wipro.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: balbirs@indiatimes.com, balbir_soni@yahoo.com
Subject: Addendum to Daniel Phillips [RFC] use-once patch
Message-ID: <Pine.SV4.4.21.0107271524310.4696-100000@wipro.wipsys.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Addendum to Daniel Phillips [RFC] use-once patch
------------------------------------------------

A while ago, Daniel Phillips, posted his use use once patch. I used it and
found it useful. I have been thinking of something similar. Let me describe
what I have been thinking, this is in-line with page-aging and the working
set model.

As per the working set model, we use locality of reference, to keep constantly
used pages in memory. It is for sure that after a period of time, these pages
that were being used constantly, would no longer be required (since we would
be done with that piece of code or data). We would like to evict these
pages since soon.

To illustrate :-

I have used a PAGE_MAX_USE principle (my own from what I know), which states
that most of the pages (**except shared pages**), would be used for a maximum of
PAGE_MAX_USE (some constant > 0). We look at pages that are very frequently
used and then after some number of times (PAGE_MAX_USE) they have been used,
we "victimize" them. This may be wrong, since the page may be required
for more than the number of times (PAGE_MAX_USE), we think it is
required. In that case, it will be paged back in (when required) and
reused again for PAGE_MAX_USE times before being victimized again.

Below is a small patch for proof of concept
-------------------------------------------


--- vmscan.c.org        Fri Jul 27 14:27:06 2001
+++ vmscan.c    Fri Jul 27 14:32:38 2001
@@ -43,10 +43,20 @@
 
        /* Don't look at this pte if it's been accessed recently. */
        if (ptep_test_and_clear_young(page_table)) {
-               page->age += PAGE_AGE_ADV;
-               if (page->age > PAGE_AGE_MAX)
-                       page->age = PAGE_AGE_MAX;
-               return;
+
+               /*
+                * If the page has been at PAGE_AGE_MAX for a while, may be
+                * it is the best candidate for swapping.
+                */
+               if ((page->age > PAGE_AGE_MAX) && (page_count(page) <= 1)) {
+                       page->age = PAGE_AGE_START;
+               } else {
+                       page->age += PAGE_AGE_ADV;
+                       if (page->age > PAGE_AGE_MAX) {
+                               page->age = PAGE_AGE_MAX;
+                       }
+                       return;
+               }
        }

System Configuration
=====================

Single processor celeron system with 128 MB of RAM, running Linux-2.4.7pre6
with Daniel's patch applied (running X windows at the time of compilation,
with GNOME).

time for creating clean bzImage *before* patch
==============================================

real    28m40.492s
user    22m43.450s
sys     2m44.490s


time for creating clean bzImage *after* patch
=============================================

real    26m37.011s
user    21m56.350s
sys     2m28.060s


The system, seemed to respond faster (or I might be feeling so).

I am also planning to run some standard benchmark (I need to figure out, which
one, or you could guide me). If you like the idea, I will post the benchmark
results also to you (soon!). This patch is a simple implementation of the
idea, I could come out with a more comprehensive solution if required.


Comments, suggestions
Please also cc to balbirs@indiatimes.com

Thanks,
Balbir Singh.



