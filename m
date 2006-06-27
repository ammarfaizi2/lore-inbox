Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932832AbWF0Evf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbWF0Evf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933434AbWF0Els
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:48 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:45531 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933429AbWF0Elh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:37 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/21] [Suspend2] Serialise userui configuration info.
Date: Tue, 27 Jun 2006 14:41:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044135.14883.34547.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Save and load routines for storing the userspace user interface
configuration information in the image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 21c6be7..16e540d 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -181,3 +181,26 @@ static unsigned long userui_storage_need
 	return sizeof(ui_helper_data.program) + 1 + sizeof(int);
 }
 
+static int userui_save_config_info(char *buf)
+{
+	*((int *) buf) = progress_granularity;
+	memcpy(buf + sizeof(int), ui_helper_data.program, sizeof(ui_helper_data.program));
+	return sizeof(ui_helper_data.program) + sizeof(int) + 1;
+}
+
+static void userui_load_config_info(char *buf, int size)
+{
+	progress_granularity = *((int *) buf);
+	size -= sizeof(int);
+
+	/* Don't load the saved path if one has already been set */
+	if (ui_helper_data.program[0])
+		return;
+
+	if (size > sizeof(ui_helper_data.program))
+		size = sizeof(ui_helper_data.program);
+
+	memcpy(ui_helper_data.program, buf + sizeof(int), size);
+	ui_helper_data.program[sizeof(ui_helper_data.program)-1] = '\0';
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
