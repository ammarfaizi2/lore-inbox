Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265104AbUELPZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265104AbUELPZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 11:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbUELPZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 11:25:23 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:2693 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S265104AbUELPZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 11:25:19 -0400
Date: Wed, 12 May 2004 17:25:18 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
In-Reply-To: <Xine.LNX.4.44.0405121046250.11214-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.53.0405121707280.32352@maxipes.logix.cz>
References: <Xine.LNX.4.44.0405121046250.11214-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, James Morris wrote:

> On Wed, 12 May 2004, Michal Ludvig wrote:
>
> > In fact I believe that the hardware-specific drivers (e.g. the S/390 one)
> > should be used in the cryptoapi as well and then the kernel should provide
> > a single, universal device with read/write/ioctl calls for all of them.
> > Not making a separete device for every piece of hardware on the market.
> > Am I wrong?
>
> Providing a userspace API is an orthogonal issue, and really needs to be
> designed in conjunction with the async hardware API.
>
> What I am suggesting is that you simply implement something like
> des_z990.c so that C3 users can load crypto alg modules which use their
> hardware.

Sorry, I overlooked that one as I was using the 2.6.5 source.

If I'd do it the same way and only implement .cia_encrypt/.cia_decrypt
functions I wouldn't gain too much from the PadLock. The great thing is
that it can encrypt/decrypt the whole block of data (e.g. the whole disk
sector, 512B) at once using a selected mode (ECB, CBC, ...). With
.cia_encrypt/.cia_decrypt the block chaining is done in software and the
hardware is only called for encryption of a single block (e.g. 16B in case
of AES) at a time. This is a big overhead and throws away most of the
PadLock potential.

That's why I added .cia_ecb/.cia_cbc/... and modified cipher.c to call
these whole-block-at-once methods instead of doing
software-chaining+hardware-encryption. This way it's much much faster and
I don't think that the changes to the cipher.c are somehow unclean.

Or can I achieve the same without extending the API?

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
