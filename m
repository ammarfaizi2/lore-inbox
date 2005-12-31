Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVLaS7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVLaS7t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 13:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVLaS7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 13:59:49 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:39744 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S965039AbVLaS7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 13:59:48 -0500
Subject: Re: [PATCH 10/9] clockpro-document.patch
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 19:59:18 +0100
Message-Id: <1136055558.17853.72.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By popular request,
I'll finish it some time next year.

Best wishes all.

--- /dev/null   2003-12-29 19:37:00.000000000 +0100
+++ linux-2.6-git/Documentation/vm/clockpro.txt 2005-12-31 19:55:45.000000000 +0100
@@ -0,0 +1,97 @@
+This document describes the page replace algorithm as implemented in the linux
+kernel. It is based on CLOCK-Pro, found here:
+       http://www.cs.wm.edu/hpcs/WWW/HTML/publications/abs05-3.html
+
+  Base Algorithm Summary
+
+The algorithm is based on reuse distance as opposed to the recency familair
+from LRU. The reuse distance is the number of pages referenced between the
+current and previous page reference.
+
+It categorizes pages with a small reuse distance as hot and those with a large
+reuse distance as cold. The threshold between hot and cold is the test period,
+that is, if a page is referenced during its test period its reuse distance is
+small, ie. it becomes hot. The test period is the largest reuse distance of a
+hot page, which in turn depends on the number of resident cold pages.
+
+The number of resident cold pages is an adaptive target which is incremented
+when a page is referenced in its test period and decremented when a test
+period expires.
+
+Reclaim looks for unreferenced cold pages, for cold pages that are still in
+their test period the metadata is kept until the test period expires.
+
+In order to be able to compare reuse distance all pages are kept on one CLOCK
+however the management of the page state requires more than one hand.
+CLOCK-Pro has three, the following table gives the actions of each hand:
+
+      res | hot | tst | ref ||  Hcold |  Hhot  |  Htst  ||  Flt
+      ----+-----+-----+-----++--------+--------+--------++------
+       1  |  1  |  0  |  1  || = 1101 |   1100 | = 1101 ||
+       1  |  1  |  0  |  0  || = 1100 |   1000 | = 1100 ||
+      ----+-----+-----+-----++--------+--------+--------++------
+       1  |  0  |  1  |  1  ||   1100 |   1001 |   1001 ||
+       1  |  0  |  1  |  0  || N 0010 |   1000 |   1000 ||
+       1  |  0  |  0  |  1  ||   1010 | = 1001 | = 1001 ||
+       1  |  0  |  0  |  0  || X 0000 | = 1000 | = 1000 ||
+      ====+=====+=====+=====++========+========+========++======
+       0  |  0  |  1  |  1  ||        |        |        || 1100
+       0  |  0  |  1  |  0  || = 0010 | X 0000 | X 0000 ||
+       0  |  0  |  0  |  1  ||        |        |        || 1010
+
+Where the first four columns give the page state and the next three columns
+give the new state when the respective hand moves along. The prefixes '=', 'N'
+and 'X' are used to indicate: state unchanged, page tracked as non-resident
+and remove page. The last column gives the state on page fault.
+
+The hand dynamics is as follows, reclaim rotates the cold hand and takes
+unreferenced cold pages. When during this rotation the actual number of cold
+pages drops below the target number of cold pages the hot hand is rotated.
+
+The hot hand demotes unreferenced hot pages to cold, and terminates the test
+period of pages is passes by. If however the total number of pages tracked
+rises above twice the total available resident pages the test hand is rotated.
+
+The test hand, like the hot hand, terminates the test period of any page it
+passes by. Remember that terminating the test period of a non-resident cold
+page removes it altogether, thus limiting the total pages tracked.
+
+
+  Implementation Notes
+
+Since pages reclaimed in one zone can end up being faulted back in another
+zone it is incorrect to have per-zone non-resident page tracking. Hence the
+resident and non-resident page tracking needs to be separated.
+
+In order to accomplish this the following is done; take two CLOCKs, a two
+handed one for resident pages and a single handed one for non-resident pages.
+The resident CLOCK's hands will reflect hand cold and the resident part of hand
+hot, the non-resident CLOCK's hand will reflect the non-resident part of hand
+hot. Hence the rotation speeds of the resident hand hot and non-resident hand
+are coupled so that when one has made a full revolution so will have the
+other.
+
+The functionality of hand test is accomplished by simply limiting the number
+of entries on the non-resident clock to the number of pages on the resident
+clock. When a new entry is added to an already full non-resident clock the
+oldest entry will be removed; ie. its test period terminated.
+
+This uncoupling of non-resident and resident pages has the effect that the
+exact position of the non-resident pages relative to the resident pages is
+lost. This uncertainty propagates to the duration of the test period, some
+pages will be terminated to soon, other too late. However this is a bounded
+error with an average of 0.
+
+This scheme can then be extended to multiple zones by scaling the rotation
+speed coupling between the resident hot hand and the non-resident hand to the
+zone size. That is, when all resident hot hands have made one full revolution
+so will the non-resident hand have.
+
+Demand paging introduces yet another problem, when a page is faulted into
+memory it effectivly doesn't matter what the referenced bit is set to, it will
+be used as soon as we finish the fault anyway. Hence the first check will
+always activate the page even though we have only had a single use. The
+classic use-once problem. To tackle this the pages can be inserted one state
+lower than normal and behind hand hot instead of behind hand cold, this so
+that hand hot cannot interfere with the lowered page state and the first
+reference is lost quicker.


