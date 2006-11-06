Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752324AbWKFTFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbWKFTFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 14:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbWKFTFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 14:05:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752324AbWKFTFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 14:05:21 -0500
Date: Mon, 6 Nov 2006 11:01:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, shaohua.li@intel.com, bunk@stusta.de
Subject: Re: [patch] Regression in 2.6.19-rc microcode driver
Message-Id: <20061106110152.63ef91bc.akpm@osdl.org>
In-Reply-To: <1162822538.3138.28.camel@laptopd505.fenrus.org>
References: <1162822538.3138.28.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2006 15:15:38 +0100
Arjan van de Ven <arjan@linux.intel.com> wrote:

> Hi,
> 
> if the microcode driver is built in (rather than module) there are some,
> ehm, interesting effects happening due to the new "call out to
> userspace" behavior that is introduced.. and which runs too early. The
> result is a boot hang; which is really nasty.
> 
> The patch below is a minimally safe patch to fix this regression for
> 2.6.19 by just not requesting actual microcode updates during early
> boot. (That is a good idea in general anyway)
> 
> The "real" fix is a lot more complex given the entire cpu hotplug
> scenario (during cpu hotplug you normally need to load the microcode as
> well); but the interactions for that are just really messy at this
> point; this fix at least makes it work and avoids a full detangle of
> hotplug.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> --- linux-2.6.18/arch/i386/kernel/microcode.c.org	2006-11-06 14:50:37.000000000 +0100
> +++ linux-2.6.18/arch/i386/kernel/microcode.c	2006-11-06 14:52:30.000000000 +0100
> @@ -577,7 +577,7 @@ static void microcode_init_cpu(int cpu)
>  	set_cpus_allowed(current, cpumask_of_cpu(cpu));
>  	mutex_lock(&microcode_mutex);
>  	collect_cpu_info(cpu);
> -	if (uci->valid)
> +	if (uci->valid && system_state==SYSTEM_RUNNING)
>  		cpu_request_microcode(cpu);
>  	mutex_unlock(&microcode_mutex);
>  	set_cpus_allowed(current, old);

Can we fix this by switching to late_initcall() or something like that?
