Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267297AbSIRRPo>; Wed, 18 Sep 2002 13:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267561AbSIRRPo>; Wed, 18 Sep 2002 13:15:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34538 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267297AbSIRRPm>;
	Wed, 18 Sep 2002 13:15:42 -0400
Date: Wed, 18 Sep 2002 19:28:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209181008570.1125-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209181925200.23619-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Linus Torvalds wrote:

> Where did this NMI oopser argument come from? get_pid() doesn't even
> disable interrupts. And we hold the read lock, and other interrupts
> aren't allowed to take the write lock anyway. [...]

the read lock makes all writers wait (and there are a number of places
that use write_lock_irq(&tasklist_lock)) - which frequently come either
from IRQ-disabled paths, or disable interrupts themselves.

Sure, we could 'fix' this artifact by tweaking the write-lock to re-enable
interrupts while looping, but this still leaves us with complete system
silence potentially for minutes.

(plus this still leaves us with 30 places in the kernel that do stupid
for_each_process() and for_each_thread() loops which really could be loops
over the session list or process group list.)

	Ingo

