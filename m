Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266730AbUITPjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266730AbUITPjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUITPjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:39:55 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:22681 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266730AbUITPjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:39:52 -0400
Date: Mon, 20 Sep 2004 17:39:46 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Hugh Dickins <hugh@veritas.com>, Stefan Hornburg <kernel@linuxia.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at mm/prio_tree.c:538
Message-ID: <20040920153946.GD3858@dualathlon.random>
References: <Pine.LNX.4.44.0409201343170.16315-100000@localhost.localdomain> <Pine.GSO.4.58.0409201053290.13166@lazuli.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0409201053290.13166@lazuli.engin.umich.edu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 11:14:53AM -0400, Rajesh Venkatasubramanian wrote:
> The only chance I see for this to happen: we are changing vm_start,
> vm_end, vm_pgoff of a vma that is already in an i_mmap tree
> without holding the corresponding i_mmap_lock. The last time I
> did an audit, all such changes were inside the i_mmap_lock.

they should yes. Only the anon_vma_lock can be dropped before vm_end
modifications (but only for vm_end, vm_start and vm_pgoff updates still
needs the anon_vma_lock hold to be coherent with vm_pgoff reads).

operations on memory-seeking data structures like lists and trees tends
to be the most likely to show bad ram, we had it for some time in the
dcache layer for the dcache shrinking (still todate AFIK they were all
hardware issues), this could be a similar case.

though I agree the same BUG_ON triggering worth a second check.

Thanks a lot!
