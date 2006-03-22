Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWCVGH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWCVGH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWCVGH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:07:58 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:2231 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750799AbWCVGH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:07:56 -0500
Date: Wed, 22 Mar 2006 15:06:52 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH: 002/017]Memory hotplug for new nodes v.4.(change name old add_memory() to arch_add_memory())
Cc: akpm@osdl.org, tony.luck@intel.com, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060322103839.3b3d2a66.kamezawa.hiroyu@jp.fujitsu.com>
References: <1142989698.10906.224.camel@localhost.localdomain> <20060322103839.3b3d2a66.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060322120649.E48C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 21 Mar 2006 17:08:18 -0800
> Dave Hansen <haveblue@us.ibm.com> wrote:
> > If I missed it before, please refresh my memory.  But, if we're
> > providing arch_nid_probe(addr), then why don't we just call it inside of
> > add_memory() on the start address, instead of in the generic code?
> > 
> I think just *probe* needs it. The firmware which supports memory-hotplug, ACPI, 
> i386/x86_64/ia64, can tell node number as pxm.(proximity domain)
> 
> add_memory() can pass address of paddr as args, but can't pass *pxm*. 
> 
> We already maintain pxm <-> nid map. But paddr <-> nid map isn't now.
> If add_memory() doesn't has nid as args, we have to maintain
> (1) pxm <-> nid map.
> (2) paddr <-> nid map.
> Becasue pfn_to_nid() is maintained by SPARSEMEM itself now, *new* paddr<->nid map
> is redundant, I think. And I think the firmware already has the map before calling
> add_memory(). 

In ACPI's case, kernel has to do 3 steps to get node id from physicall 
address.
  1) parse DSDT to get device handle of ACPI for new memory.
     This step can be described 3 detail steps.
      1-1) search memory device in DSDT.
      1-2) get _CRS of its memory device to see physicall address.
      1-3) compare 1-2)'s address with required paddr.
           (its memory device might be for other memory.)
           If it is for new memory, then goto step 2),
           else goto 1-1) again.
  2) get pxm against its device handle.
     It is just calling acpi_get_pxm().
  3) get node from pxm. If pxm is new one, new node id is assigned.

Step 1) is a bit complicated.
But, when notify of memory hot-add event reaches via ACPI,
its handle is already obtained. So, step 2) and 3) are enough to
get node id. If node id can be passed at add_memory(), that is all.
If not, kernel losts memory device handle information or node id once
at calling add_memory(), and search memory device handle again by step 1).



In addition, if paddr to node id translation is called in add_memory(),
then its code for -each arch- will be like followings.
This will be close from ugly "copy and paste" again....... :-(
 
add_memory(paddr)
{
	nid = paddr_to_node_id(paddr)
	if (!node_online(nid)) {
		pgdat = hotadd_new_pgdat(nid, start);
		if (!pgdat)
			return -ENOMEM;
	}
              :

Bye.

-- 
Yasunori Goto 


