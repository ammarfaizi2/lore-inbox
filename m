Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVIUSTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVIUSTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVIUSTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:19:53 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:14570
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751350AbVIUSTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:19:53 -0400
Subject: Re: [PATCH] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <433143C1.8D1C6F9C@tv-sign.ru>
References: <433143C1.8D1C6F9C@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 21 Sep 2005 20:20:05 +0200
Message-Id: <1127326806.24044.456.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-21 at 15:28 +0400, Oleg Nesterov wrote:

> This is deadlockable.
> 
> The caller of modify_ktimer()->internal_restart_ktimer() can hold locks
> which would prevent the completion of the ktimer->function().

True. You are right it is a potential source of dead locking. The
initial reason to implement it that way was that I wanted to avoid cross
cpu enqueueing for the high resolution timer case as I thought it would
make cross cpu timer event reprogramming necessary. But this is actually
a non issue, as the reprogramming check can be done after the timer
function has completed on the CPU where the function is running.

The loop is not necessary. I'll fix that up.

> Also, I don't understand why the timer is deleted _before_ checking that
> new_base != NULL. This way you can delete the timer (ret == 1), then goto
> retry, then get ret == 0.

Right. The return value must only be set on the first call to
remove_ktimer, but this is a non issue after removing the loop anyway.

Thanks for pointing this out,

tglx


