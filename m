Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285047AbRLFIfG>; Thu, 6 Dec 2001 03:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285050AbRLFIe4>; Thu, 6 Dec 2001 03:34:56 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:36258 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S285047AbRLFIep>; Thu, 6 Dec 2001 03:34:45 -0500
To: manfred@colorfullife.com
Cc: davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task_struct + kernel stack colouring ...
In-Reply-To: <3C0E84B4.1070808@colorfullife.com>
In-Reply-To: <Pine.LNX.4.40.0112051103100.1644-100000@blue1.dev.mcafeelabs.com>
	<3C0E84B4.1070808@colorfullife.com>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011206173435L.yamamura@flab.fujitsu.co.jp>
Date: Thu, 06 Dec 2001 17:34:35 +0900
From: Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] task_struct + kernel stack colouring ...
Date: Wed, 05 Dec 2001 21:33:56 +0100
Message-ID: <3C0E84B4.1070808@colorfullife.com>

> Shuij, I don't understand why you need both a shift and a modulo: 
> address % odd_number should generate a random distribution (i.e. all 
> bits affect the result), even without the shift.

Yes, you are right. The shift operation is unnecessary.
Sorry for your confusion.

And probably, the modulo method is better than copying bits, because
it does not depend on the cache configuration.

My posted patch did't use modulo in order to avoid the overhead of
get_current(), which is frequently called. But, copy_thread() is
called once to generate a process, so such overhead may not be the
problem.

Additionally, we measured cache line conflict statistics of stack tops
by snapshotting them during running of apache on 1MB L2-cache system.
The modulo colouring certainly reduces the cache line collisions.

                 # of tasks   # of cache line   # of collisions
                                     used          AVG(MAX)
--------------------------------------------------------------
Davide's Patch         246          32             7.68(14)
 (original)
Davide's Patch         244          165            1.48(6)
 (copying 16 to 18 bits)  
Davide's Patch         244          164            1.49(4)
 (modulo 9)

but, we could't see the meaningful performance difference among them
at least in this experimentation.

Thank you,

-----
Computer Systems Laboratories, Fujitsu Labs.
Shuji YAMAMURA (yamamura@flab.fujitsu.co.jp)
