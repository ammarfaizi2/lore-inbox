Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUBYNwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUBYNwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:52:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21653 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261329AbUBYNwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:52:14 -0500
Date: Wed, 25 Feb 2004 08:52:36 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
In-Reply-To: <20040224224451.GB32286@certainkey.com>
Message-ID: <Xine.LNX.4.44.0402250847220.28934-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Jean-Luc Cooke wrote:

> On Tue, Feb 24, 2004 at 05:17:12PM -0500, James Morris wrote:
> > On Tue, 24 Feb 2004, Jean-Luc Cooke wrote:
> > 
> > > The two patches are:
> > >  - http://jlcooke.ca/lkml/ctr_and_omac.patch
> > >    (added ctr to cipher.c and omac.c)
> > >    Using the init/update/final interface.
> > >  - http://jlcooke.ca/lkml/ctr_and_omac2.patch
> > >    (added ctr to cipher.c and integrated OMAC into all
> > >    existing modes of operation. If cipher_tfm.cit_omac!=NULL, OMAC is stored
> > >    into cipher_tfm.cit_omac)
> > 
> > Looks good so far, although the duplicated scatterwalk code needs to be 
> > put into a separate file (e.g. scatterwalk.c).
> 
> OK.  So which patch do you want?  :)  The omac.c with scatterwalk, or the
> cipher.c with omac performed in-place when needed?

I think the latter is preferrable.  OMAC should probably be a config 
option as well.

> 
> > > ps. Will crypto_cipher_encrypt/crypto_cipher_decrypt *always* be called in
> > > onesies?  I need to perform come final() code on the OMAC before it's
> > > ready to pass test vectors - how do I know when we're done?
> > 
> > I don't understand what you mean here.
> 
> finish_omac() needs to be called once all data is processed.  How do I know
> for sure the caller is done with this cipher context instance?
> 
> For example:
>   loop {
>     /* get more data into sgin */
>     crypto_cipher_encrypt(tfm, sgout, sgin, len);
>     /* send our data out of sgout */
>   }
>   /* get the 128bit OMAC and send it since we're done with all our encryption */
> 
> And decryption:
>   loop {
>     /* get more data into sgin */
>     crypto_cipher_decrypt(tfm, sgout, sgin, len);
>     /* send our data out of sgout */
>   }
>   /* get the 128bit OMAC and compare it with transmitted OMAC since we're done
>      with all our decryption */
> 
> There is no explicit/implicit "crypto_cipher_encrypt_final()" to inform the
> API to finalise the OMAC.

You could add something like crypto_cipher_omac_final(), to be used by the 
calling code once it needs the OMAC value, which then calls 
crypto_cipher_get_omac().


- James
-- 
James Morris
<jmorris@redhat.com>


