Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266090AbUFPC40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266090AbUFPC40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUFPCxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:53:45 -0400
Received: from web41104.mail.yahoo.com ([66.218.93.20]:49691 "HELO
	web41104.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266090AbUFPCw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:52:58 -0400
Message-ID: <20040616025255.40151.qmail@web41104.mail.yahoo.com>
Date: Tue, 15 Jun 2004 19:52:55 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: RSA
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040616020441.GA12610@escher.cs.wm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > In essence for a digsig module you'll require the ability to 
> > 
> > 1.  import a PK key [from a binary packet or a cert, preferably the
> > former].
> 
> Parsing a certificate into precisely the format needed by cryptoapi
> will be a task for user-space.  At least that was our plan. 
> Cryptoapi
> can check for validity and return -EINVAL if there's a problem, but
> shouldn't have to do any complicated parsing.

Sounds reasonable.  Though it would be cooler if the module handled
making/export/import of the key.  Nice and self-contained ;-)

> > 2.  free a PK key from memory (no need to waste dynamic resources
> like
> > bignums while not being used).
> > 3.  ability to sign/verify/encrypt/decrypt which amounts to a
> exptmod
> > and PKCS #1 [v2.0 preferably] padding.
> 
> where
> 	sign = private_encrypt (setkey(privkey); encrypt();)
> 	verify = public_decrypt (setkey(pubkey); decrypt();)
> 	encrypt = public_encrypt (setkey(pubkey); encrypt();)
> 	decrypt = private_decrypt (setkey_privkey(); decrypt();)
> so thus far the cipher tfm and algs suffice.

With the remark that you still have to apply/remove_and_check padding 
to/from the packets.  

> > An API exactly mirroring the symmetric side won't really work 100%.
> 
> > For instance, symmetric operations are not likely to fail [I don't
> know
> > how error handling is performed].  Also decrypt/verify ops may fail
> > hard [due to lack of heap] or soft [invalid packet].
> >
> > It would probably make more sense to design a simple API for PK
> crypto
> > [say support RSA/ECC/DH/DSA ;-)] then to mash the symmetric crypto
> API
> > into something compatible.
> 
> Wow.  Death due to a lack of heap was not something I had considered.
> 
> So, since the include/linux/crypto.h:cipher_alg struct's encrypt and
> decrypt
> functions return void, we may need to create a assymetric_alg struct
> whose
> functions can return an error.

Trust me.  I am most wise in the ways of crypto coding :).

For the most part my LTC [and indirectly LibTomMath] routines are lean
on the heap.  I haven't checked [recently] but I'm sure a RSA-1024
exptmod, for instance, requires around 6K of heap [shouldn't be more
than 8K]. Most of that is taken by the RSA's CRT params and the
exptmod's sliding window.

Definitely not a heavy operation but you have to trap errors obviously.

Tom


		
__________________________________
Do you Yahoo!?
Read only the mail you want - Yahoo! Mail SpamGuard.
http://promotions.yahoo.com/new_mail 
