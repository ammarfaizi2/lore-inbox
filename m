Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUAZIp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 03:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUAZIp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 03:45:59 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:41124 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264498AbUAZIp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 03:45:58 -0500
Subject: Re: 2.6.2-rc1-mm2 (msp34xx badness in sched.c)
From: David Woodhouse <dwmw2@infradead.org>
To: Tony Vroon <tony@vroon.org>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
In-Reply-To: <200401242347.41497.tony@vroon.org>
References: <200401242347.41497.tony@vroon.org>
Content-Type: text/plain
Message-Id: <1075106608.19924.16.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Mon, 26 Jan 2004 08:43:28 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-24 at 23:47 +0100, Tony Vroon wrote:
> sleep_on called without kernel_lock, from what it looks like in msp34xx.

Fairly typical example of the type of error the additional check was
expected to find. Note also that the same thread should be using
complete_and_exit().

I suspect some of the instances of del_timer() should be
del_timer_sync() too. Particularly in msp_wake_thread() and
map_detach().

Is there something we can do to make del_timer() break when it should
have been del_timer_sync()... like waiting five seconds and then
deliberately calling it on another CPU? :)

> Badness in interruptible_sleep_on at kernel/sched.c:2230
> Call Trace:
>  [<c011ed24>] interruptible_sleep_on+0xf4/0x100
>  [<c011e950>] default_wake_function+0x0/0x20
>  [<c02b9a27>] msp3410d_thread+0xa7/0x680
>  [<c02b9980>] msp3410d_thread+0x0/0x680
>  [<c0108e69>] kernel_thread_helper+0x5/0xc

-- 
dwmw2


