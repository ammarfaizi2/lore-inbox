Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269215AbUINI4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269215AbUINI4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUINI4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:56:10 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:46246 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S269215AbUINIzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:55:54 -0400
Subject: Re: Add skeleton "generic IO mapping" infrastructure.
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com
In-Reply-To: <200409132206.i8DM6dSC030620@hera.kernel.org>
References: <200409132206.i8DM6dSC030620@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1095152147.9144.254.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 14 Sep 2004 09:55:47 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 18:32 +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1869, 2004/09/13 11:32:00-07:00, torvalds@ppc970.osdl.org
> 
> 	Add skeleton "generic IO mapping" infrastructure.
> 	
> 	Jeff wants to use this to clean up SATA and some network drivers.


> + * Read/write from/to an (offsettable) iomem cookie. It might be a PIO
> + * access or a MMIO access, these functions don't care. The info is
> + * encoded in the hardware mapping set up by the mapping functions
> + * (or the cookie itself, depending on implementation and hw).
> + *
> + * The generic routines don't assume any hardware mappings, and just
> + * encode the PIO/MMIO as part of the cookie. They coldly assume that
> + * the MMIO IO mappings are not in the low address range.
> + *
> + * Architectures for which this is not true can't use this generic
> + * implementation and should do their own copy.
> + *
> + * We encode the physical PIO addresses (0-0xffff) into the
> + * pointer by offsetting them with a constant (0x10000) and
> + * assuming that all the low addresses are always PIO. That means
> + * we can do some sanity checks on the low bits, and don't
> + * need to just take things for granted.
> + */
> +#define PIO_OFFSET	0x10000
> +#define PIO_MASK	0x0ffff
> +#define PIO_RESERVED	0x40000

> +#define IO_COND(addr, is_pio, is_mmio) do {			\
> +	unsigned long port = (unsigned long __force)addr;	\
> +	if (port < PIO_RESERVED) {				\
> +		VERIFY_PIO(port);				\
> +		port &= PIO_MASK;				\
> +		is_pio;						\
> +	} else {						\
> +		is_mmio;					\
> +	}							\
> +} while (0)

Argh! Please no. You can't infer the IO space from the address. Provide
a cookie containing {space, address} instead -- or indeed {bus,
address}. Let some architectures optimise that by ignoring the bus and
working it out from the address if you must, but don't put that in the
generic version.

-- 
dwmw2


