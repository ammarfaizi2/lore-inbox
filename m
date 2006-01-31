Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWAaXU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWAaXU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWAaXU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:20:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932114AbWAaXU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:20:27 -0500
Date: Tue, 31 Jan 2006 15:20:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Badness in local_bh_enable by [PATCH] fix uidhash_lock <-> RCU
 deadlock
In-Reply-To: <20060131230926.GA7726@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.64.0601311512230.7301@g5.osdl.org>
References: <20060131230926.GA7726@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Feb 2006, Alexey Dobriyan wrote:
>
> Flooding boot logs with
> 
> Badness in local_bh_enable at kernel/softirq.c:140

Ok, looks bad. It's through

    __dequeue_signal():
	collect_signal():
	    __sigqueue_free():
		free_uid()

where we hold the sigqueue lock. We do _not_ want to do BH processing 
there with the lock held and interrupts disabled, so the warning is 
correct, and that uidhash_lock patch potentially causes more problems than 
it fixes.

Perhaps the easiest solution is to just make them irq-safe instead 
of bh-safe? An alternative might be to make __sigqueue_free() do its work 
through RCU callbacks too, but that seems wrong.

Comments? Ingo?

		Linus
