Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758144AbWLACtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144AbWLACtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 21:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758150AbWLACtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 21:49:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:43958 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1758144AbWLACtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 21:49:12 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,482,1157353200"; 
   d="scan'208"; a="171424509:sNHT1620646699"
Subject: Re: CPU hotplug broken with 2GB VMSPLIT
From: Shaohua Li <shaohua.li@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, pavel@ucw.cz, bryce@osdl.org,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <20061130172058.GC22050@localdomain>
References: <20061130090348.GK5400@kernel.dk>
	 <20061130091334.GM5400@kernel.dk> <20061130164347.GB22050@localdomain>
	 <20061130172058.GC22050@localdomain>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 10:48:27 +0800
Message-Id: <1164941307.4640.1.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 01:20 +0800, Nathan Lynch wrote:
> Nathan Lynch wrote:
> > Jens Axboe wrote:
> > > On Thu, Nov 30 2006, Jens Axboe wrote:
> > > > Hi,
> > > >
> > > > Just got a new notebook (Lenovo X60), setup a custom kernel and
> then I
> > > > noticed that suspend to ram doesn't work anymore. The machine
> suspends
> > > > just fine, on resume it brings back the text display but reboots
> after
> > > > it has stalled for a few seconds. On the suggestion of Pavel, I
> tried
> > > > testing CPU hotplug, and indeed he was right: I can offline 1 of
> the
> > > > cores fine, bringing it back online freezes the machine for 3-4
> seconds
> > > > and then reboots.
> > > >
> > > > carl:/sys/devices/system/cpu/cpu1 # echo 0 > online
> > > > carl:/sys/devices/system/cpu/cpu1 # dmesg
> > > > Breaking affinity for irq 219
> > > > CPU 1 is now offline
> > > > SMP alternatives: switching to UP code
> > > > carl:/sys/devices/system/cpu/cpu1 # echo 1 > online
> > > > Read from remote host carl: Connection reset by peer
> > > >
> > > > Booting with maxcpus=1 and resume works fine. Does this ring a
> bell with
> > > > anyone? With highmem enabled and the standard vmsplit, cpu
> hotplug works
> > > > fine for me.
> > >
> > > Some more clues - booting with noreplacement doesn't fix it, so I
> think
> > > the alternatives code is off the hook.
> >
> > I don't think this adds any new information, but it has been open
> > awhile:
> >
> > http://bugme.osdl.org/show_bug.cgi?id=6542
> >
> > I was able to narrow it down to the vmsplit setting but I wasn't
> able
> > to debug it further.
> 
> Hmm, I'm pretty sure this is the same problem I reported in March,
> there might be some more information in that thread:
> 
> http://marc.theaimsgroup.com/?t=114039363100002&r=1&w=1
> 
> but I didn't realize it was vmsplit-related at that time.
Does this patch help?

Thanks,
Shaohua

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
index 4bb8b77..b5f562e 100644
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -1095,7 +1095,7 @@ static int __cpuinit __smp_prepare_cpu(i
 
 	/* init low mem mapping */
 	clone_pgd_range(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
-			KERNEL_PGD_PTRS);
+			min_t(unsigned long, KERNEL_PGD_PTRS, USER_PGD_PTRS));
 	flush_tlb_all();
 	schedule_work(&task);
 	wait_for_completion(&done);
