Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUHLC4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUHLC4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268375AbUHLCz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:55:58 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:59121 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268374AbUHLCzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:55:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	<1092174959.5061.6.camel@mindpipe> <20040811073149.GA4312@elte.hu>
	<20040811074256.GA5298@elte.hu> <1092210765.1650.3.camel@mindpipe>
	<20040811082712.GB6528@elte.hu>
	<wn51xid99qf.fsf@linhd-2.ca.nortel.com>
	<1092269085.1090.10.camel@mindpipe>
From: Linh Dang <linhd@nortelnetworks.com>
Organization: Null
Date: Wed, 11 Aug 2004 22:55:44 -0400
In-Reply-To: <1092269085.1090.10.camel@mindpipe> (Lee Revell's message of
 "Wed, 11 Aug 2004 20:04:46 -0400")
Message-ID: <wn5llgl6p5b.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:

> On Wed, 2004-08-11 at 07:48, Linh Dang wrote:
>> Hi,
>>
>> I'm not running the voluntary-preempt-* patches. but I do see some
>> long latencies with:
>>
>> vanilla 2.6.7+preempt-timing+defer-softirq
>>
>> which were NOT reported here. Is it useful the report them?
>>
>
> Probably not.  Many latency issues as well as bugs in the preempt
> timing patch have been fixed since then.  You should try the latest
> version.

which "latest"? Linus's 2.6.8-rcX or Andrew's -mm's or Ingo's patches.

I've looked at Ingo patches but didn't see fixes for the followings:

1. In sys_mount(): do_mount() is called with the BKL held. on jffs2
   system, jffs2 might for a big media-scan and lock preemption for
   several msecs. even if jffs2_scan_eraseblock() calls cond_resched()
   for every flash sector, scanning one sector is still very long.

2. netif_receive_skb(): the rcu_read_lock() is too broad. IMHO, it's
   only needed around the 2 list_for_each_entry_rcu()s. There's no
   reason why rcu_read_lock() is needed when calling ip_recv on the
   skb.

3. with Ingo's patches, if all softirqs are done by the daemon then
   there's should be NO need to call local_bh_disable()/enable()
   around the processing loop in ___do_softirq().

4. in cfi_cmdset_0002.c, using spin_lock_bh() to guard struct flchip
   seems to be an overkill. why a semaphore is NOT sufficient?


I'm a total newbie so it's possible that I'm totally wrong about the
aboves.


Regards

-- 
Linh Dang
