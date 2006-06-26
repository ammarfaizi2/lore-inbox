Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933306AbWFZW6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306AbWFZW6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933309AbWFZW4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:56:30 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31927 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933306AbWFZWkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:40 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 28/35] [Suspend2] Test filewriter target value helper.
Date: Tue, 27 Jun 2006 08:40:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224038.4685.46217.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The helper called either when the user echoes a new value into
filewriter_target, or when resume2= is checked on boot or when it is reset.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 2e19aae..9947323 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -828,3 +828,33 @@ static void filewriter_set_resume2(void)
 	suspend_attempt_to_parse_resume_device();
 }
 
+static int __test_filewriter_target(char *target, int resume_time)
+{
+	filewriter_get_target_info(target, 0, resume_time);
+	if (filewriter_signature_op(GET_IMAGE_EXISTS) > -1) {
+		printk(name_suspend "Filewriter: File signature found.\n");
+		if (!resume_time)
+			filewriter_set_resume2();
+		
+		suspend_bio_ops.set_devinfo(&devinfo);
+		suspend_writer_posn.chains = &block_chain;
+		suspend_writer_posn.num_chains = 1;
+
+		set_suspend_state(SUSPEND_CAN_SUSPEND);
+		return 0;
+	}
+
+	clear_suspend_state(SUSPEND_CAN_SUSPEND);
+
+	if (*target)
+		printk(name_suspend
+			"Filewriter: Sorry. No signature found at %s.\n",
+			target);
+	else
+		if (!resume_time)
+			printk(name_suspend
+				"Filewriter: Sorry. Target is not set for suspending.\n");
+
+	return 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
