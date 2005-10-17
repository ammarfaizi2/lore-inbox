Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVJQTjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVJQTjg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVJQTjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:39:36 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:57116 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751274AbVJQTjf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:39:35 -0400
Message-ID: <4353FDE8.8070909@cosmosbay.com>
Date: Mon, 17 Oct 2005 21:39:20 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: dipankar@in.ibm.com, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com> <4353E6F1.8030206@cosmosbay.com> <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org> <4353F7B5.1040101@cosmosbay.com> <Pine.LNX.4.64.0510171218490.3369@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510171218490.3369@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds a écrit :
> 
> On Mon, 17 Oct 2005, Eric Dumazet wrote:
> 
>>Thats strange, because on my tests it seems that I dont have one reschedule
>>for 'maxbatch' items. Doing 'grep filp /proc/slabinfo' it seems I have one
>>'schedule' then filp count goes back to 1000.
> 
> 
> Hmm.
> 
> I think you're right, but for all the wrong reasons.
> 
> "maxbatch" ends up not actually having any real effect in the end: after 
> the tasklet ends up running in softirqd, softirqd will actually keep on 
> calling the tasklet code until it doesn't get rescheduled any more ;)
> 
> So it will do "maxbatch" RCU entries, reschedule itself, return, and 
> immediately get called again.
> 
> Heh.
> 
> The _good_ news is that since it ends up running in softirqd (after the 
> first ten times - the softirq code in kernel/softirq.c will start off 
> calling it ten times _first_), it can be scheduled away, so it actually 
> ends up helping latency.
> 
> Which means that we actually end up doing exactly the right thing, 
> although for what appears to be the wrong reasons (or very lucky ones).
> 
> The _bad_ news is that softirqd is running at nice +19, so I suspect that 
> with some unlucky patterns it's probably pretty easy to make sure that 
> ksoftirqd doesn't actually run very often at all! 
> 
> Gaah. So close, yet so far. I'm _almost_ willing to just undo my "make 
> maxbatch huge" patch, and apply your patch, because now that I see how it 
> all happens to work together I'm convinced that it _almost_ works. Even if 
> it seems to be mostly by luck(*) rather than anything else.
> 

:)

What about call_rcu_bh() which I left unchanged ? At least one of my 
production machine cannot live very long unless I have maxbatch = 300, because 
of an insane large tcp route cache (and one of its CPU almost filled by 
softirq NIC processing)

> 		Linus
> 
> (*) Not strictly true. It may not be by design of the RCU code itself, but 
> it's definitely by design of the softirq's being designed to be robust and 
> have good latency behaviour. So it does work by design, but it works by 
> softirq design rather than RCU design ;)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

