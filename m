Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285878AbSADXst>; Fri, 4 Jan 2002 18:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285935AbSADXsk>; Fri, 4 Jan 2002 18:48:40 -0500
Received: from holomorphy.com ([216.36.33.161]:4290 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285878AbSADXs1>;
	Fri, 4 Jan 2002 18:48:27 -0500
Date: Fri, 4 Jan 2002 15:48:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: Re: hashed waitqueues
Message-ID: <20020104154813.A10391@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@zip.com.au
In-Reply-To: <20020104094049.A10326@holomorphy.com> <3C3635A8.447EE52E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3C3635A8.447EE52E@zip.com.au>; from akpm@zip.com.au on Fri, Jan 04, 2002 at 03:07:20PM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
+       /*
+        * Although the default semantics of wake_up() are
+        * to wake all, here the specific function is used
+        * to make it even more explicit that a number of
+        * pages are being waited on here.
+        */
+       if(waitqueue_active(page_waitqueue(page)))
+               wake_up_all(page_waitqueue(page));

On Fri, Jan 04, 2002 at 03:07:20PM -0800, Andrew Morton wrote:
> Does the compiler CSE these two calls to page_waitqueue()?
> All versions?   I'd be inclined to do CSE-by-hand here.

I'm not sure if CSE is run before or after inlining, but it
is probably not wise to leave it up to the compiler.

On Fri, Jan 04, 2002 at 03:07:20PM -0800, Andrew Morton wrote:
> Also, why wake_up_all()?  That will wake all tasks which are sleeping
> in __lock_page(), even though they've asked for exclusive wakeup
> semantics.  Will a bare wake_up() here not suffice?

A couple of other private responses pointed this out, and also had
suggestions for several ways to avoid the thundering herds. I am not
sure it's possible to honor exclusive wakeup requests here without
creating problems or otherwise having to propagate semantic changes
further up the call chain. I think that comment and one of the others
needs to be expanded to make the exclusive wakeup issue clearer.

Also there is a bug in the hash function (pointed out by an anonymous
private response):


On Fri, Jan 04, 2002 at 07:16:33PM -0000, an anonymous person told me:
> One *bug* in your code is that if toy have 64-bit longs, your
> GOLDEN_RATIO_PRIME isn't large enough and page_waitqueue will
> always compute hash = 0.
> The closest primes to phi * 2^64 = 11400714819323198485.95... are:
>	...
>	11400714819323198333    
>	11400714819323198389
>	11400714819323198393
>	*
>	11400714819323198549
>	11400714819323198581
>	11400714819323198647
>	...

which is easy enough to repair with a conditional definition of
GOLDEN_RATIO_PRIME.

The same person also mentioned that less work could be done in
the hash function by storing the shift amount directly in the zone,
and also pointed out that the masking operation is unnecessary as the
shift already annihilates the high-order bits.

Cheers,
Bill
