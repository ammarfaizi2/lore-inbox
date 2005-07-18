Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVGRLoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVGRLoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVGRLoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:44:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57052 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261681AbVGRLm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:42:27 -0400
Date: Mon, 18 Jul 2005 13:42:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH - 1/12] NTP cleanup: Move NTP code into ntp.c
Message-ID: <20050718114226.GC1869@elf.ucw.cz>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com> <1121482620.25236.31.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121482620.25236.31.camel@cog.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	This patch moves the generic NTP code from time.c and timer.c into
> ntp.c. It makes most of the NTP variables static providing more
> understandable interfaces like ntp_synced() and ntp_clear(). 
> 	
> Since some of the newly made static variables are used in arch generic
> code, this patch alone will not compile. Thus this patch requires part 2
> of the series which fixes the arch specific uses of the newly static
> variables.
> 
> Any comments or feedback would be greatly appreciated.
> 
> thanks
> -john
> 

> diff --git a/kernel/ntp.c b/kernel/ntp.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/ntp.c
> @@ -0,0 +1,490 @@
> +/********************************************************************
> +* linux/kernel/ntp.c
> +*
> +* NTP state machine and time scaling code.
> +*
> +* Code moved from kernel/time.c and kernel/timer.c
> +* Please see those files for original copyrights.
> +*
> +* This program is free software; you can redistribute it and/or modify
> +* it under the terms of the GNU General Public License as published by
> +* the Free Software Foundation; either version 2 of the License, or
> +* (at your option) any later version.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*
> +* You should have received a copy of the GNU General Public License
> +* along with this program; if not, write to the Free Software
> +* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +*
> +* Notes:
> +*
> +* Hopefully you should never have to understand or touch
> +* any of the code below. but don't let that keep you from trying!
                         ~~~ should be "," ?

> +* This code is loosely based on David Mills' RFC 1589 and its
> +* updates. Please see the following for more details:
> +*  http://www.eecis.udel.edu/~mills/database/rfc/rfc1589.txt
> +*  http://www.eecis.udel.edu/~mills/database/reports/kern/kernb.pdf
> +*
> +* NOTE:	To simplify the code, we do not implement any of
> +* the PPS code, as the code that uses it never was merged.
> +*                             -johnstul@us.ibm.com
> +*
> +*********************************************************************/
> +
> +#include <linux/ntp.h>
> +#include <linux/jiffies.h>
> +#include <linux/errno.h>
> +
> +#ifdef CONFIG_TIME_INTERPOLATION
> +void time_interpolator_update(long delta_nsec);
> +#else
> +#define time_interpolator_update(x)

do {} while (0) is safer...

> +	result = time_state;       /* mostly `TIME_OK' */
> +
> +	/* Save for later - semantics of adjtime is to return old value */
> +	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
> +
> +#if 0	/* STA_CLOCKERR is never set yet */
> +	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
> +#endif

Please remove deleted code completely.

> +/**
> + * ntp_synced - Returns 1 if the NTP status is not UNSYNC
> + *
> + */
> +int ntp_synced(void)
> +{
> +	return !(time_status & STA_UNSYNC);
> +}

Should this be inline in header somewhere?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
