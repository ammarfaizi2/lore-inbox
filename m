Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbTIKBz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbTIKBz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:55:28 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:386
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262624AbTIKBz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:55:26 -0400
Date: Wed, 10 Sep 2003 21:55:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Maciej <maciej@apathy.killer-robot.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][2.6] i386 /proc/irq/.../smp_affinity
In-Reply-To: <20030910191459.GA12099@apathy.black-flower>
Message-ID: <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com>
References: <20030910191459.GA12099@apathy.black-flower>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Maciej wrote:

> Since I upgraded from 2.6.0-test3, to 2.6.0-test5, I can't seem to
> get the SMP irq affinity to change. I have a dual-proc PII-333 with
> a 440LX chipset. On boot, the smp_affinity mask for each interrupt
> is set to 00030000, and setting it to ffffffff doesn't change
> anything.

That number looks highly suspect; see patch below

> The interrupts on IRQ5/CPU1 arrive in bursts. All interrupts for IRQ5
> will happen on CPU0 for an extended period, but after I leave the
> thing alone for a few hours, I'll find that the count for CPU1 will
> have increased by a few tens of thousands. The counts for CPU1 on irq
> 0 and irq 9 are set this way as soon as I have a chance to log in,
> and don't change afterwards.

Do you have the irqbalanced daemon running? You could also try booting 
with the 'noirqbalance' kernel parameter.

Index: linux-2.6.0-test5/arch/i386/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test5/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.6.0-test5/arch/i386/kernel/irq.c	8 Sep 2003 22:07:35 -0000	1.1.1.1
+++ linux-2.6.0-test5/arch/i386/kernel/irq.c	11 Sep 2003 01:36:11 -0000
@@ -938,21 +938,12 @@ cpumask_t irq_affinity[NR_IRQS] = { [0 .
 static int irq_affinity_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int k, len;
 	cpumask_t tmp = irq_affinity[(long)data];
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
-	len = 0;
-	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
-		len += j;
-		page += j;
-		cpus_shift_right(tmp, tmp, 16);
-	}
-	len += sprintf(page, "\n");
-	return len;
+	return sprintf(page, "%08x\n", (u32)cpus_coerce(tmp));
 }
 
 static int irq_affinity_write_proc(struct file *file, const char __user *buffer,
