Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbRDJTc3>; Tue, 10 Apr 2001 15:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRDJTcT>; Tue, 10 Apr 2001 15:32:19 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:47769 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131953AbRDJTcN>; Tue, 10 Apr 2001 15:32:13 -0400
Message-ID: <3AD35EFB.40ED7810@mvista.com>
Date: Tue, 10 Apr 2001 12:28:59 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        high-res-timers-discourse@lists.sourceforge.net
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for your information we have a project going that is trying to come
up with a good solution for all of this:

http://sourceforge.net/projects/high-res-timers

We have a mailing list there where we have discussed much of the same
stuff.  The mailing list archives are available at sourceforge.

Lets separate this into findings and tentative conclusions :)

Findings:

a) The University of Kansas and others have done a lot of work here.

b) High resolution timer events can be had with or without changing HZ.

c) High resolution timer events can be had with or without eliminating
the 1/HZ tick.

d) The organization of the timer list should reflect the existence of
the 1/HZ tick or not.  The current structure is not optimal for a "tick
less" implementation.  Better would be strict expire order with indexes
to "interesting times".

e) The current organization of the timer list generates a hiccup every
2.56 seconds to handle "cascading".  Hiccups are bad.

f) As noted, the account timers (task user/system times) would be much
more accurate with the tick less approach.  The cost is added code in
both the system call and the schedule path.  

Tentative conclusions:

Currently we feel that the tick less approach is not acceptable due to
(f).  We felt that this added code would NOT be welcome AND would, in a
reasonably active system, have much higher overhead than any savings in
not having a tick.  Also (d) implies a list organization that will, at
the very least, be harder to understand.  (We have some thoughts here,
but abandoned the effort because of (f).)  We are, of course, open to
discussion on this issue and all others related to the project
objectives.

We would reorganize the current timer list structure to eliminate the
cascade (e) and to add higher resolution entries.  The higher resolution
entries would carry an addition word which would be the fraction of a
jiffie that needs to be added to the jiffie value for the timer.  This
fraction would be in units defined by the platform to best suit the sub
jiffie interrupt generation code.  Each of the timer lists would then be
ordered by time based on this sub jiffie value.  In addition, in order
to eliminate the cascade, each timer list would carry all timers for
times that expire on the (jiffie mod (size of list)).  Thus, with the
current 256 first order lists, all timers with the same (jiffies & 255)
would be in the same list, again in expire order.  We also think that
the list size should be configurable to some power of two.  Again we
welcome discussion of these issues.

George

Alan Cox wrote:

>> It's also all interrupts, not only syscalls, and also context switch if you
>> want to be accurate.

>We dont need to be that accurate. Our sample rate is currently so low the
>data is worthless anyway
