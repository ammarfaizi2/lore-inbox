Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTFKUcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTFKUaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:30:07 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:27326 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264455AbTFKU3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:29:38 -0400
Date: Wed, 11 Jun 2003 22:41:44 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: ak@suse.de, vojtech@suse.cz, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
Message-ID: <20030611224144.A8538@ucw.cz>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>; from bos@serpentine.com on Wed, Jun 11, 2003 at 11:50:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 11:50:32AM -0700, Bryan O'Sullivan wrote:

> The time code for x86-64 in 2.5.70 isout of date and wildly unstable,
> setting the clock to the year 1,115,117 (!) during boot about 60% of the
> time.  This subsequently causes other pieces of completely unrelated
> userspace software to crash randomly for no obvious reason once the
> system comes up.
> 
> I've forward-ported Vojtech's time code from 2.4, fixing some locking
> along the way.  The new code supports using the AMD8111 HPET for time
> calculations.  It also works stably with the PIT/TSC on every boot,
> which is the source of the time problems in current 2.5.

Thanks a lot for your work! 

> Right now, the only known problem is with the fixup of jiffies if a
> timer interrupt is lost, which I've hence turned off.  There's
> preliminary support for using HPET for the gettimeofday vsyscall, but
> since vsyscalls are disabled on x86-64 for now, that's obviously
> untested.

This is interesting. I'll have to test why the number of lost tick is
computed incorrectly ....

> --- linux-2.5/arch/x86_64/Kconfig	2003-06-11 11:43:09.000000000 -0700
> +++ x86-64-2.5/arch/x86_64/Kconfig	2003-06-11 10:39:45.000000000 -0700
> @@ -52,6 +52,18 @@
>  	  klogd/syslogd or the X server. You should normally N here, unless
>  	  you want to debug such a crash.
>  	  
> +config HPET_TIMER
> +	bool
> +	default n
> +	help
> +	  Use the IA-PC HPET (High Precision Event Timer) to manage
> +	  time in preference to the PIT and RTC, if a HPET is
> +	  present.  The HPET provides a stable time base on SMP
> +	  systems, unlike the RTC, but it is more expensive to access,

... probably that should be 'unlike the TSC'? Since RTC does provide a
stable time base on a SMP system, and is very far off chip, too.

> +	  as it is off-chip.  You can find the HPET spec at
> +	  <http://www.intel.com/labs/platcomp/hpet/hpetspec.htm>.
> +
> +	  If unsure, say Y.
>  
>  config GENERIC_ISA_DMA
>  	bool
>

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
