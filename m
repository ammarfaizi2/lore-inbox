Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWGJIsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWGJIsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWGJIsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:48:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51516 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751372AbWGJIsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:48:04 -0400
Date: Mon, 10 Jul 2006 10:50:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: lcapitulino@mandriva.com.br, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, akpm@osdl.org, michael.kerrisk@gmx.net
Subject: Re: splice/tee bugs?
Message-ID: <20060710085036.GK4141@suse.de>
References: <20060709103606.GU4188@suse.de> <20060709111629.GV4188@suse.de> <20060709134703.0aa5bc41@home.brethil> <20060709175744.GZ4188@suse.de> <20060710062551.307040@gmx.net> <20060710064355.GB4141@suse.de> <20060710080917.286970@gmx.net> <20060710082423.GI4141@suse.de> <20060710084017.109310@gmx.net> <20060710084645.GJ4141@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710084645.GJ4141@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10 2006, Jens Axboe wrote:
> On Mon, Jul 10 2006, Michael Kerrisk wrote:
> > > > One slight strangeness.  Most of the time, the 
> > > > "find . | ktee r | wc" command line takes about 0.1 seconds to 
> > > > execute, but about 1 time in 5 on my x86 system, it takes about 
> > > > 1.5 to 2 seconds to execute.  Any ideas about what's happening 
> > > > there?
> > > 
> > > That is pretty odd. Any chance you can do a quick sysrq-t and see where
> > > find/ktee/wc is stuck when this happens? You should not be seeing that,
> > > naturally, I'll see if I can reproduce that here. How much data does
> > > find . return in your example?
> > 
> > See the start of this message.
> > 
> > One sysrq-t output output below.
> > 
> > Cheers,
> > 
> > Michael
> > 
> > 
> > find          D B9099C00     0 14170   4167         14171       (NOTLB)
> >    ca279d04 00118054 00000008 b9099c00 003d0ca2 e7b0b9f8 00000009 d307f688
> >    d307f580 c0459dc0 c1507620 b9099c00 003d0ca2 00000000 00000000 00118054
> >    00000001 00001000 c015010e e647f5ac e647f5b8 00000046 00000000 00000000
> > Call Trace:
> >  <c015010e> __getblk+0x1d/0x225
> >  <c03e1e7c> io_schedule+0x26/0x30
> >  <c0150874> sync_buffer+0x37/0x3a
> >  <c03e25fd> __wait_on_bit+0x33/0x59
> >  <c015083d> sync_buffer+0x0/0x3a
> >  <c03e2695> out_of_line_wait_on_bit+0x72/0x7a
> >  <c015083d> sync_buffer+0x0/0x3a
> >  <c0127dd5> wake_bit_function+0x0/0x34
> >  <c019e39b> search_by_key+0x133/0xd91
> >  <c0110a1c> do_page_fault+0x0/0x532
> >  <c0189e2d> search_by_entry_key+0x20/0x22f
> >  <c015dc76> filldir64+0x8e/0xc3
> >  <c019e214> pathrelse+0x1b/0x2f
> >  <c019388c> reiserfs_readdir+0x3e3/0x3fb
> >  <c0193895> reiserfs_readdir+0x3ec/0x3fb
> >  <c018d6e5> reiserfs_update_sd_size+0x67/0x24c
> >  <c01a55c9> journal_begin+0x9c/0xdc
> >  <c0196cb0> reiserfs_dirty_inode+0x5a/0x76
> >  <c016bacc> __mark_inode_dirty+0x2d/0x15e
> >  <c015dd9a> vfs_readdir+0x58/0x6f
> >  <c015de14> sys_getdents64+0x63/0xa8
> >  <c015dbe8> filldir64+0x0/0xc3
> >  <c010287f> syscall_call+0x7/0xb
> 
> So it's find being stuck, this doesn't look tee/splice related at all.
> Can you reproduce the same thing just by doing the find . > /dev/null?

I think you found an unrelated bug, I can reproduce the same thing with
just find . > /dev/null here:

centera:/data1 # time find . > /dev/null

real    0m0.206s
user    0m0.009s
sys     0m0.196s
centera:/data1 # time find . > /dev/null

real    0m0.205s
user    0m0.008s
sys     0m0.198s
centera:/data1 # time find . > /dev/null

real    0m0.205s
user    0m0.012s
sys     0m0.194s
centera:/data1 # time find . > /dev/null

real    0m0.836s
user    0m0.011s
sys     0m0.194s

It's pretty close to 0.2 seconds most of the time, sometimes find takes
more than 1 second to complete though. Even nice'ing find to -20
reproduces the same thing.

-- 
Jens Axboe

