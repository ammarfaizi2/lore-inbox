Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWDHRQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWDHRQL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 13:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWDHRQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 13:16:11 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:60297 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965024AbWDHRQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 13:16:10 -0400
Date: Sun, 9 Apr 2006 01:13:08 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] de_thread: fix deadlockable process addition
Message-ID: <20060408211308.GA1845@oleg>
References: <20060406220403.GA205@oleg> <m1acay1fbh.fsf@ebiederm.dsl.xmission.com> <20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org> <20060407155619.18f3c5ec.akpm@osdl.org> <m1d5fslcwx.fsf@ebiederm.dsl.xmission.com> <20060408172745.GA89@oleg> <m1r748jbju.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r748jbju.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08, Eric W. Biederman wrote:
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > This change can confuse next_tid(), but this is minor.
> > I don't see other problems.
> 
> next_tid?

proc_task_readdir:

	first_tid() returns old_leader

	next_tid()  returns new_leader
	
						de_thread:
							old_leader->group_leader = new_leader;

	
	next_rid()  returns old_leader again,
	because it is not thread_group_leader()
	anymore
			

> This means your patch doesn't go far enough.  We should be
> able to kill all of the parent list manipulation in
> de_thread.   Doing reduces the places that assign
> real_parent to just fork and exit.

Yes!

I think I understand why we had the reason to reparent 'leader'
in the past. We used to set leader->exit_state = EXIT_ZOMBIE,
so without reparenting current's parent could have a bogus do_wait()
result if this do_wait() happens before release_task(leader).

Now we set leader->exit_state = EXIT_DEAD, which means this task
is not visible to do_wait().

Oleg.

