Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267777AbTBLTPf>; Wed, 12 Feb 2003 14:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267776AbTBLTOr>; Wed, 12 Feb 2003 14:14:47 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:48342 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S267771AbTBLTNS>; Wed, 12 Feb 2003 14:13:18 -0500
Message-ID: <3E4A9F13.40705@nortelnetworks.com>
Date: Wed, 12 Feb 2003 14:22:59 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: possible to livelock in mprotect() syscall?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it possible for ksoftirqd to have hold of some resource that other 
processes may need to obtain in the mprotect() syscall?

The background for this is as follows:

I've done some work with modifying the linux scheduler to support 
additional scheduling classes with limits on cpu percentages available 
for each class under stress.

We're hitting a strange scenario under the following conditions:

sched class A is given 90% of the cpu and is based on strict static 
priority scheduling

process x is put in sched class A with and is event driven

process y is put in sched class A with a lower priority than x and is a 
cpu hog

We would expect to see a background of y running, interrupted by x when 
it becomes runnable.

We seem to be seeing a case where process x calls mprotect() and then 
blocks while process y runs for large amounts of time.  Eventually we 
see ksoftirqd run and immediately after that process x wakes up and runs 
for a while, but by this time its too late and some timers have expired.

Hence the question--is it possible for ksoftirqd to have hold of some 
resource that process x tries to obtain in the mprotect() syscall?

Thanks,

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

