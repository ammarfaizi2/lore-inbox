Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVANQlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVANQlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 11:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVANQl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 11:41:29 -0500
Received: from maxipes.logix.cz ([217.11.251.249]:42428 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S261929AbVANQkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 11:40:49 -0500
Date: Fri, 14 Jan 2005 17:40:39 +0100 (CET)
From: Michal Ludvig <michal@logix.cz>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       cryptoapi@lists.logix.cz, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers
 at a time
In-Reply-To: <1105712446.18687.33.camel@ghanima>
Message-ID: <Pine.LNX.4.61.0501141709250.17481@maxipes.logix.cz>
References: <Xine.LNX.4.44.0411301009560.11945-100000@thoron.boston.redhat.com>
  <Pine.LNX.4.61.0411301722270.4409@maxipes.logix.cz> 
 <20041130222442.7b0f4f67.davem@davemloft.net>  <Pine.LNX.4.61.0412031353120.17402@maxipes.logix.cz>
  <Pine.LNX.4.61.0501111805470.2233@maxipes.logix.cz> 
 <Pine.LNX.4.61.0501141356310.10530@maxipes.logix.cz> <1105712446.18687.33.camel@ghanima>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Fruhwirth Clemens wrote:

> On Fri, 2005-01-14 at 14:10 +0100, Michal Ludvig wrote:
> 
> > This patch extends crypto/cipher.c for offloading the whole chaining modes
> > to e.g. hardware crypto accelerators. It is much faster to let the 
> > hardware do all the chaining if it can do so.
> 
> Is there any connection to Evgeniy Polyakov's acrypto work? It appears,
> that there are two project for one objective. Would be nice to see both
> parties pulling on one string.

These projects do not compete at all. Evgeniy's work is a complete 
replacement for current cryptoapi and brings the asynchronous 
operations at the first place. My patches are simple and straightforward 
extensions to current cryptoapi that enable offloading the chaining to 
hardware where possible.

> > +	void (*cia_ecb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > +			size_t nbytes, int encdec, int inplace);
> > +	void (*cia_cbc)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > +			size_t nbytes, int encdec, int inplace);
> > +	void (*cia_cfb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > +			size_t nbytes, int encdec, int inplace);
> > +	void (*cia_ofb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > +			size_t nbytes, int encdec, int inplace);
> > +	void (*cia_ctr)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > +			size_t nbytes, int encdec, int inplace);
> 
> What's the use of adding mode specific functions to the tfm struct? And
> why do they all have the same function type? For instance, the "iv" or
> "inplace" argument is meaningless for ECB.

The prototypes must be the same in my implementation, because in crypt() 
only a pointer to the appropriate mode function is taken and further used 
as "(func*)(arg, arg, ...)".

BTW these functions are not added to "struct crypto_tfm", but to "struct 
crypto_alg" which describes what a particular module supports (i.e. along 
with the block size, algorithm name, etc). In this case it can say that 
e.g. padlock.ko supports encryption in CBC mode in addition to a common 
single-block processing.

BTW I'll look at the pointers of the tweakable api over the weekend...

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
