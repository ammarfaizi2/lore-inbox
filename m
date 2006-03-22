Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWCVBig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWCVBig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 20:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWCVBif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 20:38:35 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:26849 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751937AbWCVBie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 20:38:34 -0500
Date: Wed, 22 Mar 2006 10:38:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: y-goto@jp.fujitsu.com, akpm@osdl.org, tony.luck@intel.com, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH: 002/017]Memory hotplug for new nodes v.4.(change name
 old add_memory() to arch_add_memory())
Message-Id: <20060322103839.3b3d2a66.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1142989698.10906.224.camel@localhost.localdomain>
References: <20060317162757.C63B.Y-GOTO@jp.fujitsu.com>
	<1142615538.10906.67.camel@localhost.localdomain>
	<20060318102653.57c6a2af.kamezawa.hiroyu@jp.fujitsu.com>
	<1142964013.10906.158.camel@localhost.localdomain>
	<20060322090514.6d6826fc.kamezawa.hiroyu@jp.fujitsu.com>
	<1142989698.10906.224.camel@localhost.localdomain>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006 17:08:18 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:
> If I missed it before, please refresh my memory.  But, if we're
> providing arch_nid_probe(addr), then why don't we just call it inside of
> add_memory() on the start address, instead of in the generic code?
> 
I think just *probe* needs it. The firmware which supports memory-hotplug, ACPI, 
i386/x86_64/ia64, can tell node number as pxm.(proximity domain)

add_memory() can pass address of paddr as args, but can't pass *pxm*. 

We already maintain pxm <-> nid map. But paddr <-> nid map isn't now.
If add_memory() doesn't has nid as args, we have to maintain
(1) pxm <-> nid map.
(2) paddr <-> nid map.
Becasue pfn_to_nid() is maintained by SPARSEMEM itself now, *new* paddr<->nid map
is redundant, I think. And I think the firmware already has the map before calling
add_memory(). 

> I'm also getting a bit confused in your patches whether add_memory() is
> the _original_ add_memory(), or the new one.  It tends to get lost in 17
> patches. :(
> 
maybe a big patch :(, We (I and Goto-san) are discussing to split them to
a bit small chunks. 

> I don't really like the arch_nid_probe() name.  We need to make it very
> apparent that it is to be used _only_ for memory hotplug operations.  It
> has no meaning for anything else.
> 
> 	hotplug_physaddr_to_nid()?
> 
> Maybe with a "memory_" in front.  Maybe even
> memory_add_physaddr_to_nid()?
> 
Okay, we'll rename it.

> It was probably to keep from changing as little code as possible, but
> please convert the u64 values to pfns as soon as possible.  I noticed
> that hotadd_new_pgdat() still deals with them, and does the shift as
> well.  Is that really necessary.
> 
> The u64s should not be kept for more than one level of calls.  That
> level of calls should be the firmware.  So, let the firmware call into
> the VM code with u64s, then have all of the plain VM code deal in pfns.
> 
Okay.

-- Kame

