Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVBOKvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVBOKvw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 05:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVBOKvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 05:51:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:48561 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261675AbVBOKvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 05:51:22 -0500
Date: Tue, 15 Feb 2005 04:50:56 -0600
From: Robin Holt <holt@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Robin Holt <holt@sgi.com>, Ray Bryant <raybry@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Hugh DIckins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Marcello Tosatti <marcello@cyclades.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration -- sys_page_migrate
Message-ID: <20050215105056.GC19658@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com> <1108242262.6154.39.camel@localhost> <20050214135221.GA20511@lnx-holt.americas.sgi.com> <1108407043.6154.49.camel@localhost> <20050214220148.GA11832@lnx-holt.americas.sgi.com> <1108419774.6154.58.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108419774.6154.58.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 02:22:54PM -0800, Dave Hansen wrote:
> On Mon, 2005-02-14 at 16:01 -0600, Robin Holt wrote:
> > On Mon, Feb 14, 2005 at 10:50:42AM -0800, Dave Hansen wrote:
> > > On Mon, 2005-02-14 at 07:52 -0600, Robin Holt wrote:
> > > > The node mask is a list of allowed.  This is intended to be as near
> > > > to a one-to-one migration path as possible.
> > > 
> > > If that's the case, it would make the kernel internals a bit simpler to
> > > only take a "from" and "to" node, instead of those maps.  You'll end up
> > > making multiple syscalls, but that shouldn't be a problem.  
> > 
> > Then how do you handle overlapping nodes.  If I am doing a 5->4, 4->3,
> > 3->2, 2->1 shift in the memory placement and had only a from and to node,
> > I would end up calling multiple times.  This would end up in memory shifting
> > from 5->4 on the first, 4->3 on the second, ... with the end result of
> > all memory shifting to a single node.
> 
> Can you give an example of when you'd actually want to do this?

Assume it is moving from a 4,5,6,7,8,9 to 2,3,4,5,6,7 because it
wants to move jobs from nodes 8 and 9 which are topologically closer
to 10-15 and the job that was running there did not care about node
distances as much but nodes 2 and 3 were busy when the job was starting.
Batch schedulers will use machine in very interesting ways that you
would never have imagined.  Give it the freedom to move a job around,
any you will get some really interesting new behavior

Given that the first user of this may place in onto a 256 node system,
the chances that they use the same node in the source and destination node
array are very good.  If I focus on the word "actually" from above,I
can not give you a precise example of when this was asked for by a
user because this is in the early design phase as opposed to the late
troubleshooting phase.  Given the size of the machine we are dealing
with, it is certainly plausible that they will, at some time, ask to
migrate from and to an overlapping set of nodes.  I see this as even more
likely given that the decision will be made by their batch scheduler.
This example may be a bit simplistic, but there are certainly many times
where a batch scheduler decides that because of topology, it wants to
move stuff around some.

What is the fundamental opposition to an array from from-to node mappings?
They are not that difficult to follow.  They make the expensive traversal
of ptes the single pass operation.  The time to scan the list of from nodes
to locate the node this page belongs to is relatively quick when compared
to the time to scan ptes and will result in probably no cache trashing
like the long traversal of all ptes in the system required for multiple
system calls.  I can not see the node array as anything but the right way
when compared to multiple system calls.  What am I missing?


Thanks,
Robin
