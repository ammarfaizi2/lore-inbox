Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUFUMEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUFUMEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 08:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUFUMEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 08:04:22 -0400
Received: from amazonas-2333.adsl.datanet.hu ([195.56.231.47]:32288 "HELO gw")
	by vger.kernel.org with SMTP id S266199AbUFUMET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 08:04:19 -0400
Date: Mon, 21 Jun 2004 14:04:16 +0200
From: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: 2.6.7 shows K7 with Pentium Pro erratum [Re: New version of early CPU detect]
Message-ID: <20040621120416.GA2722@noc.xeon.eu.org>
Mail-Followup-To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
	Andi Kleen <ak@suse.de>, akpm@osdl.org, manfred@colorfullife.com,
	linux-kernel@vger.kernel.org
References: <20040423043001.4bb05d5f.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423043001.4bb05d5f.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-04-23 at 04:30:01, Andi Kleen wrote:
> We still need some kind of early CPU detection, e.g. for the AMD768 workaround

This is an old post with a patch which seems to be responsible for what
I am seeing on an aging machine:

>> Pentium Pro with Errata#50 detected. Taking evasive action.
>> Memory: 255808k/262144k available (2445k kernel code, 5600k reserved, 667k data, 148k init, 0k highmem)
>> Checking if this processor honours the WP bit even in supervisor mode...  Ok.
>> Calibrating delay loop... 1077.24 BogoMIPS
...
>> CPU:     After generic identify, caps: 0081f9ff c0c1f9ff 00000000 00000000
>> CPU:     After vendor identify, caps: 0081f9ff c0c1f9ff 00000000 00000000
>> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
>> CPU: L2 Cache: 512K (64 bytes/line)
>> CPU:     After all inits, caps: 0081f9ff c0c1f9ff 00000000 00000020
>> Intel machine check architecture supported.
>> Intel machine check reporting enabled on CPU#0.
>> CPU: AMD-K7(tm) Processor stepping 02

So, it's a K7-550 with a Pentium Pro erratum... I'm not quite sure it's
right :)

As it is, the family/model numbers seems to match, but it's obviously an
AMD product..

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 551.261
cache size      : 512 KB
...
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 1077.24

The parts of the patch to point to this misdetection:

> +++ linux-2.6.5-i386/arch/i386/kernel/cpu/common.c	2004-04-21 17:05:06.000000000 +0200
...
>  void __init early_cpu_init(void)
>  {
> +	early_cpu_detect();
>  	intel_cpu_init();
>  	cyrix_init_cpu();

> +++ linux-2.6.5-i386/arch/i386/kernel/cpu/intel.c	2004-04-21 17:06:00.000000000 +0200
...
> +	/* Uses data from early_cpu_detect now */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> +	    boot_cpu_data.x86 == 6 &&
> +	    boot_cpu_data.x86_model == 1 && 
> +	    boot_cpu_data.x86_mask < 8) { 
>  		printk(KERN_INFO "Pentium Pro with Errata#50 detected. Taking evasive action.\n");
>  		return 1;

-- 
Janos | romfs is at http://romfs.sourceforge.net/ | Don't talk about silence.
