Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUF0XvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUF0XvG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 19:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUF0XvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 19:51:06 -0400
Received: from gizmo12ps.bigpond.com ([144.140.71.43]:7377 "HELO
	gizmo12ps.bigpond.com") by vger.kernel.org with SMTP
	id S264542AbUF0XvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 19:51:01 -0400
Message-ID: <40DF5D61.2030208@bigpond.net.au>
Date: Mon, 28 Jun 2004 09:50:57 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de> <200406252044.25843.mbuesch@freenet.de> <20040625190533.GI29808@alpha.home.local> <200406252148.37606.mbuesch@freenet.de> <Pine.LNX.4.58.0406272021250.29505@kolivas.org> <Pine.LNX.4.58.0406272026330.29572@kolivas.org>
In-Reply-To: <Pine.LNX.4.58.0406272026330.29572@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Sun, 27 Jun 2004, Con Kolivas wrote:
> 
> 
>>Ok I found a problem which alost certainly is responsible in the 
>>conversion from nanoseconds to Hz and may if you're unlucky give a blank 
>>timeslice. Can you try this (against staircase7.4). I'm almost certain 
>>it's responsbile. 
> 
> 
> Hmm that will be the problem but that may not compile because of the darn 
> long long division thingy. I'll get a clean patch to you later on that 
> does the same thing, sorry.

Here's a routine that I use for unsigned 64 bit divides. This is 
theoretically correct and (just to make sure :-)) thoroughly tested in a 
user space test program against a proper 64 bit divide.  It can't be 
used to initialize static variables but that's OK because the compiler 
can do the 64 bit arithmetic itself to correctly initialize them.

static inline unsigned long long sched_div_64(unsigned long long a, 
unsigned long long b)
{
#if BITS_PER_LONG < 64
	/*
	 * Assume that there's no 64 bit divide available
	 */
	if (a < b)
		return 0;
	/*
	 * Scale down until b less than 32 bits so that we can do
	 * a divide using do_div() (see div64.h).
	 */
	while (b > ULONG_MAX) { a >>= 1; b >>= 1; }

	(void)do_div(a, (unsigned long)b);

	return a;
#else
	return a / b;
#endif
}

Peter
PS If we knew the calling conventions for the library routines 
(__udivdi3, etc.) that the compiler tries to use to do 64 bit divides we 
could implement them in the kernel (where necessary) and 64 bit divide 
problems would become a thing of the past.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

