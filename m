Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWHHA3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWHHA3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 20:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWHHA3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 20:29:06 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:139 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932369AbWHHA3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 20:29:05 -0400
Date: Tue, 8 Aug 2006 09:31:10 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: kmannth@us.ibm.com
Cc: akpm@osdl.org, discuss@x86-64.org, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [Lhms-devel] [PATCH 1/10] hot-add-mem x86_64: acpi motherboard
 fix
Message-Id: <20060808093110.f7b2ae04.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1154975968.5790.16.camel@keithlap>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
	<20060805145137.aad34b44.kamezawa.hiroyu@jp.fujitsu.com>
	<1154975968.5790.16.camel@keithlap>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 11:39:27 -0700
keith mannthey <kmannth@us.ibm.com> wrote:

> On Sat, 2006-08-05 at 14:51 +0900, KAMEZAWA Hiroyuki wrote:
> > On Fri, 4 Aug 2006 07:13:51 -0600
> > Keith Mannthey <kmannth@us.ibm.com> wrote:
> > > I have worked to integrate the feedback I recived on the last round of patches
> > > and welcome more ideas/advice. Thanks to everyone who has provied input on
> > > these patches already. 
> > > 
> > Just from review...
> > 
> > If new zone , which was empty at boot, are added into the system.
> > build_all_zonelists() has to be called. (see online_pages() in memory_hotplug.c)
> > it looks x86_64's __add_pages() doesn't calles it.
> 
> With RESERVE there are not empty zones.  All zones (including add-areas)
> are setup during boot and hot add areas reserved in the bootmem
> allocator. 
> 
> Zones don't change size there is no adding to the zone just on-lining on
> pages at are already present in the zone. 
>   
Hmm, curious.
please explain. 
==
int __add_pages(struct zone *z, unsigned long start_pfn, unsigned long nr_pages)
{
        int err = -EIO;
        unsigned long pfn;
        unsigned long total = 0, mem = 0;
        for (pfn = start_pfn; pfn < start_pfn + nr_pages; pfn++) {
                if (pfn_valid(pfn)) {
                        online_page(pfn_to_page(pfn));
                        err = 0;
                        mem++;
                }
                total++;
        }
        if (!err) {
                z->spanned_pages += total;
                z->present_pages += mem; -------------------------------(*)
                z->zone_pgdat->node_spanned_pages += total;
                z->zone_pgdat->node_present_pages += mem;
        }
        return err;
}
==
It looks contents of zone is increased at (*). Do I see old code ?

==
static inline int populated_zone(struct zone *zone)
{
        return (!!zone->present_pages);
}
==
"empty zone" I said means a zone which is not populated.

this populated_zone() is used at build_zone_list().
if populated_zone(z)==0, zone "z" is not included into zonelist and zone will be never
used.

-Kame

