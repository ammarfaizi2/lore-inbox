Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131522AbRA3X1Y>; Tue, 30 Jan 2001 18:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132653AbRA3X1O>; Tue, 30 Jan 2001 18:27:14 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:52976 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131522AbRA3X1G>; Tue, 30 Jan 2001 18:27:06 -0500
Message-ID: <3A774F92.B0F20608@uow.edu.au>
Date: Wed, 31 Jan 2001 10:34:42 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A76D6A4.2385185E@uow.edu.au>,
			<3A76B72D.2DD3E640@uow.edu.au>
			<3A728475.34CF841@uow.edu.au>
			<3A726087.764CC02E@uow.edu.au>
			<20010126222003.A11994@vitelus.com>
			<14966.22671.446439.838872@pizda.ninka.net>
			<14966.47384.971741.939842@pizda.ninka.net>
			<3A76D6A4.2385185E@uow.edu.au> <14967.16395.42967.978677@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Andrew Morton writes:
>  > The box has 130 mbyte/sec memory write bandwidth, so saving
>  > a copy should save 10% of this.   (Wanders away, scratching
>  > head...)
> 
> Are you sure your measurment program will account properly
> for all system cycles spent in softnet processing?  This is
> where the bulk of the cpu cycle savings will occur.
> 

It tries to. It runs n_cpus instances of this:

static void busyloop(int instance)
{
        int idx;

        for ( ; ; ) {
                for (idx = 0; idx < busyloop_size; idx++) {
                        int thumb;

                        busyloop_buf[idx]++;                    /* Dirty a cacheline */
                        for (thumb = 0; thumb < 200; thumb++)
                                ;                               /* twiddle */
                        busyloop_progress[instance * CACHE_LINE_SIZE]++;
                }
        }
}

At minimum priority.

And it measures how much these threads are slowed
down, wrt an unloaded system. So interrupt work
is definitely accounted for.

It needs work.  It should walk the buffer in cacheline-sized
strides, should have tunable read-versus-write ratios, should
be scheduled with `idle' priority, should be bondable
to CPUs and should create PCI traffic.  That means a in-kernel
implementation.

But tweaking this thing thus far has made only very small
differences in output.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
