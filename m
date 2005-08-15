Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVHOIVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVHOIVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 04:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVHOIVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 04:21:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4267 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932082AbVHOIVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 04:21:13 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [-mm patch] make kcalloc() a static inline
Date: Mon, 15 Aug 2005 11:20:46 +0300
User-Agent: KMail/1.5.4
Cc: Adrian Bunk <bunk@stusta.de>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050808223842.GM4006@stusta.de> <200508151106.05973.vda@ilport.com.ua> <1124093660.3228.14.camel@laptopd505.fenrus.org>
In-Reply-To: <1124093660.3228.14.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151120.46186.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 August 2005 11:14, Arjan van de Ven wrote:
> On Mon, 2005-08-15 at 11:06 +0300, Denis Vlasenko wrote:
> 
> > > +static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
> > > +{
> > > +	if (n != 0 && size > INT_MAX / n)
> > > +		return NULL;
> > > +	return kzalloc(n * size, flags);
> > > +}
> 
> > Can you conditionalize it on __builtin_constant_p(n) ?
> > Otherwise with variable n you have 3 oprations in inlined
> > code, one of them a division.
> 
> you can't conditionalize the security check really. If it's constant,
> gcc will optimize it anyway, and if it's not constant you for sure want
> the check there...

Sure, I don't want to disable the check. I want that check to be
in _non-inlined function_.

static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
{
	if (__builtin_constant_p(n)) {
		if (n != 0 && size > INT_MAX / n)
			return NULL;
		return kzalloc(n * size, flags);
	}
	return kcalloc_helper(n, size, flags);
}

void *kcalloc_helper(size_t n, size_t size, unsigned int __nocast flags)
{
	if (n != 0 && size > INT_MAX / n)
		return NULL;
	return kzalloc(n * size, flags);
}
--
vda

