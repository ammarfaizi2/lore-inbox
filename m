Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWAUT0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWAUT0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWAUT0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:26:43 -0500
Received: from pat.uio.no ([129.240.130.16]:29437 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932265AbWAUT0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:26:42 -0500
Subject: Re: set_bit() is broken on i386?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, ak@suse.de, mingo@redhat.com,
       torvalds@osdl.org
In-Reply-To: <20060120183857.188ef516.akpm@osdl.org>
References: <200601201955_MC3-1-B649-DCF5@compuserve.com>
	 <1137806107.8691.25.camel@lade.trondhjem.org>
	 <jek6cu73jy.fsf@sykes.suse.de>  <20060120183857.188ef516.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 14:26:22 -0500
Message-Id: <1137871582.8715.31.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.727, required 12,
	autolearn=disabled, AWL 1.09, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 18:38 -0800, Andrew Morton wrote:
> We need to somehow tell the compiler "this assembly statement altered
> memory and you can't cache memory contents across it".  That's what
> "memory" (ie: barrier()) does.  I don't think there's a way of telling gcc
> _what_ memory was clobbered - just "all of memory".

We _can_  (and do) tell gcc that the unsigned long at address "addr"
will be clobbered. The problem here is that we're actually applying
set_bit() to a bit array that is larger than the single long, so we are
not necessarily clobbering "addr", but rather the long at addr + X.

Most non-386 architectures don't actually have this compiler reordering
problem since they tend to convert the index into the bit array into an
offset for addr + a remainder:

  unsigned long *offset = addr + (nr / 8*sizeof(unsigned long));
  unsigned long bit = (nr % 8*sizeof(unsigned long));

and then tell the compiler that the long at "offset" will be clobbered.
The remaining architectures appear to already have the general memory
clobber set in their asms (as far as I can see).

IOW: the 386 and x86_64 appear to be the problem cases here, and then
only when applied to large bit arrays.

Cheers
  Trond

