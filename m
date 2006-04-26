Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWDZRPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWDZRPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWDZRPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:15:34 -0400
Received: from smtp-2.llnl.gov ([128.115.3.82]:10449 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S932330AbWDZRPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:15:33 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 1/2] mm: serialize OOM kill operations
Date: Wed, 26 Apr 2006 10:14:14 -0700
User-Agent: KMail/1.5.3
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, riel@surriel.com,
       akpm@osdl.org
References: <200604251701.31899.dsp@llnl.gov> <444EF2CF.1020100@yahoo.com.au>
In-Reply-To: <444EF2CF.1020100@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261014.15008.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 21:10, Nick Piggin wrote:
> Firstly why not use a semaphore and trylocks instead of your homebrew
> lock?

Are you suggesting something like this?

	spinlock_t oom_kill_lock = SPIN_LOCK_UNLOCKED;

	static inline int oom_kill_start(void)
	{
		return !spin_trylock(&oom_kill_lock);
	}

	static inline void oom_kill_finish()
	{
		spin_unlock(&oom_kill_lock);
	}

If you prefer the above implementation, I can rework the patch as
above.

> Second, can you arrange it without using the extra field in mm_struct
> and operation in the mmput fast path?

I'm open to suggestions on other ways of implementing this.  However I
think the performance impact of the proposed implementation should be
miniscule.  The code added to mmput() executes only when the referece
count has reached 0; not on every decrement of the reference count.
Once the reference count has reached 0, the common-case behavior is
still only testing a boolean flag followed by a not-taken branch.  The
use of unlikely() should help the compiler and CPU branch prediction
hardware minimize overhead in the typical case where oom_kill_finish()
is not called.
