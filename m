Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUISUjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUISUjs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUISUjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:39:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26077 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263769AbUISUjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:39:42 -0400
To: hari@in.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org,
       Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [Fastboot] Re: [PATCH][2/6]Memory preserving reboot using kexec
References: <20040915125041.GA15450@in.ibm.com>
	<20040915125145.GB15450@in.ibm.com>
	<20040915125322.GC15450@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2004 14:37:18 -0600
In-Reply-To: <20040915125322.GC15450@in.ibm.com>
Message-ID: <m1d60i8075.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> writes:

> Regards, Hari
> -- 
> Hariprasad Nellitheertha
> Linux Technology Center
> India Software Labs
> IBM India, Bangalore
> 
> 
> 
> This patch contains the code that does the memory preserving reboot. It 
> copies over the first 640k into a backup region before handing over to 
> kexec. The second kernel will boot using only the backup region.

Do you know what the kernel does with the low 1M?

Nothing in the hardware architecture requires us to use the
low 1M.  So I think we would be safer if we could track down
and remove this dependency.

In general I agree that we need to be prepared to save some of the
original machine state, because some architectures give special
meaning to addresses in memory.  But x86 is not one of those.

Perhaps the proper abstraction is to add a use_mem= variable
that simply tells us which memory addresses we can use.

By still doing some copying we run into the problem, of
potentially running out of memory areas where ongoing DMA
transfers may be happening.  So this is worth
tracking down.

> diff -puN /dev/null include/linux/crash_dump.h
> --- /dev/null	2003-01-30 15:54:37.000000000 +0530
> +++ linux-2.6.9-rc1-hari/include/linux/crash_dump.h 2004-09-15
> 17:36:30.000000000 +0530
> 
> @@ -0,0 +1,28 @@
> +#include <linux/kexec.h>
> +#include <linux/smp_lock.h>
> +#include <linux/device.h>
> +#include <asm/crash_dump.h>
> +
> +#ifdef CONFIG_CRASH_DUMP

Why is this function an inline in a header file?
I know we only call it once but still unnecessary code
in a header file seems silly.

> +extern int crash_dump_on;
> +static inline void crash_machine_kexec(void)
> +{
> +	struct kimage *image;
> +
> +	if ((!crash_dump_on) || (crashed))
> +		return;
> +
> +	image = xchg(&kexec_image, 0);

You are still not using a different global variable here.

With a separate kexec_crash_image variable if the image is present
we do a crash dump.  That should allow you to remove the
crash_dump_on variable and the test above.

> +	if (image) {
> +		crashed = 1;
We should not need the magic global variable crashed.  We can
just call the one or two functions needed from crash_machine_kexec.

> +		device_shutdown();
Why are you calling device_shutdown here?
> +		printk(KERN_EMERG "kexec: opening parachute\n");

To wrap things prettily we should probably add a machine_crash_shutdown() 
and place in machine_crash_shutdown whatever architecture specific magic needs
to happen.

> +		machine_kexec(image);
> +		while (1);

The while look is unnecessary machine_kexec cannot
return. 

> +	} else {
> +		printk(KERN_EMERG "kexec: No kernel image loaded!\n");
> +	}
> +}
> +#else
> +#define crash_machine_kexec()	do { } while(0)
> +#endif
