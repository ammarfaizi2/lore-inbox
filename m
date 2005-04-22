Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVDVPHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVDVPHg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVDVPHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:07:08 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:4231 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261965AbVDVPAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:00:52 -0400
Date: Fri, 22 Apr 2005 17:00:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/12] s390: cmm guest sender id.
Message-ID: <20050422150019.GE17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/12] s390: cmm guest sender id.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

An arbitrary guest must not be allowed to trigger cmm actions.
Only one specific guest namely the one that serves as the
resource monitor may send cmm messages. Add a parameter that
allows to specify the guest that may send messages. z/VMs
resource manager has the name 'VMRMSVM' which is the default.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/cmm.c          |    9 ++++++++-
 drivers/s390/net/smsgiucv.c |   19 ++++++++++++++-----
 drivers/s390/net/smsgiucv.h |    4 ++--
 3 files changed, 24 insertions(+), 8 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/cmm.c linux-2.6-patched/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/cmm.c	2005-04-22 15:45:02.000000000 +0200
@@ -20,6 +20,11 @@
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 
+static char *sender = "VMRMSVM";
+module_param(sender, charp, 0);
+MODULE_PARM_DESC(sender,
+		 "Guest name that may send SMSG messages (default VMRMSVM)");
+
 #include "../../../drivers/s390/net/smsgiucv.h"
 
 #define CMM_NR_PAGES ((PAGE_SIZE / sizeof(unsigned long)) - 2)
@@ -367,10 +372,12 @@ static struct ctl_table cmm_dir_table[] 
 #ifdef CONFIG_CMM_IUCV
 #define SMSG_PREFIX "CMM"
 static void
-cmm_smsg_target(char *msg)
+cmm_smsg_target(char *from, char *msg)
 {
 	long pages, seconds;
 
+	if (strlen(sender) > 0 && strcmp(from, sender) != 0)
+		return;
 	if (!cmm_skip_blanks(msg + strlen(SMSG_PREFIX), &msg))
 		return;
 	if (strncmp(msg, "SHRINK", 6) == 0) {
diff -urpN linux-2.6/drivers/s390/net/smsgiucv.c linux-2.6-patched/drivers/s390/net/smsgiucv.c
--- linux-2.6/drivers/s390/net/smsgiucv.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/smsgiucv.c	2005-04-22 15:45:02.000000000 +0200
@@ -32,7 +32,7 @@ struct smsg_callback {
 	struct list_head list;
 	char *prefix;
 	int len;
-	void (*callback)(char *str);
+	void (*callback)(char *from, char *str);
 };
 
 MODULE_AUTHOR
@@ -55,8 +55,9 @@ smsg_message_pending(iucv_MessagePending
 {
 	struct smsg_callback *cb;
 	unsigned char *msg;
+	unsigned char sender[9];
 	unsigned short len;
-	int rc;
+	int rc, i;
 
 	len = eib->ln1msg2.ipbfln1f;
 	msg = kmalloc(len + 1, GFP_ATOMIC|GFP_DMA);
@@ -69,10 +70,18 @@ smsg_message_pending(iucv_MessagePending
 	if (rc == 0) {
 		msg[len] = 0;
 		EBCASC(msg, len);
+		memcpy(sender, msg, 8);
+		sender[8] = 0;
+		/* Remove trailing whitespace from the sender name. */
+		for (i = 7; i >= 0; i--) {
+			if (sender[i] != ' ' && sender[i] != '\t')
+				break;
+			sender[i] = 0;
+		}
 		spin_lock(&smsg_list_lock);
 		list_for_each_entry(cb, &smsg_list, list)
 			if (strncmp(msg + 8, cb->prefix, cb->len) == 0) {
-				cb->callback(msg + 8);
+				cb->callback(sender, msg + 8);
 				break;
 			}
 		spin_unlock(&smsg_list_lock);
@@ -91,7 +100,7 @@ static struct device_driver smsg_driver 
 };
 
 int
-smsg_register_callback(char *prefix, void (*callback)(char *str))
+smsg_register_callback(char *prefix, void (*callback)(char *from, char *str))
 {
 	struct smsg_callback *cb;
 
@@ -108,7 +117,7 @@ smsg_register_callback(char *prefix, voi
 }
 
 void
-smsg_unregister_callback(char *prefix, void (*callback)(char *str))
+smsg_unregister_callback(char *prefix, void (*callback)(char *from, char *str))
 {
 	struct smsg_callback *cb, *tmp;
 
diff -urpN linux-2.6/drivers/s390/net/smsgiucv.h linux-2.6-patched/drivers/s390/net/smsgiucv.h
--- linux-2.6/drivers/s390/net/smsgiucv.h	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/smsgiucv.h	2005-04-22 15:45:02.000000000 +0200
@@ -5,6 +5,6 @@
  * Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
-int  smsg_register_callback(char *, void (*)(char *));
-void smsg_unregister_callback(char *, void (*)(char *));
+int  smsg_register_callback(char *, void (*)(char *, char *));
+void smsg_unregister_callback(char *, void (*)(char *, char *));
 
