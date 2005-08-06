Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVHFAwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVHFAwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVHFAwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:52:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40186 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262122AbVHFAwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:52:15 -0400
Message-ID: <42F40940.9040607@mvista.com>
Date: Fri, 05 Aug 2005 17:50:08 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: Gerd Knorr <kraxel@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Re: 2.6.12: itimer_real timers don't survive execve()
 any more
References: <20050805221041.D574B180988@magilla.sf.frob.com>
In-Reply-To: <20050805221041.D574B180988@magilla.sf.frob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:
>>There are other concerns.  Let me see if I understand this.  A thread 
>>(other than the leader) can exec and we then need to change the 
>>real_timer to wake the new task which will NOT be using the same task 
>>struct.
> 
> 
> That's correct.  de_thread will turn the thread calling exec into the new
> leader and kill off all the other threads, including the old leader.  The
> exec'ing thread's existing task_struct is reassigned to the PID of the
> original leader.
> 
> 
>>My looking at the code shows that the thread leader can exit and then 
>>stays around as a zombi until the last thread in the group exits.  
> 
> 
> That is correct.
> 
> 
>>If an alarm comes during this wait I suspect it will wake this zombi and
>>cause problems.
> 
> 
> You are mistaken.  The signal code handles process signals sent when the
> leader is a zombie.  The group leader sticks around with the PID that
> matches the TGID, until there are no live threads with its TGID.  That is
> how process-wide kill can still work.

Yes, I see, traced through the signal delivery.  So Linus' patch as well 
as the regression of Ingo's will fix all of this.  Right?

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
