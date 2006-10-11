Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161433AbWJKVIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161433AbWJKVIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWJKVIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:08:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:36002 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161435AbWJKVIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:17 -0400
Date: Wed, 11 Oct 2006 14:07:52 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 50/67] CPUFREQ: Fix some more CPU hotplug locking.
Message-ID: <20061011210752.GY16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cpufreq-fix-some-more-cpu-hotplug-locking.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Dave Jones <davej@redhat.com>

[CPUFREQ] Fix some more CPU hotplug locking.

Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
[<b0134a42>] lock_cpu_hotplug+0x42/0x65
[<b02f8af1>] cpufreq_update_policy+0x25/0xad
[<b0358756>] kprobe_flush_task+0x18/0x40
[<b0355aab>] schedule+0x63f/0x68b
[<b01377c2>] __link_module+0x0/0x1f
[<b0119e7d>] __cond_resched+0x16/0x34
[<b03560bf>] cond_resched+0x26/0x31
[<b0355b0e>] wait_for_completion+0x17/0xb1
[<f965c547>] cpufreq_stat_cpu_callback+0x13/0x20 [cpufreq_stats]
[<f9670074>] cpufreq_stats_init+0x74/0x8b [cpufreq_stats]
[<b0137872>] sys_init_module+0x91/0x174
[<b0102c81>] sysenter_past_esp+0x56/0x79

As there are other places that call cpufreq_update_policy without
the hotplug lock, it seems better to keep the hotplug locking
at the lower level for the time being until this is revamped.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/cpufreq/cpufreq_stats.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.18.orig/drivers/cpufreq/cpufreq_stats.c
+++ linux-2.6.18/drivers/cpufreq/cpufreq_stats.c
@@ -350,12 +350,10 @@ __init cpufreq_stats_init(void)
 	}
 
 	register_hotcpu_notifier(&cpufreq_stat_cpu_notifier);
-	lock_cpu_hotplug();
 	for_each_online_cpu(cpu) {
 		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_ONLINE,
 			(void *)(long)cpu);
 	}
-	unlock_cpu_hotplug();
 	return 0;
 }
 static void

--
