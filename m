Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbTBUDgY>; Thu, 20 Feb 2003 22:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbTBUDgY>; Thu, 20 Feb 2003 22:36:24 -0500
Received: from packet.digeo.com ([12.110.80.53]:63670 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267094AbTBUDgW>;
	Thu, 20 Feb 2003 22:36:22 -0500
Date: Thu, 20 Feb 2003 19:47:59 -0800
From: Andrew Morton <akpm@digeo.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: Performance of partial object-based rmap
Message-Id: <20030220194759.15d5d932.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50L.0302210020560.2329-100000@imladris.surriel.com>
References: <7490000.1045715152@[10.10.2.4]>
	<278890000.1045791857@flay>
	<20030220190819.531e119d.akpm@digeo.com>
	<Pine.LNX.4.50L.0302210020560.2329-100000@imladris.surriel.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 03:46:22.0281 (UTC) FILETIME=[CCE81B90:01C2D95B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@imladris.surriel.com> wrote:
>
> On Thu, 20 Feb 2003, Andrew Morton wrote:
> 
> > I think the guiding principle here is that we should not optimise for the
> > uncommon case (as rmap is doing), and we should not allow the uncommon case
> > to be utterly terrible (as Dave's patch can do).
> 
> This "guiding principle" appears to be the primary reason why
> we've taken over a year to stabilise linux 2.0 and linux 2.2
> and linux 2.4 ... or at least, too much of a focus on the first
> half of this guiding principle. ;)
> 
> We absolutely have to take care in avoiding the worst case
> scenarios, since statistics pretty much guarantee that somebody
> will run into nothing but that scenario ...
> 

We see things like the below report, which realistically shows
the problems with the reverse map.

I have yet to see _any_ report that the problems to which you refer
are causing difficulty in the field.

I think there's a middle ground.  Hint: MAP_ORACLE.


Begin forwarded message:

Date: Tue, 17 Sep 2002 13:30:42 -0500
From: "Peter Wong" <wpeter@us.ibm.com>
To: linux-mm@kvack.org, lse-tech@lists.sourceforge.net
Cc: riel@nl.linux.org, akpm@zip.com.au, mjbligh@us.ibm.com, wli@holomorphy.com, dmccr@us.ibm.com, gh@us.ibm.com, "Bill Hartner" <bhartner@us.ibm.com>, "Troy C Wilson" <wilsont@us.ibm.com>
Subject: Examining the Performance and Cost of Revesemaps on 2.5.26 Under Heavy DB Workload



     I measured a decision support workload using two 2.5.26-based
kernels, one of which does NOT have the rmap rollup patch while the
other HAS. The database size is 100GB. The 2.5.26 rmap rollup patch
was created by Dave McCracken.

     Based upon the throughput rate and CPU utilization, the two
kernels achieve similar performance.

     Based upon /proc/meminfo, the maximum reversemap size is
22,817,885.

     Based upon /proc/slabinfo, the maximum number of active pte_chain
objects is 3,411,018 with 32 bytes each. It consumes about 104 MB. The
maximum number of slabs allocated for pte_chains is 30,186 with 4KB
each, corresponding to about 118 MB. Similar memory consumption for
rmaps is observed while running the same workload and using Andrew
Morton's mm2 patch under 2.5.32. Andrew's patch can be found at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.32/2.5.32-mm2/.

     Note that since readv is not available on 2.5.26,  the runs above
used "read" instead of "readv".

     My previous note (Sept. 10, 2002) indicated that the memory
consumption for rmaps under 2.5.32 using "readv" is about 223 MB. And
"readv" is the preferred method for this workload. The difference of
memory consumption by using read (118 MB) and readv (223 MB) is likely
due to the different I/O algorithms used by the DBMS. When there are
multiple instances of this workload running concurrently, the amount
of memory allocated to rmaps is even more significant. More data will
be provided later.

----------------------------------------------------------------------
System Information:

   - 8-way 700MHz Pentium III Xeon processors, 2MB L2 Cache
   - 4GB RAM
   - 6 SCSI controllers connected to 120 9.1 GB disks with 10K RPM
----------------------------------------------------------------------

Regards,
Peter

Peter Wai Yee Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com

