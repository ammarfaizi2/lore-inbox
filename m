Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272554AbTHBJYU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272559AbTHBJYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:24:20 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:20960 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S272554AbTHBJYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:24:18 -0400
Subject: Re: Linux 2.4.22-pre10-ac1
From: Marcel Holtmann <marcel@holtmann.org>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030802063749.GA23189@ranty.pantax.net>
References: <200308012216.h71MGLe31285@devserv.devel.redhat.com>
	<20030802040917.GA22776@ip68-4-255-84.oc.oc.cox.net> 
	<20030802063749.GA23189@ranty.pantax.net>
Content-Type: multipart/mixed; boundary="=-6eNf5LuRtA+dPPKrfeKG"
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Aug 2003 11:23:53 +0200
Message-Id: <1059816240.22299.31.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6eNf5LuRtA+dPPKrfeKG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Manuel,

> > ccache gcc -D__KERNEL__ -I/home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS -include /home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=firmware_class  -DEXPORT_SYMTAB -c firmware_class.c
> > firmware_class.c: In function `call_helper':
> > firmware_class.c:78: error: `hotplug_path' undeclared (first use in this function)
> > firmware_class.c:78: error: (Each undeclared identifier is reported only once
> > firmware_class.c:78: error: for each function it appears in.)
> > make[1]: *** [firmware_class.o] Error 1
> > make[1]: Leaving directory `/home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/lib'
> > make: *** [_mod_lib] Error 2
> [snip]
> > # CONFIG_HOTPLUG is not set
> 
>  CONFIG_HOTPLUG needs to be enabled, attached patch to make it explicit:

your patch didn't fix the problem, because it will be the same if some
internal driver needs request_firmware() and CONFIG_HOTPLUG is not set.
The call_helper() funtcion needs to be put into #idef's.

Regards

Marcel


--=-6eNf5LuRtA+dPPKrfeKG
Content-Disposition: attachment; filename=patch-2.4.22-pre10-ac1-reqfrm-hotplug
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch-2.4.22-pre10-ac1-reqfrm-hotplug;
	charset=ISO-8859-15

diff -urN linux-2.4.22-pre10-ac1/lib/firmware_class.c linux-2.4.22-pre10-ac=
1-reqfrm-hotplug/lib/firmware_class.c
--- linux-2.4.22-pre10-ac1/lib/firmware_class.c	Sat Aug  2 10:50:04 2003
+++ linux-2.4.22-pre10-ac1-reqfrm-hotplug/lib/firmware_class.c	Sat Aug  2 1=
1:21:02 2003
@@ -67,6 +67,8 @@
 static struct proc_dir_entry *proc_dir_timeout;
 static struct proc_dir_entry *proc_dir;
=20
+#ifdef CONFIG_HOTPLUG
+
 static int
 call_helper(char *verb, const char *name, const char *device)
 {
@@ -126,7 +128,9 @@
=20
 	envp[i++] =3D 0;
=20
+#ifdef  DEBUG
 	dbg("firmware: %s %s %s", argv[0], argv[1], verb);
+#endif
=20
 	retval =3D call_usermodehelper(argv[0], argv, envp);
 	if (retval) {
@@ -137,6 +141,15 @@
 	kfree(envp);
 	return retval;
 }
+#else
+
+static inline int
+call_helper(char *verb, const char *name, const char *device)
+{
+	return -ENOENT;
+}
+
+#endif /* CONFIG_HOTPLUG */
=20
 struct firmware_priv {
 	struct completion completion;

--=-6eNf5LuRtA+dPPKrfeKG--

