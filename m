Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbULIR01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbULIR01 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbULIR01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:26:27 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:7345 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261480AbULIR0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:26:19 -0500
Message-ID: <41B88AA2.6070603@colorfullife.com>
Date: Thu, 09 Dec 2004 18:25:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Kerrisk <mtk-lkml@gmx.net>
CC: alan@redhat.com, michael.kerrisk@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: System V semaphore bug in kernel 2.6
References: <25686.1102607983@www38.gmx.net>
In-Reply-To: <25686.1102607983@www38.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kerrisk wrote:

>Hello Manfred, Alan,
>
>I assume you are still the relevant people to know about 
>this nowadays...
>
>Somewhere in the reworking of the System V semaphore code 
>(ipc/sem.c or nearby) in Linux 2.6, a bug appears to have 
>been introduced.  
>
>  
>
ipc/sem.c. The change that now semaphores are actively given to the 
waiting task broke your test.

What happens is:

child 3 does a semaphore operation. It succeeds. update_queue is called:
- try_atomic_semop checks if it can wake up child 2. Answer: No.
- try_atomic_semop(): kernel checks if it can wake up child 1. Answer: Yes.

Bug: It must now check again if there is a thread that is waiting for 
semaphore value==0. This check is now missing. In 2.4, there was another 
round of update_queue calls just before child 1 returns to user space. 
That call then wakes up child 1. This call was removed.

One approach to fix that is a loop in update_queue: If a 
try_atomic_semop call from within update_queue modified the array, then 
check again from the beginning of the queue.

What do you think? I'll write a patch.

--
    Manfred
