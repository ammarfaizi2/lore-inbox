Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTIQCKS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbTIQCKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:10:18 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:17924 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262600AbTIQCKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:10:07 -0400
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel
	addrs?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ben Johnson <ben@blarg.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030916184421.A25733@blarg.net>
References: <20030916154747.A22526@blarg.net>
	 <1562370000.1063759683@[10.10.2.4]> <20030917005446.GW4306@holomorphy.com>
	 <1563260000.1063760286@[10.10.2.4]>  <20030916184421.A25733@blarg.net>
Content-Type: text/plain
Message-Id: <1063764603.19730.8.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Sep 2003 04:10:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-17 at 03:44, Ben Johnson wrote:
> On Tue, Sep 16, 2003 at 05:58:08PM -0700, Martin J. Bligh wrote:
> > 
> > BTW, to the original question ... chapter 2 of "Understanding the Linux Kernel"
> > had a good explanation of all this.
> 
> Thank you.  I've been reading the first addition.  is there a second?
> the second chapter has a very good explanation of paging and how linear
> addresses are used.  logical addresses on the other hand are barely
> mentioned.  Segmentation is described well, but the translation of
> logical into linear addresses is not described.
> 
> I've read elsewhere that logical addresses are comprised of a 16-bit
> segment selector and a 32-bit offset.  I thought pointers were always
> exactly 32-bits (on 32-bit intel).  where is the 16-bit selector?

It was a long time ago since I read about i386 addressing mechanisms,
but if my memory serves me well:

The selector is a 16-bit number which points to a segment descriptor in
either the GDT or the LDT.

The LDT is a Local Descriptor Table which is particular to a given task.
There is a task register on the CPU which contains a region of memory
used to store CPU registers when a context switch is performed and where
the LDT for that task is stored. The GDT is global to the system and
shared by all tasks.

Basically, the segment descriptor tells what kind of segment it is
(code, data, stack), defines its priority (the ring, being 0 the most
privileged and 3 the least), if it's present in memory, and defines it's
base linear address and it's size (either in bytes or in 4KB pages,
depending on it's granularity).

A selector is stored in any of the CPU segment registers (CS, DS, ES,
FS, GS and SS).

Thus from the <selector:offset> pair, you get the base address from the 
segment descriptor pointed to by the selector, and then add it up the
offset. The resulting linear address is then converted by the MMU to a
physical address using the page tables. Note that even selector+offset
is a 48-bit number, the resulting address is always a 32-bit address.
Modern processors can address 36 bit addresses using PAE extensions, but
those remember me of the times when we mapped Expanded Memory into 64KB
frames below 1MB of RAM.

I recommend you reading the Intel manuals, they are worth reading :-)

