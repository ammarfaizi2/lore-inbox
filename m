Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314681AbSEHRH0>; Wed, 8 May 2002 13:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSEHRH0>; Wed, 8 May 2002 13:07:26 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:23784 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314681AbSEHRHW>;
	Wed, 8 May 2002 13:07:22 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15577.23356.338023.88947@napali.hpl.hp.com>
Date: Wed, 8 May 2002 10:07:08 -0700
To: Dave Engebretsen <engebret@vnet.ibm.com>
Cc: justincarlson@cmu.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, anton@samba.org, davidm@hpl.hp.com,
        ak@suse.de
Subject: Re: Memory Barrier Definitions
In-Reply-To: <3CD943CE.296717DF@vnet.ibm.com>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 08 May 2002 10:27:10 -0500, Dave Engebretsen <engebret@vnet.ibm.com> said:

  Dave> I am curious what the definition of memory barriers is for
  Dave> IA64, Sparc, and x86-64.

I'm not sure it's enough to look just at the memory barriers.  The
barriers only make sense within the memory ordering model defined for
each architecture.  For ia64, this is defined in Section 4.4.7 of
the System Architecture Guide, which is available at:

 http://developer.intel.com/design/itanium/downloads/24531803s.htm

  Dave> From what I can tell, sparc and x86-64 are like alpha and map
  Dave> directly
  Dave> to the existing mb, wmb, and rmb semantics, incluing ordering
  Dave> between system memory and I/O space.  Is that an accurate
  Dave> assesment?

  Dave> IA64 has both the mf and mf.a instructions, one for system
  Dave> memory the other for I/O space.

The ia64 memory ordering model is quite orthogonal to the one that
Linux uses (which is based on the Alpha instructions): Linux
distinguishes between read and write memory barriers.  ia64 uses an
acquire/release model instead.  An acquire orders all *later* memory
accesses and a release orders all *earlier* accesses (regardless of
whether they are reads or writes).  Another difference is that the
acquire/release semantics is attached to load/store instructions,
respectively.  This means that in an ideal world, ia64 would rarely
need to use the memory barrier instruction.

Now, finding a way to abstract all the differences accross
architectures in a way that's easy to use and allows for optimal
implementation on each architecture may not be easy.  This problem
also shows up with user-level thread libraries and I have had on and
off discussions about this with Hans Boehm, but neither of us has
really had time to work on it seriously.  In truth, it is also the
case that for Itanium and Itanium 2, the cost of "mf" is small enough
that there hasn't been a huge need to get this exactly right.  But
when reworking the memory ordering model of Linux, it might just as
well be taken into account.

  Dave> What is required for ordering
  Dave> of references between the spaces?  That is not clear to me
  Dave> looking at the ia64 headers.

Look at Table 4-15 in the above document (on page 2-70).  I/O space is
simply a memory-mapped region that is mapped uncached.  In the table,
the row "Sequential" refers to uncached memory.  The quick summary is
that normal loads/stores to memory are not automatically ordered with
respect to accesses to uncached memory.

I'm also discussing some of these issues in my book
(http://www.lia64.org/book/) in the Device I/O chapter, but the
architecture manual mentioned above is of course the ultimate source
if you want all the gory details.

	--david
