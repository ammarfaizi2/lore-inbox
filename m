Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWAEAL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWAEAL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWAEAL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:11:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbWAEAL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:11:28 -0500
Date: Wed, 4 Jan 2006 16:13:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix - ioc3 serial support
Message-Id: <20060104161320.28756e24.akpm@osdl.org>
In-Reply-To: <43BC377E.3050603@sgi.com>
References: <200512162233.jBGMXRUQ139857@fsgi900.americas.sgi.com>
	<43BC377E.3050603@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Gefre <pfg@sgi.com> wrote:
>
> The following patch adds driver support for a 2 port PCI IOC3-based
> serial card on Altix boxes:
> 
> ftp://oss.sgi.com/projects/sn2/sn2-update/044-ioc3-support
>

> +struct ring_entry {
> +	union {
> +		struct {
> +			uint32_t alldata;
> +			uint32_t allsc;
> +		} all;
> +		struct {
> +			char data[4];	/* data bytes */
> +			char sc[4];	/* status/control */
> +		} s;
> +	} u;
> +};
> +
> +/* Test the valid bits in any of the 4 sc chars using "allsc" member */
> +#define RING_ANY_VALID \
> +	((uint32_t)(RXSB_MODEM_VALID | RXSB_DATA_VALID) * 0x01010101)
> +
> +#define ring_sc		u.s.sc
> +#define ring_data	u.s.data
> +#define ring_allsc	u.all.allsc
>

You no longer need to go through this pain - we plan on dropping gcc-2.95
support this cycle, so anonymous unions and anonymous structs can be used
in-kernel.

The above looks a bit dodgy wrt endianness..

> +	writeb((unsigned char)divisor, &uart->iu_dll);
> +	writeb((unsigned char)(divisor >> 8), &uart->iu_dlm);
> +	writeb((unsigned char)prediv, &uart->iu_scr);
> +	writeb((unsigned char)lcr, &uart->iu_lcr);

Are those casts needed?


ioc3uart_intr_one() has two callsites and should not be inlined.  Although
the compiler could conceivably do something sneaky with it.  Needs checking.

nic_read_bit() should be uninlined.

nic_write_bit() should be uninlined.

write_ireg() should be uninlined.


This driver will break when tty-layer-buffering-revamp.patch is merged,
which looks like it'll be 1-2 weeks hence.  A fixup patch against next -mm
would suit..
