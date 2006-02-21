Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161455AbWBUJYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161455AbWBUJYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 04:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161453AbWBUJYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 04:24:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:980 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161452AbWBUJYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 04:24:00 -0500
Date: Tue, 21 Feb 2006 04:23:38 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Paul Jackson <pj@sgi.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V4
Message-ID: <20060221092338.GV24295@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060221084631.GA5506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221084631.GA5506@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 09:46:31AM +0100, Ingo Molnar wrote:
> 
> This is release -V4 of the "lightweight robust futexes" patchset. The 
> patchset can also be downloaded from:
> 
>   http://redhat.com/~mingo/lightweight-robust-futexes/
> 
> no big changes - docs updates and the tidying of futex_atomic_cmpxchg() 
> semantics.

To me the registering of thread's robust_list_head address is very
similar to registering thread's tid address and will be needed at the same
time (i.e. during program startup, when thread library is being initialized,
and upon thread creation), so I'd say we should register it the same
way as tid address and save a syscall per thread creation and a syscall
per process start.

TID address is registered through:
pid_t set_tid_address (int *tidptr)
syscall, so IMHO we should add a new syscall
pid_t set_tid_robust_addresses (int *tidptr, struct robust_list_head *robustptr)
which could register both tid and robust addresses.

For thread creation, we can just add CLONE_CHILD_SETROBUST clone flag
and if that flag is set, pass struct robust_list_head * as additional
argument.

The `len' argument (or really revision of the structure if really needed)
can be encoded in the structure, as in:
struct robust_list_head {
       struct robust_list list;
       short robust_list_head_len; /* or robust_list_head_version ? */
       short futex_offset;
       struct robust_list __user *list_op_pending;
};
or with long futex_offset, but using say upper 8 bits of the field as
version or length.

What do you think?

	Jakub
