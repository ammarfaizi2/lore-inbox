Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTEWXqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 19:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbTEWXqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 19:46:34 -0400
Received: from fmr02.intel.com ([192.55.52.25]:24803 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264203AbTEWXqd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 19:46:33 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: /proc/kcore - how to fix it
Date: Fri, 23 May 2003 16:43:36 -0700
Message-ID: <DD755978BA8283409FB0087C39132BD101B00E09@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/kcore - how to fix it
Thread-Index: AcMhbqx3YGnND0rTTsqOqpHyCMi9iQAFCzGQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@linuxia64.org>, <ak@suse.de>,
       "David Mosberger" <davidm@napali.hpl.hp.com>,
       "Andrew Morton" <akpm@digeo.com>
X-OriginalArrivalTime: 23 May 2003 23:43:38.0450 (UTC) FILETIME=[2230DB20:01C32185]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect the easiest thing may be to arrange for the discontig direct
> mapped memory blocks to appear on the vmlist and then remove 
> the special
> case for the direct mapped RAM.  I don't see why architecture support
> needs to come into the picture really.

I did experiment with adding the architectural weird stuff to the vmlist.
But I wasn't entirely happy with it.  There were two choices:

1) Add any random thing to vmlist and fixup /proc/kcore code to check
   for other stuff outside the VMALLOC_START,VMALLOC_END range (as you
   suggested last year, an implemented in the patch you showed today).

This feels like it is abusing the vmlist.  Only one piece of code would
actually break (get_vmalloc_info() in fs/proc/proc_misc.c, and it could
easily be fixed).  But it just feels kludgy.

2) Force the random things to be allocated in the VMALLOC_START,VMALLOC_END
   address range.

I tried this, and David complained about esoteric features like kcore
dictating important stuff like kernel layout decisions.  Probably isn't
even an option for most architecture.

> I don't believe any races here are that important (except of course
> ensuring that we produce consistent data for a particular read() and
> not oopsing the kernel) - take a moment to think where the information
> /proc/kcore provides ends up and realise that as soon as it hits
> userspace, you can't rely on it.  eg, Today, if you're using it and
> you insert a module, the structure of the file changes, and gdb's
> idea of offsets of data into the "core" becomes invalid.

Actually inserting/deleting modules won't change the offsets
of other objects inside /proc/kcore (unless you add enough modules
to bump the elf_buflen size of the header to consume an extra page).
The offsets in /proc/kcore are all based on the virtual address
of the object ... not on the number/size of any preceeding objects,
so the /proc/kcore file is full of holes in the spots where things
are not currently mapped.
If gdb went back and re-read the elf headers it might be surprised
to find the elf_phdrs were appearing and disappearing ... but offsets
into the rest of the file won't (generally) change.

-Tony
