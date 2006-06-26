Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933202AbWFZXXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202AbWFZXXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933236AbWFZXX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:23:29 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:50591 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933202AbWFZWgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 14/19] [Suspend2] Sanity check image header.
Date: Tue, 27 Jun 2006 08:36:46 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223645.4219.98875.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check that an image header matches the currently running kernel, and return
either a string describing the problem, or NULL.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index d7c48e0..8c9c284 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -676,3 +676,42 @@ write_image_header_abort_no_cleanup:
 	return -1;
 }
 
+/* sanity_check()
+ *
+ * Description:	Perform a few checks, seeking to ensure that the kernel being
+ * 		booted matches the one suspended. They need to match so we can
+ * 		be _sure_ things will work. It is not absolutely impossible for
+ * 		resuming from a different kernel to work, just not assured.
+ * Arguments:	Struct suspend_header. The header which was saved at suspend
+ * 		time.
+ */
+static char *sanity_check(struct suspend_header *sh)
+{
+	if (sh->version_code != LINUX_VERSION_CODE)
+		return "Incorrect kernel version.";
+	
+	if (sh->num_physpages != num_physpages)
+		return "Incorrect memory size.";
+
+	if (strncmp(sh->machine, system_utsname.machine, 65))
+		return "Incorrect machine type.";
+
+	if (strncmp(sh->version, system_utsname.version, 65))
+		return "Right kernel version but wrong build number.";
+
+	if (sh->page_size != PAGE_SIZE)
+		return "Incorrect PAGE_SIZE.";
+
+	if (!test_suspend_state(SUSPEND_IGNORE_ROOTFS)) {
+		const struct super_block *sb;
+		list_for_each_entry(sb, &super_blocks, s_list) {
+			if ((!(sb->s_flags & MS_RDONLY)) &&
+			    (sb->s_type->fs_flags & FS_REQUIRES_DEV))
+				return "Device backed fs has been mounted "
+					"rw prior to resume."; 
+		}
+	}
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
