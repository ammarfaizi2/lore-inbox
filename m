Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUCYThl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUCYThl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:37:41 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:54712 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S263575AbUCYTh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:37:27 -0500
Date: Thu, 25 Mar 2004 12:37:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Anurekh Saxena <anurekh.saxena@timesys.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Kgdb-bugreport] kgdb_arch_set/remove_break() ?
Message-ID: <20040325193725.GK13366@smtp.west.cox.net>
References: <20040319160359.GD4569@smtp.west.cox.net> <20040324202402.GA20260@timesys.com> <20040324214029.GL7126@smtp.west.cox.net> <200403251554.39598.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403251554.39598.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 03:54:39PM +0530, Amit S. Kale wrote:
> On Thursday 25 Mar 2004 3:10 am, Tom Rini wrote:
> > On Wed, Mar 24, 2004 at 03:24:02PM -0500, Anurekh Saxena wrote:
> > > On Wed, Mar 24, 2004 at 08:05:21PM +0530, Amit S. Kale wrote:
> > > > On Friday 19 Mar 2004 9:33 pm, Tom Rini wrote:
> > > > > Hi.  Right now I'm writing up a porting doc that describes the
> > > > > various hook functions we've got.  I noticed that nothing is calling
> > > > > kgdb_arch_set/remove_break.  Is there some arch we're expecting will
> > > > > need this?  I'd like to just go ahead and remove them
> > > >
> > > > I can't remember why that was done. A processor other than PPC, x86 and
> > > > x86_64 needs a special implementation of set and remove breakpoint, I
> > > > guess.
> > > >
> > > > Anurekh, who did initial implementation of arch independent-dependent
> > > > split may have some comments on this.
> > >
> > > *set_break
> > > *remove_break
> > >
> > > These functions should only be defined for architecutes that support
> > > hardware breakpoint. Set KGDB_HW_BREAKPOINT flag.
> >
> > Amit, I think we've got a bug on i386 then.  Looking at i386-lite.patch,
> > there's:
> > +void kgdb_correct_hw_break(void)
> > +int kgdb_remove_hw_break(unsigned long addr, int type)
> > +int kgdb_set_hw_break(unsigned long addr, int type)
> > +int remove_hw_break(unsigned breakno)
> > +int set_hw_break(unsigned breakno, unsigned type, unsigned len, unsigned
> > addr)
> >
> > Of these, only kgdb_correct_hw_break is called in core-lite.patch, and
> > set_hw_break/remove_hw_break (for y/Y packets) are called in
> > i386-lite.patch.
> >
> > What I think we need to do is, since y/Y packets are reserved, I'm
> > assuming there's a special version of GDB using these for hw
> > breakpoints, and this needs to be handled in i386-lite.patch.
> > Since core-lite's handling of a z/Z* packet is to assume setting a
> > breakpoint, and hw or sw is controlled by the KGDB_HW_BREAKPOINT flag,
> > we need to make sure this (a) works and (b) is actually calling useful
> > functions.
> 
> I had used Y,y packets since Z,z packets weren't supported. Now we support Z,z 
> packets. It's time to move Y,y packet functionality to Z,z. That way it'll be 
> possible to use gdb commands themselves to place hardware breakpoints.
> 
> Anurekh found one more problem. We don't consider hardware breakpoints when 
> removing all breakpoints. We should fix that.

The following is an incomplete patch vs core-lite and i386-lite that
_needs_ someone that understand i386 and hardware breakpoints to audit
all of the code related to that in i386/kernel/kgdb.c.

We fix the remove_all_breakpoint issue by adding
kgdb_remove_all_hw_break(), which must do whatever is needed to actually
accomplish that (I don't see how we're even setting a hw break now,
unless there's a call to correct_hw_break later which actually makes
them do something).  I've also gone and made the z/Z packet handling
slightly different, and noted where we got the docs on how to handle the
packet that way.

 arch/i386/kernel/kgdb.c |   84 +++++++++++++-----------------------------------
 include/linux/kgdb.h    |    5 +-
 kernel/kgdb.c           |   67 ++++++++++++++++++++------------------
 3 files changed, 62 insertions(+), 94 deletions(-)
diff -u linux-2.6.4/include/linux/kgdb.h linux-2.6.4/include/linux/kgdb.h
--- linux-2.6.4/include/linux/kgdb.h	2004-03-19 08:22:37.143170735 -0700
+++ linux-2.6.4/include/linux/kgdb.h	2004-03-25 12:28:18.370953120 -0700
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
+++ linux-2.6.4/kernel/kgdb.c	2004-03-25 12:27:48.959587058 -0700
@@ -157,13 +157,13 @@
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
@@ -206,7 +206,6 @@
 {
 	unsigned char checksum;
 	unsigned char xmitcsum;
-	int i;
 	int count;
 	char ch;
 
@@ -540,7 +539,7 @@
 	return 0;
 }
 
-static int set_break(unsigned long addr)
+static int kgdb_set_sw_break(unsigned long addr)
 {
 	int i, breakno = -1;
 	int error;
@@ -576,7 +575,7 @@
 	return 0;
 }
 
-static int remove_break(unsigned long addr)
+static int kgdb_remove_sw_break(unsigned long addr)
 {
 	int i;
 	int error;
@@ -602,6 +601,8 @@
 {
 	int i;
 	int error;
+
+	/* Clear memory breakpoints. */
 	for (i = 0; i < MAX_BREAKPOINTS; i++) {
 		if (kgdb_break[i].state == bp_enabled) {
 			unsigned long addr = kgdb_break[i].bpt_addr;
@@ -615,6 +616,10 @@
 		}
 		kgdb_break[i].state = bp_disabled;
 	}
+
+	/* Clear hardware breakpoints. */
+	kgdb_remove_all_hw_break();
+
 	return 0;
 }
 
@@ -710,7 +715,7 @@
 	kgdb_usethreadid = shadow_pid(current->pid);
 
 	while (1) {
-		int bpt_type = 0;
+		char *bpt_type;
 		error = 0;
 
 		/* Clear the out buffer. */
@@ -964,41 +969,39 @@
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
+++ linux-2.6.4/arch/i386/kernel/kgdb.c	2004-03-25 12:28:46.987498490 -0700
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
@@ -189,7 +190,7 @@
 	}
 }
 
-int kgdb_remove_hw_break(unsigned long addr, int type)
+int kgdb_remove_hw_break(unsigned long addr)
 {
 	int i, idx = -1;
 	for (i = 0; i < 4; i++) {
@@ -205,7 +206,20 @@
 	return 0;
 }
 
-int kgdb_set_hw_break(unsigned long addr, int type)
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
 {
 	int i, idx = -1;
 	for (i = 0; i < 4; i++) {
@@ -218,33 +232,12 @@
 		return -1;
 
 	breakinfo[idx].enabled = 1;
-	breakinfo[idx].type = type;
+	breakinfo[idx].type = 1;
 	breakinfo[idx].len = 1;
 	breakinfo[idx].addr = addr;
 	return 0;
 }
 
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
@@ -293,8 +286,8 @@
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
@@ -341,35 +334,6 @@
 		asm volatile ("movl %0, %%db6\n"::"r" (0));
 
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

-- 
Tom Rini
http://gate.crashing.org/~trini/
