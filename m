Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbULZA2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbULZA2J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 19:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbULZA2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 19:28:09 -0500
Received: from ozlabs.org ([203.10.76.45]:32170 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261592AbULZA1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 19:27:36 -0500
Date: Sun, 26 Dec 2004 11:27:44 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, greg@kroah.com, miltonm@bga.com
Subject: 3 ways to represent cpu affinity in /sys and counting
Message-ID: <20041226002744.GC21710@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We have a patch to change pcibus_to_cpumask to pcibus_to_node. This makes
it more consistent with cpu_to_node, and when you want a cpumask you
use node_to_cpumask.

The one real user of pcibus_to_cpumask in arch/x86-64/kernel/pci-gart.c
highlights this:

	cpumask_t mask;
	mask = pcibus_to_cpumask(to_pci_dev(dev)->bus->number);
	node = cpu_to_node(first_cpu(mask));

We go around in circles to get back to the node. I then started looking
at how we export cpu affinity and node information in sysfs:

A pci device has a local_cpus property:

/sys/devices/pci000a:00/000a:00:02.6/local_cpus

A pci_bus has a cpuaffinity property:

/sys/class/pci_bus/000d:d8/cpuaffinity

A node has a cpumap property:

/sys/devices/system/node/node3/cpumap

Can we standardize on a single property name for this? :)

Furthermore, looking at node linkages:

A node has symlinks to cpus:

/sys/devices/system/node/node0/cpu0 -> /sys/devices/system/cpu/cpu0

But doesnt have symlinks to pci devices.

A cpu doesnt have a cpumask of its node, but a pci device and pci bus
both do. Is there some way we can stardardize this too? 

Ideally we want to be able to lookup a device -> node -> cpumask
relationship in a consistent way. Assuming we fix up the 3 different
names for cpu affinity properties, we still have 2 methods of looking
that up, and no easy way of going from pci devices to nodes.

Anton
