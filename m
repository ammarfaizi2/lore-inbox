Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWJLTHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWJLTHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWJLTHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:07:15 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:26525 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750983AbWJLTHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:07:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=OSGw0o6hzec66JuHxS+hKLIe45vmmy76MM8yyKw5LvrtruOnN81XzKQWkuyIrdDPpiWQStRrrK6i3kIQIzt0WZAso/Hw4cMkecSsf6NVDkdX2UIRECI1IXAePoOxmy6m/nJM7zpfrW5hXH0wRObz9P70LCsmcNbqW8LxtUpOkNI=  ;
From: David Brownell <david-b@pacbell.net>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] SPI: improve sysfs compiler complaint handling
Date: Thu, 12 Oct 2006 12:07:08 -0700
User-Agent: KMail/1.7.1
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <20061012014920.GA13000@havoc.gtf.org> <200610121108.59727.david-b@pacbell.net> <1160678375.3000.454.camel@laptopd505.fenrus.org>
In-Reply-To: <1160678375.3000.454.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610121207.08652.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 11:39 am, Arjan van de Ven wrote:
> 
> > Does anyone know why the GCC folk have decided to go against decades
> > of common practice here???
> 
> because it's new semantics. I was involved in this GCC feature (not in
> the coding just in the asking for it) and this behavior was specifically
> requested: It is called __must_check, you MUST CHECK it. It's not the
> normal "unused warning", by putting the attribute on the function you
> tell gcc that the result MUST be checked. Just a cast to void isn't
> checking it.... so it rightfully warns.

Ah, I see.

So another issue would seem to be that this "__must_check" thing is now
being abused ... e.g. in cases like this one, where checking is pointless.

ISTR being frustrated at various points that GCC wouldn't warn when
function values were wrongly ignored.  Seems to me there are at least
four cases for function f() return values:

   f();			/* [1] not used ... worth warning about */

   (void) f();		/* [2] not used, but known to be OK; don't warn */

   value = f();		/* it's "used", assuming [3a] "value" is used
			 * instead of [3b] "value" is not used ... where
			 * "used" means more than just "assigned"
			 */

One of the issues with this __must_check() thing is that it's possible
to shut the warning up by assigning function results to a dummy value,
but then not use that value.  IMO that proliferates bad code.

IMO we'd have been a lot better off with the warnings on [1], which I
never recall seeing, and [3b], which we're clearly not seeing even now.
Because then we could shut up the "safe" warnings cleanly like [2], and
know that the real likely-to-be-bugs cases consistently trigger warnings.

- Dave

