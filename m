Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161533AbWHDWYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161533AbWHDWYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161535AbWHDWYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:24:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7812 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161533AbWHDWYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:24:07 -0400
Date: Fri, 4 Aug 2006 18:24:00 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060804222400.GC18792@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	LKML <linux-kernel@vger.kernel.org>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com> <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:24:57PM -0700, Linus Torvalds wrote:

 > On Fri, 4 Aug 2006, Michal Piotrowski wrote:
 > > This was reported
 > > http://www.ussg.iu.edu/hypermail/linux/kernel/0607.3/1867.html
 > > http://www.ussg.iu.edu/hypermail/linux/kernel/0608.0/0675.html
 > > 
 > > It's time to use git-bisect.
 > > 
 > > BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
 > 
 > Ok, that really is a pretty scary thing. The warning happens if the lock 
 > is released by somebody else than the person who took it. I don't _think_ 
 > that's supposed to happen, but with cpu hotplug locking being as 
 > "creative" as it is, maybe it's valid. 
 > 
 > I was planning on shutting the cpu hotplug warnings up for v2.6.18 - at 
 > least the "lukewarm IQ" one for _taking_ the lock recursively. But I had 
 > planned on leaving the unlock_cpu_hotplug() in place, since up until now 
 > it hadn't triggered, and it really smells like a bug if it does.
 > 
 > > [<c0132a04>] unlock_cpu_hotplug+0x2c/0x54
 > > [<c013a2ec>] stop_machine_run+0x2e/0x34
 > > [<c0135686>] sys_init_module+0x15a0/0x178a
 > > [<c015b7b7>] do_sync_read+0xb6/0xf1
 > > [<c0102d51>] sysenter_past_esp+0x56/0x79
 > 
 > DaveJ, any ideas?

Not really :-/
Whilst it's mentioned that the git-cpufreq.patch that was in -mm
made this happen, I really don't see anything in what you merged
yesterday that could explain any of this.

99% of the changes were to longhaul, so we can ignore those,
leaving just:

[CPUFREQ] return error when failing to set minfreq

Looks benign.

[CPUFREQ] Propagate acpi_processor_preregister_performance return value.

Shouldn't affect anything wrt hotplug

[CPUFREQ] [1/2] add __find_governor helper and clean up some error handling.
[CPUFREQ] [2/2] demand load governor modules.

Looks harmless to me, and those new functions don't show up
in any of those functions.

So I'm at a loss to explain why this made this bug suddenly appear, but
I don't think this is anything new.   Fixing it however...
I'm looking at it, but I don't see anything obvious yet.

		Dave

-- 
http://www.codemonkey.org.uk
