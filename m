Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUFEPXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUFEPXi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 11:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUFEPXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 11:23:38 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:37117 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261606AbUFEPXd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 11:23:33 -0400
Date: Sat, 5 Jun 2004 17:23:26 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: Too much error in __const_udelay() ?
Message-ID: <20040605152326.GA11239@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	george anzinger <george@mvista.com>, greg kh <greg@kroah.com>,
	Chris McDermott <lcm@us.ibm.com>
References: <1086419565.2234.133.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086419565.2234.133.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> However I've started to see some problems w/ 2.6 and USB on x440/x445s,
> both of which use the 100Mhz cyclone time source. Further digging has
> pointed to the fact that certain important udelay()s in the USB
> subsystem aren't actually waiting long enough. 

Certain? AFAICS _no_ call to a delay routine actually passed a big enough
argument. Or am I missing something? Also, __ndelay seems to be affected 
as well: it returns zero for 550 nsec even for the TSC variant in your 
test.c.

> So I'm no math wiz. What's the proper fix here? 

Below are three changes I'd like to discuss. I'll build a fresh kernel with
all three changes enabled + PM_TIMER soon.

Change 1:

Move the multiplication with HZ up into the mull instruction:

unsigned long  __const_udelay(unsigned long xloops)
{
	int d0;
	__asm__("mull %0"
		:"=d" (xloops), "=&a" (d0)
		:"1" (xloops),"0" (LPJ * HZ));
        return __delay(xloops);
}

  1 usec: LPJ:  100000 __udelay:     0 vs my_udelay:    99
  1 usec: LPJ: 1500000 __udelay:  1000 vs my_udelay:  1499

  2 usec: LPJ:  100000 __udelay:     0 vs my_udelay:   199
  2 usec: LPJ: 1500000 __udelay:  2000 vs my_udelay:  2999

  5 usec: LPJ:  100000 __udelay:     0 vs my_udelay:   499
  5 usec: LPJ: 1500000 __udelay:  7000 vs my_udelay:  7498

 10 usec: LPJ:  100000 __udelay:     0 vs my_udelay:   999
 10 usec: LPJ: 1500000 __udelay: 14000 vs my_udelay: 14996

 20 usec: LPJ:  100000 __udelay:  1000 vs my_udelay:  1999
 20 usec: LPJ: 1500000 __udelay: 29000 vs my_udelay: 29993

 50 usec: LPJ:  100000 __udelay:  4000 vs my_udelay:  4998
 50 usec: LPJ: 1500000 __udelay: 74000 vs my_udelay: 74983

100 usec: LPJ:  100000 __udelay:  9000 vs my_udelay:  9997
100 usec: LPJ: 1500000 __udelay: 149000 vs my_udelay: 149966

20000 usec: LPJ:  100000 __udelay: 1999000 vs my_udelay: 1999549
20000 usec: LPJ: 1500000 __udelay: 29993000 vs my_udelay: 29993243


Change 2:

Round up in __udelay. While it can be argued that some time is also
spent in the delay functions, it's better to spend _at least_ the specified
time sleeping, in my humble opinion. 


-	return __const_udelay2(usecs * 0x000010c6);  /* 2**32 / 1000000 */
+	return __const_udelay2(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up)*/

  1 usec: LPJ:  100000 __udelay:     0 vs my_udelay:   100
  1 usec: LPJ: 1500000 __udelay:  1000 vs my_udelay:  1500

  2 usec: LPJ:  100000 __udelay:     0 vs my_udelay:   200
  2 usec: LPJ: 1500000 __udelay:  2000 vs my_udelay:  3000

  5 usec: LPJ:  100000 __udelay:     0 vs my_udelay:   500
  5 usec: LPJ: 1500000 __udelay:  7000 vs my_udelay:  7500

 10 usec: LPJ:  100000 __udelay:     0 vs my_udelay:  1000
 10 usec: LPJ: 1500000 __udelay: 14000 vs my_udelay: 15000

 20 usec: LPJ:  100000 __udelay:  1000 vs my_udelay:  2000
 20 usec: LPJ: 1500000 __udelay: 29000 vs my_udelay: 30000

 50 usec: LPJ:  100000 __udelay:  4000 vs my_udelay:  5000
 50 usec: LPJ: 1500000 __udelay: 74000 vs my_udelay: 75000

100 usec: LPJ:  100000 __udelay:  9000 vs my_udelay: 10000
100 usec: LPJ: 1500000 __udelay: 149000 vs my_udelay: 150001

20000 usec: LPJ:  100000 __udelay: 1999000 vs my_udelay: 2000015
20000 usec: LPJ: 1500000 __udelay: 29993000 vs my_udelay: 30000228


Change 3:

Asserting at least 1 loop is spent: in really small ndelay() calls to
low-mhz timers, this might be better.

        return __delay(xloops ? xloops : 1);

Before:
  1 nsec: LPJ:  100000 __ndelay:     0 vs my_udelay:     0
  2 nsec: LPJ:  100000 __ndelay:     0 vs my_udelay:     0
  5 nsec: LPJ:  100000 __ndelay:     0 vs my_udelay:     0
 10 nsec: LPJ:  100000 __ndelay:     0 vs my_udelay:     1
 20 nsec: LPJ:  100000 __udelay:     0 vs my_udelay:     2
 50 nsec: LPJ:  100000 __ndelay:     0 vs my_udelay:     5

After:
  1 nsec: LPJ:  100000 __udelay:     0 vs my_udelay:     1
  2 nsec: LPJ:  100000 __udelay:     0 vs my_udelay:     1
  5 nsec: LPJ:  100000 __udelay:     0 vs my_udelay:     1
 10 nsec: LPJ:  100000 __udelay:     0 vs my_udelay:     1
 20 nsec: LPJ:  100000 __udelay:     0 vs my_udelay:     2
 50 nsec: LPJ:  100000 __udelay:     0 vs my_udelay:     5



	Dominik
