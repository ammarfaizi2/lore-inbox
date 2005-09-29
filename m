Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVI2Jba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVI2Jba (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 05:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVI2Jba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 05:31:30 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:23436 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751315AbVI2Jb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 05:31:29 -0400
Message-ID: <1751.192.168.201.6.1127986280.squirrel@pc300>
Date: Thu, 29 Sep 2005 10:31:20 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: minibug: 'mv' -> 'mv -f ' in main Makefile
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

 I've got to answer this question on RedHat FC4 when building a kernel
in verbose mode:
$ make V=1 /boot/linux-2.6.14-rc2.kgz
  .. lot of log ...
  set -e; if [ ! -r .version ]; then rm -f .version; echo 1 >.version;
else mv .version .old_version; expr 0$(cat .old_version) + 1 >.version;
fi; make -f scripts/Makefile.build obj=init
mv: overwrite `.old_version', overriding mode 0644? y

 I do not know why it is only when verbose is ON.
 Either add the -f option to mv (or alternatively call /bin/mv)
in this part of patch-2.6.14-rc2 file b/Makefile :

@@ -624,8 +644,13 @@ quiet_cmd_vmlinux__ ?= LD      $@
 # Generate new vmlinux version
 quiet_cmd_vmlinux_version = GEN     .version
       cmd_vmlinux_version = set -e;                     \
-	. $(srctree)/scripts/mkversion > .tmp_version;	\
-	mv -f .tmp_version .version;			\
+	if [ ! -r .version ]; then			\
+	  rm -f .version;				\
+	  echo 1 >.version;				\
+	else						\
+	  mv .version .old_version;			\
+	  expr 0$$(cat .old_version) + 1 >.version;	\
+	fi;						\
 	$(MAKE) $(build)=init

 # Generate System.map

  Etienne.

