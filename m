Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTJIAP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 20:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTJIAP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 20:15:58 -0400
Received: from fmr09.intel.com ([192.52.57.35]:64981 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261821AbTJIAPz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 20:15:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] monotonic seqlock for HPET timer
Date: Wed, 8 Oct 2003 17:15:48 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600778B7@scsmsx403.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] monotonic seqlock for HPET timer
Thread-Index: AcONz0vDKA0UtQ/ATG2b91TcjTcnzgAKxGmw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Stephen Hemminger" <shemminger@osdl.org>,
       "john stultz" <johnstul@us.ibm.com>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Oct 2003 00:15:48.0355 (UTC) FILETIME=[7D827D30:01C38DFA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tested on HPET capable system. Works fine.

Thanks,
-Venkatesh

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Stephen Hemminger
> Sent: Wednesday, October 08, 2003 11:58 AM
> To: john stultz; Linus Torvalds; Andrew Morton
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] monotonic seqlock for HPET timer
> 
> 
> Replace read/write lock used for HPET timer monotonic_lock 
> with seqlock.
> Similar to locking used on xtime and monotonic_lock in 
> timers/timer_tsc.c
> 
> It builds and runs, but I don't have hardware with HPET 
> support to test.
> Not a big deal (yet) since only hangcheck timer uses 
> monotonic clock so far.
> 
> diff -urN -X dontdiff 
> linux-2.5/arch/i386/kernel/timers/timer_hpet.c 
> linux-2.5-net/arch/i386/kernel/timers/timer_hpet.c
> --- linux-2.5/arch/i386/kernel/timers/timer_hpet.c	
> 2003-09-30 13:53:48.000000000 -0700
> +++ linux-2.5-net/arch/i386/kernel/timers/timer_hpet.c	
> 2003-09-16 12:54:26.000000000 -0700
> @@ -24,7 +24,7 @@
>  static unsigned long last_tsc_low;	/* lsb 32 bits of Time 
> Stamp Counter */
>  static unsigned long last_tsc_high; 	/* msb 32 bits of Time 
> Stamp Counter */
>  static unsigned long long monotonic_base;
> -static rwlock_t monotonic_lock = RW_LOCK_UNLOCKED;
> +static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
>  
>  /* convert from cycles(64bits) => nanoseconds (64bits)
>   *  basic equation:
> @@ -57,12 +57,14 @@
>  static unsigned long long monotonic_clock_hpet(void)
>  {
>  	unsigned long long last_offset, this_offset, base;
> +	unsigned seq;
>  
>  	/* atomically read monotonic base & last_offset */
> -	read_lock_irq(&monotonic_lock);
> -	last_offset = ((unsigned long 
> long)last_tsc_high<<32)|last_tsc_low;
> -	base = monotonic_base;
> -	read_unlock_irq(&monotonic_lock);
> +	do {
> +		seq = read_seqbegin(&monotonic_lock);
> +		last_offset = ((unsigned long 
> long)last_tsc_high<<32)|last_tsc_low;
> +		base = monotonic_base;
> +	} while (read_seqretry(&monotonic_lock, seq));
>  
>  	/* Read the Time Stamp Counter */
>  	rdtscll(this_offset);
> @@ -99,7 +101,7 @@
>  	unsigned long long this_offset, last_offset;
>  	unsigned long offset;
>  
> -	write_lock(&monotonic_lock);
> +	write_seqlock(&monotonic_lock);
>  	last_offset = ((unsigned long 
> long)last_tsc_high<<32)|last_tsc_low;
>  	rdtsc(last_tsc_low, last_tsc_high);
>  
> @@ -113,7 +115,7 @@
>  	/* update the monotonic base value */
>  	this_offset = ((unsigned long 
> long)last_tsc_high<<32)|last_tsc_low;
>  	monotonic_base += cycles_2_ns(this_offset - last_offset);
> -	write_unlock(&monotonic_lock);
> +	write_sequnlock(&monotonic_lock);
>  }
>  
>  void delay_hpet(unsigned long loops)
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
