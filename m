Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVLUS4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVLUS4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVLUS4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:56:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15313 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751184AbVLUS4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:56:45 -0500
Date: Wed, 21 Dec 2005 18:56:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mark Maule <maule@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/4] msi vector targeting abstractions
Message-ID: <20051221185637.GA13210@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Maule <maule@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184348.5003.7540.53186@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221184348.5003.7540.53186@attica.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 12:42:41PM -0600, Mark Maule wrote:
> Abstract portions of the MSI core for platforms that do not use standard
> APIC interrupt controllers.  This is implemented through a set of callouts
> which default to current behavior, but which can be overridden by calling
> msi_register_callouts() in the platform msi init code.

we tend to calls these _ops or _operations instead of _callouts.
Also I'd suggest to not keep the generic ones where they are but
in a separate file and let the existing plattforms calls msi_register()
with the ops table for those.  This keeps the interface symmetric instead
of favouring the first implementation.

> @@ -89,10 +91,25 @@
>  }
>  
>  #ifdef CONFIG_SMP
> +static void msi_target_generic(unsigned int vector,
> +			       unsigned int dest_cpu,
> +			       uint32_t *address_hi,	/* in/out */
> +			       uint32_t *address_lo)	/* in/out */

Please try to use u32 instead of uint32_t everywhere.  Dito for other
sizes and signed types.

> +{
> +	struct msg_address address;
> +
> +	address.lo_address.value = *address_lo;
> +	address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
> +	address.lo_address.value |=
> +		(cpu_physical_id(dest_cpu) << MSI_TARGET_CPU_SHIFT);
> +
> +	*address_lo = address.lo_address.value;
> +}

Why do we need the full struct msg_address here?  What about just:

static void msi_target_apic(unsigned int vector, unsigned int dest_cpu,
			    u32 *address_hi, u32 *address_lo)
{
	u32 addr = *address_lo;

	addr &= MSI_ADDRESS_DEST_ID_MASK;
	addr |= (cpu_physical_id(dest_cpu) << MSI_TARGET_CPU_SHIFT);

	*address_lo = addr;
}

> +	(*msi_callouts.msi_teardown)(vector);
> +

just
	msi_ops.teardown(vector);

> +union msg_data {
> +	struct {
>  #if defined(__LITTLE_ENDIAN_BITFIELD)
> -	__u32	vector		:  8;
> -	__u32	delivery_mode	:  3;	/* 000b: FIXED | 001b: lowest prior */
> -	__u32	reserved_1	:  3;
> -	__u32	level		:  1;	/* 0: deassert | 1: assert */
> -	__u32	trigger		:  1;	/* 0: edge | 1: level */
> -	__u32	reserved_2	: 16;
> +		__u32	vector		:  8;
> +		__u32	delivery_mode	:  3;	/* 000b: FIXED */
> +						/* 001b: lowest prior */
> +		__u32	reserved_1	:  3;
> +		__u32	level		:  1;	/* 0: deassert | 1: assert */
> +		__u32	trigger		:  1;	/* 0: edge | 1: level */
> +		__u32	reserved_2	: 16;
>  #elif defined(__BIG_ENDIAN_BITFIELD)
> -	__u32	reserved_2	: 16;
> -	__u32	trigger		:  1;	/* 0: edge | 1: level */
> -	__u32	level		:  1;	/* 0: deassert | 1: assert */
> -	__u32	reserved_1	:  3;
> -	__u32	delivery_mode	:  3;	/* 000b: FIXED | 001b: lowest prior */
> -	__u32	vector		:  8;
> +		__u32	reserved_2	: 16;
> +		__u32	trigger		:  1;	/* 0: edge | 1: level */
> +		__u32	level		:  1;	/* 0: deassert | 1: assert */
> +		__u32	reserved_1	:  3;
> +		__u32	delivery_mode	:  3;	/* 000b: FIXED */
> +						/* 001b: lowest prior */
> +		__u32	vector		:  8;
>  #else
>  #error "Bitfield endianness not defined! Check your byteorder.h"
>  #endif
> +	}u;
> +	__u32 value;
>  } __attribute__ ((packed));


While you're cleaning things up, could you please kill the horrible abuse
of bitfields for H/W structures and do proper masking instead.

