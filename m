Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbTIJSmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbTIJSmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:42:32 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:1677 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262684AbTIJSma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:42:30 -0400
Message-ID: <3F5F7073.4010009@colorfullife.com>
Date: Wed, 10 Sep 2003 20:41:55 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luca Veraldi" <luca.veraldi@katamail.com>
CC: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Efficient IPC mechanism on Linux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Hi Luca,
>There was a zero-copy pipe implementation floating around a while ago
>I think. Did you have a look at that? IIRC it had advantages and
>disadvantages over regular pipes in performance.
>
It has doesn't have any performance disadvantages over regular pipes.
The problems is that it only helps for lmbench. Real world apps use 
buffered io, which uses PAGE_SIZEd buffers, which mandate certain 
atomicity requirements, which limits the gains that can be achieved.
If someone wants to try it again I can search for my patches.
Actually there are two independant improvements that are possible for 
the pipe code:
- zero-copy. The name is misleading. In reality this does a single copy: 
the sender creates a list of the pages with the data instead of copying 
the data to kernel buffers. The receiver copies from the pages directly 
to user space. The main advantage is that this implementation avoids one 
copy without requiring any tlb flushes. It works with arbitrary aligned 
user space buffers.
- use larger kernel buffers. Linux uses a 4 kB internal buffer. The 
result is a very simple implementation that causes an incredible amount 
of context switches. Larger buffers reduce that. The problem is 
accounting, and avoiding to use too much memory for the pipe buffers. A 
patch without accounting should be somewhere. The BSD unices have larger 
pipe buffers, and a few pipes with huge buffers [perfect for lmbench 
bragging].

Luca: An algorithm that uses page flipping, or requires tlb flushes, 
probably performs bad in real-world scenarios. First you have the cost 
of the tlb flush, then the inter-processor-interrupt to flush all cpus 
on SMP. And if the target app doesn't expect that you use page flipping, 
then you get a page fault [with another tlb flush], to break the COW 
share. OTHO if you redesign the app for page flipping, then it could 
also use sysv shm, and send a short message with a pointer to the shm 
segment.

--
    Manfred

