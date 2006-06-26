Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933354AbWFZWtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933354AbWFZWtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933320AbWFZWlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:40119 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933334AbWFZWlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:35 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/28] [Suspend2] Parse swapwriter signature.
Date: Tue, 27 Jun 2006 08:41:33 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224131.4975.23802.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parse a signature. It may reflect a normal swapheader of type 1 or 2, a
swsusp header or a Suspend2 header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   50 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index a014103..08c4f86 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -243,3 +243,53 @@ static void swapwriter_noresume_reset(vo
 	close_bdevs();
 }
 
+static int parse_signature(char *header, int restore)
+{
+	int type = -1;
+	
+	if (!memcmp("SWAP-SPACE",header,10))
+		return 0;
+	else if (!memcmp("SWAPSPACE2",header,10))
+		return 1;
+
+	else if (!memcmp("S1SUSP",header,6))
+		type = 4;
+	else if (!memcmp("S2SUSP",header,6))
+		type = 5;
+	
+	else if (!memcmp("z",header,1))
+		type = 12;
+	else if (!memcmp("Z",header,1))
+		type = 13;
+	
+	/* 
+	 * Put bdev of suspend header in last byte of swap header
+	 * (unsigned short)
+	 */
+	if (type > 11) {
+		dev_t *header_ptr = (dev_t *) &header[1];
+		unsigned char *headerblocksize_ptr =
+			(unsigned char *) &header[5];
+		u32 *headerblock_ptr = (u32 *) &header[6];
+		header_dev_t = *header_ptr;
+		/* 
+		 * We are now using the highest bit of the char to indicate
+		 * whether we have attempted to resume from this image before.
+		 */
+		clear_suspend_state(SUSPEND_RESUMED_BEFORE);
+		if (((int) *headerblocksize_ptr) & 0x80)
+			set_suspend_state(SUSPEND_RESUMED_BEFORE);
+		headerblock = (unsigned long) *headerblock_ptr;
+	}
+
+	if ((restore) && (type > 5)) {
+		/* We only reset our own signatures */
+		if (type & 1)
+			memcpy(header,"SWAPSPACE2",10);
+		else
+			memcpy(header,"SWAP-SPACE",10);
+	}
+
+	return type;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
