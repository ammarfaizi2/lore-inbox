Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424444AbWKJWQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424444AbWKJWQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424446AbWKJWQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:16:45 -0500
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:11602 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1424447AbWKJWQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:16:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=RHSPO+9SqCf2HBwGX2Y6i3qZ/Kzt0S28shMmU+9cLqjCPug85mtZ0sW2js0k+MLxCMUFkAm8JYLnoz8V+b06pnLnQVysbrxbinT+m2xiN+KUgwuHE1Df3egtb2BbhwfkFutOQdj79KeezUhCX+1oJl8r9mIHVlcx4PZC7qz0nlU=  ;
X-YMail-OSG: VWMIzDgVM1meZrniuhd3eI3VV_HSCscCx4PbTHjEgRGJLns.OtCF_WTudLSLciH3.w_TfdkTxXFNhhmAkmaEoiXSPzORXj3eQdhsnXMSUeVUpKYaOio-
From: Blaisorblade <blaisorblade@yahoo.it>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] Make x86_64 udelay() round up instead of down.
Date: Fri, 10 Nov 2006 23:16:19 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
References: <20061029200702.26757.12496.stgit@americanbeauty.home.lan> <20061101163043.GA2602@elf.ucw.cz>
In-Reply-To: <20061101163043.GA2602@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611102316.19545.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel!

On Wednesday 01 November 2006 17:30, Pavel Machek wrote:
> Hi!
>
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Port two patches from i386 to x86_64 delay.c to make sure all rounding is
> > done upward instead of downward.
> >
> > There is no sign in commit messages that the mismatch was done on
> > purpose, and "delay() guarantees sleeping at least for the specified
> > time" is still a valid rule IMHO.
> >
> > diff --git a/arch/x86_64/lib/delay.c b/arch/x86_64/lib/delay.c
> > index 50be909..7514df0 100644
> > --- a/arch/x86_64/lib/delay.c
> > +++ b/arch/x86_64/lib/delay.c
> > @@ -40,13 +40,13 @@ EXPORT_SYMBOL(__delay);
> >
> >  inline void __const_udelay(unsigned long xloops)
> >  {
> > -	__delay((xloops * HZ *
> > cpu_data[raw_smp_processor_id()].loops_per_jiffy) >> 32);
> > +	__delay((xloops * HZ *
> > cpu_data[raw_smp_processor_id()].loops_per_jiffy) >> 32 + 1);

Btw, that's read as >> (32 + 1). My fault.
> Well, if this should be *rounding* up, you should do
>
> (xloops * HZ * cpu_data[raw_smp_processor_id()].loops_per_jiffy +
> 0xffffffff) >> 32

Indeed, I did it so following i386 code (where fixing this is awkward - doable 
with carry sums or 64-bit sums), but it's better this way.

I'd slightly prefer (for readability) (xloops * HZ * 
cpu_data[raw_smp_processor_id()].loops_per_jiffy +
(1<<32)-1) >> 32, or even

DIV_ROUND_UP(xloops * HZ * cpu_data[raw_smp_processor_id()].loops_per_jiffy, 1 
<< 32)

but kernel.h macros such as that seem to be underused (everything reimplements 
them as min() and max() before 2.6) and should be made more consistent in 
naming:

#define ALIGN(x,a) (((x)+(a)-1UL)&~((a)-1UL))
#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
#define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))

I hope that gcc optimizes well x / (1<<32) to x >> 32, but without assurance I 
won't use DIV_ROUND_UP in timer code.

 (I also thought there was a bug, so I had a deep look and the difference 
between -1 in roundup and -1UL is correct due to sign extension ruining 
bitmasks, even if it seemed a bad mismatch).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
