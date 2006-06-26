Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933345AbWFZWnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933345AbWFZWnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933358AbWFZWmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:55 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:53431 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933349AbWFZWmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:33 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 25/28] [Suspend2] Read resume2= values for currently enabled swap.
Date: Tue, 27 Jun 2006 08:42:32 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224230.4975.36324.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get the values to use for resume2= for swap that is currently enabled.
Particularly useful for files, where we need the device and block offset.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   60 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index eb14e3e..ee7c36b 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -1080,3 +1080,63 @@ invalid:
 
 }
 
+static int header_locations_read_proc(char *page, char **start, off_t off, int count,
+		int *eof, void *data)
+{
+	int i, printedpartitionsmessage = 0, len = 0, haveswap = 0;
+	struct inode *swapf = 0;
+	int zone;
+	char *path_page = (char *) __get_free_page(GFP_KERNEL);
+	char *path;
+	int path_len;
+	
+	*eof = 1;
+	if (!page)
+		return 0;
+
+	for (i = 0; i < MAX_SWAPFILES; i++) {
+		struct swap_info_struct *si =  get_swap_info_struct(i);
+
+		if (!si->swap_file)
+			continue;
+		
+		if (S_ISBLK(si->swap_file->f_mapping->host->i_mode)) {
+			haveswap = 1;
+			if (!printedpartitionsmessage) {
+				len += sprintf(page + len, 
+					"For swap partitions, simply use the format: resume2=swap:/dev/hda1.\n");
+				printedpartitionsmessage = 1;
+			}
+		} else {
+			path_len = 0;
+			
+			path = d_path(si->swap_file->f_dentry,
+				si->swap_file->f_vfsmnt,
+				path_page,
+				PAGE_SIZE);
+			path_len = snprintf(path_page, 31, "%s", path);
+			
+			haveswap = 1;
+			swapf = si->swap_file->f_mapping->host;
+			if (!(zone = bmap(swapf,0))) {
+				len+= sprintf(page + len, 
+					"Swapfile %s has been corrupted. Reuse mkswap on it and try again.\n",
+					path_page);
+			} else {
+				char name_buffer[255];
+				len+= sprintf(page + len, "For swapfile `%s`, use resume2=swap:/dev/%s:0x%x.\n",
+						path_page,
+						bdevname(si->bdev, name_buffer),
+						zone << (swapf->i_blkbits - 9));
+			}
+
+		}
+	}
+	
+	if (!haveswap)
+		len = sprintf(page, "You need to turn on swap partitions before examining this file.\n");
+
+	free_page((unsigned long) path_page);
+	return len;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
