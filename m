Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWDWWDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWDWWDX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 18:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWDWWDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 18:03:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932077AbWDWWDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 18:03:22 -0400
Date: Sun, 23 Apr 2006 15:02:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: florin@iucha.net (Florin Iucha)
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: pcmcia oops on 2.6.17-rc[12]
Message-Id: <20060423150206.546b7483.akpm@osdl.org>
In-Reply-To: <20060423192251.GD8896@iucha.net>
References: <20060423192251.GD8896@iucha.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

florin@iucha.net (Florin Iucha) wrote:
>
> With 2.6.17-rc[12] I get the following oops:
> 
> Linux version 2.6.17-rc2 (florin@hera) (gcc version 4.1.0 (Debian 4.1.0-1+b1)) #1 Sun Apr 23 00:04:42 CDT 2006
> [snip]
> Intel ISA PCIC probe: 
>   Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
>     host opts [0]: none
>     host opts [1]: none
> setup_irq: irq handler mismatch
>  <c012f9dd> setup_irq+0xd3/0xe6   <d9449159> i365_count_irq+0x0/0x22 [i82365]
>  <c012fa5f> request_irq+0x6f/0x8b   <d944f2af> test_irq+0x27/0xc7 [i82365]
>  <d9449159> i365_count_irq+0x0/0x22 [i82365]   <d944f8ea> add_pcic+0x59b/0x81c [i82365]
>  <c0104dbb> do_IRQ+0x46/0x4e   <c011007b> machine_kexec+0x8f/0xbc
>  <c01d282e> vsnprintf+0x455/0x490   <c01d2889> sprintf+0x20/0x23
>  <c0211304> pnp_convert_id+0x74/0x79   <c020be49> compare_pnp_id+0x40/0x97
>  <d9449113> i365_get_pair+0x25/0x3b [i82365]   <d944f1f5> add_socket+0x61/0xf4 [i82365]
>
> ...
>
>     ISA irqs (scanned) = 3,4,5,7,10 polling interval = 1000 ms
> cs: IO port probe 0x100-0x4ff: excluding 0x378-0x37f 0x4d0-0x4d7
> cs: IO port probe 0x800-0x8ff: clean.
> cs: IO port probe 0x100-0x4ff: excluding 0x378-0x37f 0x4d0-0x4d7
> cs: IO port probe 0x800-0x8ff: clean.
> cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
> cs: IO port probe 0xa00-0xaff: clean.
> cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
> cs: IO port probe 0xa00-0xaff: clean.

It's actually not an oops - it's a warning, telling us that i82365 is
requesting an IRQ in non-sharing mode, but there's already a handler
registered for that IRQ (which might or might not be shareable).


> I get a similar oops on 2.6.17-rc2 compiled with gcc-4.1 and on
> 2.6.17-rc1 compiled with gcc-4.0.3 . 2.6.16 does not oops.

What has changed is that the kernel now emits a warning when this mismatch
occurs.  In 2.6.16 the request_irq() will silently fail.

Your machine should otherwise continue to work OK.  Is that the case?

i82365 appears to be poking around in interrupt space trying to find an IRQ
which isn't shared with anyone else (I'm not sure why, but these sorts of
things tend to be derived from hard experience).

Anyway.  We need to either a) make i82365 better-behaved or b) remove the
warning or c) allow callers to suppress the warning (SA_PROBEIRQ?).

I think c) - the warning can help find bugs.



From: Andrew Morton <akpm@osdl.org>

- Add new SA_PROBEIRQ which suppresses the new sharing-mismatch warning. 
  Some drivers like to use request_irq() to find an unused interrupt slot.

- Use it in i82365.c

- Kill unused SA_PROBE.



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pcmcia/i82365.c     |    7 ++++---
 include/asm-xtensa/signal.h |    2 +-
 include/linux/signal.h      |    4 +++-
 kernel/irq/manage.c         |    6 ++++--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff -puN include/linux/signal.h~request_irq-remove-warnings-from-irq-probing include/linux/signal.h
