Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUJHStC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUJHStC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUJHSsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:48:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:767 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265910AbUJHSrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:47:21 -0400
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Erich Focht <efocht@hpce.nec.com>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, Nick Piggin <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
In-Reply-To: <200410081214.20907.efocht@hpce.nec.com>
References: <1097110266.4907.187.camel@arrakis>
	 <200410081214.20907.efocht@hpce.nec.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097261158.5650.13.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 08 Oct 2004 11:45:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 03:14, Erich Focht wrote:
> Hi Matthew,

Hi Erich!


> On Thursday 07 October 2004 02:51, Matthew Dobson wrote:
> > 1) Rip out sched_groups and move them into the sched_domains.
> > 2) Add some reference counting, and eventually locking, to
> > sched_domains.
> > 3) Rewrite & simplify the way sched_domains are built and linked into a
> > cohesive tree.
> > 
> > This should allow us to support hotplug more easily, simply removing the
> > domain belonging to the going-away CPU, rather than throwing away the
> > whole domain tree and rebuilding from scratch.  This should also allow
> > us to support multiple, independent (ie: no shared root) domain trees
> > which will facilitate isolated CPU groups and exclusive domains.  I also
> > hope this will allow us to leverage the existing topology infrastructure
> > to build domains that closely resemble the physical structure of the
> > machine automagically, thus making supporting interesting NUMA machines
> > and SMT machines easier.
> 
> more flexibility in building the sched_domains is badly needed, so
> your effort towards providing this is the right step. I'm not sure
> yet whether your big change is really (and already) a simplification,
> but what you described sounded for me like getting the chance to
> configure the sched_domains at runtime, dynamically, from user
> space. I didn't notice any user interface in your patch, or overlooked
> it. Could you please describe the API you had in mind for that?

You are correct in your assumption that you didn't notice any user API
in the patch because it wasn't there.  The idea I had for the API would
be along the lines of the current cpusets/CKRM interface.  A
hierarchical filesystem where you can do operations to
create/modify/remove sched_domains.  Along the lines of:

cd /dev/sched_domains/sys_domain
mkdir node0
mkdir node1
mkdir node2
mkdir node3
cd node0
echo 0-3 > cpus
cd ../node1
echo 4-7 > cpus
cd ../node2
echo 8-11 > cpus
cd ../node3
echo 12-15 > cpus

To create a simple 4 node each w/ 4 cpus setup.  This is a trivial
example, because this is the kind of thing that would be setup by
default at boot time.  I really like the interface that Paul came up
with for cpusets, and I think that the interface we eventually settle on
should be along those lines.  Hopefully it can be shared with the
interface CKRM uses to avoid too much interface bloat.  I think that we
can probably get the two mechanisms to share a common interface.

-Matt



