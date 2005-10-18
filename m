Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVJRV2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVJRV2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVJRV2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:28:47 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:47817 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932135AbVJRV2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:28:46 -0400
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
From: Alex Williamson <alex.williamson@hp.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org,
       y-goto@jp.fujitsu.com
In-Reply-To: <20051018195423.GA6351@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain>
	 <200510171153.56063.ak@suse.de>
	 <20051017153020.GB7652@localhost.localdomain>
	 <200510171743.47926.ak@suse.de> <20051017134401.3b0d861d.akpm@osdl.org>
	 <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org>
	 <20051018001620.GD8932@localhost.localdomain>
	 <Pine.LNX.4.64.0510180845470.3369@g5.osdl.org>
	 <Pine.LNX.4.64.0510180848540.3369@g5.osdl.org>
	 <20051018195423.GA6351@localhost.localdomain>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 18 Oct 2005 15:28:27 -0600
Message-Id: <1129670907.17545.20.camel@lts1.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 12:54 -0700, Ravikiran G Thirumalai wrote:
> On Tue, Oct 18, 2005 at 08:50:18AM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Tue, 18 Oct 2005, Linus Torvalds wrote:
> > > 
> > > I vote for this one, assuming everybody who can test is happy.
> > 
> > Of course, just after sending the patch I noticed that there was a new 
> > version, even simpler. Can people test that one?
> > 
> 
> This version should work for everyone.  It falls back to the old 2.6.13
> behaviour when it does not find suitable memory from any of the nodes.
> 
> Yasunori-san, Alex, can you confirm.  (Please use stock 2.6.14)

   Oops, I used 2.6.14-rc4-mm1, I'll retest.  However, this does work on
the Superdome.  Not because of the iterating over the nodes code, but
because of the call to alloc_bootmem_low_pages() fallback case.  Adding
a printk(), I get this:

Node 0: 0xe000074104e6b200
Node 1: 0xe000082080723000
Node 2: 0xe000000101532000  *Note this is the interleaved memory node
Placing software IO TLB between 0x4cdc000 - 0x8cdc000

Looking at the memory map of the system, I see these major ranges:

Node 2:
0x00000000000 - 0x0007ffdefff (~2GB)
0x00100000000 - 0x0017fffffff (2GB)
0x04080000000 - 0x040f0000000 (2GB)
Node 0:
0x74100000000 - 0x741fbbfffff (~4GB)
Node 1:
0x82080000000 - 0x820fb453fff (~2GB)

So, it looks like we're iterating over the nodes, but
alloc_bootmem_node() isn't even guaranteed to try to get memory from the
low memory on that node.  Thanks,

	Alex



