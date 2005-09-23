Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVIWOAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVIWOAa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVIWOAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:00:30 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:23212 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750985AbVIWOA3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:00:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ai5njZYSkeNad12AGQpSMRa+7dBn426p4h0pSESG2eIX4YWnVPfM1ofBqvn32tT/OBirjfKcIYBIH0TUJUYmlrWKPA/yVy+77Wc6pVFd/xflB+0GiM1IxVnOnabYgzQtIrBqQJKBq0qYN1MRp1b59681hZzBeBGB6uJ2P/CIqj0=
Message-ID: <ea86ce2205092307003e8c2d8c@mail.gmail.com>
Date: Fri, 23 Sep 2005 10:00:27 -0400
From: Tim Mattox <tmattox@gmail.com>
Reply-To: Tim Mattox <tmattox@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH 2/3] netfilter : 3 patches to boost ip_tables performance
Cc: Eric Dumazet <dada1@cosmosbay.com>, Harald Welte <laforge@netfilter.org>,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <20050923040234.GC595@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de>
	 <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de>
	 <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com>
	 <4331D168.6090604@cosmosbay.com>
	 <20050922124803.GH26520@sunbeam.de.gnumonks.org>
	 <4332AC2E.8000607@cosmosbay.com>
	 <20050923040234.GC595@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAIK, the usual reason gcc can generate better code when you write
   bool = complex conditional
   if (bool) ...
is because of C's short-circuit conditional evaluation rules for || and &&.  By
moving the complex expression to an assignment statement, you are telling
gcc that it is okay and safe to evaluate every part of the expression.
If gcc was smart about being able to prove that all parts of the complex
expression where safe (no possibly null pointer references) and had no
side effects, then it could generate the same code with
  if (complex conditional) ...

However, there are many situations where even a magical compiler
couldn't prove that there were no possible side effects, etc., and would
have to generate multiple conditional branches to properly meet the
short-circuit conditional evaluation rules for && and ||.

However, in the specific cases in this thread using FWINV without
|| and && operators, an optimizing compiler "should" be smart enough
to generate more linear code for today's heavily pipelined CPUs.
For now, I guess it's still the duty of the programmer to use coding
style to force the compiler to generate more linear machine code.

On 9/23/05, Willy Tarreau <willy@w.ods.org> wrote:
> On Thu, Sep 22, 2005 at 03:05:50PM +0200, Eric Dumazet wrote:
> (...)
> > It was necessary to get the best code with gcc-3.4.4 on i386 and
> > gcc-4.0.1 on x86_64
> >
> > For example :
> >
> > bool1 = FWINV(ret != 0, IPT_INV_VIA_OUT);
> > if (bool1) {
> >
> > gives a better code than :
> >
> > if (FWINV(ret != 0, IPT_INV_VIA_OUT)) {
> >
> > (one less conditional branch)
> >
> > Dont ask me why, it is shocking but true :(
>
> I also noticed many times that gcc's optimization of "if (complex condition)"
> is rather poor and it's often better to put it in a variable before. I even
> remember that if you use an intermediate variable, it can often generate a
> CMOV instruction on processors which support it, while it produces cond tests
> and jumps without the variable. Generally speaking, if you want fast code,
> you have to write it as a long sequence of small instructions, just as if
> you were writing assembly. As you said, shocking but true.
>
> BTW, cheers for your optimizations !
>
> Regards,
> Willy
>
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
Tim Mattox - tmattox@gmail.com
  http://homepage.mac.com/tmattox/
    I'm a bright... http://www.the-brights.net/
