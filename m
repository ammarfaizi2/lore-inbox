Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRLIBSF>; Sat, 8 Dec 2001 20:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281017AbRLIBR4>; Sat, 8 Dec 2001 20:17:56 -0500
Received: from shell.cyberus.ca ([216.191.240.114]:20219 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S280984AbRLIBRp>;
	Sat, 8 Dec 2001 20:17:45 -0500
Date: Sat, 8 Dec 2001 20:14:10 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: bert hubert <ahu@ds9a.nl>
cc: <lartc@mailman.ds9a.nl>, <linux-kernel@vger.kernel.org>,
        <kuznet@ms2.inr.ac.ru>, <netdev@oss.sgi.com>
Subject: Re: CBQ and all other qdiscs now REALLY completely documented
 (almost!)
In-Reply-To: <20011209002344.C20125@outpost.ds9a.nl>
Message-ID: <Pine.GSO.4.30.0112081841050.4764-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001, bert hubert wrote:

> On Sat, Dec 08, 2001 at 02:20:20PM -0500, jamal wrote:
>
> > Linux remaps packets incoming with different values to some internal
> > value; the colum "mapped to" shows the internal mapping
> >
> > 8value(hex)   TOS(dec) mapped to(dec)
> > ----------------------------------
> > 0x0              0      0
> >                  1      7
> >                  2      0
> >                  3      0
> >                  4      2
> >                  5      2
> >                  6      2
> >                  7      2
> > 0x10             8      6
> >                  9      6
> >                 10      6
> >                 11      6
> >                 12      2
> >                 13      2
> >                 14      2
> >                 15      2
>
> I find this tos2prio table in the kernel (2.5.x), which is somewhat
> different than your table:
>
> 0        TC_PRIO_BESTEFFORT,     0
> 1        TC_PRIO_(FILLER),       1
> 2        TC_PRIO_BESTEFFORT,     0
> 3        TC_PRIO_(BESTEFFORT),   0
> 4        TC_PRIO_BULK,           2
> 5        TC_PRIO_(BULK),         2
> 6        TC_PRIO_BULK,           2
> 7        TC_PRIO_(BULK),         2
> 8        TC_PRIO_INTERACTIVE,    6
> 9        TC_PRIO_(INTERACTIVE),  6
> 10       TC_PRIO_INTERACTIVE,    6
> 11       TC_PRIO_(INTERACTIVE),  6
> 12       TC_PRIO_INTERACTIVE_BULK,       4
> 13       TC_PRIO_(INTERACTIVE_BULK),     4
> 14       TC_PRIO_INTERACTIVE_BULK,       4
> 15       TC_PRIO_(INTERACTIVE_BULK)      4
>
>
> > Fill in the  "8value(hex)" column gaps using the bitmap from RFC1349 for
> > the 8 bits; These are the values ou would see with tcpdump -vvv
> > I filled the two easiest ones i could compute in my head.
> >
> > Second step:
> >
> > Take the default priority map:
> >  1, 2, 2, 2, 1, 2, 0, 0 , 1, 1, 1, 1, 1, 1, 1, 1
> > This applies for both default prio and the 3-band FIFO queue.
> > Note the queue map fitted on the last column
> >
> > 8 but value     TOS     mapped to   queue map
> > ---------------------------------------------
> > 0x0              0      0              1
> >                  1      7              2
> >                  2      0              2
> >                  3      0              2
> >                  4      2              1
> >                  5      2              2
> >                  6      2              0
> >                  7      2              0
> > 0x10             8      6              1
> >                  9      6              1
> >                 10      6              1
> >                 11      6              1
> >                 12      2              1
> >                 13      2              1
> >                 14      2              1
> >                 15      2              1
>
> I've changed this table to:
> TOS     Bits  Means                    Linux Priority    Band
> ------------------------------------------------------------
> 0x0     0     Normal Service           0 Best Effort     1
> 0x2     1     Minimize Monetary Cost   1 Filler          2
> 0x4     2     Maximize Reliability     0 Best Effort     1
> 0x6     3     mmc+mr                   0 Best Effort     1
> 0x8     4     Maximize Throughput      2 Bulk            2
> 0xa     5     mmc+mt                   2 Bulk            2
> 0xc     6     mr+mt                    2 Bulk            2
> 0xe     7     mmc+mr+mt                2 Bulk            2
> 0x10    8     Minimize Delay           6 Interactive     0
> 0x12    9     mmc+md                   6 Interactive     0
> 0x14    10    mr+md                    6 Interactive     0
> 0x16    11    mmc+mr+md                6 Interactive     0
> 0x18    12    mt+md                    4 Int. Bulk       1
> 0x1a    13    mmc+mt+md                4 Int. Bulk       1
> 0x1c    14    mr+mt+md                 4 Int. Bulk       1
> 0x1e    15    mmc+mr+mt+md             4 Int. Bulk       1
>


Yes, sorry the last 4 are int_bulk (value 4) and not just bulk (2). good
eye. You are still abusing the word TOS. Thats only 4 bits not 8;
Use the terminology from RFC1349 at least.

> http://ds9a.nl/lartc/HOWTO/cvs/2.4routing/output/2.4routing-9.html#ss9.2
>
> Your table appears to imply that a Maximum Reliability, Mininum Delay
> packet, TOS bits=9, gets mapped to band 1, not 0, which would not make
> sense.
>

This is the priomap: 1, 2, 2, 2, 1, 2, 0, 0 , 1, 1, 1, 1, 1, 1, 1, 1
It says 1 is the right value

> Laying it out like this, which does appear how it works, does mean that you
> can specify priorities in the priomap which do not correspond to possible
> TOS values.
>

You cant remap the 3 band scheduler trivially, but you should be able to
replace it with a default prio qdisc get exactly the same behavior and use
whatever map you want (eg your 0 to 1 substitution for TOS 1001)

> Is it possible at all to set skb->priority from userspace without going
> through the tos2prio mapping?
>

SO_PRIORITY socket option is doable; you have to be root.

> CBQ can use the skb->priority to classify:

so do prio and pfifo_fast (as i am sure you are aware)

>         /*
>          *  Step 1. If skb->priority points to one of our classes, use it.
>          */
>         if (TC_H_MAJ(prio^sch->handle) == 0 &&
>             (cl = cbq_class_lookup(q, prio)) != NULL)
>                         return cl;
>
> But to do this, you would need to be able to set skb->priority to a 32bit
> number:
>

Cant think of a straight way to do this .... Alexey would know,

cheers,
jamal


