Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTINOIu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 10:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbTINOIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 10:08:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:15251 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261153AbTINOIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 10:08:49 -0400
Date: Sun, 14 Sep 2003 15:08:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Felipe W Damasio <felipewd@terra.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier
Message-ID: <20030914140839.GC16525@mail.jlokier.co.uk>
References: <3F620E61.4080604@terra.com.br> <20030914114054.CC7CE2C0A7@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914114054.CC7CE2C0A7@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> I personally *HATE* the set_task_state()/__set_task_state() macros.
> Simple assignments shouldn't be hidden behind macros, unless there's
> something really subtle involved.

There _is_ something subtle involved.  Back in ye olde days, folk
would set current->state directly.  Andrea Arcangeli noticed a subtle
race condition, where a memory barrier is needed after assigning the
state and before testing whatever condition the task is waiting on,
otherwise the state could be written after the condition was tested.

That's when all assignments to current->state were changed to
set_task_state().

Sprinkling special kinds of memory barrier into all the drivers is not
the kind of thing driver writers get right.  Also if you look at the
details, the barrier is quite an unusual kind on i386, using the
"xchg" instruction, and it only needs to be a CPU barrier on SMP
systems.

> Personally, when there's a normal and a __ version of a function, I
> use the normal version unless there's a real (performance or
> correctness) reason.  (ie. I prefer the "think less" version 8).

It's always correct to use the "normal" version of set_task_state().

The places where __set_task_state() is used are performance tweaks,
because the memory barrier is not for free.  That's why you see it
throughout "core" kernel code, where the authors devote more energy to
thinking about the SMP subtleties.

-- Jamie
