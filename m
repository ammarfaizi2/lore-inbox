Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUBWNyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUBWNyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:54:01 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:25996 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261866AbUBWNxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:53:46 -0500
Date: Mon, 23 Feb 2004 08:44:03 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Fruhwirth Clemens <clemens-dated-1078360505.b6b1@endorphin.org>
Cc: Christophe Saout <christophe@saout.de>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040223134403.GA22682@certainkey.com>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040223003504.GA15110@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223003504.GA15110@ghanima.endorphin.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 01:35:04AM +0100, Fruhwirth Clemens wrote:
> No obvious flaws for me. I've already argued in private different IV mode,
> but one more time for the public ;) : I embraced the principal of reusing
> components in security systems instead of depending on a large number on
> different subsystems. The only IV mode which can finally make sence for me
> is the use of cipher algorithm as hash algorithm. This will keep the risk of
> breakage of the system by the insecurity of one component to a minimum. A
> pratical reason for using one algorithm is that just one algorithm has to be
> optimized (f.e. assembler optimized or hardware offloading). I'd like to
> submit a patch for this as soon as dm-crypt is merged. Andrew: any ideas if
> this will happen soon?

Using a block cipher as a hash algorithm isn't nessesarily more secure.  The
"less moving parts" argument is quickly pushed aside by the "round peg in a
round hole" argument.

SHA-1/SHA-256/384/512 were *designed* to be message digests.  AES was not (as
a requirement anyways).

I have a CTR mode patch ready for crypto/cipher.c.  I would like to implement
OMAC (the 6th AES approved mode of opereation) before giving the patch, but
you can't use OMAC the way you use ECB/CBC/CTR mode.

The analogy of:

for (i=0; i<len; i++)
  omac_encrypt(tfm, dst[i], src[i], nbytes);

Will not work with OMAC since it creates a MAC and not a ciphertext stream
like the other modes.

for (i=0; i<len; i++)
  omac_encrypt(tfm, dst[0], src[i], nbytes);
/*                      ^ see here!           */
memcpy(mac, dest, ...); /* store the mac */

Is more appropriate.  James - is this possible?

> > At least the "cryptoloop-exploit" Jari Ruusu posted doesn't work anymore.

Oooh, Jari.

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
