Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268467AbUHTR6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268467AbUHTR6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268476AbUHTR6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:58:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55201 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268467AbUHTR6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:58:15 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/14] kexec: i8259-sysfs.x86_64
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 11:57:01 -0600
Message-ID: <m1zn4p66c2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The i8259 does not yet have sysfs support on x86_64 so
here is the port from i386, including the shutdown code
to disable it on reboot that kexec appreciates.

diff -uNr linux-2.6.8.1-mm2-i8259-shutdown.i386/arch/x86_64/kernel/i8259.c linux-2.6.8.1-mm2-i8259-sysfs.x86_64/arch/x86_64/kernel/i8259.c
--- linux-2.6.8.1-mm2-i8259-shutdown.i386/arch/x86_64/kernel/i8259.c	Fri Aug 20 09:56:29 2004
+++ linux-2.6.8.1-mm2-i8259-sysfs.x86_64/arch/x86_64/kernel/i8259.c	Fri Aug 20 10:38:36 2004
@@ -343,6 +343,44 @@
 	}
 }
 
+static int i8259A_resume(struct sys_device *dev)
+{
+	init_8259A(0);
+	return 0;
+}
+
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
+static struct sysdev_class i8259_sysdev_class = {
+	set_kset_name("i8259"),
+	.resume = i8259A_resume,
+	.shutdown = i8259A_shutdown,
+};
+
+static struct sys_device device_i8259A = {
+	.id	= 0,
+	.cls	= &i8259_sysdev_class,
+};
+
+static int __init i8259A_init_sysfs(void)
+{
+	int error = sysdev_class_register(&i8259_sysdev_class);
+	if (!error)
+		error = sysdev_register(&device_i8259A);
+	return error;
+}
+
+device_initcall(i8259A_init_sysfs);
+
 void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
