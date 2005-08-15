Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVHOI3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVHOI3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 04:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVHOI3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 04:29:07 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63434 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932249AbVHOI3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 04:29:06 -0400
Date: Mon, 15 Aug 2005 11:28:41 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] make kcalloc() a static inline
In-Reply-To: <200508151120.46186.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.58.0508151126570.26955@sbz-30.cs.Helsinki.FI>
References: <20050808223842.GM4006@stusta.de> <200508151106.05973.vda@ilport.com.ua>
 <1124093660.3228.14.camel@laptopd505.fenrus.org> <200508151120.46186.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005, Denis Vlasenko wrote:
> Sure, I don't want to disable the check. I want that check to be
> in _non-inlined function_.
> 
> static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
> {
> 	if (__builtin_constant_p(n)) {
> 		if (n != 0 && size > INT_MAX / n)
> 			return NULL;
> 		return kzalloc(n * size, flags);
> 	}
> 	return kcalloc_helper(n, size, flags);
> }
> 
> void *kcalloc_helper(size_t n, size_t size, unsigned int __nocast flags)
> {
> 	if (n != 0 && size > INT_MAX / n)
> 		return NULL;
> 	return kzalloc(n * size, flags);
> }

That's extra complexity and code duplication. How much do we shave off 
kernel text of allyesconfig with this?

Please note that whenever the caller does proper bounds checking, GCC can 
optimize the security check away. Therefore, in practice, we don't spread 
around the extra operations so much, I think.

			Pekka
