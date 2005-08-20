Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbVHTDbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVHTDbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932802AbVHTDbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:31:43 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28990 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932652AbVHTDbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:31:42 -0400
Date: Fri, 19 Aug 2005 21:20:22 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: sched_yield() makes OpenLDAP slow
In-reply-to: <4D8eT-4rg-31@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4306A176.3090907@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4D8eT-4rg-31@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> You assume that spinlocks are the only reason a developer may want to 
> yield the processor. This assumption is unfounded. Case in point - the 
> primary backend in OpenLDAP uses a transactional database with 
> page-level locking of its data structures to provide high levels of 
> concurrency. It is the nature of such a system to encounter deadlocks 
> over the normal course of operations. When a deadlock is detected, some 
> thread must be chosen (by one of a variety of algorithms) to abort its 
> transaction, in order to allow other operations to proceed to 
> completion. In this situation, the chosen thread must get control of the 
> CPU long enough to clean itself up, and then it must yield the CPU in 
> order to allow any other competing threads to complete their 
> transaction. The thread with the aborted transaction relinquishes all of 
> its locks and then waits to get another shot at the CPU to try 
> everything over again. Again, this is all fundamental to the nature of 
> transactional programming. If the 2.6 kernel makes this programming 
> model unreasonably slow, then quite simply this kernel is not viable as 
> a database platform.

I fail to see how sched_yield is going to be very helpful in this 
situation. Since that call can sleep from a range of time ranging from 
zero to a long time, it's going to give unpredictable results.

It seems to me that this sort of thing is why we have POSIX pthread 
synchronization primitives.. sched_yield is basically there for a 
process to indicate that "what I'm doing doesn't matter much, let other 
stuff run". Any other use of it generally constitutes some kind of hack.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

