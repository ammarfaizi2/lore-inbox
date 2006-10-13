Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWJMVWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWJMVWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWJMVWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:22:10 -0400
Received: from rune.pobox.com ([208.210.124.79]:38867 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S932075AbWJMVWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:22:09 -0400
Date: Fri, 13 Oct 2006 16:22:02 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Cc: Christoph Lameter <clameter@sgi.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
Message-ID: <20061013212202.GG28620@localdomain>
References: <1160764895.11239.14.camel@farscape> <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com> <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160773040.11239.28.camel@farscape>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Schmidt wrote:
> On Fri, 2006-13-10 at 14:53 -0500, Will Schmidt wrote:
> > On Fri, 2006-13-10 at 12:05 -0700, Christoph Lameter wrote:
> > > On Fri, 13 Oct 2006, Will Schmidt wrote:
> > > 
> > > >     Am seeing a crash on a power5 LPAR when booting the linux-2.6 git
> > > > tree.  It's fairly early during boot, so I've included the whole log
> > > > below.   This partition has 8 procs, (shared, including threads), and
> > > > 512M RAM.  
> > > 
> > > This looks like slab bootstrap. You are bootstrapping while having 
> > > zonelists build with zones that are only going to be populated later? 
> > > This will lead to incorrect NUMA placement of lots of slab structures on 
> > > bootup.
> > 
> > I dont think so..   but it's not an area I'm very familiar with.   one
> > of the other PPC folks might chime in with something here.  
> > 
> > > 
> > > Check if the patch below may cure the oops. Your memory is likely 
> > > still placed on the wrong numa nodes since we have to fallback from 
> > > the intended node.
> > 
> > Nope, no change with this patch.
> > 
> 
> Here is another boot log, with that patch applied, and with a numa=debug
> parm. 
> 
> -----------------------------------------------------
> ppc64_pft_size                = 0x18
> physicalMemorySize            = 0x22000000
> ppc64_caches.dcache_line_size = 0x80
> ppc64_caches.icache_line_size = 0x80
> htab_address                  = 0x0000000000000000
> htab_hash_mask                = 0x1ffff
> -----------------------------------------------------
> Linux version 2.6.19-rc1-gb8a3ad5b-dirty (willschm@airbag2) (gcc version
> 4.1.0 (SUSE Linux)) #60 SMP Fri Oct 13 14:48:20 CDT 2006
> [boot]0012 Setup Arch
> NUMA associativity depth for CPU/Memory: 3
> adding cpu 0 to node 0
> node 0
> NODE_DATA() = c000000015ffee80
> start_paddr = 8000000
> end_paddr = 16000000
> bootmap_paddr = 15ffc000
> reserve_bootmem ffc0000 40000
> reserve_bootmem 15ffc000 2000
> reserve_bootmem 15ffee80 1180
> node 1
> NODE_DATA() = c000000021ff7c80
> start_paddr = 0
> end_paddr = 22000000

Strange, node 0 appears to be in the middle of node 1.
