Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbRE2KO0>; Tue, 29 May 2001 06:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbRE2KOQ>; Tue, 29 May 2001 06:14:16 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:36879 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261487AbRE2KOM>;
	Tue, 29 May 2001 06:14:12 -0400
Date: Tue, 29 May 2001 12:14:03 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Kurt Roeckx <Q@ping.be>, Russell King <rmk@arm.linux.org.uk>,
        Vadim Lebedev <vlebedev@aplio.fr>, linux-kernel@vger.kernel.org
Subject: Re: Potenitial security hole in the kernel
Message-ID: <20010529121403.A7527@pcep-jamie.cern.ch>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP> <20010529001256.F9203@flint.arm.linux.org.uk> <20010529013030.A3381@ping.be> <20010529014635.A3499@ping.be> <20010529023222.C6061@pcep-jamie.cern.ch> <20010529193540.A7029@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010529193540.A7029@metastasis.f00f.org>; from cw@f00f.org on Tue, May 29, 2001 at 07:35:40PM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
>     By the way, the context stored on the stack is entirely a user
>     space context, however it does include some information from the
>     kernel that may be useful to user space, such as a page fault
>     address.
> 
> I actually (ab)used this for userspace paging with mprotect and
> friends.... nasty hack :)

Aye, and it's nice to see that Linux is relatively fast at this.
(See attached table).

Various garbage collectors do this to track dirty pages (clisp, Elk and
Hans Boehm's GC which is now part of the GCC distribution come to mind).
It's a shame this doesn't work for system calls like read(), as they
return EFAULT instead of calling the signal handler.  (It could be made
to work with some effort).

-- Jamie


   Timing measurements
   ===================

   Here are some rough timings to handle a write protection faults and
   change protection from read-only to writable, page by page in
   sequential order.  2000 pages were faulted, in a region of
   memory-mapped /dev/zero.

   The times given are the total running time divided by the number of
   pages, so they including the time to call mprotect to unprotect each
   page.  They are given in microseconds per page, and only the best
   observed time is shown.  The first column is the time to dirty a zero
   page for the first time (the OS must process a second page fault and
   COW/allocate a new page in these cases).  The second column is the
   time to unprotect a page that is already modified, which is the
   typical scenario for an incremental garbage collector.

     133MHz Pentium Linux 2.3.29           85.52      37.13     (page == 4096).
     233MHz dual Pentium II Linux 2.2.17-4 51.17      23.27     (page == 4096).
     233MHz Pentium II Linux 2.4.4         51.15      16.60     (page == 4096).
     300MHz Pentium II Linux 2.4.4         39.84      13.02     (page == 4096).
     366MHz Intel Celeron Linux 2.4.4      38.83      13.02     (page == 4096).
     400MHz Pentium II Linux 2.4.2         35.83      12.46     (page == 4096).
     600MHz Pentium III Linux 2.4.4        33.60       8.12     (page == 4096).
     600MHz Pentium III Linux 2.2.14-5     27.28       7.75     (page == 4096).
     600MHz Pentium III Linux 2.2.17-4     28.62       9.36     (page == 4096).
     PA-RISC HP-UX (which speed?)         108.44      60.34     (page == 4096).
     Sparc Ultra-1 SunOS 5.6              256.69     209.03     (page == 8192).
     Sparc SunOS 5.7 machine #1           158.26     102.26     (page == 8192).
     Sparc SunOS 5.7 machine #2           190.09     139.25     (page == 8192).
