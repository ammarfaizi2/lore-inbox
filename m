Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136602AbRAHKNR>; Mon, 8 Jan 2001 05:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136540AbRAHKNH>; Mon, 8 Jan 2001 05:13:07 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:45319 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S136602AbRAHKMt>; Mon, 8 Jan 2001 05:12:49 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A598F88.17EB535@yahoo.com>
Date: Mon, 08 Jan 2001 04:59:36 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.0 i486)
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: BJerrick@easystreet.com, linux-kernel@vger.kernel.org
Subject: Re: 500 ms offset in i386 Real Time Clock setting
In-Reply-To: <UTC200101071759.SAA146769.aeb@texel.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> I still haven't looked at things, but two points:
> (i) is the behaviour constant on all architectures?

As it is a property of the mc146818, it should be constant across all 
arch that use drivers/char/rtc.c

Sparc uses drivers/sbus/char/rtc.c which is for Mostek 4802.  No comment
mentions a 500ms delay there - or in the file arch/sparc/kernel/time.c 
*However* the test for the 500ms is still in the latter (in set_rtc_mmss).

> (ii) instead of waiting, isn't it much easier to redefine
> what it means to access rtc?

Yes, and possibly what I had in mind some 5 years ago (as I'm sure I would
have looked at set_rtc_mmss at the time...)

> (If you read a certain value then on average you are halfway
> that second; if you write a certain value you are precisely
> halfway that second. Maybe no delays are needed or desired.)

Calling it a "feature" is clearly easier - no code patched, no flag day
for new behaviour, and no need for user space utils to have to do a 
uname() to see if a 500ms delay is implemented.  The more I think about
it, the better I like this option.

Paul.

--- drivers/char/rtc.c~	Sat Jan  6 05:40:24 2001
+++ drivers/char/rtc.c	Mon Jan  8 04:57:59 2001
@@ -20,6 +20,14 @@
  *	interrupts since the last read in the remaining high bytes. The 
  *	/dev/rtc interface can also be used with the select(2) call.
  *
+ *	The driver also supports ioctls for reading and setting the
+ *	date/time stored in the RTC in a SMP safe fashion (used by
+ *	the [hw]clock program).  Note that for the mc146818 RTC, the
+ *	second for which the RTC is set is half over, by definition.
+ *	Thus your application may require a 0.5 second delay before
+ *	calling this driver to set the RTC time if exact synchronization
+ *	is desired.
+ *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
