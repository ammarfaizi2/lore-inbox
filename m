Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWHZBYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWHZBYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 21:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWHZBYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 21:24:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:307 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751498AbWHZBYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 21:24:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gkk2+hfn0Kl9YbKxEAyS0RjgWe63C5cUuNvCRtSjJ1iKnHWpUNvB8NGf1orVpQKCxUqduGpnRo8f1JsXRwnL8DZcD8XFlB0XRwdDNg2ttH35LPmhKVWswpC55edSs7XEoyC4TfzEEDv00SAIdcx5YJNZa8w4wf91g9IUoF9ODE0=
Message-ID: <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com>
Date: Fri, 25 Aug 2006 18:24:29 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Cc: "Esben Nielsen" <nielsen.esben@gmail.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060825071957.GA30720@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060818115934.GA29919@gnuppy.monkey.org>
	 <20060822013722.GA628@gnuppy.monkey.org>
	 <20060822232051.GA8991@gnuppy.monkey.org>
	 <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com>
	 <20060823202046.GA17267@gnuppy.monkey.org>
	 <20060823210558.GA17606@gnuppy.monkey.org>
	 <20060823210842.GB17606@gnuppy.monkey.org>
	 <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com>
	 <20060824014658.GB19314@gnuppy.monkey.org>
	 <20060825071957.GA30720@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
>         http://mmlinux.sourceforge.net/public/against-2.6.17-rt8-2.diff

It compiled a kernel through once, but died on a 2nd try.

The trace is the usual one, I believe.

kjournald/1061[CPU#1]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:471

Call Trace:
       <ffffffff80261783>{_raw_spin_lock_irqsave+29}
       <ffffffff80280e0f>{__WARN_ON+123}
       <ffffffff80280dca>{__WARN_ON+54}
       <ffffffff8029617d>{debug_rt_mutex_unlock+199}
       <ffffffff80260ef9>{rt_lock_slowunlock+25}
       <ffffffff80261489>{__lock_text_start+9}
       <ffffffff8020a188>{kmem_cache_alloc+202}
       <ffffffff8029facd>{mempool_alloc_slab+17}
       <ffffffff802222fe>{mempool_alloc+75}
       <ffffffff80261b9c>{_raw_spin_unlock+46}
       <ffffffff80260f21>{rt_lock_slowunlock+65}
       <ffffffff80219d12>{bio_alloc_bioset+35}
       <ffffffff802b58df>{bio_clone+29}
       <ffffffff803a5aaa>{clone_bio+51}
       <ffffffff803a6762>{__split_bio+399}
       <ffffffff803a6f53>{dm_request+453}
       <ffffffff8021b422>{generic_make_request+375}
       <ffffffff80232b9d>{submit_bio+192}
       <ffffffff80219c60>{submit_bh+262}
       <ffffffff802166d6>{ll_rw_block+161}
       <ffffffff802ec4ea>{journal_commit_transaction+990}
       <ffffffff80261b9c>{_raw_spin_unlock+46}
       <ffffffff80260f21>{rt_lock_slowunlock+65}
       <ffffffff80261489>{__lock_text_start+9}
       <ffffffff8024b490>{try_to_del_timer_sync+85}
       <ffffffff802f0904>{kjournald+199}
       <ffffffff8028f4b1>{autoremove_wake_function+0}
       <ffffffff802f083d>{kjournald+0}
       <ffffffff8028f2ad>{keventd_create_kthread+0}
       <ffffffff802321c0>{kthread+219}
       <ffffffff80226903>{schedule_tail+185}
       <ffffffff8025d2e6>{child_rip+8}
       <ffffffff8028f2ad>{keventd_create_kthread+0}
       <ffffffff802320e5>{kthread+0}
       <ffffffff8025d2de>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff802616bd>] .... _raw_spin_lock+0x16/0x23
.....[<ffffffff80260ef1>] ..   ( <= rt_lock_slowunlock+0x11/0x6b)
.. [<ffffffff80261783>] .... _raw_spin_lock_irqsave+0x1d/0x2e
.....[<ffffffff80280dca>] ..   ( <= __WARN_ON+0x36/0xa2)

And I should've noted this before, but in general, I use icecream

http://en.opensuse.org/Icecream

to compile stuff.  I have been able to reproduce the identical problem
without it, but it is another variable.  Sorry for the omission.


I also feel like I should be doing more, so I built a vanilla
2.6.17-rt8 kernel with the more limited set of config options I've
used on the most recent patches, but I also built this as a
uni-processor config.  On the uni-processor kernel with icecream
disabled and while building a kernel with a simple 'make',  I received
the following BUG, but the machine kept on going:

BUG: scheduling while atomic: make/0x00000001/20884

