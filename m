Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVAXQpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVAXQpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVAXQpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:45:32 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:58010 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261528AbVAXQpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:45:24 -0500
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
From: James Bottomley <jejb@steeleye.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Mel Gorman <mel@csn.ul.ie>, William Lee Irwin III <wli@holomorphy.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Grant Grundler <grundler@parisc-linux.org>
In-Reply-To: <20050124122952.GA5739@logos.cnet>
References: <20050120101300.26FA5E598@skynet.csn.ul.ie>
	 <20050121142854.GH19973@logos.cnet>
	 <Pine.LNX.4.58.0501222128380.18282@skynet>
	 <20050122215949.GD26391@logos.cnet>
	 <Pine.LNX.4.58.0501241141450.5286@skynet>
	 <20050124122952.GA5739@logos.cnet>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 10:44:12 -0600
Message-Id: <1106585052.5513.26.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 10:29 -0200, Marcelo Tosatti wrote:
> Since the pages which compose IO operations are most likely sparse (not physically contiguous),
> the driver+device has to perform scatter-gather IO on the pages. 
> 
> The idea is that if we can have larger memory blocks scatter-gather IO can use less SG list 
> elements (decreased CPU overhead, decreased device overhead, faster). 
> 
> Best scenario is where only one sg element is required (ie one huge physically contiguous block).
> 
> Old devices/unprepared drivers which are not able to perform SG/IO
> suffer with sequential small sized operations.
> 
> I'm far away from being a SCSI/ATA knowledgeable person, the storage people can 
> help with expertise here.
> 
> Grant Grundler and James Bottomley have been working on this area, they might want to 
> add some comments to this discussion.
> 
> It seems HP (Grant et all) has pursued using big pages on IA64 (64K) for this purpose.

Well, the basic advice would be not to worry too much about
fragmentation from the point of view of I/O devices.  They mostly all do
scatter gather (SG) onboard as an intelligent processing operation and
they're very good at it.

No one has ever really measured an effect we can say "This is due to the
card's SG engine".  So, the rule we tend to follow is that if SG element
reduction comes for free, we take it.  The issue that actually causes
problems isn't the reduction in processing overhead, it's that the
device's SG list is usually finite in size and so it's worth conserving
if we can; however it's mostly not worth conserving at the expense of
processor cycles.

The bottom line is that the I/O (block) subsystem is very efficient at
coalescing (both in block space and in physical memory space) and we've
got it to the point where it's about as efficient as it can be.  If
you're going to give us better physical contiguity properties, we'll
take them, but if you spend extra cycles doing it, the chances are
you'll slow down the I/O throughput path.

James


