Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbUKEQKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUKEQKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbUKEQKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:10:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56256 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261153AbUKEQIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:08:32 -0500
Date: Fri, 5 Nov 2004 10:08:08 -0600
From: Jack Steiner <steiner@sgi.com>
To: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
Cc: ak@suse.de, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041105160808.GA26719@sgi.com>
References: <20041103205655.GA5084@sgi.com> <20041104.105908.18574694.t-kochi@bq.jp.nec.com> <20041104040713.GC21211@wotan.suse.de> <20041104.135721.08317994.t-kochi@bq.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104.135721.08317994.t-kochi@bq.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the ideas from Andi & Takayoshi, I created a patch to
add the SLIT distance information to the sysfs.

I've tested this on Altix/IA64 & it appears to work ok. I have 
not tried it on other architectures.

Andi also posted a related patch for adding similar information 
for PCI busses.

Comments, suggestions, .....


	# cd /sys/devices/system
	# find .
	./node
	./node/node5
	./node/node5/cpu11
	./node/node5/cpu10
	./node/node5/distance
	./node/node5/numastat
	./node/node5/meminfo
	./node/node5/cpumap
	./node/node4
	./node/node4/cpu9
	./node/node4/cpu8
	./node/node4/distance
	./node/node4/numastat
	./node/node4/meminfo
	./node/node4/cpumap
	....
	./cpu
	./cpu/cpu11
	./cpu/cpu11/distance
	./cpu/cpu10
	./cpu/cpu10/distance
	./cpu/cpu9
	./cpu/cpu9/distance
	./cpu/cpu8
	...

	# cat ./node/node0/distance
	10 20 64 42 42 22

	# cat ./cpu/cpu8/distance
	42 42 64 64 22 22 42 42 10 10 20 20

	# cat node/*/distance
	10 20 64 42 42 22
	20 10 42 22 64 84
	64 42 10 20 22 42
	42 22 20 10 42 62
	42 64 22 42 10 20
	22 84 42 62 20 10

	# cat cpu/*/distance
	10 10 20 20 64 64 42 42 42 42 22 22
	10 10 20 20 64 64 42 42 42 42 22 22
	20 20 10 10 42 42 22 22 64 64 84 84
	20 20 10 10 42 42 22 22 64 64 84 84
	64 64 42 42 10 10 20 20 22 22 42 42
	64 64 42 42 10 10 20 20 22 22 42 42
	42 42 22 22 20 20 10 10 42 42 62 62
	42 42 22 22 20 20 10 10 42 42 62 62
	42 42 64 64 22 22 42 42 10 10 20 20
	42 42 64 64 22 22 42 42 10 10 20 20
	22 22 84 84 42 42 62 62 20 20 10 10
	22 22 84 84 42 42 62 62 20 20 10 10



Index: linux/drivers/base/node.c
===================================================================
--- linux.orig/drivers/base/node.c	2004-11-05 08:34:42.000000000 -0600
+++ linux/drivers/base/node.c	2004-11-05 09:00:01.000000000 -0600
@@ -111,6 +111,21 @@ static ssize_t node_read_numastat(struct
 }
 static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
