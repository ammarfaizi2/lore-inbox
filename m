Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWBJOSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWBJOSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBJOSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:18:23 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:50901 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932100AbWBJOSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:18:22 -0500
Message-ID: <43EC9F89.7090809@cosmosbay.com>
Date: Fri, 10 Feb 2006 15:13:29 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ak@muc.de, ashok.raj@intel.com, ntl@pobox.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
References: <20060209160808.GL18730@localhost.localdomain>	<20060209090321.A9380@unix-os.sc.intel.com>	<20060209100429.03f0b1c3.akpm@osdl.org>	<200602101102.25437.ak@muc.de>	<20060210024222.67db06f3.akpm@osdl.org>	<43EC7473.20109@cosmosbay.com> <20060210032332.13ed3b67.akpm@osdl.org>
In-Reply-To: <20060210032332.13ed3b67.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060307030607060606000403"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 10 Feb 2006 15:13:34 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060307030607060606000403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>> Andrew Morton a écrit :
>>> Andi Kleen <ak@muc.de> wrote:
>>>> On Thursday 09 February 2006 19:04, Andrew Morton wrote:
>>>>> Ashok Raj <ashok.raj@intel.com> wrote:
>>>>>> The problem was with ACPI just simply looking at the namespace doesnt
>>>>>>  exactly give us an idea of how many processors are possible in this platform.
>>>>> We need to fix this asap - the performance penalty for HOTPLUG_CPU=y,
>>>>> NR_CPUS=lots will be appreciable.
>>>> What is this performance penalty exactly? 
>>> All those for_each_cpu() loops will hit NR_CPUS cachelines instead of
>>> hweight(cpu_possible_map) cachelines.
>> You mean NR_CPUS bits, mostly all included in a single cacheline, and even in 
>> a single long word :) for most cases (NR_CPUS <= 32 or 64)
>>
> 
> No, I mean cachelines:
> 
> static void recalc_bh_state(void)
> {
> 	int i;
> 	int tot = 0;
> 
> 	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
> 		return;
> 	__get_cpu_var(bh_accounting).ratelimit = 0;
> 	for_each_cpu(i)
> 		tot += per_cpu(bh_accounting, i).nr;
> 
> That's going to hit NR_CPUS cachelines even on a 2-way.
> 
> Or am I missing something really obvious here?


OK I see. This can be solved with this patch :

[PATCH] HOTPLUG_CPU : avoid hitting too many cachelines in recalc_bh_state()

Instead of using for_each_cpu(i), we can use for_each_online_cpu(i) : The 
difference matters if HOTPUG_CPU=y

When a CPU goes offline (ie removed from online map), it might have a non null 
bh_accounting.nr, so this patch adds a transfert of this counter to an online 
CPU counter.

We already have a hotcpu_notifier, (function buffer_cpu_notify()), where we 
can do this bh_accounting.nr transfert.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------060307030607060606000403
Content-Type: text/plain;
 name="buffer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="buffer.patch"

--- a/fs/buffer.c	2006-02-10 15:08:21.000000000 +0100
+++ b/fs/buffer.c	2006-02-10 15:47:55.000000000 +0100
@@ -3138,7 +3138,7 @@
 	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
 		return;
 	__get_cpu_var(bh_accounting).ratelimit = 0;
-	for_each_cpu(i)
+	for_each_online_cpu(i)
 		tot += per_cpu(bh_accounting, i).nr;
 	buffer_heads_over_limit = (tot > max_buffer_heads);
 }
@@ -3187,6 +3187,9 @@
 		brelse(b->bhs[i]);
 		b->bhs[i] = NULL;
 	}
+	get_cpu_var(bh_accounting).nr += per_cpu(bh_accounting, cpu).nr ;
+	per_cpu(bh_accounting, cpu).nr = 0;
+	put_cpu_var(bh_accounting);
 }
 
 static int buffer_cpu_notify(struct notifier_block *self,

--------------060307030607060606000403--
