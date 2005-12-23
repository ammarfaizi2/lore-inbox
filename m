Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbVLWWX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbVLWWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVLWWX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:23:27 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:3761 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1161066AbVLWWX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:23:27 -0500
Message-ID: <43AC78CF.9090407@colorfullife.com>
Date: Fri, 23 Dec 2005 23:23:11 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - Fix memory ordering problem in wake_futex()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack wrote:

>On IA64, locks are released using a "st.rel" instruction. This ensures that
>preceding "stores" are visible before the lock is released but does NOT prevent
>a "store" that follows the "st.rel" from becoming visible before the "st.rel".
>The result is that the task that owns the futex_q continues prematurely. 
>
>The failure I saw is the task that owned the futex_q resumed prematurely and
>was context-switch off of the cpu. The task's switch_stack occupied the same
>space of the futex_q. The store to q->lock_ptr overwrote the ar.bspstore in the
>switch_stack.
>
Bad race.
Unfortuantely the scenario that you describe is quite frequent:
- autoremove_wake_function()
- ipc/sem.c (search for IN_WAKEUP)
- ipc/msg.c appears to be correct, there are smp_wmb() calls.

--
    Manfred
