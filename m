Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUKWWau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUKWWau (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUKWW2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:28:10 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:19942 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261589AbUKWW1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:27:35 -0500
Date: Tue, 23 Nov 2004 23:27:34 +0100
From: Andi Kleen <ak@suse.de>
To: "Jeff V. Merkey" <jmerkey@devicelogics.com>
Cc: Andi Kleen <ak@suse.de>, ltd@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning   and sickness
Message-ID: <20041123222734.GK20608@wotan.suse.de>
References: <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel> <419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel> <419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel> <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel> <5.1.0.14.2.20041123094109.04003720@171.71.163.14.suse.lists.linux.kernel> <41A2862A.2000602@devicelogics.com.suse.lists.linux.kernel> <p73k6sc1epi.fsf@bragg.suse.de> <41A3B23C.2080406@devicelogics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A3B23C.2080406@devicelogics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 02:57:16PM -0700, Jeff V. Merkey wrote:
> Implementation of this with skb's would not be trivial. M$ in their 
> network drivers did this sort of circular list of pages
> structure per adapter for receives and use it "pinned" to some of their 
> proprietary drivers in W2K and would use their
> version of an skb as a "pointer" of sorts that could dynamically assign 
> a filled page from this list as a "receive" then perform
> the user space copy from the page and release it back to the adapter. 
> This allowed them to fill the ring buffers with static
> addresses and copy into user space as fast as they could allocate 
> control blocks.

The point is to eliminate the writes for the address and buffer
fields in the ring descriptor right? I don't really see the point
because you have to twiggle at least the owner bit, so you
always have a cacheline sized transaction on the bus.
And that would likely include the ring descriptor anyways, just
implicitely in the read-modify-write cycle.

If you're worried about the latencies of the separate writes
you could always use write combining to combine the writes.

If you write the full cache line you could possibly even
avoid the read in this cae.

On x86-64 it can be enabled for writel/writeq with CONFIG_UNORDERED_IO.
You just have to be careful to add all the required memory
barriers, but the driver should have that already if it works
on IA64/sparc64/alpha/ppc64. 

It's an experimental option not enabled by default on x86-64 because
the performance implications haven't been really investigated well.
You could probably do it on i386 too by setting the right MSR
or adding a ioremap_wc() 

-Andi
