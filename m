Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWHDAUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWHDAUS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHDAUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:20:18 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41354 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932468AbWHDAUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:20:15 -0400
Date: Fri, 4 Aug 2006 09:22:15 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: kmannth@us.ibm.com
Cc: akpm@osdl.org, y-goto@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH] memory hotadd fixes [4/5] avoid check in
 acpi
Message-Id: <20060804092215.7cfc478d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1154646577.5925.30.camel@keithlap>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	<1154629724.5925.20.camel@keithlap>
	<1154646577.5925.30.camel@keithlap>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Keith

Thank you for test.

On Thu, 03 Aug 2006 16:09:36 -0700
keith mannthey <kmannth@us.ibm.com> wrote:
> > >  drivers/acpi/acpi_memhotplug.c |    9 +--------
> > >  1 files changed, 1 insertion(+), 8 deletions(-)
> > > 
> > > Index: linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c
> > > ===================================================================
> > > --- linux-2.6.18-rc3.orig/drivers/acpi/acpi_memhotplug.c	2006-08-01 16:11:47.000000000 +0900
> > > +++ linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c	2006-08-02 14:12:45.000000000 +0900
> > > @@ -230,17 +230,10 @@
> > >  	 * (i.e. memory-hot-remove function)
> > >  	 */
> > >  	list_for_each_entry(info, &mem_device->res_list, list) {
> > > -		u64 start_pfn, end_pfn;
> > > -
> > > -		start_pfn = info->start_addr >> PAGE_SHIFT;
> > > -		end_pfn = (info->start_addr + info->length - 1) >> PAGE_SHIFT;
> > > -
> > > -		if (pfn_valid(start_pfn) || pfn_valid(end_pfn)) {
> > > -			/* already enabled. try next area */
> > > +		if (info->enabled) { /* just sanity check...*/
> > >  			num_enabled++;
> > >  			continue;
> > >  		}
> > 
> > This check needs to go.  pfn_valid is a sparsemem specific check. Sanity
> > checking should be done it the the add_memory code. 
> > 
> > I will test and let you know. This is going to expose some baddness I
> > see already with my RESERVE path work. (Extra add_memory calls from this
> > driver during boot....)
> 
> Ok.  This pfn_valid check needs to be inserted somewhere in the code
> path for sparsemem hotadd.
> 
> with a debug statement in add_memory
> 
> Hotplug Mem Device
> add_memory 0 400000000 70000000
> System RAM resource 400000000 - 46fffffff cannot be added

This messages is at ioresouce collision check. This says system has 
memory resource between 400000000 - 46fffffff...before hotadd.

and sparse_add_one_seciton() returns -EEXIST if section exists.
==
int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
                           int nr_pages)
{
<snip>
	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
                ret = -EEXIST;
                goto out;
        }
}
==
Ah... but x86_64 special (not depends on sparsemem..) __add_pages() call doesn't
do sanity check at  online_page(). 
Here.
==
        for (pfn = start_pfn; pfn < start_pfn + nr_pages; pfn++) {
                if (pfn_valid(pfn)) {
                        online_page(pfn_to_page(pfn));
                        err = 0;
                        mem++;
                }
==
So, panics ...maybe. 
(System has memory between 40000000 - 46fffffff but it's onlined again)
Could you add sanity check in online_page() ?
==
if (PageReserved(page) {
	online_page(pfn_to_page(pfn));
}
==
will be enough.

I don't have avaliable x86_64 box now.

-Kame

