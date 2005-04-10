Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVDJCxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVDJCxX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 22:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDJCxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 22:53:23 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:36702 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261286AbVDJCxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 22:53:14 -0400
Message-ID: <4258950C.1040903@yahoo.com.au>
Date: Sun, 10 Apr 2005 12:53:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <20050404191246.24b11158.akpm@osdl.org> <200504100328.53762.ctpm@rnl.ist.utl.pt>
In-Reply-To: <200504100328.53762.ctpm@rnl.ist.utl.pt>
Content-Type: multipart/mixed;
 boundary="------------060508040808090505070808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508040808090505070808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Claudio Martins wrote:
> On Tuesday 05 April 2005 03:12, Andrew Morton wrote:
> 
>>Claudio Martins <ctpm@rnl.ist.utl.pt> wrote:
>>
>>>   While stress testing 2.6.12-rc2 on an HP DL145 I get processes stuck
>>>in D state after some time.
>>>   This machine is a dual Opteron 248 with 2GB (ECC) on one node (the
>>>other node has no RAM modules plugged in, since this board works only
>>>with pairs).
>>>
>>>   I was using stress (http://weather.ou.edu/~apw/projects/stress/) with
>>>the following command line:
>>>
>>> stress -v -c 20 -i 12 -m 10 -d 20
>>>

[snip]

> ------------------------------------
> 
> 
>   Unfortunately the system Oopsed in the middle of dumping the tasks, but from 
> what I can see I'm tempted to think that this might be related to the MD 
> code. md2_raid1 is blocked on D state and, although not shown on the dump, I 
> know from ps command that md0_raid1 (the swap partition) was also on D state 
> (along with the stress processes which are responsible for hogging memory, 
> and top and df). There were about 200MB swapped out, but the swap partition 
> size is 1GB.
> 

Looks like you may possibly have a memory allocation deadlock
(although I can't explain the NMI oops).

I would be interested to see if the following patch is of any
help to you.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

--------------060508040808090505070808
Content-Type: text/plain;
 name="mempool-can-fail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempool-can-fail.patch"




Index: linux-2.6/mm/mempool.c
===================================================================
--- linux-2.6.orig/mm/mempool.c	2005-03-30 10:39:51.000000000 +1000
+++ linux-2.6/mm/mempool.c	2005-03-30 10:41:29.000000000 +1000
@@ -198,7 +198,10 @@ void * mempool_alloc(mempool_t *pool, in
 	void *element;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
-	int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
+	int gfp_nowait;
+	
+	gfp_mask |= __GFP_NORETRY; /* don't loop in __alloc_pages */
+	gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
 
 	might_sleep_if(gfp_mask & __GFP_WAIT);
 repeat_alloc:

--------------060508040808090505070808--

