Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUHQG0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUHQG0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 02:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUHQG0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 02:26:18 -0400
Received: from jade.spiritone.com ([216.99.193.136]:52892 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S263448AbUHQGZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 02:25:58 -0400
Date: Mon, 16 Aug 2004 23:25:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Sam Ravnborg <sam@ravnborg.org>, Nathan Lynch <nathanl@austin.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <141950000.1092723938@[10.10.2.4]>
In-Reply-To: <20040817065901.GB7173@mars.ravnborg.org>
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <121120000.1092699569@flay> <1092706344.3081.4.camel@booger> <20040817065901.GB7173@mars.ravnborg.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 16, 2004 at 08:32:24PM -0500, Nathan Lynch wrote:
>> On Mon, 2004-08-16 at 18:39, Martin J. Bligh wrote:
>> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm1
>> > 
>> > make install from this config file:
>> > 
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/config.numaq
>> > 
>> > results in this failure:
>> > 
>> > make: *** No rule to make target `.tmp_kallsyms2.S', needed by `.tmp_kallsyms2.o'.  Stop.
>> 
>> I hit the same thing on ppc64 with gcc 3.3.2-ish.  Doing a non-parallel
>> make (i.e. without -j) seems to work around it for me.
> Fix below:
> 
> 	Sam
> 
> ===== Makefile 1.516 vs edited =====
> --- 1.516/Makefile	2004-08-12 23:09:08 +02:00
> +++ edited/Makefile	2004-08-16 23:40:09 +02:00
> @@ -600,6 +600,9 @@
>  .tmp_vmlinux3: $(vmlinux-objs) .tmp_kallsyms2.o arch/$(ARCH)/kernel/vmlinux.lds FORCE
>  	$(call if_changed_rule,vmlinux__)
>  
> +# Needs to visit scripts/ before $(KALLSYMS) can be used.
> +$(KALLSYMS): scripts ;
> +
>  endif
>  
>  # Finally the vmlinux rule

Well ... that worked - thanks. But NUMA is still FITH.


arch/i386/mm/discontig.c: In function `zone_sizes_init':
arch/i386/mm/discontig.c:422: warning: passing arg 3 of `free_area_init_node' from incompatible pointer type
arch/i386/mm/discontig.c:422: warning: passing arg 4 of `free_area_init_node' makes pointer from integer without a cast
arch/i386/mm/discontig.c:422: warning: passing arg 5 of `free_area_init_node' makes integer from pointer without a cast
arch/i386/mm/discontig.c:422: too few arguments to function `free_area_init_node'
arch/i386/mm/discontig.c:430: warning: passing arg 3 of `free_area_init_node' from incompatible pointer type
arch/i386/mm/discontig.c:430: warning: passing arg 4 of `free_area_init_node' makes pointer from integer without a cast
arch/i386/mm/discontig.c:430: warning: passing arg 5 of `free_area_init_node' makes integer from pointer without a cast
arch/i386/mm/discontig.c:430: too few arguments to function `free_area_init_node'
make[1]: *** [arch/i386/mm/discontig.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/i386/mm] Error 2
make: *** Waiting for unfinished jobs....
larry:~/linux/2.6.8.1-mm1# 


Which looks rather like the problem that this patch fixed (cut & pasted, sorry ....) 

--- mm2-2.6.8-rc3.orig/arch/i386/mm/discontig.c 2004-08-08 15:39:24.000000000 -0
700
+++ mm2-2.6.8-rc3/arch/i386/mm/discontig.c      2004-08-09 01:18:30.750614368 -0
700
@@ -418,15 +418,15 @@
                 * remapped KVA area - mbligh
                 */
                if (!nid)
-                       free_area_init_node(nid, NODE_DATA(nid), 0, 
-                               zones_size, start, zholes_size);
+                       free_area_init_node(nid, NODE_DATA(nid),
+                                       zones_size, start, zholes_size);
                else {
                        unsigned long lmem_map;
                        lmem_map = (unsigned long)node_remap_start_vaddr[nid];
                        lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
                        lmem_map &= PAGE_MASK;
-                       free_area_init_node(nid, NODE_DATA(nid), 
-                               (struct page *)lmem_map, zones_size, 
+                       NODE_DATA(nid)->node_mem_map = (struct page *)lmem_map;
+                       free_area_init_node(nid, NODE_DATA(nid), zones_size, 
                                start, zholes_size);
                }
        }


Except that's already applied ... Andrew - did you back out the one this was fixing?
If so, I presume this one needs to die too ... backing it out by hand seems to fix 
compilation, at least. (dont-pass-mem_map-into-init-functions-x86-fix.patch)

M.



