Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965372AbWJBTXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965372AbWJBTXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965373AbWJBTXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:23:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:53729 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965372AbWJBTXa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:23:30 -0400
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <200610021908.k92J8J8c012853@turing-police.cc.vt.edu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	 <200610021302.k92D23W1003320@turing-police.cc.vt.edu>
	 <1159796582.1386.9.camel@localhost.localdomain>
	 <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
	 <1159814317.5873.14.camel@localhost.localdomain>
	 <200610021908.k92J8J8c012853@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 12:23:25 -0700
Message-Id: <1159817005.4312.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 15:08 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 02 Oct 2006 11:38:36 PDT, john stultz said:
> 
> > Hmmm. So w/ -mm2 we're seeing the TSC get detected as running too slowly
> > (and its replaced w/ the ACPI PM), but for some reason that doesn't
> > happen w/ the dynticks patch.
> 
> It's been switching to ACPI PM for somewhere near forever, I never bothered
> to check into that because the PM timer provides a reasonably stable clock
> source (it drifts at about 24 ppm and NTP is happy with it, and I haven't
> gotten annoyed at the fact the PM timer is slow to read...)
> 
> I wonder if the TSC has been broken for forever on this box, and I'm just
> seeing it because dynticks doesn't fall over to PM timer..

This is what I suspect is the issue. Probably due to the new jiffies
accounting being now time based, and one of the TSC unstable checks (the
one you're tripping) being jiffies based. A tad bit circular :). I'm
working w/ tglx to see what we can do here.

> > Now, how is cpuspeed changing the cpufreq? Is it using the /sys
> > interface? I've got hooks in so when the cpufreq changes we should mark
> > it unstable and fall back to ACPI PM, but maybe I missed whatever hook
> > cpuspeed is using.
> 
> Looking at the source, it appears to do this:
> 
> const char SYSFS_CURRENT_SPEED_FILE[] =
>      "/sys/devices/system/cpu/cpu%u/cpufreq/scaling_setspeed";
> 
> // set the current CPU speed
> void set_speed(unsigned value)
> {
> #ifdef DEBUG
>     fprintf(stderr, "[cpu%u] Setting speed to: %uKHz\n", cpu, value);
> #endif
>     write_line(CURRENT_SPEED_FILE, "%u\n", value);
>     // give CPU / chipset voltage time to settle down
>     usleep(10000);
> }

I'll also take a peek there and see if I cannot add an extra hook, so we
don't have to rely on the jiffies stability check.

thanks
-john

