Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUIBKnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUIBKnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUIBKnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:43:40 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:48831 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268190AbUIBKmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:42:17 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Date: Thu, 2 Sep 2004 20:42:09 +1000
Subject: [PATCH] kbuild: Support LOCALVERSION
Message-ID: <20040902104209.GA24544@cse.unsw.EDU.AU>
References: <20040831192642.GA15855@mars.ravnborg.org> <20040901134341.GT6985@lug-owl.de> <20040901145646.GA7252@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20040901145646.GA7252@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2004 at 04:56:47PM +0200, Sam Ravnborg wrote:
> Ian addedconfig CONFIG_LOCALVERSION to a Kconfig file. I will
> try to add it and see how it turns out. If Ian does not beat me..

Ok, here is my attempt.  I think it does everything everyone wants

* localversion* files are read first
* config variable is appended last
* LOCALVERSION from the command line overrides all of this
* check is forced on build, since we can't really know when
  the config or environment options change.

Thanks,

-i

Add LOCALVERSION so we can append strings that show up in uname
without having to fiddle with the Makefile and EXTRAVERSION, etc.

Signed-off-by: Ian Wienand <ianw@gelato.unsw.edu.au>

=3D=3D=3D=3D=3D Makefile 1.523 vs edited =3D=3D=3D=3D=3D
--- 1.523/Makefile	2004-08-25 06:34:30 +10:00
+++ edited/Makefile	2004-09-02 20:32:57 +10:00
@@ -141,7 +141,26 @@
=20
 export srctree objtree VPATH TOPDIR
=20
-KERNELRELEASE=3D$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+nullstring :=3D=20
+space      :=3D $(nullstring) # end of line
+
+# Take the contents of any files called localversion and the config
+# variable CONFIG_LOCALVERSION and append them to KERNELRELEASE.  Be
+# careful not to include files twice if building in the source
+# directory.  LOCALVERSION from the command line should override all
+# of this
+
+ifeq ($(objtree),$(srctree))
+localversion-files :=3D $(wildcard $(srctree)/localversion*)
+else
+localversion-files :=3D $(wildcard $(objtree)/localversion* $(srctree)/loc=
alversion*)
+endif
+
+LOCALVERSION =3D $(subst $(space),, \
+	       $(shell cat /dev/null $(localversion-files)) \
+	       $(subst ",,$(CONFIG_LOCALVERSION)))
+
+KERNELRELEASE=3D$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCAL=
VERSION)
=20
 # SUBARCH tells the usermode build what the underlying arch is.  That is s=
et
 # first, and if a usermode build is happening, the "ARCH=3Dum" on the comm=
and
@@ -329,8 +348,8 @@
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:=3D -D__ASSEMBLY__
=20
-export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
-	CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
+export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE=
 \
+	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
 	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK CHECKFLAGS
=20
@@ -747,8 +766,8 @@
 # Generate some files
 # ------------------------------------------------------------------------=
---
=20
-#	version.h changes when $(KERNELRELEASE) etc change, as defined in
-#	this Makefile
+#	KERNELRELEASE can change from a few different places, meaning version.h=
=20
+#	needs to be updated, so this check is forced on all builds
=20
 uts_len :=3D 64
=20
@@ -763,7 +782,7 @@
 	)
 endef
=20
-include/linux/version.h: Makefile
+include/linux/version.h: $(srctree)/Makefile $(localversion-files) FORCE
 	$(call filechk,version.h)
=20
 # ------------------------------------------------------------------------=
---
=3D=3D=3D=3D=3D init/Kconfig 1.48 vs edited =3D=3D=3D=3D=3D
--- 1.48/init/Kconfig	2004-08-31 18:00:08 +10:00
+++ edited/init/Kconfig	2004-09-02 20:13:01 +10:00
@@ -293,6 +293,16 @@
 	  option replaces shmem and tmpfs with the much simpler ramfs code,
 	  which may be appropriate on small systems without swap.
=20
+config LOCALVERSION
+	string "Local Version"
+	help
+	  Append an extra string to the end of your kernel version.
+	  This will show up when you type uname, for example.
+	  The string you set here will be appended after the contents of=20
+	  any files with a filename matching localversion* in your=20
+	  object and source tree, in that order.  Your total string can
+	  be a maximum of 64 characters.
+
 endmenu		# General setup
=20
 config TINY_SHMEM

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBNvkBWDlSU/gp6ecRAqYFAJ9+2mPxrRDX76wQr0174XrQmAwKzACg39pK
wW/pYSW5CQlYCfubBKToa6U=
=r6JN
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
