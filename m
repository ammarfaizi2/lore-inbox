Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbVJGPHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbVJGPHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbVJGPHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:07:19 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:17158 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1030307AbVJGPHS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:07:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Fix hotplug cpu on x86_64
Date: Fri, 7 Oct 2005 10:07:08 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D9C@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix hotplug cpu on x86_64
Thread-Index: AcXK9kQOZXmasxEwQqKedfycnLpELgAWnHHg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Brian Gerst" <bgerst@didntduck.org>,
       "lkml" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 07 Oct 2005 15:07:09.0371 (UTC) FILETIME=[C9D1A8B0:01C5CB50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Brian Gerst wrote:
> > Brian Gerst wrote:
> >> I've been seeing bogus values from /proc/loadavg on an x86-64 SMP 
> >> kernel (but not UP).
> >>
> >> $ cat /proc/loadavg
> >> -1012098.26 922203.26 -982431.60 1/112 2688
> >>
> >> This is in the current git tree.  I'm also seeing strange values in
> >> /proc/stat:
> >>
> >> cpu  2489 40 920 60530 9398 171 288 1844674407350 cpu0 2509 60 940 
> >> 60550 9418 191 308 0
> >>
> >> The first line is the sum of all cpus (I only have one), so it's 
> >> picking up up bad data from the non-present cpus.  The last value, 
> >> stolen time, is completely bogus since that value is only 
> ever used 
> >> on s390.
> >>
> >> It looks to me like there is some problem with how the per-cpu 
> >> structures are being initialized, or are getting 
> corrupted.  I have 
> >> not been able to test i386 SMP yet to see if the problem is x86_64 
> >> specific.
> > 
> > I found the culprit: CPU hotplug.  The problem is that
> > prefill_possible_map() is called after setup_per_cpu_areas().  This 
> > leaves the per-cpu data sections for the future cpus uninitialized 
> > (still pointing to the original per-cpu data, which is initmem).  
> > Since the cpus exists in cpu_possible_map, for_each_cpu 
> will iterate 
> > over them even though the per-cpu data is invalid.
> 

I had to do the same in i386, but initially I was trying to avoid the
whole situation - allocating per_cpu data for all possible processors.
It seemed wasteful that on the system with NR_CPU=256 or 512 and brought
up as 4x everything per_cpu is (pre)allocated for all, although it's
sure convenient. I though at the time it would be great if
alloc_percpu() mechanism was able to dynamically re-create all the
per_cpu's for new processors, that way cpu_possible_map woun't probably
even be needed. Or is it too much trouble for too little gain...

Thanks,
--Natalie


> Initialize cpu_possible_map properly in the hotplug cpu case. 
>  Before this, the map was filled in after the per-cpu areas 
> were set up.  This left those cpus pointing to initmem and 
> causing invalid data in /proc/stat and elsewhere.
> 
> Signed-off-by: Brian Gerst <bgerst@didntduck.org>
> 
