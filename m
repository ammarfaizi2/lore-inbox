Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUEKXTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUEKXTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUEKXTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:19:54 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:10885 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265037AbUEKXSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:18:46 -0400
Date: Tue, 11 May 2004 16:16:53 -0700
From: Paul Jackson <pj@sgi.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com
Subject: Re: (resend) take3: Updated CPU Hotplug patches for IA64 (pj
 blessed) Patch [6/7]
Message-Id: <20040511161653.49e836e5.pj@sgi.com>
In-Reply-To: <20040504211755.A13286@unix-os.sc.intel.com>
References: <20040504211755.A13286@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Being somewhat thick in the head at times, it took me a lengthy private
email thread with Ashok to understand why he needed to add a
cpu_present_map for his cpu hotplug work, and just how that new map
related to the existing ones.

After patient and repeated explanations from Ashok, I worked out the
following explanation that he found accurate.  On the off chance that
others find this way of phrasing it helpful, I post it here for the
record.

===

Ashok's cpu hot plug patch adds a cpu_present_map, resulting in the
following cpu maps being available.  All the following maps are fixed
size bitmaps of size NR_CPUS.

#ifdef CONFIG_HOTPLUG_CPU
	cpu_possible_map - map with all NR_CPUS bits set
	cpu_present_map - map with bit 'cpu' set iff cpu is populated
	cpu_online_map - map with bit 'cpu' set iff cpu available to scheduler
#else
	cpu_possible_map - map with bit 'cpu' set iff cpu is populated
	cpu_present_map - copy of cpu_possible_map
	cpu_online_map - map with bit 'cpu' set iff cpu available to scheduler
#endif

In either case, NR_CPUS is fixed at compile time, as the static size of
these bitmaps.  The cpu_possible_map is fixed at boot time, as the set
of CPU id's that it is possible might ever be plugged in at anytime
during the life of that system boot.  The cpu_present_map is dynamic(*),
representing which CPUs are currently plugged in.  And cpu_online_map is
the dynamic subset of cpu_present_map, indicating those CPUs available
for scheduling.

If HOTPLUG is enabled, then cpu_possible_map is forced to have all
NR_CPUS bits set, otherwise it is just the set of CPUs that ACPI reports
present at boot.

If HOTPLUG is enabled, then cpu_present_map varies dynamically,
depending on what ACPI reports as currently plugged in, otherwise
cpu_present_map is just a copy of cpu_possible_map.

(*) Well, cpu_present_map is dynamic in the hotplug case.
    If not hotplug, it's the same as cpu_possible_map, hence
    fixed at boot.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