+static ssize_t node_read_distance(struct sys_device * dev, char * buf)
+{
+	int nid = dev->id;
+	int len = 0;
+	int i;
+
+	for (i = 0; i < numnodes; i++)
+		len += sprintf(buf + len, "%s%d", i ? " " : "", node_distance(nid, i));
+		
+	len += sprintf(buf + len, "\n");
+	return len;
+}
+static SYSDEV_ATTR(distance, S_IRUGO, node_read_distance, NULL);
+
+
 /*
  * register_node - Setup a driverfs device for a node.
  * @num - Node number to use when creating the device.
@@ -129,6 +144,7 @@ int __init register_node(struct node *no
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
 		sysdev_create_file(&node->sysdev, &attr_meminfo);
 		sysdev_create_file(&node->sysdev, &attr_numastat);
+		sysdev_create_file(&node->sysdev, &attr_distance);
 	}
 	return error;
 }
Index: linux/drivers/base/cpu.c
===================================================================
--- linux.orig/drivers/base/cpu.c	2004-11-05 08:58:09.000000000 -0600
+++ linux/drivers/base/cpu.c	2004-11-05 08:59:25.000000000 -0600
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/topology.h>
 #include <linux/device.h>
+#include <linux/cpumask.h>
 
 
 struct sysdev_class cpu_sysdev_class = {
@@ -58,6 +59,31 @@ static inline void register_cpu_control(
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_NUMA
+static ssize_t cpu_read_distance(struct sys_device * dev, char * buf)
+{
+	int nid = cpu_to_node(dev->id);
+	int len = 0;
+	int i;
+
+	for (i = 0; i < num_possible_cpus(); i++)
+		len += sprintf(buf + len, "%s%d", i ? " " : "", 
+			node_distance(nid, cpu_to_node(i)));
+	len += sprintf(buf + len, "\n");
+	return len;
+}
+static SYSDEV_ATTR(distance, S_IRUGO, cpu_read_distance, NULL);
+
+static inline void register_cpu_distance(struct cpu *cpu)
+{
+	sysdev_create_file(&cpu->sysdev, &attr_distance);
+}
+#else /* !CONFIG_NUMA */
+static inline void register_cpu_distance(struct cpu *cpu)
+{
+}
+#endif
+
 /*
  * register_cpu - Setup a driverfs device for a CPU.
  * @cpu - Callers can set the cpu->no_control field to 1, to indicate not to
@@ -81,6 +107,10 @@ int __init register_cpu(struct cpu *cpu,
 					  kobject_name(&cpu->sysdev.kobj));
 	if (!error && !cpu->no_control)
 		register_cpu_control(cpu);
+
+	if (!error)
+		register_cpu_distance(cpu);
+
 	return error;
 }
 

On Thu, Nov 04, 2004 at 01:57:21PM +0900, Takayoshi Kochi wrote:
> Hi,
> 
> From: Andi Kleen <ak@suse.de>
> Subject: Re: Externalize SLIT table
> Date: Thu, 4 Nov 2004 05:07:13 +0100
> 
> > > Why not export node_distance() under sysfs?
> > > I like (1).
> > > 
> > > (1) obey one-value-per-file sysfs principle
> > > 
> > > % cat /sys/devices/system/node/node0/distance0
> > > 10
> > 
> > Surely distance from 0 to 0 is 0?
> 
> According to the ACPI spec, 10 means local and other values
> mean ratio to 10.  But what the distance number should mean
> mean is ambiguous from the spec (e.g. some veondors interpret as
> memory access latency, others interpret as memory throughput
> etc.)
> However relative distance just works for most of uses, I believe.
> 
> Anyway, we should clarify how the numbers should be interpreted
> to avoid confusion.
> 
> How about this?
> "The distance to itself means the base value.  Distance to
> other nodes are relative to the base value.
> 0 means unreachable (hot-removed or disabled) to that node."
> 
> (Just FYI, numbers 0-9 are reserved and 255 (unsigned char -1) means
> unreachable, according to the ACPI spec.)
> 
> > > % cat /sys/devices/system/node/node0/distance1
> > > 66
> > 
> > > 
> > > (2) one distance for each line
> > > 
> > > % cat /sys/devices/system/node/node0/distance
> > > 0:10
> > > 1:66
> > > 2:46
> > > 3:66
> > > 
> > > (3) all distances in one line like /proc/<PID>/stat
> > > 
> > > % cat /sys/devices/system/node/node0/distance
> > > 10 66 46 66
> > 
> > I would prefer that. 
> 
> Ah, I missed the following last sentence in
> Documentation/filesystems/sysfs.txt:
> 
> |Attributes should be ASCII text files, preferably with only one value
> |per file. It is noted that it may not be efficient to contain only
> |value per file, so it is socially acceptable to express an array of
> |values of the same type. 
> 
> If an array is acceptable, I would prefer (3), too.
> 
> ---
> Takayoshi Kochi

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


