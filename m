Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUBHLPY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 06:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUBHLPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 06:15:24 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:55947 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S263388AbUBHLPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 06:15:19 -0500
Subject: Re: When should we use likely() / unlikely() / get_unaligned() ?
From: David Woodhouse <dwmw2@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx, rth@twiddle.net
In-Reply-To: <20040208214335.58f351d4.rusty@rustcorp.com.au>
References: <1076065578.16147.72.camel@hades.cambridge.redhat.com>
	 <20040208214335.58f351d4.rusty@rustcorp.com.au>
Content-Type: text/plain
Message-Id: <1076238833.12587.229.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sun, 08 Feb 2004 11:13:53 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-08 at 21:43 +1100, Rusty Russell wrote:
> Sometimes, unlikely()/likely() help code readability.  But generally it
> should be considered the register keyword of the 2000's: if the case isn't
> ABSOLUTELY CRYSTAL CLEAR, or doesn't show up on benchmarks, distain is
> appropriate.

Yes, that seems like a reasonable enough answer for likely()/unlikely()
-- use it only when it's 95% correct, and that way it's sane on all
architectures. The rest we ought to be able to leave to gcc.

To be honest, I'm more interested in the case of get_unaligned(). The
principle is fairly similar -- the ratio between the performance of the
inline and the exception cases varies wildly from architecture to
architecture. But the range is far wider -- we now support architectures
in 2.6 where alignment fixups _cannot_ happen, and the cost of the
'exception' case should be considered infinite.

A probability argument for get_unaligned() allows those architectures to
_unconditionally_ emit inline unaligned load/store code, while allowing
other, saner, architectures to start doing so only when the probability
means it makes sense.

The alternative would be a get_unlikely_unaligned() which does the same
as our current get_unaligned() on architectures without fixups, but
which is a direct dereference on others. I think I'd prefer the
probability approach though, because it allows us to tune the threshold
for all arches. 

-- 
dwmw2


