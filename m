Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933276AbWFZXH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933276AbWFZXH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933274AbWFZWjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:42 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:22711 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933275AbWFZWjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:39 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/35] [Suspend2] Parse filewriter signature.
Date: Tue, 27 Jun 2006 08:39:37 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223935.4685.53069.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given a pointer to what we expect to be a filewriter signature, return
whether it is unrecognised (-1), a file without an image (0) or a file with
an image to resume from (1).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 6851977..d5f0310 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -365,3 +365,23 @@ cleanup:
 	target_storage_available = 0;
 }
 
+int parse_signature(struct filewriter_header *header)
+{
+	int have_image = !memcmp(HaveImage, header->sig, sizeof(HaveImage) - 1);
+	int no_image_header = !memcmp(NoImage, header->sig, sizeof(NoImage) - 1);
+
+	if (no_image_header)
+		return 0;
+
+	if (!have_image)
+		return -1;
+
+	if (header->resumed_before)
+		set_suspend_state(SUSPEND_RESUMED_BEFORE);
+	else
+		clear_suspend_state(SUSPEND_RESUMED_BEFORE);
+
+	target_header_start = header->first_header_block;
+	return 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
