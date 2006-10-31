Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWJaHpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWJaHpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161573AbWJaHpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:45:07 -0500
Received: from brick.kernel.dk ([62.242.22.158]:25963 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161571AbWJaHpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:45:04 -0500
Date: Tue, 31 Oct 2006 08:46:45 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] splice : two smp_mb() can be omitted
Message-ID: <20061031074645.GY14055@kernel.dk>
References: <1162199005.24143.169.camel@taijtu> <20061030224802.f73842b8.akpm@osdl.org> <4546FA81.1020804@cosmosbay.com> <20061031073212.GW14055@kernel.dk> <4546FE39.8000201@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4546FE39.8000201@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2006, Eric Dumazet wrote:
> Jens Axboe a écrit :
> >On Tue, Oct 31 2006, Eric Dumazet wrote:
> >>This patch deletes two calls to smp_mb() that were done after 
> >>mutex_unlock() that contains an implicit memory barrier.
> >>
> >>The first one in splice_to_pipe(), where 'do_wakeup' is set to true only 
> >>if pipe->inode is set (and in this case the
> >>if (pipe->inode)
> >>   mutex_unlock(&pipe->inode->i_mutex);
> >>is done too)
> >>
> >>The second one in link_pipe(), following inode_double_unlock() that 
> >>contains calls to mutex_unlock() too.
> >
> >NAK on that patch, the smp_mb() follows the waitqueue_active(). If you
> >later change the code and move the locks or whatnot, you have lost that
> >connection.
> >
> >If you change the patch to insert a comment, then it may be more
> >applicable.
> >
> 
> Hum... I read fs/pipe.c and see no smp_mb() there, but I suspect same 
> semantics are/were used.
> 
> Should we add comments on fs/pipe.c too ?

fs/pipe.c looks different:

        if (do_wakeup) {
                wake_up_interruptible_sync(&pipe->wait);
                ...
        }

The smp_mb() is not needed if you call wake_up() directly, only if
checking via waitqueue_active().

-- 
Jens Axboe

