Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVCHO6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVCHO6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 09:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVCHO6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 09:58:55 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:50854 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261376AbVCHO6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 09:58:51 -0500
Date: Tue, 8 Mar 2005 18:24:17 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz, David Miller <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel
 2.6
Message-ID: <20050308182417.27984ae1@zanzibar.2ka.mipt.ru>
In-Reply-To: <DB5F652C-8FE0-11D9-A2CF-000393ACC76E@mac.com>
References: <11102278521318@2ka.mipt.ru>
	<1FA9E37C-8F90-11D9-A2CF-000393ACC76E@mac.com>
	<20050308123714.07d68b90@zanzibar.2ka.mipt.ru>
	<ACAE2383-8FCC-11D9-A2CF-000393ACC76E@mac.com>
	<20050308160747.2ffc842c@zanzibar.2ka.mipt.ru>
	<DB5F652C-8FE0-11D9-A2CF-000393ACC76E@mac.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 08 Mar 2005 17:58:15 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 09:46:30 -0500
Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On Mar 08, 2005, at 08:07, Evgeniy Polyakov wrote:
> > On Tue, 8 Mar 2005 07:22:01 -0500 Kyle Moffett <mrmacman_g4@mac.com> 
> > wrote:
> >> I'm not exactly familiar with asynchronous block device, but I'm
> >> guessing that it would need to get its crypto keys from the user
> >> somehow, no?  If so, then the best way of managing them is via
> >> the key/keyring infrastructure.  From the point of view of other
> >> kernel systems, it's basically a set of BLOB<=>task associations
> >> that supports a reasonable inheritance and permissions model.
> >
> > Above setup may be implemeted for the userspace/kernelspace 
> > application,
> > which requires continuous access to the key material from the both 
> > sides,
> > but asynchronous block device (and existing cryptoloop and dm-crypt) 
> > use
> > different model, when controlling userspace application only one time
> > provides required key material(using ioctl) and exits, but key material
> > remains in kernelspace in device's private area.
> 
> The above application works perfectly with the design of the keyring
> system.  A process (An init-script or something) creates a "key" either
> with a file or through some complex method that only user-space needs to
> care about, then it calls the keyctl syscall to create an in-kernel key
> with the data BLOB.  The kernel module that registered the key-type (IE:
> symmetric128 or something like that) verifies that the data is valid and
> attaches it to a key data-structure.
> 
> Later, when you want to use the key for acrypto, cryptoloop, dm-crypt, 
> etc,
> you would just pass the key-ID instead of a custom binary format, and 
> the
> acrypto layer would just add a reference to the key in its own structure
> and increment the refcount.

Acrypto does not actually know about keys, ivs and other.
It is layer between crypto devices(which require key) and crypto consumers
(which provide the key).
One may fill key and iv sg as NULL and put them to the private area, 
and then create approprite crypto device, which will obtain them from there,
but not using key/iv sgs.
Acrypto do not use such information.

Of course, one may patch bd_acrypto.c/cryptoloop.c/dm_crypt.c 
to use above schema, but it is too complex for the model used,
but nevertheless it can be used, I do not disput against it 
in bd_acrypto/cryptoloop/dm_crypt.
 
> Cheers,
> Kyle Moffett
> 
> -----BEGIN GEEK CODE BLOCK-----
> Version: 3.12
> GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
> L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
> PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
> !y?(-)
> ------END GEEK CODE BLOCK------
> 


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
