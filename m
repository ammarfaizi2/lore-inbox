Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290811AbSARUeH>; Fri, 18 Jan 2002 15:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290812AbSARUd5>; Fri, 18 Jan 2002 15:33:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52117 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290811AbSARUds>;
	Fri, 18 Jan 2002 15:33:48 -0500
Date: Fri, 18 Jan 2002 12:32:21 -0800 (PST)
Message-Id: <20020118.123221.85715153.davem@redhat.com>
To: dan@embeddededge.com
Cc: hozer@drgw.net, linux-kernel@vger.kernel.org, groudier@free.fr,
        mattl@mvista.com
Subject: Re: pci_alloc_consistent from interrupt == BAD
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C4875DB.9080402@embeddededge.com>
In-Reply-To: <20020118130209.J14725@altus.drgw.net>
	<3C4875DB.9080402@embeddededge.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dan Malek <dan@embeddededge.com>
   Date: Fri, 18 Jan 2002 14:22:03 -0500
   
   > Somehow the docs in DMA-mappings.txt say pci_alloc_consistent is allowed from 
   > interrupt, but this is a "bad thing" on at least arm and PPC non-cache 
   > coherent cpus.
   
   This isn't unique to PowerPC or ARM, and has nothing to do with allocating
   page tables.
   
Yes it is in fact unique to those ports...

   I don't understand how pci_alloc_consistent could ever be claimed to work
   from an interrupt function because it actually allocates pages of memory
   for all architectures.  Anytime you call alloc_pages() (or friends) you could
   potentially block or return an error (out of memory) condition.
   
If it specifies GFP_ATOMIC, there are no problems from interrupts.
You will see that every port other than the mentioned two above use
GFP_ATOMIC in their pci_alloc_consistent implementation, for this very
reason.

The ARM and PPC ports could set __GFP_HIGH in their page table
allocation calls when invoked via pci_alloc_consistent, and this is
the change I suggest they make.  It is a trivial fix whereas backing
out this ability to call pci_alloc_consistent from interrupts is not
a trivial change at all.
