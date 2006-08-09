Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWHICpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWHICpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWHICp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:38095 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030431AbWHICpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:45:22 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH 6/6] x86_64: GENERIC_TIME based vsyscall code
Date: Wed, 9 Aug 2006 04:45:16 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com> <20060809021746.23103.1842.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021746.23103.1842.sendpatchset@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090445.16413.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 04:17, john stultz wrote:

> +	cycle_t ret;
> +	rdtscll(ret);


_sync


> +static cycle_t __vsyscall_fn vread_hpet(void)
> +{
> +	return (cycle_t)readl((void *)fix_to_virt(VSYSCALL_HPET) + 0xf0);
> +}

64bit HPET?


> +extern struct vsyscall_gtod_data_t vsyscall_gtod_data;

No extern in .c please
  

> +static __always_inline int syscall_gtod(struct timeval *tv, struct timezone *tz)
> +{
> +	int ret;
> +
> +	asm volatile("syscall"

You eliminated the patching away of the syscall opcode? Please retain that.



> -	tv->tv_sec = sec + usec / 1000000;
> -	tv->tv_usec = usec % 1000000;
> +		now = __vsyscall_gtod_data.clock.vread();
> +
> +		base = __vsyscall_gtod_data.clock.cycle_last;
> +		mask = __vsyscall_gtod_data.clock.mask;
> +		mult = __vsyscall_gtod_data.clock.mult;
> +		shift = __vsyscall_gtod_data.clock.shift;
> +
> +		*tv = __vsyscall_gtod_data.wall_time_tv;
> +
> +	} while (read_seqretry(&__vsyscall_gtod_data.lock, seq));

Do you have benchmarks on performance compared to the old code?

-Andi
