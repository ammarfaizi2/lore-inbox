Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUIPM1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUIPM1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUIPM1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:27:37 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:1720 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S268031AbUIPMZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:25:20 -0400
Subject: Re: Being more careful about iospace accesses..
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland Dreier <roland@topspin.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409151546400.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
	 <52zn3rupw8.fsf@topspin.com>
	 <Pine.LNX.4.58.0409151546400.2333@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1095337514.9144.2344.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 16 Sep 2004 13:25:15 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 16:26 -0700, Linus Torvalds wrote:
>  - if you want to go outside that bitwise type, you have to convert it 
>    properly first. For example, if you want to add a constant to a __le16 
>    type, you can do so, but you have to use the proper sequence:
> 
> 	__le16 sum, a, b;
> 
> 	sum = a + b;	/* INVALID! "warning: incompatible types for operation (+)" */
> 	sum = cpu_to_le16(le16_to_cpu(a) + le16_to_cpu(b));	/* Ok */
> 
> See? 

Yeah right, that latter case is _so_ much more readable, and makes it
_so_ easy for the compiler to optimise precisely when it wants to do the
byte-swapping, especially if the back end has load-and-swap or
store-and-swap instructions. :)

It's even nicer when it ends up as:

	sum = cpu_to_le16(le16_to_cpu(a) + le16_to_cpu(b));	/* Ok */
	sum |= c;
	sum = cpu_to_le16(le16_to_cpu(sum) + le16_to_cpu(d));

I'd really quite like to see the real compiler know about endianness,
too. I dare say I _could_ optimise the above (admittedly contrived but
not _so_ unlikely) case, but I don't _want_ to hand-optimise my code --
that's what I keep a compiler _for_.

-- 
dwmw2


