Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVC2I4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVC2I4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVC2Iwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:52:40 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:25500 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262222AbVC2IuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:50:25 -0500
Date: Tue, 29 Mar 2005 00:49:15 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: johnpol@2ka.mipt.ru
Cc: guillaume.thouvenin@bull.net, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050329004915.27cd0edf.pj@engr.sgi.com>
In-Reply-To: <1112079856.5243.24.camel@uganda>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112079856.5243.24.camel@uganda>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy wrote:
> There is no overhead at all using CBUS.

This is unlikely.  Very unlikely.

Please understand that I am not trying to critique CBUS or connector in
isolation, but rather trying to determine what mechanism is best suited
for getting this accounting data written to disk, which is where I
assume it has to go until some non-real time job gets around to
analyzing it.  We already have the rest of the BSD Accounting
information taking this batched up path directly to the disk.  There is
nothing (that I know of) to be gained from delivering this new fork data
with any higher quality of service, or to any other place.

>From what I can understand, correct me if I'm wrong, we have two
alternatives in front of us (ignoring relayfs for a second):

 1) Using fork_connector (presumably soon to include use of CBUS):
	- forking process enqueues data plus header for single fork
	- context switch
	- daemon process dequeues single fork data (is this a read or recv?)
	- daemon process mergers multiple fork data into single buffer
	- daemon process writes buffer for multiple forks (a write)
	- disk driver pushes buffer with data for multiple forks to disk

 2) Using a modified form of what BSD ACCOUNTING does now:
	- forking process appends single fork data to in-kernel buffer
	- disk driver pushes buffer with data for multiple forks to disk

It seems to me to be rather unlikely that (1) is cheaper than (2).  It
is no particular fault of connector or CBUS that this is so.  Even if
there were no overhead at all using CBUS (which I don't believe), (1)
still costs more, because it passes the data, with an added packet
header, into a separate process, and into user space, before it is
combined with other accounting information, and written back down into
the kernel to go to the disk.


> > ... The efficiency
> > of getting this one extra <parent-pid, child-pid> out of the kernel
> > seems to be one or two orders of magnitude worse than the rest of
> > the accounting data.
> 
> It can be easily changed.
> One may send kernel/acct.c acct_t structure out of the kernel - 
> overhead will be the same: kmalloc probably will get new area from the
> same 256-bytes pool, skb is still in cache.

I have no idea what you just said.


> File writing accounting [kernel/acct.c] is slower,

Sure file writing is slower than queuing on an internal list.  I don't
care that getting the data where I want it is slower than getting it
some other place that's only part way.


> and requires process' context to work with system calls.

For some connector uses, that might matter.  For hooks in fork,
that is no problem - we have all the process context one could
want - two of them if that helps ;).


> realyfs is interesting project, but it has different aims, 

That could well be ... I can't claim to know which of relayfs or
connector would be better here, of the two.


> while connector is purely control/notification mechanism

However connector is, in this regard, overkill.  We don't need a single
event notification mechanism here.  One of the key ways in which
accounting such as this has historically minimized system load is to
forgo any effort to provide any notification or data packet per event,
and instead immediately work to batch the data up in bulk form, with one
buffer containing the concatenated data for multiple events.  This
amortizes the cost of almost all the handling, and of all the disk i/o,
over many data collection events.  Correct me if I'm wrong, but
fork_connector doesn't do this merging of events into a consolidated
data buffer, so is at a distinct disadvantage, for this use, because the
data merging is delayed, and a separate, user level process, is required
to accomplish the merging and conversion to writable blocks of data
suitable for storing on the disk.

Nothing wrong with a good screwdriver.  But if you want to pound nails,
hammers, even rocks, work better.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
