Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030926AbVLWRCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030926AbVLWRCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 12:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbVLWRCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 12:02:33 -0500
Received: from main.gmane.org ([80.91.229.2]:10386 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030926AbVLWRCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 12:02:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: [PATCH] - Fix memory ordering problem in wake_futex()
Date: Fri, 23 Dec 2005 12:05:38 -0500
Message-ID: <dohaiq$dgk$1@sea.gmane.org>
References: <20051223163816.GA30906@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <20051223163816.GA30906@sgi.com>
Cc: linux-ia64@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner wrote:
> Here is a fix for a ugly race condition that occurs in wake_futex() on IA64.
> 
> On IA64, locks are released using a "st.rel" instruction. This ensures that
> preceding "stores" are visible before the lock is released but does NOT prevent
> a "store" that follows the "st.rel" from becoming visible before the "st.rel".
> The result is that the task that owns the futex_q continues prematurely. 
> 
> The failure I saw is the task that owned the futex_q resumed prematurely and
> was context-switch off of the cpu. The task's switch_stack occupied the same
> space of the futex_q. The store to q->lock_ptr overwrote the ar.bspstore in the
> switch_stack. When the task resumed, it ran with a corrupted ar.bspstore.
> Things went downhill from there.
> 
> Without the fix, the application fails roughly every 10 minutes. With
> the fix, it ran 16 hours without a failure.
> 

I'm not sure I understand.  Mutex semantics allow for memory accesses to
be moved into the critical region but not vice versa.  This is true for Java
and it's pretty much agreed by all the "experts" that it's allowed in Posix
if there was such a thing as a formal definition of mutex semantics
in Posix.  It would also seem to be to be the reason why Intel designed the
release semantics that way, so the hardware, not just the compiler, could
move code into the critical region for better performance.

So I suspect the problem is something else.


--
Joe Seigh

