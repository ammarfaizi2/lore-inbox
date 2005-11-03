Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbVKCQXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbVKCQXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVKCQXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:23:52 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:56103 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030372AbVKCQXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:23:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=NSixCAaShh7Kplr7+tVape/XNqVi/Hc90U2QzftJ5kq7N35ksrvtcbxDOqXmtkvIJn29S30Oxw+e9fOcmpx6faevbHBBPjpz5SAoUrFRnOrAeF2MnqJm13ncxbFpy2qfR9MYu2QPc6jumajT8F1zsTNsidn9BlpfHz+MRaYexTY=
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Badari Pulavarty <pbadari@gmail.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: Rob Landley <rob@landley.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Gerrit Huizenga <gh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051103163555.GA4174@ccure.user-mode-linux.org>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	 <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au>
	 <200511030007.34285.rob@landley.net>
	 <20051103163555.GA4174@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 08:23:20 -0800
Message-Id: <1131035000.24503.135.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 11:35 -0500, Jeff Dike wrote:
> On Thu, Nov 03, 2005 at 12:07:33AM -0600, Rob Landley wrote:
> > I want UML to 
> > be able to hand back however much memory it's not using, but handing back 
> > individual pages as we free them and inserting a syscall overhead for every 
> > page freed and allocated is just nuts.  (Plus, at page size, the OS isn't 
> > likely to zero them much faster than we can ourselves even without the 
> > syscall overhead.)  Defragmentation means we can batch this into a 
> > granularity that makes it worth it.
> 
> I don't think that freeing pages back to the host in free_pages is the
> way to go.  The normal behavior for a Linux system, virtual or
> physical, is to use all the memory it has.  So, any memory that's
> freed is pretty likely to be reused for something else, wasting any
> effort that's made to free pages back to the host.
> 
> The one counter-example I can think of is when a large process with a
> lot of data exits.  Then its data pages will be freed and they may
> stay free for a while until the system finds other data to fill them
> with.
> 
> Also, it's not the virtual machine's job to know how to make the host
> perform optimally.  It doesn't have the information to do it.  It's
> perfectly OK for a UML to hang on to memory if the host has plenty
> free.  So, it's the host's job to make sure that its memory pressure
> is reflected to the UMLs.
> 
> My current thinking is that you'll have a daemon on the host keeping
> track of memory pressure on the host and the UMLs, plugging and
> unplugging memory in order to keep the busy machines, including the
> host, supplied with memory, and periodically pushing down the memory
> of idle UMLs in order to force them to GC their page caches.
> 
> With Badari's patch and UML memory hotplug, the infrastructure is
> there to make this work.  The one thing I'm puzzling over right now is
> how to measure memory pressure.

Yep. This is the exactly the issue other product groups normally raise
on Linux. How do we measure memory pressure in linux ? Some of our
software products want to grow or shrink their memory usage depending
on the memory pressure in the system. Since most memory is used for
cache, "free" really doesn't indicate anything -they are monitoring
info in /proc/meminfo and swapping rates to "guess" on the memory
pressure. They want a clear way of finding out "how badly" system
is under memory pressure. (As a starting point, they want to find out
out of "cached" memory - how much is really easily "reclaimable" 
under memory pressure - without swapping). I know this is kind of 
crazy, but interesting to think about :)

Thanks,
Badari

