Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVCCQ1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVCCQ1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVCCQ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:27:38 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:19341
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261980AbVCCQZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:25:33 -0500
Message-ID: <42273A54.30504@ev-en.org>
Date: Thu, 03 Mar 2005 16:24:52 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dror Cohen <dror.xiv@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Time Drift Compensation on Linux Clusters
References: <6c58e3190503030650595cbd5@mail.gmail.com>
In-Reply-To: <6c58e3190503030650595cbd5@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dror Cohen wrote:
> Hi all,
> While working on a Linux cluster with kernel version 2.4.27 we've
> encountered a consistent clock drift problem. We have devised a fix
> for this problem which is based on the Pentium's TSC clock. We'd
> appreciate any comments on the validity of the proposed solution and
> on whether it might cause unexpected (and undesired) problems in other
> parts of the kernel.

That's an interesting solution to a problem I've seen in the past.

An issue with submission to LKML, you'd better submit a full patch in 
unified diff format with context, the best command for this is:
diff -Nurp kernel-old kernel-new

The possible problem from jumping multiple jiffies is that calculations 
might be skewed off, some are likely to be done based on the assumption 
of a single jiffie increase and some by looking at the difference of 
jiffies from some time in the past.

For example, the call immediately after the increment of jiffies assumes 
a single jiffie passed, but it is not necessarily true. I do not know 
what effects this might have probably nothing that didn't happen with 
the clock skew anyway.

What happens to the TSC when the CPU is halted due to idleness? I don't 
remember exactly but there are cases when it stops ticking and then your 
patch will not advance the clock at all.

You also advance the clock once too much, the condition should probably 
be (xtdc_last + xtdc_step < cycles).

There is also the issue of a loop with 64 bit operations/comparisons in 
the timer. Maybe this should be offloaded to the bh? The cost should be 
better thought of.

Baruch
