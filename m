Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933272AbWFZXKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933272AbWFZXKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933247AbWFZWjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:01 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:928 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933226AbWFZWii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:38 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 25/32] [Suspend2] Do io on a page in the image proper.
Date: Tue, 27 Jun 2006 08:38:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223834.4376.97629.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Advance one page and perform the requested i/o.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index ffc2e16..c746f9f 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -821,3 +821,38 @@ static void set_extra_page_forward(void)
 	extra_page_forward = 1;
 }
 
+static int suspend_rw_page(int rw, struct page *page,
+		int readahead_index, int sync, int debug)
+{
+	int i, current_chain;
+	struct submit_params submit_params;
+
+	if (test_action_state(SUSPEND_TEST_FILTER_SPEED))
+		return 0;
+		
+	submit_params.readahead_index = readahead_index;
+	submit_params.page = page;
+	
+	if (forward_one_page()) {
+		printk("Failed to advance a page in the extent data.\n");
+		return -ENODATA;
+	}
+
+	current_chain = suspend_writer_posn.current_chain;
+	submit_params.dev = suspend_devinfo[current_chain].bdev;
+	submit_params.block[0] = suspend_writer_posn.current_offset <<
+		suspend_devinfo[current_chain].bmap_shift;
+
+	if (debug)
+		printk("%s: %lx:%lx.\n", rw ? "Write" : "Read",
+				(long) submit_params.dev->bd_dev,
+				(long) submit_params.block[0]);
+
+	i = suspend_do_io(rw, &submit_params, sync);
+
+	if (i)
+		return -EIO;
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
