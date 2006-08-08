Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWHHA5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWHHA5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 20:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWHHA5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 20:57:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:18871 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932471AbWHHA47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 20:56:59 -0400
Subject: Re: [Lhms-devel] [PATCH 1/10] hot-add-mem x86_64: acpi motherboard
	fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: andrew <akpm@osdl.org>, discuss <discuss@x86-64.org>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20060808093110.f7b2ae04.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
	 <20060805145137.aad34b44.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154975968.5790.16.camel@keithlap>
	 <20060808093110.f7b2ae04.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Mon, 07 Aug 2006 17:56:56 -0700
Message-Id: <1154998617.5790.31.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 09:31 +0900, KAMEZAWA Hiroyuki wrote:
> On Mon, 07 Aug 2006 11:39:27 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > On Sat, 2006-08-05 at 14:51 +0900, KAMEZAWA Hiroyuki wrote:
> > > On Fri, 4 Aug 2006 07:13:51 -0600
> > > Keith Mannthey <kmannth@us.ibm.com> wrote:
> > > > I have worked to integrate the feedback I recived on the last round of patches
> > > > and welcome more ideas/advice. Thanks to everyone who has provied input on
> > > > these patches already. 
> > > > 
> > > Just from review...
> > > 
> > > If new zone , which was empty at boot, are added into the system.
> > > build_all_zonelists() has to be called. (see online_pages() in memory_hotplug.c)
> > > it looks x86_64's __add_pages() doesn't calles it.
> > 
> > With RESERVE there are not empty zones.  All zones (including add-areas)
> > are setup during boot and hot add areas reserved in the bootmem
> > allocator. 
> > 
> > Zones don't change size there is no adding to the zone just on-lining on
> > pages at are already present in the zone. 
> >   
> Hmm, curious.
> please explain. 
> ==
> int __add_pages(struct zone *z, unsigned long start_pfn, unsigned long nr_pages)
> {
>         int err = -EIO;
>         unsigned long pfn;
>         unsigned long total = 0, mem = 0;
>         for (pfn = start_pfn; pfn < start_pfn + nr_pages; pfn++) {
>                 if (pfn_valid(pfn)) {
>                         online_page(pfn_to_page(pfn));
>                         err = 0;
>                         mem++;
>                 }
>                 total++;
>         }
>         if (!err) {
>                 z->spanned_pages += total;
>                 z->present_pages += mem; -------------------------------(*)

It is an accounting issue.  What I meant by re-sizing is there is no
change to node_mem_map (with reserve CONFIG_FLAT_NODE_MEM_MAP is set).
When the original size for the zone is setup it views that add areas as
a "hole" in the e820 space. 

See arch/x86_64/mm/init.c size_zones. 

> ==
> It looks contents of zone is increased at (*). Do I see old code ?
> 
> ==
> static inline int populated_zone(struct zone *zone)
> {
>         return (!!zone->present_pages);
> }
> ==
> "empty zone" I said means a zone which is not populated.

I know of no x86_64 hardware the supports empty node hot-add memory.  If
it exists I would recommend using SPARSEMEM based hot-add.  On HW I am
aware of there is always some memory present in a node at boot.   
 

Thanks,
  Keith 

