Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSEGTHe>; Tue, 7 May 2002 15:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315947AbSEGTHd>; Tue, 7 May 2002 15:07:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21190 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315946AbSEGTHc>;
	Tue, 7 May 2002 15:07:32 -0400
Message-ID: <3CD825E4.6950ED92@vnet.ibm.com>
Date: Tue, 07 May 2002 14:07:16 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory Barrier Definitions
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/07/2002 02:07:18 PM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/07/2002 02:07:21 PM,
	Serialize complete at 05/07/2002 02:07:21 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been working through a number of issues that became significant
on Power4 based systems, and wanted to start some discussion to
understand which other platforms are impacted in a similar way.  

The fundamental issue is that Power4 is weakly consistent and the
PowerPC architecture definitions for memory reference ordering do not
necessarily mesh well with the current Linux barrier primitive use. 
Obviously, we are not the only weakc platform, but I suspect the degree
and latencies we see push things more than most systems.  What is less
clear to me is how much PPC memory barrier symantics have in common with
other systems; presumably there are some which are similar.

As a specific example, on PowerPC the following memory barriers are
defined:

eieio: Orders all I/O references & store/store to system memory, but
seperatly
lwsync: Orders load/load, store/store, and load/store, only to system
memory 
sync: Orders everything

In terms of cycles, eieio is relatively cheap, lwsync is perhaps 100's,
while sync is measured in the 1000's.  The key is that only a sync
orders both system memory and I/O space references and it is very
expensive, so it should only be used where absolutely necessary, like in
a driver.

Linux defines (more or less) the following barriers:
mb, rmb, wmb, smp_mb, smp_wmb, smp_rmb

An example of where these primitives get us into trouble is the use of
wmb() to order two stores which are only to system memory (where a
lwsync would do for ppc64) and for a store to system memory followed by
a store to I/O (many examples in drivers).  Here ppc64 requires a sync. 
Therefore we must always pay the high price and use a sync for wmb().

A solution was pointed out by Rusty Russell that we should probabily be
using smp_*mb() for system memory ordering and reserve the *mb() calls
for when ordering against I/O is also required.  There does seem to be
some limited cases where this has been done, but in general *mb() are
used in most parts of the kernel.

Any thoughts if making better use of the smp_* macros would be the right
approach?

Thanks -

Dave Engebretsen
