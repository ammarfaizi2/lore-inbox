Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbUBXUcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUBXUcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:32:19 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:62096 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S262445AbUBXUcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:32:12 -0500
Date: Tue, 24 Feb 2004 15:22:23 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040224202223.GA31232@certainkey.com>
References: <20040223214738.GD24799@certainkey.com> <Xine.LNX.4.44.0402231710390.21142-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0402231710390.21142-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 05:11:45PM -0500, James Morris wrote:
> As far as I can tell, you should just be adding a new wrapper interface 
> like HMAC.  Have a look at that code.

OK got the hint. ;)

I'll repeat my recommendation that OMACs be computed at the same time as
encryption/decryption and not in a "two pass" approach like this.  Ideally by
passing two cipher contexts (one for encryption other for MACing) into
functions like cbc_encrypt() - alas I'm too nervous with this API to
implement that.

A Not-So-Ideal compromise would be using the same cipher context and
storing the MAC in a new member of the cipher_tfm struct.  This would require
minimal amount of new code to test and will probably go faster as well.

The two patches are:
 - http://jlcooke.ca/lkml/ctr_and_omac.patch
   (added ctr to cipher.c and omac.c)
   Using the init/update/final interface.
 - http://jlcooke.ca/lkml/ctr_and_omac2.patch
   (added ctr to cipher.c and integrated OMAC into all
   existing modes of operation. If cipher_tfm.cit_omac!=NULL, OMAC is stored
   into cipher_tfm.cit_omac)
   So in other words, current implementations using the CryptoAPI will not see
   performance change and no new .c files.
    No OMAC:
      tfm = crypto_alloc_tfm (algo, CRYPTO_TFM_MODE_CBC);
    With OMAC:
      tfm = crypto_alloc_tfm (algo, CRYPTO_TFM_MODE_CBC | CRYPTO_TFM_MODE_OMAC);
      ...
      crypto_cipher_get_omac(tfm, omac_val, 128/8);
    ** J-L likes this one more! **

Now implementing CCM mode (the final mode of operation specified for use with
AES by NIST) will be my next task.   CCM is an IEEE standard and is going
through the motions of becoming a FIPS standard as well.  Reference:
  http://csrc.nist.gov/publications/drafts/Draft_SP_800-38C_9-04-2003.pdf

It's effectively CTR mode with a CBC MAC at the end of it.  I'll start
implementing it, but we'll hold off until the spec is out of draft.

JLC

ps. Will crypto_cipher_encrypt/crypto_cipher_decrypt *always* be called in
onesies?  I need to perform come final() code on the OMAC before it's
ready to pass test vectors - how do I know when we're done?

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
