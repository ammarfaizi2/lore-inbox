Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUHTRzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUHTRzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUHTRzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:55:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54177 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268457AbUHTRyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:54:53 -0400
To: Andrew Morton <akpm@osdl.org>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/14] kexec: i8259-shutdown.i386
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 11:53:36 -0600
Message-ID: <m14qmx7l27.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch disables interrupt generation from the legacy
pic on reboot.  Now that there is a sys_device class it should
not be called while drivers are still using interrupts.

diff -uNr linux-2.6.8.1-mm2/arch/i386/kernel/i8259.c linux-2.6.8.1-mm2-i8259-shutdown.i386/arch/i386/kernel/i8259.c
--- linux-2.6.8.1-mm2/arch/i386/kernel/i8259.c	Fri Aug 20 09:56:25 2004
+++ linux-2.6.8.1-mm2-i8259-shutdown.i386/arch/i386/kernel/i8259.c	Fri Aug 20 10:27:35 2004
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
