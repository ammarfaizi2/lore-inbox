Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVJESAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVJESAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 14:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVJESAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 14:00:09 -0400
Received: from quark.didntduck.org ([69.55.226.66]:62874 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1030305AbVJESAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 14:00:08 -0400
Message-ID: <434414C4.8020109@didntduck.org>
Date: Wed, 05 Oct 2005 14:00:36 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.4 (X11/20050928)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bogus load average and cpu times on x86_64 SMP kernels
References: <43437DEB.4080405@didntduck.org>
In-Reply-To: <43437DEB.4080405@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> I've been seeing bogus values from /proc/loadavg on an x86-64 SMP kernel 
> (but not UP).
> 
> $ cat /proc/loadavg
> -1012098.26 922203.26 -982431.60 1/112 2688
> 
> This is in the current git tree.  I'm also seeing strange values in 
> /proc/stat:
> 
> cpu  2489 40 920 60530 9398 171 288 1844674407350
> cpu0 2509 60 940 60550 9418 191 308 0
> 
> The first line is the sum of all cpus (I only have one), so it's picking 
> up up bad data from the non-present cpus.  The last value, stolen time, 
> is completely bogus since that value is only ever used on s390.
> 
> It looks to me like there is some problem with how the per-cpu 
> structures are being initialized, or are getting corrupted.  I have not 
> been able to test i386 SMP yet to see if the problem is x86_64 specific.

I found the culprit: CPU hotplug.  The problem is that 
prefill_possible_map() is called after setup_per_cpu_areas().  This 
leaves the per-cpu data sections for the future cpus uninitialized 
(still pointing to the original per-cpu data, which is initmem).  Since 
the cpus exists in cpu_possible_map, for_each_cpu will iterate over them 
even though the per-cpu data is invalid.

--
				Brian Gerst
