Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbULHQsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbULHQsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbULHQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:48:09 -0500
Received: from dvhart.com ([64.146.134.43]:1924 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261262AbULHQsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:48:02 -0500
Subject: nanosleep resolution, jiffies vs microseconds
From: Darren Hart <darren@dvhart.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: blainey@ca.ibm.com, Martin J Bligh <mbligh@aracnet.com>, nacc@us.ibm.com,
       johnstul@us.ibm.com, fultonm@ca.ibm.com, paulmck@us.ibm.com
Content-Type: text/plain
Date: Wed, 08 Dec 2004 08:47:48 -0800
Message-Id: <1102524468.16986.30.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking at trying to improve the latency of nanosleep for short
sleep times (~1ms).  After reading Martin Schwidefsky's post for cputime
on s390 (Message-ID:
<20041111171439.GA4900@mschwid3.boeblingen.de.ibm.com>), it seems to me
that we may be able to accomplish this by storing the expire time in
microseconds rather than jiffies.  Here is an example for context:

Say we want to sleep for 1ms on i386, we call nanosleep(1000000).
Unfortunately on i386 a jiffy is slightly less than 1ms (as one might
expect with HZ = 1000).  So when sys_nanosleep calls
timespec_to_jiffies, it returns 2.  Now to allow for the corner case
when my 1ms sleep request gets called at the very tail end of a clock
period (see ascii diagram below), nanosleep adds 1 to that and calls
schedule_timeout with 3.  So a 1 ms sleep correctly turns into 3
jiffies.

If we were to store the expire value in microseconds, this corner case
would still exist and still span two full tick periods.  However, the
large majority of the time, nanosleep(1000000) could pause for only 2
jiffies, instead of 3.  Before I dug to deep into the relevant code I
wanted to hear some opinions on this approach.


Worst case scenario for a 1ms sleep:

TICK @ 1000000000 ns ------------------------   (X jiffies)


    nanosleep(1000000) // this can't correctly wake until 1001999849
TICK @ 1000999849 ns ------------------------   (X jiffies + 1)



TICK @ 1001999698 ns ------------------------   (X jiffies + 2)
    at 1001999849 nanosleep call can wake up
    (but since this is after X jiffies + 2, we can't actually wake
     until X jiffies + 3)

TICK @ 1002999547 ns ------------------------   (X jiffies + 3)
    wake from nanosleep


Thanks,

-- 
Darren Hart <darren@dvhart.com>


