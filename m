Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVCaKux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVCaKux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVCaKux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:50:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:25786 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261234AbVCaKug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:50:36 -0500
Message-ID: <424BD60A.1070409@in.ibm.com>
Date: Thu, 31 Mar 2005 16:20:50 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>
Subject: [PATCH] Sysrq trigger mechanism for kexec based crashdumps
Content-Type: multipart/mixed;
 boundary="------------020009040301030608010206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020009040301030608010206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

The following patch adds a sysrq-trigger mechanism for kexec 
based crashdumps. Alt-Sysrq-c triggers a kexec based 
crashdump. Please include this along with the crashdumps 
patches in the -mm tree.

Thanks and Regards, Hari

--------------020009040301030608010206
Content-Type: text/plain;
 name="crashdump-sysrq-trigger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="crashdump-sysrq-trigger.patch"



Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.12-rc1-mm3-1M-hari/Documentation/sysrq.txt |    5 +++
 linux-2.6.12-rc1-mm3-1M-hari/drivers/char/sysrq.c    |   24 +++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff -puN Documentation/sysrq.txt~crashdump-sysrq-trigger Documentation/sysrq.txt
--- linux-2.6.12-rc1-mm3-1M/Documentation/sysrq.txt~crashdump-sysrq-trigger	2005-03-31 15:56:06.000000000 +0530
+++ linux-2.6.12-rc1-mm3-1M-hari/Documentation/sysrq.txt	2005-03-31 16:01:09.000000000 +0530
@@ -72,6 +72,8 @@ On all -  write a character to /proc/sys
 'b'     - Will immediately reboot the system without syncing or unmounting
           your disks.
 
+'c'	- Will perform a kexec reboot in order to take a crashdump.
+
 'o'     - Will shut your system off (if configured and supported).
 
 's'     - Will attempt to sync all mounted filesystems.
@@ -122,6 +124,9 @@ useful when you want to exit a program t
 re'B'oot is good when you're unable to shut down. But you should also 'S'ync
 and 'U'mount first.
 
+'C'rashdump can be used to manually trigger a crashdump when the system is hung.
+The kernel needs to have been built with CONFIG_KEXEC enabled.
+
 'S'ync is great when your system is locked up, it allows you to sync your
 disks and will certainly lessen the chance of data loss and fscking. Note
 that the sync hasn't taken place until you see the "OK" and "Done" appear
diff -puN drivers/char/sysrq.c~crashdump-sysrq-trigger drivers/char/sysrq.c
--- linux-2.6.12-rc1-mm3-1M/drivers/char/sysrq.c~crashdump-sysrq-trigger	2005-03-31 15:56:06.000000000 +0530
+++ linux-2.6.12-rc1-mm3-1M-hari/drivers/char/sysrq.c	2005-03-31 16:03:21.000000000 +0530
@@ -34,6 +34,7 @@
 #include <linux/swap.h>
 #include <linux/spinlock.h>
 #include <linux/vt_kern.h>
+#include <linux/kexec.h>
 
 #include <asm/ptrace.h>
 #ifdef CONFIG_KGDB_SYSRQ
@@ -112,6 +113,21 @@ static struct sysrq_key_op sysrq_unraw_o
 };
 #endif /* CONFIG_VT */
 
+#ifdef CONFIG_KEXEC
+/* crashdump sysrq handler */
+static void sysrq_handle_crashdump(int key, struct pt_regs *pt_regs,
+				struct tty_struct *tty)
+{
+	crash_kexec();
+}
+static struct sysrq_key_op sysrq_crashdump_op = {
+	.handler	= sysrq_handle_crashdump,
+	.help_msg	= "Crashdump",
+	.action_msg	= "Trigger a crashdump",
+	.enable_mask	= SYSRQ_ENABLE_DUMP,
+};
+#endif
+
 /* reboot sysrq handler */
 static void sysrq_handle_reboot(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty) 
@@ -285,8 +301,12 @@ static struct sysrq_key_op *sysrq_key_ta
 		 it is handled specially on the sparc
 		 and will never arrive */
 /* b */	&sysrq_reboot_op,
-/* c */ NULL,
-/* d */	NULL,
+#ifdef CONFIG_KEXEC
+/* c */ &sysrq_crashdump_op,
+#else
+/* c */	NULL,
+#endif
+/* d */ NULL,
 /* e */	&sysrq_term_op,
 /* f */	&sysrq_moom_op,
 /* g */	GDB_OP,
_

--------------020009040301030608010206--
