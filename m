Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWIKClg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWIKClg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 22:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWIKClg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 22:41:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62403 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751075AbWIKClf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 22:41:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: Rework the console spawning variables.
References: <m1mz98fj16.fsf@ebiederm.dsl.xmission.com>
	<20060910142942.GA7384@oleg>
	<m18xkreb42.fsf@ebiederm.dsl.xmission.com> <20060910203324.GA121@oleg>
	<m1slizcouy.fsf@ebiederm.dsl.xmission.com> <20060911010534.GA108@oleg>
Date: Sun, 10 Sep 2006 20:40:29 -0600
In-Reply-To: <20060911010534.GA108@oleg> (Oleg Nesterov's message of "Mon, 11
	Sep 2006 05:05:34 +0400")
Message-ID: <m17j0bcehu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 09/10, Eric W. Biederman wrote:
>>
>> Ok.  I think I see the where the confusion is.  We were looking
>> at different parts of the puzzle.  But I we need to resolve this
>> to make certain I didn't do something clever and racy.
>
> Yes, I think we misunderstood each other :)
>
>> As for the rest of your suggestion it would not be hard to be able to
>> follow a struct pid pointer in an rcu safe way, and we do in the pid
>> hash table.  In other contexts so far I always have other variables
>> that need to be updated in concert, so there isn't a point in coming
>> up with a lockless implementation.  I believe vt_pid is the only
>> case that I have run across where this is a problem and I have
>> at least preliminary patches for every place where signals are
>> sent.
>> 
>> Updating this old code is painful.
>
> No, no, we shouldn't change the old code, it is fine.
>
So what happens when:
cpu0:                         cpu1:
kill_pid(vt_pid,....)         fn_SAK()->vc_reset()->put_pid(xchg(&vt_pid, NULL))

Can't kill_pid dereference vt_pid after put_pid is called?

It's a microscopic window, and requires the user to attempt a vt switch
and a sak simultaneously but I think it is there.

Eric
