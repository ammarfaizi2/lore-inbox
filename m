Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVELBg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVELBg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 21:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVELBg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 21:36:27 -0400
Received: from main.gmane.org ([80.91.229.2]:11986 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261221AbVELBgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 21:36:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joe Seigh" <jseigh_02@xemaps.com>
Subject: Re: RCU + SMR for preemptive kernel/user threads.
Date: Wed, 11 May 2005 20:39:20 -0400
Message-ID: <opsqmz3uv3ehbc72@grunion>
References: <opsqivh7agehbc72@grunion> <opsqkajto6ehbc72@grunion> <20050510165512.GA1569@us.ibm.com> <opsqkzxij0ehbc72@grunion> <20050511150454.GA1343@us.ibm.com> <opsqmr52snehbc72@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005 17:47:52 -0400, Joe Seigh <jseigh_02@xemaps.com> wrote:

>
> But if you looked at the hazard pointer in the IPI interrupt handler,
> you could use that information to decide whether you had to wait an
> additional RCU interval.  So updater logic would be
>
>           1.  Set global pointer to NULL.  // make object unreachable
>           2.  Send IPIs  to all other CPUs
>               (IPI interrupt handler will copy CPU's hazard pointers)
>           3.  Check objects to be freed against copied hazard pointers.
>           4.  There is no step 4.  Even if the actual hazard pointers
>               that pointed to the object is NULL by this point (but not
>               its copy), you'd still have to wait and addtional RCU
>               interval so you might as well leave it out as redundant.
>
> This is better.  I may try that trick I used to make NPTL condvars
> faster to see if I can keep Linux user space version of this from
> tanking.  It uses unix signals instead of IPIs.
>

I should add that this is pretty close to deferred reference counting,
not the reference counting bit but that it differentiates between local
references and shared global references like RCU does.  It lets them
avoid having to stop the world to GC, just stop one thread at a time to
examine the stack.

-- 
Joe Seigh

