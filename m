Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbVKCBiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVKCBiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVKCBhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:37:38 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3468 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030259AbVKCBhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:37:36 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Wed, 2 Nov 2005 17:28:35 -0600
User-Agent: KMail/1.8
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>, Dave Hansen <haveblue@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <1130917338.14475.133.camel@localhost> <20051102172729.9E7C.Y-GOTO@jp.fujitsu.com> <43687C3D.7060706@yahoo.com.au>
In-Reply-To: <43687C3D.7060706@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511021728.36745.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 02:43, Nick Piggin wrote:

> > Hmmm. I don't see at this point.
> > Why do you think ZONE_REMOVABLE can satisfy for hugepage.
> > At leaset, my ZONE_REMOVABLE patch doesn't any concern about
> > fragmentation.
>
> Well I think it can satisfy hugepage allocations simply because
> we can be reasonably sure of being able to free contiguous regions.
> Of course it will be memory no longer easily reclaimable, same as
> the case for the frag patches. Nor would be name ZONE_REMOVABLE any
> longer be the most appropriate!
>
> But my point is, the basic mechanism is there and is workable.
> Hugepages and memory unplug are the two main reasons for IBM to be
> pushing this AFAIKS.

Who cares what IBM is pushing?  I'm interested in fragmentation avoidance for 
User Mode Linux.

I use User Mode Linux to virtualize a system build, and one problem I 
currently have is that some workloads temporarily use a lot of memory.  For 
example, I can run a complete system build in about 48 megs of ram: except 
for building GCC.  That spikes to a couple hundred megabytes.  If I allocate 
256 megabytes of memory to UML, that's half the memory on my laptop and UML 
will just use it for redundant cacheing and such while desktop performance 
gets a bit unhappy with the build going.

UML gets an instance's "physical memory" by allocating a temporary file, 
mmapping it, and deleting it (which signals to the vfs that flushing this 
data to backing store should only be done under memory pressure from the rest 
of the OS, because the file's going away when it's closed so there's no 

With fragmentation reduction and prezeroing, UML suddenly gains the option of 
calling madvise(DONT_NEED) on sufficiently large blocks as A) a fast way of 
prezeroing, B) a way of giving memory back to the host OS when it's not in 
use.

This has _nothing_ to do with IBM.  Or large systems.  This is some random 
developer trying to run a virtualized system build on his laptop.

(The reason I need to use UML is that I build uClibc with the newest 2.6 
kernel headers I can, link apps against it, and then running many of those 
apps during later stages of the build.  If the kernel headers used to build 
libc are sufficiently newer than the kernel the build is running under, I get 
segfaults because the new libc tries use kernel features that aren't there on 
the host system, but will be in the final system.  I also get the ability to 
mknod/chown/chroot without needing root access on the host system for 
free...)

Rob
