Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWBAPU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWBAPU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWBAPU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:20:27 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:31363 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1161089AbWBAPU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:20:26 -0500
Subject: Unable to handle kernel paging request in 2.6.16-rc1-mm4
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Reply-To: lee.schermerhorn@hp.com
To: linux-ia64 <linux-ia64@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>
Content-Type: text/plain
Organization: LOSL, Nashua
Date: Wed, 01 Feb 2006 10:20:07 -0500
Message-Id: <1138807207.5211.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a "heads up" because I haven't found reference to this in the ia64
nor kernel lists.  Maybe just happens on my platform?

I'm seeing this on an HP rx8620 [16xIA64, 4 NUMA nodes, 32GB], booting
subject kernel.  Log excerpts:
---
Unable to handle kernel paging request at virtual address
a004037b4dc28110
events/12[62]: Oops 11012296146944 [1]
<snip>
Call Trace:
<snip>
 [<a00000010000cca0>] ia64_leave_kernel+0x0/0x280
                                sp=e0000721fe84fb80 bsp=e0000721fe849290
 [<a0000001001483b0>] free_block+0x90/0x360
                                sp=e0000721fe84fd50 bsp=e0000721fe849200
 [<a0000001001489d0>] drain_array_locked+0x110/0x180
                                sp=e0000721fe84fd50 bsp=e0000721fe8491b8
 [<a00000010014e6c0>] cache_reap+0x1a0/0x600
                                sp=e0000721fe84fd50 bsp=e0000721fe849140
 [<a0000001000c61c0>] run_workqueue+0x180/0x2c0
                                sp=e0000721fe84fd60 bsp=e0000721fe8490f0
 [<a0000001000c6540>] worker_thread+0x240/0x2c0
                                sp=e0000721fe84fd60 bsp=e0000721fe8490b8
<snip>
 BUG: events/12/62, lock held at task exit time!
 [a000000100867fe0] {cache_chain_mutex}
.. held by:         events/12:   62 [e0000721fe848000, 110]
... acquired at:               cache_reap+0x30/0x600
---
Eventually the boot hangs...

I did a bisection search of the mm4 broken out patches and isolated the
problem to the "export-cpu-topology-by-sysfs" patches.  I.e., if I
comment these out, builds and boots fine [with a one-liner build fix
from Christoph Lameter for an SGI sn pci source file].  Something
overstepping a slab allocation?  Still investigating.

Regards,
Lee

