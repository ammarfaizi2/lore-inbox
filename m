Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbRBOP4Y>; Thu, 15 Feb 2001 10:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129252AbRBOP4P>; Thu, 15 Feb 2001 10:56:15 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:11936 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129215AbRBOP4C>; Thu, 15 Feb 2001 10:56:02 -0500
Message-ID: <3A8BFBF6.B99CFFF5@inet.com>
Date: Thu, 15 Feb 2001 09:55:34 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Richard B. Johnson" <root@chaos.analogic.com>, tsbogend@alpha.franken.de,
        Peter Missel <P.Missel@sbs-or.de>, linux-kernel@vger.kernel.org,
        Eli Carter <eli.carter@inet.com>
Subject: Re: [PATCH] pcnet32.c: MAC address may be in CSR registers
In-Reply-To: <E14TBm9-0006VH-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > +int is_valid_ether_addr( char* address )
> > +{
> > +    int i,isvalid=0;
> > +    for( i=0; i<6; i++)
> > +     isvalid |= address[i];
> > +    return isvalid && !(address[0]&1);
> > +}
> 
> static and why not

oops, I *meant* static... doesn't gcc do mind reading?  ;)  (I had
static in the declaration, but forgot it on the definition.)

> static inline int is_valid_ea(u8 *addr)
> {
>         return memcmp(addr, "\000\000\000\000\000\000", 6) && !(addr[0]&1);
> }
> 
> That all assembles to nice inline code 8)

Hmm... well, if we're going for _those_ optimizations, shouldn't it be:
	return !(addr[0]&1) && memcmp(addr, "\000\000\000\000\000\000", 6);
so we do the cheaper test first and thus possibly avoid needing to do
the more expensive test? :)

Tell ya what, put that in <linux/etherdevice.h> (if that's the right
place) and then everyone can use it.  ;)  (I'd rather keep the longer
function name... "ea" isn't very helpful to the newer hackers among
us...)

> Looks ok to me, Im picking holes now

:)  That's encouraging.  I still feel like I'm scaling the learning
curve, and I'm feeling rather "green".

Peter pointed out that the contents of the CSR12-14 registers are
initialized from the EEPROM, so reading the EEPROM is superfluous--we
should just read the CSRs and not read the EEPROM.  I think he has a
point, so I'll make that change and submit yet another patch pair.  

Alan, do you want me to put your inline version in <linux/etherdevice.h>
while I'm at it, or what?

Comments?

Eli
--------------------.              Rule of Accuracy: When working toward
Eli Carter          |               the solution of a problem, it always 
eli.carter@inet.com `--------------------- helps if you know the answer.
