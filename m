Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264096AbRFZURZ>; Tue, 26 Jun 2001 16:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263031AbRFZURQ>; Tue, 26 Jun 2001 16:17:16 -0400
Received: from amadeus.resilience.com ([209.245.157.29]:13364 "HELO jmcmullan")
	by vger.kernel.org with SMTP id <S264096AbRFZUOK>;
	Tue, 26 Jun 2001 16:14:10 -0400
Date: Tue, 26 Jun 2001 15:58:38 -0400
From: Jason McMullan <jmcmullan@linuxcare.com>
To: linux-kernel@vger.kernel.org
Subject: VM Requirement Document - v0.0
Message-ID: <20010626155838.A23098@jmcmullan.resilience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Here's my first pass at a VM requirements document,
for the embedded, desktop, and server cases. At the end is 
a summary of general rules that should take care of all of 
these cases.

Bandwidth Descriptions:

	immediate: RAM, on-chip cache, etc. 
	fast:	   Flash reads, ROMs, etc.
	medium:    Hard drives, CD-ROMs, 100Mb ethernet, etc.
	slow:	   Flash writes, floppy disks,  CD-WR burners
	packeted:  Reads/write should be in as large a packet as possible

Embedded Case
-------------

	Overview
	--------
	  In the embedded case, the primary VM motiviation is to
	use as _little_ caching of the filesystem for reads as
	possible because (a) reads are very fast and (b) we don't
	have any swap. However, we want to cache _writes_ as hard
	as possible, because Flash is slow, and prone to wear.
	  
	Machine Description
	------------------
		RAM:	4-64Mb	 (reads: immediate, writes: immediate)
		Flash:	4-128Mb  (reads: fast, writes: slow, packeted)
		CDROM:	640-800Mb (reads: medium)
		Swap:	0Mb

	Motiviations
	------------
		* Don't write to the (slow,packeted) devices until
		  you need to free up memory for processes.
		* Never cache reads from immediate/fast devices.

Desktop Case
------------

	Overview
	--------
	  On the desktop, interactivity is king. We don't want to eat
	lots of I/O bandwidth paging in and out, however we also want
	to cache as much of the FS as possible, to speed compiles and
	multiple operations over the same sets of files. 
	
	  Balancing this is the notion of 'cache-hit-rates'. If our 
	access patterns aren't hitting cache, but disk instead, don't 
	swap out processes, just shrink the cache. Contrawise, if we
	have good cache hit rates, swap out the idle tasks.

	Machine Description
	-------------------
		RAM:	32Mb-1Gb  (reads: immediate, writes: immediate)
		HD:	1Gb-100Gb (reads: medium, writes: medium)
		CDROM:	640-800Mb (reads: medium)
		DVD:	1Gb-8Gb   (reads: medium)
		Swap:	RAM size  (HD speeds)

	Motivations
	-----------
		* If we're getting low cache hit rates, don't flush 
		  processes to swap.
		* If we're getting good cache hit rates, flush old, idle
		  processes to swap.

Laptop Case
-----------

	Overview
	--------
	  Same as a desktop, except now you must treat the HDs as
	packetized devices for power-saving.

	Machine Description
	-------------------
		RAM:	32Mb-1Gb  (reads: immediate, writes: immediate)
		HD:	1Gb-100Gb (reads: medium,packeted, writes: medium,packeted)
		CDROM:	640-800Mb (reads: medium)
		DVD:	1Gb-8Gb   (reads: medium)
		Swap:	RAM size  (HD speeds)

	Motivations
	-----------
		* Keep packetized devices as continuously-idle as possible.
		  Small chunks of idleness don't count. You want to have
		  maximal stetches of idleness for the device.

Server Case
-----------

	Overview
	--------
	  Same as a desktop, except that interactivity be damned. You
	want processes to _rarely_ have to wait for swap-ins, and 
	you want as much read-ahead as possible. Idle tasks are pressed
	firmly into cache to make room for running processes.

	Machine Description
	-------------------
		RAM:	512Mb-64Gb (reads: immediate, writes: immediate)
		HD:	10Gb-4Tb   (reads: medium, writes: medium)
		Swap:	2*RAM size  (HD speeds)

	Motivations
	-----------
		* Keep running processes as fully in memory as possible.

----------------------------- SUMMARY ----------------------------------

	If we take all the motivations from the above, and list them,
we get:

	* Don't write to the (slow,packeted) devices until
	  you need to free up memory for processes.
	* Never cache reads from immediate/fast devices.
	* If we're getting low cache hit rates, don't flush 
	  processes to swap.
	* If we're getting good cache hit rates, flush old, idle
	  processes to swap.
	* Keep packetized devices as continuously-idle as possible.
	  Small chunks of idleness don't count. You want to have
	  maximal stetches of idleness for the device.
	* Keep running processes as fully in memory as possible.


	Oddly enough, they don't seem to conflict. I'll continue to
work on these motivations, and try to determine testable methods
of measuring the success of a VM versus these criteria.

	Comments welcome.

-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
