Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbRBCI6g>; Sat, 3 Feb 2001 03:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129124AbRBCI60>; Sat, 3 Feb 2001 03:58:26 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:52844 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129054AbRBCI6L>; Sat, 3 Feb 2001 03:58:11 -0500
Message-ID: <3A7BC808.E9BF5B44@linux.com>
Date: Sat, 03 Feb 2001 00:57:45 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink 
 related)
In-Reply-To: <E14OoD8-0007GI-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------EE56B0CAEBA3E919AFC2862A"
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EE56B0CAEBA3E919AFC2862A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

How about a simple patch to the top level makefile that checks the gcc
version then prints a distinct message ..'this compiler hasn't been approved
for compiling the kernel', sleeping for one second, then continuing on.  This
solution doesn't stop compiling and makes a visible indicator without forcing
anything.

Sample attached.

-d

Alan Cox wrote:

> > As it stands, there is no way to determine programatically whether
> > gcc-2.96 is broken or now. The only way to do it is to check the RPM
> > version -- which, needless to say, is a bit difficult to do from the
> > C code about to be compiled. So I can't really blame Hans if he decides
> > to outlaw gcc-2.96[.0] for reiserfs compiles.
>
> Oh I can see why Hans wants to cut down his bug reporting load. I can also
> say from experience it wont work. If you put #error in then everyone will
> mail him and complain it doesnt build, if you put #warning in nobody will
> read it and if you dont put anything in you get the odd bug report anyway.
>
> Basically you can't win and unfortunately a shrink wrap forcing the user
> to read the README file for the kernel violates the GPL ..
>
> Jaded, me ?
>
> Alan

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



--------------EE56B0CAEBA3E919AFC2862A
Content-Type: text/plain; charset=us-ascii;
 name="lkml-gccversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lkml-gccversion.patch"

--- Makefile.orig	Sat Feb  3 00:48:26 2001
+++ Makefile	Sat Feb  3 00:45:00 2001
@@ -253,11 +253,23 @@
 		-o vmlinux
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 
-symlinks:
+symlinks: gccversioncheck
 	rm -f include/asm
 	( cd include ; ln -sf asm-$(ARCH) asm)
 	@if [ ! -d include/linux/modules ]; then \
 		mkdir include/linux/modules; \
+	fi
+
+gccversioncheck:
+	@gccversion=`${HOSTCC} --version`;\
+	echo Using gcc version: $$gccversion;\
+	if [ "x$${gccversion}" != "x2.95.2" ]; then \
+		echo "********************************************************************"; \
+		echo "***  This compiler version is not approved for compiling the kernel"; \
+		echo "***  version: " $$HOSTCC $$gccversion ; \
+		echo "***  Please consider this when reporting bugs" ;\
+		echo "********************************************************************"; \
+		sleep 1; \
 	fi
 
 oldconfig: symlinks

--------------EE56B0CAEBA3E919AFC2862A--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
