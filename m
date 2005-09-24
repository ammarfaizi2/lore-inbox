Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVIXPJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVIXPJb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 11:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVIXPJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 11:09:31 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:22405 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932189AbVIXPJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 11:09:30 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 24 Sep 2005 08:10:32 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Willy Tarreau <willy@w.ods.org>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
In-Reply-To: <20050924061500.GA24628@alpha.home.local>
Message-ID: <Pine.LNX.4.63.0509240800020.31060@localhost.localdomain>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
 <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com>
 <20050924061500.GA24628@alpha.home.local>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005, Willy Tarreau wrote:

> Yes it can, and that's why I said that gcc should send a warning when
> comparing an int with something too large for an int. But I should have
> forced the constant to be evaluated as long long. At the moment, the
> constant cannot overflow, but it can reach a value so high that
> timeout/1000 will never reach it. Example :
>  MAX_SCHEDULE_TIMEOUT=LONG_MAX
>  HZ=250
>  timeout=LONG_MAX-1
>  => timeout/1000 < MAX_SCHEDULE_TIMEOUT/HZ
>  but (timeout * HZ + 999) / 1000 will still overflow !
>
> So I finally think that the safest test would be to avoid the timeout
> range which can overflow in the computation, using something like this
> (but which will limit the timeout to 49 days on HZ=1000 machines) :
>
> +       jtimeout = timeout < 0 || \
> +                    timeout >= (1000ULL * MAX_SCHEDULE_TIMEOUT / HZ) || \
> +                    timeout >= (LONG_MAX / HZ - 1000) ?
>                   MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
>
> as both are constants, they can be optimized. Otherwise, we can resort to
> using a MAX() macro to reduce this to only one test which will catch all
> corner cases.

Using the MIN() macro would be better so we have a single check, and the 
compiler optimize that automatically. Or we can force 'timeout * HZ' to 
use ULL math. I don't think it makes a lot of difference for something 
that is in a likely sleep path ;)


- Davide


