Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760377AbWLFJiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760377AbWLFJiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760383AbWLFJiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:38:20 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:34249 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760375AbWLFJiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:38:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=EJsg3ufGcOThO/EePJ2CJjVNYsGIT+t9pOHafOmDukg5I+5/aqwFZrkeY78yQQidoBVNFApA/PX0vBsH3ZNlql3Qr+7KqJCSnOxca+7BcUiBiqyLVWjoUn1gEQnWu568iBBIIYoiKhidPXaRaFGAmaZPnBESdZX6C4astOEaXT4=
Message-ID: <45768F84.7090707@gmail.com>
Date: Wed, 06 Dec 2006 18:38:12 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jeff Garzik <jeff@garzik.org>, Mikael Pettersson <mikpe@it.uu.se>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
References: <200612010958.kB19wGbg002454@alkaid.it.uu.se>	 <4572CA7A.6010103@gmail.com> <4572CB2B.8050406@garzik.org>	 <4572CEE7.502@gmail.com> <1165155367.3233.220.camel@laptopd505.fenrus.org>
In-Reply-To: <1165155367.3233.220.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> But, having those flushes won't hurt either.  What was the conclusion of
>> mmio <-> spinlock sync discussion?  I always feel kind of uncomfortable
>> about readl() flushes.  I think they're too subtle.
> 
> those are orthogonal!
> The posting flushes have nothing to do with spinlock-vs-mmio; that
> discussion was about the CPU, while posting flushes are about the
> chipset / bridges / etc....

The problem is that it's not clear what those posting flushes actually
achieve.  Do they achieve IRQ disabling on completion?  Hardly, IRQ can
use whole different channel anyway.

And, as for spinlock/IO ordering, libata currently depends on IO
instructions not leaking outside of spinlock (ordering-wise).  We have
posting flushes at several places and some of them clearly make sense
(e.g. timed wait) but some others aren't that clear while majority of
places just don't do anything about ordering other than wrapping them
inside spinlock.

So, I don't really know.  Do we have to add mmiowb() before every
spin_unlock after IO?  Or, do we have to do explicit flushes everytime?
 Or, is it something to be taken care of in the upper layer?

-- 
tejun
