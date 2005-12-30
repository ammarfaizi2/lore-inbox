Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVL3Rzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVL3Rzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 12:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVL3Rzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 12:55:47 -0500
Received: from cluster1.g-wis.com ([204.250.154.18]:37138 "EHLO
	cluster1.g-wis.com") by vger.kernel.org with ESMTP id S1750879AbVL3Rzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 12:55:46 -0500
Thread-Index: AcYNakG4BB2/iNeiRZ6X1a0RBvBCHQ==
X-Received-From-Address: 66.220.104.32
X-Envelope-From: greg@kroah.com
Date: Fri, 30 Dec 2005 00:25:05 -0800
Content-Transfer-Encoding: 7bit
From: "Greg KH" <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: <linux-kernel@vger.kernel.org>, <openib-general@openib.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Content-Class: urn:content-classes:message
Importance: normal
Subject: Re: [PATCH 12 of 20] ipath - misc driver support code
Message-ID: <20051230082505.GC7438@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com> <5e9b0b7876e2d570f25e.1135816291@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e9b0b7876e2d570f25e.1135816291@eng-12.pathscale.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Dec 2005 17:55:44.0036 (UTC) FILETIME=[41540E40:01C60D6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 04:31:31PM -0800, Bryan O'Sullivan wrote:
> Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

No description of what the patch does?

> +struct _infinipath_do_not_use_kernel_regs {
> +	unsigned long long Revision;

u64?

> +	unsigned long long Control;
> +	unsigned long long PageAlign;
> +	unsigned long long PortCnt;

And what's with the InterCapsNamingScheme of these variables?

> +/*
> + * would prefer to not inline this, to avoid code bloat, and simplify debugging
> + * But when compiling against 2.6.10 kernel tree, it gets an error, so
> + * not for now.
> + */
> +static void ipath_i2c_delay(ipath_type, int);

You aren't compiling this for a 2.6.10 kernel anymore :)

> +/*
> + * we use this instead of udelay directly, so we can make sure
> + * that previous register writes have been flushed all the way
> + * to the chip.  Since we are delaying anyway, the cost doesn't
> + * hurt, and makes the bit twiddling more regular
> + * If delay is negative, we'll do the chip read, to be sure write made it
> + * to our chip, but won't do udelay()
> + */
> +static void ipath_i2c_delay(ipath_type dev, int dtime)
> +{
> +	/*
> +	 * This needs to be volatile, so that the compiler doesn't
> +	 * optimize away the read to the device's mapped memory.
> +	 */
> +	volatile uint32_t read_val;
> +	if (!dtime)
> +		return;
> +	read_val = ipath_kget_kreg32(dev, kr_scratch);
> +	if (--dtime > 0)	/* register read takes about .5 usec, itself */
> +		udelay(dtime);
> +}

Huh?  After reading your comment, I still don't understand why you can't
just use udelay().  Or are you counting on calling this function with
only "1" being set for dtime?

Ah, in looking at your code, that is exactly what is happening.  That's
a mess, just delay and everything will work properly on the next rev of
the hardware where the time to read that register will have dropped to
1/8 the time it does today...

> +/*
> + * write a byte, one bit at a time.  Returns 0 if we got the following
> + * ack, otherwise 1
> + */
> +static int ipath_wr_byte(ipath_type dev, uint8_t data)
> +{
> +	int bit_cntr;
> +	uint8_t bit;
> +
> +	for (bit_cntr = 7; bit_cntr >= 0; bit_cntr--) {
> +		bit = (data >> bit_cntr) & 1;
> +		ipath_sda_out(dev, bit, 1);
> +		ipath_scl_out(dev, i2c_line_high, 1);
> +		ipath_scl_out(dev, i2c_line_low, 1);
> +	}
> +	if (!ipath_i2c_ackrcv(dev))
> +		return 1;
> +	return 0;
> +}

Ah, isn't it fun to write bit-banging functions...  And the in-kernel
i2c code is messier than doing this by hand?

> +/*
> + *      ipath_eeprom_read - Receives x # byte from the eeprom via I2C.
> + *
> + *  eeprom: Atmel AT24C01
> + *
> + */
> +
> +int ipath_eeprom_read(ipath_type dev, uint8_t eeprom_offset, void *buffer,
> +		      int len)

Odd function comment style.  Please fix this to be in kerneldoc format.

> diff -r e8af3873b0d9 -r 5e9b0b7876e2 drivers/infiniband/hw/ipath/ipath_lib.c
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/drivers/infiniband/hw/ipath/ipath_lib.c	Wed Dec 28 14:19:43 2005 -0800
> @@ -0,0 +1,90 @@
> +/*
> + * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + * Patent licenses, if any, provided herein do not apply to
> + * combinations of this program with other software, or any other
> + * product whatsoever.
> + */
> +
> +/*
> + * This is library code for the driver, similar to what's in libinfinipath for
> + * usermode code.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/version.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <linux/timer.h>
> +#include <linux/fs.h>
> +#include <linux/poll.h>
> +#include <asm/io.h>
> +#include <asm/byteorder.h>
> +#include <asm/uaccess.h>

Are you _sure_ you need all of these for the one function in this file?

> +
> +#include "ipath_kernel.h"
> +
> +unsigned infinipath_debug = __IPATH_INFO;
> +
> +uint32_t _ipath_pico_per_cycle;	/* always present, for now */
> +
> +/*
> + * This isn't perfect, but it's close enough for timing work. We want this
> + * to work on systems where the cycle counter isn't the same as the clock
> + * frequency.  The one msec spin is OK, since we execute this only once
> + * when first loaded.  We don't use CURRENT_TIME because on some systems
> + * it only has jiffy resolution; we just assume udelay is well calibrated
> + * and that we aren't likely to be rescheduled.  Do it multiple times,
> + * with a yield in between, to try to make sure we get the "true minimum"
> + * value.
> + * _ipath_pico_per_cycle isn't going to lead to completely accurate
> + * conversions from timestamps to nanoseconds, but it's close enough
> + * for our purposes, which is mainly to allow people to show events with
> + * nsecs or usecs if desired, rather than cycles.
> + */
> +void ipath_init_picotime(void)
> +{
> +	int i;
> +	u_int64_t ts, te, delta = -1ULL;
> +
> +	for (i = 0; i < 5; i++) {
> +		ts = get_cycles();
> +		udelay(250);
> +		te = get_cycles();
> +		if ((te - ts) < delta)
> +			delta = te - ts;
> +		yield();
> +	}
> +	_ipath_pico_per_cycle = 250000000 / delta;
> +}

Ick.  A whole file for one function and 2 public variables?  And a
horrible timing function too?  Please just use the core kernel timing
functions, which will work all the time on all arches...


> diff -r e8af3873b0d9 -r 5e9b0b7876e2 drivers/infiniband/hw/ipath/ipath_upages.c
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/drivers/infiniband/hw/ipath/ipath_upages.c	Wed Dec 28 14:19:43 2005 -0800
> @@ -0,0 +1,144 @@
> +/*
> + * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + * Patent licenses, if any, provided herein do not apply to
> + * combinations of this program with other software, or any other
> + * product whatsoever.
> + */
> +
> +#include <stddef.h>

Where is this file being pulled in from?

> +
> +#include <linux/config.h>
> +#include <linux/version.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/mm.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/page.h>
> +#include <asm/io.h>
> +
> +#include "ipath_kernel.h"
> +
> +/*
> + * Our version of the kernel mlock function.  This function is no longer
> + * exposed, so we need to do it ourselves.

Woah, um, don't you think that you should either export the main mlock
function itself, or fix your code to not need it?  Rolling it yourself
isn't a good idea...

thanks,

greg k-h
