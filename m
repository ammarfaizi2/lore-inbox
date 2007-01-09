Return-Path: <linux-kernel-owner+w=401wt.eu-S1750951AbXAIDOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbXAIDOu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 22:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbXAIDOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 22:14:50 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:40388 "EHLO
	tomts10-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957AbXAIDOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 22:14:49 -0500
Date: Mon, 8 Jan 2007 22:14:46 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] local_t : Documentation
Message-ID: <20070109031446.GA29426@Krystal>
References: <20061221001545.GP28643@Krystal> <20061223093358.GF3960@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061223093358.GF3960@ucw.cz>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:10:59 up 139 days, 18 min,  5 users,  load average: 0.61, 0.39, 0.34
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek (pavel@suse.cz) wrote:
> Hi!
> 
> > These patches extend and standardise local_t operations on each architectures,
> > allowing a rich set of atomic operations to be done on per-cpu data with
> > minimal performance impact. On some architectures, there seems to be no
> > difference between the SMP and UP operation (same memory barriers, same
> > LOCking), local.h simply includes asm-generic/local.h, which removes duplicated
> > code.
> 
> Could you provide some Documentation/? Knowing when local_t can be
> used is kind-of important.
> 							Pavel

Hi Pavel,

Thanks for this appropriate comment. I totally agree that there is a need for
documentation about how local_t variables should be used. Here is the patch
that adds Documentation/local_ops.txt. Comments are welcome.

Regards,

Mathieu


diff --git a/Documentation/local_ops.txt b/Documentation/local_ops.txt
new file mode 100644
index 0000000..dfeec94
--- /dev/null
+++ b/Documentation/local_ops.txt
@@ -0,0 +1,148 @@
+	     Semantics and Behavior of Local Atomic Operations
+
+			    Mathieu Desnoyers
+
+
+	This document explains the purpose of the local atomic operations, how
+to implement them for any given architecture and shows how they can be used
+properly. It also stresses on the precautions that must be taken when reading
+those local variables across CPUs when the order of memory writes matters.
+
+
+
+* Purpose of local atomic operations
+
+Local atomic operations are meant to provide fast and highly reentrant per CPU
+counters. They minimize the performance cost of standard atomic operations by
+removing the LOCK prefix and memory barriers normally required to synchronize
+across CPUs.
+
+Having fast per CPU atomic counters is interesting in many cases : it does not
+require disabling interrupts to protect from interrupt handlers and it permits
+coherent counters in NMI handlers. It is especially useful for tracing purposes
+and for various performance monitoring counters.
+
+
+* Implementation for a given architecture
+
+It can be done by slightly modifying the standard atomic operations : only
+their UP variant must be kept. It typically means removing LOCK prefix (on
+i386 and x86_64) and any SMP sychronization barrier. If the architecture does
+not have a different behavior between SMP and UP, including asm-generic/local.h
+in your archtecture's local.h is sufficient.
+
+
+* How to use local atomic operations
+
+#include <linux/percpu.h>
+#include <asm/local.h>
+
+static DEFINE_PER_CPU(local_t, counters) = LOCAL_INIT(0);
+
+
+* Counting
+
+In preemptible context, use get_cpu_var() and put_cpu_var() around local atomic
+operations : it makes sure that preemption is disabled around write access to
+the per cpu variable. For instance :
+
+	local_inc(&get_cpu_var(counters));
+	put_cpu_var(counters);
+
+If you are already in a preemption-safe context, you can directly use 
+__get_cpu_var() instead.
+
+	local_inc(&__get_cpu_var(counters));
+
+
+
+* Reading the counters
+
+Those local counters can be read from foreign CPUs to sum the count. Note that
+the data seen by local_read across CPUs must be considered to be out of order
+relatively to other memory writes happening on the CPU that owns the data.
+
+	long sum = 0;
+	for_each_online_cpu(cpu)
+		sum += local_read(&per_cpu(counters, cpu));
+
+If you want to use a remote local_read to synchronize access to a resource
+between CPUs, explicit smp_wmb() and smp_rmb() memory barriers must be used
+respectively on the writer and the reader CPUs. It would be the case if you use
+the local_t variable as a counter of bytes written in a buffer : there should
+be a smp_wmb() between the buffer write and the counter increment and also a
+smp_rmb() between the counter read and the buffer read.
+
+
+Here is a sample module which implements a basic per cpu counter using local.h.
+
+--- BEGIN ---
+/* test-local.c
+ *
+ * Sample module for local.h usage.
+ */
+
+
+#include <asm/local.h>
+#include <linux/module.h>
+#include <linux/timer.h>
+
+static DEFINE_PER_CPU(local_t, counters) = LOCAL_INIT(0);
+
+static struct timer_list test_timer;
+
+/* IPI called on each CPU. */
+static void test_each(void *info)
+{
+	/* Increment the counter from a non preemptible context */
+	printk("Increment on cpu %d\n", smp_processor_id());
+	local_inc(&__get_cpu_var(counters));
+
+	/* This is what incrementing the variable would look like within a
+	 * preemptible context (it disables preemption) :
+	 *
+	 * local_inc(&get_cpu_var(counters));
+	 * put_cpu_var(counters);
+	 */
+}
+
+static void do_test_timer(unsigned long data)
+{
+	int cpu;
+
+	/* Increment the counters */
+	on_each_cpu(test_each, NULL, 0, 1);
+	/* Read all the counters */
+	printk("Counters read from CPU %d\n", smp_processor_id());
+	for_each_online_cpu(cpu) {
+		printk("Read : CPU %d, count %ld\n", cpu,
+			local_read(&per_cpu(counters, cpu)));
+	}
+	del_timer(&test_timer);
+	test_timer.expires = jiffies + 1000;
+	add_timer(&test_timer);
+}
+
+static int __init test_init(void)
+{
+	/* initialize the timer that will increment the counter */
+	init_timer(&test_timer);
+	test_timer.function = do_test_timer;
+	test_timer.expires = jiffies + 1;
+	add_timer(&test_timer);
+
+	return 0;
+}
+
+static void __exit test_exit(void)
+{
+	del_timer_sync(&test_timer);
+}
+
+module_init(test_init);
+module_exit(test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Local Atomic Ops");
+--- END ---
-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
