Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVCISYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVCISYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVCISYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:24:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:51361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262160AbVCISW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:22:27 -0500
Date: Wed, 9 Mar 2005 10:24:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Discard key spinlock and use RCU for key payload
In-Reply-To: <28092.1110391155@redhat.com>
Message-ID: <Pine.LNX.4.58.0503091019060.2530@ppc970.osdl.org>
References: <28092.1110391155@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Mar 2005, David Howells wrote:
> 
> The attached patch changes the key implementation in a number of ways:
> 
>  (1) It removes the spinlock from the key structure.
> 
>  (2) The key flags are now accessed using atomic bitops instead of
>      write-locking the key spinlock and using C bitwise operators.

I'd suggest against using __set_bit() for the initialization. Either use
the proper set_bit() (which is slow, but at least consistent), or just
initialize it with (1ul << KEY_FLAG_IN_QUOTA). __set_bit is generally
slower than setting a value (it's pretty guaranteed not to be faster, and
at least on x86 is clearly slower), so using it as an "optimization" is
misguided.

RCU seems to fit the key model pretty well, but I still wonder whether the 
conceptual complexity is worth it. Was this done on a whim, or was there 
some real reason for it? I'd love for that to be documented while you're 
at it..

			Linus
