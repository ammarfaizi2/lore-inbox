Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWEEQII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWEEQII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWEEQII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:08:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:65499 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750818AbWEEQIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:08:05 -0400
Date: Fri, 5 May 2006 11:08:06 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/12: eCryptfs] eCryptfs version 0.1.6
Message-ID: <20060505160806.GA18079@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060504031755.GA28257@hellewell.homeip.net> <445B1561.1020703@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <445B1561.1020703@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2006 at 12:05:37PM +0300, Alon Bar-Lev wrote:
> I think that current security and encryption solutions that come out
> these days without a proper smart card support create a false sense
> of security for users. So solutions should first be designed so that
> a smart card can be used, and only then provide a passphrase
> alternative.

As detailed in my OLS papers, the whole purpose of eCryptfs, in the
long run, is to provide a means for users to get away from having to
use passphrases alone to protect their data.

> This is the first time I've looked on the user mode keyutils, and it
> looks quite good. I think that the eCryptfs should use it more
> ?correctly? so that keys stored on smart card may be used.

The 0.1 release of eCryptfs provides passphrase-only support in order
to minimize the code complexity for the initial adoption into the
Linux kernel. As you have noticed, the framework is easily extensible
to provide more advanced key management features. We are nearly
finished with the 0.2 release design document, and we have a team
scheduled to work on the more advanced key management features this
summer.

> For PKCS#11 the providers listed in the conf file, key may
> be stored as a data object, and data may be:
> 	cipher:slot-type:slot:application:label:PIN
> 	Where:
> 		slot-type
> 			slot	- slot id
> 			name	- slot name
> 			label	- token label
>=20
> 	?Calling without a PIN may allow prompt for dialog
> 	via a named pipe to a running daemon by uid?

I have been the maintainer of the openCryptoki package (an Open Source
PKCS#11 implementation) for the last year; utilization of openCryptoki
is one of the things we have in mind for eCryptfs. Our design for the
0.2 release includes an interface for allowing keys to be managed via
various services, implemented by plugins. For instance, a one plugin
could link against libopencryptoki.so and use PKCS#11 tokens to manage
the keys. Another plugin could link against libgpgme.so and use GnuPG
to manage the keys. Another plugin could link against libssl.so and
use direct OpenSSL crypto calls to manage the keys. Another plugin
could link against libtspi.so and use a TPM module to manage the keys.

Packets in the header of each file will be processed with specific
modules (identifiers for these modules and the keys in the modules
will be in the header). We have plans to implement userspace
components to accomplish all of this at file open:=20

 - Kernel eCryptfs module reads the encrypted file encryption key and
   the module/key identifier from the header.

 - Kernel module sends a message to a userspace daemon (question: is
   netlink, relayfs, or some other mechanism best for this task?).

 - The daemon links against libecryptfs, which did a dlopen on the
   plugins in a place like /usr/lib/ecryptfs/ when it launched.

 - Then we defer the request to decrypt the file encryption key to the
   module specified in the message that was originally sent to the
   daemon.

 - The daemon relays the decrypted file encryption key back to
   eCryptfs in the kernel, and eCryptfs associates that key with the
   crypt_stat for the inode, continuing with the page read/write
   operations that follow.

> Another issue is a multi user access without a shared secret. This
> may be done by encrypting the symmetric key in several asymmetric
> ones.

This is exactly the sort of functionality that eCryptfs is designed to
support.

> Again this can be done in user mode... But there is a need to
> support reencrypting the whole filesystem with a new symmetric key
> so that a user may be removed from the list.

Yes, key revocation will necessarily require the re-encryption of all
of the data, which is of limited use if the user whose key is revoked
had access to all of the encrypted data in the first place before the
revocation (he could have simply made a copy of it all). Given the
stated goal of eCryptfs to protect data-at-rest from compromise in the
event of the loss or theft of the storage device, I cannot think of
many use case scenarios where key revocation will be a requirement. I
would expect that a key revocation event would entail revocation of
access to the encrypted data too.

> If you like, I will be happy to help you with the user mode stuff,
> and implement the smart card access.

Thanks for your suggestions; it seems that we are not thinking too
differently in terms of what needs to happen to provide more advanced
key management features. In the meantime, we would like to get the
simple passphrase-only version of eCryptfs upstream, and then we will
be working on implementing these more advanced features this summer. I
will let you know when we have completed the 0.2 design document.

In the meantime, if you have a desire to implement some of the
features (in userspace) you describe, please join the ecryptfs-devel
list and discuss the plans with our team, so that there is no wasted
or duplicated effort:

https://lists.sourceforge.net/lists/listinfo/ecryptfs-devel

Thanks,
Mike Halcrow

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUBRFt4ZdtAhTFtyodpAQKw5Qf/YIAZlnql4x/mOt4y8B+4M12rmT1MyAzp
2nmtLCtkItHAYjGpGX6Y8jsVjstkuo3/hfxoFhEpNdZOFrjRiAfyrqL7z3t4MTif
wSlpxiLU23IIqD+f14Iw/i47hs8abCGj+aURDoKOBbj+QzSO4KRJP3F8z0HqFDGL
uA8fCxlSVP9mmtGJbGiMYPdcSsOBAjy1oQUJU66eX9g8VwyEF8aB3GjdfVKVQPCK
Ue/dgFV5HdlVMRYyWXCJ2T7+akAGde4LKe9uXXLSrDKo2EkLYsXRmMA2xscUfrx5
BcDZKDydOE2dYk56FKCjCo+JTuLPXW9OYQdp2V1U6a/gDL+1AWmRSQ==
=vxGV
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
