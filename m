Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVA0PmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVA0PmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbVA0PmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:42:20 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:35806 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262643AbVA0Plq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:41:46 -0500
Message-ID: <41F927DC.50003@tiscali.de>
Date: Thu, 27 Jan 2005 17:41:48 +0000
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Lord <lord@xfs.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt & Xfs Question
References: <41F91470.6040204@tiscali.de> <41F908C4.4080608@xfs.org>
In-Reply-To: <41F908C4.4080608@xfs.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:

> Matthias-Christian Ott wrote:
>
>> Hi!
>> I have a question: Why do I get such debug messages:
>>
>> BUG: using smp_processor_id() in preemptible [00000001] code: 
>> khelper/892
>> caller is _pagebuf_lookup_pages+0x11b/0x362
>> [<c03119c7>] smp_processor_id+0xa3/0xb4
>> [<c02ef802>] _pagebuf_lookup_pages+0x11b/0x362
>> [<c02ef802>] _pagebuf_lookup_pages+0x11b/0x362
>
>
> .....
>
>>
>> Does the XFS Module avoid preemption rules? If so, why?
>
>
> It is probably coming from these macros which keep various statistics
> inside xfs as per cpu variables.
>
> in fs//xfs/linux-2.6/xfs_stats.h:
>
> DECLARE_PER_CPU(struct xfsstats, xfsstats);
>
> /* We don't disable preempt, not too worried about poking the
>  * wrong cpu's stat for now */
> #define XFS_STATS_INC(count)            (__get_cpu_var(xfsstats).count++)
> #define XFS_STATS_DEC(count)            (__get_cpu_var(xfsstats).count--)
> #define XFS_STATS_ADD(count, inc)       (__get_cpu_var(xfsstats).count 
> += (inc))
>
> So it knows about the fact that preemption can mess up the result of 
> this,
> but it does not really matter for the purpose it is used for here. The
> stats are just informational but very handy for working out what is going
> on inside xfs. Using a global instead of a per cpu variable would
> lead to cache line contention.
>
> If you want to make it go away on a preemptable kernel, then use the
> alternate definition of the stat macros which is just below the
> above code.
>
> Steve
>
> p.s. try running xfs_stats.pl -f which comes with the xfs-cmds source to
> watch the stats.
>
>
Hi!
It happens to all functions -- not only to the stat functions -- because 
of this macro:
#define current_cpu()           smp_processor_id()

But this it not my problem (setting it 0 fixes it or get_cpu()). I just 
wanted to know why it breaks the preemption rules.

Matthias-Christian

-- 
http://unixforge.org/~matthias-christian-ott/

