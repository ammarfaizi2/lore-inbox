Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbTIAORY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 10:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbTIAORY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 10:17:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38414 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262936AbTIAORW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 10:17:22 -0400
Date: Mon, 1 Sep 2003 15:17:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901151710.A22682@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	"Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
	linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk> <1062188787.4062.21.camel@elenuial.steamballoon.com> <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901101224.GB1638@mail.jlokier.co.uk>; from jamie@shareable.org on Mon, Sep 01, 2003 at 11:12:24AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 11:12:24AM +0100, Jamie Lokier wrote:
> Russell King wrote:
> > This looks like an old kernel on your NetWinder.  Later 2.4 kernels
> > should get this right (by marking the pages uncacheable in user space.)
> 
> How do they know which pages to mark uncacheable?  Surely not all
> MAP_SHARED|MAP_FIXED mappings are uncacheable?

By looking at the mappings present in the process.  If a process maps the
same file using MAP_SHARED _and_ we fault the same page of data into two
or more mappings, we turn off the cache for those pages.

We actually only turn off the cache and leave the write buffer (aka your
store buffer) turned on for these regions, which should be sufficient for
it to remain coherent between different virtual addresses.

I've been doing some further investigation, and I'm now of the opinion
that "SA110" StrongARM chips have buggy write buffers, because:

- if I turn off the cache, leaving the write buffer on, this program
  works on StrongARM-1110 CPUs but not some StrongARM-110 CPUs.
- if I turn off the cache and write buffer on these twice-mapped pages,
  StrongARM-110 behaves as expected.

I've tested on several silicon revisions of StrongARM-110's:
- H appears buggy (reports as rev. 2)
- K appears fine (reports as rev. 2)
- S appears buggy (reports as rev. 3)

Unfortunately, the written documentation makes zero mention of the exact
write buffer behaviour.  The best that I have to go on for the
StrongARM-110 is a block diagram which indicates that the write buffer
uses physical addresses, and that the D-cache contains the physical
address which the line was fetched from for writeback (via the write
buffer.)

So it seems your test program finds problems which DaveM's aliastest
program fails to detect...  Gah. ;(

I guess its time to devise a kernel test and alter our behaviour on ARM
accordingly.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

