Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTLACR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 21:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTLACR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 21:17:26 -0500
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:52887 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S263064AbTLACRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 21:17:24 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Keywords: dev,module,#include,serial,rsa,major,linux,char
References: <20031130071757.GA9835@node1.opengeometry.net>
	<20031130102351.GB10380@outpost.ds9a.nl>
	<20031130113656.GA28437@finwe.eu.org>
	<microsoft-free.87ekvpc0ms.fsf@eicq.dnsalias.org>
	<20031130222222.GA11809@finwe.eu.org>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Mon, 01 Dec 2003 12:17:14 +1000
Message-ID: <microsoft-free.87vfp1nuxh.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

|--==> "JK" == Jacek Kawa <jfk@zeus.polsl.gliwice.pl> writes:

  JK> Steve Youngs wrote:
  >>I _think_ this patch will bring back auto-loading of the serial module
  >>for you.  Please let me know how it goes. 

  JK> Well: patched, installed new serial_core.ko, then depmod -a, and
  JK> try to access ttySwhatever.

As Russell said, the patch was wrong, revert it.  Sorry about that, my
bad.  I really shouldn't try to hack the kernel late at night while
I'm hacking other things at the same time.

I'm pretty sure that the problem has its roots in...

diff -Nru a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	Sun Nov 23 17:33:38 2003
+++ b/fs/char_dev.c	Sun Nov 23 17:33:38 2003
@@ -434,7 +434,7 @@
 
 static struct kobject *base_probe(dev_t dev, int *part, void *data)
 {
-	request_module("char-major-%d", MAJOR(dev));
+	request_module("char-major-%d-%d", MAJOR(dev), MINOR(dev));
 	return NULL;
 }

...from Rusty, which went into 2.6.0-test10.

Does this work any better?

--- linux-2.6.0-test11/drivers/serial/8250.c	2003-11-27 11:03:42.000000000 +1000
+++ linux-2.6.0-test11-sy/drivers/serial/8250.c	2003-12-01 11:40:44.000000000 +1000
@@ -34,6 +34,7 @@
 #include <linux/serial.h>
 #include <linux/serialP.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -2195,3 +2196,4 @@
 MODULE_PARM(force_rsa, "1-" __MODULE_STRING(PORT_RSA_MAX) "i");
 MODULE_PARM_DESC(force_rsa, "Force I/O ports for RSA");
 #endif
+MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);



-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAj/KpK4ACgkQHSfbS6lLMANEiQCgni2JOLiGCjoMOUBZdrItHoIG
kUgAoMNbWoihyydiqo/z5nEUBzNPpQyk
=UK//
-----END PGP SIGNATURE-----
--=-=-=--
