Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWFZXDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWFZXDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933265AbWFZWjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:54 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:19639 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933267AbWFZWjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:18 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/35] [Suspend2] Does a filewriter page have contiguous blocks?
Date: Tue, 27 Jun 2006 08:39:17 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223915.4685.72892.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify things, pages in the file being used by the filewriter which
don't have contiguous blocks are ignored. This function determines whether
a given page meets this criteria by bmapping each sector in the page to
check.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index caa86bc..41aaed4 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -136,3 +136,21 @@ static int filewriter_storage_available(
 	return result;
 }
 
+static int has_contiguous_blocks(int page_num)
+{
+	int j;
+	sector_t last = 0;
+
+	for (j = 0; j < devinfo.blocks_per_page; j++) {
+		sector_t this = bmap(target_inode,
+				page_num * devinfo.blocks_per_page + j);
+
+		if (!this || (last && (last + 1) != this))
+			break;
+
+		last = this;
+	}
+			
+	return (j == devinfo.blocks_per_page);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
