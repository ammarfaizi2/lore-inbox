Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVL0Ix3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVL0Ix3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 03:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVL0Ix2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 03:53:28 -0500
Received: from pcsmail.patni.com ([203.124.139.197]:43677 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP id S932273AbVL0Ix2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 03:53:28 -0500
Message-ID: <003201c60ac3$16692d90$5e91a8c0@patni.com>
Reply-To: "lk" <linux_kernel@patni.com>
From: "lk" <linux_kernel@patni.com>
To: "jeff shia" <tshxiayu@gmail.com>, <linux-kernel@vger.kernel.org>,
       "robert love" <rml@novell.com>
References: <7cd5d4b40512262046w6f7a8161jfaf1e618e5722b4@mail.gmail.com>
Subject: Re: something about jiffies wraparound overflow
Date: Tue, 27 Dec 2005 14:24:03 +0530
Organization: Patni
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
x-mimeole: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you mentioned the code for comparison:
> /* code 2*/
> unsigned long timeout = jiffies + HZ/2;

the code has no problem with jiffies wrapping around
as long as the values are compared in a right way.
For a 32 bit platform the counter wraps around only once every 50 day
when the value of HZ 1000. so if your code is prepared to face this event
it will work fine.

>   2.Is there any other possibilities for the "code 2" to overflow
> except the jiffies overflow?
No.

The better option would be to use the inline macros:

> #define time_after(a,b) \
> (typecheck(unsigned long, a) && \
> typecheck(unsigned long, b) && \
> ((long)(b) - (long)(a) < 0))
> #define time_before(a,b) time_after(b,a)
>
> #define time_after_eq(a,b) \
> (typecheck(unsigned long, a) && \
> typecheck(unsigned long, b) && \
> ((long)(a) - (long)(b) >= 0))
> #define time_before_eq(a,b) time_after_eq(b,a)
>
> But I cannot understand it has some differences comparing with the
> following code.
>   1.why the macros of time_after can solve the jiffies
> wraparound problem?

As it is clear that time_after evaluates true,
when a, as a snapshot of jiffies, represents a time after b,

These inlines deals with the timer wrapping correctly, because
if the timer wrap changes in the future , you won't have to alter the driver
code.
Typechecks are performed at the compiled time, that variables are of the
same type.
the code works by first converting the values to unsigned long, subtracting
them and then comparing the result.
so it is the safe way and most encoraged..

If you need to know the difference
between two instances of jiffies in a safe way, you can use the same trick:
diff = (long)t2 - (long)t1;.


regards
lk.


