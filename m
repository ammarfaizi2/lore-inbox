Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbTAUIC4>; Tue, 21 Jan 2003 03:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbTAUIC4>; Tue, 21 Jan 2003 03:02:56 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:7429 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266514AbTAUICz>; Tue, 21 Jan 2003 03:02:55 -0500
Date: Tue, 21 Jan 2003 08:11:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121081158.A21080@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joel Becker <Joel.Becker@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Wim Coekaerts <Wim.Coekaerts@oracle.com>
References: <20030121011954.GO20972@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030121011954.GO20972@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Mon, Jan 20, 2003 at 05:19:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/module.h>
> +#include <linux/config.h>

I can't your see the driver reference CONFIG_* directly anywhere.

> +#define VERSION_STR "0.5.0"
> +
> +static void version_hash_print (void)
> +{
> +	printk(KERN_INFO "I/O fencing modules %s\n", VERSION_STR);
> +}

This message is a bit misleading, isn't it?

> +static int hangcheck_tick = DEFAULT_IOFENCE_TICK;
> +static int hangcheck_margin = DEFAULT_IOFENCE_MARGIN;
> +static int hangcheck_reboot = 0;  /* Do not reboot */

no need to initialize static variables to zero, they'll just go into .bss.

> +/* options - modular */
> +MODULE_PARM(hangcheck_tick,"i");
> +MODULE_PARM_DESC(hangcheck_tick, "Timer delay.");
> +MODULE_PARM(hangcheck_margin,"i");
> +MODULE_PARM_DESC(hangcheck_margin, "If the hangcheck timer has been delayed more than hangcheck_margin seconds, the driver will fire.");
> +MODULE_PARM(hangcheck_reboot,"i");
> +MODULE_PARM_DESC(hangcheck_reboot, "If nonzero, the machine will reboot when the timer margin is exceeded.");

It might be worth using Rusty's new module paramters for new code submitted
to 2.5 instead of the legacy interfaces.

> +#if 0
> +	printk(KERN_CRIT "tsc_diff = %lu.%lu, predicted diff is %lu.%lu.\n",
> +	       (unsigned long) ((tsc_diff >> 32) & 0xFFFFFFFFULL),
> +	       (unsigned long) (tsc_diff & 0xFFFFFFFFULL),
> +	       (unsigned long) ((hangcheck_tsc_margin >> 32) & 0xFFFFFFFFULL),
> +	       (unsigned long) (hangcheck_tsc_margin & 0xFFFFFFFFULL));
> +	printk(KERN_CRIT "hangcheck_margin = %lu, HZ = %lu, current_cpu_data.loops_per_jiffy = %lu.\n", hangcheck_margin, HZ, current_cpu_data.loops_per_jiffy);
> +#endif

#if DEBUG maybe? or VERBOSE?

> +static int __init hangcheck_init(void)
> +{
> +        version_hash_print();
> +	printk("Hangcheck: starting hangcheck timer (tick is %d seconds, margin is %d seconds).\n",
> +	       hangcheck_tick, hangcheck_margin);

Two startup messages seems like a bit too much.

> +}  /* hangcheck_init() */

Bah 8)

> +static void __exit hangcheck_exit(void)
> +{
> +	printk("Stopping hangcheck timer.\n");

Again, this is exteremly verbose.

> +	lock_kernel();
> +	del_timer(&hangcheck_ticktock);
> +	unlock_kernel();

No need for BKL here, but you might want to use del_timer_sync.

