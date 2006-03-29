Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWC2A2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWC2A2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWC2A2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:28:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:2093 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964881AbWC2A2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:28:39 -0500
X-IronPort-AV: i="4.03,140,1141632000"; 
   d="scan'208"; a="16331201:sNHT3040387154"
Message-Id: <200603290012.k2T0C6g32166@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Zoltan Menyhart" <Zoltan.Menyhart@free.fr>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Tue, 28 Mar 2006 16:12:42 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZSxMfxr6gMEsIsQ8OR0DYRRxpRBwAADIJg
In-Reply-To: <Pine.LNX.4.64.0603281537500.15037@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Tuesday, March 28, 2006 3:48 PM
> On Tue, 28 Mar 2006, Zoltan Menyhart wrote:
> 
> > Why not to use separate bit operations for different purposes?
> > 
> > - e.g. "test_and_set_bit_N_acquire()" for lock acquisition
> > - "test_and_set_bit()", "clear_bit()" as they are today
> > - "release_N_clear_bit()"...
> > 
> 
> That would force IA64 specifics onto all other architectures.
> 
> Could we simply define these smb_mb__*_clear_bit to be noops
> and then make the atomic bit ops to have full barriers? That would satisfy 
> Nick's objections.
> 
> --- linux-2.6.16.orig/include/asm-ia64/bitops.h	2006-03-19 21:53:29.000000000 -0800
> +++ linux-2.6.16/include/asm-ia64/bitops.h	2006-03-28 15:45:08.000000000 -0800
> @@ -45,6 +45,7 @@
>  		old = *m;
>  		new = old | bit;
>  	} while (cmpxchg_acq(m, old, new) != old);
> +	smb_mb();
>  }

There are better way to do it.  The pointer is already cast as volatile,
so old = *m has acq semantics built-in, we can just change cmpxchg_acq to
cmpxchg_rel, then effectively it is a full memory barrier without doing the
expensive smp_mb().

- Ken
