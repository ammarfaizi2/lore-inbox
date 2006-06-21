Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWFUVJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWFUVJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFUVJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:09:31 -0400
Received: from mga03.intel.com ([143.182.124.21]:30730 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751113AbWFUVJa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:09:30 -0400
X-IronPort-AV: i="4.06,163,1149490800"; 
   d="scan'208"; a="55565724:sNHT237332354"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
Date: Wed, 21 Jun 2006 14:09:09 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A47CBE20@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
Thread-Index: AcaVdf2pmyy+6swvR2OHtk6I9jIxJAAAHfBQ
From: "Moore, Robert" <robert.moore@intel.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Jun 2006 21:09:10.0744 (UTC) FILETIME=[F0EDE580:01C69576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I may be interpreting this incorrectly, but are you busy-waiting on the
ACPI Global Lock to become free?

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Andreas Mohr
> Sent: Wednesday, June 21, 2006 2:01 PM
> To: Andrew Morton
> Cc: Brown, Len; linux-acpi@vger.kernel.org;
linux-kernel@vger.kernel.org
> Subject: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
> 
> 
> Use cpu_relax() in __acpi_acquire_global_lock() etc.
> 
> 
> This could be considered overkill given the previous unlikely(),
> but it is busy-looping in case of false condition after all...
> 
> Tested on 2.6.17-mm1, i386 only (no x86_64 here).
> 
> Signed-off-by: Andreas Mohr <andi@lisas.de>
> 
> 
> diff -urN linux-2.6.17-mm1.orig/include/asm-i386/acpi.h linux-2.6.17-
> mm1.my/include/asm-i386/acpi.h
> --- linux-2.6.17-mm1.orig/include/asm-i386/acpi.h	2006-06-19
> 10:57:27.000000000 +0200
> +++ linux-2.6.17-mm1.my/include/asm-i386/acpi.h	2006-06-21
> 14:43:24.000000000 +0200
> @@ -61,11 +61,14 @@
>  __acpi_acquire_global_lock (unsigned int *lock)
>  {
>  	unsigned int old, new, val;
> -	do {
> +	while (1) {
>  		old = *lock;
>  		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
>  		val = cmpxchg(lock, old, new);
> -	} while (unlikely (val != old));
> +		if (likely(val == old))
> +			break;
> +		cpu_relax();
> +	}
>  	return (new < 3) ? -1 : 0;
>  }
> 
> @@ -73,11 +76,14 @@
>  __acpi_release_global_lock (unsigned int *lock)
>  {
>  	unsigned int old, new, val;
> -	do {
> +	while (1) {
>  		old = *lock;
>  		new = old & ~0x3;
>  		val = cmpxchg(lock, old, new);
> -	} while (unlikely (val != old));
> +		if (likely(val == old))
> +			break;
> +		cpu_relax();
> +	}
>  	return old & 0x1;
>  }
> 
> diff -urN linux-2.6.17-mm1.orig/include/asm-x86_64/acpi.h
linux-2.6.17-
> mm1.my/include/asm-x86_64/acpi.h
> --- linux-2.6.17-mm1.orig/include/asm-x86_64/acpi.h	2006-06-21
> 14:28:19.000000000 +0200
> +++ linux-2.6.17-mm1.my/include/asm-x86_64/acpi.h	2006-06-21
> 14:43:24.000000000 +0200
> @@ -59,11 +59,14 @@
>  __acpi_acquire_global_lock (unsigned int *lock)
>  {
>  	unsigned int old, new, val;
> -	do {
> +	while (1) {
>  		old = *lock;
>  		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
>  		val = cmpxchg(lock, old, new);
> -	} while (unlikely (val != old));
> +		if (likely(val == old))
> +			break;
> +		cpu_relax();
> +	}
>  	return (new < 3) ? -1 : 0;
>  }
> 
> @@ -75,7 +78,10 @@
>  		old = *lock;
>  		new = old & ~0x3;
>  		val = cmpxchg(lock, old, new);
> -	} while (unlikely (val != old));
> +		if (likely(val == old))
> +			break;
> +		cpu_relax();
> +	}
>  	return old & 0x1;
>  }
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
