Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSFXMp0>; Mon, 24 Jun 2002 08:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSFXMpZ>; Mon, 24 Jun 2002 08:45:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10717 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313113AbSFXMpY>;
	Mon, 24 Jun 2002 08:45:24 -0400
Date: Mon, 24 Jun 2002 05:39:15 -0700 (PDT)
Message-Id: <20020624.053915.132743979.davem@redhat.com>
To: adam@yggdrasil.com
Cc: akpm@zip.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: RFC: turn scatterlist into a linked list, eliminate bio_vec
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206241142.EAA04136@adam.yggdrasil.com>
References: <200206241142.EAA04136@adam.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Mon, 24 Jun 2002 04:42:45 -0700

   	Sorry if I was not clear enough about the purpose of of
   the new scatterlist->driver_priv field.  It is a "streaming" data
   structure to use the terminology of DMA-maping.txt (i.e., one that
   would typically only be allocated for a few microseconds as an IO is
   built up and sent).  Its purpose is to hold the hardware-specific
   gather-scatter segment descriptor, which typically look something like this:
   
   		struct foo_corporation_scsi_controller_sg_element {
   			u64	data_addr;
   			u64	next_addr;
   			u16	data_len;
   			u16	reserved;
   			u32	various_flags;
   		}
   		
This is small, about one cacheline, and thus is not to be used
with non-consistent memory.  Also, if you use streaming memory, where
is the structure written to and where is the pci_dma_sync_single
(which is a costly cache flush on many systems btw, another reason to
use consistent memory) between the CPU writes and giving the
descriptor to the device?

Again, reread DMA-mapping.txt a few more times before composing
your response to me.  I really meant that you don't understand
the purpose of consistent vs. streaming memory.

   	Come to think of it, my use of pci_map_single is incorrect
   after all, because the driver has not yet filled in that data structure
   at that point.  Since the data structures are being allocated from a
   single contiguous block that spans a couple of pages that is being used
   only for this purpose, perhaps I would be fastest to pci_alloc_consistent
   the whole memory pool for those little descriptors at initialization time
   and then change that loop to do the following.
   
Please use PCI pools, this is what they were designed for.  Pools of
like-sized objects allocated out of consistent DMA memory.

So as it stands I still think your proposal is buggy.
