Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVKMFJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVKMFJl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 00:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVKMFJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 00:09:41 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:50821 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751352AbVKMFJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 00:09:40 -0500
Date: Sat, 12 Nov 2005 21:09:13 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rohit.seth@intel.com, akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
Message-Id: <20051112210913.0b365815.pj@sgi.com>
In-Reply-To: <43716476.1030306@yahoo.com.au>
References: <20051107174349.A8018@unix-os.sc.intel.com>
	<20051107175358.62c484a3.akpm@osdl.org>
	<1131416195.20471.31.camel@akash.sc.intel.com>
	<43701FC6.5050104@yahoo.com.au>
	<20051107214420.6d0f6ec4.pj@sgi.com>
	<43703EFB.1010103@yahoo.com.au>
	<1131473876.2400.9.camel@akash.sc.intel.com>
	<43716476.1030306@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The __GFP_HIGH, GFP_ATOMIC, __GFP_WAIT flags are still driving me bonkers.

It seems to me that:
 1) __GFP_WAIT is supposed to mean can wait, and __alloc_pages()
    keys off that bit to set its "wait" variable.  Good so far.
 2) __GFP_HIGH is supposed to mean can access emergency pools
    (use lower watermarks), and __alloc_pages() does that.  Also
    good so far.
 3) But gfp.h defines GFP_ATOMIC to be an alias for __GFP_HIGH,
    and many callers through out the kernel use GFP_ATOMIC to mean
    "can't sleep" or "can't wait" or some such.  These folks are
    not getting the service they expect - they are asking for the
    most aggressive form of allocation (short perhaps of the
    special case for allocations that will net free more memory
    than they require, such as exiting), and they get the half way
    improvement instead, with the possibility of sleeping (!).

The confusion even extends to the comments in __alloc_pages(),
such as in the lines:

	/* Atomic allocations - we can't balance anything */
	if (!wait)
		goto nopage;

The "!wait" condition is --not-- GFP_ATOMIC, which is what
one might think was meant by "Atomic allocations", and likely
what the many users of GFP_ATOMIC were expecting - a nopage
response in such cases.

Perhaps GFP_ATOMIC should be its own __GFP_ATOMIC bit, with a BUG_ON
if both __GFP_ATOMIC and __GFP_WAIT are set at the same time,
leaving __GFP_HIGH for the few uses where people were just asking
to go a bit lower in the reserves.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
