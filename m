Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933351AbWFZWnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933351AbWFZWnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933355AbWFZWm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:52919 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933348AbWFZWma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:30 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 24/28] [Suspend2] Swapwriter parse resume2=
Date: Tue, 27 Jun 2006 08:42:28 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224227.4975.97297.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to parse the resume2= value as a swapwriter target, checking that
the device can be accessed and that the header is recognised.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |  113 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 683797a..eb14e3e 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -967,3 +967,116 @@ static void swapwriter_mark_resume_attem
 	return;
 }
 
+/*
+ * Parse Image Location
+ *
+ * Attempt to parse a resume2= parameter.
+ * Swap Writer accepts:
+ * resume2=swap:DEVNAME[:FIRSTBLOCK][@BLOCKSIZE]
+ *
+ * Where:
+ * DEVNAME is convertable to a dev_t by name_to_dev_t
+ * FIRSTBLOCK is the location of the first block in the swap file
+ * (specifying for a swap partition is nonsensical but not prohibited).
+ * Data is validated by attempting to read a swap header from the
+ * location given. Failure will result in swapwriter refusing to
+ * save an image, and a reboot with correct parameters will be
+ * necessary.
+ */
+
+static int swapwriter_parse_sig_location(char *commandline, int only_writer)
+{
+	char *thischar, *devstart, *colon = NULL, *at_symbol = NULL;
+	union p_diskpage diskpage;
+	int signature_found, result = -EINVAL, temp_result;
+
+	if (strncmp(commandline, "swap:", 5)) {
+		if (!only_writer)
+			return 1;
+	} else
+		commandline += 5;
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
+	if (colon)
+		resume_firstblock = (int) simple_strtoul(colon + 1, NULL, 0);
+	else
+		resume_firstblock = 0;
+
+	clear_suspend_state(SUSPEND_CAN_SUSPEND);
+	clear_suspend_state(SUSPEND_CAN_RESUME);
+	
+	/* Legacy */
+	if (at_symbol) {
+		resume_blocksize = (int) simple_strtoul(at_symbol + 1, NULL, 0);
+		if (resume_blocksize & (SECTOR_SIZE - 1)) {
+			printk("Swapwriter: Blocksizes are multiples of %d!\n", SECTOR_SIZE);
+			return -EINVAL;
+		}
+		resume_firstblock = resume_firstblock * (resume_blocksize / SECTOR_SIZE);
+	}
+	
+	temp_result = try_to_parse_resume_device(devstart);
+
+	if (colon)
+		*colon = ':';
+	if (at_symbol)
+		*at_symbol = '@';
+
+	if (temp_result)
+		return -EINVAL;
+
+	diskpage.address = get_zeroed_page(GFP_ATOMIC);
+	if (!diskpage.address) {
+		printk(KERN_ERR name_suspend "Swapwriter: Failed to allocate a diskpage for I/O.\n");
+		return -ENOMEM;
+	}
+
+	temp_result = suspend_bio_ops.bdev_page_io(READ,
+			resume_block_device,
+			resume_firstblock,
+			virt_to_page(diskpage.ptr));
+
+	suspend_bio_ops.finish_all_io();
+	
+	if (temp_result) {
+		printk(KERN_ERR name_suspend "Swapwriter: Failed to submit I/O.\n");
+		goto invalid;
+	}
+	
+	signature_found = parse_signature(diskpage.pointer->swh.magic.magic, 0);
+
+	if (signature_found != -1) {
+		printk(name_suspend "Swapwriter: Signature found.\n");
+		result = 0;
+
+		suspend_bio_ops.set_devinfo(devinfo);
+		suspend_writer_posn.chains = &block_chain[0];
+		suspend_writer_posn.num_chains = MAX_SWAPFILES;
+		set_suspend_state(SUSPEND_CAN_SUSPEND);
+		set_suspend_state(SUSPEND_CAN_RESUME);
+	} else
+		printk(KERN_ERR name_suspend "Swapwriter: No swap signature found at specified location.\n");
+invalid:
+	free_page((unsigned long) diskpage.address);
+	return result;
+
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
