Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWIVCbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWIVCbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWIVCbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:31:05 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:17582 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932217AbWIVCbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:31:02 -0400
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
	kernel BUG at mm/slab.c:2698!
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Christoph Lameter <clameter@engr.sgi.com>
In-Reply-To: <1158888843.5657.44.camel@keithlap>
References: <1158884252.5657.38.camel@keithlap>
	 <20060921174134.4e0d30f2.akpm@osdl.org> <1158888843.5657.44.camel@keithlap>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 21 Sep 2006 19:31:00 -0700
Message-Id: <1158892260.5657.60.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 18:34 -0700, keith mannthey wrote:
> On Thu, 2006-09-21 at 17:41 -0700, Andrew Morton wrote:
> > On Thu, 21 Sep 2006 17:17:31 -0700
> > keith mannthey <kmannth@us.ibm.com> wrote:
> > 
> > > I wanted to just give 2.6.18 a spin and I tripped over something I
> > > didn't expect. 
> > > 
> > > 
> > > cpu_up: attempt to bring up CPU 4 failed
> > > kfree_debugcheck: bad ptr c15f6000h.
> > > ------------[ cut here ]------------
> > > kernel BUG at mm/slab.c:2698!
> > > invalid opcode: 0000 [#1]
> > > SMP
> > > Modules linked in:
> > > CPU:    0
> > > EIP:    0060:[<c106ce51>]    Not tainted VLI
> > > EFLAGS: 00010046   (2.6.18 #1)
> > > EIP is at kfree_debugcheck+0x7f/0x90
> > > eax: 00000028   ebx: 000015f6   ecx: c1025289   edx: c7653540
> > > esi: c15f6000   edi: c15f6000   ebp: c764af38   esp: c764af28
> > > ds: 007b   es: 007b   ss: 0068
> > > Process swapper (pid: 1, ti=c764a000 task=c7653540 task.ti=c764a000)
> > > Stack: c122c68d c15f6000 c1635000 00000004 c764af5c c106ef93 00000286
> > > c76a77d0
> > >        00000004 00000001 c1635000 00000004 00000004 c764af6c c10557f6
> > > c1274eac
> > >        c12743dc c764af84 c1207467 00000004 c12734c0 00000004 00000004
> > > c764af98
> > > Call Trace:
> > >  [<c106ef93>] kfree+0x24/0x1d8
> > >  [<c10557f6>] pageset_cpuup_callback+0x40/0x58
> > >  [<c1207467>] notifier_call_chain+0x20/0x31
> > >  [<c1031530>] blocking_notifier_call_chain+0x1d/0x2d
> > >  [<c103f80c>] cpu_up+0xb5/0xcf
> > >  [<c1000372>] init+0x78/0x296
> > >  [<c1002005>] kernel_thread_helper+0x5/0xb
> > 
> > I think we have two problems here:
> > 
> > a) CPU4 didn't come up.  To diagnose that I think we'll need to ask you
> >    to into cpu_up(), add debug printks to blocking_notifier_call_chain(),
> >    work out which entry on that chain returned NOTIFY_BAD, then work out
> >    why it did so.
> 
> That unhappy caller in the chain is cpuup_callback in mm/slab.c.  I am
> still working out as to why, there is a lot going on if this function. 

I think is is an odd NUMA case.  The kernel is NUMA but it boots with
only 1 node (even though there are 2) I don't think the vm is getting
setup correctly in the i386 faking node code or some logic with respect
to i386 numa in this situation. 

I applied one of the patches I need to see the SRAT with 
(I will send this along in a proper email shortly) 

Which caused there to be 2 nodes in the system and I didn't panic during
boot. 

So works
  CONFIG_NUMA with 2 nodes srat discovering 

Number of logical nodes in system = 2
Number of memory chunks in system = 2
chunk 0 nid 0 start_pfn 00000000 end_pfn 000f0000
chunk 1 nid 0 start_pfn 00100000 end_pfn 001d0000
Node: 0, start_pfn: 0, end_pfn: 1900544
Node: 1, start_pfn: 0, end_pfn: 0
Reserving 24576 pages of KVA for lmem_map of node 0
Shrinking node 0 from 1900544 pages to 1875968 pages
Reserving 0 pages of KVA for lmem_map of node 1
Shrinking node 1 from 0 pages to 0 pages
Reserving total of 24576 pages for numa KVA remap
reserve_pages = 24576 find_max_low_pfn() ~ 229376
max_pfn = 1900544
6624MB HIGHMEM available.
800MB LOWMEM available.
min_low_pfn = 5685, max_low_pfn = 204800, highstart_pfn = 204800

(Yea there in no memory in the 2nd node but it still boots) 

  CONFIG_NUMA with 2 nodes but srat aborting the numa Discover and 


failed to get NUMA memory information from SRAT table
NUMA - single node, flat memory mode
Node: 0, start_pfn: 0, end_pfn: 156
Node: 0, start_pfn: 256, end_pfn: 982929
Node: 0, start_pfn: 1048576, end_pfn: 1900544
Node: 0, start_pfn: 0, end_pfn: 1900544
Reserving 512 pages of KVA for lmem_map of node 0
Shrinking node 0 from 1900544 pages to 1900032 pages
Reserving total of 512 pages for numa KVA remap
reserve_pages = 512 find_max_low_pfn() ~ 229376
max_pfn = 1900544
6530MB HIGHMEM available.
894MB LOWMEM available.
min_low_pfn = 5685, max_low_pfn = 228864, highstart_pfn = 228864

Hmm this puts us into a situation where the VM thinks there is 1 node
but the cpus think there are 2.  I am guessing this it the main issue
and the source of the panic. 


Thanks,
  Keith 

