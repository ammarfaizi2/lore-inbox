Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVASIGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVASIGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVASIGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:06:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54975 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261643AbVASHdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:46 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/29] x86-i8259-shutdown
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Eric W. Biederman <ebiederm@xmission.com>

This patch disables interrupt generation from the legacy pic on reboot.  Now
that there is a sys_device class it should not be called while drivers are
still using interrupts.

There is a report about this breaking ACPI power off on some systems.
http://bugme.osdl.org/show_bug.cgi?id=4041
However the final comment seems to exhonorate this code.  So until
I get more information I believe that was a false positive.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 i8259.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-e820-64bit/arch/i386/kernel/i8259.c linux-2.6.11-rc1-mm1-nokexec-x86-i8259-shutdown/arch/i386/kernel/i8259.c
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-e820-64bit/arch/i386/kernel/i8259.c	Fri Jan 14 04:32:22 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-i8259-shutdown/arch/i386/kernel/i8259.c	Tue Jan 18 22:44:27 2005
@@ -270,10 +270,22 @@
 	return 0;
 }
 
+static int i8259A_shutdown(struct sys_device *dev)
+{
+	/* Put the i8259A into a quiescent state that
+	 * the kernel initialization code can get it
+	 * out of.
+	 */
+	outb(0xff, 0x21);	/* mask all of 8259A-1 */
+	outb(0xff, 0xA1);	/* mask all of 8259A-1 */
+	return 0;
+}
+
 static struct sysdev_class i8259_sysdev_class = {
 	set_kset_name("i8259"),
 	.suspend = i8259A_suspend,
 	.resume = i8259A_resume,
+	.shutdown = i8259A_shutdown,
 };
 
 static struct sys_device device_i8259A = {
