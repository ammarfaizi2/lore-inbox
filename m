Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVKWUct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVKWUct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVKWUcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:32:48 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:51947 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932437AbVKWUcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:32:04 -0500
Message-ID: <4384D17C.4040902@mvista.com>
Date: Wed, 23 Nov 2005 12:30:52 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: paulmck@us.ibm.com, Roland McGrath <roland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, mingo@elte.hu,
       suzannew@cs.pdx.edu
Subject: Re: Thread group exec race -> null pointer... HELP
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com> <436E1401.920A83EE@tv-sign.ru> <437BC01D.60302@mvista.com> <43826FDC.8010401@mvista.com> <43832F1D.F56D1C00@tv-sign.ru>
In-Reply-To: <43832F1D.F56D1C00@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> George Anzinger wrote:
> 
>>Still rooting around in the above.  The test program is attached.  It
>>creates and arms a repeating timer and then clones a thread which does
>>an exec() call.
> 
> 
> This patch:
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113138286512847
> 
> was intended to fix exactly this problem (and the same test program was
> used to exploit the race and test the fix).
> 
> So, it does not help? I can't reproduce the problem.

Yes, it does fix it.  Somehow I missed the posting of that patch.
> 
> Note: I think you also need this patch:
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113059955626598
> 
> otherwise I beleive OOPS can happen while killing this program if you are
> running the kernel with this change applied:
> 
> 	[PATCH] Call exit_itimers from do_exit, not __exit_signal
> 	http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=25f407f0b668f5e4ebd5d13e1fb4306ba6427ead
> 
> 
> 
>>first instance of this, we see that the thread-group leader is dead
>>and the exec code at line ~718 is setting the old leaders group-leader
>>to him self.
> 
> 
> I think this code at line ~718
> 
> 	leader->group_leader = leader;
> 
> is noop, because leader->group_leader == leader here.
> 
> 
>>-               leader->group_leader = leader;
>>+               leader->group_leader = current;
> 
> 
> This can't help, without SIGEV_THREAD_ID we don't check ->group_leader,
> the signal goes to the thread group via timer->it_process, which is equal
> to the old leader.

The signal code returns <0 so posix-timers digs into up the 
group_leader and trys again.  Still, the patch fixes it all.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
