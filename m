Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbUBXWyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbUBXWyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:54:44 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:25489 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S262519AbUBXWyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:54:39 -0500
Date: Tue, 24 Feb 2004 17:44:51 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040224224451.GB32286@certainkey.com>
References: <20040224202223.GA31232@certainkey.com> <Xine.LNX.4.44.0402241713220.26251-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0402241713220.26251-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 05:17:12PM -0500, James Morris wrote:
> On Tue, 24 Feb 2004, Jean-Luc Cooke wrote:
> 
> > The two patches are:
> >  - http://jlcooke.ca/lkml/ctr_and_omac.patch
> >    (added ctr to cipher.c and omac.c)
> >    Using the init/update/final interface.
> >  - http://jlcooke.ca/lkml/ctr_and_omac2.patch
> >    (added ctr to cipher.c and integrated OMAC into all
> >    existing modes of operation. If cipher_tfm.cit_omac!=NULL, OMAC is stored
> >    into cipher_tfm.cit_omac)
> 
> Looks good so far, although the duplicated scatterwalk code needs to be 
> put into a separate file (e.g. scatterwalk.c).

OK.  So which patch do you want?  :)  The omac.c with scatterwalk, or the
cipher.c with omac performed in-place when needed?

> > ps. Will crypto_cipher_encrypt/crypto_cipher_decrypt *always* be called in
> > onesies?  I need to perform come final() code on the OMAC before it's
> > ready to pass test vectors - how do I know when we're done?
> 
> I don't understand what you mean here.

finish_omac() needs to be called once all data is processed.  How do I know
for sure the caller is done with this cipher context instance?

For example:
  loop {
    /* get more data into sgin */
    crypto_cipher_encrypt(tfm, sgout, sgin, len);
    /* send our data out of sgout */
  }
  /* get the 128bit OMAC and send it since we're done with all our encryption */

And decryption:
  loop {
    /* get more data into sgin */
    crypto_cipher_decrypt(tfm, sgout, sgin, len);
    /* send our data out of sgout */
  }
  /* get the 128bit OMAC and compare it with transmitted OMAC since we're done
     with all our decryption */

There is no explicit/implicit "crypto_cipher_encrypt_final()" to inform the
API to finalise the OMAC.

> Thanks for all this work!

Gladly.  Makes the beer at the pub go down with less guilt when I can say my
name has appear in one more kernel source file.  :)

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
