Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbTBFOki>; Thu, 6 Feb 2003 09:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267319AbTBFOkh>; Thu, 6 Feb 2003 09:40:37 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:15111 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267315AbTBFOkh>; Thu, 6 Feb 2003 09:40:37 -0500
Date: Thu, 6 Feb 2003 17:49:44 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: add framework for ndelay (nanoseconds)
Message-ID: <20030206174944.A17905@jurassic.park.msu.ru>
References: <200302040533.h145Xqq19457@hera.kernel.org> <Pine.GSO.4.21.0302051533320.16681-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0302051533320.16681-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Wed, Feb 05, 2003 at 03:34:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 03:34:31PM +0100, Geert Uytterhoeven wrote:
> On Sun, 2 Feb 2003, Linux Kernel Mailing List wrote:
> > ChangeSet 1.953.4.9, 2003/02/02 02:44:15-02:00, alan@lxorguk.ukuu.org.uk
> > 
> > 	[PATCH] PATCH: add framework for ndelay (nanoseconds)
> > 	
> > +void __ndelay(unsigned long usecs)
>                                ^^^^^
> > +{
> > +	__const_udelay(usecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
>                        ^^^^^
> > +}
> 
> Wouldn't it make more sense to call the parameter `nsecs' (or `ns')?

There are more serious problems with this implementation:
1) It's *very* imprecise. Even on an 1 GHz CPU and with HZ = 100 precision
   is ~86 nsec. With HZ = 1000 it's almost unusable on *any* CPU.
2) Additional delay caused by integer multiplication, cache misses
   and so on may be large enough, especially on older processors.
   On 233 MHz PII it's 600-700 nsec (perfectly repeatable), on 600 MHz
   alpha ev56 - 200-300 nsec.

As of current 2.4, there is the only user of ndelay() - ide_execute_command()
that calls ndelay(400). Why udelay(1) cannot be used instead?

Ivan.
