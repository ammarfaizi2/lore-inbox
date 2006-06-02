Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWFBVWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWFBVWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWFBVWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:22:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:32417 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030288AbWFBVWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:22:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:cc:subject:message-id:mime-version:content-type;
        b=pKvNyfJrBn6ffZRE/38+jqtSYKhIDPuVlwSawlPnnweUX7cSly+rdRqddTxvumPuTPUkv+TfAiPX0sC/QLFq74SsLet13woX+K5ll7d9kkCEDQKcEZ9i4wzOsNWUIl+kMVB5jnr2WFr28Yx3uVsUQ6S2ewLc8Kxu+tY5HMvf+Qw=
Date: Fri, 2 Jun 2006 23:22:46 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost
To: linux-kernel@vger.kernel.org
cc: Ingo Molnar <mingo@elte.hu>
Subject: [patch 0/5] [PREEMPT_RT] Changing interrupt handlers from running
 in thread to hardirq and back runtime.
Message-ID: <Pine.LNX.4.64.0606022321170.9307@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
Hi,

(I have sent these patches once, but I can't find them on LKML, so I assume 
they were lost.)

  I have made a system such that drivers can be enhanced to easily run in
both hard-irq context and threaded context under PREEMPT_RT (and also
under !PREEMPT_RT, although that is trivial).

- Why:
Because running hard irq handles threaded is a huge overhead and many of the
interrupt handlers already are so small that running them in hard-IRQ context 
doesn't make much different. By making them changeable runtime make it easy
to do meassurements on latencies and performance.
Furthermore, this system solves the bugs occuring when trying to share a 
non-threaded (SA_NODELAY) and threaded (new SA_MUST_THREAD flag) irq handlers
on the same irq. Unless one of them is willing to change context, installation
of the last handler will simply fail.

- How:
The basic idea is to let them change their locks to raw_spin_lock from rt_mutex
and back when the change of context is ordered.

I have therefore made 5 patches.

1) The "spin_mutex" (might need another name) which is a lock type which
can safely be changed runtime from raw_spin_lock to rt_mutex and back.
2) A set of changes to the irq system where a new callback to the driver is '
added.
3) Update to my ethernet driver (e100).
4) Update to the my serial driver (8250).
5) A patch which doesn't really belong here to lpptest where the
request_irq() API wasn't used correctly.

Esben
