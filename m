Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVLMPyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVLMPyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVLMPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:54:10 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:25254 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932315AbVLMPyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:54:08 -0500
Date: Tue, 13 Dec 2005 07:53:45 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051213075345.c39f335d.pj@sgi.com>
In-Reply-To: <20051212021247.388385da.akpm@osdl.org>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
	<20051212020211.1394bc17.pj@sgi.com>
	<20051212021247.388385da.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Please do use __read_mostly for new kmem_cache :

Paul Jackson wrote:
> Is there any downside to this?

Andrew Morton wrote:
> There's no downside, really.


Hmmm ... I suspect one possible downside.

I would think we would want to spread the hot spots out, to reduce the
chance of getting two hot spots in the same cache line, and starting a
bidding war for that line.

So my intuition is:
  If read alot but seldom written, mark "__read_mostly".
  If seldom read or written, leave unmarked.

so as to leave plenty of the rarely used (neither read nor written on
kernel hot path code) as "cannon fodder" to fill the rest of the cache
lines favored by the hot data.

This leads me to ask, of any item marked "__read_mostly":

  Is it accessed (for read, presumably) frequently, on a hot path?

If not, then I'd favor (absent actual measurements to the contrary) not
marking it.

By this criteria:

  1) I would -not- mark "struct kmem_cache *cpuset" __read_mostly, as it
     is rarely accessed on -any- code path, much less a hot one.  It is
     ideal cannon fodder.

  2) I -would- (following a private email suggestion of Christoph Lameter)
     mark my recently added "int number_of_cpusets" __read_mostly,
     because it is accessed for every zone considered in the loops
     within^Wbeneath __alloc_pages().

Disclaimer -- none of the above speculation is tempered by the heat of any
actual performance measurements.  Hence, it is worth about as much as my
legal advice.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
