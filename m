Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWHUI2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWHUI2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWHUI2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:28:19 -0400
Received: from mother.openwall.net ([195.42.179.200]:46736 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750791AbWHUI2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:28:18 -0400
Date: Mon, 21 Aug 2006 12:24:08 +0400
From: Solar Designer <solar@openwall.com>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Message-ID: <20060821082408.GA24442@openwall.com>
References: <20060819230532.GA16442@openwall.com> <ecb7k6$grh$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb7k6$grh$1@taverner.cs.berkeley.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I realize that the patch has been rejected and this message is in no
way meant to affect that decision.)

On Mon, Aug 21, 2006 at 03:00:22AM +0000, David Wagner wrote:
> Solar Designer  wrote:
> >The patch makes getsockopt(2) sanity-check the value pointed to by
> >the optlen argument early on.  This is a security hardening measure
> >intended to prevent exploitation of certain potential vulnerabilities in
> >socket type specific getsockopt() code on UP systems.
> 
> This looks broken to me.  It has a TOCTTOU (time-of-check-to-time-of-use)

Yes it does, using Matt Bishop's classification.

> vulnerability (i.e., race condition): you read the length value twice,
> and assume that you will get the same value both times.  That assumption
> is not valid.

I don't assume that.  I realize that there's the race condition on SMP
and, as pointed out by Andi Kleen, in many cases also on UP systems.
That's why I had the XXX comment in there from the very beginning.

This added check is not supposed to be relied upon; rather, it is a
hardening measure in case we miss a bug in underlying *getsockopt()
functions.

> It looks like it will be easy to bypass this check.

It depends.  You might have missed this description of a special case
where it does not appear to be possible to bypass the check:

	http://lkml.org/lkml/2006/8/20/148

Yes, the patch is highly controversial and I mostly agree with its
opponents (I had much of the same thoughts myself, except for DaveM's
concern that *optlen might be uninitialized or negative on purpose),
yet I am going to keep it in -ow.

BTW, I had previously submitted a very similar check to do_sysctl(),
also with an XXX comment, which got in a few years back.

I won't be surprised if one of these checks saves a system from a
compromise one day.  This world is not perfect - neither the rest of the
Linux kernel code nor vulnerability exploit programs are perfect.

Alexander

P.S. Please CC me on your replies.
