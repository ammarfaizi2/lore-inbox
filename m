Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUATDSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 22:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUATDSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 22:18:50 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:3814 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263762AbUATDSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 22:18:48 -0500
Date: Mon, 19 Jan 2004 21:12:22 -0600
From: Jack Steiner <steiner@sgi.com>
To: mbligh@aracnet.com, jes@trained-monkey.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
Message-ID: <20040120031222.GA15435@sgi.com>
References: <E1AiZ5h-00043I-00@jaguar.mkp.net> <4990000.1074542883@[10.10.2.4]> <20040119224535.GA12728@sgi.com> <20040120022452.GA27294@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120022452.GA27294@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 06:24:52PM -0800, Jesse Barnes wrote:
> On Mon, Jan 19, 2004 at 04:45:35PM -0600, Jack Steiner wrote:
> > On Mon, Jan 19, 2004 at 12:08:04PM -0800, Martin J. Bligh wrote:
> > > > Since we now support # of CPUs > BITS_PER_LONG with cpumask_t it would
> > > > be nice to be able to support more than BITS_PER_LONG memory blocks.
> > > 
> > > Nothing uses them. We're probably better off just removing them altogether.
> > 
> > I dont understand.
> > node_memblk[] is used on IA64 in arch/ia64/mm/discontig.c (& other places too).
> 
> I think Martin is referring to the memblk_*line() functions and the fact
> that memblks are exported via sysfs to userspace.  That API hasn't
> proven very useful so far since it's really waiting for memory hot
> add/remove.  Of course, we'll still need structures to support that for
> the low level arch specific discontig code, so any patch that killed
> memblks in sysfs and elsewhere would have to take that into account...
> (In particular, node_memblk[] is filled out by the ACPI SRAT parsing
> code and use for discontig init and physical->node id conversion.)
> 
> Jesse

OK, that makes sense.


BTW, I think SN2 has a brain-dead definition of node_memblk[]. It currently works 
but I think it is incorrect & should probably be fixed before we get into
trouble. 

On SN2, memory blocks that ACTUAL EXIST are described via the EFI tables. 
This EFI table describes memory that is put into the VM tables.

The SRAT tables that are used to build the node_memblks array dont describe
actual memory.  The SRAT (on SN2) describes the way hardware could potentially map 
physical memory to nodes. A memblk entry will cover non-existant memory.

For example.  For one node with max memory (assume 512MB dimms)
	- each node has 4 discontiguous blocks of memory.
	- actual memory on node exists at these node offsets:
	 	0-2GB
		16-18GB
		32-24GB
		48-50GB
	- These ranges are described by the EFI tables
	- the SRAT (& node_memblk) has a SINGLE entry to describe the entire node:
		memblk = 0-64GB 
	  Note that this entry covers non-existent memory


I believe SN2 should use 4 SRAT entries - one entry for each block of memory
that actually exists. 
	 	
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


