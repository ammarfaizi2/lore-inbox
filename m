Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWFZXLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWFZXLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933257AbWFZWiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:55 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:14519 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933250AbWFZWio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 27/32] [Suspend2] Init and cleanup routines for pageset i/o.
Date: Tue, 27 Jun 2006 08:38:43 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223841.4376.4707.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preparation and cleanup routines for doing I/O on a pageset.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index c095eac..374a861 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -919,3 +919,40 @@ wait:
 	return 0;
 }
 
+static int suspend_rw_init(int rw, int stream_number)
+{
+	suspend_extent_state_restore(&suspend_writer_posn,
+			&suspend_writer_posn_save[stream_number]);
+	current_stream = stream_number;
+
+	BUG_ON(!suspend_writer_posn.current_extent);
+
+	suspend_reset_io_stats();
+
+	readahead_index = readahead_submit_index = -1;
+
+	return 0;
+}
+
+static int suspend_rw_cleanup(int rw)
+{
+	if (rw == WRITE && current_stream == 2)
+		suspend_extent_state_save(&suspend_writer_posn,
+				&suspend_writer_posn_save[1]);
+	
+	suspend_finish_all_io();
+	
+	if (rw == READ) {
+		while (readahead_index != readahead_submit_index) {
+			suspend_cleanup_readahead(readahead_index);
+			readahead_index++;
+			if (readahead_index == MAX_OUTSTANDING_IO)
+				readahead_index = 0;
+		}
+	}
+
+	suspend_check_io_stats();
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
