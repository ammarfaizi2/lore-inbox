Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWEVLQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWEVLQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWEVLQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:16:11 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11211 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750747AbWEVLQK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:16:10 -0400
Message-Id: <200605221115.k4MBFq42013901@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm3
In-Reply-To: Your message of "Mon, 22 May 2006 02:27:09 PDT."
             <20060522022709.633a7a7f.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060522022709.633a7a7f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148296552_11652P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 07:15:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148296552_11652P
Content-Type: text/plain; charset=us-ascii

On Mon, 22 May 2006 02:27:09 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/

Mostly works, am chasing down 3 small things (all 3 were new as of -mm2 - I was
busy chasing them when -mm3 showed up).

1) Something has gone astray in the hardware RNG rework.  /sbin/rngd was
quite happy dealing with the i810 RNG in my laptop under -rc4-mm1, but under
-mm2 and -mm3, I get this (from strace /bin/rngd):

open("/dev/hw_random", O_RDONLY)        = 3
read(3, "q\252cg", 4)                   = 4
read(3, 0xbfaf56ac, 4)                  = -1 EAGAIN (Resource temporarily unavai lable)

It works for some number of reads, but eventually pulls an EAGAIN.  When
stracing on a console that was slow-to-scroll, it did several dozen before
failing - so it's apparently a timing thing.  I stuck a debugging printk
in just before the test that returns EAGAIN, and got this:

[   68.361000] rng_read data_present=1 i=0 bytes_read=1
[   68.361000] rng_read data_present=1 i=0 bytes_read=1
[   68.361000] rng_read data_present=1 i=0 bytes_read=1
[   68.361000] rng_read data_present=1 i=0 bytes_read=1
[   68.361000] rng_read data_present=0 i=20 bytes_read=0

It looks to me line the old code stayed in a while() loop in rng_dev_read
until it had fulfilled the read request (including possibly multiple
calls to need_resched() and friends).  The new code will bail on an -EAGAIN
as soon as the *first* poll fails, rather than waiting until something
is available - even if it is NOT flagged O_NONBLOCK.

2)   Building modules, stage 2.
  MODPOST 
WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0xf5e) and 'acpi_safe_halt' 

3) Something in git-cryptodev.patch doesn't play nice with RedHat Fedora's
'modsign' patches.  I'm suspecting this is the cause:

commit f1c737f209e39095016e5be3904b2ce84027890f
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue May 16 22:09:29 2006 +1000

    [CRYPTO] all: Pass tfm instead of ctx to algorithms

I just haven't stared at it enough to make the fixes needed.

--==_Exmh_1148296552_11652P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEcZ1ocC3lWbTT17ARAvktAKDq/g6dmVTv8WFEDoIBatKcvZTJ0gCfZ56N
BgSn07OLgEZW9195XArQpno=
=Svbi
-----END PGP SIGNATURE-----

--==_Exmh_1148296552_11652P--
