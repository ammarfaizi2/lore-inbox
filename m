Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVA2OaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVA2OaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 09:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVA2OaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 09:30:15 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:49856 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262920AbVA2OaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 09:30:07 -0500
Subject: Re: Fwd: Re: flush_cache_page()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Philippe Robin <Philippe.Robin@arm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050129113707.B2233@flint.arm.linux.org.uk>
References: <20050111223652.D30946@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0501111605570.2373@ppc970.osdl.org>
	 <20050129113707.B2233@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 08:29:22 -0600
Message-Id: <1107008962.4535.8.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-29 at 11:37 +0000, Russell King wrote:
> Thanks for the response.  However, apart from Ralph, Paul and yourself,
> it seems none of the other architecture maintainers care about this
> patch - the original mail was BCC'd to the architecture list.  Maybe
> that's an implicit acceptance of this patch, I don't know.

Well, OK, I'll try to answer for parisc, since we have huge VIPT
aliasing caches as well.

Right now, we have a scheme in flush_cache_page to make sure it's only
called when necessary (cache flushes are expensive for us and show up as
the primary cpu consumer in all of our profiles).  Our scheme is to see
if a translation exists for the page and skip the flush if it doesn't.

Obviously, like MIPS, we're also walking the page tables without
locking...

Looking at the callers of this, it seems it would be very unlikely to
call this with a missing translation, in that case, we can use the pfn
to flush the page through a temporary alias space instead and just take
the odd hit if no translation exists.  

> In other words, unless I actually receive some real help from the other
> architecture maintainers on this to address your concerns, ARM version 6
> CPUs with aliasing L1 caches (== >16K) will remain a dead dodo with
> mainline Linux kernels.

I've probably been told and forgotten, but what problems do you have
with your VIPT (Arm 6 is VIPT, not VIVT, right?) cache >16k which we
don't have with our 4MB VIPT caches on pa (which work, but cause us
grief with enormous amounts of flushing)?

James

