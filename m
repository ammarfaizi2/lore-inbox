Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264775AbUEEUCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbUEEUCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 16:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264778AbUEEUCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 16:02:04 -0400
Received: from outgoingmail.adic.com ([63.81.117.28]:30628 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264775AbUEEUCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 16:02:00 -0400
Message-ID: <409946E6.4030301@xfs.org>
Date: Wed, 05 May 2004 14:56:22 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Andrew Morton <akpm@osdl.org>, Dominik Karall <dominik.karall@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <20040505013135.7689e38d.akpm@osdl.org>	 <200405051312.30626.dominik.karall@gmx.net>	 <20040505043002.2f787285.akpm@osdl.org>  <40991A8D.5000008@xfs.org> <1083786663.3844.10.camel@laptop.fenrus.com>
In-Reply-To: <1083786663.3844.10.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>Is it less pain than making something like a memory allocation which comes
>>out of a deep stack? Say, nfs server -> filesystem -> lvm/raid -> fiber channel,
>>which itself does something like a writepage into an nfs filesystem and ends
>>up in the networking stack? OK, getting back into the filesystem on a
>>memory allocation from the block layer should not happen, but you could
>>certainly be down in
> 
> 
> it's not really much different than the 2.4 kernel already has.
> In 2.4 you have a 8Kb stack of which
> 
> First 1600 bytes (+/-) are for the task struct
> about 4Kb of user context stack
> 
>>= 2Kb stack which is needed for irq context (both soft and hard)
> 
> 
> In 2.6 with this patch you have
> 
> 32 bytes for thread info
> 4Kb minus 32 bytes for context stack
> SEPARATE softirq stack of 4K
> SEPARATE hardirq stack of 4K
> 
> so in a way you have MORE stack space than in 2.4.
> 
> Now I'll fully admit the 2Kb is somewhat of a stochast, you only hit it
> if you have iptable rules and 2 nic irq's arriving on the same cpu at an
> unfortionate moment, but that doesn't mean it's a safe situation.
> 

I agree with that, but that combination had a heck of a lot of soak time
on it. This stack crunching exercise is happening fairly early on in a
stable kernel series, that makes me nervous. A lot of new code showed up
in the meantime during 2.5 development which changed many of these
code paths.

You can do static code analysis and say which functions are stack hogs and
rework them, but the dynamic analysis is really hard to do for all possibly
combinations. Doing the dynamic analysis on someones production fileserver may
not be the wisest move ever made.

Steve

