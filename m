Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWCaAjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWCaAjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWCaAjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:39:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:30036 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751130AbWCaAi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:38:59 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17973915:sNHT25064137"
Message-Id: <200603310038.k2V0crg26704@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 16:39:38 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUWJm5lGF1WcSDSPG5bufQnTw+bwAALF/A
In-Reply-To: <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 4:18 PM
> Note that the current semantics for bitops IA64 are broken. Both
> smp_mb__after/before_clear_bit are now set to full memory barriers
> to compensate

Why you say that?  clear_bit has built-in acq or rel semantic depends
on how you define it. I think only one of smp_mb__after/before need to
be smp_mb?



>  static __inline__ void
>  clear_bit (int nr, volatile void *addr)
>  {
> -	__u32 mask, old, new;
> -	volatile __u32 *m;
> -	CMPXCHG_BUGCHECK_DECL
> -
> -	m = (volatile __u32 *) addr + (nr >> 5);
> -	mask = ~(1 << (nr & 31));
> -	do {
> -		CMPXCHG_BUGCHECK(m);
> -		old = *m;
> -		new = old & mask;
> -	} while (cmpxchg_acq(m, old, new) != old);
> +	clear_bit_mode(nr, addr, MODE_ATOMIC);
>  }

I would make that MODE_RELEASE for clear_bit, simply to match the
observation that clear_bit is usually used in unlock path and have
potential less surprises.


> +static __inline__ void
> +set_bit_mode (int nr, volatile void *addr, int mode)
> +{
> +	__u32 bit, old, new;
> +	volatile __u32 *m;
> +	CMPXCHG_BUGCHECK_DECL
> +
> +	m = (volatile __u32 *) addr + (nr >> 5);
> +	bit = 1 << (nr & 31);
> +
> +	if (mode == MODE_NON_ATOMIC) {
> +		*m |= bit;
> +		return;
> +	}

Please kill all volatile declaration, because for non-atomic version,
you don't need to do any memory ordering, but compiler automatically
adds memory order because of volatile.  It's safe to kill them because
cmpxchg later has explicit mode in there.

Same thing goes to all other bit ops.

- Ken
