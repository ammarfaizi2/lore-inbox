Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWBPV2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWBPV2l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWBPV2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:28:41 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:30116 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750960AbWBPV2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:28:41 -0500
Date: Thu, 16 Feb 2006 22:26:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-ID: <20060216212651.GB25738@elte.hu>
References: <20060216094130.GA29716@elte.hu> <1140107585.21681.18.camel@localhost.localdomain> <20060216172435.GC29151@elte.hu> <1140111257.21681.26.camel@localhost.localdomain> <20060216202357.GA21415@elte.hu> <Pine.LNX.4.64.0602161229390.30911@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602161229390.30911@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> 
> On Thu, 16 Feb 2006, Ingo Molnar wrote:
> >and? You can 'manipulate' arbitrary userspace memory, be that used by
> >the kernel or not, and you can do a sys_futex(FUTEX_WAKE) on any
> >arbitrary userspace memory address too (this is a core property of
> >futexes). You must have meant something specific when you said "on the
> >surface looks like a malicious users dream variable". In other words:
> >please move your statement out of innuendo by backing it up with
> >specifics (or by retracting it) - right now it's hanging in the air :)
> 
> 
> 	Sorry I didn't mean to leave something hanging out there. I was 
> just making an observation. The 'dream variable' comment was maybe a 
> little to much and I'll gladly retract that .. I'll replace it with , 
> I think the code needs more review in that area ..

basically, ->futex_offset is not blindly trusted by the kernel either: 
it's simply used to calculate a "userspace pointer" value, which it then 
uses in a (secure) get_user() access, to do a FUTEX_WAKEUP. [Note that 
FUTEX_WAKEUP is already done at do_exit() time via the ->clear_child_tid 
userspace pointer.] All in one: this is totally safe.

The purpose of ->futex_offset is to not hardcode glibc's data structure 
layout into the kernel. Since 'clean up after locks' is a relatively 
rare operation, it was the prudent thing to do.

We could also have registered the futex_offset in the kernel itself, but 
I didnt do it that way because that would add another word to 
task_struct (for the sake of an operation that is rare), and it would 
also make the sys_set_robust_list() operation a bit more expensive. So I 
minimized the API to only take a single userspace pointer, which pointer 
points to the robust_list_head structure which contains all data to 
continue. That data is never trusted and is handled very carefully.

	Ingo
