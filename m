Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWIJULi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWIJULi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWIJULi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:11:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14516 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964866AbWIJULh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:11:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: Rework the console spawning variables.
References: <m1mz98fj16.fsf@ebiederm.dsl.xmission.com>
	<20060910142942.GA7384@oleg>
Date: Sun, 10 Sep 2006 14:10:37 -0600
In-Reply-To: <20060910142942.GA7384@oleg> (Oleg Nesterov's message of "Sun, 10
	Sep 2006 18:29:42 +0400")
Message-ID: <m18xkreb42.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 09/09, Eric W. Biederman wrote:
>> 
>> This patch does several things.
>> - The variables used are moved into a structure and declared in vt_kern.h
>> - A spinlock is added so we don't have SMP races updating the values.
>> - Instead of raw pid_t value a struct_pid is used to guard against
>>   pid wrap around issues, if the daemon to spawn a new console dies.
>
> I am not arguing against this patch, but it's a pity we can't use 'struct pid'
> lockless. What dou you think about this:

Actually with xchg I can use a reference counted struct pid lockless.
In the general case you have more then one variable you want to keep
in sync and you need the lock for that.

rcu is definitely not the solution in these cases as the struct pid
is stored for a long time so we need the reference count.

It might make sense to have some helper code makes that wraps
the following line so it is obvious you can do this.

put_pid(xchg(&vc->vt_pid, get_pid(task_pid(current))));

Perhaps:
void update_pid(struct pid **ref, struct pid *new)
{
        struct pid *old;
        get_pid(new);
        old = xchg(ref, new);
        put_pid(old);
}

But since I can write it as a moderately clear one liner in the
case that matters I don't much care.

Eric
