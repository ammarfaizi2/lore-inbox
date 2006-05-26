Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWEZIzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWEZIzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWEZIzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:55:45 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:36006 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751196AbWEZIza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:55:30 -0400
Date: Fri, 26 May 2006 17:56:22 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: y-goto@jp.fujitsu.com, linux-ia64@vger.kernel.org, ashok.raj@intel.com,
       steiner@sgi.com, tony.luck@intel.com
Subject: [RFC][PATCH] ia64 node hotplug -- cpu - node relationship fix [0/2]
 intro
Message-Id: <20060526175622.13057d7e.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

current -mm tree includes node-hotplug codes.

But by following reason , ia64's node-hotplug doesn't work well now.

Following patch will fix it. I'd like to post this patch against next -mm.
Feedbacks are welcome.

1. empty-node-fix : avoid creating empty node
   SRAT's enable bit just shows 'you can read this entry'. But the kernel know
   this and checks each entries are vaild or not later.

   But pxm_bit/node_online_mask is not treated as they should be.
   The kernel creates empty node, which has no cpu, no memory.

   Becasue of the empty node, node-hot-added will not create new NODE_DATA at
   hotadd event. It's already created at boot time as empty node.
   I'm now thinking of allocate NODE_DATA on local (hot-added) node. So,
   avoiding to allocate empty NODE_DATA (allocated on off-node) is necessary.

   My concern is whether there is a nice way to detect I/O only node at boot
   time or not. (if we need it) If someone shows it, I'll add it to my patch.

2. cpu-to-node fix: fix cpu-to-node mapping at cpu hotplug
   cpu hotplug on NUMA has to map cpu to its node. From its comment in the code,
   it expects the container hotplug will map pxm to correct node.
   But the container hotplug itself doesn't it now and acpi_map_pxm_to_node()
   is introduced.
   We also need to update node_to_cpu_mask[] and cpu_to_node_map[].

BTW, our team's node-hotplug considers (cpu + memory) hotplug by ACPI's container.
Does anyone has plan of cpu-only-node-hotplug or I/O-only-node-hotplug ?
If someone has, I'll develop memory-less-node hotplug, which just allocates
NODE_DATA of hot-added node.

-Kame

