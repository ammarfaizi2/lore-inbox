Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUFXXRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUFXXRp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbUFXXR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:17:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13972
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265812AbUFXXPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:15:18 -0400
Date: Fri, 25 Jun 2004 01:15:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de,
       ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624231523.GC30687@dualathlon.random>
References: <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624222150.GZ30687@dualathlon.random> <20040624153612.038ebd39.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624153612.038ebd39.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 03:36:12PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Thu, Jun 24, 2004 at 02:54:41PM -0700, Andrew Morton wrote:
> > > First thing to do is to identify some workload which needs the patch. 
> > 
> > that's quite trivial, boot a 2G box, malloc(1G), bzero(1GB), swapoff -a,
> > then the machine will lockup.
> 
> Are those numbers correct?  We won't touch swap at all with that test?

they are correct if the page allocator allocates memory starting from
address 0 physical up to 2G in contigous order (sometime it allocates
memory backwards instead, in such case you need to load say 900M in
pagecache and then malloc 1.2G, worked fine for me in 2.4 before I fixed
it at least).

the malloc(1G) will pin the whole lowmem, then the box will be dead. oom
killer won't kill the task, but the syscalls will all hang (they don't
even return -ENOMEM because you loop forever, 2.4 at least was returning
-ENOMEM).  workaround is to add swap and to slowdown like a crawl
relocating ram at disk-seeking-speed and overshrinking vfs caches, but
nobody will notice something is going wrong then. Only swapoff -a will
show that something is not going well.
