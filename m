Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291660AbSBAKEI>; Fri, 1 Feb 2002 05:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291661AbSBAKD6>; Fri, 1 Feb 2002 05:03:58 -0500
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:7949 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S291660AbSBAKDy>; Fri, 1 Feb 2002 05:03:54 -0500
Date: Thu, 31 Jan 2002 13:09:13 +0000
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Joe Thornber <thornber@fib011235813.fsnet.co.uk>, lvm-devel@sistina.com,
        Jim McDonald <Jim@mcdee.net>, Andreas Dilger <adilger@turbolabs.com>,
        linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [linux-lvm] Re: [lvm-devel] [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020131130913.A8997@fib011235813.fsnet.co.uk>
In-Reply-To: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com> <20020131125211.A8934@fib011235813.fsnet.co.uk> <20020201045518.A10893@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201045518.A10893@devserv.devel.redhat.com>; from arjanv@redhat.com on Fri, Feb 01, 2002 at 04:55:18AM -0500
From: Joe Thornber <thornber@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 04:55:18AM -0500, Arjan van de Ven wrote:
> There is one thing that might spoil the device-mapper "just simple stuff
> only" thing: moving active volumes around. Doing that in userspace reliably
> is impossible and basically needs to be done in kernelspace (it's an
> operation comparable with raid1 resync, a not even that hard in kernel
> space). However, that sort of automatically requires kernelspace to know
> about volumes, and from there it's a small step....

I think you're talking about pvmove and friends, in which case I hope
the description below helps.

- Joe



Let's say we have an LV, made up of three segments of different PV's,
I've also added in the device major:minor as this will be useful
later:

+-----------------------------+
|  PV1     |   PV2   |   PV3  | 254:3
+----------+---------+--------+


Now our hero decides to PV move PV2 to PV4:

1. Suspend our LV (254:3), this starts queueing all io, and flushes
   all pending io.  Once the suspend has completed we are free to change
   the mapping table.

2. Set up *another* (254:4) device with the mapping table of our LV.

3. Load a new mapping table into (254:3) that has identity targets for
   parts that aren't moving, and a mirror target for parts that are.

4. Unsuspend (254:3)

So now we have:
                           destination of copy
               +--------------------->--------------+
               |                                    |
+-----------------------------+               + -----------+
| Identity | mirror  | Ident. | 254:3         |    PV4     |
+----------+---------+--------+               +------------+
     |         |         |
     \/        \/        \/
+-----------------------------+
|  PV1     |   PV2   |   PV3  | 254:4
+----------+---------+--------+

Any writes to segment2 of the LV get intercepted by the mirror target
who checks that that chunk has been copied to the new destination, if
it hasn't it queues the initial copy and defers the current io until
it has finished.  Then the current io is written to *both* PV2 and the
PV4.

5. When the copying has completed 254:3 is suspended/pending flushed.

6. 254:4 is taken down

7. metadata is updated on disk

8. 254:3 has new mapping table loaded:

+-----------------------------+
|  PV1     |   PV4   |   PV3  | 254:3
+----------+---------+--------+

