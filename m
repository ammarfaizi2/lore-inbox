Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVCHOqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVCHOqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 09:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVCHOqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 09:46:55 -0500
Received: from smtpout.mac.com ([17.250.248.88]:3522 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261363AbVCHOqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 09:46:48 -0500
In-Reply-To: <20050308160747.2ffc842c@zanzibar.2ka.mipt.ru>
References: <11102278521318@2ka.mipt.ru> <1FA9E37C-8F90-11D9-A2CF-000393ACC76E@mac.com> <20050308123714.07d68b90@zanzibar.2ka.mipt.ru> <ACAE2383-8FCC-11D9-A2CF-000393ACC76E@mac.com> <20050308160747.2ffc842c@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DB5F652C-8FE0-11D9-A2CF-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz, David Miller <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       Fruhwirth Clemens <clemens@endorphin.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel 2.6
Date: Tue, 8 Mar 2005 09:46:30 -0500
To: johnpol@2ka.mipt.ru
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 08, 2005, at 08:07, Evgeniy Polyakov wrote:
> On Tue, 8 Mar 2005 07:22:01 -0500 Kyle Moffett <mrmacman_g4@mac.com> 
> wrote:
>> I'm not exactly familiar with asynchronous block device, but I'm
>> guessing that it would need to get its crypto keys from the user
>> somehow, no?  If so, then the best way of managing them is via
>> the key/keyring infrastructure.  From the point of view of other
>> kernel systems, it's basically a set of BLOB<=>task associations
>> that supports a reasonable inheritance and permissions model.
>
> Above setup may be implemeted for the userspace/kernelspace 
> application,
> which requires continuous access to the key material from the both 
> sides,
> but asynchronous block device (and existing cryptoloop and dm-crypt) 
> use
> different model, when controlling userspace application only one time
> provides required key material(using ioctl) and exits, but key material
> remains in kernelspace in device's private area.

The above application works perfectly with the design of the keyring
system.  A process (An init-script or something) creates a "key" either
with a file or through some complex method that only user-space needs to
care about, then it calls the keyctl syscall to create an in-kernel key
with the data BLOB.  The kernel module that registered the key-type (IE:
symmetric128 or something like that) verifies that the data is valid and
attaches it to a key data-structure.

Later, when you want to use the key for acrypto, cryptoloop, dm-crypt, 
etc,
you would just pass the key-ID instead of a custom binary format, and 
the
acrypto layer would just add a reference to the key in its own structure
and increment the refcount.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


