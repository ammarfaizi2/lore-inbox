Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266348AbUFZTDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266348AbUFZTDj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 15:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266360AbUFZTDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 15:03:39 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:5305 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266348AbUFZTDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 15:03:35 -0400
Subject: Re: [PATCH] Fix the cpumask rewrite
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406261140360.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave>
	<Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
	<1088268405.1942.25.camel@mulgrave>
	<Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
	<1088270298.1942.40.camel@mulgrave>
	<Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
	<20040626182820.GA3723@ucw.cz> 
	<Pine.LNX.4.58.0406261140360.16079@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Jun 2004 14:02:10 -0500
Message-Id: <1088276531.1750.113.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 13:54, Linus Torvalds wrote:
> On Sat, 26 Jun 2004, Vojtech Pavlik wrote:
> > At least input pretty much relies on the fact that bitops don't need
> > locking and act as memory barriers.
> 
> Well, plain test_bit() has always been more relaxed than the others, and
> has never implied a memory barrier. Only the "test_and_set/clear()" things
> imply memory barriers.
> 
> What we _could_ do (without changing any existing rules) is to add a
> "__test_bit()" that is the relaxed version that doesn't do any of the
> volatile etc. That would match the "__"  versions of the other bit
> operations.
> 
> Then people who know that they use the bits without any volatility issues 
> can use that one, and let the compiler optimize more. 

Well, we can do this, yes.

Our test bit implementation would then become:

static __inline__ int test_bit(int nr, const volatile void *address)
{
	return __test_bit(nr, (const void *)address);
}

That would keep our implementation happy.

James


