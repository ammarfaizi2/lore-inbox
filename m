Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbTLCUDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbTLCUDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:03:10 -0500
Received: from mx1.elte.hu ([157.181.1.137]:51423 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265146AbTLCUDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:03:08 -0500
Date: Wed, 3 Dec 2003 21:03:09 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <Pine.LNX.4.58.0312030748240.5258@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312032100100.4424@earth>
References: <20031203153858.C14999@in.ibm.com> <Pine.LNX.4.58.0312030748240.5258@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Dec 2003, Linus Torvalds wrote:

> I think the problem is the BUG() itself, not really the caller. So I'd
> prefer the fix for this to be to just entirely remove the debug tests
> withing that "#ifdef CONFIG_SMP", rather than hide the threads from
> /proc when this happens.
> 
> Ingo, comments?

i'd like to keep the BUG() - it has caught this bug, and it has caught
other bugs too in the past. The next_thread() use of procfs is clearly
illegal if it happens after a thread has been removed from the tasklist.
procfs is really special in this regard (nothing else that accesses the
thread list is supposed to have a stale reference to the task).

removing the debug tests will cause further crashes i think - the thread
pointers are not valid anymore, they could point to truly freed tasks.  
(this particular task is not freed yet because it has a procfs reference -
but the thread list pointers are not valid anymore.)

	Ingo
