Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSIJU5W>; Tue, 10 Sep 2002 16:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSIJU5W>; Tue, 10 Sep 2002 16:57:22 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:39428 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316199AbSIJU5V>;
	Tue, 10 Sep 2002 16:57:21 -0400
Date: Tue, 10 Sep 2002 23:01:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: clean and mrproper file list created dynamically 1/6
Message-ID: <20020910230157.A18386@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020910225530.A17094@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020910225530.A17094@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Sep 10, 2002 at 10:55:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o Create infrastructure in Rules.make to allow the individual makefiles
to specify what files shall be deleted during clean and mrproper
o Add .clean and .mrproper to ignore list

	Sam

diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Tue Sep 10 22:37:37 2002
+++ b/Rules.make	Tue Sep 10 22:37:37 2002
@@ -405,6 +405,27 @@
 
 targets += $(host-progs-single) $(host-progs-multi-objs) $(host-progs-multi) 
 
+# Saved generated files that needs cleaning up later.
+# Filename are saved in $(objtree)/.clean and $(objtree)/.mrproper
+# When make clean or make mrproper is executed, the files listed
+# are deleted, and the file itselt is deleted.
+# To add files to the list set clean or mrproper equal to the
+# file, before inclusion of Rules.make. Rules.amke will prefix the
+# file with the full directory path.
+# ===========================================================================
+clean := $(addprefix $(CURDIR)/,$(clean))
+clean-file := $(objtree)/.clean
+tmp := $(if $(clean),\
+$(shell (if [ -f $(clean-file) ]; then cat $(clean-file); fi;\
+echo $(clean)) | sort -u > $(clean-file)))
+
+mrproper := $(addprefix $(CURDIR)/,$(mrproper) \
+$(host-progs-single) $(host-progs-multi) $(host-progs-multi-objs))
+mrproper-file := $(objtree)/.mrproper
+tmp := $(if $(mrproper),\
+$(shell (if [ -f $(mrproper-file) ]; then cat $(mrproper-file); fi;\
+echo $(mrproper)) | sort -u > $(mrproper-file)))
+
 endif # ! modules_install
 endif # ! fastdep
 
