Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSIPUIr>; Mon, 16 Sep 2002 16:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSIPUIr>; Mon, 16 Sep 2002 16:08:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52741 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262258AbSIPUIq>;
	Mon, 16 Sep 2002 16:08:46 -0400
Date: Mon, 16 Sep 2002 13:13:59 -0700
From: Dave Olien <dmo@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: Daniel Phillips <phillips@arcor.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020916131359.A17880@acpi.pdx.osdl.net>
References: <E17odbY-000BHv-00@f1.mail.ru> <20020910062030.GL8719@suse.de> <E17qQum-0001qO-00@starship> <20020915131920.GR935@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020915131920.GR935@suse.de>; from axboe@suse.de on Sun, Sep 15, 2002 at 03:19:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I can only note that so far there has been a lot of talk about dac960
> and updating it, and that's about it. Talk/code ratio is very very low,
> I'm tempted to just do the update myself. Might even safe some time.
> 
> -- 
> Jens Axboe
> 
> -

I have the DAC960 driver working in 2.5.34.  The work isn't
complete yet.  But, I'm able to boot, and do mke2fs
on partitions on logical drives, and then do e2fsck
on those partitions.  It seems to work, although more
testing is required.  Is there any interest in reviewing
the code so far, or should I continue testing and complete
the remaining issues first?

Here's what I've done:

1. I've removed all references to struct bio
   (or BufferHeader_T) from the code.  I'm using the
   blk_rq_map_sg() function to create scatter lists
   from I/O request structures.  Then, using pci_map_sg
   to produce DMA maps for those scatter/gather lists.

   I'm using "end_that_request_first" and
   "end_that_request_last" to do I/O request completions.


2. I've placed the DAC960's ScatterGatherList arrays into
   dma-mapped memory.  I'm currently using pci_pool_create()
   for esablishing these maps.  These are "consisent" maps.
   Should these be "streaming maps"?  For x86, it doesn't make
   any difference, but...

3. I've placed the DAC960 RequestSense structures into dma-mapped
   memory.  Again, I'm using pci_pool_create() to do this.

At the moment, I think I have some kind of problem writing
new partitions to a logical disk.  It seems if the system
comes up with all the logical disks already partitioned, then
I can work with them OK.  If I try to repartition a logical
disk with the new driver, the logical drive seems to be
unpartitioned afterwards.  I haven't completely understood this
problem yet.  This is what I'm working on now.

Before going on with the next steps, I'll probably do more
vigorous testing.


Work to do:

I've temporarliy put back the virt_to_bus and bus_to_virt
calls.  The remaining steps will get rid of those.

1. Establish dma maps for the DAC960 command mailbox.
   I'll establish consistent maps for them.

   The existing code here is a little odd.  
   The function DAC960_V1_EnableMemoryMailboxInterface()
   should call any of the RestoreMemoryMailboxInfo()
   functions.  It seems to be trying to retrieve
   from the controller old pointers to memory
   mailboxes.  But I can't imagine cirumstances
   where this would work in the context of the current
   driver.
   

2. Establish dma maps for the sizeable collection of
   status and monitoring operations.

3. I have an issue with the read/write retry commands.
   I think I know how to do it, but just need to code
   it and test it.  Since I don't have any
   disks with media errors, I'll probably  use some kind
   of fault insertion to test this.

4. I need to add calls to pci_dma_sync*() in the approriate
   places.  This function doesn't do anything on the current
   x86 platform.  So, I'll put these in place after getting
   things to work.

