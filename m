Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWEBX7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWEBX7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 19:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWEBX7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 19:59:24 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:41359 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965042AbWEBX7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 19:59:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=GvvW6/COQqLoysnz05a47q3uQem+aCcPDvtrJxQdLt4brXUJNrxDaRsd3kvnjY0wZV4RdRV0A0Py+qEoegxyp1J7W8k4ySLALZNkn8x3lOloI1dnpivxHg2Qimjeh7sJK8eHZNUan36sj7uwlxO9rwPs+Cl6kwYywgl4kwyrZZ0=  ;
Message-ID: <44576AD3.500@yahoo.com.au>
Date: Wed, 03 May 2006 00:21:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
In-Reply-To: <20060502132953.GA30146@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> There are several solutions to this - the most obvious being that we
> need a function which returns the nanosecond difference between two
> sched_clock() return values, and this function needs to know how to
> handle the case where sched_clock() has wrapped.
> 
> IOW:
> 
> 	t0 = sched_clock();
> 	/* do something */
> 	t1 = sched_clock();
> 
> 	time_passed = sched_clock_diff(t1, t0);
> 
> Comments?
> 

There is another problem John pointed out to me: sched_clock (at least
on i386) can do tsc frequency scaling on the raw tsc value. I'm not
sure if this is still a problem (I'm not aware that it has been fixed),
however it would mean that between two sched_clock()s, the values
returned can be basically completely arbitrary.

What is needed is something like:
     t0 = get_cycles_unsynchronized();
     t1 = get_cycles_unsynchronized();
     ns = cycles_to_ns(t1, t0);

Where unsynchronized means not synchronized between CPUs.

This would still cause the `ns' value to be skewed if a frequency change
occured between t0 and t1, however at least it should be within some
realistic range (something like ns +/- ns * max freq / min freq).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
