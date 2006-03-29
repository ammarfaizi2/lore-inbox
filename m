Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWC2Wp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWC2Wp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWC2Wp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:45:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbWC2Wp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:45:27 -0500
Date: Wed, 29 Mar 2006 14:47:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-Id: <20060329144746.358a6b4e.akpm@osdl.org>
In-Reply-To: <20060329220808.GA1716@elf.ucw.cz>
References: <20060329220808.GA1716@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> HOTPLUG_CPU is needed on normal PCs, too -- it is neccessary for
> software suspend.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> ---
> commit 2206dab43d50723d6b15caa8821e8d97c6b5ef28
> tree cbfc324e15d216aa91ce6a51927668076de5b7db
> parent dd76aabd03933b80c61fa5b0c0c995950246c603
> author <pavel@amd.ucw.cz> Thu, 30 Mar 2006 00:06:31 +0200
> committer <pavel@amd.ucw.cz> Thu, 30 Mar 2006 00:06:31 +0200
> 
>  arch/i386/Kconfig      |    8 ++++----
>  kernel/power/process.c |    3 +--
>  kernel/signal.c        |    1 +
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
> index f7db71d..955dc08 100644
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -741,12 +741,12 @@ config PHYSICAL_START
>  
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> -	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && !X86_PC
> +	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
>  	---help---
> -	  Say Y here to experiment with turning CPUs off and on.  CPUs
> -	  can be controlled through /sys/devices/system/cpu.
> +	  Say Y here to experiment with turning CPUs off and on, and to 
> +	  enable suspend on SMP systems. CPUs can be controlled through
> +	  /sys/devices/system/cpu.
>  
> -	  Say N.
>  

OK, this will get ugly.  APICs are involved.

That patch simply undoes this one:

> [PATCH] x86: make CONFIG_HOTPLUG_CPU depend on !X86_PC
> 
> Make CONFIG_HOTPLUG_CPU depend on !X86_PC, so we need to turn on either
> CONFIG_GENERICARCH, CONFIG_BIGSMP or any other subarch except X86_PC when
> CONFIG_HOTPLUG_CPU=y
> 
> With 2.6.15+ kernels when CONFIG_HOTPLUG_CPU is turned on we switch to
> bigsmp mode for sending IPI's and ioapic configurations that caused the
> following error message.
> 
> >> More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
> >> Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.
> 
> Originally bigsmp was added just to handle >8 cpus, but now with hotplug
> cpu support we need to use bigsmp mode (why?  see below), that cause the
> above error message even if there were less than 8 cpus in the system.
> 
> The message is bogus, but we are cannot use logical flat mode due to issues
> with broadcast IPI can confuse a CPU just comming up.  We use flat physical
> mode just like x86_64 case.  More details on why bigsmp now uses flat
> physical mode (vs.  cluster mode) in following link.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2
> 

Which I was distinctly uncomfortable with.  (And glad I nixed it for 2.6.16 ;))

Ashok, we need to do something better, but what? 
