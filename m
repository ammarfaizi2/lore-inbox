Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVCaOCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVCaOCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVCaOCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:02:31 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:33248 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S261459AbVCaOAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:00:12 -0500
Date: Thu, 31 Mar 2005 08:58:22 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: David McCullough <davidm@snapgear.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, johnpol@2ka.mipt.ru,
       Andrew Morton <akpm@osdl.org>, herbert@gondor.apana.org.au,
       jmorris@redhat.com, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz
Subject: Re: [PATCH] API for TRNG (2.6.11) [Fortuna]
Message-ID: <20050331135822.GR24697@certainkey.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <1111666903.23532.95.camel@uganda> <42432596.2090709@pobox.com> <1111724759.23532.121.camel@uganda> <42439781.4080007@pobox.com> <20050331035214.GA12181@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331035214.GA12181@beast>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 01:52:14PM +1000, David McCullough wrote:
> 
> Jivin Jeff Garzik lays it down ...
> ...
> > >If kernelspace can assist and driver _knows_ in advance that data
> > >produced is cryptographically strong, why not allow it directly
> > >access pools?
> > 
> > A kernel driver cannot know in advance that the data from a hardware RNG 
> > is truly random, unless the data itself is 100% validated beforehand.
> 
> You can also say that it cannot know that data written to /dev/random
> is truly random unless it is also validated ?
> 
> For argument you could just run "cat < /dev/hwrandom > /dev/random"
> instead of using rngd.
> 
> If /dev/random demands a level of randomness,  shouldn't it enforce it ?
> 
> If the HW is using 2 random sources, a non-linear mixer and a FIPS140
> post processor before handing you a random number it would be nice to
> take advantage of that IMO.


For those who are interested, my Fortuna patch to the Linux RNG (/dev/random,
/dev/urandom) is available here (2.6.12-rc1, works on kernels as low as
2.6.11.4):
  http://jlcooke.ca/random/

Fortuna is a Cryptographically Secure Random Number Generator (CSRNG)
developed by Neils Ferguson and Bruce Schnier and published in their book
Applied Cryptography.

By most regards, it is the state of the art as far as software based CSRNGs
go.  The website gives an over view of the design, here is a summary:
  Fortuna uses a block cipher (AES128) in CTR mode to generate output.
  Fortuna uses a 32 hash states (SHA-256) which collect event data from
  sources of randomness (as usual in Linux).
  Once every 0.1sec or so, some of the hash states are finalised and the
  digests are collected.
  These digests are hashed together with with the current block cipher key to
  produce the new block cipher key.

Ferguson goes into detail in Practical Cryptography as to why this design is
superior to Yarrow based RNG (like the existing Linux RNG) and also delves
into why entropy estimation is impossible and is infact a liability in RNG
design.

My patch keep the entropy estimation from the current Linux RNG since this is
a very controversial issue with most people.  Disabling entropy estimation
and /dev/random blocking can be done by changing the RANDOM_NO_ENTROPY_COUNT
macro to 1.

I have not tested the syncookie code yet.  But networking works smoothly
after I echo "1" to /proc/sys/net/ipv4/tcp_syncookies.  Any help on this
would be great.

JLC
