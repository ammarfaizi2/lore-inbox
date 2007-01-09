Return-Path: <linux-kernel-owner+w=401wt.eu-S1751184AbXAIJDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbXAIJDU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbXAIJDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:03:19 -0500
Received: from [213.46.243.15] ([213.46.243.15]:9563 "EHLO
	amsfep14-int.chello.nl" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751224AbXAIJDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:03:16 -0500
Subject: mutex ownership (was: Re: [PATCH 19/24] Unionfs: Helper
	macros/inlines)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, arjan <arjan@infradead.org>
In-Reply-To: <20070108132817.5c9a30d6.akpm@osdl.org>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	 <11682295994056-git-send-email-jsipek@cs.sunysb.edu>
	 <20070108132817.5c9a30d6.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 10:02:56 +0100
Message-Id: <1168333376.12503.22.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 13:28 -0800, Andrew Morton wrote:

> Please use mutexes where possible.  Semaphores should only be used when
> their counting feature is employed.  And, arguably, in situations where a
> lock is locked and unlocked from different threads, because this presently
> triggers mutex debugging warnings, although we should find a way of fixing
> this in the mutex code.

Its a fundamental property of a mutex, not a shortcoming. A mutex has an
owner, the one that takes and releases the resource. This allows things
such as Priority Inheritance to boost owners.

'fixing' this takes away much of what a mutex is.

That said, it seems some folks really want this to happen, weird as it
may be. I'm not sure if all these cases are because of wrong designs. A
possible extension to the mutex interface might be something like this:

  mutex_pass_owner(struct task_struct *task);

which would be an atomic unlock/lock pair where the current task
releases the resource and the indicated task gains it. However it must
be understood that from the POV of 'current' this should be treated as
an unlock action.

Ingo, I'd much rather see something like this than the proposed

  mutex_unlock_dont_warn_if_a_different_task_did_it()

wart. Esp. since it preserves the mutex semantics and properties.



