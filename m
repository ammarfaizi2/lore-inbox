Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVHEPmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVHEPmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbVHEPgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:36:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8433 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263062AbVHEPfa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:35:30 -0400
Message-ID: <42F386C4.2080103@mvista.com>
Date: Fri, 05 Aug 2005 08:33:24 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Re: 2.6.12: itimer_real timers don't survive execve()
 any more
References: <42F28707.7060806@mvista.com> <20050804213416.1EA56180980@magilla.sf.frob.com> <20050804150251.5f4acb0a.akpm@osdl.org> <20050805084401.GA12145@bytesex>
In-Reply-To: <20050805084401.GA12145@bytesex>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
> On Thu, Aug 04, 2005 at 03:02:51PM -0700, Andrew Morton wrote:
> 
>>Roland McGrath <roland@redhat.com> wrote:
>>
>>>That's wrong.  It has to be done only by the last thread in the group to go.
>>>Just revert Ingo's change.
>>>
>>
>>OK..
>>
>>+++ 25-akpm/kernel/exit.c	Thu Aug  4 15:01:06 2005
>>@@ -829,8 +829,10 @@ fastcall NORET_TYPE void do_exit(long co
>>-	if (group_dead)
>>+	if (group_dead) {
>>+ 		del_timer_sync(&tsk->signal->real_timer);
>> 		acct_process(code);
>>+	}
>>+++ 25-akpm/kernel/posix-timers.c	Thu Aug  4 15:01:06 2005
>>@@ -1166,7 +1166,6 @@ void exit_itimers(struct signal_struct *
>>-	del_timer_sync(&sig->real_timer);
> 
> 
> That one fixes it for me.

There are other concerns.  Let me see if I understand this.  A thread 
(other than the leader) can exec and we then need to change the 
real_timer to wake the new task which will NOT be using the same task 
struct.

My looking at the code shows that the thread leader can exit and then 
stays around as a zombi until the last thread in the group exits.  If an 
alarm comes during this wait I suspect it will wake this zombi and cause 
problems.  So, don't we need to also change real_timer's task when the 
exiting task is the real_timer wake up task, assigning it to some other 
member of the group?  Note, I don't say just if it is the group leader...

Then when we finally release the signal structure, we can "del" the timer.

Did I miss something here?
> 
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
