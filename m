Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbTIARLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTIARLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:11:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3090 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263075AbTIARLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:11:52 -0400
Date: Mon, 1 Sep 2003 18:11:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901181148.C22682@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	"Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
	linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk> <1062188787.4062.21.camel@elenuial.steamballoon.com> <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk> <20030901165239.GB3556@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901165239.GB3556@mail.jlokier.co.uk>; from jamie@shareable.org on Mon, Sep 01, 2003 at 05:52:39PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 05:52:39PM +0100, Jamie Lokier wrote:
> Russell King wrote:
> > By looking at the mappings present in the process.  If a process maps the
> > same file using MAP_SHARED _and_ we fault the same page of data into two
> > or more mappings, we turn off the cache for those pages.
> 
>    1. That's not necessary when the virtual addresses are separated
>       by some multiple, is it?

Incorrect - with a VIVT, you have alias hell.  There is no multiple
which makes it safe.

> > I've tested on several silicon revisions of StrongARM-110's:
> > - H appears buggy (reports as rev. 2)
> > - K appears fine (reports as rev. 2)
> > - S appears buggy (reports as rev. 3)
> 
> It's possible that all of them are buggy, but the write buffer test
> doesn't manage to get writes into the buffer with the exact timing
> needed to trigger it.

Well, I've just generated a kernel test which does more or less the
same thing (write to one mapping, write to other, read from first.)
This indicates the same result.

If you take a moment to think about what should be going on -

- first write gets translated to physical address, and the address with
  the data is placed in the write buffer.
- second write gets translated to the same physical address, and the
  address and data is placed into the write buffer such that we store
  the first write then the second write to the same physical memory.
- reading from the first mapping should return the second writes value
  no matter what.

But it doesn't in some cases.

> Unfortunately, while the write buffer test does
> pretty much guarantee a store/store/load instruction sequence, because
> it's generic it can't guarantee how those are executed in a
> superscalar or out of order pipeline.

ARM doesn't do any of those tricks.

> > So it seems your test program finds problems which DaveM's aliastest
> > program fails to detect...  Gah. ;(
> 
> Well, it's good to know it was useful :/

Well, we now have a kernel test to detect the problem, which alters our
behaviour appropriately.  Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

