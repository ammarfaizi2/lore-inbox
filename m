Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWF0FJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWF0FJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWF0FIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:08:46 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:20955 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030663AbWF0Ei6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/10] [Suspend2] Atomic copy get_next_bit_on routine.
Date: Tue, 27 Jun 2006 14:38:56 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043855.14546.37822.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This routine is used find the next bit in a bitmap that is on. It is used
during the atomic restore of highmem pages.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   60 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
index 07b418c..6d1bc68 100644
--- a/kernel/power/atomic_copy.c
+++ b/kernel/power/atomic_copy.c
@@ -75,3 +75,63 @@ static void suspend_init_nosave_zone_tab
 	}
 }
 
+/**
+ * __suspend_get_next_bit_on: Atomic-copy safe location of next bit on in a bitmap.
+ * 
+ * @bitmap:	The bitmap we are traversing.
+ * @zone_num:	Which zone we are in.
+ * @counter:	The current pfn.
+ *
+ * A version of __get_next_bit_on that can be used when doing the atomic
+ * copy. While doing it, we can't rely on the zone information being in
+ * a constant location.
+ **/
+static unsigned long __suspend_get_next_bit_on(dyn_pageflags_t bitmap,
+		int *zone_num, long counter)
+{
+	unsigned long *ul_ptr = NULL;
+	int reset_ul_ptr = 1;
+	BUG_ON(*zone_num == num_zones);
+
+	if (counter == -1) {
+		*zone_num = 0;
+
+		/* 
+		 * Test the end because the start can validly
+		 * be zero.
+		 */
+		while (!zone_nosave[*zone_num].end_pfn)
+			(*zone_num)++;
+		counter = zone_nosave[*zone_num].start_pfn - 1;
+	}
+
+	do {
+		counter++;
+		if (counter > zone_nosave[*zone_num].end_pfn) {
+			(*zone_num)++;
+			while (!zone_nosave[*zone_num].end_pfn &&
+					*zone_num < num_zones)
+				(*zone_num)++;
+			
+			if (*zone_num == num_zones)
+				return -1;
+			counter = zone_nosave[*zone_num].start_pfn;
+			reset_ul_ptr = 1;
+		} else
+			if (!(counter & BIT_NUM_MASK))
+				reset_ul_ptr = 1;
+
+		if (reset_ul_ptr) {
+			reset_ul_ptr = 0;
+			ul_ptr = PAGE_UL_PTR(bitmap, *zone_num,
+				(counter - zone_nosave[*zone_num].start_pfn));
+			if (!*ul_ptr) {
+				counter += BIT_NUM_MASK - 1;
+				continue;
+			}
+		}
+	} while(!test_bit(PAGEBIT(counter), ul_ptr));
+
+	return counter;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
