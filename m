Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbTFLX0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265068AbTFLX0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:26:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58610 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265067AbTFLX0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:26:43 -0400
Subject: Re: [PATCH] udev enhancements to use kernel event queue
From: Robert Love <rml@tech9.net>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
References: <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
Content-Type: text/plain
Message-Id: <1055461324.662.346.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 12 Jun 2003 16:42:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 16:34, Patrick Mochel wrote:

> > Nice thinking. It is a shame we need a lock for this, but we don't
> > have an atomic_inc_and_return().
> 
> Those were my sentiments exactly:

Heh.

> +static inline int atomic_inc_and_read(atomic_t *v)
> +{
> +	__asm__ __volatile__(
> +		LOCK "incl %0"
> +		:"=m" (v->counter)
> +		:"m" (v->counter));
> +	return v->counter;
> +}

What prevents a race between the increment and the return (i.e. you
return v->counter after another person also increments it)? Only the
increment is guaranteed atomic.

I think you need to copy the result of the increment into a local
variable _inside_ of the LOCK and return that. Whether or not that will
work sanely on all architectures I dunno.

	Robert Love

