Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSG2I5S>; Mon, 29 Jul 2002 04:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSG2I5S>; Mon, 29 Jul 2002 04:57:18 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:21800 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S313711AbSG2I5R>; Mon, 29 Jul 2002 04:57:17 -0400
Date: Mon, 29 Jul 2002 10:00:11 +0100
To: Ben Rafanello <benr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020729090011.GA2581@fib011235813.fsnet.co.uk>
References: <OF6180310A.A3D14E1B-ON85256C02.004FB178@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6180310A.A3D14E1B-ON85256C02.004FB178@pok.ibm.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 11:12:15AM -0500, Ben Rafanello wrote:
> Much
> like snapshots and their cow tables, the changed blocks bitmap must
> be updated and written to disk before a block is modified.

Agreed dirty region logging will be handled directly by the in kernel
mirror target, in the same way that the snapshot exception table is
handled by the snapshot target.

I guess when I think of metadata I'm really thinking of the mappings
that describe whole volumes, rather than any internal data that a
particular target may use.  I think this is an appropriate divide,
presumably EVMS stores the dirty bitmap for a mirror in the same way
irrespective of whether the volume group metadata is in AIX or LVM1
format ?

> On the facility used to notify userland processes of events, how
> are the userland programs notified?

There are 2 ioctls, one which gets the status for all the targets in a
device, and another that blocks until that status changes.  It is up
to the target implementor to decide what is returned in the status,
and to declare when this status has changed.

So you will need a daemon if you are waiting for an event.  For
instance pvmove needs no additional kernel code to be implemented,
instead it just uses a mirror target to keep the old and new mappings
in sync.  When the mirrors initial sync has been completed pvmove
notices the change in status, removes the mirror and updates the
device to use the new mapping.

- Joe
