Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWFNOGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWFNOGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWFNOGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:06:04 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:63092 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S964956AbWFNOGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:06:01 -0400
Date: Wed, 14 Jun 2006 16:05:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [patch 19/24] s390: Add vmpanic parameter.
Message-ID: <20060614140557.GT9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] Add vmpanic parameter.

Implementation of new kernel parameter vmpanic that provides a means to
perform a z/VM CP command after a kernel panic occurred.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/kernel-parameters.txt |    9 +++++++--
 arch/s390/kernel/setup.c            |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-06-14 14:29:44.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-06-14 14:29:58.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/seq_file.h>
 #include <linux/kernel_stat.h>
 #include <linux/device.h>
+#include <linux/notifier.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -123,6 +124,7 @@ void __devinit cpu_init (void)
  */
 char vmhalt_cmd[128] = "";
 char vmpoff_cmd[128] = "";
+char vmpanic_cmd[128] = "";
 
 static inline void strncpy_skip_quote(char *dst, char *src, int n)
 {
@@ -154,6 +156,38 @@ static int __init vmpoff_setup(char *str
 
 __setup("vmpoff=", vmpoff_setup);
 
+static int vmpanic_notify(struct notifier_block *self, unsigned long event,
+			  void *data)
+{
+	if (MACHINE_IS_VM && strlen(vmpanic_cmd) > 0)
+		cpcmd(vmpanic_cmd, NULL, 0, NULL);
+
+	return NOTIFY_OK;
+}
+
+#define PANIC_PRI_VMPANIC	0
+
+static struct notifier_block vmpanic_nb = {
+	.notifier_call = vmpanic_notify,
+	.priority = PANIC_PRI_VMPANIC
+};
+
+static int __init vmpanic_setup(char *str)
+{
+	static int register_done __initdata = 0;
+
+	strncpy_skip_quote(vmpanic_cmd, str, 127);
+	vmpanic_cmd[127] = 0;
+	if (!register_done) {
+		register_done = 1;
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &vmpanic_nb);
+	}
+	return 1;
+}
+
+__setup("vmpanic=", vmpanic_setup);
+
 /*
  * condev= and conmode= setup parameter.
  */
diff -urpN linux-2.6/Documentation/kernel-parameters.txt linux-2.6-patched/Documentation/kernel-parameters.txt
--- linux-2.6/Documentation/kernel-parameters.txt	2006-06-14 14:29:11.000000000 +0200
+++ linux-2.6-patched/Documentation/kernel-parameters.txt	2006-06-14 14:29:58.000000000 +0200
@@ -1662,9 +1662,14 @@ running once the system is up.
 			decrease the size and leave more room for directly
 			mapped kernel RAM.
 
-	vmhalt=		[KNL,S390]
+	vmhalt=		[KNL,S390] Perform z/VM CP command after system halt.
+			Format: <command>
 
-	vmpoff=		[KNL,S390]
+	vmpanic=	[KNL,S390] Perform z/VM CP command after kernel panic.
+			Format: <command>
+
+	vmpoff=		[KNL,S390] Perform z/VM CP command after power off.
+			Format: <command>
 
 	waveartist=	[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>
