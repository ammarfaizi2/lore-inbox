Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWHVODE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWHVODE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHVODE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:03:04 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:51350 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932253AbWHVODC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:03:02 -0400
Date: Tue, 22 Aug 2006 22:27:07 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_process: cosmetic ->ioprio tweak
Message-ID: <20060822182707.GA469@oleg>
References: <20060820145321.GA775@oleg> <20060821143224.62018aba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821143224.62018aba.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21, Andrew Morton wrote:
>
> On Sun, 20 Aug 2006 18:53:21 +0400
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> 
> > copy_process:
> > // holds tasklist_lock + ->siglock
> >        /*
> >         * inherit ioprio
> >         */
> >        p->ioprio = current->ioprio;
> > 
> > Why? ->ioprio was already copied in dup_task_struct().
> 
> It might just be a thinko.
> 
> > I guess this is needed
> > to ensure that the child can't escape sys_ioprio_set(IOPRIO_WHO_{PGRP,USER}),
> > yes?
> 
> How could the child escape that if this assignment was not present?

It is possible that sys_ioprio_set(IOPRIO_WHO_PGRP) was called after
copy_process() already did dup_task_struct(), but before it takes
tasklist_lock. Documentation/block/ioprio.txt doesn't say should
ioprio_set() be "atomic" or not. If not, we can kill this line, and
(more importantly) drop tasklist_lock in fs/ioprio.c

Oleg.

