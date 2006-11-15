Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966610AbWKOBbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966610AbWKOBbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 20:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966613AbWKOBbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 20:31:14 -0500
Received: from elvis.mu.org ([192.203.228.196]:49397 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S966610AbWKOBbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 20:31:14 -0500
Message-ID: <455A6DD8.4020608@FreeBSD.org>
Date: Tue, 14 Nov 2006 17:31:04 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Always print out the header line in /proc/swaps
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be possible for /proc/swaps to not always print out the header:

swapon /dev/hdc2
swapon /dev/hde2
swapoff /dev/hdc2

At this point /proc/swaps would not have a header.

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 mm/swapfile.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a15def6..8e206ce 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1274,10 +1274,13 @@ static void *swap_start(struct seq_file 
 
 	mutex_lock(&swapon_mutex);
 
+	if (!l)
+		return SEQ_START_TOKEN;
+
 	for (i = 0; i < nr_swapfiles; i++, ptr++) {
 		if (!(ptr->flags & SWP_USED) || !ptr->swap_map)
 			continue;
-		if (!l--)
+		if (!--l)
 			return ptr;
 	}
 
@@ -1286,10 +1289,17 @@ static void *swap_start(struct seq_file 
 
 static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 {
-	struct swap_info_struct *ptr = v;
+	struct swap_info_struct *ptr;
 	struct swap_info_struct *endptr = swap_info + nr_swapfiles;
 
-	for (++ptr; ptr < endptr; ptr++) {
+	if (v == SEQ_START_TOKEN)
+		ptr = swap_info;
+	else {
+		ptr = v;
+		ptr++;
+	}
+
+	for (; ptr < endptr; ptr++) {
 		if (!(ptr->flags & SWP_USED) || !ptr->swap_map)
 			continue;
 		++*pos;
@@ -1310,8 +1320,10 @@ static int swap_show(struct seq_file *sw
 	struct file *file;
 	int len;
 
-	if (v == swap_info)
-		seq_puts(swap, "Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
+	if (ptr == SEQ_START_TOKEN) {
+		seq_puts(swap,"Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
+		return 0;
+	}
 
 	file = ptr->swap_file;
 	len = seq_path(swap, file->f_vfsmnt, file->f_dentry, " \t\n\\");


