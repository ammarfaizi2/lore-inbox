Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270708AbVBEQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270708AbVBEQzF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 11:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVBEQzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 11:55:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:34434
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S273518AbVBEQyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 11:54:20 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
Subject: [patch] Make User Mode Linux compile in 2.6.11-rc3
Date: Sat, 5 Feb 2005 10:51:45 -0500
User-Agent: KMail/1.6.2
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Jeff Dike <jdike@addtoit.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502051051.46242.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of yesterday afternoon, the UML build still breaks in sys_call_table.c, 
here's the patch I submitted earlier (which got me past the break when I 
tried it).  Last week, this produced what seemed like a working UML.

Now there's a second break in mm/memory.c: the move to four level page
tables conflicts with a stub in our headers.  Not quite sure how to fix that.
Jeff?

(Yeah, I know Andrew's tree works.  But wouldn't it be nice if the kernel.org 
tree to worked too, before 2.6.11 release.)

Rob

----------  Forwarded Message  ----------

Subject: [uml-devel] [patch] Make User Mode Linux compile in 2.6.11-rc2-bk6.
Date: Saturday 29 January 2005 05:51 am
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

User Mode Linux doesn't compile in 2.6.11-rc2-bk6.  Here's the change I
made to sys_call_table.c to make it compile.  (I ran the result and brought
up a shell.)

We're really close to finally having a usable UML kernel in mainline.
2.6.9's ARCH=um built but was very unstable, 2.6.10 didn't even build
for me, but 2.6.11-rc1-mm2 builds fine unmodified, and ran my tests
correctly to completion.

Here's the patch.  Nothing fancy, it simply removes or stubs out all the
syscalls the compiler complains about.

Rob

Signed-off-by: Rob Landley <rob@landley.net>

--- linux-2.6.10/arch/um/kernel/sys_call_table.c	2005-01-28
 21:20:38.000000000 -0600 +++
 linux-2.6.10-um/arch/um/kernel/sys_call_table.c	2005-01-28
 21:40:30.735892144 -0600 @@ -20,7 +20,7 @@
 #define NFSSERVCTL sys_ni_syscall
 #endif

-#define LAST_GENERIC_SYSCALL __NR_vperfctr_read
+#define LAST_GENERIC_SYSCALL (NR_syscalls-1)

 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
 #define LAST_SYSCALL LAST_GENERIC_SYSCALL
@@ -52,13 +52,7 @@
 extern syscall_handler_t sys_mbind;
 extern syscall_handler_t sys_get_mempolicy;
 extern syscall_handler_t sys_set_mempolicy;
-extern syscall_handler_t sys_sys_kexec_load;
 extern syscall_handler_t sys_sys_setaltroot;
-extern syscall_handler_t sys_vperfctr_open;
-extern syscall_handler_t sys_vperfctr_control;
-extern syscall_handler_t sys_vperfctr_unlink;
-extern syscall_handler_t sys_vperfctr_iresume;
-extern syscall_handler_t sys_vperfctr_read;

 syscall_handler_t *sys_call_table[] = {
 	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
@@ -273,7 +267,7 @@
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
-	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_kexec_load,
+	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
 #if 0
 	[ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
@@ -281,11 +275,6 @@
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
-	[ __NR_vperfctr_open ] = (syscall_handler_t *) sys_vperfctr_open,
-	[ __NR_vperfctr_control ] = (syscall_handler_t *) sys_vperfctr_control,
-	[ __NR_vperfctr_unlink ] = (syscall_handler_t *) sys_vperfctr_unlink,
-	[ __NR_vperfctr_iresume ] = (syscall_handler_t *) sys_vperfctr_iresume,
-	[ __NR_vperfctr_read ] = (syscall_handler_t *) sys_vperfctr_read,

 	ARCH_SYSCALLS
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] =
