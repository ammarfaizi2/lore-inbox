Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbTDGVOx (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbTDGVOx (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:14:53 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:38520 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S263673AbTDGVOw (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:14:52 -0400
Date: Mon, 7 Apr 2003 23:25:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Rik van Riel <riel@surriel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Bill Irwin <wli@holomorphy.com>
Subject: Re: subobj-rmap
Message-ID: <20030407212543.GM5750@dualathlon.random>
References: <Pine.LNX.4.44.0304061737510.2296-100000@chimarrao.boston.redhat.com> <1600000.1049666582@[10.10.2.4]> <20030406221547.GP1326@dualathlon.random> <2640000.1049667906@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2640000.1049667906@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 03:25:08PM -0700, Martin J. Bligh wrote:
> >> We can always leave the sys_remap_file_pages stuff using pte_chains,
> > 
> > not sure why you want still to have the vm to know about the
> > mmap(VM_NONLINEAR) hack at all.
> > 
> > that's a vm bypass. I can bet the people who wants to use it for running
> > faster on the the 32bit archs will definitely prefer zero overhead and
> > full hardware speed with only the pagetable and tlb flushing trash, and
> > zero additional kernel internal overhead. that's just a vm bypass that
> > could otherwise sit in kernel module, not a real kernel API.
> 
> Well, you don't get zero overhead whatever you do. You either pay the
> cost at remap time of manipulating sub-objects, or the cost at page-touch
> time of the pte_chains stuff. I suspect sub-objects are cheaper if we
> read /write the 32K chunks, not if people mostly just touch one page
> per remap though.
> 
> What do you think about using this for the linear stuff though?

I think at this only for the linear stuff. it would solve Andrew's
exploit against objrmap, for each page we would walk only the vmas
matching the pagetables mapping to the page. However those sub-objects
have a cost, the cost will be 8bytes per fragment. the slowest part
should be the split of the subobject when a new mapping happens and the
possible flood of list_add/list_del. I'm unsure it worth.

However it would be nice to se how the current 2.4 pte walking clock
algorithm does compared to objrmap and rmap when ext2 is used because
ext3 generated an I/O bound behaviour at least for my tree, that made
any vm-side comparison invalid.

Andrea
