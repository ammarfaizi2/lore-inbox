Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265028AbUFANR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265028AbUFANR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUFANR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:17:29 -0400
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265028AbUFANR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:17:26 -0400
Date: Tue, 1 Jun 2004 15:15:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: paul.devriendt@amd.com, Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: PREEMPT problems in cpufreq/powernow-k8
Message-ID: <20040601131552.GA614@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I enabled CONFIG_PREEMPT to test swsusp, and it uncovered some
problems with powernow-k8:


md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011b91a>] __might_sleep+0xaa/0xb8
 [<c0333dd2>] cpufreq_notify_transition+0x32/0x168
 [<c010fd5d>] transition_frequency+0xa1/0x104
 [<c010fe9b>] powernowk8_target+0xdb/0x130
 [<c03337ab>] __cpufreq_driver_target+0x1b/0x20
 [<c03341ea>] cpufreq_governor_performance+0x1e/0x24
 [<c033388a>] __cpufreq_governor+0x6e/0x10c
 [<c0333c5d>] __cpufreq_set_policy+0x139/0x144
 [<c0333cb5>] cpufreq_set_policy+0x4d/0x94
 [<c0334896>] cpufreq_proc_write+0x9e/0xb8
 [<c0142440>] handle_mm_fault+0xc8/0x134
 [<c0119217>] do_page_fault+0x13f/0x4fb
 [<c01190d8>] do_page_fault+0x0/0x4fb
 [<c0175c13>] proc_file_write+0x27/0x34
 [<c014d67c>] vfs_write+0xa0/0xd0
 [<c014d729>] sys_write+0x31/0x4c
 [<c0104ce7>] syscall_call+0x7/0xb

Adding 1051304k swap on /dev/hda1.  Priority:-1 extents:1

powernowk8_target does preempt_disable(), and that calls
cpufreq_notify_transition(). That does down(). Ouch.

Hmm, but on SMP systems frequency really should be changed with
preempt_disable. How to deal with that?
							Pavel

[Plus I get some more warnings during swsusp, all seem to be
powernow-k8 related...]
-- 
934a471f20d6580d5aad759bf0d97ddc

