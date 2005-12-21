Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVLUUgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVLUUgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLUUgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:36:42 -0500
Received: from smtpout.mac.com ([17.250.248.87]:22744 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964809AbVLUUgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:36:41 -0500
In-Reply-To: <200512211610.jBLGAW05003489@laptop11.inf.utfsm.cl>
References: <200512211610.jBLGAW05003489@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CB5409C3-80FE-4C6B-8E9C-0D3FEECD8384@mac.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Peter Williams <pwil3058@bigpond.net.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on interactive response
Date: Wed, 21 Dec 2005 15:36:24 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 21, 2005, at 11:10, Horst von Brand wrote:
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> On Dec 21, 2005, at 08:21, Trond Myklebust wrote:
>>> ...and if you stick in a faster server?...
>>> There is _NO_ fundamental difference between NFS and a local  
>>> filesystem that warrants marking one as "interactive" and the  
>>> other as "noninteractive". What you are basically saying is that  
>>> all I/O should be marked as TASK_NONINTERACTIVE.
>>
>> Uhh, what part of disk/NFS/filesystem access is "interactive"?   
>> Which of those sleeps directly involve responding to user- 
>> interface  events?
>
> And if it is a user waiting for the data to display? Can't  
> distinguish that so easily from the compiler waiting for something  
> to do...

No, but in that case the program probably _already_ has some  
interactivity bonus just from user interaction.  On the other hand,  
UI programming guidelines say that any task which might take more  
than a half-second or so should not be run in the event loop, but in  
a separate thread (either a drawing thread or similar).  In that  
case, your event loop thread is the one with the interactivity bonus,  
and the others are just data processing threads (like the compile you  
have running in the background or the webserver responding to HTTP  
requests), that the user would need to manually arbitrate between  
with nice levels.

The whole point of the interactivity bonus was that processes that  
follow the cycle <waiting-for-input> => <respond-to-input-for-less- 
than-time-quantum> => <waiting-for-input> would get a boost; things  
like dragging a window or handling mouse or keyboard events should  
happen within a small number of milliseconds, whereas background  
tasks really _don't_ care if they are delayed running their time  
quantum by 400ms, as long as they get their full quantum during each  
cycle.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


