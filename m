Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTLCDd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 22:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTLCDd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 22:33:59 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:49732 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264479AbTLCDdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 22:33:53 -0500
Date: Wed, 3 Dec 2003 14:32:29 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
Message-ID: <20031203143229.A1918624@wobbly.melbourne.sgi.com>
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de> <3FCB4CFA.4020302@backtobasicsmgmt.com> <20031201155143.GF12211@suse.de> <3FCC0EE0.9010207@backtobasicsmgmt.com> <20031202082713.GN12211@suse.de> <20031202211002.C2009778@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031202211002.C2009778@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Tue, Dec 02, 2003 at 09:10:02PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 09:10:02PM +1100, Nathan Scott wrote:
> On Tue, Dec 02, 2003 at 09:27:13AM +0100, Jens Axboe wrote:
> > On Mon, Dec 01 2003, Kevin P. Fleming wrote:
> > > 
> > > without device-mapper in place, though, and I could not reproduce the 
> > > problem! I copied > 500MB of stuff to the XFS filesystem created using 
> > > the entire /dev/md/0 device without a single unusual message. I then 
> > > unmounted the filesystem and used pvcreate/vgcreate/lvcreate to make a 
> > > 3G volume on the array, made an XFS filesystem on it, mounted it, and 
> > > tried copying data over. The oops message came back.
> > 
> > Smells like a bio stacking problem in raid/dm then. I'll take a quick
> > look and see if anything obvious pops up, otherwise the maintainers of
> > those areas should take a closer look.
> 
> One thing that might be of interest - XFS does tend to pass
> variable size requests down to the block layer, and this has
> tripped up md and other drivers in 2.4 in the distant past.
> 
> Log IO is typically 512 byte aligned (as opposed to block or
> page size aligned), as are IOs into several of XFS' metadata
> structures.

The XFS tests just tripped up a panic in raid5 in -test11 -- a kdb
stacktrace follows.  Seems to be reproducible, but not always the
same test that causes it.  And I haven't seen a double bio_put yet,
this first problem keeps getting in the way I guess.

Looks like its in a raid5 kernel thread, doing asynchronous stuff?,
so I don't really have any extra hints about what XFS was doing at
the time for y'all either.

cheers.

--
Nathan

XFS mounting filesystem md0
Unable to handle kernel paging request at virtual address d1c92c00
 printing eip:
c0387be6
*pde = 00048067
*pte = 11c92000
Oops: 0000 [#1]
CPU:    3
EIP:    0060:[<c0387be6>]    Not tainted
EFLAGS: 00010086
EIP is at handle_stripe+0xda6/0xef0
eax: f315df94   ebx: 00000000   ecx: 00000000   edx: f6d25ef8
esi: d1c92bfc   edi: d1c92bfc   ebp: f36d3f88   esp: f36d3ef8
ds: 007b   es: 007b   ss: 0068
Process md0_raid5 (pid: 1435, threadinfo=f36d2000 task=f684a9d0)
Stack: f6d25ef8 f2f84ebc f302e000 00000020 f2f84fc0 f7127000 f712760c f36d3f30
       f315de3c f7101ef8 00000000 00000000 f36d3f3c f315df68 c04fde00 f7f9a9d0
       f684a9d0 df449de8 00000000 f315df94 00000000 00000000 00000001 00000000
Call Trace:
 [<c0388173>] raid5d+0x73/0x120
 [<c039048c>] md_thread+0xbc/0x180
 [<c0118ef0>] default_wake_function+0x0/0x30
 [<c03903d0>] md_thread+0x0/0x180
 [<c010750d>] kernel_thread_helper+0x5/0x18

Code: 8b 56 04 8b 48 58 8b 58 5c 8b 06 83 c1 08 83 d3 00 39 da 72

Entering kdb (current=0xf684a9d0, pid 1435) on processor 3 Oops: Oops
due to oops @ 0xc0387be6
eax = 0xf315df94 ebx = 0x00000000 ecx = 0x00000000 edx = 0xf6d25ef8
esi = 0xd1c92bfc edi = 0xd1c92bfc esp = 0xf36d3ef8 eip = 0xc0387be6
ebp = 0xf36d3f88 xss = 0xc0390068 xcs = 0x00000060 eflags = 0x00010086
xds = 0xf6d2007b xes = 0x0000007b origeax = 0xffffffff &regs = 0xf36d3ec4
[3]kdb> bt
Stack traceback for pid 1435
0xf684a9d0     1435        1  1    3   R  0xf684ad00 *md0_raid5
EBP        EIP        Function (args)
0xf36d3f88 0xc0387be6 handle_stripe+0xda6 (0xf315dea0, 0x292, 0xf36d2000, 0xf5e90578, 0xf5e90580)
                               kernel <NULL> 0x0 0xc0386e40 0xc0387d30
0xf36d3fa4 0xc0388173 raid5d+0x73 (0xf6d25ef8, 0x0, 0xf36d2000, 0xf36d2000, 0xf36d2000)
                               kernel <NULL> 0x0 0xc0388100 0xc0388220
0xf36d3fec 0xc039048c md_thread+0xbc
                               kernel <NULL> 0x0 0xc03903d0 0xc0390550
           0xc010750d kernel_thread_helper+0x5
                               kernel <NULL> 0x0 0xc0107508 0xc0107520
[3]kdb>

