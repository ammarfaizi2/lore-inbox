Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVCKRtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVCKRtq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCKRtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:49:25 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:52930 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261237AbVCKRtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:49:02 -0500
Message-ID: <4231E959.141F7D85@tv-sign.ru>
Date: Fri, 11 Mar 2005 21:54:17 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Shai Fultheim <Shai@Scalex86.org>,
       Christoph Lameter <christoph@lameter.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] del_timer_sync scalability patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am not sure, but I think this patch incorrect.

> @@ -466,6 +482,7 @@ repeat:
>  			set_running_timer(base, timer);
>  			smp_wmb();
>  			timer->base = NULL;
------>	WINDOW <------
> +			set_last_running(timer, base);
>  			spin_unlock_irq(&base->lock);

Suppose it is the first invocation of timer, so
timer->last_running == NULL.

What if del_timer_sync() happens in that window?

del_timer_sync:
	del_timer();	// timer->base == NULL, returns

	base = timer->last_running;
	if (base)	// no, it is still NULL
		...

	if (timer->base != NULL || timer->last_running != base)
		goto del_again;	// not taken

	return;

I think it is not enough to exchange these 2 lines in
__run_timers, we also need barriers.

Oleg.
