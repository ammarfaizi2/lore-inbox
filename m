Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWBPVhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWBPVhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBPVhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:37:23 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:29917 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932201AbWBPVhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:37:20 -0500
Date: Thu, 16 Feb 2006 22:35:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       drepper@redhat.com, tglx@linutronix.de, arjan@infradead.org,
       akpm@osdl.org
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-ID: <20060216213531.GC25738@elte.hu>
References: <20060216094130.GA29716@elte.hu> <1140107585.21681.18.camel@localhost.localdomain> <20060216172435.GC29151@elte.hu> <1140111257.21681.26.camel@localhost.localdomain> <20060216124758.d51befd5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216124758.d51befd5.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> That malicious code would have no need to have the kernel futext 
> handling code do its dirty work indirectly via manipulations of this 
> list.  It can just do the dirty work directly.
> 
> All Ingo needs to insure is that the kernel will assume no more 
> priviledge when reading/writing this list than the current task had, 
> from user space, reading/writing this list.

Correct, this is precisely what happens.

Furthermore, the new exit-time futex code within the kernel will do only 
one, very limited thing with userspace memory: it will atomically set 
bit 30 of a word at a userspace address (if the word is accessible to 
and writable by userspace), if and only if that word is equal to 
current->pid. This is really not the sort of memory writing capability 
attackers are looking for :-)

Btw., we already have a similar mechanism in the kernel (and had for 
years): the current->clear_child_tid pointer will be overwritten with 0 
by the kernel at do_exit() time, and causes a futex wakeup. See 
kernel/fork.c:mm_release():

        if (tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
                u32 __user * tidptr = tsk->clear_child_tid;
                tsk->clear_child_tid = NULL;

                /*
                 * We don't check the error code - if userspace has
                 * not set up a proper pointer then tough luck.
                 */
                put_user(0, tidptr);
                sys_futex(tidptr, FUTEX_WAKE, 1, NULL, NULL, 0);

So the concept is not unprecedented at all, nor did it ever cause any 
security problems [and i think i'd know - i wrote the above code too].  
And 'write 0' is slightly more interesting to attackers than 'set bit 30 
if word equals to TID'.

	Ingo
