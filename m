Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTKDR72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 12:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTKDR71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 12:59:27 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:2475 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262446AbTKDR70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 12:59:26 -0500
Message-ID: <3FA7E8F7.7060304@colorfullife.com>
Date: Tue, 04 Nov 2003 18:59:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John M Collins <jmc@xisl.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Semaphores and threads anomaly and bug?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:

>I know this isn't defined anywhere but the seems to be an ambiguity and 
>discrepancy between versions of Unix and Linux over threads and semaphores.
>
>Do the "SEM_UNDO"s get applied when a thread terminates or when the 
>"whole thing" terminates?
>  
>
According to the Unix spec: per-process.
Older Linux kernels applied it per-thread. Newer kernels can handle it 
per-process, and AFAIK it's the default for NPTL.

>I think that in ipc/sem.c line 1062 the line should be made 
>conditional on "u->semadj[i]" being non-zero.
>  
>
Fixed in 2.6. But there is another bug in that block: undos can increase 
the semaphore value above SEMVMX.

>There is a potential problem here in that the code in ipc/sem.c doesn't 
>allow the adjustment to yield a negative value but what if it starts at 
>zero, thread A increments it, thread B decrements it back to zero (both 
>with SEM_UNDO) and thread A exits first? Thread A's undo won't work and 
>then thread B's undo will increment it again leaving it in an incorrect 
>state which is different from thread B exiting first.
>  
>
Correct. undo operations should never try to decrease the semaphore 
value - an attempt to decrease below 0 is either silently ignored, or 
the semaphore value is set to 0.

--
    Manfred

