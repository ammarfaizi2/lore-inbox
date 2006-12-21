Return-Path: <linux-kernel-owner+w=401wt.eu-S1423011AbWLUSZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423011AbWLUSZs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423012AbWLUSZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:25:48 -0500
Received: from mx2.netapp.com ([216.240.18.37]:31344 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423011AbWLUSZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:25:47 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 13:25:46 EST
X-IronPort-AV: i="4.12,200,1165219200"; 
   d="scan'208"; a="14051329:sNHT126188916"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: newbie questions about while (1) in kernel mode and spinlocks
Date: Thu, 21 Dec 2006 23:44:56 +0530
Message-ID: <7026BCCA258BA2438F885772CA0B431305185805@exbtc01.hq.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: newbie questions about while (1) in kernel mode and spinlocks
Thread-Index: Acck6jY/BhT/MwIoQPG6j8cAsLypgwAQPs4g
From: "SR, Krishna" <Krishna.Sr@netapp.com>
To: "Paolo Ornati" <ornati@fastwebnet.it>,
       "Sorin Manolache" <sorinm@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Dec 2006 18:16:42.0085 (UTC) FILETIME=[2A3E1950:01C7252C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well, Spin lock itself is a while loop. So in case a process on another
CPU has the semaphore and you get a  spin lock and try to wait on a
semaphore and the other CPU also tries to get the spin lock then you are
in a dead loop.


CPU 1                   CPU 2
		            Get sem-1 (success)
				......
Spin lock (success)	.......

...				.....
...				Spin lock??? No you are locked....
Get sem -1 (block)
You are blocked now

That is the reason we always make sure that we never do any thing that
can sleep in a place after we have spin lock.

And as Paolo tells, all these if PREEMPTION is disabled. But in any case
if the signals are not handled then the processes are blocked.

Thanks and Best Regards,
KK
-----Original Message-----
From: Paolo Ornati [mailto:ornati@fastwebnet.it] 
Sent: Thursday, December 21, 2006 2:20 AM
To: Sorin Manolache
Cc: linux-kernel@vger.kernel.org
Subject: Re: newbie questions about while (1) in kernel mode and
spinlocks

On Thu, 21 Dec 2006 10:41:44 +0100
"Sorin Manolache" <sorinm@gmail.com> wrote:

> spin_lock(&lck);
> down(&sem); /* I know that one shouldn't sleep when holding a lock */
>                     /* but I want to understand why */

I suppose because the lock is held for an indefinite amount of time and
any other process that try to get that lock will "spin" and burn CPU
without doing anything useful (locking the process in kernel mode and
preventing the execution of other processes on that CPU if there
isn't any type of PREEMPTION).

:)

spin_lock is a "while(1) {...}" thing...

-- 
	Paolo Ornati
	Linux 2.6.20-rc1-g99f5e971 on x86_64
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
