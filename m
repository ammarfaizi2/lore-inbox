Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUK1JOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUK1JOl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 04:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUK1JOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 04:14:41 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:65498 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261417AbUK1JOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 04:14:37 -0500
Message-ID: <41A9A571.9BAD29A7@tv-sign.ru>
Date: Sun, 28 Nov 2004 13:16:17 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH? rcu: eliminate rcu_ctrlblk.lock
References: <41A8A57A.DD2338BB@tv-sign.ru> <41A8BFB8.3000804@colorfullife.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
>
> Your patch would add one new corner case:
>
> start: next_pending==1. rcp->cur == 11.
> cpu 1: rcu_start_back sets next_pending to 0.
> cpu 2: rdp->batch = rcp->cur + 1 [i.e. wait for end of period 12]
> cpu 2: notices next_pending == 0, tries to acquire the spinlock [blocks]
> cpu 1: rcp->cur++ [i.e. start period 12]
> cpu 1: releases the spinlock
> cpu 2: gets the spinlock, sets next_pending to 1 and exits.
>
> Now next_pending is 1 [i.e. at the end of grace period 12 grace period
> 13 is automatically started], although noone has callbacks waiting for
> period 13.

Yes. But if i understand correctly, the current behaviour a bit worse.
In this scenario rcu_process_callbacks() on cpu 2 will re-read cur==12
and next_pendind==0 and call start_batch(), so grace period 13 will be
started at the end of grace period 12 anyway.

The difference is that with this patch the 'curlist' will be flushed when
the grace period 12 is completed, while the current code will postpone it
up to 13.

Oleg.
