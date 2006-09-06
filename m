Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964769AbWIFWoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWIFWoQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWIFWoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:44:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42695 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964769AbWIFWoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:44:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jean Delvare <jdelvare@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] proc: readdir race fix (take 3)
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1ac5e2woe.fsf_-_@ebiederm.dsl.xmission.com>
	<200609061101.11544.jdelvare@suse.de>
	<200609062312.57774.jdelvare@suse.de>
Date: Wed, 06 Sep 2006 16:43:09 -0600
In-Reply-To: <200609062312.57774.jdelvare@suse.de> (Jean Delvare's message of
	"Wed, 6 Sep 2006 23:12:57 +0200")
Message-ID: <m1zmdcty4i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <jdelvare@suse.de> writes:

> On Wednesday 6 September 2006 11:01, Jean Delvare wrote:
>> Eric, Kame, thanks a lot for working on this. I'll be giving some good
>> testing to this patch today, and will return back to you when I'm done.
>
> The original issue is indeed fixed, but there's a problem with the patch. 
> When stressing /proc (to verify the bug was fixed), my test machine ended 
> up crashing. Here are the 2 traces I found in the logs:

Ugh.  

So the death in __put_task_struct() is from:
WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
So it appears we have something that is decrementing but not
incrementing the count on the task struct.

Now what is interesting is that there are a couple of other failure modes
present here.
free_uid called from __put_task_struct is failing


And you seem to have a recursive page fault going on somewhere.

I suspect the triggering of this bug is the result of an earlier oops,
that left some process half cleaned up.

Have you tested 2.6.18-rc6 without my patch?
If not can you please test the same 2.6.18-rc6 configuration with my patch?

> Sometimes the machine just hung, with nothing in the logs. The machine is 
> a Sony laptop (i686).
>
> I have been testing the patch on another machine (x86_64) and had no 
> problem at all, so the reproduceability of the bug might depend on the 
> arch or some config option. I'll help nailing down this issue if I can, 
> just tell me what to do.

So I don't know what is going on with your laptop.  It feels nasty.

I think my patch is just tripping on the problem, rather than causing
it.  The previous version of fs/proc/base.c should have tripped over
this problem as well if it happened to have hit the same process.

I'm staring at the patch and I can not think of anything that would
explain your problem.  The reference counting is simple and the only
bug I had in a posted version was a failure to decrement the count
on the task_struct.

I guess the practical question is what was your test methodology to
reproduce this problem?  A couple of more people running the same
test on a few more machines might at least give us confidence in what
is going on.

Eric
