Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSELOEv>; Sun, 12 May 2002 10:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSELOEu>; Sun, 12 May 2002 10:04:50 -0400
Received: from boden.synopsys.com ([204.176.20.19]:18883 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S313477AbSELOEt>; Sun, 12 May 2002 10:04:49 -0400
Date: Sun, 12 May 2002 16:04:35 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT:  problem with select() and RH 7.3
Message-ID: <20020512140435.GC22916@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Ben Greear <greearb@candelatech.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CDDC194.7000405@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 06:12:52PM -0700, Ben Greear wrote:
> Appologies for an OT post, but I am hoping someone here will
> have an answer.
> 
> It appears that the select() call as found in RH 7.3 waits too
> long before it returns.  I come to this conclusion because I
> was dropping a large number of UDP packets when I allowed the
> select timeout to be > 0.   However, if I force the timeout to
> be zero in all cases, almost no packets are dropped (but the
> packet generator/receiver uses all of the CPU)  My traffic pattern
> is 10Mbps send + 10Mbps receive on 4 ports (of a DFE-570tx 4-port
> NIC, tulip driver), pkt size of 1200 to 1514.
> 
> If I understand select() correctly, it should work equally fast
> with a timeout of zero or 10 minutes, as long as the file descriptors
> are ready to be read from or written to.
> 
> I tried various kernels that I am sure have worked in the past,
> all with the same results.  The only thing I can think of is that
> somehow glibc or whatever implements select is wierd in RH 7.3
> (I'm installing RH 7.2 now to test that hypothesis.)

just try to exchange glibc

> One interesting observation that sheds a bit of doubt on blaming
> glibc is that when the timeout is > 0 (ie I'm dropping packets),
> the ethernet driver is not receiving as many packets as the
> sender is sending.  It also does not have any substantial amount
> of errors of any kind.  The ports are connected via a loopback cable,
> and all 4 ports exhibit this behaviour.  With a timeout of zero though,
> the send & receive counters are virtually identical.

...


Although that will not answer your question, just an idea, it will
certanly improve things alot:

if ( select(...) > 0 ) {
    ...
    for ( ;; ) {
	if ( read(fd, buffer, size) != size )
	    break;
	... do something with your packet ...
    }
}

Besides, select(2) cannot be "fast", look at poll(2), async io, or
just operate in blocking mode if your are in that critical timeline.
And lookup kernel archives about poll vs. select benchmarks to find
better explanation.


-alex

