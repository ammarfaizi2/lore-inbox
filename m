Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVLUGc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVLUGc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 01:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVLUGc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 01:32:56 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:57413 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932286AbVLUGcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 01:32:55 -0500
Message-ID: <43A8F714.4020406@bigpond.net.au>
Date: Wed, 21 Dec 2005 17:32:52 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on	interactive
 response
References: <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org>
In-Reply-To: <1135145341.7910.17.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Dec 2005 06:32:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2005-12-21 at 17:00 +1100, Peter Williams wrote:
> 
>>This patch addresses the adverse effect that the NFS client can have on 
>>interactive response when CPU bound tasks (such as a kernel build) 
>>operate on files mounted via NFS.  (NB It is emphasized that this has 
>>nothing to do with the effects of interactive tasks accessing NFS 
>>mounted files themselves.)
>>
>>The problem occurs because tasks accessing NFS mounted files for data 
>>can undergo quite a lot of TASK_INTERRUPTIBLE sleep depending on the 
>>load on the server and the quality of the network connection.  This can 
>>result in these tasks getting quite high values for sleep_avg and 
>>consequently a large priority bonus.  On the system where I noticed this 
>>problem they were getting the full 10 bonus points and being given the 
>>same dynamic priority as genuine interactive tasks such as the X server 
>>and rythmbox.
>>
>>The solution to this problem is to use TASK_NONINTERACTIVE to tell the 
>>scheduler that the TASK_INTERRUPTIBLE sleeps in the NFS client and 
>>SUNRPC are NOT interactive sleeps.
> 
> 
> Sorry. That theory is just plain wrong. ALL of those case _ARE_
> interactive sleeps.

It's not a theory.  It's a result of observing a -j 16 build with the 
sources on an NFS mounted file system with top with and without the 
patches and comparing that with the same builds with the sources on a 
local file system.  Without the patches the tasks in the kernel build 
all get the same dynamic priority as the X server and other interactive 
programs when the sources are on an NFS mounted file system.  With the 
patches they generally have dynamic priorities between 6 to 10 higher 
than the X server and other interactive programs.

In both cases, when the build is run on a source on a local file system 
the kernel build tasks all have dynamic priorities 6 to 10 higher than 
the X server and other interactive programs.

In all cases, the dynamic priorities of the X server and other 
interactive programs are the same.

In the testing that I have done so far the patch has not resulted in any 
genuine interactive tasks not being identified as interactive.


Peter
PS There's a difference between interruptible and interactive in that 
while all interactive sleeps will be interruptible not all interruptible 
sleeps are interactive.  Ingo introduced TASK_NONINTERACTIVE to enable 
this distinction to be made.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
