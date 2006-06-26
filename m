Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933377AbWFZW5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377AbWFZW5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933312AbWFZW4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:56:33 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31415 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933302AbWFZWkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:37 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 27/35] [Suspend2] Set filewriter resume2, having been given a filename.
Date: Tue, 27 Jun 2006 08:40:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224034.4685.75812.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the resume2= value when the user has echoed to filewriter_target and
we've verified that an image exists in that file. The user can then read
the value and modify their bootloader or initrd to set the value to the
same thing when resuming.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 20d0807..2e19aae 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -799,3 +799,32 @@ static void filewriter_mark_resume_attem
 	filewriter_signature_op(MARK_RESUME_ATTEMPTED);
 }
 
+static void filewriter_set_resume2(void)
+{
+	char *buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	char *buffer2 = (char *) get_zeroed_page(GFP_ATOMIC);
+	unsigned long sector = bmap(target_inode, 0);
+	int offset = 0;
+
+	if (filewriter_target_bdev) {
+		set_devinfo(filewriter_target_bdev, target_inode->i_blkbits);
+
+		bdevname(filewriter_target_bdev, buffer2);
+		offset += snprintf(buffer + offset, PAGE_SIZE - offset, 
+				"/dev/%s", buffer2);
+		
+		if (sector)
+			offset += snprintf(buffer + offset, PAGE_SIZE - offset,
+				":0x%lx", sector << devinfo.bmap_shift);
+	} else
+		offset += snprintf(buffer + offset, PAGE_SIZE - offset,
+				"%s is not a valid target.", filewriter_target);
+			
+	sprintf(resume2_file, "file:%s", buffer);
+
+	free_page((unsigned long) buffer);
+	free_page((unsigned long) buffer2);
+
+	suspend_attempt_to_parse_resume_device();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
