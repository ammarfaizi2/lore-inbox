Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936930AbWLDOyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936930AbWLDOyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936921AbWLDOyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:54:22 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:16535 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936945AbWLDOyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:54:14 -0500
Date: Mon, 4 Dec 2006 15:54:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] cpcmd <-> __cpcmd calling issues
Message-ID: <20061204145410.GR32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] cpcmd <-> __cpcmd calling issues

In case of reipl cpcmd gets called when all other cpus are not running
anymore. To prevent deadlocks change __cpcmd so that it doesn't take
any locks and call cpcmd or __cpcmd, whatever is correct in the current
context.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/cpcmd.c |   18 +++++++++++-------
 arch/s390/kernel/ipl.c   |   10 +++++-----
 arch/s390/kernel/setup.c |   10 +++++-----
 include/asm-s390/cpcmd.h |   10 +++-------
 4 files changed, 24 insertions(+), 24 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/cpcmd.c linux-2.6-patched/arch/s390/kernel/cpcmd.c
--- linux-2.6/arch/s390/kernel/cpcmd.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/cpcmd.c	2006-12-04 14:50:49.000000000 +0100
@@ -21,14 +21,15 @@ static DEFINE_SPINLOCK(cpcmd_lock);
 static char cpcmd_buf[241];
 
 /*
- * the caller of __cpcmd has to ensure that the response buffer is below 2 GB
+ * __cpcmd has some restrictions over cpcmd
+ *  - the response buffer must reside below 2GB (if any)
+ *  - __cpcmd is unlocked and therefore not SMP-safe
  */
 int  __cpcmd(const char *cmd, char *response, int rlen, int *response_code)
 {
-	unsigned long flags, cmdlen;
+	unsigned cmdlen;
 	int return_code, return_len;
 
-	spin_lock_irqsave(&cpcmd_lock, flags);
 	cmdlen = strlen(cmd);
 	BUG_ON(cmdlen > 240);
 	memcpy(cpcmd_buf, cmd, cmdlen);
@@ -74,7 +75,6 @@ int  __cpcmd(const char *cmd, char *resp
 			: "+d" (reg3) : "d" (reg2) : "cc");
 		return_code = (int) reg3;
         }
-	spin_unlock_irqrestore(&cpcmd_lock, flags);
 	if (response_code != NULL)
 		*response_code = return_code;
 	return return_len;
@@ -82,15 +82,18 @@ int  __cpcmd(const char *cmd, char *resp
 
 EXPORT_SYMBOL(__cpcmd);
 
-#ifdef CONFIG_64BIT
 int cpcmd(const char *cmd, char *response, int rlen, int *response_code)
 {
 	char *lowbuf;
 	int len;
+	unsigned long flags;
 
 	if ((rlen == 0) || (response == NULL)
-	    || !((unsigned long)response >> 31))
+	    || !((unsigned long)response >> 31)) {
+		spin_lock_irqsave(&cpcmd_lock, flags);
 		len = __cpcmd(cmd, response, rlen, response_code);
+		spin_unlock_irqrestore(&cpcmd_lock, flags);
+	}
 	else {
 		lowbuf = kmalloc(rlen, GFP_KERNEL | GFP_DMA);
 		if (!lowbuf) {
@@ -98,7 +101,9 @@ int cpcmd(const char *cmd, char *respons
 				"cpcmd: could not allocate response buffer\n");
 			return -ENOMEM;
 		}
+		spin_lock_irqsave(&cpcmd_lock, flags);
 		len = __cpcmd(cmd, lowbuf, rlen, response_code);
+		spin_unlock_irqrestore(&cpcmd_lock, flags);
 		memcpy(response, lowbuf, rlen);
 		kfree(lowbuf);
 	}
@@ -106,4 +111,3 @@ int cpcmd(const char *cmd, char *respons
 }
 
 EXPORT_SYMBOL(cpcmd);
-#endif		/* CONFIG_64BIT */
diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2006-12-04 14:50:48.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-12-04 14:50:49.000000000 +0100
@@ -677,7 +677,7 @@ void do_reipl(void)
 		else
 			sprintf(buf, "IPL %X LOADPARM '%s'",
 				reipl_block_ccw->ipl_info.ccw.devno, loadparm);
-		cpcmd(buf, NULL, 0, NULL);
+		__cpcmd(buf, NULL, 0, NULL);
 		break;
 	case IPL_METHOD_CCW_DIAG:
 		diag308(DIAG308_SET, reipl_block_ccw);
@@ -691,12 +691,12 @@ void do_reipl(void)
 		diag308(DIAG308_IPL, NULL);
 		break;
 	case IPL_METHOD_FCP_RO_VM:
-		cpcmd("IPL", NULL, 0, NULL);
+		__cpcmd("IPL", NULL, 0, NULL);
 		break;
 	case IPL_METHOD_NONE:
 	default:
 		if (MACHINE_IS_VM)
-			cpcmd("IPL", NULL, 0, NULL);
+			__cpcmd("IPL", NULL, 0, NULL);
 		diag308(DIAG308_IPL, NULL);
 		break;
 	}
