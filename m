Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbUC2RDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUC2RDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:03:43 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:58820 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S263031AbUC2Qeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 11:34:44 -0500
Date: Mon, 29 Mar 2004 09:34:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: [PATCH][KGDB] Move i386 hw breakpoint bits into non-lite
Message-ID: <20040329163443.GG2895@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following interdiffs accomplish the following:
- core-lite: Add an API to clear all hw breakpoints, and clarify the
  logic of handling z[01] packets.  Also rename set_break/remove_break
  to kgdb_set/remove_sw_break.
- i386-lite: Remove all of the hw-breakpoint code, as it might only be
  working for 'y'/'Y' packets and most certainly not for anything else
  right now.
- i386.patch: Consolidate both versions of the hw-breakpoint code into
  one set of functions.  This is incomplete, and I'm not convinced that
  it worked before with a 'y' / 'Y' packet.
- core.patch: Make this apply still and add the hw_breakpoint hooks to
  the documentation.  I plan on re-organizing this a bit more, and will
  hopefully have another patch, against this later today. (Not posted
  since interdiff wasn't liking it).

This has been tested on i386 + 8250, and I'd like to check this in
noon -0700, 30 March.

diff -u linux-2.6.4/include/linux/kgdb.h linux-2.6.4/include/linux/kgdb.h
--- linux-2.6.4/include/linux/kgdb.h	2004-03-19 08:22:37.143170735 -0700
+++ linux-2.6.4/include/linux/kgdb.h	2004-03-29 08:50:26.510296479 -0700
@@ -84,8 +84,9 @@
 extern int kgdb_arch_handle_exception(int vector, int signo, int err_code,
 				      char *InBuffer, char *outBuffer,
 				      struct pt_regs *regs);
-extern int kgdb_arch_set_break(unsigned long addr, int type);
-extern int kgdb_arch_remove_break(unsigned long addr, int type);
+extern int kgdb_set_hw_break(unsigned long addr);
+extern int kgdb_remove_hw_break(unsigned long addr);
+extern void kgdb_remove_all_hw_break(void);
 extern void kgdb_correct_hw_break(void);
 extern void kgdb_shadowinfo(struct pt_regs *regs, char *buffer,
 			    unsigned threadid);
diff -u linux-2.6.4/kernel/kgdb.c linux-2.6.4/kernel/kgdb.c
--- linux-2.6.4/kernel/kgdb.c	2004-03-19 08:22:37.147169789 -0700
+++ linux-2.6.4/kernel/kgdb.c	2004-03-29 08:51:14.137620137 -0700
@@ -157,18 +157,23 @@
 }
 
 int __attribute__ ((weak))
-    kgdb_arch_set_break(unsigned long addr, int type)
+    kgdb_set_hw_break(unsigned long addr)
 {
 	return 0;
 }
 
 int __attribute__ ((weak))
-    kgdb_arch_remove_break(unsigned long addr, int type)
+    kgdb_remove_hw_break(unsigned long addr)
 {
 	return 0;
 }
 
 void __attribute__ ((weak))
+     kgdb_remove_all_hw_break(void)
+{
+}
+
+void __attribute__ ((weak))
     kgdb_correct_hw_break(void)
 {
 }
@@ -206,7 +211,6 @@
 {
 	unsigned char checksum;
 	unsigned char xmitcsum;
-	int i;
 	int count;
 	char ch;
 
@@ -540,7 +544,7 @@
 	return 0;
 }
 
-static int set_break(unsigned long addr)
+static int kgdb_set_sw_break(unsigned long addr)
 {
 	int i, breakno = -1;
 	int error;
@@ -576,7 +580,7 @@
 	return 0;
 }
 
