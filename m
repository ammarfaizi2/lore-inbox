Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWEUTJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWEUTJN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWEUTJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:09:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964917AbWEUTJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:09:12 -0400
Date: Sun, 21 May 2006 12:08:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, ak@suse.de, bob.picco@hp.com,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
 free_area_init_nodes
Message-Id: <20060521120843.43babdc7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605211528390.16327@skynet.skynet.ie>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141151.26912.15976.sendpatchset@skynet>
	<20060520135922.129a481d.akpm@osdl.org>
	<Pine.LNX.4.64.0605211528390.16327@skynet.skynet.ie>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> wrote:
>

> > Anyway, I just don't get how this code can work.  We have an e820 map with
> > up to 128 entries (this machine has ten) and we're trying to scrunch that
> > all into the four-entry early_node_map[].
> >
> 
> Missing E820MAX was a mistake. On x86_64, CONFIG_MAX_ACTIVE_REGIONS should 
> have been used. I didn't expect x86_64 to have so many memory holes.

x86 uses 128 e820 slots too.

>
> > On my little x86 PC:
> >
> > BIOS-provided physical RAM map:
> > BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
> > BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
> > BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> > BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
> > BIOS-e820: 000000000ffc0000 - 000000000fff8000 (ACPI data)
> > BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
> > BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> > BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> > BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
> > BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> > 0MB HIGHMEM available.
> > 255MB LOWMEM available.
> > found SMP MP-table at 000ff780
> > Range (nid 0) 0 -> 65472, max 4
> > On node 0 totalpages: 65472
> >  DMA zone: 4096 pages, LIFO batch:0
> >  Normal zone: 61376 pages, LIFO batch:15
> >
> > So here, the architecture code only called add_active_range() the once, for
> > the entire memory map.
>
> Because in this case, the architecture reported that there was just one 
> range of available pages with no holes.

So..  we're registering a simgle blob of pfns which includes the "reserved"
memory as well as the "ACPI data" and the "ACPI NVS" (with an apparent
off-by-one here).

How come the machine still works?  I guess the architecture went and marked
those pfns reserved.

> > If so, perhaps the bug is that the x86_64 code isn't doing that.  And that
>  > x86 isn't doing it for some people either.
>  >
> 
>  I'm hoping in this case that having MAX_ACTIVE_REGIONS match E820MAX will 
>  fix the issue on your machine.

I expect it will.

One does wonder whether it's worth all this fuss though.  It's only a
24-byte structure and it's all thrown away in free_initmem().  One _could_
just go and do

	#define MAX_ACTIVE_REGIONS 10000

and be happy.

> I'm still confused why Christian's failed 
>  to boot with the patch backed out though.

He didn't get any "Too many memory regions" messages, so it's something
different.

Maybe he hit my off-by-one on his "ACPI data"?

hm, I didn't mention this in the earlier email.   On my x86 I have

  BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
  BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
  BIOS-e820: 000000000ffc0000 - 000000000fff8000 (ACPI data)
  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)

I added some debug and saw that add_active_range() was getting a
start_pfn=0 and an end_pfn which corresponds with 0x0fffc000.  So my "ACPI
NVS" is getting chopped off.

If Christian is seeing a similar thing then his "ACPI data" will be getting
only part-registered.

I'd suggest that the next rev be liberal in its printking.  This is the
debug patch I used:

 mm/page_alloc.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff -puN mm/page_alloc.c~a mm/page_alloc.c
--- devel/mm/page_alloc.c~a	2006-05-20 13:19:58.000000000 -0700
+++ devel-akpm/mm/page_alloc.c	2006-05-20 13:20:42.000000000 -0700
@@ -2463,22 +2463,36 @@ void __init add_active_range(unsigned in
 						unsigned long end_pfn)
 {
 	unsigned int i;
-	printk(KERN_DEBUG "Range (%d) %lu -> %lu\n", nid, start_pfn, end_pfn);
+
+	printk("Range (nid %d) %lu -> %lu, max %d\n",
+			nid, start_pfn, end_pfn, MAX_ACTIVE_REGIONS - 1);
 
 	/* Merge with existing active regions if possible */
 	for (i = 0; early_node_map[i].end_pfn; i++) {
-		if (early_node_map[i].nid != nid)
+		printk("i=%d early_node_map[i].nid=%d "
+				"early_node_map[i].start_pfn=%lu "
+				"early_node_map[i].end_pfn=%lu",
+			i, early_node_map[i].nid,
+			early_node_map[i].start_pfn,
+			early_node_map[i].end_pfn);
+
+		if (early_node_map[i].nid != nid) {
+			printk(" continue 1\n");
 			continue;
+		}
 
 		/* Skip if an existing region covers this new one */
 		if (start_pfn >= early_node_map[i].start_pfn &&
-				end_pfn <= early_node_map[i].end_pfn)
+				end_pfn <= early_node_map[i].end_pfn) {
+			printk(" return 1\n");
 			return;
+		}
 
 		/* Merge forward if suitable */
 		if (start_pfn <= early_node_map[i].end_pfn &&
 				end_pfn > early_node_map[i].end_pfn) {
 			early_node_map[i].end_pfn = end_pfn;
+			printk(" return 2\n");
 			return;
 		}
 
@@ -2486,13 +2500,16 @@ void __init add_active_range(unsigned in
 		if (start_pfn < early_node_map[i].end_pfn &&
 				end_pfn >= early_node_map[i].start_pfn) {
 			early_node_map[i].start_pfn = start_pfn;
+			printk(" return 3\n");
 			return;
 		}
+		printk("\n");
 	}
 
 	/* Leave last entry NULL, we use range.end_pfn to terminate the walk */
 	if (i >= MAX_ACTIVE_REGIONS - 1) {
-		printk(KERN_ERR "Too many memory regions, truncating\n");
+		printk(KERN_ERR "More than %d memory regions, truncating\n",
+				MAX_ACTIVE_REGIONS - 1);
 		return;
 	}
 
_

