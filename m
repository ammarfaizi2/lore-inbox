Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753017AbWKHDyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbWKHDyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 22:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbWKHDyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 22:54:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753017AbWKHDyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 22:54:39 -0500
Date: Tue, 7 Nov 2006 19:54:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: ak@suse.de, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, ashok.raj@intel.com
Subject: Re: [patch 2/4] introduce the mechanism of disabling cpu hotplug
 control
Message-Id: <20061107195430.37f8deb0.akpm@osdl.org>
In-Reply-To: <20061107174024.B5401@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com>
	<20061107173624.A5401@unix-os.sc.intel.com>
	<20061107174024.B5401@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 17:40:25 -0800
"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:

> Add 'cpu_hotplug_no_control' and when set, the hotplug control file("online")
> will not be added under /sys/devices/system/cpu/cpuX/
> 
> Next patch doing PCI quirks will use this.
> 

I don't understand what this (ugly) patch has to do with the overall
bugfix.  We're fixing the APCI initialisation - what does that have to do
with presenting cpu-hotplug files in sysfs?


> ---
> 
> diff --git a/arch/i386/kernel/topology.c b/arch/i386/kernel/topology.c
> index 07d6da3..9b766e7 100644
> --- a/arch/i386/kernel/topology.c
> +++ b/arch/i386/kernel/topology.c
> @@ -40,14 +40,22 @@ int arch_register_cpu(int num)
>  	 * restrictions and assumptions in kernel. This basically
>  	 * doesnt add a control file, one cannot attempt to offline
>  	 * BSP.
> +	 *
> +	 * Also certain PCI quirks require to remove this control file
> +	 * for all CPU's.
>  	 */
> +#ifdef CONFIG_HOTPLUG_CPU
> +	if (!num || cpu_hotplug_no_control)
> +#else
>  	if (!num)
> +#endif

This ifdef could be removed 

>  		cpu_devices[num].cpu.no_control = 1;
>  
>  	return register_cpu(&cpu_devices[num].cpu, num);
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> +int cpu_hotplug_no_control;
>  
>  void arch_unregister_cpu(int num) {
>  	return unregister_cpu(&cpu_devices[num].cpu);
> diff --git a/include/asm-i386/cpu.h b/include/asm-i386/cpu.h
> index b1bc7b1..3c5da33 100644
> --- a/include/asm-i386/cpu.h
> +++ b/include/asm-i386/cpu.h
> @@ -13,6 +13,7 @@ struct i386_cpu {
>  extern int arch_register_cpu(int num);
>  #ifdef CONFIG_HOTPLUG_CPU
>  extern void arch_unregister_cpu(int);
> +extern int cpu_hotplug_no_control;

via:

#else
#define cpu_hotplug_no_control 1

here.


But does this variable _have_ to be a negative like this?  The code would
be simpler if it had the opposite sense and was called, say,
cpu_hotplug_enable_control_file.

Are these patches considered 2.6.19 material?  They look a bit big, ugly
and scary for that.

