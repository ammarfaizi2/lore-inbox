Return-Path: <linux-kernel-owner+w=401wt.eu-S1751451AbXAOWO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbXAOWO5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 17:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXAOWO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 17:14:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:42039 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbXAOWO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 17:14:56 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Mqanmut9yDFXfl9qbZYaNRIlHXMYiqdEXhLhswQbg/LgTDIh6gsSdCEHDT+K5UXruKhI9RVDNIHe8uWn5j+4P9u+d/p3l/7f4wA2iB7y8oXrMOVqmivRPblN6CuPxrDHRBsmqZFh0o+EL/jprjuawHdx6QMhHyHvOPw0TFYb+g8=
Date: Tue, 16 Jan 2007 01:14:32 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] seq_file conversion: toshiba.c
Message-ID: <20070115221432.GA31293@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile-tested.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/toshiba.c |   35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

--- a/drivers/char/toshiba.c
+++ b/drivers/char/toshiba.c
@@ -68,6 +68,7 @@ #include <asm/uaccess.h>
 #include <linux/init.h>
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 #include <linux/toshiba.h>
 
@@ -298,12 +299,10 @@ static int tosh_ioctl(struct inode *ip, 
  * Print the information for /proc/toshiba
  */
 #ifdef CONFIG_PROC_FS
-static int tosh_get_info(char *buffer, char **start, off_t fpos, int length)
+static int proc_toshiba_show(struct seq_file *m, void *v)
 {
-	char *temp;
 	int key;
 
-	temp = buffer;
 	key = tosh_fn_status();
 
 	/* Arguments
@@ -314,8 +313,7 @@ static int tosh_get_info(char *buffer, c
 	     4) BIOS date (in SCI date format)
 	     5) Fn Key status
 	*/
-
-	temp += sprintf(temp, "1.1 0x%04x %d.%d %d.%d 0x%04x 0x%02x\n",
+	seq_printf(m, "1.1 0x%04x %d.%d %d.%d 0x%04x 0x%02x\n",
 		tosh_id,
 		(tosh_sci & 0xff00)>>8,
 		tosh_sci & 0xff,
@@ -323,9 +321,21 @@ static int tosh_get_info(char *buffer, c
 		tosh_bios & 0xff,
 		tosh_date,
 		key);
+	return 0;
+}
 
-	return temp-buffer;
+static int proc_toshiba_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_toshiba_show, NULL);
 }
+
+static const struct file_operations proc_toshiba_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_toshiba_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 #endif
 
 
@@ -508,10 +518,15 @@ static int __init toshiba_init(void)
 		return retval;
 
 #ifdef CONFIG_PROC_FS
-	/* register the proc entry */
-	if (create_proc_info_entry("toshiba", 0, NULL, tosh_get_info) == NULL) {
-		misc_deregister(&tosh_device);
-		return -ENOMEM;
+	{
+		struct proc_dir_entry *pde;
+
+		pde = create_proc_entry("toshiba", 0, NULL);
+		if (!pde) {
+			misc_deregister(&tosh_device);
+			return -ENOMEM;
+		}
+		pde->proc_fops = &proc_toshiba_fops;
 	}
 #endif
 

