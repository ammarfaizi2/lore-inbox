Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132033AbRA0ILs>; Sat, 27 Jan 2001 03:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132001AbRA0ILi>; Sat, 27 Jan 2001 03:11:38 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:17072 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131964AbRA0ILe>; Sat, 27 Jan 2001 03:11:34 -0500
Message-ID: <3A728475.34CF841@uow.edu.au>
Date: Sat, 27 Jan 2001 19:19:01 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A726087.764CC02E@uow.edu.au>,
		<3A726087.764CC02E@uow.edu.au>; from andrewm@uow.edu.au on Sat, Jan 27, 2001 at 04:45:43PM +1100 <20010126222003.A11994@vitelus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> 
> On Sat, Jan 27, 2001 at 04:45:43PM +1100, Andrew Morton wrote:
> > 2.4.1-pre10-vanilla, using read()/write():      34.5% CPU
> > 2.4.1-pre10+zercopy, using read()/write():      38.1% CPU
> 
> Am I right to be bothered by this?
> 
> The majority of Unix network traffic is handled with read()/write().
> Why would zerocopy slow that down?
> 
> If zerocopy is simply unoptimized, that's fine for now. But if the
> problem is inherent in the implementation or design, that might be a
> problem. Any patch which incurs a signifigant slowdown on traditional
> networking should be contraversial.

Good point.

The figures I quoted for the no-hw-checksum case were still
using scatter/gather.  That can be turned off as well and
it makes it a tiny bit quicker.  So the table is now:

2.4.1-pre10-vanilla, using sendfile():          29.6% CPU
2.4.1-pre10-vanilla, using read()/write():      34.5% CPU

2.4.1-pre10+zercopy, using sendfile():          18.2% CPU
2.4.1-pre10+zercopy, using read()/write():      38.1% CPU

2.4.1-pre10+zercopy, using sendfile():          22.9% CPU    * hardware tx checksums disabled
2.4.1-pre10+zercopy, using read()/write():      39.2% CPU    * hardware tx checksums disabled

2.4.1-pre10+zercopy, using sendfile():          22.4% CPU    * hardware tx checksums and SG disabled
2.4.1-pre10+zercopy, using read()/write():      38.5% CPU    * hardware tx checksums and SG disabled

But that's not relevant.

I just retested everything.  Yes, the zerocopy patch does
appear to decrease the efficiency of TCP on non-SG+checksumming
hardware by 5% - 10%.  Others need to test...


With an RTL8139/8139too.  CPU is 500MHz PII Celeron, uniprocessor:

2.4.1-pre10-vanilla, using sendfile():          43.8% CPU
2.4.1-pre10-vanilla, using read()/write():      54.1% CPU

2.4.1-pre10+zerocopy, using sendfile():         43.1% CPU
2.4.1-pre10+zerocopy, using read()/write():     55.5% CPU

Note that the 8139 only gets 10.8 Mbytes/sec here.  it randomly
jumps up to 11.5 occasionally, but spends most of its time at
10.8. Hard to know what to make of this.  Of course, if you're
using an 8139 you don't care about performance anyway :)


Contradictory results.  rtl8139 doesn't do Rx checksums,
and I think has an extra copy in the driver, so caching effects
may be obscuring things here.

I can test with eepro100 in a couple of days.


-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
