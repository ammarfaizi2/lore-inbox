Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUHNL3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUHNL3G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268601AbUHNL3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:29:06 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:53511 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S268224AbUHNL24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:28:56 -0400
Message-ID: <411DF776.6090102@superbug.demon.co.uk>
Date: Sat, 14 Aug 2004 12:28:54 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
In-Reply-To: <20040812235116.GA27838@elte.hu>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've uploaded the latest version of the voluntary-preempt patch:
>      
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6
> 
<snip>
> reports, suggestions welcome,
> 
> 	Ingo

I used O7.

I have tested this for a day now, and I have noticed problems:
1)
kernel syslog gets a record like this:
 >  (default.hotplug/1470): 121 us critical section violates 100 us 
threshold.
 >   => started at: <kmap_high+0x2b/0x2d0>
 >   => ended at:   <kmap_high+0x1a9/0x2d0>
 >   [<c0105a23>] dump_stack+0x23/0x30
 >   [<c0140d14>] check_preempt_timing+0x184/0x1e0
 >   [<c0140e84>] sub_preempt_count+0x54/0x5d
 >   [<c0152959>] kmap_high+0x1a9/0x2d0
 >   [<c017655a>] copy_strings+0xea/0x230
 >   [<c01766db>] copy_strings_kernel+0x3b/0x50
 >   [<c017840d>] do_execve+0x12d/0x1f0
 >   [<c0103284>] sys_execve+0x44/0x80
 >   [<c0104b95>] sysenter_past_esp+0x52/0x71
and the /proc/latency_trace gets:
 >   preemption latency trace v1.0
 >   -----------------------------
 >    latency: 121 us, entries: 1032 (1032)
 >    process: default.hotplug/1470, uid: 0
 >    nice: -10, policy: 0, rt_priority: 0
 >   =======>
 >    0.000ms (+0.000ms): page_address (kmap_high)
 >    0.000ms (+0.000ms): page_slot (page_address)
 >    0.000ms (+0.000ms): flush_all_zero_pkmaps (kmap_high)
 >    0.000ms (+0.000ms): set_page_address (flush_all_zero_pkmaps)
 >   [...]
 >    0.118ms (+0.000ms): page_slot (set_page_address)
 >    0.118ms (+0.000ms): check_preempt_timing (sub_preempt_count)

Could the patch be adjusted to make the syslog and the 
/proc/latency_trace produce the same output?

2)
I suspect that there is a problem with reiserfs, but when I detect a 
momentary hang in the system(mouse stops moving), no latency_trace appears.

