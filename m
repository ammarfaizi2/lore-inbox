Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbULBT3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbULBT3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbULBT3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:29:00 -0500
Received: from mail.aknet.ru ([217.67.122.194]:57355 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261734AbULBT2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:28:33 -0500
Message-ID: <41AF6CE0.4090500@aknet.ru>
Date: Thu, 02 Dec 2004 22:28:32 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com>
In-Reply-To: <20041117131552.GA11053@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010607050709080402030808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010607050709080402030808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Prasanna S Panchamukhi wrote:
> Yes, there is a small bug in kprobes. Kprobes int3 handler
> was returning wrong value. Please check out if the patch
> attached with this mail fixes your problem.
> Please let me know if you have any issues.
Yes. After several days of debugging,
I am pointing to this problem again.
Unfortunately your patch appeared not
to work. It only masks the problem.
I was surprised that you check VM_MASK
after you already used "addr" a couple
of times - this "addr" is completely
bogus and should not be used. Now this
turned out more important. The problem
is that the "addr" calculated only from
the value of EIP, is bogus not only when
VM flag is set. It is also bogus if the
program uses segmentation and the
CS_base!=0. I have many of the like
programs here and they all are broken
because kprobes still steal the int3 from
them. They do not use V86, but they use
segments instead of the flat layout, so
the address cannot be calculated by the
EIP value.
I would suggest something like the attached
patch. I know nothing about kprobes (sorry)
so I don't know what CS you need. If you
need not only __KERNEL_CS, you probably
want the (regs->xcs & 4) check to see if
the CS is not from LDT at least. Does this
make sense?
Anyway, would be nice to get this fixed.
This can cause Oopses because you deref
the completely bogus pointer later in the
code.
Writing a test-case for this problem is
not a several-minutes work, but if you
really need one, I may try to hack it out.

Thanks.


--------------010607050709080402030808
Content-Type: text/x-patch;
 name="kprb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kprb.diff"

--- linux/arch/i386/kernel/kprobes.c.old	2004-11-18 16:22:46.000000000 +0300
+++ linux/arch/i386/kernel/kprobes.c	2004-12-02 22:01:05.000000000 +0300
@@ -92,6 +92,11 @@
 	int ret = 0;
 	u8 *addr = (u8 *) (regs->eip - 1);
 
+	/* If we are in v86 mode or CS is not ours, get out */
+	if ((regs->eflags & VM_MASK) || regs->xcs != __KERNEL_CS) {
+		return 0;
+	}
+
 	/* We're in an interrupt, but this is clear and BUG()-safe. */
 	preempt_disable();
 
@@ -117,10 +122,6 @@
 	p = get_kprobe(addr);
 	if (!p) {
 		unlock_kprobes();
-		if (regs->eflags & VM_MASK) {
-			/* We are in virtual-8086 mode. Return 0 */
-			goto no_kprobe;
-		}
 
 		if (*addr != BREAKPOINT_INSTRUCTION) {
 			/*

--------------010607050709080402030808--