--- devel/include/linux/signal.h~request_irq-remove-warnings-from-irq-probing	2006-04-23 14:55:13.000000000 -0700
+++ devel-akpm/include/linux/signal.h	2006-04-23 14:56:19.000000000 -0700
@@ -14,10 +14,12 @@
  *
  * SA_INTERRUPT is also used by the irq handling routines.
  * SA_SHIRQ is for shared interrupt support on PCI and EISA.
+ * SA_PROBEIRQ is set by callers when they expect sharing mismatches to occur
  */
-#define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+#define SA_PROBEIRQ		0x08000000
+
 /*
  * As above, these correspond to the IORESOURCE_IRQ_* defines in
  * linux/ioport.h to select the interrupt line behaviour.  When
diff -puN kernel/irq/manage.c~request_irq-remove-warnings-from-irq-probing kernel/irq/manage.c
--- devel/kernel/irq/manage.c~request_irq-remove-warnings-from-irq-probing	2006-04-23 14:55:13.000000000 -0700
+++ devel-akpm/kernel/irq/manage.c	2006-04-23 14:57:01.000000000 -0700
@@ -246,8 +246,10 @@ int setup_irq(unsigned int irq, struct i
 
 mismatch:
 	spin_unlock_irqrestore(&desc->lock, flags);
-	printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
-	dump_stack();
+	if (!(new->flags & SA_PROBE_IRQ)) {
+		printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
+		dump_stack();
+	}
 	return -EBUSY;
 }
 
diff -puN drivers/pcmcia/i82365.c~request_irq-remove-warnings-from-irq-probing drivers/pcmcia/i82365.c
--- devel/drivers/pcmcia/i82365.c~request_irq-remove-warnings-from-irq-probing	2006-04-23 14:55:13.000000000 -0700
+++ devel-akpm/drivers/pcmcia/i82365.c	2006-04-23 14:58:14.000000000 -0700
@@ -509,7 +509,8 @@ static irqreturn_t i365_count_irq(int ir
 static u_int __init test_irq(u_short sock, int irq)
 {
     debug(2, "  testing ISA irq %d\n", irq);
-    if (request_irq(irq, i365_count_irq, 0, "scan", i365_count_irq) != 0)
+    if (request_irq(irq, i365_count_irq, SA_PROBEIRQ, "scan",
+			i365_count_irq) != 0)
 	return 1;
     irq_hits = 0; irq_sock = sock;
     msleep(10);
@@ -561,7 +562,7 @@ static u_int __init isa_scan(u_short soc
     } else {
 	/* Fallback: just find interrupts that aren't in use */
 	for (i = 0; i < 16; i++)
-	    if ((mask0 & (1 << i)) && (_check_irq(i, 0) == 0))
+	    if ((mask0 & (1 << i)) && (_check_irq(i, SA_PROBEIRQ) == 0))
 		mask1 |= (1 << i);
 	printk("default");
 	/* If scan failed, default to polled status */
@@ -725,7 +726,7 @@ static void __init add_pcic(int ns, int 
 	u_int cs_mask = mask & ((cs_irq) ? (1<<cs_irq) : ~(1<<12));
 	for (cs_irq = 15; cs_irq > 0; cs_irq--)
 	    if ((cs_mask & (1 << cs_irq)) &&
-		(_check_irq(cs_irq, 0) == 0))
+		(_check_irq(cs_irq, SA_PROBEIRQ) == 0))
 		break;
 	if (cs_irq) {
 	    grab_irq = 1;
diff -puN include/asm-xtensa/signal.h~request_irq-remove-warnings-from-irq-probing include/asm-xtensa/signal.h
--- devel/include/asm-xtensa/signal.h~request_irq-remove-warnings-from-irq-probing	2006-04-23 14:59:43.000000000 -0700
+++ devel-akpm/include/asm-xtensa/signal.h	2006-04-23 15:00:07.000000000 -0700
@@ -118,9 +118,9 @@ typedef struct {
  * SA_INTERRUPT is also used by the irq handling routines.
  * SA_SHIRQ is for shared interrupt support on PCI and EISA.
  */
-#define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+#define SA_PROBEIRQ		0x08000000
 #endif
 
 #define SIG_BLOCK          0	/* for blocking signals */
_

