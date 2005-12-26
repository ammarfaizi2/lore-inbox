Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVLZHi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVLZHi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 02:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVLZHi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 02:38:26 -0500
Received: from fmr18.intel.com ([134.134.136.17]:58588 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751036AbVLZHiZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 02:38:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH v2:3/3]Export cpu topology by sysfs
Date: Mon, 26 Dec 2005 15:38:16 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84044DE5EA@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2:3/3]Export cpu topology by sysfs
Thread-Index: AcYH9awnpJC2ZoENSOWiFkMtUgBacgB9RjbA
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Yanmin Zhang" <ymzhang@unix-os.sc.intel.com>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>,
       <linux-ia64@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 26 Dec 2005 07:38:19.0093 (UTC) FILETIME=[572B5850:01C609EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Greg KH [mailto:greg@kroah.com]
>>Sent: 2005Äê12ÔÂ24ÈÕ 3:16
>>To: Zhang, Yanmin
>>Cc: Yanmin Zhang; linux-kernel@vger.kernel.org; discuss@x86-64.org; linux-ia64@vger.kernel.org; Siddha, Suresh B; Shah, Rajesh;
>>Pallipadi, Venkatesh
>>Subject: Re: [PATCH v2:3/3]Export cpu topology by sysfs
>>
>>On Fri, Dec 23, 2005 at 12:03:27PM +0800, Zhang, Yanmin wrote:
>>> >>Can't you just use an attribute group and attach it to the cpu kobject?
>>> >>That would save an array of kobjects I think.
>>> As you know, current i386/x86_64 arch also export cache info under
>>> /sys/device/system/cpu/cpuX/cache. Is it clearer to export topology
>>> under a new directory than under cpu directly?
>>
>>No, the place in the sysfs tree you are putting this is just fine.  I'm
>>just saying that you do not need to create a new kobject for these
>>attributes.  Just use an attribute group, and you will get the same
>>naming, without the need for an extra kobject (and the whole array of
>>kobjects) at all.
>>
>>Does that make more sense?
Yes, indeed. Now, I used your idea and the patch became simpler. Thanks.


>>
>>> >>> +static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
>>> >>> +		unsigned long action, void *hcpu)
>>> >>> +{
>>> >>> +	unsigned int cpu = (unsigned long)hcpu;
>>> >>> +	struct sys_device *sys_dev;
>>> >>> +
>>> >>> +	sys_dev = get_cpu_sysdev(cpu);
>>> >>> +	switch (action) {
>>> >>> +		case CPU_ONLINE:
>>> >>> +			topology_add_dev(sys_dev);
>>> >>> +			break;
>>> >>> +#ifdef	CONFIG_HOTPLUG_CPU
>>> >>> +		case CPU_DEAD:
>>> >>> +			topology_remove_dev(sys_dev);
>>> >>> +			break;
>>> >>> +#endif
>>> >>
>>> >>Why ifdef?  Isn't it safe to just always have this in?
>>> If no ifdef here, gcc reported a compiling warning when I compiled it
>>> on IA64 with CONFIG_HOTPLUG_CPU=n.
>>
>>Then you should probably go change it so that CPU_DEAD is defined on
>>non-smp builds, otherwise the code gets quite messy like the above :)

Sorry. My previous explanation is confusing. It's a link warning on ia64. On ia64, the kernel vmlinux doesn't include section .exit.text, so ld will report a link warning when a function is in section .exit.text and another function (not in .exit.text) calls the first one. When CONFIG_HOTPLUG_CPU=n, function topology_remove_dev is in section .exit.text, but its caller topology_remove_dev is not in .exit.text.

i386 and x86_64 kernel vmlinux does include .exit.text and discard it only when running, so there is no such warning on i386/x86_64.

There is no other better approach to get rid of the warning unless we change arch/ia64/kernel/vmlinux.lds.S to keep all .exit.text in kernel image.

