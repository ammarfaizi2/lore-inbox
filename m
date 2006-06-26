Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933146AbWFZWea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933146AbWFZWea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933109AbWFZWeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:14 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:23967 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933136AbWFZWdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/16] [Suspend2] Image exists proc entry.
Date: Tue, 27 Jun 2006 08:33:49 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223347.3832.49382.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines for the image_exists proc entry. Read to determine whether an
image exists at the place resume2= points to (-1 equals can't determine, 0
for no image, 1 for there is).

If an image exists, we also print the kernel version and suspend version
used to create the image on additional lines. 

Echoing to the file invalidates any image that exists.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 40f54f7..4eabb21 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -640,3 +640,54 @@ cleanup:
 	suspend_deactivate_storage(0);
 }
 
+/* image_exists_read
+ * 
+ * Return 0 or 1, depending on whether an image is found.
+ */
+static int image_exists_read(char *page, char **start, off_t off, int count,
+		int *eof, void *data)
+{
+	int len = 0;
+	char *result;
+	
+	if (suspend_activate_storage(0))
+		return count;
+
+	if (!test_suspend_state(SUSPEND_RESUME_DEVICE_OK))
+		suspend_attempt_to_parse_resume_device();
+
+	if (!suspend_active_writer) {
+		len = sprintf(page, "-1\n");
+	} else {
+		result = get_have_image_data();
+		if (result) {
+			len = sprintf(page, "%s",  result);
+			free_page((unsigned long) result);
+		}
+	}
+
+	*eof = 1;
+
+	suspend_deactivate_storage(0);
+
+	return len;
+}
+
+/* image_exists_write
+ * 
+ * Invalidate an image if one exists.
+ */
+static int image_exists_write(struct file *file, const char *buffer,
+		unsigned long count, void *data)
+{
+	if (suspend_activate_storage(0))
+		return count;
+
+	if (suspend_active_writer && suspend_active_writer->image_exists())
+		suspend_active_writer->invalidate_image();
+
+	suspend_deactivate_storage(0);
+
+	return count;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
