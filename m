Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281157AbRLIBaz>; Sat, 8 Dec 2001 20:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281180AbRLIBas>; Sat, 8 Dec 2001 20:30:48 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:26782 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S281157AbRLIBag>; Sat, 8 Dec 2001 20:30:36 -0500
Date: Sun, 9 Dec 2001 02:30:29 +0100
From: bert hubert <ahu@ds9a.nl>
To: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: CBQ and all other qdiscs now REALLY completely documented (almost!)
Message-ID: <20011209023029.A25580@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, lartc@mailman.ds9a.nl,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20011209002344.C20125@outpost.ds9a.nl> <Pine.GSO.4.30.0112081841050.4764-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0112081841050.4764-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sat, Dec 08, 2001 at 08:14:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 08:14:10PM -0500, jamal wrote:

> Yes, sorry the last 4 are int_bulk (value 4) and not just bulk (2). good
> eye. You are still abusing the word TOS. Thats only 4 bits not 8;
> Use the terminology from RFC1349 at least.

Will do.

> > http://ds9a.nl/lartc/HOWTO/cvs/2.4routing/output/2.4routing-9.html#ss9.2
> >
> > Your table appears to imply that a Maximum Reliability, Mininum Delay
> > packet, TOS bits=9, gets mapped to band 1, not 0, which would not make
> > sense.
> 
> This is the priomap: 1, 2, 2, 2, 1, 2, 0, 0 , 1, 1, 1, 1, 1, 1, 1, 1
> It says 1 is the right value

AFAICT, the priomap maps skb->priority to band. So the translation is as
follows:

Type of Service octet, which is fed to:
        skb->priority = rt_tos2priority(iph->tos);


To extract the four TOS bits, and to translate to prio:
static inline char rt_tos2priority(u8 tos)
{
        return ip_tos2prio[IPTOS_TOS(tos)>>1];
}

----

__u8 ip_tos2prio[16] = {
        TC_PRIO_BESTEFFORT,
        ECN_OR_COST(FILLER),
        TC_PRIO_BESTEFFORT,
        ECN_OR_COST(BESTEFFORT),
        TC_PRIO_BULK,
        ECN_OR_COST(BULK),
        TC_PRIO_BULK,
        ECN_OR_COST(BULK),
        TC_PRIO_INTERACTIVE,
        ECN_OR_COST(INTERACTIVE),
        TC_PRIO_INTERACTIVE,
        ECN_OR_COST(INTERACTIVE),
        TC_PRIO_INTERACTIVE_BULK,
        ECN_OR_COST(INTERACTIVE_BULK),
        TC_PRIO_INTERACTIVE_BULK,
        ECN_OR_COST(INTERACTIVE_BULK)
};
 
---

#define TC_PRIO_BESTEFFORT              0
#define TC_PRIO_FILLER                  1
#define TC_PRIO_BULK                    2
#define TC_PRIO_INTERACTIVE_BULK        4
#define TC_PRIO_INTERACTIVE             6
#define TC_PRIO_CONTROL                 7
#define TC_PRIO_MAX                     15

net/sched/sched_generic.c:

static const u8 prio2band[TC_PRIO_MAX+1] =
{ 1, 2, 2, 2, 1, 2, 0, 0 , 1, 1, 1, 1, 1, 1, 1, 1 };

        list = ((struct sk_buff_head*)qdisc->data) +
                prio2band[skb->priority&TC_PRIO_MAX];

> > CBQ can use the skb->priority to classify:
> 
> so do prio and pfifo_fast (as i am sure you are aware)

Of course, but only CBQ (& HTB, by the way) can extract a classid directly
from it, without a priomap. Devik is planning to learn HTB to extract a
classid directly from the fwmark, to skip a layer of indirection.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
