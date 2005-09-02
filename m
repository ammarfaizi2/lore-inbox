Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVIBUjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVIBUjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVIBUjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:39:48 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:29886 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S1750791AbVIBUjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:39:48 -0400
Subject: [RFC] broken installkernel.sh with CROSS_COMPILE
From: Dave Hansen <dave@sr71.net>
To: icampbell@arcom.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PPC64 External List <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 13:39:13 -0700
Message-Id: <1125693554.26605.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that my cross-compilation 'make install' broke with 2.6.13 (I
don't use it horribly often).  It's from this commit:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0f8e2d62fa04441cd12c08ce521e84e5bd3f8a46

Which added CROSS_COMPILE to each arch's install.sh:

if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi

However, I don't just have a simple arch name as my CROSS_COMPILE, I
have a whole path, so that line expands like this for me:

+ '[' -x /home/dave/bin//home/services/cross_compile/ppc64/bin/ppc64-linux-gnu-installkernel ']'

Needless to say, that doesn't work :)

Could we do something that's guaranteed to not have lots of extra path
elements in it, like ARCH?  Something like this?

That way, people like me who have a single installkernel script that
does all of the fancy arch-detection can just do this:

	for i in `ls linux-2.6.git/arch/`; do 
		ln -s ~/bin/installkernel ~/bin/$i-installkernel
	fi

And be done with it forever.

--- linux-2.6/arch/ppc64/boot/install.sh.orig	2005-09-02 13:34:16.000000000 -0700
+++ linux-2.6/arch/ppc64/boot/install.sh	2005-09-02 13:34:52.000000000 -0700
@@ -22,6 +22,7 @@
 
 # User may have a custom install script
 
+if [ -x ~/bin/${ARCH}-installkernel ]; then exec ~/bin/${ARCH}-installkernel "$@"; fi
 if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
 if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then exec /sbin/${CROSS_COMPILE}installkernel "$@"; fi
 


-- Dave

