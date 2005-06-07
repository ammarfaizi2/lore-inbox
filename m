Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVFGTIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVFGTIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVFGTIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:08:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:14469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261959AbVFGTIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:08:35 -0400
Date: Tue, 7 Jun 2005 12:08:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC for 2.6: avoid OOM at bounce buffer storm
Message-Id: <20050607120811.6527a9ff.akpm@osdl.org>
In-Reply-To: <42A5AD4A.6080100@fujitsu-siemens.com>
References: <42A07BAA.4050303@fujitsu-siemens.com>
	<20050603160629.2acc4558.akpm@osdl.org>
	<42A5AD4A.6080100@fujitsu-siemens.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck <martin.wilck@fujitsu-siemens.com> wrote:
>
> > It might be neater to do this at the mempool level: that way we're adding
>  > general-purpose infrastructure and then just using it, rather than
>  > special-casing the bounce code.
>  > 
>  > See below a (n untested) patch against the latest devel tree.  It won't be
>  > stunningly scalable on big SMP, but the overhead of bouncing will probably
>  > hide that.
> 
>  I don't quite understand your patch. You introduce a "limit" field but 
>  you never actually use it. You also don't count the allocated pages.
>  Are you using the semaphore for slowing things down on purpose?

The semaphore is initialised with the limit level, so once it has been
down()ed more than `limit' times, processes will block until someone does
up().

>  (Note that the problem is not in the mempool allocation itself but in 
>  the "normal" allocation path (page_pool_alloc() -> alloc_page()))

yup.  The semaphore will prevent more than `limit' pages being allocated at
any point in time.

>  Anyway, I think could figure out your patch but with 2.6.12-rc5-mm2 I 
>  couldn't reproduce the problem any more.

Oh bugger.

> It appears to run much more 
>  smoothly now, perhaps because wakeup_bdflush() isn't called any more. 
>  Are you still interested in more data?

Perhaps the newer kernel has writeback thresholding fixes so it's not
possible to dirty as much memory with write().

You can probably trigger the same problem if the memory is instead dirtied
with mmap(MAP_SHARED).
