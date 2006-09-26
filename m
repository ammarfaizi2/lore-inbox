Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWIZQRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWIZQRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWIZQRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:17:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932316AbWIZQRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:17:03 -0400
Date: Tue, 26 Sep 2006 09:15:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Howells <dhowells@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv
In-Reply-To: <1159260980.3309.22.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.64.0609260909470.3952@g5.osdl.org>
References: <20060925142016.GI29920@ftp.linux.org.uk> 
 <1159186771.11049.63.camel@localhost.localdomain> 
 <1159183568.11049.51.camel@localhost.localdomain>  <20060924223925.GU29920@ftp.linux.org.uk>
  <22314.1159181060@warthog.cambridge.redhat.com>  <5578.1159183668@warthog.cambridge.redhat.com>
  <7276.1159186684@warthog.cambridge.redhat.com>  <20660.1159195152@warthog.cambridge.redhat.com>
  <1159199184.11049.93.camel@localhost.localdomain>  <1159258013.3309.9.camel@pmac.infradead.org>
  <4518EA39.40309@pobox.com> <1159260980.3309.22.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Sep 2006, David Woodhouse wrote:
>
> On Tue, 2006-09-26 at 04:52 -0400, Jeff Garzik wrote:
> > The irq is a special case no matter how we try to prettyify it.  We need 
> > two irqs, and PCI only gives us one per device. 
> 
> That's fine -- but don't use zero to mean none. We have NO_IRQ for that,
> and zero isn't an appropriate choice.

Zero _is_ an appropriate choice, dammit!

That NO_IRQ thing should be zero, and any architecture that thinks that 
zero is a valid IRQ just needs to fix its own irq mapping so that the 
"cookie" doesn't work.

The thing is, it's zero. Get over it. It can't be "-1" or some other 
random value like people have indicated, because that thing is often read 
from places where "-1" simply isn't a possible value (eg it gets its 
default value initialized from a "unsigned char" in MMIO space on x86).

So instead of making everybody and their dog to silly things with some 
NO_IRQ define that they haven't historically done, the rule is simple: "0" 
means "no irq", so that you can test for it with obvious code like

	if (!dev->irq)
		..

and then, if your actual _hardware_ things that the bit-pattern with all 
bits clear is a valid irq that can be used for normal devices, then what 
you do is you add a irq number translation layer (WHICH WE NEED AND HAVE 
_ANYWAY_) and make sure that nobody sees that on a _software_ level.

			Linus
