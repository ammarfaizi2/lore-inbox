Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTAaUwr>; Fri, 31 Jan 2003 15:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTAaUwr>; Fri, 31 Jan 2003 15:52:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:14567 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262380AbTAaUwq>;
	Fri, 31 Jan 2003 15:52:46 -0500
Date: Fri, 31 Jan 2003 13:04:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc/module_alloc: unable to handle two memory regions
Message-Id: <20030131130432.6631ff1e.akpm@digeo.com>
In-Reply-To: <20030131105518.B19646@flint.arm.linux.org.uk>
References: <20030131102013.A19646@flint.arm.linux.org.uk>
	<20030131024820.4c1290ca.akpm@digeo.com>
	<20030131105518.B19646@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2003 21:02:06.0618 (UTC) FILETIME=[0324A7A0:01C2C96C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:
>
> On Fri, Jan 31, 2003 at 02:48:20AM -0800, Andrew Morton wrote:
> > Boggle.
> > 
> > Isn't this totally abusing get_vma_area?
> > 
> > What stops an ioremap region from landing in module space?
> 
> Exactly the problem.
> 
> What's more is that fs/proc/kcore.c:get_kcore_size() also breaks, so
> this isn't an acceptable solution.  get_kcore_size wants the module
> region to be above PAGE_OFFSET.
> 
> In order to place the module in the normal vmalloc space, we end up with
> a chicken and egg problem - we need to scan the module from kernel space
> to find out how large to make the jump table, but we can't because the
> module hasn't been loaded into kernel memory - this is the reason why it
> was suggested to go down this route.
> 

Well, could you not do something like:

 +----------------------------+ 4GB
   devices
 +----------------------------+ VMALLOC_END = 0xc2000000
   vmalloc/ioremap
 +----------------------------+ 0xc1000000 + sizeof(linux)
   kernel direct-mapped ram
 +----------------------------+ 0xc1000000
   module
 +----------------------------+ TASK_SIZE = MODULE_START = PAGE_OFFSET =
                                VMALLOC_START = 0xc0000000
   user space
 +----------------------------+

And then arrange for a (start=0xc1000000,len=sizeof(linux)) entry which
describes the kernel itself to be added to the vmlist before anything else?


