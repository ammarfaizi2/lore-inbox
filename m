Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWC3Ino@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWC3Ino (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWC3Ino
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:43:44 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:19331 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751093AbWC3Inn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:43:43 -0500
Message-ID: <442B9A2A.7000306@bull.net>
Date: Thu, 30 Mar 2006 10:43:22 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <65953E8166311641A685BDF71D865826A23D40@cacexc12.americas.cpqcorp.net> <Pine.LNX.4.64.0603291529160.26011@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603291529160.26011@schroedinger.engr.sgi.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2006 10:45:39,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2006 10:45:47,
	Serialize complete at 30/03/2006 10:45:47
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Hmmm... Maybe we therefore need to add a mode to each bit operation in 
> the kernel?
> 
> With that we can also get rid of the __* version of bitops.
> 
> Possible modes are
> 
> NON_ATOMIC 	Do not perform any atomic ops at all.
> 
> ATOMIC		Atomic but unordered
> 
> ACQUIRE		Atomic with acquire semantics (or lock semantics)
> 
> RELEASE 	Atomic with release semantics (or unlock semantics)
> 
> FENCE		Atomic with full fence.
> 
> This would require another bitops overhaul.
> 
> Maybe we can preserve the existing code with bitops like __* mapped to 
> *(..., NON_ATOMIC) and * mapped to *(..., FENCE) and the gradually fix the 
> rest of the kernel.

Form semantical point of view, the forms:

	bit_foo(..., mode)
and
	bit_foo_mode(...)

are equivalent.

However, I do not think your implementation would be efficient due to
selecting the ordering mode at run time:

> +	switch (mode) {
> +	case MODE_NONE :
> +	case MODE_ACQUIRE :
> +		return cmpxchg_acq(m, old, new);
> +	case MODE_FENCE :
> +		smp_mb();
> +		/* Fall through */
> +	case MODE_RELEASE :
> +		return cmpxchg_rel(m, old, new);

> +	if (mode == ORDER_NON_ATOMIC) {
> +		*m |= bit;
> +		return;
> +	}

etc.

In addition, we may want to inline these primitives...

A compile-time selection of the appropriate code sequence would help.

Thanks,

Zoltan
