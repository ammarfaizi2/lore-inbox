Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbTFSSGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbTFSSGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:06:09 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:29916 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265847AbTFSSGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:06:03 -0400
Date: Thu, 19 Jun 2003 11:21:02 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ray Bryant <raybry@sgi.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll()
 tohang in
Message-Id: <20030619112102.6a528a29.akpm@digeo.com>
In-Reply-To: <3EF1FC53.2C9C5249@sgi.com>
References: <3EF1E136.40305@colorfullife.com>
	<3EF1FC53.2C9C5249@sgi.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2003 18:20:03.0052 (UTC) FILETIME=[66DD7AC0:01C3368F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant <raybry@sgi.com> wrote:
>
>  > The correct fix is current->state = TASK_RUNNING just before calling
>  > yield() in the rebalance code.
> 
>  But doesn't this have the same kind of problem?  e. g., just before
>  calling yield() in the rebalance code we save current->state, set it to
>  TASK_RUNNING, then restore current->state on return from yield().  If a
>  fd becomes ready after the call to yield(), and we entered
>  __alloc_pages() with state TASK_INTERRUPTIBLE, aren't we in exactly the
>  same situation as described above?

No, you cannot restore the task state after having set it to TASK_RUNNING.

Just leave the state at TASK_RUNNING.  The (silly) code which called the
page allocator in state TASK_[IN]TERRUPTIBLE will just go around its wait
loop an extra time and go back to sleep.  This almost always works.

