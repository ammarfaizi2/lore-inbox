Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbTBDInJ>; Tue, 4 Feb 2003 03:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbTBDInI>; Tue, 4 Feb 2003 03:43:08 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:43282 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267176AbTBDInF>; Tue, 4 Feb 2003 03:43:05 -0500
Message-Id: <200302040843.h148hLs11097@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Robert de Bath <robert$@mayday.cix.co.uk>
Subject: Re: [PATCH *] use 64 bit jiffies
Date: Tue, 4 Feb 2003 10:41:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
References: <6789aaded8e91844@mayday.cix.co.uk>
In-Reply-To: <6789aaded8e91844@mayday.cix.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 February 2003 10:27, Robert de Bath wrote:
> On Tue, 4 Feb 2003, Denis Vlasenko wrote:
> > 		Jiffy Wrap Bugs
> >
> > There were reports of machines hanging on jiffy wrap.
> > This is typically a result of incorrect jiffy use in some driver.
> > Ask Tim - he is hunting those problems regularly, but he is
> > outnumbered by buggy driver authors. :(
> >
> > There is a better solution to ensure correct jiffy wrap handling in
> > *ALL* kernel code: make jiffy wrap in first five minutes of uptime.
> > Tim has a patch for such config option. This is almost right.
> > This MUST NOT be a config option, it MUST be mandatory in every
> > kernel. Driver writers would be bitten by their own bugs and will
> > fix it themself. Tim, what do you think?
>
> How about an option, either the jiffy timer wraps at 5 minutes or
> process 1 gets sent a SIGINT after 24 hours ? That way a driver
> with an MIA author can still be used even if it's buggy, just not
> for very long.

I prefer buggy driver be fixed ASAP. The first step is to know
that there *is* a (jiffywize-) buggy driver or something.

Jiffie wrap at 5 mins is done this way: jiffies is initialized to -5*60*HZ
instead of zero at boot. Accounting code is adjusted e.g. not to show 400+
days uptime (it subtracts -5*60*HZ from jiffies).

Jiffies wraps to zero in five minutes. Box should survive with no probs.
If it instead hangs, oops or otherwise feeling bad, you have a jiffy wrap
bug somewhere.

Today you need to wait 400 or so days before you can test what will happen.
Production servers' admins getting a bit nervous close to that date ;)

A nice printk "Timer code check..." at jiffies = -30*HZ
and "...timer code check passed" at jiffies = 30*HZ will let us have
good bug reports ("what was your last log message?") and would not
scare people. "A jiffie would wrap in 5 seconds!" is not that good -
please do not unnecessarily scare new users ;)
--
vda
