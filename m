Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbRLDQro>; Tue, 4 Dec 2001 11:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281184AbRLDQq7>; Tue, 4 Dec 2001 11:46:59 -0500
Received: from pc-62-30-67-59-az.blueyonder.co.uk ([62.30.67.59]:61166 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S281157AbRLDQpm>; Tue, 4 Dec 2001 11:45:42 -0500
Date: Tue, 4 Dec 2001 16:39:50 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Christoph Rohland <cr@sap.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Wrapping memory.
Message-ID: <20011204163950.B28839@kushida.jlokier.co.uk>
In-Reply-To: <m3r8qcagt7.fsf@linux.local> <E16AIZ8-0008Re-00@the-village.bc.nu> <12969.1007315617@redhat.com> <m3r8qcagt7.fsf@linux.local> <25163.1007370678@redhat.com> <20011204104047.A18147@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204104047.A18147@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Dec 04, 2001 at 10:40:47AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Dec 03, 2001 at 09:11:18AM +0000, David Woodhouse wrote:
> > ARM used to just break, but I pointed it out to Russell a while ago and I 
> > believe he fixed it. I don't remember what his fix was - it may have been 
> > just to map the offending page uncached, which is also a fairly effective 
> > was of avoiding cache aliasing :)
> 
> We actually still map the pages as cached, but when update_mmu_cache
> detects that a page has been mmapped more than once, we ensure that
> the other mappings in the current mm will fault when accessed.

It should be possible, in a "portable" program, to map the two pages you
want and then test to see whether they are aliasing correctly.

Write to one and read from the other page, and vice versa.  Repeat a few
thousand times just in case you were interrupted in the middle.

That is my approach to creating circular buffers (which is the question
which started this thread).

Unfortunately, the update_mmu_cache makes aliasing work properly while
ruining performence, so then it's better to not to use the mapping trick
at all in that case.  To check for this, I have to call gettimeofday()
between pairs of accesses, to check whether they are slow.  I don't know
for sure if this works because I don't have an ARM to try it on.

-- Jamie

