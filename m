Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318300AbSGYCOb>; Wed, 24 Jul 2002 22:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318305AbSGYCOb>; Wed, 24 Jul 2002 22:14:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61191 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318300AbSGYCOa>;
	Wed, 24 Jul 2002 22:14:30 -0400
Message-ID: <3D3F61A2.10661C93@zip.com.au>
Date: Wed, 24 Jul 2002 19:25:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generalized spin_lock_bit, take two
References: <1027556989.927.1646.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> Andrew and Linus,
> 
> The attached patch implements bit-sized spinlocks via the following
> interfaces:
> 
>         spin_lock_bit(int nr, unsigned long * lock)
>         spin_unlock_bit(int nr, unsigned long * lock)
> 
> to abstract the current VM pte_chain locking and to fix the problem
> where the locks are not compiled away on UP.
> 

Do we really want to introduce another locking primitive?

pte_chain_lock is special, because we have so many struct page's,
and open-coding that locking is a good way to express that
specialness.  But if we go and formalise "spin_lock_bit" then
everyone will start using them, and that's not necessarily
a thing we want to happen?

I did some testing yesterday with fork/exec/exit-intensive
workloads and the contention rate on pte_chain_lock was 0.3%,
so the efficiency problems which Linus described are unlikely
to bite us in this particular application.  But if the usage
of spin_lock_bit() were to widen, some platforms may be impacted.

-
