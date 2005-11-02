Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbVKBHIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbVKBHIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVKBHIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:08:04 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:10662 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932602AbVKBHIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:08:02 -0500
Date: Wed, 2 Nov 2005 08:07:50 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu hoptlug: avoid usage of smp_processor_id() in preemptible code
Message-ID: <20051102070750.GA8083@osiris.boeblingen.de.ibm.com>
References: <20051101145402.GA20255@osiris.ibm.com> <20051102064854.GB943@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102064854.GB943@elte.hu>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > Replace smp_processor_id() with any_online_cpu(cpu_online_map) in 
> > order to avoid lots of "BUG: using smp_processor_id() in preemptible 
> > [00000001] code:..." messages in case taking a cpu online fails.
> 
> could you post the full message, including the stacktrace? I think this 
> patch just works around the debugging message, and there might be some 
> real bug to fix.
> 
> 	Ingo

Sure, all traces start actually at the last notifier_call_chain(...) in
kernel/cpu.c. Since we hold the cpu_control semaphore it shouldn't be
any problem to access cpu_online_map.
The reason why cpu_up failed is simply that the cpu that was supposed to be
taken online wasn't even there. That is because on s390 we never know when
a new cpu comes and therefore cpu_possible_map consists of only ones and
doesn't reflect reality.

Heiko

BUG: using smp_processor_id() in preemptible [00000001] code: bash/1398
caller is migration_call+0x1c8/0x920
000000000d377928 07d9fe4c616704cc 0000000000357d22 0000000000357d22 
       0000000000015dc8 00000000004e3838 000000000dc6a500 000000000d9c5180 
       00000000004072e0 0000000000000000 000000000d377888 000000000d3778d8 
       000000000000000c 000000000032e040 0000000000015dc8 000000000d377888 
       0000000000000004 0000000000000000 000000000d3779c8 000000000d377928 
Call Trace:
([<0000000000015d5c>] show_trace+0xbc/0xd0)
 [<0000000000149fb6>] debug_smp_processor_id+0xee/0xf4
 [<000000000002ac48>] migration_call+0x1c8/0x920
 [<0000000000043292>] notifier_call_chain+0x46/0x84
 [<0000000000052c06>] cpu_up+0x16a/0x1c0
 [<000000000015bc92>] store_online+0xae/0xe0
 [<00000000000d3af0>] sysfs_write_file+0x150/0x1c4
 [<000000000008963a>] vfs_write+0xae/0x184
 [<000000000008a186>] sys_write+0x52/0x84
 [<00000000000211e6>] sysc_do_restart+0x16/0x1c
 [<0000020000107e24>] 0x20000107e24

BUG: using smp_processor_id() in preemptible [00000001] code: bash/1398
caller is cpu_callback+0x156/0x360
000000000d377980 000000000d377870 0000000000357d22 0000000000357d22 
       0000000000015dc8 000000000d374000 000000000dc6a500 0000020000020000 
       00000000004072e0 0000000000000000 000000000d3778e0 000000000d377930 
       000000000000000c 000000000032e040 0000000000015dc8 000000000d3778e0 
       0000000000000004 0000000000000000 000000000d377a20 000000000d377980 
Call Trace:
([<0000000000015d5c>] show_trace+0xbc/0xd0)
 [<0000000000149fb6>] debug_smp_processor_id+0xee/0xf4
 [<0000000000038a4a>] cpu_callback+0x156/0x360
 [<0000000000043292>] notifier_call_chain+0x46/0x84
 [<0000000000052c06>] cpu_up+0x16a/0x1c0
 [<000000000015bc92>] store_online+0xae/0xe0
 [<00000000000d3af0>] sysfs_write_file+0x150/0x1c4
 [<000000000008963a>] vfs_write+0xae/0x184
 [<000000000008a186>] sys_write+0x52/0x84
 [<00000000000211e6>] sysc_do_restart+0x16/0x1c
 [<0000020000107e24>] 0x20000107e24

