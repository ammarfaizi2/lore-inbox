Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284500AbRLERJP>; Wed, 5 Dec 2001 12:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284506AbRLERJF>; Wed, 5 Dec 2001 12:09:05 -0500
Received: from adsl-64-168-153-221.dsl.snfc21.pacbell.net ([64.168.153.221]:27525
	"EHLO unifiedcomputing.com") by vger.kernel.org with ESMTP
	id <S284500AbRLERI5>; Wed, 5 Dec 2001 12:08:57 -0500
Message-Id: <4.2.2.20011205085135.00ab0e88@slither>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.2.2 
Date: Wed, 05 Dec 2001 08:59:45 -0800
To: Kurt Roeckx <Q@ping.be>, Tim Hockin <thockin@sun.com>
From: Steve Parker <sparker@sparker.net>
Subject: Re: [PATCH] eepro100 - need testers
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, saw@sw-soft.com
In-Reply-To: <20011205022610.A757@ping.be>
In-Reply-To: <3C0D54DF.4E897B70@sun.com>
 <E167w6n-0001dz-00@fenrus.demon.nl>
 <3C0D54DF.4E897B70@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:26 PM 12/4/2001 , Kurt Roeckx wrote:
>On Tue, Dec 04, 2001 at 02:57:35PM -0800, Tim Hockin wrote:
> > -#define TX_RING_SIZE 32
> > -#define RX_RING_SIZE 32
> > +#define TX_RING_SIZE 64
> > +#define RX_RING_SIZE 1024
>
>Why do I have the feeling that you're just changing those values
>so you get less chance of having the problem?  Are there any
>other reason why you change this?  It might even be a good idea
>to test it with lower values.

If you test with lower values, I find that the problem happens so often that
bidirectional TCP bulk throughput tests on 100Mbits/sec ethernet are 
significantly
lower.  As Tim pointed out, the RX ring size is chosen based on being large 
enough
to receive steadily and only require the ISR to come by and empty it once 
every jiffy.
In order to provide good performance and survivability on maximum packet 
rate loads,
it needs to be 1024, although it's moderately good on 512, on my 300MHz K6 
system.



> > -                     } else if ((status & 0x003c) == 0x0008) { /* No 
> resources. */
> > -                             struct RxFD *rxf;
> > -                             printk(KERN_WARNING "%s: card reports no 
> resources.\n",
> > -                                             dev->name);
>
>[...]
>
> > +             switch ((status >> 2) & 0xf) {
> > +             case 0: /* Idle */
> > +                     break;
> > +             case 1: /* Suspended */
> > +             case 2: /* No resources (RxFDs) */
> > +             case 9: /* Suspended with no more RBDs */
> > +             case 10: /* No resources due to no RBDs */
> > +             case 12: /* Ready with no RBDs */
> > +                     speedo_rx_soft_reset(dev);
> > +                     break;
>
>You can also argue that you're trying to fix the problem by
>hiding it.  It would be useful that it still reported the same
>error message, so you can see that if it happens again with the
>patch that it no longer locks up.

The printk significantly reduces TCP throughput on my tests, it doesn't tell me
about an interesting condition, so I removed it.  This state happens any 
time the chip receives
more than a ring buffer full before the ISR can empty it, which is 
something which
is always possible.

And any way, why would you care to know?  Is there something you'ld imagine
doing because you saw the message?


Cheers,

	~sparker

