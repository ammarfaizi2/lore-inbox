Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSCWBYV>; Fri, 22 Mar 2002 20:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291620AbSCWBWz>; Fri, 22 Mar 2002 20:22:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S310458AbSCWBPR> convert rfc822-to-8bit;
	Fri, 22 Mar 2002 20:15:17 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: mprotect() api overhead.
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Fri, 22 Mar 2002 15:09:31 -0800
Message-ID: <4D7B558499107545BB45044C63822DDE3A2044@mvebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mprotect() api overhead.
Thread-Index: AcHR9TTkt/0OgYy3RTS1eWS0PLBKvAAAGzCQ
From: <Tony.P.Lee@nokia.com>
To: <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Mar 2002 23:09:32.0064 (UTC) FILETIME=[A00FE200:01C1D1F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: ext Andrew Morton [mailto:akpm@zip.com.au]
> Sent: Friday, March 22, 2002 2:58 PM
> To: Lee Tony.P (NET/MtView)
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: mprotect() api overhead.
> 
> 
> Tony.P.Lee@nokia.com wrote:
> > 
> > ...
> > What I like to do is to use the mprotect() api to turn on/off the
> > memory read/write access to the globally share memory.  This
> > way, the only possible memory corruption to the share table
> > is from the APIs in the libForwardTableManager.so.  It makes
> > debugging this kind of problem easier.  If the application
> > corrupts the memory, it will cause a seg-fault which also
> > makes debugging simple.
> > 
> > Questions for the linux kernel guru are:
> > 
> >         Is this reasonable to do in Linux?
> > 
> >         Any idea the overhead for such scheme in term of numbers of
> >         micro-seconds added to each API call.  I like to see the
> >         overhead in sub-microseconds range since the application
> >         might call the api in libForwardTableManager.so  at the rate
> >         of 100k api call per seconds.
> > 
> >         I used the TSC counter to profile the mprotect() overhead
> >         in QNX (micro-kernel RTOS).  It has overhead is 130
> >         milliseconds for 6 MB of share memory which is 
> extremely high.
> >         I think the reason is all of QNX APIs turns to IPC messages
> >         to process manager task.  It cause context switch to
> >         other tasks.
> 
> Seems that mprotect() against a 6 megabyte region takes five 
> microseconds
> in Linux.  Which is too expensive for you.
> 
> It would be better if you could map the same memory region
> two times.  One with PROT_READ and the other with 
> PROT_READ|PROT_WRITE.
> Then just use the appropriate pointer at the appropriate time.
> 

Andrew,
Thanks for the info.

5 microseconds is definitly a lot better than the number I got
with QNX.   Mapping the same region twice doesn't help.  Here's
why:	App A call my API() and my api use local variables as 
pointers to the read write region of share memory on stack.
App B has an un-init local variable in stack, it updates that 
pointer and the share memory is corrupted.  It is impossible
to track down exactly who cause the corruption in this case.

----------------------------------------------------------------
Tony Lee           Nokia Networks, Inc. 
Work:(650)864-6565 545 Whisman Drive - Bld C 
                   Mountain View, CA 94043

