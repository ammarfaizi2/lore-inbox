Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTJJKsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 06:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTJJKsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 06:48:30 -0400
Received: from holomorphy.com ([66.224.33.161]:16000 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262051AbTJJKsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 06:48:25 -0400
Date: Fri, 10 Oct 2003 03:50:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: YoshiyaETO <eto@soft.fujitsu.com>
Cc: Stuart Longland <stuartl@longlandclan.hopto.org>,
       linux-kernel@vger.kernel.org,
       Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
       Fabian.Frederick@prov-liege.be
Subject: Re: 2.7 thoughts
Message-ID: <20031010105021.GA727@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	YoshiyaETO <eto@soft.fujitsu.com>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	linux-kernel@vger.kernel.org,
	Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
	Fabian.Frederick@prov-liege.be
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010063039.GA700@holomorphy.com> <047b01c38f00$60b34840$6a647c0a@eto> <20031010074030.GB700@holomorphy.com> <04d501c38f0b$2864c210$6a647c0a@eto> <20031010090942.GC700@holomorphy.com> <053f01c38f18$f6212420$6a647c0a@eto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053f01c38f18$f6212420$6a647c0a@eto>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> arena. The two issues mentioned above are in reality non-issues.

On Fri, Oct 10, 2003 at 07:26:26PM +0900, YoshiyaETO wrote:
>     Could tell me what is the real issue you think?

Using reserved areas for kernel metadata marked as ZONE_HIGHMEM creates
two serious problems. First memory placement of kernel metadata is
disturbed, just like the "all kernel memory references are on node 0"
problem on ia32 NUMA. Second, it also inherits all of the workload
feasibility problems also seen on ia32 PAE. A third, less serious
problem is that the confusions between notions such as the capability
to do io to memory vs. placement in ZONE_HIGHMEM, the likely newly
introduced confusion between being able to directly access the data
in ZONE_HIGHMEM without establishing a new mapping (TLB entry) vs.
copying overheads etc., and the placement of some pinned/wired kernel
metadata like leaf pagetable nodes in ZONE_HIGHMEM, are all nasty
details conveniently left out of the quickly rattled-off zoning schemes
for inhibiting pinned/wired allocations from offlineable memory.

The first point explodes the entire theory of nodes coming on and off
line; the moment node-local kernel data is allowed, the entire zoning
scheme falls apart and the node can't be fully offlined at will as
envisioned at all.

The second point raises the further question of whether allowing the
zoning to get anywhere near 64-bit is even desirable; Linux tends to
want to consume all physical memory for kernel metadata as it pleases,
and confining it to small subsets of it has proved incompatible with
its design and/or the wishes of the kernel community in the past. The
general notions of process-local paged kernel metadata and the like
which would create some allowance for relocatable kernel metadata (or
in the PAE case, reduce pressure on lowmem) have been proposed before
and met heavy resistance. OTOH, certain things, like mem_map[] and
pgdats, could easily be made node-local as they would be torn down
when the node is offlined anyway.


-- wli

(The answers to the issues raised in the third point are all basically
API cleanups and the implementation of a thing that should have been in
the kernel to begin with.)