-static int remove_break(unsigned long addr)
+static int kgdb_remove_sw_break(unsigned long addr)
 {
 	int i;
 	int error;
@@ -602,6 +606,8 @@
 {
 	int i;
 	int error;
+
+	/* Clear memory breakpoints. */
 	for (i = 0; i < MAX_BREAKPOINTS; i++) {
 		if (kgdb_break[i].state == bp_enabled) {
 			unsigned long addr = kgdb_break[i].bpt_addr;
@@ -615,6 +621,10 @@
 		}
 		kgdb_break[i].state = bp_disabled;
 	}
+
+	/* Clear hardware breakpoints. */
+	kgdb_remove_all_hw_break();
+
 	return 0;
 }
 
@@ -710,7 +720,7 @@
 	kgdb_usethreadid = shadow_pid(current->pid);
 
 	while (1) {
-		int bpt_type = 0;
+		char *bpt_type;
 		error = 0;
 
 		/* Clear the out buffer. */
@@ -964,41 +974,39 @@
 			else
 				error_packet(remcom_out_buffer, -EINVAL);
 			break;
+		/* Since GDB-5.3, it's been drafted that '0' is a software
+		 * breakpoint, '1' is a hardware breakpoint, so let's do
+		 * that.
+		 */
 		case 'z':
 		case 'Z':
+			bpt_type = &remcom_in_buffer[1];
 			ptr = &remcom_in_buffer[2];
+
+			if (*bpt_type != '0' && *bpt_type != '1')
+				/* Unsupported. */
+				break;
+			/* Test if this is a hardware breakpoint, and
+			 * if we support it. */
+			if (*bpt_type == '1' && !(kgdb_ops->flags &
+						KGDB_HW_BREAKPOINT))
+				/* Unsupported. */
+				break;
+
 			if (*(ptr++) != ',') {
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
 			}
 			kgdb_hex2long(&ptr, &addr);
 
-			bpt_type = remcom_in_buffer[1];
-			if (bpt_type != bp_breakpoint) {
-				if (bpt_type == bp_hardware_breakpoint &&
-				    !(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
-					break;
-
-				/* if set_break is not defined, then
-				 * remove_break does not matter
-				 */
-				if (!(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
-					break;
-			}
-
-			if (remcom_in_buffer[0] == 'Z') {
-				if (bpt_type == bp_breakpoint)
-					error = set_break(addr);
-				else
-					error = kgdb_arch_set_break(addr,
-								    bpt_type);
-			} else {
-				if (bpt_type == bp_breakpoint)
-					error = remove_break(addr);
-				else
-					error = kgdb_arch_remove_break(addr,
-								       bpt_type);
-			}
+			if (remcom_in_buffer[0] == 'Z' && *bpt_type == '0')
+				error = kgdb_set_sw_break(addr);
+			else if (remcom_in_buffer[0] == 'Z' && *bpt_type == '1')
+				error = kgdb_set_hw_break(addr);
+			else if (remcom_in_buffer[0] == 'z' && *bpt_type == '0')
+				error = kgdb_remove_sw_break(addr);
+			else if (remcom_in_buffer[0] == 'z' && *bpt_type == '1')
+				error = kgdb_remove_hw_break(addr);
 
 			if (error == 0)
 				strcpy(remcom_out_buffer, "OK");

diff -u linux-2.6.4/arch/i386/kernel/kgdb.c linux-2.6.4/arch/i386/kernel/kgdb.c
--- linux-2.6.4/arch/i386/kernel/kgdb.c	2004-03-19 08:29:47.155575704 -0700
+++ linux-2.6.4/arch/i386/kernel/kgdb.c	2004-03-29 08:55:53.752914399 -0700
@@ -124,11 +124,12 @@
 	unsigned type;
 	unsigned len;
 	unsigned addr;
-} breakinfo[4] = { {
-enabled:0}, {
-enabled:0}, {
-enabled:0}, {
-enabled:0}};
+} breakinfo[4] = {
+	{ .enabled = 0 },
+	{ .enabled = 0 },
+	{ .enabled = 0 },
+	{ .enabled = 0 },
+};
 
 void kgdb_correct_hw_break(void)
 {
@@ -189,62 +190,6 @@
 	}
 }
 
-int kgdb_remove_hw_break(unsigned long addr, int type)
-{
-	int i, idx = -1;
-	for (i = 0; i < 4; i++) {
-		if (breakinfo[i].addr == addr && breakinfo[i].enabled) {
-			idx = i;
-			break;
-		}
-	}
-	if (idx == -1)
-		return -1;
-
-	breakinfo[idx].enabled = 0;
-	return 0;
-}
-
-int kgdb_set_hw_break(unsigned long addr, int type)
-{
-	int i, idx = -1;
-	for (i = 0; i < 4; i++) {
-		if (!breakinfo[i].enabled) {
-			idx = i;
-			break;
-		}
-	}
-	if (idx == -1)
-		return -1;
-
-	breakinfo[idx].enabled = 1;
-	breakinfo[idx].type = type;
-	breakinfo[idx].len = 1;
-	breakinfo[idx].addr = addr;
-	return 0;
-}
-
-int remove_hw_break(unsigned breakno)
-{
-	if (!breakinfo[breakno].enabled) {
-		return -1;
-	}
-	breakinfo[breakno].enabled = 0;
-	return 0;
-}
-
-int set_hw_break(unsigned breakno, unsigned type, unsigned len, unsigned addr)
-{
-	if (breakinfo[breakno].enabled) {
-		return -1;
-	}
-	breakinfo[breakno].enabled = 1;
-	breakinfo[breakno].type = type;
-	breakinfo[breakno].len = len;
-	breakinfo[breakno].addr = addr;
-	return 0;
-}
-
 void kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
 {
 	unsigned dr6;
@@ -293,8 +238,8 @@
 			       char *remcom_out_buffer,
 			       struct pt_regs *linux_regs)
 {
-	long addr, length;
-	long breakno, breaktype;
+	long addr;
+	long breakno;
 	char *ptr;
 	int newPC;
 	int dr6;
@@ -343,38 +288,8 @@
 		return (0);
-
-	case 'Y':
-		ptr = &remcom_in_buffer[1];
-		kgdb_hex2long(&ptr, &breakno);
-		ptr++;
-		kgdb_hex2long(&ptr, &breaktype);
-		ptr++;
-		kgdb_hex2long(&ptr, &length);
-		ptr++;
-		kgdb_hex2long(&ptr, &addr);
-		if (set_hw_break(breakno & 0x3, breaktype & 0x3,
-				 length & 0x3, addr) == 0) {
-			strcpy(remcom_out_buffer, "OK");
-		} else {
-			strcpy(remcom_out_buffer, "ERROR");
-		}
-		break;
-
-		/* Remove hardware breakpoint */
-	case 'y':
-		ptr = &remcom_in_buffer[1];
-		kgdb_hex2long(&ptr, &breakno);
-		if (remove_hw_break(breakno & 0x3) == 0) {
-			strcpy(remcom_out_buffer, "OK");
-		} else {
-			strcpy(remcom_out_buffer, "ERROR");
-		}
-		break;
-
 	}			/* switch */
 	return -1;		/* this means that we do not want to exit from the handler */
 }
 
 struct kgdb_arch arch_kgdb_ops = {
 	.gdb_bpt_instr = {0xcc},
-	.flags = KGDB_HW_BREAKPOINT,
 };

--- linux-2.6.4.orig/arch/i386/kernel/kgdb.c	2004-03-29 08:55:53.752914399 -0700
+++ linux-2.6.4/arch/i386/kernel/kgdb.c	2004-03-29 08:54:49.382357765 -0700
@@ -190,6 +190,54 @@
 	}
 }
 
