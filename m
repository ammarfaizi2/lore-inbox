Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136034AbRDVKsz>; Sun, 22 Apr 2001 06:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136030AbRDVKs0>; Sun, 22 Apr 2001 06:48:26 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:21517 "EHLO
	c0mailgw11.prontomail.com") by vger.kernel.org with ESMTP
	id <S136032AbRDVKsH>; Sun, 22 Apr 2001 06:48:07 -0400
Message-ID: <3AE2B6CC.1D1F8A10@mvista.com>
Date: Sun, 22 Apr 2001 03:47:40 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Ramos <marcus@ansp.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: What is the precision of usleep ?
In-Reply-To: <3AE07A5A.C5BBE59C@ansp.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Ramos wrote:
> 
> Hello,
> 
> I am using usleep in an application under RH7 kernel 2.4.2. However,
> when I bring its argument down to 20 miliseconds (20.000 microseconds)
> or less, this seems to be ignored by the function (or the machine's hw
> timer), which behaves as if 20 ms where its lowest acceptable value. How
> can I measure the precision of usleep in my box ? I am currently using
> an Dell GX110 PIII 866 MHz.
> 
> Thanks in advance.
> Marcus.

Well, first, your issue is resolution, not precision.  Current
resolution on most all timers is 1/HZ.  So this should get a min.
nanosleep of 10 ms.

So, could someone explain this line from sys_nanosleep() (
kernel/timer.c):

	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);

It seems to me this should just be:

	expire = timespec_to_jiffies(&t)

timespec_to_jiffies(&t) seems to do all the needed resolution round up
and such.  Since || is logical, this seems to always add 1, except if
the requested value is 0.  The net result is you always get 1 extra
jiffie (unless you ask for zero, in which case you get a timer that will
expire next tick (thru the wonders of add_timer).

George
