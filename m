Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSLQK3f>; Tue, 17 Dec 2002 05:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSLQK3f>; Tue, 17 Dec 2002 05:29:35 -0500
Received: from mail.wnyip.net ([209.2.65.194]:31758 "EHLO mail.wnyip.net")
	by vger.kernel.org with ESMTP id <S264877AbSLQK3d>;
	Tue, 17 Dec 2002 05:29:33 -0500
Message-ID: <3DFEFF01.7040304@wnyip.net>
Date: Tue, 17 Dec 2002 05:40:01 -0500
From: peter <pvant67@wnyip.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com>,
       Michael E Chastain <mec@shout.net>, kbuild-devel@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fix for RPM build target under newer versions
Content-Type: multipart/mixed;
 boundary="------------080603000907000209030309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080603000907000209030309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,
	I notice there's an "rpm" target in the Makefile, which seems broken 
under RH 8.0. This may also apply to some "bleeding-edge" versions of 
Mandrake and Suse. Specifically, RH "split" the RPM build process into a 
separate utility from the old style rpm command. This could be fixed 
with a few aliases to keep backwards compatibility a bit easier. I 
wonder why an RH install doesn't already do this?

The reason why I'm sending this is because it's in the Makefile itself. 
If it wasn't for that, I'd just use the aliases mentioned above.

--------------080603000907000209030309
Content-Type: text/plain;
 name="Makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile.patch"

--- /usr/src/linux-2.4.19/Makefile	2002-12-15 19:04:20.000000000 -0500
+++ /home/pete/Makefile.new	2002-12-17 04:36:49.000000000 -0500
@@ -567,5 +567,16 @@
 	rm $(KERNELPATH) ; \
 	cd $(TOPDIR) ; \
 	. scripts/mkversion > .version ; \
-	rpmbuild -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
+
+#	RedHat split the RPM build process into a separate
+#	utility called "rpmbuild", leading to a broken 
+#	"make rpm" target in the kernel Makefile;
+#	this patch fixes that.
+
+	if [ `rpm --version | cut -b 12-15 | tr -d .` -ge '41' ] ;
+		then
+		rpmbuild -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \ 
+		else
+		rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
+	fi ; \
 	rm $(TOPDIR)/../$(KERNELPATH).tar.gz

--------------080603000907000209030309--

