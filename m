Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVCJJBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVCJJBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVCJJBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:01:01 -0500
Received: from one.firstfloor.org ([213.235.205.2]:64167 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262448AbVCJJAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:00:49 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: greearb@candelatech.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>
	<422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com>
	<422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au>
	<422C1D57.9040708@candelatech.com> <422C1EC0.8050106@yahoo.com.au>
	<422D468C.7060900@candelatech.com> <422DD5A3.7060202@rapidforum.com>
	<422F8A8A.8010606@candelatech.com> <422F8C58.4000809@rapidforum.com>
	<422F9259.2010003@candelatech.com> <422F93CE.3060403@rapidforum.com>
	<20050309211730.24b4fc93.akpm@osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Thu, 10 Mar 2005 10:00:48 +0100
In-Reply-To: <20050309211730.24b4fc93.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 9 Mar 2005 21:17:30 -0800")
Message-ID: <m1is3zvprz.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Christian Schmid <webmaster@rapidforum.com> wrote:
>>
>>  > So, maybe a VM problem?  That would be a good place to focus since
>>  > I think we can be fairly certain it isn't a problem in just the
>>  > networking code.  Otherwise, my tests would show lower bandwidth.
>> 
>>  Thanks to your tests I am really sure that its no network-code problem anymore. But what I THINK it 
>>  is: The network is allocating buffers dynamically and if the vm doesnt provide that buffers fast 
>>  enough, it locks as well.
>
> Did anyone have a 100-liner which demonstrates this problem?
>
> The output of `vmstat 1' when the thing starts happening would be interesting.

If he had a lot of RX traffic (it is hard to figure out because his
bug reports are more or less useless and mostly consists of rants):
The packets are allocated with GFP_ATOMIC and a lot of traffic
overwhelms the free memory.

Some drivers work around this by doing the RX ring refill in process
context (easier with NAPI), but not all do.

In general to solve it one has to increase /proc/sys/vm/freepages
a lot.

It would be nice though if the VM tuned itself dynamically to a lot
of GFP_ATOMIC requests. And maybe if GFP_ATOMIC was a bit more aggressive
and did some simple minded reclaiming that would be helpful too.
e.g. there could be a "easy to free" list in the VM for clean pages
where freeing is simple enough that it could be made interrupt safe.

-Andi
