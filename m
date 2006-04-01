Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWDAGvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWDAGvZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 01:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWDAGvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 01:51:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46497 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750722AbWDAGvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 01:51:24 -0500
Date: Sat, 1 Apr 2006 16:50:19 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
Message-ID: <20060401165019.G961681@wobbly.melbourne.sgi.com>
References: <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com> <20060327131049.2c6a5413.akpm@osdl.org> <20060327225847.GC3756@localhost.localdomain> <1143530126.11560.6.camel@openx2.frec.bull.fr> <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com> <1143623605.5046.11.camel@openx2.frec.bull.fr> <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com> <20060330174008.GW5030@schatzie.adilger.int> <1143746202.3896.32.camel@dyn9047017067.beaverton.ibm.com> <p73r74i91sr.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p73r74i91sr.fsf@verdi.suse.de>; from ak@suse.de on Fri, Mar 31, 2006 at 03:33:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Fri, Mar 31, 2006 at 03:33:24PM +0200, Andi Kleen wrote:
> Mingming Cao <cmm@us.ibm.com> writes:
> > > Have you done tests _near_ 8TB with a 32-bit machine, even without these
> > > patches?
> > No I haven't. The >8TB right now is attached to a 64 bit machine, but we
> > should able to move it to a 32 bit machine.
> 
> If you use XFS or JFS as backing fs you can use a holey loop device
> to simulate it.  When I tried this last time JFS worked better for me.
> XFS doesn't seem to like that many extents as will be created by 
> mkfs.ext2.

Mainline has this issue resolved now (very recently, post-.16).

This (loopback on a local file) technique will get you up to 16TB
for 32 bit platforms, where you hit the unsigned long page->index
limit (but sounds like thats fine for the testing you're doing).

A related technique we've used in the past in testing XFS on large
devices (we've successfully tested in petabyte ranges using this,
on 64 bit systems of course) is to write a tool that modifies the
values in the ondisk data structures managing the "lower" areas of
the device to say "all the space here is used", which then forces
new allocations to be done in the "higher" parts of the device
address space.  Testing then follows this recipe: mkfs-on-loop,
then run the tool, then mount, then run the usual test suites ...
perhaps thats useful here too (I dunno if the ext2/3 format lends
itself to that or not).

cheers.

-- 
Nathan
