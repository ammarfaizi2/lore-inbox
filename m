Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290845AbSARVoM>; Fri, 18 Jan 2002 16:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290846AbSARVn4>; Fri, 18 Jan 2002 16:43:56 -0500
Received: from host155.209-113-146.oem.net ([209.113.146.155]:36598 "EHLO
	tibook.netx4.com") by vger.kernel.org with ESMTP id <S290845AbSARVng>;
	Fri, 18 Jan 2002 16:43:36 -0500
Message-ID: <3C4896E5.400@embeddededge.com>
Date: Fri, 18 Jan 2002 16:43:01 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.11-pre6-ben0 ppc; en-US; 0.8) Gecko/20010419
X-Accept-Language: en
MIME-Version: 1.0
CC: hozer@drgw.net, linux-kernel@vger.kernel.org, groudier@free.fr
Subject: Re: pci_alloc_consistent from interrupt == BAD
In-Reply-To: <20020118130209.J14725@altus.drgw.net>	<3C4875DB.9080402@embeddededge.com> <20020118.123221.85715153.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:


> If it specifies GFP_ATOMIC, there are no problems from interrupts.
> You will see that every port other than the mentioned two above use
> GFP_ATOMIC in their pci_alloc_consistent implementation, for this very
> reason.

The PowerPC does use (or is supposed to use) GFP_ATOMIC.  I don't
know why ARM doesn't.

I guess I'm just trying to understand the value of calling it from interrupt.
If the purpose is to allocate a page of memory, and that doesn't happen,
all you have done is pushed added complexity to a device driver.  If
an interrupt handler (and the remainder of the driver) must handle the
condition of wanting a page but not getting one in the interrupt handler,
why bother trying to do it at all?

> The ARM and PPC ports could set __GFP_HIGH in their page table
> allocation calls when invoked via pci_alloc_consistent,

How does this solve anything?  All it does is make more memory potentially
available.  If memory isn't available, the call is still going to fail.

> ......  It is a trivial fix whereas backing
> out this ability to call pci_alloc_consistent from interrupts is not
> a trivial change at all.

You can call pci_alloc_consistent from anywhere on any architecture,
but anyone calling it and not handling an error condition is a broken
implementation.

I have to apologize to hozer, because the allocation of page tables would
be a condition where pci_alloc_consistent could return an error.  However,
he must be looking into the future because that is the way it will be
later today when I'm done changing the functions, not the current implementation.

Thanks.


	-- Dan


