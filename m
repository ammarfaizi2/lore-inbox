Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUEFRIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUEFRIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUEFRIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:08:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:11698 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261474AbUEFRIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:08:21 -0400
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
From: Dave Hansen <haveblue@us.ibm.com>
To: Sourav Sen <souravs@india.hp.com>
Cc: "HELGAAS,BJORN (HP-Ft. Collins)" <bjorn_helgaas@am.exch.hp.com>,
       "'Matt Domsch'" <Matt_Domsch@dell.com>,
       Matthew E Tolentino <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tony.luck@intel.com
In-Reply-To: <004f01c43386$c3301900$39624c0f@india.hp.com>
References: <004f01c43386$c3301900$39624c0f@india.hp.com>
Content-Type: text/plain
Message-Id: <1083862182.2811.266.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 May 2004 09:49:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-06 at 09:25, Sourav Sen wrote:
> From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
> + For this application, the EFI memory map isn't what you want.
> + It's a pretty good approximation today, but the day when we'll
> + be able to hot-add memory is fast approaching, and the EFI map
> + won't mention anything added after boot.  We'll discover all
> + that via ACPI (on ia64).
>
> 	Why not also update the efi memory table on a hotplug :-)

That's actually what ppc64 does.  But, they do it via /proc (not even
from inside the kernel).  I'm not very fond of that solution :)

> (Now also it gets modified a little on a call to efi_memmap_walk()).
> Otherwise clients of efi_memmap_walk() will also get stale 
> information after a hotplug, isn't it (assuming they want to
> know about available physical ranges)?

We'll probably end up having to lock down hotplug around the time that
someone *needs* persistent information about memory layout from
userspace.  Think crashdump...

> Also, kernel may not exactly use all the memory added via hotplug

That's a good point.  Some of the happy consumers of this should be
things like crashdump and kexec.  They might want a choice to either
dump only the memory that Linux is currently using, or to know about all
of the memory that is present.  

>  and there may be some truncation (just as efi_memmap_walk()
> does today). And it isn't help us if we get to know about those
> extents. Additionally we get to know about various mmio ranges and
> other ranges thru that table -- may be useful opportunistically.

There can be some pretty generic (although asynchronous) events given
via /sbin/hotplug.  I'm currently planning on having the memory hotplug
"drivers" get the hot-added memory ready, but keep it offline.  It then
creates some kobjects, which generate hotplug events, and *then* the
decision can be made in the hotplug scripts about what to do with it.

-- Dave

