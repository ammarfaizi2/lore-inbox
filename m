Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312866AbSCVWKz>; Fri, 22 Mar 2002 17:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312868AbSCVWKp>; Fri, 22 Mar 2002 17:10:45 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:60854 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S312866AbSCVWKa> convert rfc822-to-8bit;
	Fri, 22 Mar 2002 17:10:30 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: mprotect() api overhead.
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Fri, 22 Mar 2002 14:10:20 -0800
Message-ID: <4D7B558499107545BB45044C63822DDE3A2043@mvebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mprotect() api overhead.
Thread-Index: AcHR7mdAKgcxLZBATEGIynpTNXhU+w==
From: <Tony.P.Lee@nokia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Mar 2002 22:10:21.0025 (UTC) FILETIME=[5B7A5510:01C1D1EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We like to design a software in certain module way.  For example,
a libForwardTableManager.so for infiniband switch manager 
might manager 128 MBytes of share memory data.  10 or more 
applications will call the APIs in the libForwardTableManager.so 
to get/set the forward table data.

Since the data manager by this share library are globally share,
there is a chance that someone might corrupt this data via
invalid pointers.  Or even if we don't give them a pointer, the
application can still corrupt the share memory with an uninitialized 
pointer on it stack.  This type of problem are extremely hard
to debug.

What I like to do is to use the mprotect() api to turn on/off the 
memory read/write access to the globally share memory.  This
way, the only possible memory corruption to the share table 
is from the APIs in the libForwardTableManager.so.  It makes
debugging this kind of problem easier.  If the application
corrupts the memory, it will cause a seg-fault which also
makes debugging simple.



Questions for the linux kernel guru are:

	Is this reasonable to do in Linux?

	Any idea the overhead for such scheme in term of numbers of
	micro-seconds added to each API call.  I like to see the 
	overhead in sub-microseconds range since the application
	might call the api in libForwardTableManager.so  at the rate
	of 100k api call per seconds.  

	I used the TSC counter to profile the mprotect() overhead
	in QNX (micro-kernel RTOS).  It has overhead is 130 
	milliseconds for 6 MB of share memory which is extremely high.
	I think the reason is all of QNX APIs turns to IPC messages
	to process manager task.  It cause context switch to 
	other tasks.


	For x86 system, is there way to specify 4MB page table entry
	instead of 4K page table entry when use the mmap() api.  
	With 4MB mmap() page table entry, mprotected should take only
	8 iterations to change the access bits for 32 MB of share
	memory as compare to 8k iterations for 4k page table entries.
	Am I corrected on this?

Thanks	

----------------------------------------------------------------
Tony Lee           Nokia Networks, Inc. 
Work:(650)864-6565 545 Whisman Drive - Bld C 
                   Mountain View, CA 94043

