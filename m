Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933373AbWFZWsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933373AbWFZWsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933347AbWFZWrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:47:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:42679 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933329AbWFZWlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/28] [Suspend2] Initialise/cleanup swapwriter
Date: Tue, 27 Jun 2006 08:41:49 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224148.4975.13748.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise and cleanup routines, called when we're going to do something.
It may be just modifying a setting, but some of these result in I/O being
done to (eg) check whether an image exists.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 792bcc8..ae0dfad 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -429,3 +429,26 @@ static int swapwriter_storage_available(
 	return swapinfo.freeswap + swapwriter_storage_allocated();
 }
 
+static int swapwriter_initialise(int starting_cycle)
+{
+	if (!starting_cycle)
+		return 0;
+
+	enable_swapfile();
+
+	if (resume_dev_t && !resume_block_device &&
+	    IS_ERR(resume_block_device =
+	    		open_bdev(MAX_SWAPFILES, resume_dev_t)))
+		return 1;
+	
+	return 0;
+}
+
+static void swapwriter_cleanup(int ending_cycle)
+{
+	if (ending_cycle)
+		disable_swapfile();
+	
+	close_bdevs();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
