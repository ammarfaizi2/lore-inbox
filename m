Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVDMBtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVDMBtz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVDMBsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:48:10 -0400
Received: from fmr19.intel.com ([134.134.136.18]:28325 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262625AbVDMBms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:42:48 -0400
Subject: RE: [PATCH 1/6]sep initializing rework
From: Li Shaohua <shaohua.li@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Ryan Harper <ryanh@us.ibm.com>,
       hotplug_sig@lists.osdl.org, Joel Schopp <jschopp@austin.ibm.com>,
       Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04AB0@USRV-EXCH4.na.uis.unisys.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04AB0@USRV-EXCH4.na.uis.unisys.com>
Content-Type: text/plain
Message-Id: <1113356358.7148.27.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Apr 2005 09:39:19 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 01:57, Protasevich, Natalie wrote:
> Hello,
> This is a hotplug CPU patch for i386, done against 2.6.12-rc2-mm3.
> Somewhat alternative to the one posted by Li Shaohua, but not really
> (and I didn't mean that :). If you look closer, our patches are
> different and can complement each other I think. Li did great job on
> sep, after-offline cleanup, __devinit etc., and I have some radical
> changes in the AP bringup mechanism. I left alone __init to __devinit
> part (I was going through it lately, but I think even though I had few
> more than Li did, he covered it sufficiently perhaps). I started
> having
> doubts in free_initmem() vs __devinit because look how many of
> __init's
> left! just a few :). 
Looks quite smart, but people will argue it will keep all __init
sections in this way. I'd like we keep the default behavior of __init. 

> I got rid of do_boot_cpu loop in smpboot.c because
> the loop
> static void __init smp_init(void)
> {
>         unsigned int i;
> 
>         /* FIXME: This should be done in userspace --RR */
>         for_each_present_cpu(i) {
>                 if (num_online_cpus() >= max_cpus)
>                         break;
>                 if (!cpu_online(i))
>                         cpu_up(i);
>         }
> ...
> does it again so why leave it in smpboot.c to boot AP's twice. 
This is what IA64 does. In this way, you must clean up the bogomips
message, TSC synchronization. And CPU_UP could be called in user
context, so fork_idle possibly should be in workqueue. And please make
sure it doesn't break other things like check_nmi_watchdog. I just
select an easy way (add smp_prepare_cpu) and it doesn't break anything. 

> I also
> found that my system fails sooner or later when I try not to synch
> runtime booted processor with others, so I changed tsc synchronization
> to only sync between booting CPU and the one that boots it. 
IA64 also does like this. It synchronizes one AP's ITC against BP's one
time. But in IA32, TSC's upper 32 bits can be written only on prescott
and above. In earlier CPU, upper 32 bits will become 0 after any write.

> The patch
> works for me on Intel 8x generic box, and on ES7000. I was asked to
> separate my patch into smaller ones by the theme, but I'm posting the
> entire patch for now, because I think it is probably not the final
> one.
> I think (I hope) I will sync up with Li later on.
> My idea was that if we find a CPU core in ACPI (enabled or disabled),
> we
> encounter for it in sibling map and create a sysfs node accordingly,
> and
> cpu_possible_map will reflect that. We take processors up/down
> depending
> on physical presence using the existing node. That's the scenario
> implemented on ES7000 that reports all possible cores in ACPI marking
> absent processors as disabled. Runtime enablement/disablement depends
> on
> sysfs only and the driving agent can be anything (ACPI or user) that
> triggers sysfs node for this processor.
You possibly can refer to IA64's implementation. The goal of my patches
are to support suspend/resume, which actually doesn't really hotremove a
CPU, so I just ignored the sysfs/ACPI issues.

Thanks,
Shaohua

> 
> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@arm.linux.org.uk] 
> Sent: Tuesday, April 12, 2005 6:08 AM
> To: Li Shaohua
> Cc: lkml; ACPI-DEV; Len Brown; Pavel Machek; Andrew Morton;
> Protasevich,
> Natalie; Ryan Harper
> Subject: Re: [PATCH 1/6]sep initializing rework
> 
> Hello Shaohua,
> 
> On Tue, 12 Apr 2005, Li Shaohua wrote:
> 
> > These patches (together with 5 patches followed this one) are
> updated 
> > suspend/resume SMP patches. The patches fixed some bugs and do clean
> > up as suggested. Now they work for both suspend-to-ram and
> suspend-to-disk.
> > Patches are against 2.6.12-rc2-mm3.
> 
> These patches look good and i think we should go ahead with them. I've
> also cross checked with physical hotplug cpu patches for ES7xxx from
> Natalie (added to Cc) and it does indeed look like a lot of the code
> will work for her too, but i'd appreciate it if she also does a double
> check. 
> Obviously this won't work for other upcoming users of hotplug cpu like
> Xen (Ryan added to Cc) but i think we can abstract things later on to
> cover other special users.
> 
> Thanks Shaohua,
>         Zwane
> 

