Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUFUUk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUFUUk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUFUUk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:40:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44184 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266458AbUFUUkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:40:52 -0400
Message-ID: <40D747B1.9030406@redhat.com>
Date: Mon, 21 Jun 2004 16:40:17 -0400
From: Nobuhiro Tachino <ntachino@redhat.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takao Indoh <indou.takao@soft.fujitsu.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
References: <20040617121356.GA24338@elte.hu> <D3C4552C24A60Aindou.takao@soft.fujitsu.com>
In-Reply-To: <D3C4552C24A60Aindou.takao@soft.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takao Indoh wrote:
> On Thu, 17 Jun 2004 14:13:56 +0200, Ingo Molnar wrote:
> 
> 
>>but there's another possible method (suggested by Alan Cox) that
>>requires no changes to the timer API hotpaths: 'clear' all timer lists
>>upon a crash [once all CPUs have stopped and irqs are disabled] and just
>>let the drivers use the normal timer APIs. Drive timer execution via a
>>polling method.
>>
>>this basically approximates your polling based implementation but uses
>>the existing kernel timer data structures and timer mechanism so should
>>be robust and compatible. It doesnt rely on any previous state (because
>>all currently pending timers are discarded) so it's as crash-safe as
>>possible.
> 
> 
> This is a test patch for clearing timer/tasklet and executing it
> during dumping.
> This patch does not work yet. I tried dumping using this patch, but
> aic7xxx is unstable...

Your new dump_run_timers() calls __run_timers() directly. I think that's
the reason of unstability. __run_timers() calls spin_unlock_irq()
and enables IRQ, but diskdump expects everything runs with IRQ
disabled.
