Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265389AbUAWJJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUAWJJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:09:23 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:62878 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S266279AbUAWJIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:08:55 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: FYI: kgdb 2.1.0 interdiff
Date: Fri, 23 Jan 2004 14:38:38 +0530
User-Agent: KMail/1.5
References: <20040123081822.GA3382@elf.ucw.cz>
In-Reply-To: <20040123081822.GA3382@elf.ucw.cz>
Cc: George Anzinger <george@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401231438.38492.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 Jan 2004 1:48 pm, Pavel Machek wrote:
> Hi!
>
> [I hope these are usefull to someone? They do not contain ppc and
> serial].

I guess so. Now onwards I'll send diff of patch trees. They should be a few 
lines only between consecutive kgdb versions and will be easier to read.

> entry.S change is interesting... and it changes do_IRQ() calling
> convention. Perhaps that change should be pushed to Andrew? It is
> "interesting" to have different do_IRQ in case of kgdb...

This change of do_IRQ calling convention isn't a good fix. It's just a quick 
work around the gdb's problem of not being able to parse common_interrupt 
frame correctly.

George Anzinger is working on some cfi directives to tell gdb about the format 
of common_interrupt stack frame. Once that's available I'll remove this 
work-around.


>
> 							Pavel
>
> @@ -67,8 +67,8 @@
>
>  Index: linux/arch/i386/kernel/entry.S
>  ===================================================================
> ---- linux.orig/arch/i386/kernel/entry.S	2004-01-20 14:28:44.000000000
> +0100 -+++ linux/arch/i386/kernel/entry.S	2004-01-20 14:29:19.000000000
> +0100 +--- linux.orig/arch/i386/kernel/entry.S	2004-01-23
> 09:04:23.000000000 +0100 ++++ linux/arch/i386/kernel/entry.S	2004-01-23
> 09:05:16.000000000 +0100 @@ -226,7 +226,7 @@
>   	jz restore_all
>   	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebp)
> @@ -87,7 +87,25 @@
>   	cli				# make sure we don't miss an interrupt
>   					# setting need_resched or sigpending
>   					# between sampling and the iret
> -@@ -606,6 +606,31 @@
> +@@ -399,7 +399,17 @@
> + 	ALIGN
> + common_interrupt:
> + 	SAVE_ALL
> ++	movl %esp, %eax
> ++/* Create a fake function call followed by a fake function prologue to
> fool ++ * gdb into believing that this is a normal function call. */
> ++	pushl EIP(%eax)
> ++
> ++common_interrupt_1:
> ++	pushl %ebp
> ++	movl %esp, %ebp
> ++	pushl %eax
> + 	call do_IRQ
> ++	addl $12, %esp
> + 	jmp ret_from_intr
> +
> + #define BUILD_INTERRUPT(name, nr)	\
> +@@ -606,6 +616,31 @@
>   	pushl $do_spurious_interrupt_bug
>   	jmp error_code
>
> @@ -581,10 +599,41 @@
>  +	.remove_break = i386_remove_hw_break,
>  +	.correct_hw_break = i386_correct_hw_break,
>  +};
> +Index: linux/arch/i386/kernel/irq.c
> +===================================================================
> +--- linux.orig/arch/i386/kernel/irq.c	2004-01-09 20:26:08.000000000 +0100
> ++++ linux/arch/i386/kernel/irq.c	2004-01-23 09:05:16.000000000 +0100
> +@@ -410,7 +410,7 @@
> +  * SMP cross-CPU interrupts have their own specific
> +  * handlers).
> +  */
> +-asmlinkage unsigned int do_IRQ(struct pt_regs regs)
> ++asmlinkage unsigned int do_IRQ(struct pt_regs *regs)
> + {
> + 	/*
> + 	 * We ack quickly, we don't want the irq controller
> +@@ -422,7 +422,7 @@
> + 	 * 0 return value means that this irq is already being
> + 	 * handled by some other CPU. (or is disabled)
> + 	 */
> +-	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
> ++	int irq = regs->orig_eax & 0xff; /* high bits used in ret_from_ code  */
> + 	irq_desc_t *desc = irq_desc + irq;
> + 	struct irqaction * action;
> + 	unsigned int status;
> +@@ -488,7 +488,7 @@
> + 		irqreturn_t action_ret;
> +
> + 		spin_unlock(&desc->lock);
> +-		action_ret = handle_IRQ_event(irq, &regs, action);
> ++		action_ret = handle_IRQ_event(irq, regs, action);
> + 		spin_lock(&desc->lock);
> + 		if (!noirqdebug)
> + 			note_interrupt(irq, desc, action_ret);
>  Index: linux/arch/i386/kernel/nmi.c
>  ===================================================================
> ---- linux.orig/arch/i386/kernel/nmi.c	2004-01-20 14:28:44.000000000 +0100
> -+++ linux/arch/i386/kernel/nmi.c	2004-01-20 14:29:19.000000000 +0100
> +--- linux.orig/arch/i386/kernel/nmi.c	2004-01-23 09:04:23.000000000 +0100
> ++++ linux/arch/i386/kernel/nmi.c	2004-01-23 09:05:16.000000000 +0100
>  @@ -25,6 +25,7 @@
>   #include <linux/module.h>
>   #include <linux/nmi.h>
> @@ -2031,9 +2080,9 @@
>   obj-$(CONFIG_VORTEX) += 3c59x.o
>  Index: linux/drivers/net/kgdb_eth.c
>  ===================================================================
> ---- linux.orig/drivers/net/kgdb_eth.c	2004-01-20 14:29:19.000000000 +0100
> -+++ linux/drivers/net/kgdb_eth.c	2004-01-20 14:29:19.000000000 +0100
> -@@ -0,0 +1,704 @@
> +--- linux.orig/drivers/net/kgdb_eth.c	2004-01-23 09:05:16.000000000 +0100
> ++++ linux/drivers/net/kgdb_eth.c	2004-01-23 09:05:16.000000000 +0100
> +@@ -0,0 +1,702 @@
>  +/*
>  + * Network interface GDB stub
>  + *
> @@ -2107,7 +2156,7 @@
>  +struct net_device *kgdb_netdevice = NULL;
>  +
>  +/* Indicates dept of recursion for xmitlock hold */
> -+static int xlockholdcount = 0;
> ++static int xlock_hold_count = 0;
>  +
>  +/* kgdb ethernet ring buffers. Increase the space if you get panics in
>  + * kgdbeth_alloc_skb.
> @@ -2122,7 +2171,7 @@
>  +static struct sk_buff *send_skb;
>  +static int bufnum;
>  +
> -+static char kgdb_netdevname[16];
> ++static char kgdb_netdev_name[16];
>  +
>  +#ifdef CONFIG_KGDB_CONSOLE
>  +#error kgdb over ethernet is not yet ready for console messages.
> @@ -2181,7 +2230,7 @@
>  +
>  +/* Holds xmitlock of the ethernet device
>  + * Recursive calls allowed */
> -+static void kgdbeth_holdxlock(void)
> ++static void kgdbeth_lock(void)
>  +{
>  +	if (spin_is_locked(&kgdb_netdevice->xmit_lock)) {
>  +		if (kgdb_netdevice->xmit_lock_owner == smp_processor_id()) {
> @@ -2192,14 +2241,14 @@
>  +	kgdb_netdevice->xmit_lock_owner = smp_processor_id();
>  +
>  +gotit:
> -+	xlockholdcount++;
> ++	xlock_hold_count++;
>  +}
>  +
>  +/* releases xmitlock of the ethernet device
>  + * Recursive calls allowed */
> -+static void kgdbeth_relxlock(void)
> ++static void kgdbeth_unlock(void)
>  +{
> -+	if (--xlockholdcount) {
> ++	if (--xlock_hold_count) {
>  +		kgdb_netdevice->xmit_lock_owner = -1;
>  +		spin_unlock(&kgdb_netdevice->xmit_lock);
>  +	}
> @@ -2245,7 +2294,7 @@
>  +	if (!(in_dev->ifa_list)) {
>  +		panic("No interface address set for interface!\n");
>  +	}
> -+	kgdbeth_holdxlock();
> ++	kgdbeth_lock();
>  +
>  +	udp_len = len + sizeof(struct udphdr);
>  +	ip_len = eth_len = udp_len + sizeof(struct iphdr);
> @@ -2284,10 +2333,8 @@
>  +	memcpy(eth->h_dest, kgdb_remotemac, kgdb_netdevice->addr_len);
>  +
>  +	kgdb_netdevice->hard_start_xmit(skb, kgdb_netdevice);
> -+	if (atomic_read(&skb->users) != 1) {
> -+		BUG();
> -+	}
> -+	kgdbeth_relxlock();
> ++	BUG_ON(atomic_read(&skb->users) != 1);
> ++	kgdbeth_unlock();
>  +}
>  +
>  +static void kgdbeth_flush(void)
> @@ -2317,10 +2364,10 @@
>  +kgdb_eth_reply_arp(void)
>  +{
>  +	if (send_skb) {
> -+		kgdbeth_holdxlock();
> ++		kgdbeth_lock();
>  +	    	kgdb_netdevice->hard_start_xmit(send_skb, kgdb_netdevice);
>  +		send_skb = NULL;
> -+		kgdbeth_relxlock();
> ++		kgdbeth_unlock();
>  +	}
>  +}
>  +
> @@ -2391,7 +2438,7 @@
>  +	}
>  +	/* reply to the ARP request */
>  +
> -+	kgdbeth_holdxlock();
> ++	kgdbeth_lock();
>  +	if (send_skb) {
>  +		/* Get rid of any previous replies to ARP request. We hope
>  +		 * that regular reply to ARP by network layers would have gone
> @@ -2401,7 +2448,7 @@
>  +	send_skb = kgdbeth_alloc_skb(sizeof(struct arphdr) +
>  +			2 * (kgdb_netdevice->addr_len + 4) +
>  +			LL_RESERVED_SPACE(kgdb_netdevice));
> -+	kgdbeth_relxlock();
> ++	kgdbeth_unlock();
>  +
>  +	skb_reserve(send_skb, LL_RESERVED_SPACE(kgdb_netdevice));
>  +	send_skb->nh.raw = send_skb->data;
> @@ -2531,18 +2578,18 @@
>  +	struct irqaction *ia_ptr;
>  +	int i;
>  +
> -+	sprintf(kgdb_netdevname, "eth%d", kgdb_eth);
> ++	sprintf(kgdb_netdev_name, "eth%d", kgdb_eth);
>  +
>  +	for (kgdb_netdevice = dev_base;
>  +		kgdb_netdevice != NULL;
>  +		kgdb_netdevice = kgdb_netdevice->next) {
> -+		if (strncmp(kgdb_netdevice->name, kgdb_netdevname, IFNAMSIZ) == 0) {
> ++		if (strncmp(kgdb_netdevice->name, kgdb_netdev_name, IFNAMSIZ) == 0) {
>  +			break;
>  +		}
>  +	}
>  +	if (!kgdb_netdevice) {
>  +		printk("kgdbeth: Unable to find interface %s\n",
> -+				kgdb_netdevname);
> ++				kgdb_netdev_name);
>  +		return -ENODEV;
>  +	}
>  +	if (!(kgdb_netdevice->flags & IFF_UP)) {
> @@ -2550,7 +2597,7 @@
>  +	}
>  +	ia_ptr = irq_desc[kgdb_netdevice->irq].action;
>  +	while (ia_ptr) {
> -+		if (!strncmp(kgdb_netdevname, ia_ptr->name, IFNAMSIZ)) {
> ++		if (!strncmp(kgdb_netdev_name, ia_ptr->name, IFNAMSIZ)) {
>  +			kgdbeth_irqhandler = ia_ptr->handler;
>  +			break;
>  +		}
> @@ -2558,7 +2605,7 @@
>  +	}
>  +	if (!kgdbeth_irqhandler) {
>  +		printk("kgdbeth: Interface %s doesn't have an interrupt"
> -+			" handler cannot use it\n", kgdb_netdevname);
> ++			" handler cannot use it\n", kgdb_netdev_name);
>  +		return -EINVAL;
>  +	}
>  +	for (i = 0; i < NUM_SENDBUF; i++) {
> @@ -2603,7 +2650,7 @@
>  + * responded yet.
>  + */
>  +static void kgdbeth_begin_session(void) {
> -+	kgdbeth_holdxlock();
> ++	kgdbeth_lock();
>  +	disable_irq(kgdb_netdevice->irq);
>  +	kgdb_eth_reply_arp();
>  +}
> @@ -2611,7 +2658,7 @@
>  +static void kgdbeth_end_session(void)
>  +{
>  +	enable_irq(kgdb_netdevice->irq);
> -+	kgdbeth_relxlock();
> ++	kgdbeth_unlock();
>  +}
>  +
>  +struct kgdb_serial kgdbeth_serial = {
> @@ -2661,7 +2708,7 @@
>  +
>  +int kgdbeth_event(struct notifier_block * self, unsigned long val, void *
> data) +{
> -+	if (strcmp(((struct net_device *)data)->name, kgdb_netdevname)) {
> ++	if (strcmp(((struct net_device *)data)->name, kgdb_netdev_name)) {
>  +		goto out;
>  +	}
>  +	if (val!= NETDEV_UP)
> @@ -2740,8 +2787,8 @@
>  +__setup("kgdbeth=", kgdbeth_opt);
>  Index: linux/include/asm-i386/kgdb.h
>  ===================================================================
> ---- linux.orig/include/asm-i386/kgdb.h	2004-01-20 14:29:19.000000000 +0100
> -+++ linux/include/asm-i386/kgdb.h	2004-01-20 14:29:19.000000000 +0100
> +--- linux.orig/include/asm-i386/kgdb.h	2004-01-23 09:05:16.000000000 +0100
> ++++ linux/include/asm-i386/kgdb.h	2004-01-23 09:05:17.000000000 +0100
>  @@ -0,0 +1,49 @@
>  +#ifndef _ASM_KGDB_H_
>  +#define _ASM_KGDB_H_

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

