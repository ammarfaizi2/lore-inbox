Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWITUHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWITUHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWITUHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:07:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:49576 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750708AbWITUHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:07:12 -0400
Date: Wed, 20 Sep 2006 13:06:56 -0700
From: Paul Jackson <pj@sgi.com>
To: rohitseth@google.com
Cc: clameter@sgi.com, ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920130656.85208bde.pj@sgi.com>
In-Reply-To: <1158775678.8574.81.camel@galaxy.corp.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773208.8574.53.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
	<1158775678.8574.81.camel@galaxy.corp.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth wrote:
> I thought the fake NUMA support still does not work on x86_64 baseline
> kernel.  Though Paul and Andrew have patches to make it work.

It works.  Having long zonelists where one expects to have to scan a
long way down the list has a performance glitch, in the
get_page_from_freelist() code sucks.  We don't want to be doing a
linear scan of a long list on this code path.

The cpuset_zone_allowed() routine happens to be the most obvious canary
in this linear scan loop (google 'canary in the mine shaft' for the
idiom), so shows up the problem first.

We don't have patches yet to fix this (well, we might, I still haven't
digested the last couple days worth of postings.)  But we are persuing
Andrew's suggestion to cache the zone that we found memory on last time
around, so as to dramatically reduce the chance we have to rescan the
entire dang zonelist every time through this code.

Initially these zonelists had been designed to handle the various
kinds of dma, main and upper memory on common PC architectures, then
they were (ab)used to handle multiple Non-Uniform Memory Nodes (NUMA)
on bigger boxen.  So it is not entirely surprising that we hit a
performance speed bump when further (ab)using them to handle multiple
Uniform sub-nodes as part of a memory containerization effort.  Each
different kind of use hits these algorithms and data structures
differently.

It seems pretty clear by now that we will be able to pave over this
speed bump without doing any major reconstruction.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