BUG: using smp_processor_id() in preemptible [00000001] code: bash/1398
caller is cpu_callback+0x138/0x1c0
000000000d377988 0000000000a2f1b0 0000000000357d22 0000000000357d22 
       0000000000015dc8 000000000d374000 000000000dc6a500 0000020000020000 
       00000000004072e0 0000000000000000 000000000d3778e8 000000000d377938 
       000000000000000c 000000000032e040 0000000000015dc8 000000000d3778e8 
       0000000000000004 0000000000000000 000000000d377a28 000000000d377988 
Call Trace:
([<0000000000015d5c>] show_trace+0xbc/0xd0)
 [<0000000000149fb6>] debug_smp_processor_id+0xee/0xf4
 [<000000000005c00c>] cpu_callback+0x138/0x1c0
 [<0000000000043292>] notifier_call_chain+0x46/0x84
 [<0000000000052c06>] cpu_up+0x16a/0x1c0
 [<000000000015bc92>] store_online+0xae/0xe0
 [<00000000000d3af0>] sysfs_write_file+0x150/0x1c4
 [<000000000008963a>] vfs_write+0xae/0x184
 [<000000000008a186>] sys_write+0x52/0x84
 [<00000000000211e6>] sysc_do_restart+0x16/0x1c
 [<0000020000107e24>] 0x20000107e24

BUG: using smp_processor_id() in preemptible [00000001] code: bash/1398
caller is workqueue_cpu_callback+0x17c/0x358
000000000d377978 000000000ebb1280 0000000000357d22 0000000000357d22 
       0000000000015dc8 000000000d374000 000000000dc6a500 0000000000000009 
       00000000004072e0 0000000000000000 000000000d3778d8 000000000d377928 
       000000000000000c 000000000032e040 0000000000015dc8 000000000d3778d8 
       0000000000000004 0000000000000000 000000000d377a18 000000000d377978 
Call Trace:
([<0000000000015d5c>] show_trace+0xbc/0xd0)
 [<0000000000149fb6>] debug_smp_processor_id+0xee/0xf4
 [<00000000000472ac>] workqueue_cpu_callback+0x17c/0x358
 [<0000000000043292>] notifier_call_chain+0x46/0x84
 [<0000000000052c06>] cpu_up+0x16a/0x1c0
 [<000000000015bc92>] store_online+0xae/0xe0
 [<00000000000d3af0>] sysfs_write_file+0x150/0x1c4
 [<000000000008963a>] vfs_write+0xae/0x184
 [<000000000008a186>] sys_write+0x52/0x84
 [<00000000000211e6>] sysc_do_restart+0x16/0x1c
 [<0000020000107e24>] 0x20000107e24

BUG: using smp_processor_id() in preemptible [00000001] code: bash/1398
caller is workqueue_cpu_callback+0x17c/0x358
000000000d377978 000000000d377888 0000000000357d22 0000000000357d22 
       0000000000015dc8 000000000d374000 000000000dc6a500 0000000000000009 
       00000000004072e0 0000000000000000 000000000d3778d8 000000000d377928 
       000000000000000c 000000000032e040 0000000000015dc8 000000000d3778d8 
       0000000000000004 0000000000000000 000000000d377a18 000000000d377978 
Call Trace:
([<0000000000015d5c>] show_trace+0xbc/0xd0)
 [<0000000000149fb6>] debug_smp_processor_id+0xee/0xf4
 [<00000000000472ac>] workqueue_cpu_callback+0x17c/0x358
 [<0000000000043292>] notifier_call_chain+0x46/0x84
 [<0000000000052c06>] cpu_up+0x16a/0x1c0
 [<000000000015bc92>] store_online+0xae/0xe0
 [<00000000000d3af0>] sysfs_write_file+0x150/0x1c4
 [<000000000008963a>] vfs_write+0xae/0x184
 [<000000000008a186>] sys_write+0x52/0x84
 [<00000000000211e6>] sysc_do_restart+0x16/0x1c
 [<0000020000107e24>] 0x20000107e24

