Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWFZWyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWFZWyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWFZWyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:54:54 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32951 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933309AbWFZWks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 30/35] [Suspend2] Filewriter parse resume2 parameter.
Date: Tue, 27 Jun 2006 08:40:46 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224045.4685.91165.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parse a resume2= value to see if it is for the filewriter's use (file:
prefix or filewriter is the only writer registered), and whether it points
to a device we can open and a header we recognise.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |  116 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 56de7d9..ee371ce 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -872,3 +872,119 @@ static void test_filewriter_target(void)
 	setting_filewriter_target = 0;
 }
 
+/*
+ * Parse Image Location
+ *
+ * Attempt to parse a resume2= parameter.
+ * Swap Writer accepts:
+ * resume2=file:DEVNAME[:FIRSTBLOCK]
+ *
+ * Where:
+ * DEVNAME is convertable to a dev_t by name_to_dev_t
+ * FIRSTBLOCK is the location of the first block in the file.
+ * BLOCKSIZE is the logical blocksize >= SECTOR_SIZE & <= PAGE_SIZE, 
+ * mod SECTOR_SIZE == 0 of the device.
+ * Data is validated by attempting to read a header from the
+ * location given. Failure will result in filewriter refusing to
+ * save an image, and a reboot with correct parameters will be
+ * necessary.
+ */
+
+static int filewriter_parse_sig_location(char *commandline, int only_writer)
+{
+	char *thischar, *devstart = NULL, *colon = NULL, *at_symbol = NULL;
+	int result = -EINVAL, target_blocksize = 0;
+
+	if (strncmp(commandline, "file:", 5)) {
+		if (!only_writer)
+			return 1;
+	} else
+		commandline += 5;
+
+	/* 
+	 * Don't check signature again if we're beginning a cycle. If we already
+	 * did the initialisation successfully, assume we'll be okay when it comes
+	 * to resuming.
+	 */
+	if (filewriter_target_bdev)
+		return 0;
+	
+	devstart = thischar = commandline;
+	while ((*thischar != ':') && (*thischar != '@') &&
+		((thischar - commandline) < 250) && (*thischar))
+		thischar++;
+
+	if (*thischar == ':') {
+		colon = thischar;
+		*colon = 0;
+		thischar++;
+	}
+
+	while ((*thischar != '@') && ((thischar - commandline) < 250) && (*thischar))
+		thischar++;
+
+	if (*thischar == '@') {
+		at_symbol = thischar;
+		*at_symbol = 0;
+	}
+	
+	/* 
+	 * For the filewriter, you can be able to resume, but not suspend,
+	 * because the resume2= is set correctly, but the filewriter_target
+	 * isn't. 
+	 *
+	 * We may have come here as a result of setting resume2 or
+	 * filewriter_target. We only test the filewriter target in the
+	 * former case (it's already done in the later), and we do it before
+	 * setting the block number ourselves. It will overwrite the values
+	 * given on the command line if we don't.
+	 */
+
+	if (!setting_filewriter_target)
+		__test_filewriter_target(filewriter_target, 1);
+
+	if (colon)
+		target_firstblock = (int) simple_strtoul(colon + 1, NULL, 0);
+	else
+		target_firstblock = 0;
+
+	if (at_symbol) {
+		target_blocksize = (int) simple_strtoul(at_symbol + 1, NULL, 0);
+		if (target_blocksize & (SECTOR_SIZE - 1)) {
+			printk("Filewriter: Blocksizes are multiples of %d.\n", SECTOR_SIZE);
+			result = -EINVAL;
+			goto out;
+		}
+	}
+	
+	printk("Suspend2 Filewriter: Testing whether you can resume:\n");
+
+	filewriter_get_target_info(commandline, 0, 1);
+
+	if (!filewriter_target_bdev || IS_ERR(filewriter_target_bdev)) {
+		filewriter_target_bdev = NULL;
+		result = -1;
+		goto out;
+	}
+
+	if (target_blocksize)
+		set_devinfo(filewriter_target_bdev, ffs(target_blocksize));
+
+	result = __test_filewriter_target(commandline, 1);
+
+out:
+	if (result)
+		clear_suspend_state(SUSPEND_CAN_SUSPEND);
+	else
+		set_suspend_state(SUSPEND_CAN_SUSPEND);
+
+	printk("Resuming %sabled.\n",  result ? "dis" : "en");
+
+	if (colon)
+		*colon = ':';
+	if (at_symbol)
+		*at_symbol = '@';
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
