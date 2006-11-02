Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752718AbWKBWw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbWKBWw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbWKBWw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:52:57 -0500
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:23439 "EHLO sMtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1752718AbWKBWw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:52:56 -0500
Date: Thu, 02 Nov 2006 23:53:00 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: New filesystem for Linux
In-reply-to: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <454A76CC.6030003@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka a écrit :
> Hi
> 
> As my PhD thesis, I am designing and writing a filesystem, and it's now 
> in a state that it can be released. You can download it from 
> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
> 
> It has some new features, such as keeping inode information directly in 
> directory (until you create hardlink) so that ls -la doesn't seek much, 
> new method to keep data consistent in case of crashes (instead of 
> journaling), free space is organized in lists of free runs and converted 
> to bitmap only in case of extreme fragmentation.
> 
> It is not very widely tested, so if you want, test it.
> 
> I have these questions:
> 
> * There is a rw semaphore that is locked for read for nearly all 
> operations and locked for write only rarely. However locking for read 
> causes cache line pingpong on SMP systems. Do you have an idea how to 
> make it better?
> 
> It could be improved by making a semaphore for each CPU and locking for 
> read only the CPU's semaphore and for write all semaphores. Or is there 
> a better method?
> 

If you believe you need a semaphore for protecting a mostly read structure, 
then RCU is certainly a good candidate. (ie no locked operation at all)

The problem with a per_cpu biglock is that you may consume a lot of RAM for 
big NR_CPUS. Count 32 KB per 'biglock' if NR_CPUS=1024

> * This leads to another observation --- on i386 locking a semaphore is 2 
> instructions, on x86_64 it is a call to two nested functions. Has it 
> some reason or was it just implementator's laziness? Given the fact that 
> locked instruction takes 16 ticks on Opteron (and can overlap about 2 
> ticks with other instructions), it would make sense to have optimized 
> semaphores too.

Hum, please dont use *lazy*, this could make Andi unhappy :)

What are you calling semaphore exactly ?
Did you read Documentation/mutex-design.txt ?