+int kgdb_remove_hw_break(unsigned long addr)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i++) {
+		if (breakinfo[i].addr == addr && breakinfo[i].enabled) {
+			idx = i;
+			break;
+		}
+	}
+	if (idx == -1)
+		return -1;
+
+	breakinfo[idx].enabled = 0;
+	return 0;
+}
+
+void kgdb_remove_all_hw_break(void)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (breakinfo[i].enabled) {
+			/* Do what? */
+			;
+		}
+		memset(&breakinfo[i], 0, sizeof(struct hw_breakpoint));
+	}
+}
+
+int kgdb_set_hw_break(unsigned long addr)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i++) {
+		if (!breakinfo[i].enabled) {
+			idx = i;
+			break;
+		}
+	}
+	if (idx == -1)
+		return -1;
+
+	breakinfo[idx].enabled = 1;
+	breakinfo[idx].type = 1;
+	breakinfo[idx].len = 1;
+	breakinfo[idx].addr = addr;
+	return 0;
+}
+
 void kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
 {
 	unsigned dr6;
@@ -292,4 +340,5 @@
 
 struct kgdb_arch arch_kgdb_ops = {
 	.gdb_bpt_instr = {0xcc},
+	.flags = KGDB_HW_BREAKPOINT,
 };

-- 
Tom Rini
http://gate.crashing.org/~trini/