Call Trace:
       <ffffffff802fbc2e>{plist_check_head+60}
       <ffffffff8025d2eb>{__schedule+155}
       <ffffffff8028f06a>{task_blocks_on_rt_mutex+643}
       <ffffffff8020efda>{__mod_page_state_offset+25}
       <ffffffff802871de>{find_task_by_pid_type+24}
       <ffffffff8020efda>{__mod_page_state_offset+25}
       <ffffffff8025dad7>{schedule+236}
       <ffffffff8025e96d>{rt_lock_slowlock+416}
       <ffffffff8025f4b8>{rt_lock+13}
       <ffffffff8020efda>{__mod_page_state_offset+25}
       <ffffffff8029ab91>{__free_pages_ok+336}
       <ffffffff8022c07e>{__free_pages+47}
       <ffffffff80233bb0>{free_pages+128}
       <ffffffff802580df>{free_task+26}
       <ffffffff80245b52>{__put_task_struct+182}
       <ffffffff8025d86e>{thread_return+163}
       <ffffffff8025dad7>{schedule+236}
       <ffffffff80245ff1>{pipe_wait+111}
       <ffffffff802893ac>{autoremove_wake_function+0}
       <ffffffff8025e7c8>{rt_mutex_lock+50}
       <ffffffff8022ce81>{pipe_readv+785}
       <ffffffff8025eaa6>{rt_lock_slowunlock+98}
       <ffffffff8025f4a9>{__lock_text_start+9}
       <ffffffff802aea38>{pipe_read+30}
       <ffffffff8020afae>{vfs_read+171}
       <ffffffff8020fdbc>{sys_read+71}
       <ffffffff8025994e>{system_call+126}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8025d303>] .... __schedule+0xb3/0x57b
.....[<ffffffff8025dad7>] ..   ( <= schedule+0xec/0x11a)

Of 4 total attempts this way, two completed with no problems, one had
the BUG above, and yet another had two BUGs (below), but also
continued.

BUG: scheduling while atomic: make/0x00000001/14632

Call Trace:
       <ffffffff802fbc2e>{plist_check_head+60}
       <ffffffff8025d2eb>{__schedule+155}
       <ffffffff8028f06a>{task_blocks_on_rt_mutex+643}
       <ffffffff8020efda>{__mod_page_state_offset+25}
       <ffffffff802871de>{find_task_by_pid_type+24}
       <ffffffff8020efda>{__mod_page_state_offset+25}
       <ffffffff8025dad7>{schedule+236}
       <ffffffff8025e96d>{rt_lock_slowlock+416}
       <ffffffff8025f4b8>{rt_lock+13}
       <ffffffff8020efda>{__mod_page_state_offset+25}
       <ffffffff8029ab91>{__free_pages_ok+336}
       <ffffffff8022c07e>{__free_pages+47}
       <ffffffff80233bb0>{free_pages+128}
       <ffffffff802580df>{free_task+26}
       <ffffffff80245b52>{__put_task_struct+182}
       <ffffffff8025d86e>{thread_return+163}
       <ffffffff8025dad7>{schedule+236}
       <ffffffff80245ff1>{pipe_wait+111}
       <ffffffff802893ac>{autoremove_wake_function+0}
       <ffffffff8025e7c8>{rt_mutex_lock+50}
       <ffffffff8022ce81>{pipe_readv+785}
       <ffffffff8025eaa6>{rt_lock_slowunlock+98}
       <ffffffff8025f4a9>{__lock_text_start+9}
       <ffffffff802aea38>{pipe_read+30}
       <ffffffff8020afae>{vfs_read+171}
       <ffffffff8020fdbc>{sys_read+71}
       <ffffffff8025994e>{system_call+126}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8025d303>] .... __schedule+0xb3/0x57b
.....[<ffffffff8025dad7>] ..   ( <= schedule+0xec/0x11a)

BUG: scheduling while atomic: make/0x00000001/23043

Call Trace:
       <ffffffff802fbc2e>{plist_check_head+60}
       <ffffffff8025d2eb>{__schedule+155}
       <ffffffff8028f06a>{task_blocks_on_rt_mutex+643}
       <ffffffff8029a81b>{free_pages_bulk+42}
       <ffffffff802871de>{find_task_by_pid_type+24}
       <ffffffff8029a81b>{free_pages_bulk+42}
       <ffffffff8025dad7>{schedule+236}
       <ffffffff8025e96d>{rt_lock_slowlock+416}
       <ffffffff8025f4b8>{rt_lock+13}
       <ffffffff8029a81b>{free_pages_bulk+42}
       <ffffffff8029abf7>{__free_pages_ok+438}
       <ffffffff8022c07e>{__free_pages+47}
       <ffffffff80233bb0>{free_pages+128}
       <ffffffff802580df>{free_task+26}
       <ffffffff80245b52>{__put_task_struct+182}
       <ffffffff80225900>{schedule_tail+152}
       <ffffffff80259845>{ret_from_fork+5}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8025ea5a>] .... rt_lock_slowunlock+0x16/0xba
.....[<ffffffff8025f4a9>] ..   ( <= __lock_text_start+0x9/0xb)


I also tried the compile with icecream running, and the machine simply
wudged during each of three attempts, once almost instantly.  I was
able to use the sysrq keys (but nothing else: couldn't get the
capslock light when I toggled that key), and I dumped all the task
info.  It's A LOT, since I was building with 'make -j40' or something.
 I will probably try and put it up on my little webserver once I get
home (I have no mechanism here).

Is there anything else you want me to try: I can probably wave a
chicken over the machine or get some black candles or something?

-- 
Robert Crocombe
rcrocomb@gmail.com
