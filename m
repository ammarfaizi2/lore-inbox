Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbUK0R47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbUK0R47 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbUK0R47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 12:56:59 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:35015 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261279AbUK0R45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 12:56:57 -0500
Message-ID: <41A8BFB8.3000804@colorfullife.com>
Date: Sat, 27 Nov 2004 18:56:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH? rcu: eliminate rcu_ctrlblk.lock
References: <41A8A57A.DD2338BB@tv-sign.ru>
In-Reply-To: <41A8A57A.DD2338BB@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:

>Hello.
>
>I am trying to understand the rcu implementetion.
>
>I can't understand why rcu_ctrlblk.seqcount is needed.
>It seems to me it can be replaced by a couple of barriers.
>
>  
>

Your patch would add one new corner case:

start: next_pending==1. rcp->cur == 11.
cpu 1: rcu_start_back sets next_pending to 0.
cpu 2: rdp->batch = rcp->cur + 1 [i.e. wait for end of period 12]
cpu 2: notices next_pending == 0, tries to acquire the spinlock [blocks]
cpu 1: rcp->cur++ [i.e. start period 12]
cpu 1: releases the spinlock
cpu 2: gets the spinlock, sets next_pending to 1 and exits.

Now next_pending is 1 [i.e. at the end of grace period 12 grace period 
13 is automatically started], although noone has callbacks waiting for 
period 13.

This is not fatal: the combination is rare, so perhaps we could tolerate 
the race. But on the other hand the sequence locks are outside of the 
hot paths and not much slower than a smp_rmb().

Dipankar - what do you think?

--
    Manfred
