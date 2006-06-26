Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933265AbWFZXGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933265AbWFZXGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933272AbWFZXFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:05:14 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:24759 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933289AbWFZWjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:52 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 14/35] [Suspend2] Allocate filewriter header storage
Date: Tue, 27 Jun 2006 08:39:50 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223949.4685.70912.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having already allocated storage, set aside a number of pages at the start
of the image for the header and record where pageset2 will start.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 257acca..6b04eb5 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -427,3 +427,24 @@ static int filewriter_release_storage(vo
 	return 0;
 }
 
+static int filewriter_allocate_header_space(int space_requested)
+{
+	int i;
+
+	if (!block_chain.first)
+		return 0;
+
+	suspend_extent_state_goto_start(&suspend_writer_posn);
+	suspend_bio_ops.forward_one_page(); /* To first page */
+	
+	for (i = 0; i < space_requested; i++)
+		if (suspend_bio_ops.forward_one_page())
+			return -ENOSPC;
+
+	/* The end of header pages will be the start of pageset 2 */
+	suspend_extent_state_save(&suspend_writer_posn,
+			&suspend_writer_posn_save[2]);
+	header_pages = space_requested;
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
