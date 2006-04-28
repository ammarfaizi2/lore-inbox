Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWD1Ap7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWD1Ap7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWD1Ap7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:45:59 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:9347 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965061AbWD1Ap7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:45:59 -0400
Date: Fri, 28 Apr 2006 09:47:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: jschopp <jschopp@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       akpm@osdl.org
Subject: Re: [Lhms-devel] [PATCH] register hot-added memory to iomem
 resource
Message-Id: <20060428094703.62e4a3c1.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4450ECE8.6050708@austin.ibm.com>
References: <20060427204904.5037f6ea.kamezawa.hiroyu@jp.fujitsu.com>
	<4450ECE8.6050708@austin.ibm.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006 11:10:16 -0500
jschopp <jschopp@austin.ibm.com> wrote:

> > +/* add this memory to iomem resource */
> > +static void register_memory_resource(u64 start, u64 size)
> > +{
> > +	struct resource *res;
> > +
> > +	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> > +	BUG_ON(!res);
> > +
> > +	res->name = "System RAM";
> > +	res->start = start;
> > +	res->end = start + size - 1;
> > +	res->flags = IORESOURCE_MEM;
> > +	if (request_resource(&iomem_resource, res) < 0) {
> > +		printk("System RAM resource %llx - %llx cannot be added\n",
> > +		(unsigned long long)res->start, (unsigned long long)res->end);
> > +		kfree(res);
> > +	}
> > +}
> 
> This is more of a question than a comment.  Is this code saying that all memory we are 
> adding is available for IO?  And is it really true that on all platforms any memory we add 
> can be used that way?
> 
No. However list name is iomem_resource (from historical reason), 
This registration doesn't mean memory for IO, just shows memory-map.
( I consider so...)

I think this modification is done on ia64 recently.
- http://www.gelato.unsw.edu.au/archives/linux-ia64/0507/14758.html

If powerpc people doesn't like this, add new CONFIG will be necessary.
(like CONFIG_EXPORT_SYSTEM_RAM) But I think powerpc can export memory range
from /proc as x86/x86_64/ia64.
(But I don't have powerpc, I can't test/write patch)

Example: my desctop
When cat /proc/iomem, System RAM is shown in followingf way.

==
00000000-0009fbff : System RAM    <------
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-2dfeffff : System RAM    <------
  00100000-003e0f48 : Kernel code
  003e0f49-00542003 : Kernel data
2dff0000-2dff2fff : ACPI Non-volatile Storage
2dff3000-2dffffff : ACPI Tables
30000000-31ffffff : PCI CardBus #02
32000000-33ffffff : PCI CardBus #02
34000000-35ffffff : PCI CardBus #06
36000000-37ffffff : PCI CardBus #06
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
e8000000-ebffffff : 0000:00:00.0
ec000000-ec0fffff : PCI Bus #01
  ec000000-ec01ffff : 0000:01:00.0
ec100000-ec1fffff : 0000:00:09.0
ec200000-ec20ffff : 0000:00:08.0
ec210000-ec210fff : 0000:00:03.3
  ec210000-ec210fff : ehci_hcd
ec211000-ec211fff : 0000:00:03.0
  ec211000-ec211fff : ohci_hcd
ec212000-ec212fff : 0000:00:03.1
  ec212000-ec212fff : ohci_hcd
ec213000-ec2130ff : 0000:00:0c.0
  ec213000-ec2130ff : 8139too
ec214000-ec214fff : 0000:00:0d.0
ec219000-ec219fff : 0000:00:0d.1
ec21e000-ec21e7ff : 0000:00:0d.2
  ec21e000-ec21e7ff : ohci1394
ec21f000-ec21f0ff : 0000:00:0d.3
ec220000-ec2200ff : 0000:00:0d.4
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

