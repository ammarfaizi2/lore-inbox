Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUCWACL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 19:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUCWACL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 19:02:11 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:34524 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261661AbUCWACE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 19:02:04 -0500
Date: Mon, 22 Mar 2004 15:59:52 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040322155952.4d6f5035.pj@sgi.com>
In-Reply-To: <20040320093614.GZ2045@holomorphy.com>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
	<20040318175654.435b1639.pj@sgi.com>
	<1079737351.17841.51.camel@arrakis>
	<20040319165928.45107621.pj@sgi.com>
	<20040320031843.GY2045@holomorphy.com>
	<20040319220907.1e07d36f.pj@sgi.com>
	<20040320093614.GZ2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not quasi-const, it is const.

	Const cpumasks are not your Father's const references.
	======================================================

True, the current cpumask_const_t API makes essential use of the 'C'
const construct and semantics.

But it's not simply and entirely the usual const usage as seen in the
signature:

  char *strncpy(char *dest, const char *src, size_t n);

In this usual case, declaring something referenced by an argument
pointer as 'const' means the called function won't change the referenced
data.  For simple values such as the 'size_t n', it's not useful,
because these are simply pass by value, so changes by the called
function won't be visible to the caller anyway.  But when passing in
pointers, it has become useful in 'C' to indicate that the called
function won't mess with the pointed to data.

That's the usual use of the C keyword 'const', as I am sure you know
well.

You aren't simply marking parameters with the C 'const' keyword; you are
also labeling some functions and a cpumask typedef as const, embedding
the letters "_const" in the names.  Part of the cpumask_const_t
implementation uses the real C keyword 'const', but it's not simply the
classic usage shown above.

Each time I try to work with this, I have to scratch my head and think
a few minutes first.

Is the following a fair statement of this interface:

 1) Declaring a cpumask as type 'cpumask_const_t' means it might be passed
    to various cpumask '*_const()' methods either by value or by a const
    pointer, depending on the implementation (the size of the mask,
    presumably).

 2) The various cpumask '*_const()' methods expect to be passed such
    cpumask_const_t masks, and may actually pass by value or by const
    reference, at the discretion of the implementation, again.

So if I am not too confused, this non-C keyword embedded '_const' string
means something like "optionally pass masks by value or const pointer,
at the discretion of the implementation."

This is an abuse (or at the very least an extension) of our customary
use of the 'const' construct of the 'C' language, in my view; an abuse
with which users will never become comfortable.

You castigate yourself for not having converted more cpumask
manipulations to making full use of this quasi-const mechanism.

That way does not lay closure and sweet success.  You have provided a
weird API that will never become widely and comfortably used by others;
you will always find your available energies for putting it in use
yourself to be insufficient; you will be pushing this rock up the hill
throughout your years in purgatory (hopefully fewer years than I expect
to spend there ;).

I do not fault you for failing to put this interface to more wide
spread usage.  I do fault the interface for being a bit too weird
to obtain wide spread usage on its own, after it's original creation
and introduction.

Could you (Bill or any lurker) provide any specific examples of generic
code where it is important to pass by value on some architectures, but
by const reference on some other architectures?  Rather than distort the
API in general for such cases, I'd prefer to consider more narrowly
focused solutions that address such specific needs.  In general, I would
hope to be able to arrive at a cpumask (or even more generic mask as
multi-word bit mask) ADT that was always clear and explicit, using just
traditional 'C' idioms, as to whether arguments were pass by value or
reference, and which arguments were const reference or not-const.  If
some arch's (say sparc64) have arch-specific code that explicitly passes
a pointer to a cpumask, where similar code in some other arch passes by
value, that's fine, and an appropriate arch-specific optimization.  The
only challenges come in generic code for which arch's cannot agree on
any one form for passing a particular mask.  Examples anyone ... ?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
