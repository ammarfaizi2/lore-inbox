Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVCTJZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVCTJZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 04:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVCTJZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 04:25:47 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:11183
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262046AbVCTJZl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 04:25:41 -0500
Subject: Re: Real-Time Preemption and RCU
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       dipankar@in.ibm.com, shemminger@osdl.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, gh@us.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <423D19FE.7020902@colorfullife.com>
References: <20050318002026.GA2693@us.ibm.com>
	 <20050318091303.GB9188@elte.hu> <20050318092816.GA12032@elte.hu>
	 <423BB299.4010906@colorfullife.com> <20050319162601.GA28958@elte.hu>
	 <423D19FE.7020902@colorfullife.com>
Content-Type: text/plain
Date: Sun, 20 Mar 2005 10:25:36 +0100
Message-Id: <1111310736.17944.24.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-20 at 07:36 +0100, Manfred Spraul wrote:
> cpu 1:
> acquire random networking spin_lock_bh()
> 
> cpu 2:
> read_lock(&tasklist_lock) from process context
> interrupt. softirq. within softirq: try to acquire the networking lock.
> * spins.
> 
> cpu 1:
> hardware interrupt
> within hw interrupt: signal delivery. tries to acquire tasklist_lock.
> 
> --> deadlock.

Signal delivery from hw interrupt context (interrupt is flagged
SA_NODELAY) is not possible in RT preemption mode. The
local_irq_save_nort() check in __cache_alloc will catch you.

When it happens from a threaded irq handler the situation is solvable by
the PI code.

tglx


