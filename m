Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUBZXX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbUBZXXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:23:11 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59121 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261253AbUBZXTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:19:51 -0500
Message-ID: <403E7F0C.6000009@mvista.com>
Date: Thu, 26 Feb 2004 15:19:40 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Tom Rini <trini@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <200402261300.34911.amitkale@emsyssoft.com>
In-Reply-To: <200402261300.34911.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Thursday 26 Feb 2004 3:13 am, Tom Rini wrote:
> 
>>The following adds, and then makes use of kgdb_process_breakpoint /
>>kgdb_schedule_breakpoint.  Using it i kgdb_8250.c isn't strictly needed,
>>but it isn't wrong either.
> 
> 
> That makes 8250 response it a _bit_ slower. A user will notice when kgdb 
> doesn't respond within a millisecond of pressing Ctrl+C :-)

Hm...  I have been wondering if it might not be a good idea to put some comments 
to the user at or around the breakpoint.  Possibly we might want to tell the 
user about where the info files are or some such.  This would then come up on 
his screen when the source code at the breakpoint is displayed.

comments...

-g
> 
> OK to checkin.
> -Amit
> 
> 
>># This is a BitKeeper generated patch for the following project:
>># Project Name: Linux kernel tree
>># This patch format is intended for GNU patch command version 2.5 or
>>higher. # This patch includes the following deltas:
>>#	           ChangeSet	1.1663  -> 1.1664
>>#	arch/i386/kernel/irq.c	1.48    -> 1.49
>>#	drivers/net/kgdb_eth.c	1.2     -> 1.3
>>#	arch/x86_64/kernel/irq.c	1.21    -> 1.22
>>#	drivers/serial/kgdb_8250.c	1.3     -> 1.4
>>#	       kernel/kgdb.c	1.3     -> 1.4
>>#	arch/ppc/kernel/irq.c	1.36    -> 1.37
>>#	include/linux/kgdb.h	1.3     -> 1.4
>>#
>># The following is the BitKeeper ChangeSet Log
>># --------------------------------------------
>># 04/02/25	trini@kernel.crashing.org	1.1664
>># process_breakpoint/schedule_breakpoint.
>># --------------------------------------------
>>#
>>diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
>>--- a/arch/i386/kernel/irq.c	Wed Feb 25 14:21:32 2004
>>+++ b/arch/i386/kernel/irq.c	Wed Feb 25 14:21:32 2004
>>@@ -34,6 +34,7 @@
>> #include <linux/proc_fs.h>
>> #include <linux/seq_file.h>
>> #include <linux/kallsyms.h>
>>+#include <linux/kgdb.h>
>>
>> #include <asm/atomic.h>
>> #include <asm/io.h>
>>@@ -507,6 +508,8 @@
>> 	spin_unlock(&desc->lock);
>>
>> 	irq_exit();
>>+
>>+	kgdb_process_breakpoint();
>>
>> 	return 1;
>> }
>>diff -Nru a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
>>--- a/arch/ppc/kernel/irq.c	Wed Feb 25 14:21:32 2004
>>+++ b/arch/ppc/kernel/irq.c	Wed Feb 25 14:21:32 2004
>>@@ -46,6 +46,7 @@
>> #include <linux/random.h>
>> #include <linux/seq_file.h>
>> #include <linux/cpumask.h>
>>+#include <linux/kgdb.h>
>>
>> #include <asm/uaccess.h>
>> #include <asm/bitops.h>
>>@@ -536,7 +537,9 @@
>> 	if (irq != -2 && first)
>> 		/* That's not SMP safe ... but who cares ? */
>> 		ppc_spurious_interrupts++;
>>-        irq_exit();
>>+	irq_exit();
>>+
>>+	kgdb_process_breakpoint();
>> }
>>
>> unsigned long probe_irq_on (void)
>>diff -Nru a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
>>--- a/arch/x86_64/kernel/irq.c	Wed Feb 25 14:21:32 2004
>>+++ b/arch/x86_64/kernel/irq.c	Wed Feb 25 14:21:32 2004
>>@@ -405,6 +405,8 @@
>> 	spin_unlock(&desc->lock);
>>
>> 	irq_exit();
>>+
>>+	kgdb_process_breakpoint();
>> 	return 1;
>> }
>>
>>diff -Nru a/drivers/net/kgdb_eth.c b/drivers/net/kgdb_eth.c
>>--- a/drivers/net/kgdb_eth.c	Wed Feb 25 14:21:32 2004
>>+++ b/drivers/net/kgdb_eth.c	Wed Feb 25 14:21:32 2004
>>@@ -60,7 +60,6 @@
>> static atomic_t in_count;
>> int kgdboe = 0;			/* Default to tty mode */
>>
>>-extern void breakpoint(void);
>> static void rx_hook(struct netpoll *np, int port, char *msg, int len);
>>
>> static struct netpoll np = {
>>@@ -106,14 +105,12 @@
>>
>> 	np->remote_port = port;
>>
>>-	/* Is this gdb trying to attach? */
>>-	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
>>-		breakpoint();
>>+	/* Is this gdb trying to attach (!kgdb_connected) or break in
>>+	 * (msg[0] == 3) ? */
>>+	if (!netpoll_trap() && (!kgdb_connected || msg[0] == 3))
>>+		 kgdb_schedule_breakpoint();
>>
>> 	for (i = 0; i < len; i++) {
>>-		if (msg[i] == 3)
>>-			breakpoint();
>>-
>> 		if (atomic_read(&in_count) >= IN_BUF_SIZE) {
>> 			/* buffer overflow, clear it */
>> 			in_head = in_tail = 0;
>>diff -Nru a/drivers/serial/kgdb_8250.c b/drivers/serial/kgdb_8250.c
>>--- a/drivers/serial/kgdb_8250.c	Wed Feb 25 14:21:32 2004
>>+++ b/drivers/serial/kgdb_8250.c	Wed Feb 25 14:21:32 2004
>>@@ -248,7 +248,7 @@
>>
>> 	/* If we get an interrupt, then KGDB is trying to connect. */
>> 	if (!kgdb_connected) {
>>-		breakpoint();
>>+		kgdb_schedule_breakpoint();
>> 		return IRQ_HANDLED;
>> 	}
>>
>>diff -Nru a/include/linux/kgdb.h b/include/linux/kgdb.h
>>--- a/include/linux/kgdb.h	Wed Feb 25 14:21:32 2004
>>+++ b/include/linux/kgdb.h	Wed Feb 25 14:21:32 2004
>>@@ -11,8 +11,22 @@
>> #include <asm/atomic.h>
>> #include <linux/debugger.h>
>>
>>+/*
>>+ * This file should not include ANY others.  This makes it usable
>>+ * most anywhere without the fear of include order or inclusion.
>>+ * TODO: Make it so!
>>+ *
>>+ * This file may be included all the time.  It is only active if
>>+ * CONFIG_KGDB is defined, otherwise it stubs out all the macros
>>+ * and entry points.
>>+ */
>>+
>>+#if defined(CONFIG_KGDB) && !defined(__ASSEMBLY__)
>> /* To enter the debugger explicitly. */
>>-void breakpoint(void);
>>+extern void breakpoint(void);
>>+extern void kgdb_schedule_breakpoint(void);
>>+extern void kgdb_process_breakpoint(void);
>>+extern volatile int kgdb_connected;
>>
>> #ifndef KGDB_MAX_NO_CPUS
>> #if CONFIG_NR_CPUS > 8
>>@@ -112,4 +126,7 @@
>> char *kgdb_hex2mem(char *buf, char *mem, int count);
>> int kgdb_get_mem(char *addr, unsigned char *buf, int count);
>>
>>+#else
>>+#define kgdb_process_breakpoint()      do {} while(0)
>>+#endif /* KGDB && !__ASSEMBLY__ */
>> #endif				/* _KGDB_H_ */
>>diff -Nru a/kernel/kgdb.c b/kernel/kgdb.c
>>--- a/kernel/kgdb.c	Wed Feb 25 14:21:32 2004
>>+++ b/kernel/kgdb.c	Wed Feb 25 14:21:32 2004
>>@@ -1169,6 +1169,29 @@
>> 	printk("Connected.\n");
>> }
>>
>>+/*
>>+ * Sometimes we need to schedule a breakpoint because we can't break
>>+ * right where we are.
>>+ */
>>+static int kgdb_need_breakpoint[NR_CPUS];
>>+
>>+void kgdb_schedule_breakpoint(void)
>>+{
>>+	kgdb_need_breakpoint[smp_processor_id()] = 1;
>>+}
>>+
>>+void kgdb_process_breakpoint(void)
>>+{
>>+	/*
>>+	 * Handle a breakpoint queued from inside network driver code
>>+	  * to avoid reentrancy issues
>>+	 */
>>+	if (kgdb_need_breakpoint[smp_processor_id()]) {
>>+		 kgdb_need_breakpoint[smp_processor_id()] = 0;
>>+		 breakpoint();
>>+	}
>>+}
>>+
>> #ifdef CONFIG_KGDB_CONSOLE
>> char kgdbconbuf[BUFMAX];
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

