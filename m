Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTL2KXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 05:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTL2KXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 05:23:37 -0500
Received: from holomorphy.com ([199.26.172.102]:41659 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262796AbTL2KXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 05:23:35 -0500
Date: Mon, 29 Dec 2003 02:23:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mfedyk@matchmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, phillips@arcor.de
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031229102319.GW22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>, mfedyk@matchmail.com,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Anton Ertl <anton@mips.complang.tuwien.ac.at>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	phillips@arcor.de
References: <m1smj596t1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0312272046400.2274@home.osdl.org> <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com> <20031229025507.GT22443@holomorphy.com> <Pine.LNX.4.58.0312282000390.11299@home.osdl.org> <20031229065240.GU22443@holomorphy.com> <Pine.LNX.4.58.0312290112450.11299@home.osdl.org> <20031229092203.GL27687@holomorphy.com> <Pine.LNX.4.58.0312290129510.11299@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312290129510.11299@home.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, William Lee Irwin III wrote:
>> I can't say I'm particularly encouraged by what I've heard thus far,

On Mon, Dec 29, 2003 at 01:33:53AM -0800, Linus Torvalds wrote:
> Well, I don't even know what your approach is - mind giving an overview? 
> My original plan (and you can see some of it in the fact that 
> PAGE_CACHE_SIZE is separate from PAGE_SIZE), was to just have the page 
> cache be able to use bigger pages than the "normal" pages, and the 
> normal pages would continue to be the hardware page size.
> However, especially with mem_map[] becoming something of a problem, and 
> all the problems we'd have if PAGE_SIZE and PAGE_CACHE_SIZE were 
> different, I suspect I'd just be happier with increasing PAGE_SIZE 
> altogether (and PAGE_CACHE_SIZE with it), and then just teaching the VM 
> mapping about "fractional pages".
> What's your approach?

Hmm, I presented on this at KS. Basically, it's identical to Hugh
Dickins' approach from 2000. The only difference is really that it had
to be forward ported (or unfortunately in too many cases reimplemented)
to mix with current code and features.

Basically, elevate PAGE_SIZE, introduce MMUPAGE_SIZE to be a nice macro
representing the hardware pagesize, and the fault handling is done with
some relatively localized complexity. Numerous s/PAGE_SIZE/MMUPAGE_SIZE/
bits are sprinkled around, along with a few more involved changes because
a large number of distributed changes are required to handle oddities
that occur when PAGE_SIZE changes from 4KB. The more involved changes
are often for things such as the only reason it uses PAGE_SIZE is
really that it just expects 4KB and says PAGE_SIZE, or that it wants
some fixed (even across compiles) size and needs updating for more
general PAGE_SIZE numbers, or sometimes that it expects PAGE_SIZE to be
what a pte maps when this is now represented by MMUPAGE_SIZE. I have a
bad feeling the diligence of the original code audit could be bearing
against me (and though I'm trying to be equally diligent, I'm not hugh).

The fact merely elevating PAGE_SIZE breaks numerous things makes me
rather suspicious of claims that minimalistic patches can do likewise.

The only new infrastructures introduced are the MMUPAGE_SIZE and a couple
of related macros (defining numbers, not structures or code) and the
fault handler implementations. The diff size is not small. The memory
footprint is, and demonstrably so (c.f. March 27 2003).

My 2.6 code has been heavily leveraging the pfn abstraction in its favor
to represent physical addresses measured in units of the hardware
pagesize. Generally, my maintenance approach has been incrementally
advancing the state of the thing while keeping it working on as broad a
cross section of i386 systems as I can test or get testers on. It has
been verified to run userspace on Thinkpad T21's and 16x/32GB and
32x/64GB NUMA-Q's at every point release it's been ported to, which
since 2.5.68 or so has been every point release coming out of kernel.org.


-- wli