@@ -732,9 +732,9 @@ static void do_dump(void)
 	case IPL_METHOD_CCW_VM:
 		dump_smp_stop_all();
 		sprintf(buf, "STORE STATUS");
-		cpcmd(buf, NULL, 0, NULL);
+		__cpcmd(buf, NULL, 0, NULL);
 		sprintf(buf, "IPL %X", dump_block_ccw->ipl_info.ccw.devno);
-		cpcmd(buf, NULL, 0, NULL);
+		__cpcmd(buf, NULL, 0, NULL);
 		break;
 	case IPL_METHOD_CCW_DIAG:
 		diag308(DIAG308_SET, dump_block_ccw);
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-12-04 14:50:49.000000000 +0100
@@ -229,11 +229,11 @@ static void __init conmode_default(void)
 	char *ptr;
 
         if (MACHINE_IS_VM) {
-		__cpcmd("QUERY CONSOLE", query_buffer, 1024, NULL);
+		cpcmd("QUERY CONSOLE", query_buffer, 1024, NULL);
 		console_devno = simple_strtoul(query_buffer + 5, NULL, 16);
 		ptr = strstr(query_buffer, "SUBCHANNEL =");
 		console_irq = simple_strtoul(ptr + 13, NULL, 16);
-		__cpcmd("QUERY TERM", query_buffer, 1024, NULL);
+		cpcmd("QUERY TERM", query_buffer, 1024, NULL);
 		ptr = strstr(query_buffer, "CONMODE");
 		/*
 		 * Set the conmode to 3215 so that the device recognition 
@@ -242,7 +242,7 @@ static void __init conmode_default(void)
 		 * 3215 and the 3270 driver will try to access the console
 		 * device (3215 as console and 3270 as normal tty).
 		 */
-		__cpcmd("TERM CONMODE 3215", NULL, 0, NULL);
+		cpcmd("TERM CONMODE 3215", NULL, 0, NULL);
 		if (ptr == NULL) {
 #if defined(CONFIG_SCLP_CONSOLE)
 			SET_CONSOLE_SCLP;
@@ -299,14 +299,14 @@ static void do_machine_restart_nonsmp(ch
 static void do_machine_halt_nonsmp(void)
 {
         if (MACHINE_IS_VM && strlen(vmhalt_cmd) > 0)
-                cpcmd(vmhalt_cmd, NULL, 0, NULL);
+		__cpcmd(vmhalt_cmd, NULL, 0, NULL);
         signal_processor(smp_processor_id(), sigp_stop_and_store_status);
 }
 
 static void do_machine_power_off_nonsmp(void)
 {
         if (MACHINE_IS_VM && strlen(vmpoff_cmd) > 0)
-                cpcmd(vmpoff_cmd, NULL, 0, NULL);
+		__cpcmd(vmpoff_cmd, NULL, 0, NULL);
         signal_processor(smp_processor_id(), sigp_stop_and_store_status);
 }
 
diff -urpN linux-2.6/include/asm-s390/cpcmd.h linux-2.6-patched/include/asm-s390/cpcmd.h
--- linux-2.6/include/asm-s390/cpcmd.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/cpcmd.h	2006-12-04 14:50:49.000000000 +0100
@@ -7,8 +7,8 @@
  *               Christian Borntraeger (cborntra@de.ibm.com),
  */
 
-#ifndef __CPCMD__
-#define __CPCMD__
+#ifndef _ASM_S390_CPCMD_H
+#define _ASM_S390_CPCMD_H
 
 /*
  * the lowlevel function for cpcmd
@@ -16,9 +16,6 @@
  */
 extern int __cpcmd(const char *cmd, char *response, int rlen, int *response_code);
 
-#ifndef __s390x__
-#define cpcmd __cpcmd
-#else
 /*
  * cpcmd is the in-kernel interface for issuing CP commands
  *
@@ -33,6 +30,5 @@ extern int __cpcmd(const char *cmd, char
  * NOTE: If the response buffer is not below 2 GB, cpcmd can sleep
  */
 extern int cpcmd(const char *cmd, char *response, int rlen, int *response_code);
-#endif /*__s390x__*/
 
-#endif
+#endif /* _ASM_S390_CPCMD_H */
