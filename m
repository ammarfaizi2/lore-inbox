Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbUD2JYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUD2JYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 05:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUD2JYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 05:24:21 -0400
Received: from nobody.lpr.e-technik.tu-muenchen.de ([129.187.151.1]:17598 "EHLO
	nobody.lpr.e-technik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262112AbUD2JYS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 05:24:18 -0400
Subject: Re: [BUG]linux-2.4.26 Quad-Opteron: panic when init scsi
From: "Alexander v. Buelow" <buelow@lpr.e-technik.tu-muenchen.de>
To: Andi Kleen <ak@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Juergen Stohr <stohr@lpr.e-technik.tu-muenchen.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Message-Id: <1083230651.25322.38.camel@floyd.lpr.e-technik.tu-muenchen.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Apr 2004 11:24:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> It looks like you compiled this on a SuSE 9.0/64bit system, right?
> I presume this means the SuSE 2.4.21 smp kernel worked on the same
> box, right? 

Yes, that's right.

> Can you perhaps try to narrow down where it broke between (mainline)
> 2.4.21 and 2.4.26 ? 

We tried: 2.4.21 -> ok
          2.4.22 -> ok
	  2.4.23 -> not ok !!

Then we tried to find the error and I changed in mm/numa.c:

--- linux-2.4.26/mm/numa.c      2001-09-18 01:15:02.000000000 +0200
+++ linux-2.4.26-recoms/mm/numa.c       2004-04-27 18:25:28.000000000
+0200
@@ -105,6 +105,11 @@
                return NULL;
 #ifdef CONFIG_NUMA
        temp = NODE_DATA(numa_node_id());
+       if((gfp_mask & GFP_DMA) == GFP_DMA)
+         {
+           printk(KERN_WARNING "RECOMS: Umleitung DMA auf CPU 0\n");
+           temp = NODE_DATA(0);
+         }
 #else
        spin_lock_irqsave(&node_lock, flags);
        if (!next) next = pgdat_list;

And in mm/page_alloc.c I added in void __init free_area_init_core(..):

*gmap = pgdat->node_mem_map = lmem_map;
pgdat->node_size = totalpages;
pgdat->node_start_paddr = zone_start_paddr;
pgdat->node_start_mapnr = (lmem_map - mem_map);
pgdat->nr_zones = 0;
+// Alex:
+pgdat->node_id = nid;

offset = lmem_map - mem_map;
for (j = 0; j < MAX_NR_ZONES; j++) {

This seemed to work, the scsi error didn't occur any more. 

But then we ran into various other problems: Sometimes we got MCEs (GART
TLB) and different kernel errors like page fault, NULL pointer
dereference and general protection fault. These errors are not
reproducible but occur frequently.

I hope you will find a solution!

Regards,

Jürgen and Alexander

-- 
-----------------------------------------------------------------------    
Dipl.-Ing. Alexander von Buelow                http://www.rcs.ei.tum.de
Institute for Real-Time Computersystems (RCS)      fon +49/89-289-23556 
Technische Universitaet Muenchen, D-80290 Muenchen fax +49/89-289-23555
