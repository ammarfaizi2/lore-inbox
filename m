Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbTF0T3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 15:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTF0T3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 15:29:07 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:5063 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264706AbTF0T3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 15:29:05 -0400
Message-ID: <3EFC9E4F.9070405@colorfullife.com>
Date: Fri, 27 Jun 2003 21:43:11 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ipc semaphore optimization
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen wrote:

>What we are proposing here is to merge the portion of the code in the
>bottom part of sys_semtimedop() (code that gets executed when a sleeping
>process gets woken up) into update_queue() function.  The benefit is two
>folds: (1) is to reduce redundant calls to try_atomic_semop() and (2) to
>increase efficiency of finding eligible processes to wake up and higher
>concurrency for multiple wake-ups.
>  
>
Interesting. I'm not sure if you noticed it, but your patch backs out a 
change from Christoph Rohland from 1998, probably from SAP DB benchmarking:

linux/ipc/sem.c:
 * - The previous code had two flaws:
 *   1) It actively gave the semaphore to the next waiting process
 *      sleeping on the semaphore. Since this process did not have the
 *      cpu this led to many unnecessary context switches and bad
 *      performance. Now we only check which process should be able to
 *      get the semaphore and if this process wants to reduce some
 *      semaphore value we simply wake it up without doing the
 *      operation. So it has to try to get it later. Thus e.g. the
 *      running process may reacquire the semaphore during the current
 *      time slice. If it only waits for zero or increases the semaphore,
 *      we do the operation in advance and wake it up.

Perhaps the O(1) scheduler is better at handling the thread switches 
than the old scheduler. Could you include an update of the comments into 
your patch?

--
    Manfred

