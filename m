Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUCIDkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 22:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUCIDkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 22:40:23 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:55680
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S261472AbUCIDkS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 22:40:18 -0500
Date: Mon, 8 Mar 2004 19:37:58 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
Message-ID: <20040309033758.GA3738@jm.kir.nu>
References: <20040306184623.GB3963@jm.kir.nu> <Xine.LNX.4.44.0403080935310.22156-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0403080935310.22156-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 09:45:39AM -0500, James Morris wrote:

> On Sat, 6 Mar 2004, Jouni Malinen wrote:
> > One straightforward way of adding support for Michael MIC is to add an
> > optional setkey operation for digest algorithms. The included patch
> > (against Linux 2.6.4-rc2) does exactly this and also includes an
> > implementation of Michael MIC. Another option would be to add a new
> > algorithm type for keyed hash algorithms, but that seemed unnecessary
> > for this purpose.

> I think it would be better to do the latter, add another mode for 
> simple keyed digest processing (KMAC?), where a function called something 
> like kmac_init() takes the tfm/key/kelen paramters.  The kmac_update() and
> kmac_final() methods are just wrappers around the digest methods, and we 
> also kmac_kmac() similar to the HMAC method.

Hmm.. HMAC can do this easily, since that construction uses plain digest
functions and just hashes the key with them. Michael MIC initializes
some of the internal state (L and R in the implementation) with the key.
This would mean that the kmac_init() would need to know something about
the used digest algorithm or we would need to have setkey handler for
the digests (which is actually the way I implemented Michael MIC in the
original patch).

crypto_kmac() can be implemented, if that is considered useful wrapper
for Michael MIC. However, I'm not sure whether the other part of this
would work very well with Michael MIC. In addition, I'm not sure whether
there would be another algorithm using this new keyed has method. HMAC
and CBC-MAC (which, btw, is also on my list of crypto API things to do
for IEEE 802.11i) are using more generic mechanism and can be used with
multiple algorithms and are probably prefered for anything that requires
real security.

If you prefer, I can make a new type crypto alg type
(CRYPTO_ALG_TYPE_KEYED_DIGEST) and make it a clone of the
CRYPTO_ALG_TYPE_DIGEST with the only change of adding a new callback,
setkey, in the way I added in the patch for CRYPTO_ALG_TYPE_DIGEST. This
would leave the digest type unmodified, but would result in copying most
of the digest code. I do not see much benefit of this because the
dia_setkey function pointer does not seem to change the old digest
functionality at all since it is optional and since this function
pointer does not even enlarge struct crypto_alg due to the cra_u union
already being a bit larger than the current struct digest_alg.


> Is there an 802.11i spec available?  It seems like there are only drafts 
> available which require payment.  I'd like to see the Micheal MIC 
> algorithm description & know of any potential IP rights issues.

IEEE 802.11i draft is not freely available. The finalized standard is
likely to become freely available six month after its publications (I
would guess this would be about early 2005 or so). However, the proposal
for Michael MIC is available from
http://grouper.ieee.org/groups/802/11/Documents/DocumentHolder/2-020.zip.
This includes full description of the algorithm, analysis of it and
reasoning for the compromises needed for TKIP. I haven't verified, but I
would assume that this matches with the algorithm as defined in the
current IEEE 802.11i draft.

As far as IP rights (I would assume you mean patents, in this case) are
concerned, IEEE has a policy* of requiring a statement about potential
patent application on the algorithms used in the standards. I do not
remember seeing such a statement about Michael MIC (of course this does
not mean that there is not one, but at least I haven't seen one) and
could not find such a statement in the IEEE 802.11 patent statements**.
In addition, the author of Michael MIC proposal has put the reference
implementation code in the public domain.

*) http://standards.ieee.org/guides/bylaws/sect6-7.html#6
**) http://standards.ieee.org/db/patents/pat802_11.html


> Also, is there any mainline kernel code which would use this feature?

Well, the main goal for me here is to get Host AP driver in shape for
mainline inclusion.. ;-)

The only use for Michael MIC seems to be in implementing TKIP since it
is not very secure (due to compromises needed to support old legacy wlan
hardware). This is needed for wireless LAN cards that cannot or at least
do not implement TKIP in hardware/firmware. It may also be useful, if
the hardware implementation does not support all needed modes (e.g., AP)
or is considered too slow. Some of the current IEEE 802.11b drivers in
the mainline kernel would be likely canditates for using this when
WPA/IEEE 802.11i support is added.

-- 
Jouni Malinen                                            PGP id EFC895FA
