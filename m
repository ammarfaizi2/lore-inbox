Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTISTr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTISTr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:47:29 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:33188 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261696AbTISTrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:47:24 -0400
Subject: [PATCH 2/5] Fix a warning in input.c when CONFIG_PROC_FS is not set
In-Reply-To: <10640008343413@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 21:47:15 +0200
Message-Id: <10640008352019@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1351, 2003-09-19 13:23:54+02:00, lcapitulino@prefeitura.sp.gov.br
  input: Fix a warning in input.c when CONFIG_PROC_FS is not set.


 input.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Fri Sep 19 14:12:57 2003
+++ b/drivers/input/input.c	Fri Sep 19 14:12:57 2003
@@ -678,20 +678,10 @@
 	return (count > cnt) ? cnt : count;
 }
 
-#endif
-
-struct class input_class = {
-	.name		= "input",
-};
-
-static int __init input_init(void)
+static int __init input_proc_init(void)
 {
 	struct proc_dir_entry *entry;
-	int retval = -ENOMEM;
-
-	class_register(&input_class);
 
-#ifdef CONFIG_PROC_FS
 	proc_bus_input_dir = proc_mkdir("input", proc_bus);
 	if (proc_bus_input_dir == NULL)
 		return -ENOMEM;
@@ -710,7 +700,22 @@
 		return -ENOMEM;
 	}
 	entry->owner = THIS_MODULE;
+	return 0;
+}
+#else /* !CONFIG_PROC_FS */
+static inline int input_proc_init(void) { return 0; }
 #endif
+
+struct class input_class = {
+	.name		= "input",
+};
+
+static int __init input_init(void)
+{
+	int retval = -ENOMEM;
+
+	class_register(&input_class);
+	input_proc_init();
 	retval = register_chrdev(INPUT_MAJOR, "input", &input_fops);
 	if (retval) {
 		printk(KERN_ERR "input: unable to register char major %d", INPUT_MAJOR);

