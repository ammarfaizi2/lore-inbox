Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265130AbUEUXKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUEUXKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUEUXJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:09:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:35775 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265098AbUEUXCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:02:44 -0400
Date: Fri, 21 May 2004 16:05:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-Id: <20040521160510.4214c7a3.akpm@osdl.org>
In-Reply-To: <20040520093817.GX30909@devserv.devel.redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> wrote:
>
> The patch below extends FUTEX_REQUEUE operation with something FUTEX_WAIT
> already uses:
> FUTEX_CMP_REQUEUE is passed an additional argument which is the expected
> value of *futex.  Kernel then while holding the futex locks checks if

                                      ^^^^^^^^^^^^^^^^^^^^^^^

But in your patch the check is happening _prior_ to taking the futex locks.

> *futex != expected and returns -EAGAIN in that case, while if it is equal,
> continues with a normal FUTEX_REQUEUE operation.
> If the syscall returns -EAGAIN, NPTL can fall back to FUTEX_WAKE INT_MAX
> operation which doesn't have this problem, but is less efficient, while
> in the likely case that nobody hit the (small) window the efficient
> FUTEX_REQUEUE operation is used.

You've added an smp_mb().  These things are becoming like lock_kernel() -
hard for the reader to discern what it's protecting against.

Please always include a comment when adding a barrier like this.
