Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSJZC3E>; Fri, 25 Oct 2002 22:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbSJZC3E>; Fri, 25 Oct 2002 22:29:04 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:30212 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261829AbSJZC3D>; Fri, 25 Oct 2002 22:29:03 -0400
Date: Sat, 26 Oct 2002 12:35:13 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: linux-kernel@vger.kernel.org
cc: netdev@oss.sgi.com
Subject: Re: The return of the return of crunch time (2.5 merge candidate
 list 1.6) (crypto api info)
In-Reply-To: <200210251557.55202.landley@trommello.org>
Message-ID: <Mutt.LNX.4.44.0210261225020.22775-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2002, Rob Landley wrote:

> 4) New CryptoAPI (James Morris)

This is currently available for review at:

http://samba.org/~jamesm/crypto/

The patch there tracks Dave Miller's tree.

There's not much documentation yet, so here's a brief rundown:

The API takes page vectors (scatterlists) as arguments, and works directly
on pages.  This is required to support a clean IPsec implementation (which
is being worked on by Dave Miller and Alexey Kuznetzov), and is also a
requirement from Linus.  In some cases (e.g. ECB mode ciphers), this will
allow for pages to be encrypted in place with no copying.

At the lowest level are algorithms, which register dynamically with the 
API.

'Transforms' are user-instantiated objects, which maintain state, handle all
of the implementation logic (e.g. manipulating page vectors), provide an 
abstraction to the underlying algorithms, and handle common logical 
operations (e.g. cipher modes, HMAC for digests).  However, at the user 
level they are very simple.

Conceptually, the API layering looks like this:

  [transform api]  (user interface)
  [transform ops]  (per-type logic glue e.g. cipher.c, digest.c)
  [algorithm api]  (for registering algorithms)
  
The idea is to make the user interface and algorithm registration API
very simple, while hiding the core logic from both.  Many good ideas
from existing APIs such as Cryptoapi and Nettle have been adapted for this.

The API currently supports three types of transforms: Ciphers, Digests and
Compressors.  The compression algorithms especially seem to be performing
very well so far.

An asynchronous scheduling interface is in planning but not yet
implemented, as we need to further analyze the requirements of all of
the possible hardware scenarios (e.g. IPsec NIC offload).

Here's an example of how to use the API:

	#include <linux/crypto.h>
	
	struct scatterlist sg[2];
	char result[128];
	struct crypto_tfm *tfm;
	
	tfm = crypto_alloc_tfm(CRYPTO_ALG_MD5);
	if (tfm == NULL)
		fail();
		
	/* ... set up the scatterlists ... */
	
	crypto_digest_init(tfm);
	crypto_digest_update(tfm, &sg, 2);
	crypto_digest_final(tfm, result);
	
	crypto_free_tfm(tfm);

    
Many real examples are available in the regression test module (tcrypt.c).


- James
-- 
James Morris
<jmorris@intercode.com.au>


