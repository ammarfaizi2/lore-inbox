Return-Path: <linux-kernel-owner+w=401wt.eu-S1752418AbWLQLX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbWLQLX7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 06:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbWLQLX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 06:23:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38286 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbWLQLX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 06:23:58 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@infradead.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kill_something_info: misc cleanups
References: <20061216200510.GA5535@tv-sign.ru>
	<20061217101856.GA1285@infradead.org>
Date: Sun, 17 Dec 2006 04:22:48 -0700
In-Reply-To: <20061217101856.GA1285@infradead.org> (Christoph Hellwig's
	message of "Sun, 17 Dec 2006 10:18:56 +0000")
Message-ID: <m18xh6u5pz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Sat, Dec 16, 2006 at 11:05:10PM +0300, Oleg Nesterov wrote:
>>  static int kill_something_info(int sig, struct siginfo *info, int pid)
>>  {
>>  	int ret;
>> +
>> +	rcu_read_lock();
>> +	if (pid > 0) {
>> +		ret = kill_pid_info(sig, info, find_pid(pid));
>> +	} else if (pid == -1) {
>> +		struct task_struct *p;
>> +		int found = 0;
>> +
>> +		ret = 0;
>> +		read_lock(&tasklist_lock);
>> +		for_each_process(p)
>> +			if (!is_init(p) && p != current->group_leader) {
>> +				int err = group_send_sig_info(sig, info, p);
>> +				if (err != -EPERM)
>> +					ret = err;
>> +				found = 1;
>> +			}
>> +		read_unlock(&tasklist_lock);
>> +		if (!found)
>> +			ret = -ESRCH;
>
> This branch should probably be factored out into a helper of it's own:

The proper name would be something like kill_all_info().  As we are
talking about the group of all processes.

I am sitting here wondering why we bother to ignore init, as init
is protected from all signals it doesn't explicitly setup a signal
handler for.  It is probably worth taking a quick look at the common
shutdown scripts and sysv init and see if anything actually cares if
we simply remove the is_init check.

The only two signals I know that are commonly handled this way
are kill(-1, SIGTERM) and kill(-1, SIGKILL);

And a very quick look at sysvinit-2.86 shows that it doesn't setup a
handler for SIGTERM.  So I believe we can delete we can delete
the is_init check entirely without changing anything and with a less
surprising if anyone ever cares.

>> +	} else {
>> +		struct pid *grp = task_pgrp(current);
>> +		if (pid != 0)
>> +			grp = find_pid(-pid);
>> +		ret = kill_pgrp_info(sig, info, grp);
>> +	}
>
> This also looks rather unreadable, an
>
> 	} else if (pid) {
> 		ret = kill_pgrp_info(sig, info, find_pid(-pid));
> 	} else {
> 		ret = kill_pgrp_info(sig, info, task_pgrp(current));
> 	}
>
> might be slightly more code, but also a lot more readable.

And that part is basically what we have now, just reshuffled.

Eric
