Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWAXQQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWAXQQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 11:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWAXQQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 11:16:16 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43655 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964996AbWAXQQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 11:16:16 -0500
Message-ID: <43D652CC.4000505@renninger.de>
Date: Tue, 24 Jan 2006 17:16:12 +0100
From: Thomas Renninger <mail@renninger.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cpufreq@lists.linux.org.uk, cpufreq@www.linux.org.uk
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Dominik Brodowski <linux@brodo.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] _PPC frequency change issues - freq already lowered by
 BIOS
Content-Type: multipart/mixed;
 boundary="------------080509060706010509050207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509060706010509050207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Dell600/800 machines:

When unplugging the AC adapter on these machines
following happens in BIOS:

- ACPI processor event fired, frequencies get limited
  to the lowest one(600 MHz) and BIOS already sets lowest freq.
- when waiting about 10 seconds another ACPI processor  event
  is fired, and all frequencies are available again,
  highest freq(1700 MHz) is set.
- when plugging in ac adapter before waiting 10 seconds
  ACPI processor event is happening immediately and all
  frequencies are available again, highest freq(1700 MHz) is set.


I found these bugs in kernel:

- speedstep centrino driver does not recognise that BIOS
 changed the frequency behind it's back.
 It tells you that 600 MHz are already set, and does not invoke
 PRE/POST transition validation.  On next frequency settings,
 the frequency is "out_of_sync" and
 the validater assumes 600 MHz and the frequency stays there.
 
 Patch [1/2]
 
- userspace governor is using its own cpufreq_policy struct and
 forgets to set max_frequency there in  cpufreq_governor_userspace(CPUFREQ_GOV_LIMITS)
 That results in scaling_setspeed staying high in sysfs even the
 frequency has been lowered on _PPC change.
 When _PPC allows all frequencies again, the userspace governor
 uses it's own policy_struct with the old max value again (now the
 low one) and the frequency still stays at lowest frequency.
 Also the userspace governor need not to hold it's own cpufreq_policy,
 better make use of the global core policy, save some memory and
 avoid to forget any struct member to be copied.

 Patch [2/2]

I tested with ondemand and userspace governor on a speedstep-centrino
system, both governors had problems with but should work fine now,
whether _PPC (or whatever ACPI function) prechanges the freq or not.
The first patch fixes the ondemand governor working properly again,
the second is also needed to make the userspace governor working on these
machines.

Could someone please review and apply.

      Thomas

--------------080509060706010509050207
Content-Type: text/plain;
 name="cpufreq_bios_ppc_change"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpufreq_bios_ppc_change"

Author: Thomas Renninger <trenn@suse.de>

BIOS might change frequency behind our back
when BIOS changes allowed frequencies via _PPC.
in this case cpufreq core got out of sync.
-> ask driver for current freq and notify
  governors about a change

cpufreq.c |   10 ++++++++++
1 files changed, 10 insertions(+)

Index: linux-2.6.15/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.15.orig/drivers/cpufreq/cpufreq.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/cpufreq/cpufreq.c	2006-01-20 11:11:55.000000000 +0100
@@ -1402,6 +1402,16 @@
 	policy.policy = data->user_policy.policy;
 	policy.governor = data->user_policy.governor;
 
+    /* BIOS might change freq behind our back 
+       -> ask driver for current freq and notify
+          governors about a change
+    */
+    if (cpufreq_driver->get){
+        policy.cur = cpufreq_driver->get(cpu);
+        if (data->cur != policy.cur)
+            cpufreq_out_of_sync(cpu, data->cur, policy.cur);
+    }
+
 	ret = __cpufreq_set_policy(data, &policy);
 
 	up(&data->lock);

--------------080509060706010509050207--
