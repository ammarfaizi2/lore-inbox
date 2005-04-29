Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVD2TIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVD2TIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVD2TIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:08:54 -0400
Received: from [195.23.16.24] ([195.23.16.24]:27054 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262888AbVD2THL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:07:11 -0400
Message-ID: <427285CC.9090300@grupopie.com>
Date: Fri, 29 Apr 2005 20:06:52 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Croquette <ocroquette@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: setitimer timer expires too early
References: <42726DDD.1010204@free.fr>
In-Reply-To: <42726DDD.1010204@free.fr>
Content-Type: multipart/mixed;
 boundary="------------060406030604020308070307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060406030604020308070307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Olivier Croquette wrote:
> Hello
> 
> I wrote a program which uses setitimer to implement a usleep() equivalent.
> [...]
> Anyone have an idea?
> Can you reproduce that?

I can reproduce that.

It seems that the code responsible for this is in kernel/itimer.c:126:

	p->signal->real_timer.expires = jiffies + interval;
	add_timer(&p->signal->real_timer);

If you request an interval of, lets say 900 usecs, the interval given by 
timeval_to_jiffies will be 1.

If you request this when we are half-way between two timer ticks, the 
interval will only give 400 usecs.

If we want to guarantee that we never ever give intervals less than 
requested, the simple solution would be to change that to:

	p->signal->real_timer.expires = jiffies + interval + 1;

This however will produce pathological cases, like having a idle system 
being requested 1 ms timeouts will give systematically 2 ms timeouts, 
whereas currently it simply gives a few usecs less than 1 ms.

The complex (and more computationally expensive) solution would be to 
check the gettimeofday time, and compute the correct number of jiffies. 
This way, if we request a 300 usecs timer 200 usecs inside the timer 
tick, we can wait just one tick, but not if we are 800 usecs inside the 
tick. This would also mean that we would have to lock preemption during 
these computations to avoid races, etc.

I've searched the archives but couldn't find this particular issue being 
discussed before.

Attached is a patch to do the simple solution, in case anybody thinks 
that it should be used.

Signed-Off-By: Paulo Marques <pmarques@grupopie.com>

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------060406030604020308070307
Content-Type: text/plain;
 name="itimer_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="itimer_patch"

--- ./kernel/itimer.c.orig	2005-04-29 19:59:12.937832959 +0100
+++ ./kernel/itimer.c	2005-04-29 20:01:49.849787304 +0100
@@ -123,7 +123,11 @@ static inline void it_real_arm(struct ta
 		return;
 	if (interval > (unsigned long) LONG_MAX)
 		interval = LONG_MAX;
-	p->signal->real_timer.expires = jiffies + interval;
+	/* the "+ 1" below makes sure that the timer doesn't go off before
+	 * the interval requested. This could happen if 
+	 * time requested % (usecs per jiffy) is more than the usecs left
+	 * in the current jiffy */
+	p->signal->real_timer.expires = jiffies + interval + 1;
 	add_timer(&p->signal->real_timer);
 }
 

--------------060406030604020308070307--
