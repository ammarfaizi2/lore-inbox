Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVJFPel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVJFPel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVJFPel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:34:41 -0400
Received: from gold.veritas.com ([143.127.12.110]:38550 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751097AbVJFPel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:34:41 -0400
Date: Thu, 6 Oct 2005 16:34:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Kirill Korotaev <dev@sw.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, Andrey Savochkin <saw@sawoct.com>, st@sw.ru
Subject: Re: SMP syncronization on AMD processors (broken?)
In-Reply-To: <Pine.LNX.4.64.0510060741000.31407@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0510061631260.11029@goblin.wat.veritas.com>
References: <434520FF.8050100@sw.ru> <Pine.LNX.4.64.0510060741000.31407@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Oct 2005 15:34:40.0804 (UTC) FILETIME=[77BC9640:01C5CA8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, Linus Torvalds wrote:
> 
> If you want to notify another CPU that you want the spinlock, then you 
> need to set the "flag" variable _outside_ of the spinlock.
> 
> Spinlocks are not fair, not by a long shot. They never have been, and they 
> never will. Fairness would be extremely expensive indeed.

That reminds me: ought cond_resched_lock to be doing something more?

int cond_resched_lock(spinlock_t *lock)
{
	int ret = 0;

	if (need_lockbreak(lock)) {
		spin_unlock(lock);
		cpu_relax();
		ret = 1;
		spin_lock(lock);
	}
