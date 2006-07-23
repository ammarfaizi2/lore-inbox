Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWGWSTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWGWSTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 14:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWGWSTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 14:19:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751143AbWGWSTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 14:19:18 -0400
Date: Sun, 23 Jul 2006 11:12:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       davej@redhat.com, Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
In-Reply-To: <Pine.LNX.4.64.0607230955130.29649@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607231107510.29649@g5.osdl.org>
References: <20060722194018.GA28924@redhat.com>  <Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
  <20060722180602.ac0d36f5.akpm@osdl.org>  <Pine.LNX.4.64.0607221813020.29649@g5.osdl.org>
 <1153627754.7359.17.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607230955130.29649@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Jul 2006, Linus Torvalds wrote:
> 
> Does this work? Hey, it works for me once. It's pretty simple, and had 
> better not have any recursion issues.

GAAH!!

What kind of _crap_ is this cpufreq thing?

Lookie here:

	S06cpuspeed   D DD94A324  2180 10241  10215                     (NOTLB)
	Call Trace:
	 [<c03c411d>] __mutex_lock_slowpath+0x4d/0x7b
	 [<c03c415a>] .text.lock.mutex+0xf/0x14
	 [<c0137651>] lock_cpu_hotplug+0xd/0xf
	 [<c012f9df>] __create_workqueue+0x52/0x11f
	 [<df0cd336>] cpufreq_governor_dbs+0x9e/0x2c5 [cpufreq_ondemand]
	 [<c0305d2a>] __cpufreq_governor+0x57/0xd8
	 [<c0305ee8>] __cpufreq_set_policy+0x13d/0x1a9
	 [<c03060e4>] store_scaling_governor+0x12d/0x155
	 [<c03057a5>] store+0x34/0x45
	 [<c0199a6c>] sysfs_write_file+0x99/0xbf
	 [<c0164ac3>] vfs_write+0xab/0x157
	 [<c01650fc>] sys_write+0x3b/0x60
	 [<c0102d41>] sysenter_past_esp+0x56/0x79

where it takes the cpu_hotplug lock in "store_scaling_governor()", and 
then calls __cpufreq_set_policy(), and then that ondemand thing WILL TAKE 
IT AGAIN!

What a piece of crap. Why, why, why?

[ Linus bangs his head against the wall until tears of blood course down 
  his face ]

I will here-by re-introduce the recursion thing for lock_cpu_hotplug, but 
I will make it say some very rude things about idiots who create code like 
this. 

cpufreq (or at least ondemand) must DIE! And the people who wrote that 
crap should have red-hot pokers jammed into some very uncomfortable 
places.

		Linus
