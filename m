Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130460AbRA3OvZ>; Tue, 30 Jan 2001 09:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131008AbRA3OvO>; Tue, 30 Jan 2001 09:51:14 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:8913 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130460AbRA3OvK>; Tue, 30 Jan 2001 09:51:10 -0500
Message-ID: <3A76D6A4.2385185E@uow.edu.au>
Date: Wed, 31 Jan 2001 01:58:44 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A76B72D.2DD3E640@uow.edu.au>,
		<3A728475.34CF841@uow.edu.au>
		<3A726087.764CC02E@uow.edu.au>
		<20010126222003.A11994@vitelus.com>
		<14966.22671.446439.838872@pizda.ninka.net>
		<3A76B72D.2DD3E640@uow.edu.au> <14966.47384.971741.939842@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Andrew Morton writes:
>  > BTW: can you suggest why I'm not observing any change in NFS client
>  > efficiency?
> 
> As in "filecopy speed" or "cpu usage while copying a file"?
> 
> The current fragmentation code eliminates a full SKB allocation and
> data copy on the NFS file data receive path in the client, CPU has to
> be saved compared to pre-zerocopy or something is very wrong.
> 
> File copy speed, well you should be link speed limited as even without
> the zerocopy patches you ought to have enough cpu to keep it busy.
> 

Mount the server rsize=wsize=8192.  `cp' a 102,400,000 byte file
from the NFS server to /dev/null.  The file is fully cached on
the server.  unmount and remount the server between runs
to eliminate client caching. The copy takes 8.654 seconds.  That's
11.8 megabytes/sec.

Client is 2.4.1-vanilla:                   29.8% CPU
Client is 2.4.1-zc:                        28.2% CPU
Client is 2.4.1-zc, non-SG+xsum NIC:       27.7% CPU

So I was mistaken - there is an improvement. (A 2% CPU
change is easily measurable with this setup).

It may be a little better than this - cyclesoak I think
will underestimate the benefit of saving on memory traffic.
It only generates 10,000 cacheline writebacks per second per
CPU.  But winding it up to 80,000 doesn't affect the above
figures much at all.

The box has 130 mbyte/sec memory write bandwidth, so saving
a copy should save 10% of this.   (Wanders away, scratching
head...)

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
