Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUHTIny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUHTIny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUHTInM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:43:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46752 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268024AbUHTIme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:42:34 -0400
To: Greg KH <greg@kroah.com>
CC: Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add sysfs support for the i8259 PIC on x86_64
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 02:40:49 -0600
Message-ID: <m13c2i8ani.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got to looking at x86_64 and while it occasionally uses the i8259 legacy
pic it is not put in sysfs.

Here is the appropriate code ported code from i386.

diff -uNr linux-2.6.8.1-i8259-shutdown.i386/arch/x86_64/kernel/i8259.c linux-2.6.8.1-i8259-sysfs.x86_64/arch/x86_64/kernel/i8259.c
--- linux-2.6.8.1-i8259-shutdown.i386/arch/x86_64/kernel/i8259.c	Wed Aug 18 14:54:30 2004
+++ linux-2.6.8.1-i8259-sysfs.x86_64/arch/x86_64/kernel/i8259.c	Wed Aug 18 14:59:00 2004
@@ -342,6 +342,44 @@
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
 void __init init_8259A(int auto_eoi)
 {
 	unsigned long flags;
