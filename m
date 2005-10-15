Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVJOQBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVJOQBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 12:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJOQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 12:01:25 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:1408 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750850AbVJOQBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 12:01:24 -0400
Message-ID: <43512AD5.852E44AC@tv-sign.ru>
Date: Sat, 15 Oct 2005 20:14:13 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG?] 2.6.x (2.6.13) - new signals not being delivered to a 
 terminating (PF_EXITING) process.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kilau, Scott wrote:
>
> signal_pending() never does, no matter how many signals I send it.
> (Even sending it multiple kill -9's)
>
> ...
>
> However, I see the signals climb, when I print out the values of
> current->signal->shared_pending.list.next and
> current->signal->shared_pending.list.prev
>
> Its like those values and the signal_pending macro aren't in "synch"
> Anymore, once the process has gone into the PF_EXITING state.
> (It works fine when the process is not in that state)

Yes, __group_complete_signal() is called after the signal has been added to
the ->shared_pending. But it does not signal_wake_up()s process, because of
this check in wants_signal():

	if (p->flags & PF_EXITING)
		return 0;

The intent was to find another thread in the thread group which can accept
this signal. May be we need special check in __group_complete_signal() under
"else if (thread_group_empty(p))".

You still can kill this process via tkill, though.

Oleg.
