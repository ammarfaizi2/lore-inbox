Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbTFMLEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 07:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265350AbTFMLEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 07:04:11 -0400
Received: from mail.webmaster.com ([216.152.64.131]:22153 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265142AbTFMLEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 07:04:09 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] udev enhancements to use kernel event queue
Date: Fri, 13 Jun 2003 04:17:54 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEFJDKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <16105.3943.510055.309447@nanango.paulus.ozlabs.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pual Mackerras is said to have opined:

> Patrick Mochel writes:

> > +static inline int atomic_inc_and_read(atomic_t *v)
> > +{
> > +	__asm__ __volatile__(
> > +		LOCK "incl %0"
> > +		:"=m" (v->counter)
> > +		:"m" (v->counter));
> > +	return v->counter;
> > +}

> BZZZT.  If another CPU is also doing atomic_inc_and_read you could end
> up with both calls returning the same value.
>
> You can't do atomic_inc_and_read on 386.  You can on cpus that have
> cmpxchg (e.g. later x86).  You can also on machines with load-locked
> and store-conditional instructions (alpha, ppc, probably most other
> RISCs).

	You can also do it with a conditional move instruction, but it's kind of
ugly. No help on a '386 though.

	There are ways to do it that work on a 386, but they are all basically
equivalent to (or worse than) acquiring a spinlock, doing the deed, and then
releasing it.

	You could also do (in pseudo-code):

top:
 ret <- v->counter
 inc ret
 LOCK incl v->counter
 cmp v->counter, ret
 jz end
 LOCK decl v->counter
 jmp top:
end:
 return ret

	This does not strictly guarantee in order return values, but that's
meaningless without a lock anyway.

	DS


