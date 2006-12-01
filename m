Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936501AbWLAPfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936501AbWLAPfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936464AbWLAPfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:35:48 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:64690 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S936501AbWLAPfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:35:47 -0500
Date: Fri, 1 Dec 2006 10:36:59 -0500
From: Chris Mason <chris.mason@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Zach Brown'" <zach.brown@oracle.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] optimize o_direct on block device
Message-ID: <20061201153659.GL7888@think.oraclecorp.com>
References: <48655D0C-F150-4EF1-B946-94B959580A65@oracle.com> <000001c71510$4bec8400$8f8c030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c71510$4bec8400$8f8c030a@amr.corp.intel.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 10:16:53PM -0800, Chen, Kenneth W wrote:
> Zach Brown wrote on Thursday, November 30, 2006 1:45 PM
> > > At that time, a patch was written for raw device to demonstrate that
> > > large performance head room is achievable (at ~20% speedup for micro-
> > > benchmark and ~2% for db transaction processing benchmark) with a  
> > > tight I/O submission processing loop.
> > 
> > Where exactly does the benefit come from?  icache misses?  "atomic"  
> > ops leading to pipeline flushes?
> 
> It benefit from shorter path length. It takes much shorter time to process
> one I/O request, both in the submit and completion path.  I always think in
> terms of how many instructions, or clock ticks does it take to convert user
> request into bio, submit it and in the return path, to process the bio call
> back function and do the appropriate io completion (sync or async).  The
> stock 2.6.19 kernel takes about 5.17 micro-seconds to process one 4K aligned
> DIO (just the submit and completion path, less disk I/O latency).  With the
> patch, the time is reduced to 4.26 us.

I'm not completely against a minimal DIO implementation for the block
device, but right now we get block device QA for free when we test the
rest of the DIO code.  Splitting the code base makes DIO (already a
special case) that much harder to test.

It's obvious there's a lot less code in your patch than fs/direct-io.c,
but I'm still interested in which part of the fs/direct-io.c path is
taking the most time.  I would guess it is allocating the dio?

I don't think we should cut out fs/direct-io.c until we understand
exactly where the hit is coming from.  I know you've done lots of
instrumentation already, but can you share some percentages on the hot
paths?

-chris
