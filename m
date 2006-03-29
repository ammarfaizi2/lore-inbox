Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWC2NSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWC2NSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWC2NSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:18:18 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:42689 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750889AbWC2NSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:18:17 -0500
Message-ID: <442A8933.6090408@bull.net>
Date: Wed, 29 Mar 2006 15:18:43 +0200
From: Pierre PEIFFER <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       jakub@redhat.com
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
References: <4428E7B7.8040408@bull.net> <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com>
In-Reply-To: <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 15:20:22,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 15:20:23,
	Serialize complete at 29/03/2006 15:20:23
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper a écrit :
> 
> There are no such situations anymore in an optimal userlevel
> implementation.  The last problem (in pthread_cond_signal) was fixed
> by the addition of FUTEX_WAKE_OP.  The userlevel code you're looking
> at is simply not optimized for the modern kernels.
> 

I think there is a misunderstanding here.

FUTEX_WAKE_OP is implemented to handle simultaneously more than one 
futex in some specific situations (such as pthread_cond_signal).

The scenario I've described occurred in futex_wake, futex_wake_op and 
futex_requeue and is _independent_ of the userlevel code.

All these functions call wake_futex, and then wake_up_all, with the 
futex_hash_bucket lock still held.

If the woken thread is immediately scheduled (in wake_up_all), and only 
in this case (because of a higher priority, etc), it will try to take 
this lock too (because of the "if (lock_ptr != 0)" statement in 
unqueue_me), causing two task-switches to take this lock for nothing.

Otherwise, it will not: lock_ptr is set to NULL just after the 
wake_up_all call)

This scenario happens at least in pthread_cond_signal, 
pthread_cond_broadcast and probably all pthread_*_unlock functions.

The patch I've proposed should, at least in theory, solve this. But I'm 
not sure of the correctness...

-- 
Pierre P.
