Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933171AbWFZXVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933171AbWFZXVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933106AbWFZXVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:21:03 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:51615 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933171AbWFZWgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 16/19] [Suspend2] Read pageset1.
Date: Tue, 27 Jun 2006 08:36:53 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223651.4219.73921.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call the __read_pageset1() function, report any errors and return the
result.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index 35fb081..79cf54f 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -898,3 +898,38 @@ out_reset_console:
 	goto out;
 }
 
+/* read_pageset1()
+ *
+ * Description:	Attempt to read the header and pageset1 of a suspend image.
+ * 		Handle the outcome, complaining where appropriate.
+ */
+
+int read_pageset1(void)
+{
+	int error;
+
+	error = __read_pageset1();
+
+	switch (error) {
+		case 0:
+		case -ENODATA:
+		case -EINVAL:	/* non fatal error */
+			return error;
+		case -EIO:
+			printk(KERN_CRIT name_suspend "I/O error\n");
+			break;
+		case -ENOENT:
+			printk(KERN_CRIT name_suspend "No such file or directory\n");
+			break;
+		case -EPERM:
+			printk(KERN_CRIT name_suspend "Sanity check error\n");
+			break;
+		default:
+			printk(KERN_CRIT name_suspend "Error %d resuming\n",
+					error);
+			break;
+	}
+	abort_suspend("Error %d in read_pageset1",error);
+	return error;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
