Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132642AbRDQOKP>; Tue, 17 Apr 2001 10:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbRDQOKG>; Tue, 17 Apr 2001 10:10:06 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:42756 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S132633AbRDQOJy>;
	Tue, 17 Apr 2001 10:09:54 -0400
Date: Tue, 17 Apr 2001 16:01:42 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] scripts/ver_linux not working on Debian
Message-ID: <20010417160142.H4385@kallisto.sind-doof.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Debian GNU/Linux (Linux 2.4.3-ac5-int1-nf20010413-dc1 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

scripts/ver_linux uses fdformat to determine the version of util-linux
used on the system. However, on Debian GNU/Linux:

---------- snip ----------
% fdformat --version

Note: /usr/bin/fdformat is obsolete and is no longer available.
Please use /usr/bin/superformat instead (make sure you have the
fdutils package installed first).  Also, there had been some
major changes from version 4.x.  Please refer to the documentation.

---------- snip ----------

Attached is a patch which modifies ver_linux so that it can correctly
determine the util-linux version on Debian (by using /sbin/hwclock if
fdformat fails).

Andreas
-- 
Bell Labs Unix -- Reach out and grep someone.

--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ver_linux-debian.patch"

--- linux/scripts/ver_linux.orig	Tue Apr 17 15:49:14 2001
+++ linux/scripts/ver_linux	Tue Apr 17 15:52:04 2001
@@ -20,7 +20,13 @@
 ld -v 2>&1 | awk -F\) '{print $1}' | awk \
       '/BFD/{print "binutils              ",$NF}'
 
-fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
+ut_vers=`fdformat --version | awk -F\- '{print $NF}'`
+if echo "$ut_vers" | grep -q obsolete
+then
+    # Debian does not ship fdformat
+    ut_vers=`/sbin/hwclock --version | awk -F\- '{print $NF}'`
+fi
+echo "util-linux             $ut_vers"
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 

--xA/XKXTdy9G3iaIz--

