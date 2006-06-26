Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933319AbWFZWlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933319AbWFZWlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933327AbWFZWln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:43 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:40631 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933339AbWFZWlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:37 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/28] [Suspend2] Prepare swapwriter signature.
Date: Tue, 27 Jun 2006 08:41:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224135.4975.93994.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the swapwriter signature to reflect that we have an image and point to
the device and sector where the header proper begins.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 08c4f86..7f16bea 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -293,3 +293,39 @@ static int parse_signature(char *header,
 	return type;
 }
 
+/*
+ * prepare_signature
+ */
+
+static int prepare_signature(dev_t bdev, unsigned long block,
+		char *current_header)
+{
+	int current_type = parse_signature(current_header, 0);
+	dev_t *header_ptr = (dev_t *) (&current_header[1]);
+	unsigned long *headerblock_ptr =
+		(unsigned long *) (&current_header[6]);
+
+	if ((current_type > 1) && (current_type < 6))
+		return 1;
+
+	/* At the moment, I don't have a way to handle the block being
+	 * > 32 bits. Not enough room in the signature and no way to
+	 * safely put the data elsewhere. */
+
+	if (BITS_PER_LONG == 64 && ffs(block) > 31) {
+		suspend_prepare_status(DONT_CLEAR_BAR,
+			"Header sector requires 33+ bits. "
+			"Would not be able to resume.");
+		return 1;
+	}
+
+	if (current_type & 1)
+		current_header[0] = 'Z';
+	else
+		current_header[0] = 'z';
+	*header_ptr = bdev;
+	/* prev is the first/last swap page of the resume area */
+	*headerblock_ptr = (unsigned long) block; 
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