BUG: using smp_processor_id() in preemptible [00000001] code: bash/1398
caller is workqueue_cpu_callback+0x17c/0x358
000000000d377978 000000000d377888 0000000000357d22 0000000000357d22 
       0000000000015dc8 000000000d374000 000000000dc6a500 0000000000000009 
       00000000004072e0 0000000000000000 000000000d3778d8 000000000d377928 
       000000000000000c 000000000032e040 0000000000015dc8 000000000d3778d8 
       0000000000000004 0000000000000000 000000000d377a18 000000000d377978 
Call Trace:
([<0000000000015d5c>] show_trace+0xbc/0xd0)
 [<0000000000149fb6>] debug_smp_processor_id+0xee/0xf4
 [<00000000000472ac>] workqueue_cpu_callback+0x17c/0x358
 [<0000000000043292>] notifier_call_chain+0x46/0x84
 [<0000000000052c06>] cpu_up+0x16a/0x1c0
 [<000000000015bc92>] store_online+0xae/0xe0
 [<00000000000d3af0>] sysfs_write_file+0x150/0x1c4
 [<000000000008963a>] vfs_write+0xae/0x184
 [<000000000008a186>] sys_write+0x52/0x84
 [<00000000000211e6>] sysc_do_restart+0x16/0x1c
 [<0000020000107e24>] 0x20000107e24

BUG: using smp_processor_id() in preemptible [00000001] code: bash/1398
caller is workqueue_cpu_callback+0x17c/0x358
000000000d377978 000000000d377888 0000000000357d22 0000000000357d22 
       0000000000015dc8 000000000d374000 000000000dc6a500 0000000000000009 
       00000000004072e0 0000000000000000 000000000d3778d8 000000000d377928 
       000000000000000c 000000000032e040 0000000000015dc8 000000000d3778d8 
       0000000000000004 0000000000000000 000000000d377a18 000000000d377978 
Call Trace:
([<0000000000015d5c>] show_trace+0xbc/0xd0)
 [<0000000000149fb6>] debug_smp_processor_id+0xee/0xf4
 [<00000000000472ac>] workqueue_cpu_callback+0x17c/0x358
 [<0000000000043292>] notifier_call_chain+0x46/0x84
 [<0000000000052c06>] cpu_up+0x16a/0x1c0
 [<000000000015bc92>] store_online+0xae/0xe0
 [<00000000000d3af0>] sysfs_write_file+0x150/0x1c4
 [<000000000008963a>] vfs_write+0xae/0x184
 [<000000000008a186>] sys_write+0x52/0x84
 [<00000000000211e6>] sysc_do_restart+0x16/0x1c
 [<0000020000107e24>] 0x20000107e24

BUG: using smp_processor_id() in preemptible [00000001] code: bash/1398
caller is workqueue_cpu_callback+0x17c/0x358
000000000d377978 000000000d377888 0000000000357d22 0000000000357d22 
       0000000000015dc8 000000000d374000 000000000dc6a500 0000000000000009 
       00000000004072e0 0000000000000000 000000000d3778d8 000000000d377928 
       000000000000000c 000000000032e040 0000000000015dc8 000000000d3778d8 
       0000000000000004 0000000000000000 000000000d377a18 000000000d377978 
Call Trace:
([<0000000000015d5c>] show_trace+0xbc/0xd0)
 [<0000000000149fb6>] debug_smp_processor_id+0xee/0xf4
 [<00000000000472ac>] workqueue_cpu_callback+0x17c/0x358
 [<0000000000043292>] notifier_call_chain+0x46/0x84
 [<0000000000052c06>] cpu_up+0x16a/0x1c0
 [<000000000015bc92>] store_online+0xae/0xe0
 [<00000000000d3af0>] sysfs_write_file+0x150/0x1c4
 [<000000000008963a>] vfs_write+0xae/0x184
 [<000000000008a186>] sys_write+0x52/0x84
 [<00000000000211e6>] sysc_do_restart+0x16/0x1c
 [<0000020000107e24>] 0x20000107e24
