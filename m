Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUHTIub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUHTIub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHTIrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:47:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47776 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267974AbUHTIoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:44:14 -0400
To: Greg KH <greg@kroah.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i8259 shutdown method for i386
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 02:43:06 -0600
Message-ID: <m1y8ka6vz9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg, 
Now that you have added sys_device support to the generic
device support.  This patch to shutdown the i8259A interrupt
controller on reboot should now be safe.

Eric

diff -uNr linux-2.6.8.1/arch/i386/kernel/i8259.c linux-2.6.8.1-i8259-shutdown.i386/arch/i386/kernel/i8259.c
--- linux-2.6.8.1/arch/i386/kernel/i8259.c	Wed Aug 18 14:54:26 2004
+++ linux-2.6.8.1-i8259-shutdown.i386/arch/i386/kernel/i8259.c	Wed Aug 18 14:58:56 2004
@@ -244,9 +244,21 @@
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
 	.resume = i8259A_resume,
+	.shutdown = i8259A_shutdown,
 };
 
 static struct sys_device device_i8259A = {
