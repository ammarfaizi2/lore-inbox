Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTL3E7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTL3E7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:59:54 -0500
Received: from holomorphy.com ([199.26.172.102]:7873 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264477AbTL3E7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:59:49 -0500
Date: Mon, 29 Dec 2003 20:59:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@osdl.org, mfedyk@matchmail.com, ebiederm@xmission.com,
       anton@mips.complang.tuwien.ac.at, linux-kernel@vger.kernel.org,
       phillips@arcor.de
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031230045918.GA22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@osdl.org,
	mfedyk@matchmail.com, ebiederm@xmission.com,
	anton@mips.complang.tuwien.ac.at, linux-kernel@vger.kernel.org,
	phillips@arcor.de
References: <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com> <20031229025507.GT22443@holomorphy.com> <Pine.LNX.4.58.0312282000390.11299@home.osdl.org> <20031229065240.GU22443@holomorphy.com> <Pine.LNX.4.58.0312290112450.11299@home.osdl.org> <20031229092203.GL27687@holomorphy.com> <Pine.LNX.4.58.0312290129510.11299@home.osdl.org> <20031229102319.GW22443@holomorphy.com> <20031230130029.6183a872.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230130029.6183a872.rusty@rustcorp.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003 02:23:19 -0800 William Lee Irwin III wrote:
>> The fact merely elevating PAGE_SIZE breaks numerous things makes me
>> rather suspicious of claims that minimalistic patches can do likewise.

On Tue, Dec 30, 2003 at 01:00:29PM +1100, Rusty Russell wrote:
> Can you give an example?
> 	One approach is to simply present a larger page size to userspace w/
> getpagesize().  This does break ELF programs which have been laid out assuming
> the old page size (presumably they try to mprotect the read-only sections).
> On PPC, the ELF ABI already insists on a 64k boundary between such sections,
> and maybe for others you could simply round appropriately and pray, or do
> fine-grained protections (ie. on real pagesize) for that one case.

Apps must, of course, be relinked for that, but that's userspace. This
ABI change is largely out of the picture due to legacy binaries, user
virtualspace fragmentation (most likely an issue for 32-bit threading),
and so on. The choice of PAGE_SIZE in such schemes is also restricted
to no larger than whatever choice used for userspace linking, which is
a relatively ugly dependency. There's also a question of "smooth
transition": the only way to "incrementally deploy" it on a mixture
"ready" userspace and "unready" userspace is to turn it off. I suppose
it has the minor advantage of being trivial to program.

I had in mind pure kernel internal issues, not ABI.

The issues from raising PAGE_SIZE alone are things like interpreting
hardware descriptions in arch code, some shifts underflowing for things
like hashtables, certain drivers doing ioremap() and the like either
filling up vmallocspace or getting their math wrong, and some other
drivers doing calculations on physical addresses getting them wrong, or
using PAGE_SIZE to represent some 4KB or other fixed-size memory area
interpreted by hardware, and filesystems that assume blocksize ==
PAGE_SIZE or assume PAGE_SIZE is less than some particular value (e.g.
short offsets into pages, worst of all being signed shorts), and
tripping BUG()'s in ll_rw_blk.c when 512*q->max_sectors < PAGE_SIZE.

These issues are the bulk of the work needing to be done for the driver
and fs sweeps. Actual concerns about MMUPAGE_SIZE in drivers/ and fs/
are rather limited in scope, though drivers/char/drm/ was somewhat
painful to get going (Zwane actually did most of this for me, as I have
no DRM/DRI -capable graphics cards at my disposal).


-- wli
