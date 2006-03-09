Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWCIKQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWCIKQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWCIKQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:16:07 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:12814 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S1751773AbWCIKQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:16:05 -0500
Message-ID: <44100043.2020703@imap.cc>
Date: Thu, 09 Mar 2006 11:15:31 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-usb-devel@lists.sourceforge.net, hjlipp@web.de,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] reduce syslog clutter (take 2)
References: <440F609F.8090604@imap.cc> <20060308214724.cf987bbf.rdunlap@xenotime.net>
In-Reply-To: <20060308214724.cf987bbf.rdunlap@xenotime.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCE6DCBF2E92E8DDAE7520CDB"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCE6DCBF2E92E8DDAE7520CDB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Randy.Dunlap wrote:

>> +#if defined(CONFIG_MODULES) && defined(THIS_MODULE)
>> +#define KMSG_LOCATION_PREFIX THIS_MODULE ? THIS_MODULE->name : __FILE__
>
> Can we get parens around the expression, please?

Will do.

> and does it make sense to test
> #if defined(THIS_MODULE)
> #define KMSG_LOCATION_PREFIX (THIS_MODULE ? ...

Unfortunately, it does.

> If that does make sense (the double testing of THIS_MODULE),
> please explain why it does.

We have the following cases:

- compiling without module support, source file not including linux/module.h
  -> !defined(CONFIG_MODULES) && !defined(THIS_MODULE)
   -> compiling the expression (THIS_MODULE ? THIS_MODULE->name : __FILE__)
      fails with undefined symbol THIS_MODULE

- compiling with module support, source file not including linux/module.h
  -> defined(CONFIG_MODULES) && !defined(THIS_MODULE)
   -> compiling the expression (THIS_MODULE ? THIS_MODULE->name : __FILE__)
      fails with undefined symbol THIS_MODULE

- compiling without module support, source file including linux/module.h
  -> !defined(CONFIG_MODULES) && defined(THIS_MODULE)
   -> compiling the expression (THIS_MODULE ? THIS_MODULE->name : __FILE__)
      fails because THIS_MODULE is defined as a NULL pointer to
      struct module which in this case is an incomplete type (*sigh*)

- compiling with module support, source file including linux/module.h,
  not compiling as a module
  -> defined(CONFIG_MODULES) && defined(THIS_MODULE)
     && THIS_MODULE == ((struct module *)0)
   -> compiling the expression (THIS_MODULE ? THIS_MODULE->name : __FILE__)
      succeeds (hooray), but THIS_MODULE is a NULL pointer, though this
      time the type it points to is at least completely defined

- compiling with module support, source file including linux/module.h,
  compiling as a module
  -> defined(CONFIG_MODULES) && defined(THIS_MODULE)
     && THIS_MODULE == &__this_module
   -> compiling the expression (THIS_MODULE ? THIS_MODULE->name : __FILE__)
      succeeds and THIS_MODULE can actualy be dereferenced

I would like the code to compile and run successfully in all these cases.

--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)

--------------enigCE6DCBF2E92E8DDAE7520CDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEEABLMdB4Whm86/kRAjCvAJ9i8k/7RlXDDQx/ezlVUAHiEvmpsgCbBwQ/
jgOgvIZwER+63GI++tOEhqA=
=gO6D
-----END PGP SIGNATURE-----

--------------enigCE6DCBF2E92E8DDAE7520CDB--
