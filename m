Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVA0P3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVA0P3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVA0P3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:29:25 -0500
Received: from [63.81.117.10] ([63.81.117.10]:50562 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S262642AbVA0P3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:29:19 -0500
Message-ID: <41F908C4.4080608@xfs.org>
Date: Thu, 27 Jan 2005 09:29:08 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt & Xfs Question
References: <41F91470.6040204@tiscali.de>
In-Reply-To: <41F91470.6040204@tiscali.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2005 15:29:16.0123 (UTC) FILETIME=[F61D32B0:01C50484]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias-Christian Ott wrote:
> Hi!
> I have a question: Why do I get such debug messages:
> 
> BUG: using smp_processor_id() in preemptible [00000001] code: khelper/892
> caller is _pagebuf_lookup_pages+0x11b/0x362
> [<c03119c7>] smp_processor_id+0xa3/0xb4
> [<c02ef802>] _pagebuf_lookup_pages+0x11b/0x362
> [<c02ef802>] _pagebuf_lookup_pages+0x11b/0x362

.....

> 
> Does the XFS Module avoid preemption rules? If so, why?

It is probably coming from these macros which keep various statistics
inside xfs as per cpu variables.

in fs//xfs/linux-2.6/xfs_stats.h:

DECLARE_PER_CPU(struct xfsstats, xfsstats);

/* We don't disable preempt, not too worried about poking the
  * wrong cpu's stat for now */
#define XFS_STATS_INC(count)            (__get_cpu_var(xfsstats).count++)
#define XFS_STATS_DEC(count)            (__get_cpu_var(xfsstats).count--)
#define XFS_STATS_ADD(count, inc)       (__get_cpu_var(xfsstats).count += (inc))

So it knows about the fact that preemption can mess up the result of this,
but it does not really matter for the purpose it is used for here. The
stats are just informational but very handy for working out what is going
on inside xfs. Using a global instead of a per cpu variable would
lead to cache line contention.

If you want to make it go away on a preemptable kernel, then use the
alternate definition of the stat macros which is just below the
above code.

Steve

p.s. try running xfs_stats.pl -f which comes with the xfs-cmds source to
watch the stats.

