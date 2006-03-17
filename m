Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWCQIq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWCQIq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbWCQIq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:46:58 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:23958 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751509AbWCQIq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:46:56 -0500
Date: Fri, 17 Mar 2006 14:16:53 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       bryce@osdl.org
Subject: Re: [PATCH] Check for online cpus before bringing them up
Message-ID: <20060317084653.GA4515@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316170814.02fa55a1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 05:08:14PM -0800, Andrew Morton wrote:
> Is x86 the only architecture which is exposed to this?

Currently only x86 implements smp_prepare_cpu(). On other arch, it is a
no-op. Hence yes, only x86 is exposed to this bug.

> >  
> >  	lock_cpu_hotplug();
> > +
> > +	if (cpu_online(cpu)) {
> > +		ret = -EINVAL;
> > +		goto exit;
> > +	}
> > +
> >  	apicid = x86_cpu_to_apicid[cpu];
> >  	if (apicid == BAD_APICID) {
> >  		ret = -ENODEV;
> 
> a) It's hard for the reader to understand what that test is doing there
> 
> b) People copy code from x86, so other architectures which are not
>    exposed to this problem will end up having a pointless test in there.

Well ..other arch-es need to have a similar check if they get around to
implement physical hot-add (even if they allow offlining of all CPUs). This is 
required since a user can (by mistake maybe) try to bring up an already online 
CPU by writing a '1' to it's sysfs 'online' file. 'store_online' 
(drivers/base/cpu.c) unconditionally calls 'smp_prepare_cpu' w/o checking for 
this error condition. The check added in the patch catches such error 
conditions as well.

> IOW: please comment your code.   I'll fix this one up.

Sorry about not commenting my code earlier! How does the patch below look?


Add check for online cpus.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>


 arch/i386/kernel/smpboot.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff -puN arch/i386/kernel/smpboot.c~cpu_hp arch/i386/kernel/smpboot.c
--- linux-2.6.16-rc6/arch/i386/kernel/smpboot.c~cpu_hp	2006-03-17 14:27:15.000000000 +0530
+++ linux-2.6.16-rc6-root/arch/i386/kernel/smpboot.c	2006-03-17 14:38:50.000000000 +0530
@@ -1029,6 +1029,16 @@ int __devinit smp_prepare_cpu(int cpu)
 	int	apicid, ret;
 
 	lock_cpu_hotplug();
+
+	/* Check if CPU is already online. This can happen if user tries to 
+	 * bringup an already online CPU or a previous offline attempt
+	 * on this CPU has failed.
+	 */
+	if (cpu_online(cpu)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	apicid = x86_cpu_to_apicid[cpu];
 	if (apicid == BAD_APICID) {
 		ret = -ENODEV;

_

-- 
Regards,
vatsa
