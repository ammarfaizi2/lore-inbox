Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbRFGRAc>; Thu, 7 Jun 2001 13:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbRFGRAX>; Thu, 7 Jun 2001 13:00:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16429 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261988AbRFGRAN>; Thu, 7 Jun 2001 13:00:13 -0400
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: Derek Glidden <dglidden@illusionary.com>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
	<Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
	<3B1D927E.1B2EBE76@uow.edu.au> <20010605231908.A10520@illusionary.com>
	<3B1DEAC7.43DEFA1C@idb.hist.no> <3B1E437C.D5D339EB@illusionary.com>
	<3B1F2BFE.28E7CCF0@idb.hist.no>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2001 10:56:24 -0600
In-Reply-To: <3B1F2BFE.28E7CCF0@idb.hist.no>
Message-ID: <m1k82o44av.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@idb.hist.no> writes:

> A problem with this is that normal paging-in is allowed to page other
> things out as well.  But you can't have that when swap is about to
> be turned off.  My guess is that swapoff functionality was perceived to
> be so seldom used that they didn't bother too much with scheduling 
> or efficiency.

There is some truth in that.  You aren't allowed to allocate new pages
in the swap space currently being removed however.  The current swap
off code removes pages from the current swap space without breaking
any sharing between swap pages.  Depending on your load this may be
important.  Fixing swapoff to be more efficient while at the same time
keeping sharing between pages is tricky.  That under loads that are
easy to trigger in 2.4 swapoff never sleeps is a big bug.

> I don't have the same problem myself though.  Shutting down with
> 30M or so in swap never take unusual time on 2.4.x kernels here,
> with a 300MHz processor.  I did a test while typing this letter,
> almost filling the 96M swap partition with 88M.  swapoff
> took 1 minute at 100% cpu.  This is long, but the machine was responsive
> most of that time.  I.e. no worse than during a kernel compile.
> The machine froze 10 seconds or so at the end of the minute, I can
> imagine that biting with bigger swap.

O.k. so at some point you actually wait for I/O and other process get
a chance to run.  On the larger machines we never wait for I/O and
thus never schedule at all.

The problem is now understood.  Now we just need to fix it.

Eric
