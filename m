Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWBFSzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWBFSzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWBFSzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:55:38 -0500
Received: from ns1.suse.de ([195.135.220.2]:5317 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932158AbWBFSzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:55:37 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Mon, 6 Feb 2006 19:55:18 +0100
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, bharata@in.ibm.com, linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com> <200602061931.13953.ak@suse.de> <Pine.LNX.4.62.0602061043440.16829@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602061043440.16829@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061955.19702.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 19:45, Christoph Lameter wrote:
> On Mon, 6 Feb 2006, Andi Kleen wrote:
> 
> > > If node 0 is exhausted then you have an OOM situation.
> > 
> > No - it could just need to free some cleanable pages first. That's
> > a long way before going OOM.
> 
> Then node 0 still has memory available. So you suspect zone_reclaim?

Either zone reclaim or the first entry in the zonelist is ok, but it's 
not correctly terminated or something like that so it causes 
problems when the kernel looks for the second (just speculating here,
i don't know if that is the problem) 
   
> > > > but with a full free local node that code path is never triggered)
> > > 
> > > Wamt me to test the OOM path for mbind?
> > I already know it oopses - someone else reported that. If you feel
> > motivated feel free to fix.
> 
> We also have a minor issue with huge pages. If the pools are exhausted 
> then the kernel will terminate the application with Bus Error.

That is what prereservation was supposed to prevent. I remember there 
were endless discussions when this all was originally implemented long
ago (in the version that never got merged).

Basically there were two approaches:
- Do strict overcommit checking at mmap with prereservation (that was
what the old Intel/SGI patch did)

- The hackish way I implemented in SLES9: just check at mmap time 
if there are enough pages but don't prereserve anything. That was 
more a 80% solution with races, but seemed to fix the problem well enough 
that people in the field didn't really complain. The advantage was that 
it was much simpler code.

-Andi

