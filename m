Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUHWEYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUHWEYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 00:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267383AbUHWEYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 00:24:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61096 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267381AbUHWEYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 00:24:03 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/14] kexec: i8259-sysfs.x86_64
References: <m1zn4p66c2.fsf@ebiederm.dsl.xmission.com>
	<20040821162417.7bad0b08.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Aug 2004 22:22:43 -0600
In-Reply-To: <20040821162417.7bad0b08.akpm@osdl.org>
Message-ID: <m1d61i4h64.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> > The i8259 does not yet have sysfs support on x86_64
> 
> umm, yes it does.  It went into Linus's tree post 2.6.8.1.

Sorry I missed that one.  I'm surprised I did not get a reject
when I rebuilt that one against mm2.  It appears I was in a bit
of a rush.

Or why it would be nice for this code to be merged :)

> I added the below make-it-compile patch.  Please check it.

Please just remove the previous patch and it's fix from your patchset,
as together they are a noop.

The following patch simply adds a shutdown method to the x86_64
i8259 code. That is what I care about in the context of kexec.

While testing this I found a minor ide bug. I will have a patch for
that in a second. 

Eric

diff -uNr linux-2.6.8.1-mm4/arch/x86_64/kernel/i8259.c linux-2.6.8.1-mm4-i8259-shutdown-x86_64/arch/x86_64/kernel/i8259.c
--- linux-2.6.8.1-mm4/arch/x86_64/kernel/i8259.c	Sun Aug 22 20:56:01 2004
+++ linux-2.6.8.1-mm4-i8259-shutdown-x86_64/arch/x86_64/kernel/i8259.c	Sun Aug 22 21:00:23 2004
@@ -416,10 +416,24 @@
 	return 0;
 }
 
+
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
 static struct sysdev_class i8259_sysdev_class = {
 	set_kset_name("i8259"),
 	.suspend = i8259A_suspend,
 	.resume = i8259A_resume,
+	.shutdown = i8259A_shutdown,
 };
 
 static struct sys_device device_i8259A = {


