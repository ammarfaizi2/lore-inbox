Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136764AbRECLQ1>; Thu, 3 May 2001 07:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136753AbRECLQS>; Thu, 3 May 2001 07:16:18 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:17673 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S136764AbRECLQH>;
	Thu, 3 May 2001 07:16:07 -0400
Date: Thu, 3 May 2001 04:08:48 -0700
From: Anton Blanchard <anton@samba.org>
To: mike_phillips@urscorp.com
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
Message-ID: <20010503040848.Q20471@va.samba.org>
In-Reply-To: <OFA57C1906.E60183EB-ON85256A40.00425F2E@urscorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFA57C1906.E60183EB-ON85256A40.00425F2E@urscorp.com>; from mike_phillips@urscorp.com on Wed, May 02, 2001 at 09:12:41AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This is where the multiple support issue comes in. In ibmtr_cs.c we do 
> ioremap the addresses so pcmcia all works nicely. What we don't do at 
> present is an ioremap in ibmtr.c for the non-pcmcia adapters (isa & mca). 
> So, I suppose the real fix would be to implement the ioremap in ibmtr.c so 
> that regular read/writes can be used everywhere in the driver. (This is 
> half the battle with changes to the driver, it supports so many 
> combinations that one change for one type of adapter can kill support for 
> another adapter, and that's my bottom line with updates: No loss of 
> functionality we already had.)

Yes since we ioremap both regions in ibmtr_cs.c and pass the cookies into 
ibmtr.c we should be using read*/write*. With the simple fix to do this
and use the non byteswapping versions of read*/write* the token ring
pcmcia driver works fine on a titanium powerbook.

My suggestion is to throw this into ibmtr.h:

#ifdef PCMCIA
#define tr_readb(addr)		readb(addr)
#define tr_readw(addr)		__raw_readw(addr)
#define tr_readl(addr)		__raw_readl(addr)
#define tr_writeb(val, addr)	writeb(val, addr)
#define tr_writel(val, addr)	__raw_writel(val, addr)
#define tr_writew(val, addr)	__raw_writew(val, addr)
#else
#define tr_readb(addr)		isa_readb(addr)
#define tr_readw(addr)		isa_readw(addr)
#define tr_readl(addr)		isa_readl(addr)
#define tr_writeb(val, addr)	isa_writeb(val, addr)
#define tr_writel(val, addr)	isa_writel(val, addr)
#define tr_writew(val, addr)	isa_writew(val, addr)
#endif

Anton
