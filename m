Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWGFEsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWGFEsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 00:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWGFEsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 00:48:43 -0400
Received: from science.horizon.com ([192.35.100.1]:43332 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965165AbWGFEsn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 00:48:43 -0400
Date: 6 Jul 2006 00:48:38 -0400
Message-ID: <20060706044838.30651.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The very cheap readers all appear to be fairly crude image scanners, and
> they even lack hardware encryption/perturbation so they are actually of
> very limited value.

I utterly fail to see why multiple, generally knowledgeable people are
claiming that encryption in a fingerprint scanner is desirable.

As far as I can tell, the only thing you want is AUTHENTICATION - you
want proof that you are getting a "live" scan taken from a user
who's present, and not a replay of what was sent last week.

This is called "freshness" and is usually provided by including a
random "nonce" (known in other contexts as "magic cookie") in the
authenticated data.

That is,

1) Computer generates random nonce and sends to fingerprint reader
   as part of the "please scan" command.

2) Fingerprint reader scans the image, and hashes it along with the nonce.

3) Fingerprint reader sends the (unencrypted) scan back to the computer.

4) Fingerprint reader computes a digital signature of the hash computed
   in step 2, and sends it to the computer.

5) Computer verifies the signature, thereby proving that the reader
   read the fingerprint after receiving the nonce (or has been
   compromised internally).

To do it right, I'd have a per-reader signing key, signed by a vendor
model key, signed by a top-level vendor public key that's widely
published.  These signatures and the public keys they sign can be stored
in ROM.

Also note that, if using DSA, the raw fingerprint reader's data, hashed
with the device private key and nonce, will make an excellent seed
to generate the per-signature random nonce K.  It is a security disaster
if you make two signatures on different data with the same K, but by
combining some secret information and all of the input used to generate
the hash value, you guarantee that that will only happen if the data
signed is the same, in which case it's harmless.

Put another way, given the hash H to sign and the private key X,
you can let K = SHA(H,X).  (You can also hash in other data, but H and
X are available and sufficient.)


If you don't have the signature verification information, you can still
use the device, you just can't be sure you aren't experiencing a replay
attack.

Encryption is useless, as is authentication without a host-provided
nonce or other means of guaranteeing freshness.  You can just sniff
and replay.  I'm sure keyghost.com would be happy to sell you the
necessary hardware.

Not that I expect "A-1 Computer Corporation" in Shenzhen to have a clue
about these things, but you'd think that Microsoft would have one or
two competent employees left on the payroll.
