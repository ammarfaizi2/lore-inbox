Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284370AbRLHTYS>; Sat, 8 Dec 2001 14:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284405AbRLHTYJ>; Sat, 8 Dec 2001 14:24:09 -0500
Received: from shell.cyberus.ca ([216.191.240.114]:5371 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S284370AbRLHTYF>;
	Sat, 8 Dec 2001 14:24:05 -0500
Date: Sat, 8 Dec 2001 14:20:20 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: bert hubert <ahu@ds9a.nl>
cc: <lartc@mailman.ds9a.nl>, <linux-kernel@vger.kernel.org>,
        <kuznet@ms2.inr.ac.ru>, <netdev@oss.sgi.com>
Subject: Re: CBQ and all other qdiscs now REALLY completely documented
 (almost!)
In-Reply-To: <20011203030002.A20601@outpost.ds9a.nl>
Message-ID: <Pine.GSO.4.30.0112030831520.20924-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Dec 2001, bert hubert wrote:

> On Sat, Dec 01, 2001 at 01:33:41AM +0100, bert hubert wrote:
>
> > One thing - does *anybody* understand how hash tables work in tc filter, and
> > what they do? Furthermore, I could use some help with the tc filter police
> > things.
>
> Thanks to Andreas Steinmetz and David Sauer, tc hash tables are now
> documented as well, thanks!
>
> See:
>
>   http://ds9a.nl/2.4Routing/HOWTO//cvs/2.4routing/output/2.4routing-12.html
>
> And then 'Hashing filters for very fast massive filtering'.
>
> I also finished documenting all parameters for TBF, CBQ, SFQ, PRIO,
> bfifo, pfifo and pfifo_fast. All queues in the Linux kernel are now
> described in the Linux Advanced Routing & Shaping HOWTO, which can be found on
>
>                           http://ds9a.nl/2.4Routing
>
> I want to send this off to the LDP and Freshmeat somewhere next week, I
> *would really* like people who are knowledgeable about this subject (this
> means you, ANK & Jamal 8) ) to read through this.
>
> This HOWTO is rapidly becoming the perceived authoritative source for
> traffic control in linux (google on 'Linux Routing' finds it), it might as
> well be right! So if you have any time at all, check the parts you know
> about. I expect mistakes.
>
> The parts of the table of contents that document stuff in the kernel not
> documented elsewhere:

"not documented elsewhere" comes out rude. Werner and I (and even
Alexey when he was in the mood -- and i have seen some good documentation
by other people as well) have spent numerous hours documenting, presenting
and answering questions on mailing lists at times

Sample docs that i was personally involved in:
ftp://icaftp.epfl.ch/pub/linux/diffserv/misc/dsid-01.txt.gz
You need to introduce the big picture to the user.
and what is wrong with the definitions used in
http://www.davin.ottawa.on.ca/ols/img10.htm that forced you to introduce
your own?
Actually, the big picture is:
http://www.davin.ottawa.on.ca/ols/img9.htm
Also
http://www.linuxjournal.com/article.php?sid=3369
(was written in 98 but got published in 99)

Now despite all the bitching above, i think your efforts are noble.

[My complaints about your style is you often are trying to present facts
by using opinions. For example despite a lot of effort in the past to
explain ingress qdisc to you in the past and, pointing you to very good
documentation from CISCO you still ended using your opinions on what you
thought it should be;->
My scanning of the document shows opinions still posing as miscontrued
facts. It is improving compared to what i saw last when we discussed ingress.
Let me clarify one thing in this email; i'll read what you have later.

Lets start by your description of TC_PRIO and TOS mappings etc:
Your descriptions of these values is insufficient. Consider this a
tutorial and reword it as you wish but please avoid opinions.
Ok here's clarification, this applies to both prio, default fifo 3 band
queueing and CBQ defaultmap classification; applies to both packets being
forwarded as well as locally generated:

First Step:
===========

Define TOS: This is a 4 bit value used as defined in RFC 1349.

               0     1     2     3     4     5     6     7
             +-----+-----+-----+-----+-----+-----+-----+-----+
             |                 |                       |     |
             |   PRECEDENCE    |          TOS          | MBZ |
             |                 |                       |     |
             +-----+-----+-----+-----+-----+-----+-----+-----+

Then define the values possible as:



                    1000   --   minimize delay
                    0100   --   maximize throughput
                    0010   --   maximize reliability
                    0001   --   minimize monetary cost
                    0000   --   normal service

Look at RFC 1349 for typical values used by different applications
Then of course note that RFC 1349 is obsoleted by RFC 2474 (yes, you can
weep);

Having said all that:

Linux remaps packets incoming with different values to some internal
value; the colum "mapped to" shows the internal mapping

8value(hex)   TOS(dec) mapped to(dec)
----------------------------------
0x0              0      0
                 1      7
                 2      0
                 3      0
                 4      2
                 5      2
                 6      2
                 7      2
0x10             8      6
                 9      6
                10      6
                11      6
                12      2
                13      2
                14      2
                15      2

Fill in the  "8value(hex)" column gaps using the bitmap from RFC1349 for
the 8 bits; These are the values ou would see with tcpdump -vvv
I filled the two easiest ones i could compute in my head.

Second step:

Take the default priority map:
 1, 2, 2, 2, 1, 2, 0, 0 , 1, 1, 1, 1, 1, 1, 1, 1
This applies for both default prio and the 3-band FIFO queue.
Note the queue map fitted on the last column

8 but value     TOS     mapped to   queue map
---------------------------------------------
0x0              0      0              1
                 1      7              2
                 2      0              2
                 3      0              2
                 4      2              1
                 5      2              2
                 6      2              0
                 7      2              0
0x10             8      6              1
                 9      6              1
                10      6              1
                11      6              1
                12      2              1
                13      2              1
                14      2              1
                15      2              1

Queue 0 gets processed first then queue 1 then queue 2. In the strict
priority processing such as in prio or default 3 band sched, queue 0 is
processed until no more packets are left, then queue1 etc. This could
result in starvation. You could avoid starvation by inserting a TBF
in a prio; limit the size of the fifo in a class or use CBQ configured
as WRR.
I hope the above explains why you have to recreate the priomap everytime
you change the number of bands. You used the word "probably" which is
wrong. The proper word is "MUST".
What i think would be useful for you to do is describe some of the vlaues
used by some applications (RFC 1349 cut-n-paste job would help).

cheers,
jamal

