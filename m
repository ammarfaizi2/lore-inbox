Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbSI2Ar0>; Sat, 28 Sep 2002 20:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262359AbSI2Ar0>; Sat, 28 Sep 2002 20:47:26 -0400
Received: from holomorphy.com ([66.224.33.161]:9648 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262358AbSI2Ar0>;
	Sat, 28 Sep 2002 20:47:26 -0400
Date: Sat, 28 Sep 2002 17:50:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: John Levon <movement@marcelothewonderpenguin.com>,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Sleeping function called from illegal context...
Message-ID: <20020929005019.GD22942@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>,
	John Levon <movement@marcelothewonderpenguin.com>,
	linux-kernel@vger.kernel.org, akpm@digeo.com
References: <20020927233044.GA14234@kroah.com> <1033174290.23958.17.camel@phantasy> <20020928145418.GB50842@compsoc.man.ac.uk> <3D95E14D.9134405C@digeo.com> <20020928172449.GA54680@compsoc.man.ac.uk> <1033237664.22582.167.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief emssage
Content-Disposition: inline
In-Reply-To: <1033237664.22582.167.camel@phantasy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 13:24, John Levon wrote:
>> NMI interrupt handler cannot block so it trylocks against a spinlock
>> instead. Buffer processing code needs to block against concurrent NMI
>> interrupts so takes the spinlock for them. All actual blocks on the
>> spinlock are beneath a down() on another semaphore, so a sleep whilst
>> holding the spinlock won't actually cause deadlock.

On Sat, Sep 28, 2002 at 02:27:44PM -0400, Robert Love wrote:
> If all accesses to the spinlock are taken under a semaphore, then the
> spinlock is not needed (i.e. the down'ed semaphore provides the same
> protection), or am I missing something?
> If this is not the case - e.g. there are other accesses to these locks -
> then you cannot sleep, no?
> I really can think of no case in which it is safe to sleep while holding
> a spinlock or otherwise atomic.  If it is, then the atomicity is not
> needed, sort of by definition.

Actually, though he may be using a spinlock_t, when used this way, it
is not a spinlock, but rather a semaphore-like construct like PG_locked.
Spinlocks include blocking via busywait semantics, which this usage
does not have. It just happens to use the same data type. There are
other interesting abuses of spinlock-like constructs in "advanced"
locks, for instance, in non-sleeping handoff-scheduled queueing locks
(e.g. MCS spinlocks and rwlocks) it's a common idiom for one waiter to
set a "blocked" bit or lock word and then spin on it until another
waiter and/or cpu manipulating the lock clears it.


Bill
